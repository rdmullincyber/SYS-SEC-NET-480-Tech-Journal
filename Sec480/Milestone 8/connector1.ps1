$connection = Read-Host -Prompt 'Input your VI server'
Connect-VIServer -Server $connection
if (-not $?) {
    throw "Failed, make sure you are inputting the correct server or credentials"
}
Get-VM -Server $connection| Select-Object -Property Name,Notes,VMHost,Guest
$basevmq = Read-Host -Prompt 'Which VM would you like to use'
$basevm = Get-VM -Name "$basevmq"
if (-not $?) {
    throw "Failed, make sure you are inputting the correct VM name"
}
$snapshotq = Read-Host -Prompt 'Which snapshot would you like to use'
$snapshot = Get-Snapshot -VM $basevm -Name "$snapshotq"
if (-not $?) {
    throw "Failed, make sure you are inputting the correct snapshot"
}
$vmhostq = Read-Host -Prompt 'What is your VMhost name'
$vmhost = Get-VMHost -Name "$vmhostq"
if (-not $?) {
    throw "Failed, make sure you are inputting the VM Host Name"
}
$dstoreq = Read-Host -Prompt 'What is your dstore name'
$dstore = Get-Datastore -Name "$dstoreq"
if (-not $?) {
    throw "Failed, make sure you are inputting the correct Datastore Name"
}
$folderq = Read-Host -Prompt 'What is your folder name'
$folder = Get-Folder -Name "$folderq"
$question = Read-Host -Prompt "Would you like to create a Full or Linked Clone? (F or L)"
if ($question -eq 'L'){
    $newvmq = Read-Host -Prompt 'what do you want to name your new vm'
    $newvm = New-VM -Name "$newvmq.tmp" -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $dstore -Location $folder
    Write-Host "Complete"
}
if ($question -eq 'F'){
    $newvmq = Read-Host -Prompt 'what do you want to name your new vm'
    $newvm = New-VM -Name "$newvmq.tmp" -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $dstore -Location $folder
    New-VM -Name "$newvmq" -VM $newvm -VMHost $vmhost -Datastore $dstore -Location $folder
    Remove-VM -VM "$newvmq.tmp" -DeletePermanently
    Write-Host "Complete"
}
