unit uLoadIT;

interface

uses
  // Delphi
  Windows, SysUtils, Classes, Controls, Variants, Math,
  // RegEx
  RegExpr,
  // Utils,
  uHTMLUtils, uPathUtils, uStringUtils,
  // Common
  uConst, uWebsiteInterface,
  // HTTPManager
  uHTTPInterface, uHTTPClasses, uHTTPConst,
  // Plugin system
  uPlugInCMSClass, uPlugInCMSFormbasedClass, uPlugInHTTPClasses;

type
  TLoadITSettings = class(TCMSFormbasedPlugInSettings)
  published
    [AttrDefaultValue(False)]
    property use_plainlinks;
    [AttrDefaultValue(False)]
    property use_textasdescription;

    property categorys;
  end;

  TLoadIT = class(TCMSFormbasedPlugIn)
  private
    LoadITSettings: TLoadITSettings;
  protected
    function SettingsClass: TCMSPlugInSettingsMeta; override;
    function GetSettings: TCMSPlugInSettings; override;
    procedure SetSettings(ACMSPlugInSettings: TCMSPlugInSettings); override;
    function LoadSettings(const AWebsiteData: ICMSWebsiteData = nil): Boolean; override;

    function DoBuildLoginRequest(out AHTTPRequest: IHTTPRequest; out AHTTPParams: IHTTPParams; out AHTTPOptions: IHTTPOptions; APrevResponse: string; ACAPTCHALogin: Boolean = False): Boolean; override;
    function NeedPostLogin(out ARequestURL: string): Boolean; override;
    function DoAnalyzeLogin(AResponseStr: string; out ACAPTCHALogin: Boolean): Boolean; override;

    function DoBuildPostRequest(const AWebsiteData: ICMSWebsiteData; out AHTTPRequest: IHTTPRequest; out AHTTPParams: IHTTPParams; out AHTTPOptions: IHTTPOptions; APrevResponse: string; APrevRequest: Double): Boolean; override;
    function DoAnalyzePost(AResponseStr: string; AHTTPProcess: IHTTPProcess): Boolean; override;

    function GetIDsRequestURL: string; override;
    function DoAnalyzeIDsRequest(AResponseStr: string): Integer; override;
  public
    function GetName: WideString; override; safecall;
    function DefaultCharset: WideString; override; safecall;
    function BelongsTo(AWebsiteSourceCode: WideString): WordBool; override; safecall;
  end;

implementation

function TLoadIT.SettingsClass;
begin
  Result := TLoadITSettings;
end;

function TLoadIT.GetSettings;
begin
  Result := LoadITSettings;
end;

procedure TLoadIT.SetSettings;
begin
  LoadITSettings := ACMSPlugInSettings as TLoadITSettings;
end;

function TLoadIT.LoadSettings;
begin
  Result := inherited LoadSettings(AWebsiteData);
  with LoadITSettings do
  begin
    if Assigned(AWebsiteData) and (categorys = null) then
    begin
      ErrorMsg := 'category is undefined!';
      Result := False;
    end;
  end;
end;

function TLoadIT.DoBuildLoginRequest;
begin
  Result := True;

  AHTTPRequest := THTTPRequest.Create(Website + 'index.php?p=login');
  with AHTTPRequest do
  begin
    Referer := Website;
    CharSet := LoadITSettings.CharSet;
  end;

  AHTTPParams := THTTPParams.Create(ptMultipartFormData);
  with AHTTPParams do
  begin
    AddFormField('username', AccountName);
    AddFormField('password', AccountPassword);
    AddFormField('submit', 'Login');
  end;

  AHTTPOptions := TPlugInHTTPOptions.Create(Self);
end;

function TLoadIT.NeedPostLogin(out ARequestURL: string): Boolean;
begin
  Result := True;
  ARequestURL := Website + 'index.php?p=home';
end;

function TLoadIT.DoAnalyzeLogin;
begin
  ACAPTCHALogin := False;

  Result := not(Pos('p=logout', AResponseStr) = 0);
  with TRegExpr.Create do
    try
      InputString := AResponseStr;
      Expression := 'alert\("(.*?)"';

      if Exec(InputString) then
      begin
        Self.ErrorMsg := HTML2Text(Match[1]);
      end
      else
      begin
        Expression := 'class="maincontent">(.*?)<';

        if Exec(InputString) then
        begin
          Self.ErrorMsg := Trim(HTML2Text(Match[1]));
        end
      end;
    finally
      Free;
    end;
end;

function TLoadIT.DoBuildPostRequest;
const
  DownloadArray: array [0 .. 3, 0 .. 1] of string = (('up_hoster', 'up_crypted'), ('mirror1_hoster', 'mirror1_links'), ('mirror2_hoster', 'mirror2_links'), ('mirror3_hoster', 'mirror3_links'));
var
  I: Integer;
