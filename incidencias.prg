#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE El Proceso "
#Define MSGTITULO "SISVEN"
Define Class Incidencia As Custom
	idusua=0
	idusuaa=0
	idauto=0
	idautop=0
	cdetalle=""
	Procedure GrabaIncidencia()
	lc='ProGrabaIncidencia'
	cur=""
	goapp.npara1=This.idusua
	goapp.npara2=This.idusuaa
	goapp.npara3=This.idautop
	goapp.npara4=This.idauto
	goapp.npara5=This.cdetalle
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Grabando Incidencia')
		Return 0
	Else
		Return  1
	Endif
	Endproc
	Procedure MostrarIncidencia(dfi,dff,cur)
	lc='ProMuestraIncidencia'
	goapp.npara1=dfi
	goapp.npara2=dff
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Mostrando Incidencias')
		Return 0
	Else
		Return  1
	Endif
	Endproc
	Procedure Limpiar()
	idusua=0
	idusuaa=0
	idauto=0
	idautop=0
	cdetalle=""
	Endproc
Enddefine
***************************************
