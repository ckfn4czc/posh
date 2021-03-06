cls

$Groups = Get-DistributionGroup

Foreach ($Group in $Groups)
{
	$Members = Get-DistributionGroup -Identity $Group.Name | select AcceptMessagesOnlyFromSendersOrMembers
	If ($Members.AcceptMessagesOnlyFromSendersOrMembers.Count -gt 0) {Write-Host $Group.Name -ForegroundColor DarkGreen}
	For ($i=0; $i -lt $Members.AcceptMessagesOnlyFromSendersOrMembers.Count; $i++)
	{
		$Members.AcceptMessagesOnlyFromSendersOrMembers[$i].Name
	}
}
