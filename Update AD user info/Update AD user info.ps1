#This script will update AD user info from a CSV file with these fields populated:

Start-Transcript -path "C:\ADupdate\output.txt"

Import-Module ActiveDirectory

$userinfo = Import-Csv "C:\ADupdate\SPC.csv"

foreach($user in $userinfo){

    # Find user
	
    $ADUser = Get-ADUser -Filter "EmailAddress -eq '$($user.PrimaryEmail)'" -Properties mail
	
	
	#The following if statements check to see if the user exists then ignores empty fields in the CSV
	
    if ($ADUser){
		if ($user.BusinessUnit) {
			Set-ADUser -Identity $ADUser -Company $user.BusinessUnit
		}
		if ($user.Department) {
			Set-ADUser -Identity $ADUser -Department $user.Department
		}
		if ($user.jobtitle) {
			Set-ADUser -Identity $ADUser -Title $user.jobtitle
		}
		if ($user.Office) {
			Set-ADUser -Identity $ADUser -Office $user.Office
		}
		if ($user.Manager) {
			Set-ADUser -Identity $ADUser -Manager $user.Manager
		}
		if ($user.OfficePhone) {
			Set-ADUser -Identity $ADUser -OfficePhone $user.OfficePhone
		}
		if ($user.StreetAddress) {
			Set-ADUser -Identity $ADUser -StreetAddress $user.StreetAddress
		}
		if ($user.City) {
			Set-ADUser -Identity $ADUser -City $user.City
		}
		if ($user.State) {
			Set-ADUser -Identity $ADUser -State $user.State
		}
		if ($user.Zip) {
			Set-ADUser -Identity $ADUser -PostalCode $user.Zip
		}
		if ($user.Country) {
			Set-ADUser -Identity $ADUser -Country $user.Country
		}
    }else{
        Write-Warning ("Failed to update " + $user.PrimaryEmail)
    }
}

Pause

Stop-Transcript