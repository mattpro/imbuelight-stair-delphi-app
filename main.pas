unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Bluetooth,
  System.Bluetooth.Components, Vcl.StdCtrls, System.Generics.Collections,
  iplcore, ipltypes, iplbleclient;

type
  TForm1 = class(TForm)
    BluetoothLE1: TBluetoothLE;
    ButtonScan: TButton;
    Memo1: TMemo;
    ListBoxScannedDevices: TListBox;
    GroupBox1: TGroupBox;
    ButtonConnect: TButton;
    iplBLEClient1: TiplBLEClient;
    procedure ButtonScanClick(Sender: TObject);
    procedure BluetoothLE1DiscoverLEDevice(const Sender: TObject;
      const ADevice: TBluetoothLEDevice; Rssi: Integer;
      const ScanResponse: TScanResponse);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonConnectClick(Sender: TObject);
    procedure BluetoothLE1Connect(Sender: TObject);
    procedure BluetoothLE1ConnectedDevice(const Sender: TObject;
      const ADevice: TBluetoothLEDevice);
    procedure BluetoothLE1ServicesDiscovered(const Sender: TObject;
      const AServiceList: TBluetoothGattServiceList);
    procedure BluetoothLE1EndDiscoverServices(const Sender: TObject;
      const AServiceList: TBluetoothGattServiceList);
    procedure BluetoothLE1EndDiscoverDevices(const Sender: TObject;
      const ADeviceList: TBluetoothLEDeviceList);
    procedure iplBLEClient1Advertisement(Sender: TObject; const ServerId,
      Name: string; RSSI, TxPower: Integer; const ServiceUuids,
      ServicesWithData, SolicitedServiceUuids: string;
      ManufacturerCompanyId: Integer; const ManufacturerData: string;
      const ManufacturerDataB: TBytes; IsConnectable, IsScanResponse: Boolean);
    procedure iplBLEClient1Connected(Sender: TObject; StatusCode: Integer;
      const Description: string);
    procedure iplBLEClient1Disconnected(Sender: TObject; StatusCode: Integer;
      const Description: string);
    procedure iplBLEClient1Discovered(Sender: TObject; GattType: Integer;
      const ServiceId, CharacteristicId, DescriptorId, Uuid,
      Description: string);
  private
    { Private declarations }
    BleDevices: TDictionary<string, TBluetoothLEDevice>;
    connectedBleDevice: TBluetoothLEDevice;
    procedure Log(const Msg: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// Function wit adding time of log data
procedure TForm1.Log(const Msg: string);
var
  Time: string;
begin
  Time := FormatDateTime('hh:nn:ss.zzz', Now);
  Memo1.Lines.Add('[' + Time + '] ' + Msg);
end;

procedure TForm1.BluetoothLE1Connect(Sender: TObject);
begin
  Log('BluetoothLE1Connect');
end;

procedure TForm1.BluetoothLE1ConnectedDevice(const Sender: TObject;
  const ADevice: TBluetoothLEDevice);
begin
  Log('BluetoothLE1ConnectedDevice');
end;

procedure TForm1.BluetoothLE1DiscoverLEDevice(const Sender: TObject;
  const ADevice: TBluetoothLEDevice; Rssi: Integer;
  const ScanResponse: TScanResponse);
var
  MacAddress: string;
  bledevice: TBluetoothLEDevice;
begin
  // Log the discovered device
  Log('New device: ' + ADevice.DeviceName + ' RSSI: ' + Rssi.ToString + ' dBm');

  // Avoid duplicate entries for the same device
  if not BleDevices.ContainsKey(ADevice.Address) then
  begin
    BleDevices.Add(ADevice.Address, ADevice);
  end;

  // Clear the ListBox to avoid redundant items
  ListBoxScannedDevices.Clear;

  // Iterate through the dictionary and populate the ListBox
  for MacAddress in BleDevices.Keys do
  begin
    bledevice := BleDevices[MacAddress];
    ListBoxScannedDevices.AddItem(bledevice.DeviceName + ' ' + MacAddress + ' RSSI: ' + bledevice.LastRSSI.ToString + ' dBm', bledevice);
  end;
end;

procedure TForm1.BluetoothLE1EndDiscoverDevices(const Sender: TObject;
  const ADeviceList: TBluetoothLEDeviceList);
begin
  Log('BluetoothLE1EndDiscoverDevices');
end;

procedure TForm1.BluetoothLE1EndDiscoverServices(const Sender: TObject;
  const AServiceList: TBluetoothGattServiceList);
begin
  Log('BluetoothLE1EndDiscoverServices');
end;

procedure TForm1.BluetoothLE1ServicesDiscovered(const Sender: TObject;
  const AServiceList: TBluetoothGattServiceList);
begin
  Log('BluetoothLE1ServicesDiscovered:');
end;

procedure TForm1.ButtonConnectClick(Sender: TObject);
begin
//  // Check if an item is selected
//  if ListBoxScannedDevices.ItemIndex = -1 then
//  begin
//    Log('Please select a device to connect.');
//    Exit;
//  end;
//
//  // Get the associated TBluetoothLEDevice object from the selected item
//  connectedBleDevice := TBluetoothLEDevice(ListBoxScannedDevices.Items.Objects
//    [ListBoxScannedDevices.ItemIndex]);

  //if connectedBleDevice <> nil then
  //begin
   // Log('Connecting to: ' + connectedBleDevice.DeviceName);
    iplBLEClient1.Connect('D419FC47881D');
    //connectedBleDevice.DiscoverServices;
    // Proceed with your BLE connection logic here

  //end
  //else
  //begin
   // ShowMessage('No device associated with the selected item.');
  //end;
end;

procedure TForm1.ButtonScanClick(Sender: TObject);
begin
//  BluetoothLE1.DiscoverDevices(1000);
  iplBLEClient1.StartScanning('');
  ListBoxScannedDevices.Clear;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BleDevices.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BleDevices := TDictionary<string, TBluetoothLEDevice>.Create;
end;

procedure TForm1.iplBLEClient1Advertisement(Sender: TObject; const ServerId,
  Name: string; RSSI, TxPower: Integer; const ServiceUuids, ServicesWithData,
  SolicitedServiceUuids: string; ManufacturerCompanyId: Integer;
  const ManufacturerData: string; const ManufacturerDataB: TBytes;
  IsConnectable, IsScanResponse: Boolean);
begin
  Log('Advertisement: ' + Name + ' RSSI: ' + RSSI.ToString + ' dBm' + ' ServerId: ' + ServerId);
end;

procedure TForm1.iplBLEClient1Connected(Sender: TObject; StatusCode: Integer;
  const Description: string);
begin
Log('On connected');
iplBLEClient1.DiscoverServices('','');
end;

procedure TForm1.iplBLEClient1Disconnected(Sender: TObject; StatusCode: Integer;
  const Description: string);
begin
Log('On disconnect');
end;

procedure TForm1.iplBLEClient1Discovered(Sender: TObject; GattType: Integer;
  const ServiceId, CharacteristicId, DescriptorId, Uuid, Description: string);
begin
Log('On discover');
end;

end.
