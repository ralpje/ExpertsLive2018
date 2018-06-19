Get-CsOnlineTelephoneNumberInventoryTypes

Get-CsOnlineTelephoneNumberInventoryRegions -InventoryType 'Subscriber'

Get-CsOnlineTelephoneNumberInventoryCountries -InventoryType 'Subscriber' -RegionalGroup 'EMEA'

Get-CsOnlineTelephoneNumberInventoryAreas -InventoryType 'Subscriber' -RegionalGroup 'EMEA' -CountryOrRegion 'NL'

Get-CsOnlineTelephoneNumberInventoryCities -InventoryType 'Subscriber' -RegionalGroup 'EMEA' -CountryOrRegion 'NL' -Area 'All' | select-object DefaultName, ID, AreaCodes, GeoCode | Sort-Object DefaultName | ogv

Get-CSOnlineTelephoneNumberAvailableCount -InventoryType 'Subscriber'


$TestSearch = Search-CsOnlineTelephoneNumberInventory -InventoryType 'Subscriber' -RegionalGroup 'EMEA' -CountryOrRegion 'NL' -Area 'All' -City 'NH_BE' -Quantity '3'
$TestSearch
$Testsearch.Reservations[0]

$PBXNumber = @{
    'Inventorytype' = 'subscriber'
    'RegionalGroup' = 'EMEA'
    'CountryOrRegion' = 'GB'
    'Area' = 'all'
    'City' = 'LND_LN'
    'Quantity' = '3'
}

$search = Search-CsOnlineTelephoneNumberInventory @PBXNumber
$search
$search.Reservations
$search.Reservations.Numbers

$ReservationResponse = Select-CsOnlineTelephoneNumberInventory -ReservationID $search.ReservationId -TelephoneNumbers $($search.Reservations.Numbers[0].Number) -RegionalGroup $PBXNumber.RegionalGroup -CountryOrRegion $PBXNumber.CountryOrRegion -Area $pbxnumber.Area -City $PBXNumber.City
$ReservationResponse
$ReservationResponse.Items

# vrijgeven nummer
# Clear-CsOnlineTelephoneNumberReservation -ReservationId $($Search.ReservationId) -InventoryType $PBXNumber.Inventorytype -Verbose

Get-CsOnlineTelephoneNumber | select-object InventoryType, ID, CityCode, ActivationState, FriendlyName

get-csonlinevoiceuser -Identity $NewUser.userprincipalname
Get-CsOnlineLisLocation
$LocationID = (get-csonlinelislocation | where {$_.Description -like 'Westminster'}).LocationID
Set-CSOnlineVoiceUser -Identity $NewUser.userprincipalname -LocationID $LocationID -TelephoneNumber $ReservationResponse.Items.Numbers
Get-CSOnlineVoiceUser -Identity $NewUser.userprincipalname
