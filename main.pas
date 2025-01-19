unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Bluetooth,
  System.Bluetooth.Components, Vcl.StdCtrls, System.Generics.Collections,
  iplcore, ipltypes, iplbleclient, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    ButtonScan: TButton;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    ButtonConnect: TButton;
    iplBLEClient1: TiplBLEClient;
    lvAdvertisements: TListView;
    Button1: TButton;
    procedure ButtonScanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonConnectClick(Sender: TObject);
    procedure iplBLEClient1Advertisement(Sender: TObject;
      const ServerId, Name: string; RSSI, TxPower: Integer;
      const ServiceUuids, ServicesWithData, SolicitedServiceUuids: string;
      ManufacturerCompanyId: Integer; const ManufacturerData: string;
      const ManufacturerDataB: TBytes; IsConnectable, IsScanResponse: Boolean);
    procedure iplBLEClient1Connected(Sender: TObject; StatusCode: Integer;
      const Description: string);
    procedure iplBLEClient1Disconnected(Sender: TObject; StatusCode: Integer;
      const Description: string);
    procedure iplBLEClient1Discovered(Sender: TObject; GattType: Integer;
      const ServiceId, CharacteristicId, DescriptorId, Uuid,
      Description: string);
    procedure lvAdvertisementsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure iplBLEClient1Value(Sender: TObject;
      const ServiceId, CharacteristicId, DescriptorId, Uuid, Description,
      Value: string; const ValueB: TBytes);
  private
    { Private declarations }

    isScanning: Boolean;
    ServerIds: TStringList;
    ServiceIds: TStringList;
    FlagsList: TStringList;
    selected_device: string;
    procedure Log(const Msg: string);
    function TBytesToHex(data: TBytes): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.TBytesToHex(data: TBytes): String;
var
  x: Integer;
begin
  for x := 0 to Length(data) - 1 do
    Result := Result + IntToHex(data[x], 2);
end;

// Function wit adding time of log data
procedure TForm1.Log(const Msg: string);
var
  Time: string;
begin
  Time := FormatDateTime('hh:nn:ss.zzz', Now);
  Memo1.Lines.Add('[' + Time + '] ' + Msg);
end;

procedure TForm1.lvAdvertisementsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  selected_device := Item.Caption;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //iplBLEClient1.ReadValue('6E400001-B5A3-F393-E0A9-E50E24DCCA9E', '6E400003-B5A3-F393-E0A9-E50E24DCCA9E', '');
   iplBLEClient1.Subscribe('000A00000000', '000A000B0000');
 // iplBLEClient1.ReadValue('000A00000000',
 //   '6E400003-B5A3-F393-E0A9-E50E24DCCA9E', '');

end;

procedure TForm1.ButtonConnectClick(Sender: TObject);
var
  connectedBleDevice: string;
begin
  iplBLEClient1.Connect(selected_device);
end;

procedure TForm1.ButtonScanClick(Sender: TObject);
begin
  if (iplBLEClient1.Scanning = False) then
  begin
    iplBLEClient1.StartScanning('');
    // ListBoxScannedDevices.Clear;
    ButtonScan.Caption := 'Stop scan';
  end
  else
  begin
    iplBLEClient1.StopScanning;
    ButtonScan.Caption := 'Start scan';
  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // BleDevices.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FlagsList := TStringList.Create;
  ServerIds := TStringList.Create;
  ServiceIds := TStringList.Create;
  isScanning := False;
end;

procedure TForm1.iplBLEClient1Advertisement(Sender: TObject;
  const ServerId, Name: string; RSSI, TxPower: Integer;
  const ServiceUuids, ServicesWithData, SolicitedServiceUuids: string;
  ManufacturerCompanyId: Integer; const ManufacturerData: string;
  const ManufacturerDataB: TBytes; IsConnectable, IsScanResponse: Boolean);
var
  serverIdExists: Boolean;
  I: Integer;
begin
  // This method will check to see if the ServerID already exists. If it does not,
  // then display advertisement information for it.
  Log('Advertisement: ' + Name + ' RSSI: ' + RSSI.ToString + ' dBm' +
    ' ServerId: ' + ServerId);
  serverIdExists := False;
  if ServerIds.Count = 0 then
  begin
    ServerIds.Add(ServerId);
  end
  else
  begin
    for I := 0 to ServerIds.Count - 1 do
    begin
      if ServerIds[I] = ServerId then
      begin
        serverIdExists := true;
        break;
      end;
    end;
  end;

  if not serverIdExists then
  begin
    ServerIds.Add(ServerId);
    lvAdvertisements.Items.Add();
    lvAdvertisements.Items[lvAdvertisements.Items.Count - 1].Caption :=
      ServerId;
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1]
      .SubItems.Add(Name);
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (inttostr(RSSI));
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (inttostr(TxPower));
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (booltostr(IsConnectable, true));
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (ServiceUuids);
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (ServicesWithData);
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (inttostr(ManufacturerCompanyId));
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add
      (TBytesToHex(ManufacturerDataB)); // Needs to be converted to hex string
  end

end;

procedure TForm1.iplBLEClient1Connected(Sender: TObject; StatusCode: Integer;
  const Description: string);
begin
  Log('On connected');
  iplBLEClient1.Discover('', '', true, '');
end;

procedure TForm1.iplBLEClient1Disconnected(Sender: TObject; StatusCode: Integer;
  const Description: string);
begin
  Log('On disconnect');
end;

procedure TForm1.iplBLEClient1Discovered(Sender: TObject; GattType: Integer;
  const ServiceId, CharacteristicId, DescriptorId, Uuid, Description: string);
begin


  if GattType = 0 then
  begin
    Log('Discover Service');
  end
  else if GattType = 1 then
  begin
    Log('Discover Characteristic');
  end
  else if GattType = 2 then
  begin
    begin
      Log('Discover Descriptor');
    end
  end;

  Log('Discovered: ' + Description + ' UUID: ' + Uuid + ' ServiceId: ' +
    ServiceId + ' CharacteristicId: ' + CharacteristicId + ' DescriptorId: ' +
    DescriptorId);

end;

procedure TForm1.iplBLEClient1Value(Sender: TObject;
  const ServiceId, CharacteristicId, DescriptorId, Uuid, Description,
  Value: string; const ValueB: TBytes);
begin
  //Log('Value: ' + Value + ' UUID: ' + Uuid + ' ServiceId: ' + ServiceId +
  //  ' CharacteristicId: ' + CharacteristicId + ' DescriptorId: ' +
  //  DescriptorId);
  Log( 'Value: ' + TBytesToHex(ValueB) );
end;

end.
