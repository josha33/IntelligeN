unit uLinkcryptWs;

interface

uses
  // Delphi
  Windows, SysUtils, StrUtils, Variants, SyncObjs, XMLDoc, XMLIntf, ActiveX,
  // RegEx
  RegExpr,
  // Common
  uBaseConst, uBaseInterface,
  // HTTPManager
  uHTTPInterface, uHTTPClasses,
  // Plugin system
  uPlugInInterface, uPlugInCrypterClass, uPlugInHTTPClasses, uPlugInConst,
  // Utils
  uVariantUtils;

type
  // see: http://linkcrypt.ws/image/Linkcrypt.ws_API-Create_folder_DE.pdf
  TLinkcryptWs = class(TCrypterPlugIn)
  protected { . }
  const
    WEBSITE = 'http://linkcrypt.ws/';

    function GetFolderID(AFolderURL: string): string;
    function GetStatusImageLink(AFolderIdentifier: WideString; Small: WordBool = True): WideString;
  public
    function GetAuthor: WideString; override;
    function GetAuthorURL: WideString; override;
    function GetDescription: WideString; override;
    function GetName: WideString; override;

    function GetServiceRequiresAccess: TCrypterAccess; override;

    function AddFolder(const ACrypterData: ICrypterData; const AMirrorContainer: IDirectlinkContainer; out ACrypterFolderInfo: TCrypterFolderInfo): WordBool; override;
    function EditFolder(const ACrypterData: ICrypterData; const AMirrorContainer: IDirectlinkContainer; var ACrypterFolderInfo: TCrypterFolderInfo): WordBool; override;
    function DeleteFolder(const AAccountData: IAccountData; const AFolderIdentifier: WideString): WordBool; override;
    function GetFolder(const AAccountData: IAccountData; const AFolderIdentifier: WideString; out ACrypterFolderInfo: TCrypterFolderInfo): WordBool; override;
  end;

implementation

function TLinkcryptWs.GetFolderID(AFolderURL: string): string;
begin
  Result := '';

  with TRegExpr.Create do
    try
      InputString := AFolderURL;
      Expression := 'dir\/(\w+)';

      if Exec(InputString) then
        Result := Match[1];
    finally
      Free;
    end;
end;

function TLinkcryptWs.GetStatusImageLink(AFolderIdentifier: WideString; Small: WordBool = True): WideString;
begin
  case Small of
    True:
      Result := StringReplace(AFolderIdentifier, '/dir/', '/png/', []);
    False:
      Result := StringReplace(AFolderIdentifier, '/dir/', '/textpng/', []);
  end;
end;

function TLinkcryptWs.GetAuthor;
begin
  Result := 'Sebastian Klatte';
end;

function TLinkcryptWs.GetAuthorURL;
begin
  Result := 'http://www.intelligen2009.com/';
end;

function TLinkcryptWs.GetDescription;
begin
  Result := GetName + ' crypter plug-in.';
end;

function TLinkcryptWs.GetName;
begin
  Result := 'Linkcrypt.ws';
end;

function TLinkcryptWs.GetServiceRequiresAccess;
begin
  Result := caAPIKey;
end;

function TLinkcryptWs.AddFolder;
var
  LNeedToUninitialize: Boolean;
  LFoldertypes: TFoldertypes;
  LContainertypes: TContainertypes;

  LDirectlinkIndex: Integer;

  LHTTPParams: IHTTPParams;
  LRequestID: Double;
  LHTTPProcess: IHTTPProcess;

  LXMLDoc: IXMLDocument;
