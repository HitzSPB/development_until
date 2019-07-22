# Install Chocolatey - I run it everytime I run this script, simply because it is fast, does no damage and then I am sure I got the latest version.
Invoke-Expression ((new-object net.webclient).DownloadString("http://chocolatey.org/install.ps1"))

$InstalledPackages = Invoke-Expression "choco list --local-only" | Select-String -Pattern '([\.\-A-Za-z\d]+)\s[\d\.v]+' -AllMatches | Foreach-Object {$_.Matches} | Foreach-Object {$_.Groups[1].Value}
[array]$MyTargetPackages =  'visualstudio2019enterprise','office365business','sql-server-management-studio','sql-server-2017';

# Upgrade of .NetFramework, 



foreach($item in $MyTargetPackages)
{    
    write-host "Running item $item"
    if($InstalledPackages.Contains($item))
    {
        Write-Host "Upgrading item $item"
        choco upgrade $item -y
    }
    else 
    {
        Write-Host "Installing item $item"
        choco install $item -y
    }
}

Write-Host "Run have completed. Check manually for errors."