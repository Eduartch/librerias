ValidezCPE()
Procedure ValidezCPE()
    Local loIE ,lcURL,loDoc,loForm,loLista
    
    lcCaptcha = GetCodigoCaptcha()
    WAIT WINDOW "Aca"
    WAIT WINDOW lcCaptcha
    
TRY    
    lcURL = "http://www.sunat.gob.pe/ol-ti-itconsvalicpe/ConsValiCpe.htm"
   * *lcURL = "http://www.sunat.gob.pe/ol-ti-itreciboelectronico/cpelec003Alias?accion=LlamaValidez1"
    
    loIE = Createobject("InternetExplorer.Application")
    loIE.Navigate2(lcURL)
    Do While Not loIE.Busy
       Doevents 
    Enddo
    Pause(0.5)
    
    loIE.Visible = .t.
    loDoc = loIE.Document
    loForm = loDoc.forms(0)
    loForm.item(1).Value = "20103134065"
    loForm.item(2).Value = "03"
    loForm.item(3).Value = "6"
    loForm.item(3).Value = "-"
    loForm.item(4).Value = ""
    loForm.item(5).Value = "F011"
    loForm.item(6).Value = "194"
    loForm.item(7).Value = "29/11/2016"
    loForm.item(8).Value = "26815.76"
    loForm.item(9).Value = lcCaptcha
    
    loLista = loIE.Document.Lista
    loLista.accion.value = "CapturaCriterioValidez"
    
    loForm.accion.value = "CapturaCriterioValidez"
    *loForm.WAcepta.Disabled = .f.
    
        
    *loForm.item(9).Value = "JPCY"
    *loForm.submit()
    *loDoc.Submit()

Catch To loError
    MensajeError(loError)
Endtry     
    
Return
&&
Function GetCodigoCaptcha()
    ** Obtiene el codigo captcha
    Local lcURL,loCaptcha,lnIntento,lcCaptcha
    lcURL = "http://www.sunat.gob.pe/ol-ti-itconsvalicpe/captcha?accion=image"
    loCaptcha = NewObject("rucsunat","libsunat.vcx")

    ** 5 Intentos para leer correctamente captcha
    lnIntento = 0
    Do  While lnIntento<=5
        lnIntento = lnIntento + 1 
    
        If Not loCaptcha.Getimagen(lcURL) Then
           Pause(0.01)
           Loop 
        Endif 
    
        If Not loCaptcha.Gettexto() Then
           Pause(0.01)
           Loop
        Endif 
    Enddo     
    
    lcCaptcha = loCaptcha.lcTextoCaptcha
    
Return lcCaptcha