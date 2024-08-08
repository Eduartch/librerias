Set Default To c:\librerias\
Set Library To (Locfile("vfpconnection.fll","FLL"))
*? FTPGet("FTP://myusername:mypassword@mysite.com/mydir/myfile.zip", "C:\myfile.zip", "MyCommand()")
*? HTTPGet("http://www.mysite.com/mypage.htm", "C:\mypage.htm", "MyCommand()")
*? FILEGet("File://C:\MyFile.txt", "C:\MyFileCopy.txt", "MyCommand()")
? FTPPut("C:\librerias\file.zip", "FTP://factura:P455w0rd18?!@facturacionsysven.com/XML/file.zip", "MyCommand()")
*? FTPPut("C:\myfile.zip", "FTP://myusername:mypassword@mysite.com/mydir/myfile.zip", "MyCommand()")
*? HTTPPut("C:\mypage.htm", "http://www.mysite.com/mypage.htm", "MyCommand()")
*? FilePut("C:\myfile.zip", "File://C:\myfile.zip", "MyCommand()")
m.lcString1 = FTPToStr("FTP://myusername:mypassword@mysite.com/mydir/myfile.txt", "MyCommand()")
*m.lcString2 = HTTPToStr("http://www.mysite.com/mypage.htm", "MyCommand()")
Set Library To

Function MyCommand()
? nConnectTotalBytes
? nConnectBytesSoFar
Endfunc
