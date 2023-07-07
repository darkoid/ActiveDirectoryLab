# Windows PowerShell script for AD DS Deployment
#

Import-ModuleADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-Databasepath "C: \windows \NTDS" `
-DomainMode "WinThreshold" `
-DomainName "marvel.com" `
-DomainNetbiosName "marvel" `
-ForestMode "WinThreshold" `
-Installons:$true `
-LogPath "C: \Windows \NTDS" `
-NoRebootonCompletion:$false `
-SysvolPath "C: \Windows\ SYSVOL" `
-Force: $true
