unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Bluetooth,
  System.Bluetooth.Components, Vcl.StdCtrls, System.Generics.Collections,
  iplcore, ipltypes, iplbleclient, Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, VclTee.TeeProcs,
  VclTee.Chart, Mitov.VCLTypes, Vcl.LPControl, SLControlCollection,
  LPControlDrawLayers, SLBasicDataDisplay, SLDataDisplay, SLDataChart,
  SLScope, DateUtils;

type
  TForm1 = class(TForm)
    ButtonScan: TButton;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    ButtonConnect: TButton;
    ble: TiplBLEClient;
    lvAdvertisements: TListView;
    Button1: TButton;
    GroupBox2: TGroupBox;
    LabeledEditLight: TLabeledEdit;
    LabeledEditMove: TLabeledEdit;
    ShapeLightState: TShape;
    ShapeMoveState: TShape;
    ShapeSensorState: TShape;
    StaticText1: TStaticText;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    GroupBox3: TGroupBox;
    CheckBoxLiveData: TCheckBox;
    CheckBoxLightEnable: TCheckBox;
    CheckBoxLightInvert: TCheckBox;
    EditLightThreshold: TEdit;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    CheckBoxMoveEnable: TCheckBox;
    CheckBoxMoveInvert: TCheckBox;
    EditMoveThreshold: TEdit;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    CheckBoxOutInvert: TCheckBox;
    ComboBoxLedFunction: TComboBox;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    ComboBoxOutFunction: TComboBox;
    ButtonReadSettings: TButton;
    ButtonSaveSettings: TButton;
    LabelFirmwareVersion: TLabel;
    procedure ButtonScanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonConnectClick(Sender: TObject);
    procedure bleAdvertisement(Sender: TObject; const ServerId, Name: string; RSSI, TxPower: Integer;
      const ServiceUuids, ServicesWithData, SolicitedServiceUuids: string; ManufacturerCompanyId: Integer; const ManufacturerData: string;
      const ManufacturerDataB: TBytes; IsConnectable, IsScanResponse: Boolean);
    procedure bleConnected(Sender: TObject; StatusCode: Integer; const Description: string);
    procedure bleDisconnected(Sender: TObject; StatusCode: Integer; const Description: string);
    procedure bleDiscovered(Sender: TObject; GattType: Integer; const ServiceId, CharacteristicId, DescriptorId, Uuid, Description: string);
    procedure lvAdvertisementsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure bleValue(Sender: TObject; const ServiceId, CharacteristicId, DescriptorId, Uuid, Description, Value: string; const ValueB: TBytes);
    procedure CheckBoxLiveDataClick(Sender: TObject);
    procedure ButtonReadSettingsClick(Sender: TObject);
    procedure ButtonSaveSettingsClick(Sender: TObject);
  private
    { Private declarations }

    isScanning: Boolean;
    ServerIds: TStringList;
    ServiceIds: TStringList;
    FlagsList: TStringList;
    selected_device: string;
    ble_connected: Boolean;
    time_start: TDateTime;
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

procedure TForm1.lvAdvertisementsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  selected_device := Item.Caption;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // iplBLEClient1.ReadValue('6E400001-B5A3-F393-E0A9-E50E24DCCA9E', '6E400003-B5A3-F393-E0A9-E50E24DCCA9E', '');
  ble.Subscribe('000A00000000', '000A000B0000');
end;

procedure TForm1.ButtonConnectClick(Sender: TObject);
begin
  if (ble_connected = false) then
  begin
    ble.Connect(selected_device);
  end
  else
  begin
    ble.Disconnect;
  end;

end;


procedure TForm1.ButtonReadSettingsClick(Sender: TObject);
var
  data: TBytes;
begin
  SetLength(data, 1);
  data[0] :=  $BC;
  ble.WriteValue('000A00000000', '000A000E0000', '', data);
  Log('Get data');
end;

procedure TForm1.ButtonSaveSettingsClick(Sender: TObject);
var
  data: TBytes;
begin
  SetLength(data, 12);
  data[0] :=  $EC;
  data[1] :=  Byte(CheckBoxLightEnable.Checked);
  data[2] :=  StrToInt(EditLightThreshold.Text) shr 8;
  data[3] :=  StrToInt(EditLightThreshold.Text) and $FF;
  data[4] :=  Byte(CheckBoxLightInvert.Checked);

  data[5] :=  Byte(CheckBoxMoveEnable.Checked);
  data[6] :=  StrToInt(EditMoveThreshold.Text) shr 8;
  data[7] :=  StrToInt(EditMoveThreshold.Text) and $FF;
  data[8] :=  Byte(CheckBoxMoveInvert.Checked);

  data[9] :=  ComboBoxOutFunction.ItemIndex;
  data[10] :=  Byte(CheckBoxOutInvert.Checked);
  data[11] :=  ComboBoxLedFunction.ItemIndex;

  ble.WriteValue('000A00000000', '000A000E0000', '', data);
  Log('Save data');
end;

procedure TForm1.ButtonScanClick(Sender: TObject);
begin
  if (ble.Scanning = false) then
  begin
    ble.StartScanning('');
    // ListBoxScannedDevices.Clear;
    ButtonScan.Caption := 'Stop scan';
  end
  else
  begin
    ble.StopScanning;
    ButtonScan.Caption := 'Start scan';
  end;

end;

