# service phone number
$AttendantNumber = [System.uri] "tel:+31202588955"
$AttendantNumber

# Operator settings
$OperatorURI = 'sip:' + $newuser.userprincipalname
$operatorEntity = New-CsOrganizationalAutoAttendantCallableEntity -identity $OperatorURI -type User

# In Hours Greeting
$AAGreeting = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "Welcome to Experts Live 2018"
$AAMenuOptionZero = New-CsOrganizationalAutoAttendantMenuOption -Action TransferCallToOperator -DtmfResponse Tone0
$AAMenuPrompt = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "Enter the name, followd by the pound sign, or press 0 to reach the operator"
$AADefaultMenu = New-CsOrganizationalAutoAttendantMenu -Name "Default Menu" -Prompts @($AAmenuPrompt) -EnableDialByName -MenuOptions @($AAMenuOptionZero)
$AADefaultCallFlow = New-CSorganizationalAutoAttendantCallFlow -Name 'Default Call Flow' -Menu $AADefaultMenu -Greetings @($AAGreeting)

# After Hours Greeting
$AAClosedGreeting = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "Sorry, we're closed right now"
$AAClosedMenuOption = New-CSOrganizationalAutoAttendantMenuOption -Action Disconnect -DtmfResponse Automatic
$AAClosedMenu = New-CsOrganizationalAutoAttendantMenu -Name "Closed Menu" -MenuOptions @($AAClosedMenuOption)
$AAClosedCallFlow = New-CsOrganizationalAutoAttendantCallFlow -Name "Closed call flow" -Menu $AAClosedMenu -Greetings @($AAClosedGreeting)

# Define time slots
$timeslot1 = New-CsOnlineTimeRange -start 09:00 -end 12:00
$timeslot2 = New-CsOnlineTimeRange -start 13:00 -end 17:00
$ClosedHours = @($timeslot1, $timeslot2)

$ClosedSchedule = New-CSOnlineSchedule -name 'Schedule' -WeeklyRecurrentSchedule -MondayHours $ClosedHours -TuesdayHours $ClosedHours -WednesdayHours $ClosedHours -ThursdayHours $ClosedHours -FridayHours $ClosedHours -Complement

$ClosedScheduleAssociation = New-CSOrganizationalAutoAttendantCallHandlingAssociation -Type AfterHours -ScheduleID $ClosedSchedule.id -CallFlowID $AAClosedCallFlow.id
$language = Get-CsOrganizationalAutoAttendantSupportedLanguage -identity "en-US"
$defaultVoice = $language.Voices[0]
$output = New-CsOrganizationalAutoAttendant -Name "Main AA" -LineUris @($AttendantNumber) -DefaultCallFlow $AADefaultCallFlow -EnableVoiceResponse -Schedules @($ClosedSchedule) -CallHandlingAssociations @($ClosedScheduleAssociation) -Language "en-us" -TimeZoneI "UTC" -Operator $operatorEntity -VoiceID $defaultVoice