begin
  Result := False;

  with ACrypterFolderInfo do
  begin
    Link := '';
    Status := csNotChecked;
    Size := 0;
    PartSize := 0;
    Hoster := '';
    HosterShort := '';
    Parts := 0;
    StatusImage := '';
    StatusImageText := '';
  end;

  LFoldertypes := TFoldertypes(TFoldertype(ACrypterData.Foldertypes));
  LContainertypes := TContainertypes(TContainertype(ACrypterData.ContainerTypes));

  LHTTPParams := THTTPParams.Create;
  with LHTTPParams do
  begin
    if ACrypterData.UseAccount then
      AddFormField('apiKey', ACrypterData.AccountName);

    AddFormField('urls', StringReplace(AMirrorContainer.Directlink[0].Value, sLineBreak, ';', [rfReplaceAll]));

    if not SameStr('', ACrypterData.FolderName) then
      AddFormField('title', ACrypterData.FolderName);

    if ACrypterData.UseVisitorPassword then
      AddFormField('folder_password', ACrypterData.Visitorpassword);

    if ACrypterData.UseFilePassword then
      AddFormField('download_password', ACrypterData.FilePassword);

    AddFormField('captx', IfThen(ACrypterData.UseCaptcha, '1', '0'));

    AddFormField('weburls', IfThen(ftWeb in LFoldertypes, '1', '0'));

    if ftContainer in LFoldertypes then
    begin
      AddFormField('dlc', IfThen(ctDLC in LContainertypes, '1', '0'));
      AddFormField('rsdf', IfThen(ctRSDF in LContainertypes, '1', '0'));
      AddFormField('ccf', IfThen(ctCCF in LContainertypes, '1', '0'));
    end
    else
    begin
      AddFormField('dlc', '0');
      AddFormField('rsdf', '0');
      AddFormField('ccf', '0');
    end;

    AddFormField('cnl', IfThen(ACrypterData.UseCNL, '1', '0'));

    for LDirectlinkIndex := 1 to AMirrorContainer.DirectlinkCount - 1 do
      AddFormField('mirror_' + IntToStr(LDirectlinkIndex), StringReplace(AMirrorContainer.Directlink[LDirectlinkIndex].Value, sLineBreak, ';', [rfReplaceAll]));
  end;

  LRequestID := HTTPManager.Post(THTTPRequest.Create(WEBSITE + 'api.html?api=create_V2'), LHTTPParams, TPlugInHTTPOptions.Create(Self));

  HTTPManager.WaitFor(LRequestID);

  LHTTPProcess := HTTPManager.GetResult(LRequestID);

  if LHTTPProcess.HTTPResult.HasError then
  begin
    ErrorMsg := LHTTPProcess.HTTPResult.HTTPResponseInfo.ErrorMessage;
  end
  else if not SameStr('', LHTTPProcess.HTTPResult.SourceCode) then
  begin
    LNeedToUninitialize := Succeeded(CoInitializeEx(nil, COINIT_MULTITHREADED));
    try
      LXMLDoc := NewXMLDocument;
      try
        try
          with LXMLDoc do
          begin
            LoadFromXML(LHTTPProcess.HTTPResult.SourceCode);
            Active := True;
          end;
          with LXMLDoc.ChildNodes.Nodes['data'].ChildNodes do
            if (Nodes['status'].NodeValue = '1') then
            begin
              ACrypterFolderInfo.Link := Nodes['folderUrl'].NodeValue;
              ACrypterFolderInfo.StatusImage := GetStatusImageLink(ACrypterFolderInfo.Link);
              ACrypterFolderInfo.StatusImageText := GetStatusImageLink(ACrypterFolderInfo.Link, False);
              Result := True;
            end
            else
            begin
              ErrorMsg := Nodes['errorCode'].NodeValue + ': ' + Nodes['errorMsg'].NodeValue;
            end;
        except
          on E: Exception do
          begin
            ErrorMsg := 'The XML from ' + GetName + ' was invaild: ' + E.message;
          end;
        end;
      finally
        LXMLDoc := nil;
      end;
    finally
      if LNeedToUninitialize then
        CoUninitialize;
    end;
  end
  else
  begin
    ErrorMsg := 'The Server response was empty!';
  end;
end;

function TLinkcryptWs.EditFolder;
begin
  Result := False;
end;

