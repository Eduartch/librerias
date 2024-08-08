Close All
Set Talk Off
Set Delete On
Set Century To 19
Set Exclusive Off
Set Safety Off
Set Optimize On
Set Date To Dmy
Set Century On
#Define MSGTITULO      "SISVEN"
Release goApp
Public goApp
goApp = Createobject("empty")
AddProperty(goApp,'Grabarxmlbd','S')
AddProperty(goApp,'cdatos',"")
AddProperty(goApp,'tienda',1)
AddProperty(goApp,'ose',"")
AddProperty(goApp,"vtascondetraccion","")
AddProperty(goApp,"tipoh","P")
AddProperty(goApp,"tipoh","P")
AddProperty(goApp,"xopcion",1)
SET CLASSLIB TO d:\librerias\clasesvisuales.vcx ADDITIVE
o=CREATEOBJECT("conectar")
oconn = o.ejecutar
wait WINDOW 'hola'
wait WINDOW oconn
RETURN 


