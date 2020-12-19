object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 442
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 24
    Top = 88
    Width = 217
    Height = 329
    ItemHeight = 13
    TabOrder = 0
  end
  object ListBox2: TListBox
    Left = 320
    Top = 88
    Width = 225
    Height = 329
    ItemHeight = 13
    TabOrder = 1
  end
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 121
    Height = 41
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'imd'#35889#38754'|*.imd'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 216
    Top = 8
  end
end
