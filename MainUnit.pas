unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, JSON, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, iniFiles, Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    LBAllWord: TListBox;
    LBAllWordTranslate: TListBox;
    Edit1: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    MemWord: TMemo;
    MemWordTranslate: TMemo;
    Panel3: TPanel;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel4: TPanel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Panel5: TPanel;
    CbLang: TComboBox;
    Edit2: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure LBAllWordClick(Sender: TObject);
    procedure LBAllWordTranslateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CbLangChange(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CbLangDblClick(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
    procedure MemWordKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure NewDic;
    procedure LoadDic;
    procedure SaveDic;
    procedure AddWord;
    Procedure LoadLang;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses ExportDicUnit;
{ TForm1 }

procedure LoadJSONToListBoxes(const JSONString: string;
  ListBoxKeys, ListBoxValues: TListBox);
var
  JSONObj: TJSONObject;
  JSONPair: TJSONPair;
  JSONValue: TJSONValue;
  Keys, Values: TStrings;
  I: Integer;
begin

  //  Õ·Ì· JSON
  JSONObj := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // ≈›—«€ «·ﬁÊ«∆„
    ListBoxKeys.Clear;
    ListBoxValues.Clear;

    //  ⁄»∆… «·ﬁÊ«∆„ »«·„›« ÌÕ Ê«·ﬁÌ„
    for I := 0 to JSONObj.Count - 1 do
    begin
      JSONPair := JSONObj.Pairs[I];
      ListBoxKeys.Items.Add(JSONPair.JSONString.Value);
      ListBoxValues.Items.Add(JSONPair.JSONValue.Value);
    end;
  finally
    JSONObj.Free;
  end;
end;

procedure TFrmMain.AddWord;
var
  I: Integer;
begin

  for I := 0 to LBAllWord.Items.Count - 1 do
  begin
    if UpperCase(LBAllWord.Items.Strings[I]) = UpperCase(Trim(MemWord.Text))
    then
    begin
      ShowMessage('„ ﬂ——');
      Exit;
    end;
  end;

  if MemWord.Text = EmptyStr then
    Exit;
  if MemWordTranslate.Text = EmptyStr then
    Exit;
  LBAllWord.Items.Insert(0, MemWord.Text);
  LBAllWordTranslate.Items.Insert(0, MemWordTranslate.Text);

  LBAllWord.ItemIndex := 0;
  LBAllWordTranslate.ItemIndex := 0;

  MemWord.Clear;
  MemWordTranslate.Clear;

  SaveDic;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  LoadDic;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin

  if MemWord.Text = EmptyStr then
    Exit;
  if MemWordTranslate.Text = EmptyStr then
    Exit;

  LBAllWord.Items.Strings[LBAllWord.ItemIndex] := MemWord.Text;
  LBAllWordTranslate.Items.Strings[LBAllWordTranslate.ItemIndex] :=
    MemWordTranslate.Text;

  SaveDic;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
  with TFrmExportDic.Create(Self) Do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.Button4Click(Sender: TObject);
begin
  LBAllWord.Items.Delete(LBAllWord.ItemIndex);
  LBAllWordTranslate.Items.Delete(LBAllWordTranslate.ItemIndex);

  SaveDic;
end;

procedure TFrmMain.Button5Click(Sender: TObject);
begin
  AddWord;
end;

procedure TFrmMain.Button6Click(Sender: TObject);
begin
  if not Edit2.Visible then
    Exit;
  CbLang.Items.Strings[CbLang.ItemIndex] := Edit2.Text;
  CbLang.Visible := true;
  Edit2.Visible := False;
  ShowMessage('Modified');
end;

procedure TFrmMain.Button7Click(Sender: TObject);
begin
  if MessageDlg('„ «ﬂœ „‰ ⁄„·Ì… «·Õ–›', mtWarning, mbYesNo, 0) = mrYes then
  begin
    CbLang.Items.Delete(CbLang.ItemIndex);
    ShowMessage('Deleted');
    SaveDic;
  end;

end;

procedure TFrmMain.Button8Click(Sender: TObject);
begin
  CbLang.Items.Add('Lang' + (CbLang.Items.Count + 1).ToString);
  CbLang.ItemIndex := CbLang.Items.Count - 1;
  SaveDic;
  ShowMessage('Added');
end;

procedure TFrmMain.Button9Click(Sender: TObject);
begin
  NewDic;
end;

procedure TFrmMain.CbLangChange(Sender: TObject);
begin
  LoadLang;
end;

procedure TFrmMain.CbLangDblClick(Sender: TObject);
begin
  CbLang.Visible := False;
  Edit2.Visible := true;
  Edit2.Text := CbLang.Text;
end;

procedure TFrmMain.Edit2DblClick(Sender: TObject);
begin
  CbLang.Visible := true;
  Edit2.Visible := False;
end;

procedure TFrmMain.LBAllWordClick(Sender: TObject);
begin
  if LBAllWord.ItemIndex >= 0 then
  begin
    LBAllWordTranslate.ItemIndex := LBAllWord.ItemIndex;
    MemWord.Text := LBAllWord.Items.Strings[LBAllWord.ItemIndex];
    MemWordTranslate.Text := LBAllWordTranslate.Items.Strings
      [LBAllWordTranslate.ItemIndex];
  end;
end;

procedure TFrmMain.LBAllWordTranslateClick(Sender: TObject);
begin

  if LBAllWordTranslate.ItemIndex >= 0 then
  begin
    LBAllWord.ItemIndex := LBAllWordTranslate.ItemIndex;
    MemWord.Text := LBAllWord.Items.Strings[LBAllWord.ItemIndex];
    MemWordTranslate.Text := LBAllWordTranslate.Items.Strings
      [LBAllWordTranslate.ItemIndex];
  end;

end;

procedure TFrmMain.LoadDic;
var
  str: TStrings;
  IniMem: TMemIniFile;
begin

  str := TStringList.Create;
  try
    with TOpenDialog.Create(Self) do
      try
        if Execute then
        begin
          str.LoadFromFile(FileName);
          Edit1.Text := FileName;
          IniMem := TMemIniFile.Create(FileName);
          try
            IniMem.ReadSections(CbLang.Items);
            CbLang.ItemIndex := 0;
            LoadLang;
          finally
            IniMem.Free;
          end;
        end;
      finally
        Free;
      end;
  finally
    str.Free;
  end;

end;

procedure TFrmMain.LoadLang;
var
  str: TStrings;
  IniMem: TMemIniFile;
  I: Integer;
begin

  if CbLang.ItemIndex < 0 then
    Exit;

  LBAllWord.Clear;
  LBAllWordTranslate.Clear;

  IniMem := TMemIniFile.Create(Edit1.Text);
  try

    IniMem.ReadSection(CbLang.Text, LBAllWord.Items);

    for I := 0 to LBAllWord.Items.Count - 1 do
    begin
      LBAllWordTranslate.Items.Add(IniMem.ReadString(CbLang.Text,
        LBAllWord.Items.Strings[I], ''));
    end;

    for I := 0 to LBAllWord.Items.Count - 1 do
    begin
      LBAllWord.Items.Strings[I] := StringReplace(LBAllWord.Items.Strings[I],
        '#13#10', sLineBreak, [rfReplaceAll]);

      LBAllWordTranslate.Items.Strings[I] :=
        StringReplace(LBAllWordTranslate.Items.Strings[I], '#13#10', sLineBreak,
        [rfReplaceAll]);

    end;

  finally
    IniMem.Free;
  end;

  MemWord.Text := '';
  MemWordTranslate.Text := '';
end;

procedure TFrmMain.MemWordKeyPress(Sender: TObject; var Key: Char);
var
  str: string;
  I: Integer;
begin
  if Key = #13 then
  begin
    str := Trim(MemWord.Text);
    if str <> EmptyStr then

      for I := 0 to LBAllWord.Items.Count - 1 do
        if UpperCase(str) = UpperCase(LBAllWord.Items.Strings[I]) then
        begin
          LBAllWord.ItemIndex := I;
          ShowMessage('„ ﬂ——');
          Break;
        end;

  end;

end;

procedure TFrmMain.NewDic;
begin

  with TSaveDialog.Create(Self) do
    try
      FileName := 'Languages.ini';
      if Execute then
      begin
        Edit1.Text := FileName;
      end;
    finally
      Free;
    end;

end;

procedure ReplaceOrAddSection(const FileName, SectionName: string;
  const SectionContent: TStrings);
var
  IniMem: TMemIniFile;
  I: Integer;
  Key, Value: string;
begin
  IniMem := TMemIniFile.Create(FileName);
  try
    // «· Õﬁﬁ ≈–« ﬂ«‰ «·ﬁ”„ „ÊÃÊœ«
    if IniMem.SectionExists(SectionName) then
    begin
      // ≈–« ﬂ«‰ «·ﬁ”„ „ÊÃÊœ«° ﬁ„ »Õ–›Â √Ê·«
      IniMem.EraseSection(SectionName);
    end;

    // «·¬‰° √÷› «·ﬁ”„ «·ÃœÌœ »„Õ ÊÌ« Â
    for I := 0 to SectionContent.Count - 1 do
    begin
      // ﬁ„ »›’· «·„› «Õ Ê«·ﬁÌ„…
      Key := SectionContent.Names[I];
      Value := SectionContent.ValueFromIndex[I];
      // √÷› «·„› «Õ Ê«·ﬁÌ„… ≈·Ï «·ﬁ”„ «·„Õœœ
      IniMem.WriteString(SectionName, Key, Value);
    end;

    IniMem.UpdateFile; // ·Õ›Ÿ «· €ÌÌ—«  ›Ì „·› «·‹ INI
  finally
    IniMem.Free;
  end;
end;

procedure TFrmMain.SaveDic;
var
  str: TStrings;
  I: Integer;
  Key, Value: string;
begin
  str := TStringList.Create;
  try
    for I := 0 to LBAllWord.Items.Count - 1 do
    begin

      Key := LBAllWord.Items.Strings[I];
      Value := LBAllWordTranslate.Items.Strings[I];
      Key := StringReplace(Key, sLineBreak, '#13#10', [rfReplaceAll]);
      Value := StringReplace(Value, sLineBreak, '#13#10', [rfReplaceAll]);
      str.Add(Key + '=' + Value);

    end;

    ReplaceOrAddSection(Edit1.Text, CbLang.Text, str);

  finally
    str.Free;
  end;
  ShowMessage(' „ «·Õ›Ÿ');
end;

end.
