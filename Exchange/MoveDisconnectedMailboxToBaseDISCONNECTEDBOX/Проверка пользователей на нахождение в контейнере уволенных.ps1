cls
$Userss = Get-Content d:\UserWithoutActiveBox.txt
Foreach ($Users in $Userss)
{
	$User = $Users -replace " ARCHIV.+"
	# Если учетная запись пользователя уже не находится к контейнере уволенных - сообщаем об этом и больше ничего не делаем
	If ( (get-aduser  -Filter {name -like $User} -Properties DistinguishedName).DistinguishedName -like "*,OU=Уволенные,OU=Пользователи,OU=ХОЛДИНГ,DC=zaoeps,DC=local" )
	{	
		"ОК: "+$User
	}
	Else
	{	
		"Учетная запись пользователя '"+$User+"' не находится в контейнере уволенных!"
	}
}