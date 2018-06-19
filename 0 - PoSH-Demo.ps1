$credentials = Get-Credential
$credentials.Password.MakeReadOnly()
$sfbsession = New-CsOnlineSession -Credential $credentials
$eolsession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri 'https://outlook.office365.com/powershell/liveid' -Credential $credentials -Authentication basic -AllowRedirection
$sfbmodule = Import-PSSession $sfbsession -AllowClobber
$eolmodule = Import-PSSession $eolsession -AllowClobber
Connect-MsolService -Credential $credentials
(get-command -module $sfbmodule.name).count