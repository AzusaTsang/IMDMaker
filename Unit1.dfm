object Form1: TForm1
  Left = 0
  Top = 0
  AlphaBlendValue = 100
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'imd Maker 2s'
  ClientHeight = 601
  ClientWidth = 403
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 407
    Height = 601
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 206
      Top = 13
      Width = 70
      Height = 20
      Caption = #27468#26354#26102#38388#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 230
      Top = 40
      Width = 46
      Height = 20
      Caption = 'BPM'#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object BMSInfoMemo: TMemo
      Left = 456
      Top = 7
      Width = 168
      Height = 81
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      Lines.Strings = (
        'BMSInfoMemo')
      ScrollBars = ssBoth
      TabOrder = 8
      Visible = False
    end
    object BPMTxt: TEdit
      Left = 275
      Top = 37
      Width = 116
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 3
    end
    object IMD2txt: TButton
      Left = 113
      Top = 566
      Width = 94
      Height = 23
      Caption = #25209#37327#36716#25442#20026'txt'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = IMD2txtClick
    end
    object IsChangeBPM: TCheckBox
      Left = 319
      Top = 60
      Width = 72
      Height = 22
      Caption = 'BPM'#21464#36895
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = IsChangeBPMClick
    end
    object KeyGrid: TStringGrid
      Left = 14
      Top = 86
      Width = 377
      Height = 474
      Hint = #38754#26465#13#10'0='#21333#38190#13#10'6='#24320#22987#13#10'2='#25345#32493#13#10'10='#32467#26463#13#10#13#10#38190#22411#13#10'0='#25955#28857#13#10'1='#28369#38190#13#10'2='#38754#26465
      ColCount = 6
      DefaultColWidth = 58
      DefaultRowHeight = 22
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing, goThumbTracking]
      ParentFont = False
      ParentShowHint = False
      PopupMenu = KeyMenu
      ShowHint = True
      TabOrder = 5
    end
    object OpenBtn: TButton
      Left = 14
      Top = 7
      Width = 68
      Height = 23
      Caption = #25171#24320'(&O)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = OpenBtnClick
    end
    object OpenInExcel: TButton
      Left = 14
      Top = 566
      Width = 94
      Height = 23
      Caption = #22312'Excel'#20013#32534#36753
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = OpenInExcelClick
    end
    object SaveBtn: TButton
      Left = 14
      Top = 35
      Width = 68
      Height = 23
      Caption = #20445#23384'(&S)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      PopupMenu = SaveAsMenu
      TabOrder = 1
      OnClick = SaveBtnClick
    end
    object TimeTxt: TEdit
      Left = 275
      Top = 10
      Width = 116
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 2
      OnChange = TimeTxtChange
    end
    object HideHint: TCheckBox
      Left = 326
      Top = 569
      Width = 65
      Height = 15
      Caption = #38544#34255#25552#31034
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = HideHintClick
    end
    object OpenConnecter: TButton
      Left = 213
      Top = 566
      Width = 78
      Height = 23
      Caption = #38754#26465#36830#25509#22120
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = OpenConnecterClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 607
    Width = 378
    Height = 89
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 14
      Top = 5
      Width = 361
      Height = 75
      Caption = #35831#21247#25163#21160#20851#38381'Excel'#65292#27442#24819#36864#20986'Excel'#65292#35831#20808#13#10#36864#20986#32534#36753#27169#24335#65288#21035#20986#29616#20809#26631#65292#25353#19968#19979#21608#22260#30340#13#10#38190#65289#65292#20877#25353
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object ReturnToiM: TButton
      Left = 113
      Top = 58
      Width = 97
      Height = 24
      Caption = #36820#22238'imd Maker'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ReturnToiMClick
    end
  end
  object ExcelMemo: TMemo
    Left = 629
    Top = 338
    Width = 320
    Height = 372
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    Lines.Strings = (
      'ExcelMemo')
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
  end
  object Panel3: TPanel
    Left = 406
    Top = 0
    Width = 232
    Height = 601
    BevelOuter = bvNone
    TabOrder = 3
    object CleanBPM: TButton
      Left = 116
      Top = 565
      Width = 102
      Height = 24
      Caption = #28165#38500'BPM'#25968#25454
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CleanBPMClick
    end
    object BPMGrid: TStringGrid
      Left = 14
      Top = 86
      Width = 204
      Height = 474
      ColCount = 3
      DefaultColWidth = 58
      DefaultRowHeight = 22
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing, goThumbTracking]
      ParentFont = False
      TabOrder = 1
    end
    object ChangedBPM: TEdit
      Left = 14
      Top = 58
      Width = 128
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 2
      Text = 'BPM'
      OnEnter = ChangedBPMEnter
      OnExit = ChangedBPMExit
    end
    object BPMEnd: TEdit
      Left = 14
      Top = 33
      Width = 128
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 3
      Text = #32467#26463#26102#38388
      OnEnter = BPMEndEnter
      OnExit = BPMEndExit
    end
    object BPMBegin: TEdit
      Left = 14
      Top = 7
      Width = 128
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 4
      Text = #24320#22987#26102#38388
      OnEnter = BPMBeginEnter
      OnExit = BPMBeginExit
    end
    object BPMChangeBtn: TButton
      Left = 149
      Top = 57
      Width = 69
      Height = 24
      Caption = #28155#21152'BPM(&A)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BPMChangeBtnClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #35889#38754#25991#20214'|*.imd;*.bms'
    Left = 88
  end
  object ShakeBPMBegin: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ShakeBPMBeginTimer
    Left = 528
    Top = 8
  end
  object ShakeBPMEnd: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ShakeBPMEndTimer
    Left = 528
    Top = 32
  end
  object ShakeChangedBPM: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ShakeChangedBPMTimer
    Left = 528
    Top = 64
  end
  object SaveDialog: TSaveDialog
    Filter = 'imd'#25991#20214'|*.imd'
    Left = 88
    Top = 40
  end
  object ChangeFormSize: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ChangeFormSizeTimer
    Left = 288
    Top = 64
  end
  object ShakeTimeTxt: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ShakeTimeTxtTimer
    Left = 360
    Top = 8
  end
  object ShakeBPMTxt: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ShakeBPMTxtTimer
    Left = 360
    Top = 40
  end
  object KeyMenu: TPopupMenu
    Left = 232
    Top = 304
    object AddAbove: TMenuItem
      Caption = #22312#36873#20013#21333#20803#26684#19978#26041#22686#21152#19968#34892'(&U)'
      OnClick = AddAboveClick
    end
    object AddBelow: TMenuItem
      Caption = #22312#36873#20013#21333#20803#26684#19979#26041#22686#21152#19968#34892'(&B)'
      OnClick = AddBelowClick
    end
    object DeleteLine: TMenuItem
      Caption = #21024#38500#36873#20013#21333#20803#26684#25152#22312#34892'(&D)'
      OnClick = DeleteLineClick
    end
    object CopyGrid: TMenuItem
      Caption = #22797#21046#34920#26684'(&C)'
      OnClick = CopyGridClick
    end
    object PasteGrid: TMenuItem
      Caption = #28165#31354#24182#31896#36148#34920#26684'(&V)'
      OnClick = PasteGridClick
    end
  end
  object EnterExcelMode: TTimer
    Enabled = False
    Interval = 10
    OnTimer = EnterExcelModeTimer
    Left = 352
    Top = 377
  end
  object SaveAsMenu: TPopupMenu
    Left = 168
    Top = 40
    object SaveAsBtn: TMenuItem
      Caption = #21478#23384#20026'(&A)'
      OnClick = SaveAsBtnClick
    end
  end
end
