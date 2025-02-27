unit frm_main;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  StringBuilder,  IOUtils, System.RegularExpressions, System.Json,
  System.UITypes, Global, Vcl.ComCtrls, IniFiles, StrUtils,
  System.Generics.Collections, HttpResponse, Http, Vcl.Menus, System.ImageList,
  Vcl.ImgList, Printers, Vcl.Samples.Spin, uSettings, Vcl.AppEvnts;

type
  TfrmMain = class(TForm)
    mDebugMemo: TMemo;
    pnlBottom: TPanel;
    btnRequest: TButton;
    btnUpdate: TButton;
    ilIconListAnimate: TImageList;
    ilIconsListStatic: TImageList;
    tiTrayIcon: TTrayIcon;
    pmMenu: TPopupMenu;
    miClose: TMenuItem;
    tmRefreshTimer: TTimer;
    btnPrint: TButton;
    cbxLocalPrinters: TComboBox;
    seCopyCount: TSpinEdit;
    btnSaveSettings: TButton;
    miShow: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    pnlHidden: TPanel;
    procedure btnRequestClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure tmRefreshTimerTimer(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cbxLocalPrintersCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure seCopyCountChange(Sender: TObject);
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure miShowClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
  private
    slEquipment: TStringList;
    procedure FormHide;
    procedure UnlockThirdParty;
    procedure RefreshQueeStatus;
    function GetReportDocument: string;
    function SetFilesAsPrinted(aLocalPrinterID: string): string;
    function ReadPrintersList: TStringList;
    function GetPrinterHotFolderPath(sPrinterId: string): string;
    procedure CopyFiles(sFromPath, sToPath: string);
    procedure UpdateLocalPrinterList;
    procedure PrintLocalFile(aFilename: string; aCopyCount: integer; aPrinterIndex: integer);
    procedure InitializeStartup;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  slPrintersList: TStringList;
  slLocalPrintersList: TStringList;
  sLocalPrintersString: string;
  iPrinterIndex: integer;
  iCopyCount: integer;
  sEndpointServerPath: string;
  stSettings: TSettings;
  bCanClose: boolean;
const
  STATUS_INCOMPLETE = False;
  STATUS_COMPLETE = True;
  EQUIPMENT_FILE_NAME = 'equipmentList.el';

implementation

{$R *.dfm}

uses uConstants, frm_errors, uFastReport;

{ TfrmMain }

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  FormHide;
end;

procedure TfrmMain.btnPrintClick(Sender: TObject);
begin
  UpdateLocalPrinterList;
  PrintLocalFile('2025-02-20_21-38-01-681', 1, iPrinterIndex);
end;

procedure TfrmMain.btnRequestClick(Sender: TObject);
begin
  GetReportDocument;
end;

procedure TfrmMain.btnSaveSettingsClick(Sender: TObject);
begin
  stSettings.WriteSettingsToIni(PRINTER_SETTINGS_SECTION, PRINTER_INDEX, IntToStr(iPrinterIndex));
  stSettings.WriteSettingsToIni(PRINTER_SETTINGS_SECTION, DEFAULT_PRINTER_COPY_COUNT, IntToStr(iCopyCount));
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
begin
//
end;

procedure TfrmMain.cbxLocalPrintersCloseUp(Sender: TObject);
begin
  iPrinterIndex := cbxLocalPrinters.ItemIndex;
end;

procedure TfrmMain.CopyFiles(sFromPath, sToPath: string);
begin
  CopyFile(PChar(sFromPath), PChar(sToPath), False);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := bCanClose;
  FormHide;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitializeStartup;
end;

procedure TfrmMain.UpdateLocalPrinterList;
var
  i: integer;
begin
  for i:= 0 to Printer.Printers.Count - 1 do begin
    cbxLocalPrinters.Items.Add(Printer.Printers[i]);
  end;
end;

function TfrmMain.GetPrinterHotFolderPath(sPrinterId: string): string;
begin
  Result := Trim(slEquipment.Values[sPrinterId]);
end;

procedure TfrmMain.PrintLocalFile(aFilename: string; aCopyCount: integer; aPrinterIndex: integer);
var
  cReport: TFastReport;
begin
  cReport := nil;
  if (aPrinterIndex > 0) and (aPrinterIndex < Printer.Printers.Count) then begin
    try
      cReport := TFastReport.Create;
    with cReport do begin
      CopyCount := aCopyCount;
      PrinterName := cbxLocalPrinters.Items[aPrinterIndex];
      AFileLoad := aFilename;
    end;
    cReport.PrintExecute;
    finally
    if cReport <> nil then
      cReport.Free;
    end;
  end
  else
    ShowMessage('Принтер не найден');
end;

procedure TfrmMain.UnlockThirdParty;
var
  glob: HCkGlobal;
  success: Boolean;
  status: Integer;
begin
  glob := CkGlobal_Create();
  success := CkGlobal_UnlockBundle(glob, CHILKAT_UNLOCK);
if (success <> True) then
  begin
    mDebugMemo.Lines.Add(CkGlobal__lastErrorText(glob));
    Exit;
  end;
  status := CkGlobal_getUnlockStatus(glob);
  if (status = 2) then  begin
    mDebugMemo.Lines.Add('Unlocked using purchased unlock code.');
  end
else
  begin
    mDebugMemo.Lines.Add('Unlocked in trial mode.');
  end;
  mDebugMemo.Lines.Add(CkGlobal__lastErrorText(glob));
  CkGlobal_Dispose(glob);
end;

function TfrmMain.GetReportDocument: string;
var
  http: HCkHttp;
  i, iInitialArraySize: Integer;
  sResp, sResp_Database: string;
  JSON: TJSONObject;
  JSONArray: TJSONArray;
  JSONNestedObject: TJSONObject;
  sLinkId, sLink, sPrintID,
  sAppPath, sFilePathTo,
  sErrorMessage: string;
const
  TEXT_CHECK = '{"links":';
  LOCAL_PRINTER = 'lp';

begin
  sErrorMessage := '';
  http := CkHttp_Create();

  sResp := CkHttp__quickGetStr(http, PWideChar(sEndpointServerPath +
                               ENDPOINT_ACTION_GET + '/' +
                               ENDPOINT_CRED + '/'));

  if (CkHttp_getLastMethodSuccess(http) <> True) then begin
    mDebugMemo.Lines.Add(CkHttp__lastErrorText(http));
    Exit;
  end;

  if LeftStr(sResp, 9) =  TEXT_CHECK then begin
    JSON:=TJSONObject.Create;
    JSON.Parse(TEncoding.UTF8.GetBytes(sResp), 0);
    JSONArray := JSON.Values['links'].AsType < TJSONArray >;
    iInitialArraySize := JSONArray.Count;
    i := 0;
    while i < iInitialArraySize do begin

      tiTrayIcon.Icons := ilIconListAnimate;
      tiTrayIcon.IconIndex := 0;
      tiTrayIcon.Animate := True;

      JSONNestedObject := JSONArray.Items[i] As TJSONObject;
      sLinkId := JSONNestedObject.GetValue('quee_status_link', '');
      sLink := JSONNestedObject.GetValue('link', '');
      sPrintID := JSONNestedObject.GetValue('printerId', '');
      sResp_Database := '';
      if slPrintersList.IndexOf(sPrintID) <> -1 then begin
        sResp_Database := SetFilesAsPrinted(sLinkId);
        mDebugMemo.Lines.Add(sResp_Database);
        mDebugMemo.Lines.Add(sPrintID + #13#10 + sLink + #13#10 + sLinkId);
        if LeftStr(sPrintID, 2) =  LOCAL_PRINTER then begin
          sAppPath := ExpandFileName(ExtractFileDir(Application.ExeName) + '\');
          sAppPath := sAppPath + sPrintID + sLinkId + FormatDateTime('ddmmyyyyhhnnsszzz', Now);
          try
          CkHttp_Download(http, PWideChar(sLink), PWideChar(sAppPath));
          finally

          end;
          if (FileExists(sAppPath)) then begin
            PrintLocalFile(sAppPath, iCopyCount, iPrinterIndex);
            DeleteFile(sAppPath);
          end;
        end
        else begin
          sFilePathTo := GetPrinterHotFolderPath(sPrintID);
          if DirectoryExists(sFilePathTo) then
          if (FileExists(sLink)) then begin
            if (sFilePathTo[Length(sFilePathTo)] = '\') then
              sFilePathTo := sFilePathTo + ExtractFileName(sLink)
            else
              sFilePathTo := sFilePathTo + '\' + ExtractFileName(sLink);
            CopyFiles(sLink, sFilePathTo);
          end
          else begin
            if Trim(sErrorMessage) = '' then
              sErrorMessage := 'Проблема с файлом: ' + #13 + #10;
            sErrorMessage := sErrorMessage + ExtractFileName(sLink) + #13 + #10;
          end;
        end;
      end;
      Inc(i);
    end;
  end;
  Result := sErrorMessage;
  CkHttp_Dispose(http);
  FreeAndNil(JSON);
end;


procedure TfrmMain.FormHide;
begin
  Hide();
  WindowState := wsMinimized;
end;

procedure TfrmMain.InitializeStartup;
begin
  UnlockThirdParty;
  UpdateLocalPrinterList;
  stSettings := TSettings.Create;
  //stSettings.WriteSettingsToIni;
  stSettings.ReadSettingsFromIni;

  iCopyCount := stSettings.iDefaultCopyCount;
  seCopyCount.Value := iCopyCount;
  iPrinterIndex := stSettings.iPrinterID;
  cbxLocalPrinters.ItemIndex := iPrinterIndex;
  sEndpointServerPath := stSettings.sEndpointServer;
  sLocalPrintersString := stSettings.sLocalPrintersList;
  slPrintersList := ReadPrintersList;

  tmRefreshTimer.Enabled := True;
  slEquipment := TStringList.Create;
  if FileExists(ExtractFilePath(Application.ExeName) + '\' + EQUIPMENT_FILE_NAME) then
    slEquipment.LoadFromFile(EQUIPMENT_FILE_NAME);
  tiTrayIcon.Animate := False;
  tiTrayIcon.Icons := ilIconsListStatic;
  tiTrayIcon.IconIndex := 0;
  bCanClose := False;
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
  if MessageDlg('Остановить работу сервера печати?',
                 mtConfirmation, mbOKCancel, 0) = mrOk then begin
    bCanClose := True;
    Close;
  end;
end;

procedure TfrmMain.miShowClick(Sender: TObject);
begin
  frmMain.Show;
  frmMain.Left := 200;
end;

function TfrmMain.ReadPrintersList: TStringList;
begin
  Result := TStringList.Create;
  with Result do begin
    Sorted := True;
    DelimitedText := sLocalPrintersString;
  end;
end;

function TfrmMain.SetFilesAsPrinted(aLocalPrinterID: string): string;
var
  http: HCkHttp;
  sResp: string;
const
  TEXT_CHECK = 'Updated';
begin
  http := CkHttp_Create();
  sResp := CkHttp__quickGetStr(http, PWideChar(sEndpointServerPath +
                               ENDPOINT_ACTION_SET + '/' +
                               ENDPOINT_CRED + '/' + aLocalPrinterID));
  if (CkHttp_getLastMethodSuccess(http) <> True) then begin
    mDebugMemo.Lines.Add(CkHttp__lastErrorText(http));
    Exit;
  end;
  if LeftStr(sResp, 9) =  TEXT_CHECK then
    mDebugMemo.Lines.Add(sResp);
  CkHttp_Dispose(http);
end;




procedure TfrmMain.RefreshQueeStatus;
var
  sErrorMessage: string;
begin
  sErrorMessage := '';


  sErrorMessage := GetReportDocument;

  tiTrayIcon.Animate := False;
  tiTrayIcon.Icons := ilIconsListStatic;
  tiTrayIcon.IconIndex := 0;

  //sErrorMessage :='Test';

  if Trim(sErrorMessage) <> '' then begin
    frmErrors.SetErrorsText(sErrorMessage);
    frmErrors.ShowModal;
    if frmErrors.ModalResult = mrClose then
      Exit;
  end;

end;

procedure TfrmMain.seCopyCountChange(Sender: TObject);
begin
  iCopyCount := seCopyCount.Value;
end;

procedure TfrmMain.tmRefreshTimerTimer(Sender: TObject);
begin
  RefreshQueeStatus;
end;

end.