procedure TForm1.CheckBoxLiveDataClick(Sender: TObject);
begin
  if (CheckBoxLiveData.Checked) then
    ble.Subscribe('000A00000000', '000A000B0000')
  else
    ble.Unsubscribe('000A00000000', '000A000B0000');

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
  isScanning := false;
  time_start := Now;
end;

procedure TForm1.bleAdvertisement(Sender: TObject; const ServerId, Name: string; RSSI, TxPower: Integer;
  const ServiceUuids, ServicesWithData, SolicitedServiceUuids: string; ManufacturerCompanyId: Integer; const ManufacturerData: string;
  const ManufacturerDataB: TBytes; IsConnectable, IsScanResponse: Boolean);
var
  serverIdExists: Boolean;
  I: Integer;
begin
  // This method will check to see if the ServerID already exists. If it does not,
  // then display advertisement information for it.
  Log('Advertisement: ' + Name + ' RSSI: ' + RSSI.ToString + ' dBm' + ' ServerId: ' + ServerId);
  serverIdExists := false;
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
    lvAdvertisements.Items[lvAdvertisements.Items.Count - 1].Caption := ServerId;
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add(Name);
    lvAdvertisements.Items.Item[lvAdvertisements.Items.Count - 1].SubItems.Add(inttostr(RSSI));
  end

end;

procedure TForm1.bleConnected(Sender: TObject; StatusCode: Integer; const Description: string);
begin
  Log('On connected');
  ButtonConnect.Caption := 'Disconnect';
  ble_connected := true;
  ble.Discover('', '', true, '');
end;

procedure TForm1.bleDisconnected(Sender: TObject; StatusCode: Integer; const Description: string);
begin
  ble_connected := false;
  ButtonConnect.Caption := 'Connect';
  Log('On disconnect');
end;

procedure TForm1.bleDiscovered(Sender: TObject; GattType: Integer; const ServiceId, CharacteristicId, DescriptorId, Uuid, Description: string);
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

  Log('Discovered: ' + Description + ' UUID: ' + Uuid + ' ServiceId: ' + ServiceId + ' CharacteristicId: ' + CharacteristicId + ' DescriptorId: ' +
    DescriptorId);

end;

procedure TForm1.bleValue(Sender: TObject; const ServiceId, CharacteristicId, DescriptorId, Uuid, Description, Value: string; const ValueB: TBytes);
var
  light: Integer;
  move: SmallInt;
  light_state, move_state, sensor_state: Boolean;
  Time: TDateTime;
begin
  // Log('Value: ' + Value + ' UUID: ' + Uuid + ' ServiceId: ' + ServiceId +
  // ' CharacteristicId: ' + CharacteristicId + ' DescriptorId: ' +
  // DescriptorId);
  Log('Value: ' + TBytesToHex(ValueB));

  if ValueB[0] = $0D then
  begin
    // First two bytes is lighht
    light := SmallInt(ValueB[2] + ValueB[1] shl 8);
    light_state := ValueB[3] = 1;
    move := SmallInt(ValueB[5] + ValueB[4] shl 8);
    move_state := ValueB[6] = 1;
    sensor_state := ValueB[7] = 1;

    TThread.Synchronize(nil,
      procedure
      begin
        try
          LabeledEditLight.EditText := inttostr(light);
          LabeledEditMove.EditText := inttostr(move);

          if light_state then
            ShapeLightState.Brush.Color := clGreen
          else
            ShapeLightState.Brush.Color := clRed;

          if move_state then
            ShapeMoveState.Brush.Color := clGreen
          else
            ShapeMoveState.Brush.Color := clRed;

          if sensor_state then
            ShapeSensorState.Brush.Color := clGreen
          else
            ShapeSensorState.Brush.Color := clRed;

          // Plot data in real Time Plot
          Time := MilliSecondsBetween(Now, time_start) / 1000.0;

          Chart1.Series[0].AddXY(Time, light, '', clTeeColor);
          Chart1.Series[1].AddXY(Time, move, '', clTeeColor);

          // Ensure the chart only has 100 points
          while Chart1.Series[0].Count > 300 do
            Chart1.Series[0].Delete(0);
          while Chart1.Series[1].Count > 300 do
            Chart1.Series[1].Delete(0);

          // Refresh the chart to update the display
          Chart1.Refresh;

        except
          on E: Exception do
            Log('Error updating UI: ' + E.Message);
        end;
      end);
  end
  else if ValueB[0] = $BC then
  begin
    LOG('Send settiings');

    CheckBoxLightEnable.Checked := Boolean( ValueB[1] );
    CheckBoxLightInvert.Checked := Boolean( ValueB[4] );
    EditLightThreshold.Text := IntToStr( ValueB[3] + ValueB[2] shl 8);

    CheckBoxMoveEnable.Checked := Boolean( ValueB[5] );
    CheckBoxMoveInvert.Checked := Boolean( ValueB[8] );
    EditMoveThreshold.Text := IntToStr( ValueB[7] + ValueB[6] shl 8);

    ComboBoxOutFunction.ItemIndex := ValueB[9];
    CheckBoxOutInvert.Checked := Boolean( ValueB[10] );
    ComboBoxLedFunction.ItemIndex := ValueB[11];
    LabelFirmwareVersion.Caption := Format('Firmware version: %f', [ValueB[12] / 10.] );
  end;
end;


end.
