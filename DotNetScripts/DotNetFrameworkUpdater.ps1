param (
  [Parameter(Mandatory=$true)]
  [string]$Path,
  [string]$TargetVersion = "4.7.2"
  )

  #DotNet Framework upgrade - .csproj

$AllCsprojPaths = Get-ChildItem -Path $Path -Filter "*.csproj" -Recurse
$WebConfigPaths = Get-ChildItem -Path $Path -Filter "web.config" -Recurse

$RegexMatchPatternCsproj = '<(TargetFrameworkVersion>)[^<]+(<\/\1)'
foreach($csprojFilePath in $AllCsprojPaths)
{
  Write-Host $csprojFilePath.FullName
  $FileContent = Get-Content $csprojFilePath.FullName
  if($FileContent -match $RegexMatchPatternCsproj)
  {
    Write-Host "Attempting to modify file: $($csprojFilePath.FullName)"
    $FileContent -replace $RegexMatchPatternCsproj, "<`${1}V$TargetVersion`${2}" | Set-Content $csprojFilePath.FullName -Encoding UTF8
    Write-Host "Target Framework changed for file: $($csprojFilePath.FullName)"
  }
}

  #DotNet Framework upgrade - Web.config

$RegexMatchPatternWebConfig = '\b(targetFramework=")[^"]*(")\b'
foreach($webconfigFilePath in $WebConfigPaths)
{
  Write-Host "Checking File $($webconfigFilePath.FullName)"
  $FileContent = Get-Content $webconfigFilePath.FullName
  if($FileContent -match $RegexMatchPattern)
  {
    Write-Host "Attempting to modify file: $($webconfigFilePath.FullName)"
    $FileContent -replace $RegexMatchPatternWebConfig, "`${1}$TargetVersion`${2}"| Set-Content $webconfigFilePath.FullName -Encoding UTF8
    Write-Host "Target Framework changed for file: $($webconfigFilePath.FullName)"
  }
}