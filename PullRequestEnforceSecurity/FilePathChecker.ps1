#TFS Build repository path variable
$PathToCheck = "$ENV:Build.Repository.LocalPath"
$PathTooLong = $false
$Files = Get-ChildItem -Path $PathToCheck -Recurse

foreach($file in $Files)
{
$ActualLength = $file.FullName.replace("$PathToCheck\", "")
  #From the total length we accept that 220 of them from the from root of the source code and to the longest file. It leaves a little space for the path to the source code root.
  if($ActualLength.Length -ge 220)
  {  
   Write-Host "$($ActualLength) $($ActualLength.Length)"
   $PathTooLong = $true
  }
}

if($PathTooLong)
{
  Write-Error "One or more paths were too long"
  throw [System.IO.FileNotFoundException] "One or more paths were too long" #We throw a exception because TFS will report it as a error in the build system
}
