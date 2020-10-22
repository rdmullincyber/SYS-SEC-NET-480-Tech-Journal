function createSwitch{
Param ([string]$h,[string]$n)
$esx_Hostname = Get-VMhost -Name $h
$virtualSwitch = New-VirtualSwitch -VMHost $esx_Hostname -Name $n -ErrorAction Ignore
New-VirtualPortGroup -VirtualSwitch $virtualSwitch -Name $n
}
