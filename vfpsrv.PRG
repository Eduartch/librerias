LPARAMETERS parm1,parm2

CLEAR

* http://msdn.microsoft.com/library/default.asp?url=/library/en-us/tools/tools/service_control_utility.asp

* http://www.microsoft.com/msj/1097/WINNT.aspx

 

*To get SrvAny and SrvInst: go to http://www.microsoft.com/downloads, enter Windows 2003 Resource Kit Tools in the Keywords field, and click Go.

*Then, click the Windows Server 2003 Resource Kit Tools Download button at the Windows Server 2003 Resource Kit Tools

*Web page to download rktools.exe-which contains the most recent versions of Instsrv and Srvany-and run the executable to install the tools on your system.

 

 

#define TIMERINT  5     && # of seconds for timer interval. Also syncs to TIMERINT seconds for time of day

 

PUBLIC oService

oService=NEWOBJECT("vfpsrv")

oService.logstr("Starting Service: got some params: "+TRANSFORM(parm1)+" "+TRANSFORM(parm2))

IF _vfp.StartMode>0     && if we’re running as an EXE

      READ events       && message loop

ENDIF

 

*Create VFPSRVRTN.PRG that just beeps

SET TEXTMERGE TO vfpsrvrtn.prg

      \LPARAMETERS oTimer,oService

      \oService.logstr("")

      \Messagebeep(0)

SET TEXTMERGE TO

 

*RETURN

 

BUILD PROJECT vfpsrv from vfpsrv

MODIFY PROJECT vfpsrv nowait

STRTOFILE("screen=off"+CHR(13)+CHR(10),"config.fpw")  && to hide the VFP runtime desktop

_vfp.ActiveProject.Files.Add("config.fpw")

_vfp.ActiveProject.Close

BUILD EXE vfpsrv FROM vfpsrv

ERASE config.fpw

 

DEFINE CLASS vfpsrv AS form

      PROCEDURE Init

            this.logstr(CURDIR())

            DECLARE integer MessageBeep IN WIN32API integer

            this.AddObject("mytimer","mytimer")

            WITH this.mytimer

                  .enabled=.t.

                  .interval=1000    && start it in a sec

            ENDWITH

      PROCEDURE Destroy

            ?PROGRAM()

            MessageBeep(32)

      PROCEDURE logstr(str as String)

            str=TRANSFORM(DATETIME())+" "+str+CHR(13)+CHR(10)

            ??str

            STRTOFILE(str,"c:\vfpsrv.log",.t.)

ENDDEFINE

DEFINE CLASS mytimer AS timer

      PROCEDURE timer

            DO ("vfpsrvrtn" ) with this,oService

            CLEAR PROGRAM

            dtNow=DATETIME()  && read datetime() and seconds() close to the same instant

            nsec=SECONDS()

            nsec=CEILING((nsec+.5)/TIMERINT)*TIMERINT && target is # of seconds since midnight + a little for calculation time

            dtTarget=DTOT(DATE())+nsec

            this.interval=(dtTarget-dtNow) * 1000

 

ENDDEFINE

 