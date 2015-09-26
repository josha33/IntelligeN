library erodvdnl;

uses
  uPlugInInterface,
  uPlugInCrawlerClass,
  uErodvdNl in 'uErodvdNl.pas';

{$R *.res}

function LoadPlugin(var PlugIn: ICrawlerPlugIn): Boolean; stdcall; export;
begin
  try
    PlugIn := TErodvdNl.Create;
    Result := True;
  except
    Result := False;
  end;
end;

exports
  LoadPlugIn name 'LoadPlugIn';

begin
end.