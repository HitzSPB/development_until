param(
    [string]$DirectoryPath
)

function FindAllBuildFolders ([string]$path) {
    return Get-ChildItem $path -recurse -Include "obj", "bin"
}

function RemoveAllItems ([string[]]$paths) {
    foreach($item in $paths)
    {
        write-host "Removing item $item"
        Remove-Item -Path $item -Recurse -Confirm:$false -Force
    }
}

RemoveAllitems -paths (FindAllBuildFolders -path $DirectoryPath)