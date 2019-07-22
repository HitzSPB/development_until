$agentDownloadUrl = "https://vstsagentpackage.azureedge.net/agent/2.136.1/vsts-agent-win-x64-2.136.1.zip"
$windowsUser = '' # Username for windows user
$windowsUserPassword = '' # Password for windows user
$agentFolderPath = 'C:\Agents'
$buildFolderPath = 'D:\builds' #I always place my build folders on a second drive. This way I can just format the drive when it needs cleaning
$tfsUrl = ''
$machineName = $env:computername #I always call my agents the name of the server they run on
$agentTargetCount = 4 #Insert the number of how many agents you want to create
$removeOldAgents = $true
$agentZipFile = "$agentFolderPath\agent.zip"
$pool = 'Pool' #Target agent pool
$pat = '' # TFS Personal Access Token, Should have read and manage Agent/Deployment pool


if($removeOldAgents -eq $true)
{

    $oldConfigPaths = Get-ChildItem -Path $agentFolderPath -Filter "config.cmd" -Recurse
    $foldersToDelete = Get-ChildItem -Path $agentFolderPath 

    foreach($registeredagent in $oldConfigPaths)
    {
        & $registeredagent.FullName remove --unattended --auth pat --token $pat
    }


    foreach($folder in $foldersToDelete)
    {
        Remove-Item $folder.FullName -Recurse
    }
}

New-Item -ItemType Directory -Force -Path $agentFolderPath
Invoke-WebRequest -Uri $agentDownloadUrl -OutFile $agentZipFile

$agentCount = 1
$starupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" # I created this script because I had to create 4 agents on 25 servers. And because they are GUI agents I put the exe file into the startup folder
While([int]$agentCount -ne [int]($agentTargetCount + 1))
{
    $agentName = "$machineName-A$agentCount"
    $agentPath = "$agentFolderPath\$agentName"

    New-Item -ItemType Directory -Path $agentPath
    Expand-Archive -Path $agentZipFile -DestinationPath $agentPath
    &"$agentPath\config.cmd" --unattended --url $tfsUrl --auth pat --token $pat --work "$buildFolderPath\$agentcount" --pool $pool --agent "$agentName" --windowsLogonAccount $windowsUser --windowsLogonPassword $windowsUserPassword --noRestart
    
    if(![System.IO.File]::Exists("$starupFolder\$agentName")){
        Remove-Item "$starupFolder\$agentName" -Recurse
    }
    New-Item -ItemType SymbolicLink -Path $starupFolder -Name $agentName -Value "$agentPath\run.cmd"

    $agentCount++
}

Remove-Item $agentZipFile







