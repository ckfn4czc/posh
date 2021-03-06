#Clear-Host

$SoftDeleted = Get-MailboxStatistics -Database "Disconnected Box" | Where {$_.DisconnectReason -eq "SoftDeleted"} | 
Select DisplayName, MailboxGuid, Database
$SoftDeleted | ForEach {Remove-StoreMailbox -Database $_.Database -Identity $_.MailboxGuid –MailboxState SoftDeleted}


#$Disabled = Get-MailboxStatistics -Database "Disconnected Box" | Where {$_.DisconnectReason -eq "Disabled"} |
#Select DisplayName, MailboxGuid, Database
#$Disabled #| ForEach {Remove-StoreMailbox -Database $_.Database -Identity $_.MailboxGuid –MailboxState Disabled -Confirm:$false}
