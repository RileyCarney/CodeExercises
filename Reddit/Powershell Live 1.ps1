<#
Hello, I need help. I would like to create a mailbox but there are some missing items.
I would like to add a second proxyaddresses:
- smtp: jlouis@seconddomainname.com
- add X400: C = CA; A =; P = test; O = ExchangeS = LastName; G = FirstName;
- and I want to enable: Automatically update email addresses based on the email address policy applied to this recipient


This is what I have so far:
#>
#Connexion Exchange 2013
$Credentials = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://server.domainname.com/PowerShell/ -Authentication Kerberos -Credential $Credentials
Import-PSSession $Session


#Infos users
$DisplayName="Louis, Joe"
$FirstName="Joe"
$LastName="Louis"
$Alias="jlouis"
$SamAccountName="louij"
$UserPrincipalName="jlouis@domainname.com"
$OU="domainname.com/Users"
$primarySMTPAddress="jlouis@domainname.com"
$remoteRoutingAddress="jlouis@domainname.mail.onmicrosoft.com"
$CustomAttribute="officetest"

#Creation mailbox
Write-host "+ Create new mailbox : $($DisplayName) processing.."
New-RemoteMailbox -name $DisplayName -Firstname $FirstName -LastName $LastName -Alias $Alias -samAccountname $SamAccountName -UserPrincipalName $UserPrincipalName -Archive -OnPremisesOrganizationalUnit $OU -primarySMTPAddress $primarySMTPAddress -remoteRoutingAddress $remoteRoutingAddress

#Add attribut
Write-host "+ Add Custom Attribute : $($CustomAttribute)"
Set-aduser -identity $SamAccountName -Add @{extensionAttribute1=$CustomAttribute}

