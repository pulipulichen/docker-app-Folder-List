#include <MsgBoxConstants.au3>
#include <FileConstants.au3>

Global $sPROJECT_NAME = "docker-app-Folder-List"
Global $sFILE_EXT = "All (*.*)"

;~ MsgBox($MB_SYSTEMMODAL, "Title", "This message box will timeout after 10 seconds or select the OK button.", 10)
Local $sWorkingDir = @WorkingDir

; =================================================================

; Step 1: Create the directory if it doesn't exist
DirCreate( @HomeDrive & @HomePath & "\docker-app\" )

; Step 2: Download the script
Local $sScriptPath = @HomeDrive & @HomePath &"\docker-app\docker-app-launcher.exe"
Local $sURL = "https://pulipulichen.github.io/docker-app-Launcher/docker-app-launcher.exe"

InetGet($sURL, $sScriptPath, $INET_FORCERELOAD)

; Check if download was successful
If @error <> 0 Then
    MsgBox($MB_OK, "Error", "Failed to download the script. Error code: " & @error)
    Exit
EndIf

; Step 4: Get the script's full path as the second parameter
Local $sScriptFullPath = @ScriptFullPath

; Step 5: Get all parameters from this script as the third, fourth, ... parameters
Local $aParameters[UBound($CmdLine)]
For $i = 1 To UBound($CmdLine) - 1
	$aParameters[$i] = '"' & $CmdLine[$i] & '"'
Next

; Step 6: Pass parameters to "~/docker-app/docker-app-launcher.exe" using RunWait
Local $sParameters = '"' & $sPROJECT_NAME & '" "' & $sScriptFullPath & '" ' & _ArrayToString($aParameters, " ")
Local $iRunWaitResult = RunWait('"' & $sScriptPath & '" ' & $sParameters, @ScriptDir, @SW_SHOW)