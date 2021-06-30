;estas son las funciones de MCY downloader:
;**por favor no tocar este archivo en caso de que no tengas conocimientos sobre programaci�n o cosas t�cnicas.
;This is the functions off MCY downloader.
;**please do not touch this file in case you do not have knowledge about programming or technical things.
;Function wen the program is not compiled for use. Funci�n cuando el programa no est� compilado para su uso.
Func NotCompiled()
;If the program is not compiled, it plays the sound along with the following message: Si el programa no est� compilado, reproduce el sonido junto con el siguiente mensaje:
If @Compiled Then
selector()
Else
$errorsound = $device.opensound ("sounds/soundsdata.dat/error_not_comp.ogg", true)
$errorsound.play
;Esperemos un segundo y medio. Let's wait a second and a half.
sleep(1000)
;Muestra el mensage de error. Show error message.
MsgBox($MB_SYSTEMMODAL, "", "You have to compile this program first to run it. Then the program will close now.")
writeinlog("The program is not compiled... Exiting.")
exitpersonaliced()
EndIf
EndFunc
;Esta es la funci�n para dar soporte a la interfaz de MCY Downloader. Vamos a crear una ventana. This is the function to support the MCY Downloader interface. We are going to create a window.
Func Menuprogram()
Local $sDefaultstatus = "Ready"
;Creamos la ventana. We create the window.
$PROGRAMGUI = GUICreate("MCY Downloader", 500, 500)
;Establecemos el atajo de teclado para escuchar la ayuda en audio. We set the keyboard shortcut to listen to the audio help.
HotKeySet("{F1}", "playhelp")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
;Ahora crearemos los men�s junto a sus respectivas opciones. Now we will create the menus along with their respective options.
;A�adimos el soporte de multiidioma. We add multi-language support.
select
case $grlanguage ="es"
Local $idDownload = GUICtrlCreateMenu("&MCY")
Local $idDownloaditem = GUICtrlCreateMenuItem("Descargar multimedia, listas de reproducci�n y m�s...", $idDownload)
Local $idOptionsitem = GUICtrlCreateMenuItem("Opciones...", $idDownload)
Local $idChanges = GUICtrlCreateMenuItem("Cambios", $idDownload)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
Local $idTSmenu = GUICtrlCreateMenu("Herramientas")
Local $idRadioitem = GUICtrlCreateMenuItem("Radio", $idTSmenu)
Local $idconvitem = GUICtrlCreateMenuItem("Convertir archivos...", $idTSmenu)
Local $idURLitem = GUICtrlCreateMenuItem("Reproducir muestra de audio en l�nea", $idTSmenu)
Local $idHelpmenu = GUICtrlCreateMenu("Ayuda")
Local $idErrorreporting = GUICtrlCreateMenuItem("Reportero de errores...", $idHelpmenu)
Local $idCheckupdates = GUICtrlCreateMenuItem("Buscar actualizaciones...", $idHelpmenu)
Local $idHelpitema = GUICtrlCreateMenuItem("Acerca de...", $idHelpmenu)
Local $idHelpitemb = GUICtrlCreateMenuItem("&Visitar sitio web", $idHelpmenu)
Local $idHelpitemc = GUICtrlCreateMenuItem("&Manual de usuario", $idHelpmenu)
Local $idExititem = GUICtrlCreateMenuItem("&Salir", $idDownload)
GUICtrlCreateMenuItem("", $idDownload, 2)
case $grlanguage ="eng"
Local $idDownload = GUICtrlCreateMenu("&MCY")
Local $idDownloaditem = GUICtrlCreateMenuItem("download multimedia, playlist and more...", $idDownload)
Local $idOptionsitem = GUICtrlCreateMenuItem("Options...", $idDownload)
Local $idChanges = GUICtrlCreateMenuItem("Changes", $idDownload)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
Local $idTSmenu = GUICtrlCreateMenu("Tools")
Local $idRadioitem = GUICtrlCreateMenuItem("Radio", $idTSmenu)
Local $idconvitem = GUICtrlCreateMenuItem("Convert files...", $idTSmenu)
Local $idURLitem = GUICtrlCreateMenuItem("Play audio URL online", $idTSmenu)
Local $idHelpmenu = GUICtrlCreateMenu("help")
Local $idErrorreporting = GUICtrlCreateMenuItem("Bug Reporter...", $idHelpmenu)
Local $idCheckupdates = GUICtrlCreateMenuItem("Check for updates...", $idHelpmenu)
Local $idHelpitema = GUICtrlCreateMenuItem("About", $idHelpmenu)
Local $idHelpitemb = GUICtrlCreateMenuItem("&Visit website", $idHelpmenu)
Local $idHelpitemc = GUICtrlCreateMenuItem("&User manual", $idHelpmenu)
Local $idExititem = GUICtrlCreateMenuItem("E&xit", $idDownload)
GUICtrlCreateMenuItem("", $idDownload, 2)
endselect
GUICtrlSetState(-1, $GUI_CHECKED)
;Crear una etiqueta de texto. Creates a text label.
;Nota: Todo esto ahora aplica la detecci�n de idioma. Note: All of this now applies language detection.
select
case $grlanguage ="es"
GUICtrlCreateLabel("Pulsa alt para abrir el men�.",0,100,20,20,$WS_TABSTOP)
case $grlanguage ="eng"
GUICtrlCreateLabel("Press alt to open the menu.", 0,100,20,20,$WS_TABSTOP)
endselect
GUICtrlSetState(-1, $GUI_FOCUS)
;Bot�n de salir. Exit button.
select
case $grlanguage ="es"
Local $idExitbutton = GUICtrlCreateButton("&Salir", 120, 100, 20, 20)
case $grlanguage ="eng"
Local $idExitbutton = GUICtrlCreateButton("E&xit", 120, 100, 20, 20)
endselect
Local $idStatuslabel = GUICtrlCreateLabel($sDefaultstatus, 0, 165, 300, 16, BitOR($SS_SIMPLE, $SS_SUNKEN))
GUISetState(@SW_SHOW)
;Ahora vamos a darle m�s sentido a cada opci�n del men�, especialmente la elegida por el usuario. Now we are going to give more meaning to each menu option, especially the one chosen by the user.
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $idDownloaditem
GUIDelete($PROGRAMGUI)
$idDownloaditem = Imputdownload()
writeinlog("Function: download in mp3...")
case $idRadioitem
Radio()
case $idConvitem
mp3Converter()
case $idURLitem
ReproducirURL()
case $idOptionsitem 
writeinlog("Function: options")
sleep(250)
If $ReadAccs ="yes" Then
$optionsitem = menu_options()
Else
$optionsitem = menu_options2()
EndIf
case $idChanges 
If $ReadAccs ="yes" Then
$changes = readchanges()
Else
$changes = readchanges2()
EndIf
Case $idErrorreporting
writeinlog("Function: Bug_Reporter_Tool")
$mainlanguage = iniRead ("config\config.st", "General settings", "language", "")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
select
case $mainlanguage ="es"
$mensaje=InputBox("Reportar un error...", "Cu�ntanos en este cuadro qu� es lo que deseas reportar o sugerirnos:", "", " M2000")
if $mensaje="" then
$mensaje="Este mensaje est� en blanco..."
endif
$yourname=InputBox("tu nombre", "escribe tu nombre en este campo a continuaci�n:", "")
if $yourname="" then
$yourname="Alguien sin identificarse"
endif
$combo=InputBox("Correo Electr�nico, opcional", "Escribe tu correo electr�nico en caso de que necesitemos ponernos en contacto contigo.", "")
if $combo="" then
$combo="No se ha especificado."
endif
$correo="Correo electr�nico: " (&$combo)
case $mainlanguage ="eng"
$mensaje=InputBox("Report a bug...", "Tell us in this box what you want to report or suggest:", "")
if $mensaje="" then
$mensaje="This message is blank ..."
endif
$yourname=InputBox("Your name", "write your name in this field below:", "", " M2000")
if $yourname="" then
$yourname="Someone unidentified"
endif
$correo="Email: " (&$combo)
$combo=InputBox("Email, optional", "Write your email in case we need to contact you.", "")
if $combo="" then
$combo="Not specified."
endif
endselect
$program="MCY Downloader, "
$SmtpServer = "smtp.gmail.com"              ; address for the smtp-server to use - REQUIRED
select
case $mainlanguage ="es"
$FromName = "Reportero de errores"                      ; name from who the email was sent
case $mainlanguage ="eng"
$FromName = "Bug reporter"                      ; name from who the email was sent
endselect
$FromAddress = "reporterodeerrores@gmail.com" ; address from where the mail should come
$ToAddress = "angelitomateocedillo@gmail.com"   ; destination address of the email - REQUIRED
select
case $mainlanguage ="es"
$Su1=" nos ha enbiado un reporte de error"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
case $mainlanguage ="eng"
$Su1=" You have sent us an error report"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
endselect
select
case $mainlanguage ="es"
$gr="Gracias, el reportero de errores."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                             ; the messagebody from the mail - can be left blank but then you get a blank mail
case $mainlanguage ="eng"
$gr="Thanks, the bug reporter."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                              ; the messagebody from the mail - can be left blank but then you get a blank mail
endselect
$AttachFiles = "logs.dat"                       ; the file(s) you want to attach seperated with a ; (Semicolon) - leave blank if not needed
$CcAddress = ""       ; address for cc - leave blank if not needed
$BccAddress = ""     ; address for bcc - leave blank if not needed
$Importance = "High"                  ; Send message priority: "High", "Normal", "Low"
$Username = "Reporterodeerrores"                    ; username for the account used from where the mail gets sent - REQUIRED
$Password = "superpollo1234567890"                  ; password for the account used from where the mail gets sent - REQUIRED
$IPPort = 465                            ; port used for sending the mail
$ssl = 1                                ; enables/disables secure socket layer sending - put to 1 if using httpS
;~ $IPPort=465                          ; GMAIL port used for sending the mail
;~ $ssl=1                               ; GMAILenables/disables secure socket layer sending - put to 1 if using httpS
sendLog(".log", "logs.dat")
sleep(2500)
if @error then
MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Error", "Could not send. reason:" &@error)
exitpersonaliced()
endif
_SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
sleep(1000)
FileDelete("logs.dat")
case $idCheckupdates
writeinlog("Checking components...")
GUIDelete($PROGRAMGUI)
$idCheckupdates = updcomponents()
Case $GUI_EVENT_CLOSE, $idExitbutton, $idExititem
exitpersonaliced()
Case $idHelpitema
;$idHelpitema = aboutdialog()
;Este es el di�logo de acerca del programa en el que se mostrar� en pantalla, idiomas espa�ol e ingl�s. This is the dialogue about the program in which it will be shown on the screen, Spanish and English languages.
select
case $grlanguage ="es"
MsgBox(0, "Acerca de...", "MCY downloader versi�n 0.8.1 beta. Programa desarrollado por mateo cedillo para descargar videos a trav�s de Youtube. 2018-2021 MT programs.")
case $grlanguage ="eng"
MsgBox($MB_SYSTEMMODAL, "About", "MCY downloader version 0.8.1 beta. Program developed by mateo cedillo to download videos through Youtube. 2018-2021 MT programs.")
endselect
continueLoop
case $idHelpitemb
ShellExecute("http://mateocedillo.260mb.net/")
writeinlog("Visited website &$numViews times")
case $idHelpitemc
writeinlog("Exec function: User manual.")
playhelp()
EndSwitch
WEnd
GUIDelete()
EndFunc
;Esta es la funci�n para el reportero de errores, en las que podr�s hacer tus sugerencias y/o reportar algo. Por razones t�cnicas el reportero de errores se ejecuta en otro archivo aparte de este script. This is the function for the bug reporter, in which you can make your suggestions and / or report something. For technical reasons the bug reporter runs in a file other than this script.
Func _SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
Global $oMyRet[2]
Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$rc = _INetSmtpMailCom($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
If @error Then
MsgBox(0, "Error sending message", "Error code:" & @error & "  Description:" & $rc)
EndIf
endfunc
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Importance="Normal", $s_Username = "", $s_Password = "", $IPPort = 465, $ssl = 1)
    Local $objEmail = ObjCreate("CDO.Message")
    $objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
    $objEmail.To = $s_ToAddress
    Local $i_Error = 0
    Local $i_Error_desciption = ""
    If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
    If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
    $objEmail.Subject = $s_Subject
    If StringInStr($as_Body, "<") And StringInStr($as_Body, ">") Then
        $objEmail.HTMLBody = $as_Body
    Else
        $objEmail.Textbody = $as_Body & @CRLF
    EndIf
    If $s_AttachFiles <> "" Then
        Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
        For $x = 1 To $S_Files2Attach[0]
            $S_Files2Attach[$x] = _PathFull($S_Files2Attach[$x])
