object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #38754#26465#36830#25509#22120
  ClientHeight = 750
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 106
  TextHeight = 14
  object Background: TShape
    Left = 71
    Top = 15
    Width = 371
    Height = 639
  end
  object KeyCanval: TImage
    Left = 72
    Top = 16
    Width = 369
    Height = 637
    OnClick = KeyCanvalClick
    OnMouseDown = KeyCanvalMouseDown
  end
  object BeginTimeLabel: TLabel
    Left = 10
    Top = 635
    Width = 56
    Height = 19
    Alignment = taRightJustify
    Caption = '0000000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object EndTimeLabel: TLabel
    Left = 10
    Top = 8
    Width = 56
    Height = 19
    Alignment = taRightJustify
    Caption = '0000000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 58
    Top = 704
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '4'#38190
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 122
    Top = 704
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '5'#38190
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 187
    Top = 704
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '6'#38190
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 292
    Top = 711
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '1'#36895
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 334
    Top = 711
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '2'#36895
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 380
    Top = 711
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '3'#36895
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 421
    Top = 711
    Width = 21
    Height = 19
    Alignment = taCenter
    Caption = '4'#36895
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object TrackCountBar: TTrackBar
    Left = 58
    Top = 680
    Width = 150
    Height = 25
    Max = 6
    Min = 4
    Position = 6
    TabOrder = 3
    OnChange = TrackCountBarChange
  end
  object SpeedBar: TTrackBar
    Left = 292
    Top = 680
    Width = 150
    Height = 25
    Max = 4
    Min = 1
    Position = 1
    TabOrder = 0
    OnChange = SpeedBarChange
  end
  object PlayBtn: TButton
    Left = 553
    Top = 368
    Width = 75
    Height = 25
    Caption = 'PlayBtn'
    TabOrder = 1
    Visible = False
    OnClick = PlayBtnClick
  end
  object ShowedKey: TMemo
    Left = 89
    Top = 440
    Width = 177
    Height = 188
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    Lines.Strings = (
      'ShowedKey')
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
  end
  object TimeLine: TScrollBar
    Left = 443
    Top = 15
    Width = 19
    Height = 639
    Kind = sbVertical
    PageSize = 0
    TabOrder = 4
    OnChange = TimeLineChange
  end
  object PlayTimer: TTimer
    Enabled = False
    Interval = 40
    OnTimer = PlayTimerTimer
    Left = 568
    Top = 320
  end
end
