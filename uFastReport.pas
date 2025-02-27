unit uFastReport;

interface

Uses Winapi.Windows, Classes, System.TypInfo, System.SysUtils, System.JSON,
  System.StrUtils, frxClass, frxDMPExport, frxEngine, idsync,
  frxChBox, frxCross, frxChart, frxGradient, frxOLE, frxRich, frxBarcode,
  frxDesgn,vcl.forms;

Type
TFastReport = class(TPersistent)
 private
    frxDesigner1: TfrxDesigner;
    frxReport1: TfrxReport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxRichObject1: TfrxRichObject;
    frxOLEObject1: TfrxOLEObject;
    frxGradientObject1: TfrxGradientObject;
    frxChartObject1: TfrxChartObject;
    frxCrossObject1: TfrxCrossObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    fAFileLoad: string;
    fCopyCount: integer;
    fSelectPrinter: boolean;
    fPrinterName: string;


 public
   procedure PrintExecute;
   procedure AfterConstruction; override;
   destructor Destroy; Override;
 published
   property AFileLoad:string read fAFileLoad write fAFileLoad;
   property PrinterName:string read fPrinterName write fPrinterName;
   property CopyCount:integer read fCopyCount write fCopyCount;
   property SelectPrinter:boolean read fSelectPrinter write fSelectPrinter;
end;

implementation

uses
  frm_main;

{ TFastReport }

procedure TFastReport.AfterConstruction;
begin
  inherited;
  frxDesigner1:= TfrxDesigner.Create(frmMain);
  frxReport1:= TfrxReport.Create(frmMain);
  frxBarCodeObject1:= TfrxBarCodeObject.Create(frmMain);
  frxRichObject1:= TfrxRichObject.Create(frmMain);
  frxOLEObject1:=TfrxOLEObject.Create(frmMain);
  frxGradientObject1:= TfrxGradientObject.Create(frmMain);
  frxChartObject1:= TfrxChartObject.Create(frmMain);
  frxCrossObject1:= TfrxCrossObject.Create(frmMain);
  frxCheckBoxObject1:= TfrxCheckBoxObject.Create(frmMain);
  frxDotMatrixExport1:= TfrxDotMatrixExport.Create(frmMain);

  frxReport1.EngineOptions.ConvertNulls := True;
  frxReport1.EngineOptions.IgnoreDevByZero := true;
  frxReport1.PrintOptions.ShowDialog := true;
  frxReport1.ShowProgress := true;
end;

destructor TFastReport.Destroy;
begin
    frxDesigner1.free;
    frxReport1.free;
    frxBarCodeObject1.free;
    frxRichObject1.free;
    frxOLEObject1.free;
    frxGradientObject1.free;
    frxChartObject1.free;
    frxCrossObject1.free;
    frxCheckBoxObject1.free;
    frxDotMatrixExport1.free;
  inherited;
end;

procedure TFastReport.PrintExecute;
begin
  try

    frmMain.Show;
    frmMain.Left := -1000;

    try
      frxReport1.PreviewPages.LoadFromFile(AFileLoad);
      frxReport1.PrintOptions.Copies := CopyCount;

      if (Trim(PrinterName) <> '') or SelectPrinter then
      begin
        if SelectPrinter then
        begin
          frxReport1.PrintOptions.ShowDialog := True;
          frxReport1.PreviewPages.Print;
        end
        else
        begin
          frxReport1.PrintOptions.Printer := PrinterName;
          frxReport1.PrintOptions.ShowDialog := false;
          frxReport1.PreviewPages.Print;
        end;
      end
      else
      begin
        frxReport1.ShowPreparedReport;
      end;
    except
      on E: Exception do
      Begin
      End;
    end;
  finally
    frmMain.Hide;
  end;
end;



Initialization
 RegisterClass(TFastReport);

end.