;~          ConsoleWrite('@@ Debug : $S_Files2Attach[$x] = ' & $S_Files2Attach[$x] & @LF & '>Error code: ' & @error & @LF) ;### Debug Console
            If FileExists($S_Files2Attach[$x]) Then
                ConsoleWrite('+> File attachment added: ' & $S_Files2Attach[$x] & @LF)
                $objEmail.AddAttachment($S_Files2Attach[$x])
            Else
                ConsoleWrite('!> File not found to attach: ' & $S_Files2Attach[$x] & @LF)
                SetError(1)
                Return 0
            EndIf
        Next
    EndIf
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
    If Number($IPPort) = 0 then $IPPort = 25
    $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
    ;Authenticated SMTP
    If $s_Username <> "" Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
    EndIf
    If $ssl Then
        $objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
    EndIf
    ;Update settings
    $objEmail.Configuration.Fields.Update
    ; Set Email Importance
    Switch $s_Importance
        Case "High"
            $objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "High"
        Case "Normal"
            $objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Normal"
        Case "Low"
            $objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Low"
    EndSwitch
    $objEmail.Fields.Update
    ; Sent the Message
    $objEmail.Send
    If @error Then
        SetError(2)
        Return $oMyRet[1]
    EndIf
    $objEmail=""
