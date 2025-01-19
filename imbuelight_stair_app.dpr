program imbuelight_stair_app;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
