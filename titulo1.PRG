PUBLIC oform1

oform1=NEWOBJECT("form1")
oform1.Show
RETURN


DEFINE CLASS form1 AS form


    Top = 114
    Left = 197
    DoCreate = .T.
    Caption = "Form1"
    l = .F.


    ADD OBJECT command1 AS commandbutton WITH ;
        AutoSize = .T., ;
        Top = 24, ;
        Left = 96, ;
        Height = 27, ;
        Width = 208, ;
        Caption = "Changer la couleur de la barre titre", ;
        Name = "Command1"


    ADD OBJECT command2 AS commandbutton WITH ;
        AutoSize = .T., ;
        Top = 78, ;
        Left = 110, ;
        Height = 27, ;
        Width = 181, ;
        Caption = "Remmettre la couleur original", ;
        Name = "Command2"


    PROCEDURE changerlacouleurdelabarredetitre
        LPARAMETERS NewColor
        #DEFINE COLOR_ACTIVECAPTION  2
        Local lRet
        lRet = SetSysColors(1, COLOR_ACTIVECAPTION, NewColor)
        ChangeTitleBarColor = lRet > 0
    ENDPROC


    PROCEDURE trouverlacouleur
        GetTitleBarColor1 = GetSysColor(COLOR_ACTIVECAPTION)
        Return GetTitleBarColor1
    ENDPROC


    PROCEDURE Load
        DECLARE INTEGER GetSysColor IN user32 INTEGER nIndex 
        DECLARE INTEGER SetSysColors IN user32; 
            INTEGER nChanges,; 
            INTEGER @ lpSysColor,; 
            INTEGER @ lpColorValues  
         
    ENDPROC


    PROCEDURE command1.Click
        thisform.l = thisform.trouverlacouleur()
        thisform.changerlacouleurdelabarredetitre(RGB(255, 0, 0))
    ENDPROC


    PROCEDURE command2.Click
        thisform.changerlacouleurdelabarredetitre(thisform.l)
    ENDPROC


ENDDEFINE