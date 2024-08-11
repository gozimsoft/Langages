unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, JSON, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, iniFiles, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
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
    Button3: TButton;
    Button9: TButton;
    Panel5: TPanel;
    CbLang: TComboBox;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure LBAllWordClick(Sender: TObject);
    procedure LBAllWordTranslateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CbLangChange(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CbLangDblClick(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
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
  Form1: TForm1;

implementation

{$R *.dfm}
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

  // ����� JSON
  JSONObj := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // ����� �������
    ListBoxKeys.Clear;
    ListBoxValues.Clear;

    // ����� ������� ��������� ������
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

procedure TForm1.AddWord;
var
  I: Integer;
begin

  for I := 0 to LBAllWord.Items.Count - 1 do
  begin
    if LBAllWord.Items.Strings[I] = MemWord.Text then
    begin
      ShowMessage('�����');
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

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LoadDic;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  if MemWord.Text = EmptyStr then
    Exit;
  if MemWordTranslate.Text = EmptyStr then
    Exit;

  LBAllWord.Items.Strings[LBAllWord.ItemIndex] := MemWord.Text;
  LBAllWordTranslate.Items.Strings[LBAllWordTranslate.ItemIndex] :=
    MemWordTranslate.Text;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SaveDic;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  LBAllWord.Items.Delete(LBAllWord.ItemIndex);
  LBAllWordTranslate.Items.Delete(LBAllWordTranslate.ItemIndex);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  AddWord;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if not Edit2.Visible then
    Exit;
  CbLang.Items.Strings[CbLang.ItemIndex] := Edit2.Text;
  CbLang.Visible := true;
  Edit2.Visible := False;
  ShowMessage('Modified');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  CbLang.Items.Delete(CbLang.ItemIndex);
  ShowMessage('Deleted');
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  CbLang.Items.Add('Lang' + (CbLang.Items.Count + 1).ToString);
  CbLang.ItemIndex := CbLang.Items.Count - 1;
  ShowMessage('Added');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  NewDic;
end;

procedure TForm1.CbLangChange(Sender: TObject);
begin
  LoadLang;
end;

procedure TForm1.CbLangDblClick(Sender: TObject);
begin
  CbLang.Visible := False;
  Edit2.Visible := true;
  Edit2.Text := CbLang.Text;
end;

procedure TForm1.Edit2DblClick(Sender: TObject);
begin
  CbLang.Visible := true;
  Edit2.Visible := False;
end;

procedure TForm1.LBAllWordClick(Sender: TObject);
begin
  if LBAllWord.ItemIndex >= 0 then
  begin
    LBAllWordTranslate.ItemIndex := LBAllWord.ItemIndex;
    MemWord.Text := LBAllWord.Items.Strings[LBAllWord.ItemIndex];
    MemWordTranslate.Text := LBAllWordTranslate.Items.Strings
      [LBAllWordTranslate.ItemIndex];
  end;
end;

procedure TForm1.LBAllWordTranslateClick(Sender: TObject);
begin

  if LBAllWordTranslate.ItemIndex >= 0 then
  begin
    LBAllWord.ItemIndex := LBAllWordTranslate.ItemIndex;
    MemWord.Text := LBAllWord.Items.Strings[LBAllWord.ItemIndex];
    MemWordTranslate.Text := LBAllWordTranslate.Items.Strings
      [LBAllWordTranslate.ItemIndex];
  end;

end;

procedure TForm1.LoadDic;
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

procedure TForm1.LoadLang;
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
  finally
    IniMem.Free;
  end;

  MemWord.Text := '';
  MemWordTranslate.Text := '';
end;

procedure TForm1.NewDic;
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
    // ������ ��� ��� ����� �������
    if IniMem.SectionExists(SectionName) then
    begin
      // ��� ��� ����� ������ǡ �� ����� �����
      IniMem.EraseSection(SectionName);
    end;

    // ���� ��� ����� ������ ���������
    for I := 0 to SectionContent.Count - 1 do
    begin
      // �� ���� ������� �������
      Key := SectionContent.Names[I];
      Value := SectionContent.ValueFromIndex[I];
      // ��� ������� ������� ��� ����� ������
      IniMem.WriteString(SectionName, Key, Value);
    end;

    IniMem.UpdateFile; // ���� ��������� �� ��� ��� INI
  finally
    IniMem.Free;
  end;
end;

procedure TForm1.SaveDic;
var
  str: TStrings;
  I: Integer;
begin
  str := TStringList.Create;
  try
    for I := 0 to LBAllWord.Items.Count - 1 do
      str.Add(LBAllWord.Items.Strings[I] + '=' +
        LBAllWordTranslate.Items.Strings[I]);
    ReplaceOrAddSection(Edit1.Text, CbLang.Text, str);
  finally
    str.Free;
  end;
  ShowMessage('�� �����');
end;

end.