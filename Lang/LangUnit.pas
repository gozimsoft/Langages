{ By GozimSoft }

unit LangUnit;

interface

Uses inifiles, Dialogs, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls,
  Vcl.Controls,
  Vcl.forms,
  System.Classes;

const
  Lang_ar = 'ar';

Type


  // Ttype_Lang = set of (Lang_Ar, Lang_En, Lang_Fr);

  Tlang = Class

  private
    FLangage: string;
    FDic: string;
    FFileNameDic: string;
    function FindWordInDic(aDic: TMemIniFile; aStr: string): string;
    function TranslateWord(aStr: string): string;
    procedure TranslateComponent(aComponent: TComponent);
    procedure PrepareForm(aForm: TControl);
    procedure PrepareComponentsDirection(aComponent: TComponent);
  public
    constructor Create(aDic: string = '');
    Property FileNameDic: string read FFileNameDic write FFileNameDic;
    Property Langage: string read FLangage write FLangage;
    procedure Translate(aForm: TControl);
  End;

implementation

{ Tlang }
constructor Tlang.Create(aDic: string);
begin
  FDic := aDic;
end;

function Tlang.FindWordInDic(aDic: TMemIniFile; aStr: string): string;
begin

  with aDic do
  begin
    try
      Result := ReadString(FLangage, aStr, aStr);
    except
      Result := aStr;
    end;
  end;

end;

procedure Tlang.PrepareComponentsDirection(aComponent: TComponent);
begin

  // if FLangage in ([Lang_Ar]) then
  begin
    if aComponent is TLabel then
    begin
      with TLabel(aComponent) do
      begin
        if Alignment = taLeftJustify then
          Alignment := taRightJustify
        else if Alignment = taRightJustify then
          Alignment := taLeftJustify;
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TGroupBox then
    begin
      with TGroupBox(aComponent) do
      begin
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TSearchBox then
    begin
      with TSearchBox(aComponent) do
      begin
        if Alignment = taLeftJustify then
          Alignment := taRightJustify
        else if Alignment = taRightJustify then
          Alignment := taLeftJustify;
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TEdit then
    begin
      with TEdit(aComponent) do
      begin
        if Alignment = taLeftJustify then
          Alignment := taRightJustify
        else if Alignment = taRightJustify then
          Alignment := taLeftJustify;
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TPanel then
    begin
      with TPanel(aComponent) do
      begin
        if Alignment = taLeftJustify then
          Alignment := taRightJustify
        else if Alignment = taRightJustify then
          Alignment := taLeftJustify;
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TComboBox then
    begin
      with TComboBox(aComponent) do
      begin
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TListBox then
    begin
      with TListBox(aComponent) do
      begin
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
    else if aComponent is TMemo then
    begin
      with TPanel(aComponent) do
      begin
        if Alignment = taLeftJustify then
          Alignment := taRightJustify
        else if Alignment = taRightJustify then
          Alignment := taLeftJustify;
        if BiDiMode = bdLeftToRight then
          BiDiMode := bdRightToLeft
        else if BiDiMode = bdRightToLeft then
          BiDiMode := bdLeftToRight;
      end
    end
  end;

end;

procedure Tlang.PrepareForm(aForm: TControl);
begin
  if FLangage = Lang_ar then
  begin
    if aForm is Tform then
    begin
      Tform(aForm).FlipChildren(True);
    end
    else if aForm is TFrame then
    begin
      TFrame(aForm).FlipChildren(True);
    end;
  end;
end;

procedure Tlang.TranslateComponent(aComponent: TComponent);
var
  _Text: string;
  I: integer;
begin
  if aComponent is TLabel then
  begin
    with TLabel(aComponent) do
    begin
      Caption := TranslateWord(Caption);
    end
  end
  else if aComponent is TButton then
  begin
    with TButton(aComponent) do
    begin
      Caption := TranslateWord(Caption);
    end
  end
  else if aComponent is TGroupBox then
  begin
    with TGroupBox(aComponent) do
    begin
      Caption := TranslateWord(Caption);
    end
  end
  else if aComponent is TSearchBox then
  begin
    with TSearchBox(aComponent) do
    begin
      Text := TranslateWord(Text);
      TextHint := TranslateWord(TextHint);
    end
  end
  else if aComponent is TEdit then
  begin
    with TEdit(aComponent) do
    begin
      Text := TranslateWord(Text);
      TextHint := TranslateWord(TextHint);
    end
  end
  else if aComponent is TPanel then
  begin
    with TPanel(aComponent) do
    begin
      Caption := TranslateWord(Caption);
    end
  end
  else if aComponent is TComboBox then
  begin
    with TComboBox(aComponent) do
    begin
      _Text := Text;
      for I := 0 to Items.Count - 1 do
        Items.Strings[I] := TranslateWord(Items.Strings[I]);
      Text := _Text;
    end
  end
  else if aComponent is TListBox then
  begin
    with TListBox(aComponent) do
    begin
      for I := 0 to Items.Count - 1 do
        Items.Strings[I] := TranslateWord(Items.Strings[I]);
    end
  end;
end;

function Tlang.TranslateWord(aStr: string): string;
var
  IniMem: TMemIniFile;
  _Dic: TStrings;
begin
  _Dic := TStringList.Create;
  try
    if FDic = EmptyStr then
    begin
      try
        _Dic.LoadFromFile(FFileNameDic);
      except
        raise Exception.Create('Error: Dictionary not found');
      end;
    end
    else
      _Dic.Text := FDic;

    IniMem := TMemIniFile.Create('');
    try
      IniMem.SetStrings(_Dic);
      Result := FindWordInDic(IniMem, aStr);
    finally
      IniMem.Free;
    end;

  finally
    _Dic.Free;
  end;

end;

procedure Tlang.Translate(aForm: TControl);
var
  I: integer;
begin
  PrepareForm(aForm);
  for I := 0 to aForm.ComponentCount - 1 do
  begin
    TranslateComponent(aForm.Components[I]);
    PrepareComponentsDirection(aForm.Components[I]);
  end;
end;

end.