function TLinkcryptWs.DeleteFolder;
begin
  Result := False;
end;

function TLinkcryptWs.GetFolder;
var
  LNeedToUninitialize: Boolean;
  LHTTPParams: IHTTPParams;
  LRequestID: Double;
  LHTTPProcess: IHTTPProcess;

  LXMLDoc: IXMLDocument;
begin
  Result := False;

  with ACrypterFolderInfo do
  begin
    Status := csNotChecked;
    Size := 0;
    PartSize := 0;
    Hoster := '';
    HosterShort := '';
    Parts := 0;
    StatusImage := '';
    StatusImageText := '';
  end;

  LHTTPParams := THTTPParams.Create;
  with LHTTPParams do
  begin
    if AAccountData.UseAccount then
      AddFormField('apiKey', AAccountData.AccountName);

    AddFormField('folderKey', GetFolderID(AFolderIdentifier));
  end;

  LRequestID := HTTPManager.Post(THTTPRequest.Create(WEBSITE + 'api.html?api=getFolder_V2'), LHTTPParams, TPlugInHTTPOptions.Create(Self));

  HTTPManager.WaitFor(LRequestID);

  LHTTPProcess := HTTPManager.GetResult(LRequestID);

  if LHTTPProcess.HTTPResult.HasError then
  begin
    ErrorMsg := LHTTPProcess.HTTPResult.HTTPResponseInfo.ErrorMessage;
  end
  else if not SameStr('', LHTTPProcess.HTTPResult.SourceCode) then
  begin
    LNeedToUninitialize := Succeeded(CoInitializeEx(nil, COINIT_MULTITHREADED));
    try
      LXMLDoc := NewXMLDocument;
      try
        try
          with LXMLDoc do
          begin
            LoadFromXML(LHTTPProcess.HTTPResult.SourceCode);
            Active := True;
          end;
          with LXMLDoc.ChildNodes.Nodes['data'].ChildNodes do
          begin
            if not Assigned(FindNode('errorCode')) then
            begin
              case IndexText(VarToStr(Nodes['folderStatus'].NodeValue), ['1', '3', '2', '0']) of
                0:
                  ACrypterFolderInfo.Status := csOnline;
                1:
                  ACrypterFolderInfo.Status := csMixedOnOffline;
                2:
                  ACrypterFolderInfo.Status := csOffline;
                3:
                  ACrypterFolderInfo.Status := csUnknown;
              else
                ACrypterFolderInfo.Status := csNotChecked;
              end;
              ACrypterFolderInfo.Link := AFolderIdentifier;
              ACrypterFolderInfo.Size := VarToFloatDefault(VarToStr(Nodes['folderSize'].NodeValue), 0, True);
              if Nodes['files'].ChildNodes.Count > 0 then
                ACrypterFolderInfo.PartSize := VarToFloatDefault(Nodes['files'].ChildNodes.Nodes[0].ChildNodes.Nodes['filesize'].NodeValue, 0, False);
              ACrypterFolderInfo.Hoster := VarToStr(Nodes['folderHoster'].NodeValue);
              ACrypterFolderInfo.Parts := Nodes['files'].ChildNodes.Count;
              ACrypterFolderInfo.StatusImage := GetStatusImageLink(ACrypterFolderInfo.Link);
              ACrypterFolderInfo.StatusImageText := GetStatusImageLink(ACrypterFolderInfo.Link, False);
              Result := True;
            end
            else
            begin
              ErrorMsg := Nodes['errorCode'].NodeValue + ': ' + Nodes['errorMsg'].NodeValue;
            end;
          end;
        except
          on E: Exception do
          begin
            ErrorMsg := 'The XML from ' + GetName + ' was invaild: ' + E.message;
          end;
        end;
      finally
        LXMLDoc := nil;
      end;
    finally
      if LNeedToUninitialize then
        CoUninitialize;
    end;
  end
  else
  begin
    ErrorMsg := 'The Server response was empty!';
  end;
end;

end.
