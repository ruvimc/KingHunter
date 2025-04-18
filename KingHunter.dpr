program KingHunter;

uses
  Vcl.Forms,
  frm_main in 'frm_main.pas' {frmMain},
  uConstants in 'uConstants.pas',
  Asn in 'Library_chilkat-9.5.0-delphi\Asn.pas',
  Atom in 'Library_chilkat-9.5.0-delphi\Atom.pas',
  AuthAws in 'Library_chilkat-9.5.0-delphi\AuthAws.pas',
  AuthAzureAD in 'Library_chilkat-9.5.0-delphi\AuthAzureAD.pas',
  AuthAzureSAS in 'Library_chilkat-9.5.0-delphi\AuthAzureSAS.pas',
  AuthAzureStorage in 'Library_chilkat-9.5.0-delphi\AuthAzureStorage.pas',
  AuthGoogle in 'Library_chilkat-9.5.0-delphi\AuthGoogle.pas',
  AuthUtil in 'Library_chilkat-9.5.0-delphi\AuthUtil.pas',
  BinData in 'Library_chilkat-9.5.0-delphi\BinData.pas',
  Bounce in 'Library_chilkat-9.5.0-delphi\Bounce.pas',
  Bz2 in 'Library_chilkat-9.5.0-delphi\Bz2.pas',
  Cache in 'Library_chilkat-9.5.0-delphi\Cache.pas',
  Cert in 'Library_chilkat-9.5.0-delphi\Cert.pas',
  CertChain in 'Library_chilkat-9.5.0-delphi\CertChain.pas',
  CertStore in 'Library_chilkat-9.5.0-delphi\CertStore.pas',
  Cgi in 'Library_chilkat-9.5.0-delphi\Cgi.pas',
  Charset in 'Library_chilkat-9.5.0-delphi\Charset.pas',
  CkByteData in 'Library_chilkat-9.5.0-delphi\CkByteData.pas',
  CkDateTime in 'Library_chilkat-9.5.0-delphi\CkDateTime.pas',
  CkString in 'Library_chilkat-9.5.0-delphi\CkString.pas',
  CodeSign in 'Library_chilkat-9.5.0-delphi\CodeSign.pas',
  Compression in 'Library_chilkat-9.5.0-delphi\Compression.pas',
  CreateCS in 'Library_chilkat-9.5.0-delphi\CreateCS.pas',
  Crypt2 in 'Library_chilkat-9.5.0-delphi\Crypt2.pas',
  Csp in 'Library_chilkat-9.5.0-delphi\Csp.pas',
  Csr in 'Library_chilkat-9.5.0-delphi\Csr.pas',
  Csv in 'Library_chilkat-9.5.0-delphi\Csv.pas',
  Dh in 'Library_chilkat-9.5.0-delphi\Dh.pas',
  DirTree in 'Library_chilkat-9.5.0-delphi\DirTree.pas',
  Dkim in 'Library_chilkat-9.5.0-delphi\Dkim.pas',
  Dns in 'Library_chilkat-9.5.0-delphi\Dns.pas',
  Dsa in 'Library_chilkat-9.5.0-delphi\Dsa.pas',
  DtObj in 'Library_chilkat-9.5.0-delphi\DtObj.pas',
  Ecc in 'Library_chilkat-9.5.0-delphi\Ecc.pas',
  EdDSA in 'Library_chilkat-9.5.0-delphi\EdDSA.pas',
  Email in 'Library_chilkat-9.5.0-delphi\Email.pas',
  EmailBundle in 'Library_chilkat-9.5.0-delphi\EmailBundle.pas',
  FileAccess in 'Library_chilkat-9.5.0-delphi\FileAccess.pas',
  Ftp2 in 'Library_chilkat-9.5.0-delphi\Ftp2.pas',
  Global in 'Library_chilkat-9.5.0-delphi\Global.pas',
  Gzip in 'Library_chilkat-9.5.0-delphi\Gzip.pas',
  Hashtable in 'Library_chilkat-9.5.0-delphi\Hashtable.pas',
  HtmlToText in 'Library_chilkat-9.5.0-delphi\HtmlToText.pas',
  HtmlToXml in 'Library_chilkat-9.5.0-delphi\HtmlToXml.pas',
  Http in 'Library_chilkat-9.5.0-delphi\Http.pas',
  HttpRequest in 'Library_chilkat-9.5.0-delphi\HttpRequest.pas',
  HttpResponse in 'Library_chilkat-9.5.0-delphi\HttpResponse.pas',
  Imap in 'Library_chilkat-9.5.0-delphi\Imap.pas',
  JavaKeyStore in 'Library_chilkat-9.5.0-delphi\JavaKeyStore.pas',
  JsonArray in 'Library_chilkat-9.5.0-delphi\JsonArray.pas',
  JsonObject in 'Library_chilkat-9.5.0-delphi\JsonObject.pas',
  Jwe in 'Library_chilkat-9.5.0-delphi\Jwe.pas',
  Jws in 'Library_chilkat-9.5.0-delphi\Jws.pas',
  Jwt in 'Library_chilkat-9.5.0-delphi\Jwt.pas',
  KeyContainer in 'Library_chilkat-9.5.0-delphi\KeyContainer.pas',
  Log in 'Library_chilkat-9.5.0-delphi\Log.pas',
  Mailboxes in 'Library_chilkat-9.5.0-delphi\Mailboxes.pas',
  MailMan in 'Library_chilkat-9.5.0-delphi\MailMan.pas',
  MessageSet in 'Library_chilkat-9.5.0-delphi\MessageSet.pas',
  Mht in 'Library_chilkat-9.5.0-delphi\Mht.pas',
  Mime in 'Library_chilkat-9.5.0-delphi\Mime.pas',
  Ntlm in 'Library_chilkat-9.5.0-delphi\Ntlm.pas',
  OAuth1 in 'Library_chilkat-9.5.0-delphi\OAuth1.pas',
  OAuth2 in 'Library_chilkat-9.5.0-delphi\OAuth2.pas',
  Pdf in 'Library_chilkat-9.5.0-delphi\Pdf.pas',
  Pem in 'Library_chilkat-9.5.0-delphi\Pem.pas',
  Pfx in 'Library_chilkat-9.5.0-delphi\Pfx.pas',
  Pkcs11 in 'Library_chilkat-9.5.0-delphi\Pkcs11.pas',
  PrivateKey in 'Library_chilkat-9.5.0-delphi\PrivateKey.pas',
  Prng in 'Library_chilkat-9.5.0-delphi\Prng.pas',
  PublicKey in 'Library_chilkat-9.5.0-delphi\PublicKey.pas',
  Rest in 'Library_chilkat-9.5.0-delphi\Rest.pas',
  Rsa in 'Library_chilkat-9.5.0-delphi\Rsa.pas',
  Rss in 'Library_chilkat-9.5.0-delphi\Rss.pas',
  SCard in 'Library_chilkat-9.5.0-delphi\SCard.pas',
  ScMinidriver in 'Library_chilkat-9.5.0-delphi\ScMinidriver.pas',
  Scp in 'Library_chilkat-9.5.0-delphi\Scp.pas',
  SecureString in 'Library_chilkat-9.5.0-delphi\SecureString.pas',
  ServerSentEvent in 'Library_chilkat-9.5.0-delphi\ServerSentEvent.pas',
  SFtp in 'Library_chilkat-9.5.0-delphi\SFtp.pas',
  SFtpDir in 'Library_chilkat-9.5.0-delphi\SFtpDir.pas',
  SFtpFile in 'Library_chilkat-9.5.0-delphi\SFtpFile.pas',
  Socket in 'Library_chilkat-9.5.0-delphi\Socket.pas',
  Spider in 'Library_chilkat-9.5.0-delphi\Spider.pas',
  Ssh in 'Library_chilkat-9.5.0-delphi\Ssh.pas',
  SshKey in 'Library_chilkat-9.5.0-delphi\SshKey.pas',
  SshTunnel in 'Library_chilkat-9.5.0-delphi\SshTunnel.pas',
  Stream in 'Library_chilkat-9.5.0-delphi\Stream.pas',
  StringArray in 'Library_chilkat-9.5.0-delphi\StringArray.pas',
  StringBuilder in 'Library_chilkat-9.5.0-delphi\StringBuilder.pas',
  StringTable in 'Library_chilkat-9.5.0-delphi\StringTable.pas',
  Tar in 'Library_chilkat-9.5.0-delphi\Tar.pas',
  Task in 'Library_chilkat-9.5.0-delphi\Task.pas',
  TaskChain in 'Library_chilkat-9.5.0-delphi\TaskChain.pas',
  TrustedRoots in 'Library_chilkat-9.5.0-delphi\TrustedRoots.pas',
  UnixCompress in 'Library_chilkat-9.5.0-delphi\UnixCompress.pas',
  Upload in 'Library_chilkat-9.5.0-delphi\Upload.pas',
  Url in 'Library_chilkat-9.5.0-delphi\Url.pas',
  WebSocket in 'Library_chilkat-9.5.0-delphi\WebSocket.pas',
  Xml in 'Library_chilkat-9.5.0-delphi\Xml.pas',
  XmlCertVault in 'Library_chilkat-9.5.0-delphi\XmlCertVault.pas',
  XmlDSig in 'Library_chilkat-9.5.0-delphi\XmlDSig.pas',
  XmlDSigGen in 'Library_chilkat-9.5.0-delphi\XmlDSigGen.pas',
  Xmp in 'Library_chilkat-9.5.0-delphi\Xmp.pas',
  Zip in 'Library_chilkat-9.5.0-delphi\Zip.pas',
  ZipCrc in 'Library_chilkat-9.5.0-delphi\ZipCrc.pas',
  ZipEntry in 'Library_chilkat-9.5.0-delphi\ZipEntry.pas',
  frm_errors in 'frm_errors.pas' {frmErrors},
  uFastReport in 'uFastReport.pas',
  uSettings in 'uSettings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmErrors, frmErrors);  
  Application.ShowMainForm := False;
  Application.Run;
end.
