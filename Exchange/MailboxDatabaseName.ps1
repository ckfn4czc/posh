$a=get-mailbox mkleimenov
#$a | fl
"Mailbox database: "+$a.Database.Name
"Archive database: "+$a.ArchiveDatabase.Name

$b=Get-MailboxStatistics mkleimenov -Archive