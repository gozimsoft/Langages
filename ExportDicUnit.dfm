object FrmExportDic: TFrmExportDic
  Left = 0
  Top = 0
  Caption = 'Export Dic'
  ClientHeight = 667
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Button1: TButton
    AlignWithMargins = True
    Left = 3
    Top = 32
    Width = 690
    Height = 50
    Align = alTop
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 690
    Height = 23
    Align = alTop
    TabOrder = 1
    Text = 'D:\Delphi\programs\Clinic'
  end
  object Memo1: TMemo
    Left = 0
    Top = 85
    Width = 696
    Height = 526
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button2: TButton
    AlignWithMargins = True
    Left = 3
    Top = 614
    Width = 690
    Height = 50
    Align = alBottom
    Caption = 'Save'
    TabOrder = 3
    OnClick = Button2Click
  end
end
