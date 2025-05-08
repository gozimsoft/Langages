object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Dic'
  ClientHeight = 669
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LBAllWord: TListBox
    AlignWithMargins = True
    Left = 3
    Top = 156
    Width = 350
    Height = 367
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
    OnClick = LBAllWordClick
  end
  object LBAllWordTranslate: TListBox
    AlignWithMargins = True
    Left = 359
    Top = 156
    Width = 350
    Height = 367
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
    OnClick = LBAllWordTranslateClick
  end
  object Edit1: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 715
    Height = 21
    Align = alTop
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 721
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Button1: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 75
      Height = 32
      Align = alLeft
      Caption = 'Load Dic'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button9: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 32
      Align = alLeft
      Caption = 'New Dic'
      TabOrder = 1
      OnClick = Button9Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 526
    Width = 721
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object MemWord: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 350
      Height = 90
      Align = alLeft
      Lines.Strings = (
        '')
      ScrollBars = ssBoth
      TabOrder = 0
      OnKeyPress = MemWordKeyPress
    end
    object MemWordTranslate: TMemo
      AlignWithMargins = True
      Left = 359
      Top = 3
      Width = 350
      Height = 90
      Align = alLeft
      Alignment = taRightJustify
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 625
    Width = 715
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object Button2: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Edit'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 165
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Delete'
      TabOrder = 1
      OnClick = Button4Click
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Add'
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object Panel4: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 109
    Width = 715
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object Button6: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Edit'
      TabOrder = 0
      OnClick = Button6Click
    end
    object Button7: TButton
      AlignWithMargins = True
      Left = 165
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Delete'
      TabOrder = 1
      OnClick = Button7Click
    end
    object Button8: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 35
      Align = alLeft
      Caption = 'Add'
      TabOrder = 2
      OnClick = Button8Click
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 65
    Width = 721
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object Edit2: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 715
      Height = 35
      Align = alClient
      TabOrder = 1
      Visible = False
      OnDblClick = Edit2DblClick
      ExplicitHeight = 27
    end
    object CbLang: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 715
      Height = 27
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = CbLangChange
      OnDblClick = CbLangDblClick
    end
  end
end
