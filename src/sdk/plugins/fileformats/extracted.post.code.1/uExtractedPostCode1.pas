unit uExtractedPostCode1;

interface

uses
  // Delphi
  SysUtils, Classes, Variants, StrUtils, XMLDoc, XMLIntf, ActiveX,
  // Common
  uBaseConst, uAppInterface,
  // Utils
  uStringUtils,
  // Plugin system
  uPlugInInterfaceAdv, uPlugInFileFormatClass;

type
  TExtractedPostCode = class(TFileFormatPlugIn)
  public
    function GetAuthor: WideString; override;
    function GetAuthorURL: WideString; override;
    function GetDescription: WideString; override;
    function GetName: WideString; override;

    function GetFileExtension: WideString; override;
    function GetFileFilter: WideString; override;

    function CanSaveFiles: WordBool; override;
    function SaveFile(const AFileName: WideString; const ATabSheetController: ITabSheetController): WordBool; override;

    function CanLoadFiles: WordBool; override;
    function LoadFile(const AFileFormatData: IFileFormatData; const AFileName: WideString; const APageController: IPageController): Integer; override;
  end;

implementation

{ TExtractedPostCode }

function TExtractedPostCode.GetAuthor;
begin
  Result := 'Sebastian Klatte';
end;

function TExtractedPostCode.GetAuthorURL;
begin
  Result := 'http://www.intelligen2009.com/';
end;

function TExtractedPostCode.GetDescription;
begin
  Result := GetName + ' file formats plug-in.';
end;

function TExtractedPostCode.GetName;
begin
  Result := 'extracted.post.code.1';
end;

function TExtractedPostCode.GetFileExtension;
begin
  result := '.epc';
end;

function TExtractedPostCode.GetFileFilter;
begin
  result := 'extracted post code 1 %s (*.epc)|*.epc|';
end;

function TExtractedPostCode.CanSaveFiles;
begin
  result := True;
end;

function TExtractedPostCode.SaveFile;
var
  LNeedToUninitialize: Boolean;
  XMLDoc: IXMLDocument;
  I: Integer;
  _hoster: string;
begin
  LNeedToUninitialize := Succeeded(CoInitialize(nil));
  try
    XMLDoc := NewXMLDocument;
    try
      with XMLDoc do
      begin
        Options := Options + [doNodeAutoIndent];
        DocumentElement := CreateElement('Settings', '');
        Active := True;
        Encoding := 'iso-8859-1';
      end;
      with XMLDoc.DocumentElement do
      begin
        with AddChild('Title') do
          NodeValue := ATabSheetController.ControlController.FindControl(cTitle).Value;
        with AddChild('SelectedArea') do
          case ATabSheetController.ControlController.TypeID of
            cAudio:
              NodeValue := '24';
            cMovie:
              NodeValue := '14';
            cNintendoDS, cNintendo3DS:
              NodeValue := '10';
            cPCGames:
              NodeValue := '4';
            cPlayStation3:
              NodeValue := '7';
            cPlayStationVita:
              NodeValue := '8';
            cSoftware:
              NodeValue := '0';
            cWii:
              NodeValue := '9';
            cXbox360:
              NodeValue := '12';
            cXXX:
              NodeValue := '31';
            cOther:
              NodeValue := '';
          end;
        with AddChild('Post') do
          with ATabSheetController do
            with TStringList.Create do
              try
                Add('.');
                Add('[center]');
                if Assigned(ControlController.FindControl(cPicture)) then
                  Add('[img]' + ControlController.FindControl(cPicture).Value + '[/img]');

                Add('');

                if Assigned(ControlController.FindControl(cVideoSystem)) then
                  Add('[b]Video System:[/b] ' + ControlController.FindControl(cVideoSystem).Value);
                if Assigned(ControlController.FindControl(cVideoStream)) then
                  Add('[b]Video Stream:[/b] ' + ControlController.FindControl(cVideoStream).Value);
                if Assigned(ControlController.FindControl(cAudioStream)) then
                  Add('[b]Audio Stream:[/b] ' + ControlController.FindControl(cAudioStream).Value);
                if Assigned(ControlController.FindControl(cAudioBitrate)) then
                  Add('[b]Audio Bitrate:[/b] ' + ControlController.FindControl(cAudioBitrate).Value);
                if Assigned(ControlController.FindControl(cVideoCodec)) then
                  Add('[b]Video Codec:[/b] ' + ControlController.FindControl(cVideoCodec).Value);
                if Assigned(ControlController.FindControl(cAudioEncoder)) then
                  Add('[b]Audio Encoder:[/b] ' + ControlController.FindControl(cAudioEncoder).Value);
                if Assigned(ControlController.FindControl(cAudioSamplingRate)) then
                  Add('[b]Audio Sampling Rate:[/b] ' + ControlController.FindControl(cAudioSamplingRate).Value);

                if Assigned(ControlController.FindControl(cGenre)) then
                  Add('[b]Genre:[/b] ' + ControlController.FindControl(cGenre).Value);
                if Assigned(ControlController.FindControl(cLanguage)) then
                  Add('[b]Language/s:[/b] ' + ControlController.FindControl(cLanguage).Value);
                Add('[b]Parts:[/b] ' + IntToStr(CharCount('http://', MirrorController.Mirror[0].Directlink[0].Value)));
                if Assigned(ControlController.FindControl(cPassword)) and (ControlController.FindControl(cPassword).Value <> '') then
                  Add('[b]Password:[/b] ' + ControlController.FindControl(cPassword).Value);

                for I := 0 to MirrorController.MirrorCount - 1 do
                  if MirrorController.Mirror[I].Size > 0 then
                  begin
                    Add('[b]Size:[/b] ' + FloatToStr(MirrorController.Mirror[I].Size) + ' MB');
                    break;
                  end;

                _hoster := '[b]Hoster:[/b]';
                for I := 0 to MirrorController.MirrorCount - 1 do
                begin
                  _hoster := _hoster + ' ' + MirrorController.Mirror[I].Hoster;
                  if not(I = MirrorController.MirrorCount - 1) then
                    _hoster := _hoster + ',';
                end;
                Add(_hoster);

                if Assigned(ControlController.FindControl(cDescription)) then
                begin
                  Add('');
                  Add(ControlController.FindControl(cDescription).Value);
                end;

                Add('');

                for I := 0 to MirrorController.MirrorCount - 1 do
                begin
                  Add('[b]Mirror: ' + IntToStr(I + 1) + '[/b]');
                  Add('');
                  Add('[b]' + MirrorController.Mirror[I].Hoster + '[/b]');
                  Add('[code]' + MirrorController.Mirror[I].Directlink[0].Value + '[/code]');
                  if not(I = MirrorController.MirrorCount - 1) then
                    Add('');
                end;

                Add('[/center]');
                NodeValue := Text;
              finally
                Free;
              end;
      end;

      XMLDoc.SaveToFile(ChangeFileExt(AFileName, '.epc'));
    finally
      XMLDoc := nil;
    end;
  finally
    if LNeedToUninitialize then
      CoUninitialize;
  end;
end;

function TExtractedPostCode.CanLoadFiles;
begin
  result := False;
end;

function TExtractedPostCode.LoadFile;
begin
  result := -1;
end;

end.
