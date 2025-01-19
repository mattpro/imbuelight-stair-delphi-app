object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 912
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    1008
    912)
  TextHeight = 15
  object Memo1: TMemo
    Left = 0
    Top = 744
    Width = 1008
    Height = 168
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1008
    Height = 257
    Align = alTop
    Caption = 'Bluetooth'
    TabOrder = 1
    object ButtonScan: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Start scan'
      TabOrder = 0
      OnClick = ButtonScanClick
    end
    object ButtonConnect: TButton
      Left = 16
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 1
      OnClick = ButtonConnectClick
    end
    object lvAdvertisements: TListView
      Left = 120
      Top = 24
      Width = 489
      Height = 217
      Columns = <
        item
          Caption = 'Server ID'
          MinWidth = 10
          Width = 90
        end
        item
          Caption = 'Local Name'
          MinWidth = 10
          Width = 120
        end
        item
          Caption = 'RSSI'
          MinWidth = 10
          Width = 40
        end>
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
      OnSelectItem = lvAdvertisementsSelectItem
    end
    object Button1: TButton
      Left = 16
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Read'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 263
    Width = 240
    Height = 178
    Caption = 'Data'
    TabOrder = 2
    object ShapeLightState: TShape
      Left = 151
      Top = 53
      Width = 32
      Height = 20
      Brush.Color = clRed
      Shape = stCircle
    end
    object ShapeMoveState: TShape
      Left = 151
      Top = 77
      Width = 32
      Height = 20
      Brush.Color = clRed
      Shape = stCircle
    end
    object ShapeSensorState: TShape
      Left = 151
      Top = 103
      Width = 32
      Height = 20
      Brush.Color = clRed
      Shape = stCircle
    end
    object LabeledEditLight: TLabeledEdit
      Left = 56
      Top = 48
      Width = 89
      Height = 23
      EditLabel.Width = 27
      EditLabel.Height = 23
      EditLabel.Caption = 'Light'
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '...'
    end
    object LabeledEditMove: TLabeledEdit
      Left = 56
      Top = 74
      Width = 89
      Height = 23
      EditLabel.Width = 30
      EditLabel.Height = 23
      EditLabel.Caption = 'Move'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '...'
    end
    object StaticText1: TStaticText
      Left = 71
      Top = 104
      Width = 67
      Height = 19
      Caption = 'Sensor state'
      TabOrder = 2
    end
    object CheckBoxLiveData: TCheckBox
      Left = 24
      Top = 25
      Width = 97
      Height = 17
      Caption = 'Live data'
      TabOrder = 3
      OnClick = CheckBoxLiveDataClick
    end
  end
  object Chart1: TChart
    Left = 304
    Top = 263
    Width = 681
    Height = 402
    Legend.Alignment = laBottom
    Legend.CheckBoxes = True
    Title.Text.Strings = (
      'TChart')
    Shadow.Visible = False
    View3D = False
    Color = 16620104
    TabOrder = 3
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      31
      15
      31)
    ColorPaletteIndex = 13
    object Series1: TFastLineSeries
      HoverElement = []
      SeriesColor = 6750054
      Title = 'Light'
      LinePen.Color = 6750054
      LinePen.Width = 3
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      HoverElement = []
      Title = 'Move'
      LinePen.Color = 3513587
      LinePen.Width = 3
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 447
    Width = 240
    Height = 282
    Caption = 'Settings'
    TabOrder = 4
    object LabelFirmwareVersion: TLabel
      Left = 28
      Top = 216
      Width = 32
      Height = 15
      Caption = 'FW: ...'
    end
    object CheckBoxLightEnable: TCheckBox
      Left = 71
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Enable'
      TabOrder = 0
    end
    object CheckBoxLightInvert: TCheckBox
      Left = 143
      Top = 31
      Width = 97
      Height = 17
      Caption = 'Invert'
      TabOrder = 1
    end
    object EditLightThreshold: TEdit
      Left = 143
      Top = 54
      Width = 67
      Height = 23
      TabOrder = 2
      Text = '0'
    end
    object StaticText2: TStaticText
      Left = 23
      Top = 31
      Width = 36
      Height = 19
      Caption = 'LIGHT'
      TabOrder = 3
    end
    object StaticText3: TStaticText
      Left = 77
      Top = 55
      Width = 56
      Height = 19
      Caption = 'Threshold'
      TabOrder = 4
    end
    object CheckBoxMoveEnable: TCheckBox
      Left = 71
      Top = 88
      Width = 97
      Height = 17
      Caption = 'Enable'
      TabOrder = 5
    end
    object CheckBoxMoveInvert: TCheckBox
      Left = 143
      Top = 87
      Width = 97
      Height = 17
      Caption = 'Invert'
      TabOrder = 6
    end
    object EditMoveThreshold: TEdit
      Left = 143
      Top = 110
      Width = 67
      Height = 23
      TabOrder = 7
      Text = '0'
    end
    object StaticText4: TStaticText
      Left = 23
      Top = 87
      Width = 37
      Height = 19
      Caption = 'MOVE'
      TabOrder = 8
    end
    object StaticText5: TStaticText
      Left = 77
      Top = 111
      Width = 56
      Height = 19
      Caption = 'Threshold'
      TabOrder = 9
    end
    object CheckBoxOutInvert: TCheckBox
      Left = 23
      Top = 136
      Width = 160
      Height = 17
      Caption = 'Out signal invert'
      TabOrder = 10
    end
    object ComboBoxLedFunction: TComboBox
      Left = 62
      Top = 164
      Width = 145
      Height = 23
      TabOrder = 11
      Text = 'None'#11
      Items.Strings = (
        'None '
        'Move sensor'
        'Light sensor'
        'Out signal')
    end
    object StaticText6: TStaticText
      Left = 28
      Top = 168
      Width = 27
      Height = 19
      Caption = 'LED:'
      TabOrder = 12
    end
    object StaticText7: TStaticText
      Left = 28
      Top = 192
      Width = 30
      Height = 19
      Caption = 'OUT:'
      TabOrder = 13
    end
    object ComboBoxOutFunction: TComboBox
      Left = 62
      Top = 188
      Width = 145
      Height = 23
      TabOrder = 14
      Text = 'None'#11
      Items.Strings = (
        'None '
        'Move sensor'
        'Light sensor'
        'Out signal')
    end
    object ButtonReadSettings: TButton
      Left = 23
      Top = 242
      Width = 82
      Height = 25
      Caption = 'Read'
      TabOrder = 15
      OnClick = ButtonReadSettingsClick
    end
    object ButtonSaveSettings: TButton
      Left = 120
      Top = 242
      Width = 82
      Height = 25
      Caption = 'Save'
      TabOrder = 16
      OnClick = ButtonSaveSettingsClick
    end
  end
  object ble: TiplBLEClient
    OnAdvertisement = bleAdvertisement
    OnConnected = bleConnected
    OnDisconnected = bleDisconnected
    OnDiscovered = bleDiscovered
    OnValue = bleValue
    Left = 680
    Top = 296
  end
end
