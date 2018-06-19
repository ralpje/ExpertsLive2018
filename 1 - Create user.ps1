get-msolaccountsku

$NewUser = @{
    "displayname" = "ExpertsLive Demo 2018"
    "firstname" = "ExpertsLive"
    "lastname" = "Demo 2018"
    "userprincipalname" = "demouserel@demoel2018.onmicrosoft.com"
    "usagelocation" = "GB"
    "licenseassignment" = "demoel2018:ENTERPRISEPREMIUM"
    "passwordneverexpires" = $true
    "forcechangepassword" = $false
    "password" = "SuperGeheim2018!"
}

New-MsolUser @NewUser

Set-MsolUserLicense -UserPrincipalName $NewUser.userprincipalname -AddLicenses "demoel2018:MCOPSTN_5"