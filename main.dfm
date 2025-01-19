object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 771
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 48
    Top = 283
    Width = 385
    Height = 249
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 641
    Height = 241
    Caption = 'Bluetooth'
    TabOrder = 1
    object ButtonScan: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Scan'
      TabOrder = 0
      OnClick = ButtonScanClick
    end
    object ListBoxScannedDevices: TListBox
      Left = 113
      Top = 24
      Width = 520
      Height = 206
      ItemHeight = 15
      TabOrder = 1
    end
    object ButtonConnect: TButton
      Left = 16
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 2
      OnClick = ButtonConnectClick
    end
  end
  object BluetoothLE1: TBluetoothLE
    Enabled = True
    OnConnectedDevice = BluetoothLE1ConnectedDevice
    OnConnect = BluetoothLE1Connect
    OnDiscoverLEDevice = BluetoothLE1DiscoverLEDevice
    OnServicesDiscovered = BluetoothLE1ServicesDiscovered
    OnEndDiscoverDevices = BluetoothLE1EndDiscoverDevices
    OnEndDiscoverServices = BluetoothLE1EndDiscoverServices
    Left = 840
    Top = 64
  end
  object iplBLEClient1: TiplBLEClient
    OnAdvertisement = iplBLEClient1Advertisement
    OnConnected = iplBLEClient1Connected
    OnDisconnected = iplBLEClient1Disconnected
    OnDiscovered = iplBLEClient1Discovered
    Left = 680
    Top = 296
  end
end
