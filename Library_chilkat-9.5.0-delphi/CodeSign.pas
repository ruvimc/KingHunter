unit CodeSign;

interface

type

HCkCodeSign = Pointer;
HCkCert = Pointer;
HCkTask = Pointer;
HCkJsonObject = Pointer;
HCkString = Pointer;


// Note: The callback functions use the cdecl calling convention, while all other functions use stdcall.
TCodeSignAbortCheck = function(): Integer; cdecl;
TCodeSignProgressInfo = procedure(name: PWideChar; value: PWideChar); cdecl;
TCodeSignPercentDone = function(pctDone: Integer): Integer; cdecl;
TCodeSignTaskCompleted = procedure(task: HCkTask); cdecl;


function CkCodeSign_Create: HCkCodeSign; stdcall;
procedure CkCodeSign_Dispose(handle: HCkCodeSign); stdcall;

procedure CkCodeSign_SetAbortCheck(objHandle: HCkCodeSign; fn: TCodeSignAbortCheck) stdcall;
procedure CkCodeSign_SetProgressInfo(objHandle: HCkCodeSign; fn: TCodeSignProgressInfo) stdcall;
procedure CkCodeSign_SetPercentDone(objHandle: HCkCodeSign; fn: TCodeSignPercentDone) stdcall;
procedure CkCodeSign_SetTaskCompleted(objHandle: HCkCodeSign; fn: TCodeSignTaskCompleted) stdcall;
procedure CkCodeSign_getDebugLogFilePath(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

procedure CkCodeSign_putDebugLogFilePath(objHandle: HCkCodeSign; newPropVal: PWideChar); stdcall;

function CkCodeSign__debugLogFilePath(objHandle: HCkCodeSign): PWideChar; stdcall;

function CkCodeSign_getHeartbeatMs(objHandle: HCkCodeSign): Integer; stdcall;

procedure CkCodeSign_putHeartbeatMs(objHandle: HCkCodeSign; newPropVal: Integer); stdcall;

procedure CkCodeSign_getLastErrorHtml(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

function CkCodeSign__lastErrorHtml(objHandle: HCkCodeSign): PWideChar; stdcall;

procedure CkCodeSign_getLastErrorText(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

function CkCodeSign__lastErrorText(objHandle: HCkCodeSign): PWideChar; stdcall;

procedure CkCodeSign_getLastErrorXml(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

function CkCodeSign__lastErrorXml(objHandle: HCkCodeSign): PWideChar; stdcall;

function CkCodeSign_getLastMethodSuccess(objHandle: HCkCodeSign): wordbool; stdcall;

procedure CkCodeSign_putLastMethodSuccess(objHandle: HCkCodeSign; newPropVal: wordbool); stdcall;

procedure CkCodeSign_getUncommonOptions(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

procedure CkCodeSign_putUncommonOptions(objHandle: HCkCodeSign; newPropVal: PWideChar); stdcall;

function CkCodeSign__uncommonOptions(objHandle: HCkCodeSign): PWideChar; stdcall;

function CkCodeSign_getVerboseLogging(objHandle: HCkCodeSign): wordbool; stdcall;

procedure CkCodeSign_putVerboseLogging(objHandle: HCkCodeSign; newPropVal: wordbool); stdcall;

procedure CkCodeSign_getVersion(objHandle: HCkCodeSign; outPropVal: HCkString); stdcall;

function CkCodeSign__version(objHandle: HCkCodeSign): PWideChar; stdcall;

function CkCodeSign_AddSignature(objHandle: HCkCodeSign; path: PWideChar; cert: HCkCert; options: HCkJsonObject): wordbool; stdcall;

function CkCodeSign_AddSignatureAsync(objHandle: HCkCodeSign; path: PWideChar; cert: HCkCert; options: HCkJsonObject): HCkTask; stdcall;

function CkCodeSign_RemoveSignature(objHandle: HCkCodeSign; path: PWideChar): wordbool; stdcall;

function CkCodeSign_SaveLastError(objHandle: HCkCodeSign; path: PWideChar): wordbool; stdcall;

function CkCodeSign_VerifySignature(objHandle: HCkCodeSign; path: PWideChar; sigInfo: HCkJsonObject): wordbool; stdcall;

implementation

{$Include chilkatDllPath.inc}

function CkCodeSign_Create; external DLLName;
procedure CkCodeSign_Dispose; external DLLName;

procedure CkCodeSign_SetAbortCheck; external DLLName;
procedure CkCodeSign_SetProgressInfo; external DLLName;
procedure CkCodeSign_SetPercentDone; external DLLName;
procedure CkCodeSign_SetTaskCompleted; external DLLName;
procedure CkCodeSign_getDebugLogFilePath; external DLLName;
procedure CkCodeSign_putDebugLogFilePath; external DLLName;
function CkCodeSign__debugLogFilePath; external DLLName;
function CkCodeSign_getHeartbeatMs; external DLLName;
procedure CkCodeSign_putHeartbeatMs; external DLLName;
procedure CkCodeSign_getLastErrorHtml; external DLLName;
function CkCodeSign__lastErrorHtml; external DLLName;
procedure CkCodeSign_getLastErrorText; external DLLName;
function CkCodeSign__lastErrorText; external DLLName;
procedure CkCodeSign_getLastErrorXml; external DLLName;
function CkCodeSign__lastErrorXml; external DLLName;
function CkCodeSign_getLastMethodSuccess; external DLLName;
procedure CkCodeSign_putLastMethodSuccess; external DLLName;
procedure CkCodeSign_getUncommonOptions; external DLLName;
procedure CkCodeSign_putUncommonOptions; external DLLName;
function CkCodeSign__uncommonOptions; external DLLName;
function CkCodeSign_getVerboseLogging; external DLLName;
procedure CkCodeSign_putVerboseLogging; external DLLName;
procedure CkCodeSign_getVersion; external DLLName;
function CkCodeSign__version; external DLLName;
function CkCodeSign_AddSignature; external DLLName;
function CkCodeSign_AddSignatureAsync; external DLLName;
function CkCodeSign_RemoveSignature; external DLLName;
function CkCodeSign_SaveLastError; external DLLName;
function CkCodeSign_VerifySignature; external DLLName;



end.
