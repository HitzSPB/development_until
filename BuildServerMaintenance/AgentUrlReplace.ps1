$AgentDirPath = "C:\Agents"
$CurrentUrl = "http://tfs:8080/tfs/"
$TargetUrl = "https://weburl.com/tfs/"

$agentfiles = Get-ChildItem -Path $AgentDirPath -Recurse -Attributes !Directory, !Directory+Hidden -Include ".agent", ".credentials"

foreach ($agent in $agentfiles) {
  ((Get-Content -path $agent.FullName -Raw) -replace $CurrentUrl, $TargetUrl) | Set-Content -Path $agent.FullName
}

