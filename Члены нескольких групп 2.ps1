Clear-Host
#$Groups = Get-ADGroup -SearchBase "OU=Факсы,OU=Группы доступа к ящикам,OU=Служебные группы,OU=ХОЛДИНГ,DC=zaoeps,DC=local" -Filter *
$Groups = Get-ADGroup -SearchBase "OU=Локальные администраторы,OU=Группы GPO,OU=Служебные группы,OU=ХОЛДИНГ,DC=zaoeps,DC=local" -Filter *
Foreach ($Group in $Groups)
{
	$Group.name
	Get-ADGroupMember -Identity $Group | %{$_.name}
	" "
}