begin
  Result := True;

  AHTTPRequest := THTTPRequest.Create(Website + 'index.php?p=insert');
  with AHTTPRequest do
  begin
    Referer := Website;
    CharSet := LoadITSettings.CharSet;
  end;

  AHTTPParams := THTTPParams.Create(ptMultipartFormData);
  with AHTTPParams do
  begin
    AddFormField('up_name', Subject);

    AddFormField('up_kat', LoadITSettings.categorys);

    if Assigned(AWebsiteData.FindControl(cPassword)) then
      AddFormField('up_pw', AWebsiteData.FindControl(cPassword).Value);

    if Assigned(AWebsiteData.FindControl(cPicture)) then
      AddFormField('up_cover', AWebsiteData.FindControl(cPicture).Value);

    for I := 0 to AWebsiteData.MirrorCount - 1 do
      if AWebsiteData.Mirror[I].Size > 0 then
      begin
        AddFormField('up_size', FloatToStr(AWebsiteData.Mirror[I].Size));
        break;
      end;

    if Assigned(AWebsiteData.FindControl(cAudioBitrate)) then
      AddFormField('up_bitrate', AWebsiteData.FindControl(cAudioBitrate).Value);

    if Assigned(AWebsiteData.FindControl(cGenre)) then
      AddFormField('genre', AWebsiteData.FindControl(cGenre).Value);

    if Assigned(AWebsiteData.FindControl(cTrailer)) then
      AddFormField('up_trailer', AWebsiteData.FindControl(cTrailer).Value);

    if not LoadITSettings.use_textasdescription then
    begin
      if Assigned(AWebsiteData.FindControl(cDescription)) then
        AddFormField('beschreibung', AWebsiteData.FindControl(cDescription).Value);
    end
    else
      AddFormField('beschreibung', Message);

    // max 3 mirrors
    for I := 0 to Min(3, AWebsiteData.MirrorCount) - 1 do
    begin
      if (I = 0) then
        AddFormField('andererhoster', AWebsiteData.Mirror[I].Hoster);

      AddFormField(DownloadArray[I][0], AWebsiteData.Mirror[I].Hoster);

      if LoadITSettings.use_plainlinks then
        AddFormField(DownloadArray[I][1], AWebsiteData.Mirror[I].Directlink[0].Value)
      else if (AWebsiteData.Mirror[I].CrypterCount > 0) then
        AddFormField(DownloadArray[I][1], AWebsiteData.Mirror[I].Crypter[0].Value)
      else
      begin
        ErrorMsg := 'No crypter initialized! (disable use_plainlinks or add a crypter)';
        Result := False;
      end;

    end;
  end;

  AHTTPOptions := TPlugInHTTPOptions.Create(Self);
end;

function TLoadIT.DoAnalyzePost;
begin
  Result := True;
end;

function TLoadIT.GetIDsRequestURL;
begin
  Result := Website + 'index.php?p=eintragen';
end;

function TLoadIT.DoAnalyzeIDsRequest;
var
  BoardLevel: TStringList;
  BoardLevelIndex: Integer;

  CategoryName, CategoryHTMLList: string;

  function IDPath(AStringList: TStringList): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to AStringList.Count - 1 do
    begin
      if not SameStr('', Result) then
        Result := Result + ' -> ';
      Result := Result + AStringList.Strings[I];
    end;
  end;

  function CleanPathName(AName: string): string;
  begin
    Result := Trim(HTML2Text(AName));
  end;

begin
  with TRegExpr.Create do
    try
      InputString := ExtractTextBetween(AResponseStr, 'name="up_kat"', '</select>') + '</select>';
      Expression := '>~ (.*?) ~<\/(.*?)(disabled="disabled"|<\/select>)';

      if Exec(InputString) then
      begin
        repeat
          CategoryName := Match[1];
          CategoryHTMLList := Match[2];

          BoardLevel := TStringList.Create;
          try
            // adding TOP-category
            BoardLevel.Add(CategoryName);

            with TRegExpr.Create do
              try
                InputString := CategoryHTMLList;
                Expression := 'value="(.*?)".*?t;(.*?)<\/';

                if Exec(InputString) then
                begin
                  repeat
                    BoardLevelIndex := 1;

                    if (BoardLevelIndex = BoardLevel.Count) then
                      BoardLevel.Add(CleanPathName(Match[2]))
                    else
                    begin
                      repeat
                        BoardLevel.Delete(BoardLevel.Count - 1);
                      until (BoardLevelIndex = BoardLevel.Count);
                      BoardLevel.Add(CleanPathName(Match[2]));
                    end;

                    AddID(Match[1], IDPath(BoardLevel));
                  until not ExecNext;
                end;
              finally
                Free;
              end;

          finally
            BoardLevel.Free;
          end;

        until not ExecNext;
      end;
    finally
      Free;
    end;

  Result := FCheckedIDsList.Count;
end;

function TLoadIT.GetName;
begin
  Result := 'LoadIT';
end;

function TLoadIT.DefaultCharset;
begin
  Result := 'UTF-8';
end;

function TLoadIT.BelongsTo;
begin
  Result := (Pos('index.php?p=load&amp;type=', string(AWebsiteSourceCode)) > 0);
end;

end.