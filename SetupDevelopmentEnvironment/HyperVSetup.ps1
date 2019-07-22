$systemInfomation = Invoke-Command -ScriptBlock {systeminfo.exe}

$collection = [Regex]::Matches([string]$systemInfomation, '(?:VM Monitor Mode Extensions:|Virtualization Enabled In Firmware:|Second Level Address Translation:|Data Execution Prevention Available:)\s(Yes|No)')

foreach($item in $collection)
{
    $checkValue = $item.Groups[1].Value;
    if($item.Groups[1].Value -eq 'no')
    {
        Write-Error "You are not ready to run Hyper-V:: $item"
        $Global:LASTEXITCODE = 1
    }
    else
    {
        Write-Host "Step is ready to run Hyper-V:: $item"
    }
}

if($Global:LASTEXITCODE -eq 1)
{
    Write-Host "Fix the missing features before installing Hyper-V"
}
else
{
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}

pause