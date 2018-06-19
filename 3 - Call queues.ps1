Get-CsHuntGroup
Get-CsOnlineTelephoneNumber -InventoryType Service | Select-Object Id, FriendlyName, CityCode

[byte[]]$content = get-content -path 'C:\Users\RalphEckhard\OneDrive - PeopleWare ICT Solutions\Presentaties\Experts Live 2018\Audio\welkom.wav' -encoding Byte -ReadCount 0

get-distributiongroup | Select-Object DisplayName, PrimarySMTPAddress, ExternalDirectoryObjectID

$HuntGroup = @{
    "Name" = "PowerShell HuntGroup"
    "LineURI" =  "TEL:+31202588793"
    "AgentAlertTime" = "40"
    "DistributionLists" = "9bec5b7b-3a72-4230-85fd-f62a8b74281d" 
    "OverFlowThresHold" = "5"
    "OverFlowAction" = "DisconnectWithBusy"
    "UseDefaultMusicOnHold" = $true
    "TimeOutAction" = "Disconnect"
    "TimeOutThreshold" = "15"
    "WelcomeMusicFileContent" = $content
    "WelcomeMusicFilename" = "welcome.wav"
    "Domain" = "demoel2018.onmicrosoft.com"
}

New-CSHuntGroup @HuntGroup