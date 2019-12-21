Add-WindowsFeature -Name "Web-Server" -IncludeAllSubFeature
$appUrl = "https://github.com/opsgility/cpu-spike-app/raw/master/cpu-spike-app.zip"
$splitpath = $appUrl.Split("/")
$fileName = $splitpath[$splitpath.Length-1]
$destinationPath = "C:\Inetpub\wwwroot\cpu-spike-app.zip"
$destinationFolder = "C:\Inetpub\wwwroot"

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($appUrl,$destinationPath)

(new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)

New-NetFirewallRule -DisplayName "Allow Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow