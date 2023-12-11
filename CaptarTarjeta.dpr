program CaptarTarjeta;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {PosConnect};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPosConnect, PosConnect);
  Application.Run;
end.
