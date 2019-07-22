param(
    [switch]$InstallFrameworks,
    [switch]$CompanyTools,
    [switch]$DevelopmentTools,
    [switch]$PersonalSoftwareToolsAndDevelopment,
    [switch]$CloudTools,
    [switch]$BuildAndDeploymentTools,
    [switch]$SpecsAndBenchMark
)

# Install Chocolatey - I run it everytime I run this script, simply because it is fast, does no damage and then I am sure I got the latest version.
Invoke-Expression ((new-object net.webclient).DownloadString("http://chocolatey.org/install.ps1"))

$InstalledPackages = Invoke-Expression "choco list --local-only" | Select-String -Pattern '([\.\-A-Za-z\d]+)\s[\d\.v]+' -AllMatches | Foreach-Object {$_.Matches} | Foreach-Object {$_.Groups[1].Value}
[array]$MyTargetPackages

# Upgrade of .NetFramework, 
if($InstallFrameworks)
{
    Write-Host "Grabbing required frameworks"
    cinst NETFramework2 -source webpi # Required by the current company I work for
    cinst NETFramework35 -source webpi # Required by the current company I work for
    cinst NETFramework4 -source webpi # Required by the current company I work for
    cinst NETFramework48 -source webpi 
    # Add 'netfx-4.8-devpack' when Chocolatey have it in release version. It only have pre-release 13/7-2019
    $MyTargetPackages +=  'netfx-4.7.2-devpack', 'dotnetcore-sdk', 'jre8';
}

if($CompanyTools)
{
    $MyTargetPackages +=  'microsoft-teams','skypeforbusiness';
}

if($PersonalSoftwareToolsAndDevelopment)
{
    $MyTargetPackages += 'putty.install',
    'nodejs.install',
    'filezilla',
    'wireshark',
    'vlc',
    '7zip',
    'pnggauntlet',
    'github-desktop',
    'totalcommander',
    'firefox',
    'chrome',
    'chrome',
    'discord',
    'autohotkey.install',
    'windirstat',
    'audacity',
    'googledrive',
    '1password',
    'office365proplus',
    'slack',
    'poweriso',
    'adblockpluschrome',
    'whatsapp',
    'veracrypt',
    'join.me',
    'manictime',
    'pdfcreator',
    'screentogif';
}

if($DevelopmentTools)
{
    $MyTargetPackages +=  'postman', 
    'fiddler',
    'docker-desktop',
    'dotpeek',
    'linqpad',
    'vscode',
    'git.install --params "/GitOnlyOnPath /SChannel"', #This is a messy hack, will be changed in next version of the script
    'powershell-core',
    'sql-server-management-studio',
    'sql-server-2017';
}

if($VisualStudio)
{
    $MyTargetPackages += 'visualstudio2019enterprise'
    # $MyTargetPackages += 'visualstudio2019professional'
    # $MyTargetPackages += 'visualstudio2019community'
}

if($DebugTools)
{
    $MyTargetPackages +=  'sysinternals', 'tailblazer';

}

if($BuildAndDeploymentTools)
{
    $MyTargetPackages +=  'octopustools', 
    'octopusdeploy'
    'kubernetes-cli',
    'kubernetes-node';
}

if($CloudTools)
{
    $MyTargetPackages +=  'awscli', 'azurepowershell';
}

if($Education)
{
    $MyTargetPackages +=  'powerbi', 
    'chefdk',
    'chef-workstation',
    'jenkins-x',
    'electron',
    'ravendb',
    'mongodb.core.2.6',
    'prometheus';
}

if($SpecsAndBenchMark)
{
    $MyTargetPackages +=  'speccy', 
    'cpu-z.install',
    'crystaldiskinfo.install',
    'futuremark-systeminfo',
    '3dmark ';
}

if($TestTools)
{
    $MyTargetPackages +=  'angryip', 
    'pode',
    'icaros',
    'aida64-engineer',
    'regexpixie ';
}



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