EndFunc   ;==>_INetSmtpMailCom
Func MyErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
    $oMyRet[0] = $HexNumber
    $oMyRet[1] = StringStripWS($oMyError.description, 3)
    ConsoleWrite("### COM Error !  Number: " & $HexNumber & "   ScriptLine: " & $oMyError.scriptline & "   Description:" & $oMyRet[1] & @LF)
    SetError(1); something to check for when this function returns
    Return
EndFunc   ;==>MyErrFunc
func playhelp()
select
case $grlanguage ="es"
Local $manualdoc = "documentation\manual1.txt"
$editmessage1="Manual del usuario."
$editmessage2="No se encuentra el archivo."
$editmessage3="abriendo..."
$editmessage4="Ocurri� un error al leer el archivo."
$editmessage5="error"
case $grlanguage ="eng"
Local $manualdoc = "documentation\manual2.txt"
$editmessage1="User manual."
$editmessage2="The file cannot be found."
$editmessage3="opening..."
$editmessage4="An error occurred while reading the file."
$editmessage5="error"
endSelect
Local $DocOpen = FileOpen($manualdoc, $FO_READ)
ToolTip($editmessage3)
speaking($editmessage3)
sleep(200)
If $DocOpen = -1 Then
MsgBox($MB_SYSTEMMODAL, $editmessage5, $editmessage4)
Return False
EndIf
Local $openned = FileRead($DocOpen)
$manualwindow = GUICreate($manualdoc)
Local $idMyedit = GUICtrlCreateEdit($openned, 8, 92, 121, 97, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $WS_VSCROLL, $WS_VSCROLL, $WS_CLIPSIBLINGS))
GUISetState(@SW_SHOW)
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
FileClose($DocOpen)
ExitLoop
EndSwitch
WEnd
GUIDelete()
EndFunc
Func ReproducirURL()
global $ENlace = inputBox("Enter URL", "Please enter the direct multimedia link you want to play.")
if $enlace = "" then
MSGBox(48, "Error", "There is no URL!"
Else
PlayDirectAudioURL($ENlace)
EndIf
EndFunc
func menu_options()
;Esta opci�n es para a�adir el men� de opciones del programa, donde puedes configurar todo a tu manera.
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
$download_dir = iniRead ("config\config.st", "General settings", "Destination folder", "")
select
case $download_dir =""
$download_dir="C:\MCY\Download\Audio"
endSelect
select
case $slanguage ="es"
$omenu_Message="Men� de opciones. Usa flechas arriba y avajo para ir a ellas, y enter para ejecutar una acci�n."
$omensaje0="Men� de opciones"
$omensaje1 = "Seleccionar calidad de mp3."
$omensaje1a="por favor selecciona:"
$omensaje2="Cambiar carpeta de descargas Actualmente " &$download_dir
$omensaje2a="Selecciona la carpeta de destino:"
$omensaje3="Cambiar idioma Idioma actual: " & $sLanguage
$omensaje4="Activar o desactivar accesibilidad mejorada."
$omensaje5="si"
$omensaje6="no"
$omensaje7="Seleccionar lector de pantalla"
$omensaje7a="Qu� lector de pantalla quieres usar?"
$omensaje8="Re-organizar audios y videos ahora"
$omensaje9="Guardar archivo de registro (recomendado)"
$omensaje10="Buscar siempre las actualizaciones del programa y de los componentes (recomendado)"
$omensaje10a="Activar / desactivar: "
$omensaje10b="Leer barras de progreso de descarga"
$omensaje10c="Leer tiempo restante estimado de descarga"
$omensaje10d="Pitar para barras de progreso"
$omensaje10e="Vajar el volumen multimedia mientras el lector de pantalla est� hablando"
$omensaje11="Cerrar este men�."
$omensaje12="Est�s seguro?"
$menuPos = "de"
case $sLanguage ="eng"
$omenu_Message="Options menu. Use up and down arrows to go to them, and enter to execute an action."
$omensaje0="Options menu"
$omensaje1 = "Select mp3 quality."
$omensaje1a="please select:"
$omensaje2 = "Change download folder Currently " &$download_dir
$omensaje2a="Select destination folder:"
$omensaje3 = "Change language Currently Language: " & $sLanguage
$omensaje4 = "Enable or disable enhanced accessibility."
$omensaje5 = "yes"
$omensaje6 = "no"
$omensaje7 = "Select screen reader"
$omensaje7a="What screen reader do you want to use?"
$omensaje8 = "Re-organize audios and videos now"
$omensaje9 = "Save log file"
$omensaje10 = "Always check for program and component updates (recommended)"
$omensaje10a="Enable / disable: "
$omensaje10b="Read download progress bars"
$omensaje10c="Read remaining time of download"
$omensaje10d="Beep for progress bars"
$omensaje10e="Down the multimedia volume while the screen reader is speaking"
$omensaje11 = "Close this menu."
$omensaje12 = "Are you sure?"
$menuPos = "of"
endselect
$okmessaje="OK"
$p_options=reader_Create_Menu($Omenu_message, $omensaje1 & "," &$omensaje2 & "," &$omensaje3 & "," &$omensaje4 & "," &$omensaje7 & "," &$omensaje8 & "," &$omensaje9 & "," &$omensaje10 & "," &$omensaje10a&$omensaje10b & "," &$omensaje10a &$omensaje10c & "," &$omensaje10a&$omensaje10d & "," &$omensaje10a&$omensaje10e & "," &$omensaje11, "1", $menuPos)
select
case $p_options = 1
$Bitrate=reader_Create_Menu($omensaje1a, "128 kbps,160 kbps,192 kbps,224 kbps,256 kbps,320 kbps,384 kbps(experimental", "1", $menuPos)
select
case $bitrate = 1
IniWrite("config\config.st", "General settings", "Audio Quality", "128k")
case $bitrate = 2
IniWrite("config\config.st", "General settings", "Audio Quality", "160k")
case $bitrate = 3
IniWrite("config\config.st", "General settings", "Audio Quality", "192k")
case $bitrate = 4
IniWrite("config\config.st", "General settings", "Audio Quality", "224k")
case $bitrate = 5
IniWrite("config\config.st", "General settings", "Audio Quality", "256k")
case $bitrate = 6
IniWrite("config\config.st", "General settings", "Audio Quality", "320k")
case $bitrate = 7
IniWrite("config\config.st", "General settings", "Audio Quality", "384k")
endselect
case $p_options = 2
Local $d_path = FileSelectFolder($omensaje2a,$download_dir)
speaking($d_path)
IniWrite("config\config.st", "General settings", "Destination folder", $d_path)
case $p_options = 3
$configureaccs = iniRead ("config\config.st", "accessibility", "Enable enanced accessibility", "")
$windowslanguage= @OSLang
;Spanish languages: Idiomas en espa�ol:
select
case $windowslanguage = "0c0a" or $windowslanguage = "040a" or $windowslanguage = "080a" or $windowslanguage = "100a" or $windowslanguage = "140a" or $windowslanguage = "180a" or $windowslanguage = "1c0a" or $windowslanguage = "200a" or $windowslanguage = "240a" or $windowslanguage = "280a" or $windowslanguage = "2c0a" or $windowslanguage = "300a" or $windowslanguage = "340a" or $windowslanguage = "380a" or $windowslanguage = "3c0a" or $windowslanguage = "400a" or $windowslanguage = "440a" or $windowslanguage = "480a" or $windowslanguage = "4c0a" or $windowslanguage = "500a"
$menu_lang=reader_Create_Menu("Por favor selecciona tu idioma", "Espa�ol,Ingl�s,Volver", "1", $menuPos)
;English languages: Idiomas para ingl�s:
case $windowslanguage = "0809" or $windowslanguage = "0c09" or $windowslanguage = "1009" or $windowslanguage = "1409" or $windowslanguage = "1809" or $windowslanguage = "1c09" or $windowslanguage = "2009" or $windowslanguage = "2409" or $windowslanguage = "2809" or $windowslanguage = "2c09" or $windowslanguage = "3009" or $windowslanguage = "3409" or $windowslanguage = "0425" or 
$menu_lang=reader_Create_Menu("Please select your language", "Spanish,English,Back", "1", $menuPos)
;end selection off languages. Fin de selecci�n/detecci�n de idiomas.
case else
$menu_lang=reader_Create_Menu("Please select your language", "Spanish,English,back", "1", $menuPos)
endselect
select
case $menu_lang = 1
IniDelete ( "config\config.st", "General settings", "language")
sleep(100)
IniWrite("config\config.st", "General settings", "language", "es")
$language="1"
MsgBox(48, "Informaci�n", "Por favor, reinicia MCY Downloader para que los cambios del idioma tengan efecto.")
case $menu_lang = 2
IniDelete ( "config\config.st", "General settings", "language")
sleep(100)
IniWrite ("config\config.st", "General settings", "language", "eng")
$language="2"
MsgBox(48, "Information", "Please restart MCY Downloader for the language changes to take effect.")
EndSelect
;case $menu_lang = 3
;$s_selected = $device.opensound ("sounds/soundsdata.dat/selected.ogg", true)
;$s_selected.play
;speaking($okmessaje)
case $p_options = 4
$en_a=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "1", $menuPos)
select
case $en_a = 1
IniWrite("config\config.st", "accessibility", "Enable enanced accessibility", "Yes")
case $en_a = 2
IniWrite("config\config.st", "accessibility", "Enable enanced accessibility", "No")
endselect
case $p_options = 5
$SpeakWh=Reader_Create_Menu($omensaje7a, "NVDA,JAWS,sapi5", "1", $menuPos)
select
case $speakWh = 1
IniWrite("config\config.st", "accessibility", "Speak Whit", "NVDA")
case $speakWh = 2
IniWrite("config\config.st", "accessibility", "Speak Whit", "JAWS")
case $speakWh = 3
IniWrite("config\config.st", "accessibility", "Speak Whit", "Sapi")
endselect
case $p_options = 6
reOrganizar()
case $p_options = 7
$menu_log=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "0", $menuPos)
select
case $menu_log = 1
IniWrite("config\config.st", "General settings", "Sabe Logs", "Yes")
case $menu_log = 2
IniWrite("config\config.st", "General settings", "Sabe Logs", "No")
endselect
case $p_options = 8
$menu_update=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "1", $menuPos)
select
case $menu_Update = 1
IniWrite("config\config.st", "General settings", "Check updates", "Yes")
case $menu_update = 2
IniWrite("config\config.st", "General settings", "Check updates", "No")
endselect
case $p_options = 9
$m_progress=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "1", $menuPos)
select
case $m_progress = 1
iniWrite ("config\config.st", "Accessibility", "Read download progress bar", "Yes")
case $m_progress = 2
iniWrite ("config\config.st", "Accessibility", "Read download progress bar", "No")
EndSelect
case $p_options = 10
$m_time=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "1", $menuPos)
select
case $m_time = 1
iniWrite ("config\config.st", "Accessibility", "Read download remaining time", "Yes")
case $m_time = 2
iniWrite ("config\config.st", "Accessibility", "Read download remaining time", "No")
EndSelect
case $p_options = 11
$PBeep=reader_Create_Menu($omensaje1a, $omensaje5 & "," &$omensaje6, "1", $menuPos)
select
case $PBeep = 1
iniWrite ("config\config.st", "Accessibility", "Beep for progress bars", "Yes")
case $PBeep = 2
iniWrite ("config\config.st", "Accessibility", "Beep for progress bars", "No")
EndSelect
case $p_options = 12
$audioDuck=reader_Create_Menu($omensaje1a, $omensaje5 &"," &$omensaje6, "1", $menuPos)
select
case $audioDuck = 1
iniWrite ("config\config.st", "Accessibility", "Audio ducking", "Yes")
case $AudioDuck = 2
iniWrite ("config\config.st", "Accessibility", "Audio ducking", "No")
EndSelect
case $p_options = 13
$s_selected = $device.opensound ("sounds/soundsdata.dat/selected.ogg", true)
$s_selected.play
speaking($okmessaje)
EndSelect
EndFunc
Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc
Func Menu_Options2()
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
$download_dir = iniRead ("config\config.st", "General settings", "Destination folder", "")
select
case $download_dir =""
$download_dir="C:\MCY\Download\Audio"
endSelect
Dim $aArray[0]
Dim $bArray[0]
Select
case $sLanguage ="es"
$mensaje0="Men� de opciones"
$mensaje1="Seleccionar calidad de mp3."
$mensaje1a="por favor selecciona:"
$mensaje2="Cambiar carpeta de descargas, Actualmente " &$download_dir
$mensaje2a="Selecciona la carpeta de destino:"
$mensaje3="Cambiar idioma, Idioma actual: " & $sLanguage
$mensaje4="Activar o desactivar accesibilidad mejorada."
$mensaje5="si"
$mensaje6="no"
$mensaje8="Re-organizar audios y videos ahora"
$mensaje9="Guardar archivo de registro (recomendado)"
$mensaje10="Buscar siempre las actualizaciones del programa y de los componentes (recomendado)"
$mensaje11="Cerrar este men�."
$mensaje12="Est�s seguro?"
case $sLanguage ="eng"
$mensaje0="Options menu"
$mensaje1 = "Select mp3 quality."
$mensaje1a="please select:"
$mensaje2 = "Change download folder, Currently " &$download_dir
$mensaje2a="Select destination folder:"
$mensaje3 = "Change language, Currently Language: " & $sLanguage
$mensaje4 = "Enable or disable enhanced accessibility."
$mensaje5 = "yes"
$mensaje6 = "no"
$mensaje8 = "Re-organize audios and videos now"
$mensaje9 = "Save log file"
$mensaje10 = "Always check for program and component updates (recommended)"
$mensaje11 = "Close this menu."
$mensaje12 = "Are you sure?"
endselect
$okmessaje="OK"
$guioptions = GuiCreate($mensaje0)
$iRadio_Count = 7
GUICtrlCreateGroup($mensaje1, 20, 10, 100, 60)
Local $idBtr1 = GUICtrlCreateRadio("128KBPS", 30, 30, 120, 30)
Local $idBtr2 = GUICtrlCreateRadio("160KBPS", 30, 50, 120, 30)
Local $idBtr3 = GUICtrlCreateRadio("192KBPS", 30, 70, 120, 30)
Local $idBtr4 = GUICtrlCreateRadio("224KBPS", 30, 90, 120, 30)
Local $idBtr5 = GUICtrlCreateRadio("256KBPS", 30, 130, 120, 30)
Local $idBtr6 = GUICtrlCreateRadio("320KBPS", 30, 150, 120, 30)
Local $idBtr7 = GUICtrlCreateRadio("384KBPS", 30, 170, 120, 30)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;GUICtrlSetState($idBTR7, $GUI_CHECKED)
local $BTNChooseF = GUICtrlCreateButton($mensaje2, 50, 200, 120, 25)
$lang_Label = GUICtrlCreateLabel($mensaje3, 60, 200, 120, 25)
$idComboBox = GUICtrlCreateCombo("Spanish", 60, 200, 150, 30, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idComboBox, "English", "Spanish")
$accs_Label = GUICtrlCreateLabel($mensaje4, 90, 200, 120, 25)
$idComboBox2 = GUICtrlCreateCombo("On", 60, 60, 150, 30, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idComboBox2, "Off", "Off")
local $BTN_ReOrder = GUICtrlCreateButton($mensaje8, 120, 200, 180, 25)
Local $idSabeLogs = GUICtrlCreateCheckbox($mensaje9, 150, 200, 185, 25)
Local $idCheckupds = GUICtrlCreateCheckbox($mensaje10, 250, 200, 185, 25)
Local $idBTN_Close = GUICtrlCreateButton($mensaje11, 300, 200, 185, 25)
GUISetState(@SW_SHOW)
Local $idMsg
Local $sComboRead = ""
While 1
$idMsg = GUIGetMsg()
Select
Case $idMsg = $GUI_EVENT_CLOSE
guiDelete($guioptions)
ExitLoop
Case $idMsg = $idBTR1 And BitAND(GUICtrlRead($idBTR1), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "128k")
Case $idMsg = $idBTR2 And BitAND(GUICtrlRead($idBTR2), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "160k")
Case $idMsg = $idBTR3 And BitAND(GUICtrlRead($idBTR3), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "192k")
Case $idMsg = $idBTR4 And BitAND(GUICtrlRead($idBTR4), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "224k")
Case $idMsg = $idBTR5 And BitAND(GUICtrlRead($idBTR5), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "256k")
Case $idMsg = $idBTR6 And BitAND(GUICtrlRead($idBTR6), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "320k")
Case $idMsg = $idBTR7 And BitAND(GUICtrlRead($idBTR7), $GUI_CHECKED) = $GUI_CHECKED
IniWrite("config\config.st", "General settings", "Audio Quality", "384k")
case $idMsg = $BTNChooseF
Local $d_path = FileSelectFolder($mensaje2a,$download_dir)
speaking($d_path)
IniWrite("config\config.st", "General settings", "Destination folder", $d_path)
Case $idMsg = $idComboBox
$sComboRead = GUICtrlRead($idComboBox)
select
case $sComboRead = "Spanish"
IniDelete ( "config\config.st", "General settings", "language")
sleep(100)
IniWrite("config\config.st", "General settings", "language", "es")
$language="1"
MsgBox(48, "Informaci�n", "Por favor, reinicia MCY Downloader para que los cambios del idioma tengan efecto.")
case $sComboRead = "English"
IniDelete ( "config\config.st", "General settings", "language")
sleep(100)
IniWrite ("config\config.st", "General settings", "language", "eng")
$language="2"
MsgBox(48, "Information", "Please restart MCY Downloader for the language changes to take effect.")
EndSelect
Case $idMsg = $idComboBox2
$sComboRead = GUICtrlRead($idComboBox2)
IniWrite("config\config.st", "accessibility", "Enable enanced accessibility", $sComboRead)
MsgBox(48, "Information", "Please restart MCY Downloader for the changes to take effect.")
case $idMsg = $BTN_reOrder
reOrganizar()
Case $idMsg = $idSabelogs
If _IsChecked($idSabelogs) Then
IniWrite("config\config.st", "General settings", "Sabe Logs", "Yes")
Else
IniWrite("config\config.st", "General settings", "Sabe Logs", "No")
				EndIf
Case $idMsg = $idCheckupds
If _IsChecked($idCheckUpds) Then
IniWrite("config\config.st", "General settings", "Check updates", "Yes")
				Else
IniWrite("config\config.st", "General settings", "Check updates", "No")
EndIf
Case $idMsg = $idBTN_Close
guiDelete($guioptions)
ExitLoop
EndSelect
WEnd
endfunc