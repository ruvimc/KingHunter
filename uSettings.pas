unit uSettings;


interface

uses IniFiles, System.SysUtils, System.Variants,
  System.Classes, StrUtils,  Vcl.Forms;

type TSettings = class (TObject)
  public
   sEndpointServer: string;
   iPrinterID: integer;
   iDefaultCopyCount: integer;
   sLocalPrintersList: string;
   procedure ReadSettingsFromIni;
   procedure WriteSettingsToIni(sMainSection, sSubSection, sValue: string);
   procedure WriteDefaults;
end;

const
  INI_FILE_NAME = 'Settings.set';
  GLOBAL_SETTINGS_SECTION = 'Global';
  SERVER_SETTINGS_SECTION = 'Server';
  PRINTER_SETTINGS_SECTION = 'Printer';
  ENDPOINT_SERVER_PATH = 'EndpointServerName';
  PRINTER_INDEX = 'PrinterID';
  DEFAULT_PRINTER_COPY_COUNT = 'DefaultCopyCount';
  LOCAL_PRINTERS_ID_LIST_CSV = 'LocalPrintersIDsCSV';

implementation

{ TSettings }

procedure TSettings.ReadSettingsFromIni;
var
  ini: TIniFile;
  sAppPath: string;
begin
  sAppPath := ExpandFileName(ExtractFileDir(Application.ExeName) + '\');
  sAppPath := sAppPath + INI_FILE_NAME;
  ini := TIniFile.Create(sAppPath);
   try
     sEndpointServer := ini.ReadString(SERVER_SETTINGS_SECTION, ENDPOINT_SERVER_PATH, '');
     iPrinterID := StrToIntDef(ini.ReadString(PRINTER_SETTINGS_SECTION, PRINTER_INDEX, ''), 1);
     iDefaultCopyCount := StrToIntDef(ini.ReadString(PRINTER_SETTINGS_SECTION, DEFAULT_PRINTER_COPY_COUNT, ''), 1);
     sLocalPrintersList := ini.ReadString(PRINTER_SETTINGS_SECTION, LOCAL_PRINTERS_ID_LIST_CSV, '');
   finally
     ini.Free;
   end;
end;

procedure TSettings.WriteDefaults;
begin
  WriteSettingsToIni(SERVER_SETTINGS_SECTION, ENDPOINT_SERVER_PATH, 'https://stickerking.by/printserver/');
  WriteSettingsToIni(PRINTER_SETTINGS_SECTION, PRINTER_INDEX, '1');
  WriteSettingsToIni(PRINTER_SETTINGS_SECTION, DEFAULT_PRINTER_COPY_COUNT, '1');
  WriteSettingsToIni(PRINTER_SETTINGS_SECTION, LOCAL_PRINTERS_ID_LIST_CSV, 'lp1,lp2,lp3');
end;

procedure TSettings.WriteSettingsToIni(sMainSection, sSubSection, sValue: string);
var
  ini: TIniFile;
  sAppPath: string;
begin
  sAppPath := ExpandFileName(ExtractFileDir(Application.ExeName) + '\');
  sAppPath := sAppPath + INI_FILE_NAME;
  ini := TIniFile.Create(sAppPath);
   try
     ini.WriteString(sMainSection, sSubSection, sValue);
   finally
     ini.Free;
   end;
 end;

end.
