# Имя контакта
$EmailAddress = "mvoronina@norrexim.ru"

$User = $EmailAddress -replace "@.+$"
# $User = "andrew_test"   # для несимметричного контакта



$Alias = $EmailAddress -replace "@","?"

New-MailContact -Name $EmailAddress -ExternalEmailAddress $EmailAddress -Alias $Alias -DisplayName $EmailAddress `
-OrganizationalUnit "OU=Контакты,OU=Пользователи,OU=ХОЛДИНГ,DC=zaoeps,DC=local"
Start-Sleep -s 10

# Ждать по 10 секунд, пока не появится контакт
Do
{
	Start-Sleep -s 10
	$Contact = Get-Contact $EmailAddress
}
Until ($Contact -ne $null)

# Добавление прав "Отправить как" пользователю на контакт
Add-ADPermission -Identity $EmailAddress -User $User -ExtendedRights "Send-As" -InheritanceType All


# Если контакт несимметричный
If (($EmailAddress -replace "@.+") -notlike $User)
{
	"Контакт несимметричный"
	# Добавление имени контакта @zaoeps.local в адреса почтового ящика пользователя
	$Addr = (Get-Mailbox $User).EmailAddresses
	$NotExistAddrForContact = $true # примем, что локального адреса для контакта в почтовом ящике не существует
	For ($i=0; $i -lt $Addr.Count; $i++)
	{
		If ((($Addr[$i].SmtpAddress -replace "@.+") -like ($EmailAddress -replace "@.+")) -and ($Addr[$i].PrefixString -like "smtp"))
		{$NotExistAddrForContact = $false}
	}
	If ($NotExistAddrForContact)
	{	# Если нет соттветсвующего внутреннего адреса для контакта в почтовом ящике пользователя, то добавляем его
		Set-Mailbox $User -EmailAddresses @{add = (($EmailAddress -replace "@.+")+"@zaoeps.local")}
		"Адрес "+(($EmailAddress -replace "@.+")+"@zaoeps.local")+" добавлен для ящика "+$User
	}
	Else
	{
		"Адрес "+(($EmailAddress -replace "@.+")+"@zaoeps.local")+" уже существует для ящика "+$User
	}
	
	# Добавление логина пользователя в описание несимметричного контакта
	Set-ADObject (Get-Contact -Identity $EmailAddress).Guid -Description $User
	"В описание контакта "+$EmailAddress+" добавлен логин пользователя "+$User
}
