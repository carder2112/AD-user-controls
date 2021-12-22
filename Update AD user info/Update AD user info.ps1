#This script will update AD user info from a CSV file with these fields populated:



Import-Module ActiveDirectory

$userinfo = Import-Csv "C:\ADupdate\SPC.csv"

foreach($user in $userinfo){

    # Find user
	
    $ADUser = Get-ADUser -Filter "EmailAddress -eq '$($user.PrimaryEmail)'" -Properties mail
	
	
    if ($ADUser){
        Set-ADUser -Identity $ADUser -Company $user.BusinessUnit -Department $user.Department -Title $user.jobtitle -Office $user.Office -Manager $user.Manager -OfficePhone $user.OfficePhone -StreetAddress $user.StreetAddress -City $user.City -State $user.State -PostalCode $user.Zip -Country $user.Country
    }else{
        Write-Warning ("Failed to update " + $user.PrimaryEmail)
    }
}

Pause