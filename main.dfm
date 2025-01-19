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
    Left = 0
    Top = 408
    Width = 1008
    Height = 363
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
      Left = 113
      Top = 24
      Width = 1200
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
        end
        item
          Caption = 'TxPwr'
          MinWidth = 10
          Width = 45
        end
        item
          Caption = 'Connectable'
          MinWidth = 10
          Width = 72
        end
        item
          Caption = 'Service UUIDs'
          MinWidth = 10
          Width = 300
        end
        item
          Caption = 'Services With Data'
          MinWidth = 10
          Width = 105
        end
        item
          Caption = 'Mfr ID'
          MinWidth = 10
          Width = 60
        end
        item
          Caption = 'Manufacturer Data'
          MinWidth = 10
          Width = 300
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
  object iplBLEClient1: TiplBLEClient
    OnAdvertisement = iplBLEClient1Advertisement
    OnConnected = iplBLEClient1Connected
    OnDisconnected = iplBLEClient1Disconnected
    OnDiscovered = iplBLEClient1Discovered
    OnValue = iplBLEClient1Value
    Left = 680
    Top = 296
  end
end
