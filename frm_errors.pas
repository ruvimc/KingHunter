unit frm_errors;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmErrors = class(TForm)
    mErrors: TMemo;
  private
    { Private declarations }
  public
    procedure SetErrorsText(sErrorText: string);
  end;

var
  frmErrors: TfrmErrors;

implementation

{$R *.dfm}

{ TfrmErrors }

procedure TfrmErrors.SetErrorsText(sErrorText: string);
begin
  mErrors.Lines.Text := sErrorText;
end;

end.
