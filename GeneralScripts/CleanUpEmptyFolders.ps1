param(
    [string]$DirectoryPath
)
do {
  [string[]]$dirs = (Get-ChildItem $RemoveEmptyFolderPath -directory -recurse | Where { (Get-ChildItem $_.fullName).count -eq 0 }).FullName
  if ($dirs) {
    $dirs | Foreach-Object {
      Remove-Item $_
      Write-Host "$_ was removed"
    }
  }
} while ($dirs.count -gt 0) 