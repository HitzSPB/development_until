$Url = "https://github.com/git-for-windows/git/releases/download/v2.16.2.windows.1/Git-2.16.2-64-bit.exe"
$GitExe = "git2.16.2.exe"
$GitInstallParameters = "GitInstallParameters.txt"

if(!(Test-Path "$PSScriptRoot\$GitExe"))
{
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url, "$PSScriptRoot\$GitExe")
}


if (!(Test-Path "$PSScriptRoot\$GitInstallParameters"))
{
    $text = "[Setup]
    Lang=default
    Dir=C:\Program Files\Git
    Group=Git
    NoIcons=0
    SetupType=default
    Components=ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh,consolefont,autoupdate
    Tasks=
    EditorOption=VIM
    PathOption=Cmd
    SSHOption=OpenSSH
    CURLOption=OpenSSL
    CRLFOption=CRLFCommitAsIs
    BashTerminalOption=ConHost
    PerformanceTweaksFSCache=Enabled
    UseCredentialManager=Enabled
    EnableSymlinks=Enabled" > "$PSScriptRoot\$GitInstallParameters"
}


& "$PSScriptRoot\$GitExe" '/SILENT' '/LOADINF="GitInstallParameters.txt"' | Out-Null # Wait for exit

#If you wish to clean after install. Uncomment the two lines below
#Remove-Item "$PSScriptRoot\$GitExe"
#Remove-Item "$PSScriptRoot\$GitInstallParameters"