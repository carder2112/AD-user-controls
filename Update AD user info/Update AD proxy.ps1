

#This script will update AD user PROXY info from a CSV file with these fields populated: email address, proxy addresses separated by ;

Start-Transcript -path "C:\ADupdate\output.txt"

Import-Module ActiveDirectory

$userinfo = Import-Csv "C:\ADupdate\ThisOne.csv"

foreach($user in $userinfo){

    # Find user
	
    $ADUser = Get-ADUser -Filter "EmailAddress -eq '$($user.PrimaryEmail)'" -Properties mail
	
	
	#The following if statements check to see if the user exists then updates the proxy info if they exist.
	
    if ($ADUser){
		
			Set-ADUser -Identity $ADUser -add @{Proxyaddresses=$user.Proxyaddresses -split ";"}
			
    }else{
        Write-Warning ("Failed to update " + $user.PrimaryEmail)
    }
}

Pause

Stop-Transcript