$connection = Read-Host -Prompt 'Input your VI server'
Connect-VIServer -Server $connection
$basevmq = Read-Host -Prompt 'Which VM would you like to use'
$basevm = Get-VM -Name "$basevmq"
$snapshotq = Read-Host -Prompt 'Which snapshot would you like to use'
$snapshot = Get-Snapshot -VM $basevm -Name "$snapshotq"
$vmhostq = Read-Host -Prompt 'What is your VMhost name'
$vmhost = Get-VMHost -Name "$vmhostq"
$dstoreq = Read-Host -Prompt 'What is your dstore name'
$dstore = Get-Datastore -Name "$dstoreq"
$folderq = Read-Host -Prompt 'What is your folder name'
$folder = Get-Folder -Name "$folderq"
$newvmq = Read-Host -Prompt 'what do you want to name your new vm'
$newvm = New-VM -Name "$newvmq" -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $dstore -Location $folder
Write-Host "Complete"