program Dictionary;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {FrmMain},
  ExportDicUnit in 'ExportDicUnit.pas' {FrmExportDic};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmExportDic, FrmExportDic);
  Application.Run;
end.
