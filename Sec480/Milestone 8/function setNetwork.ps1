function setNetwork{
    Param ([string]$vmname,[string]$preferredNetwork, [int] $numInterface)
    $vm = Get-VM -Name $vmname
    $interfaces = $vm | Get-NetworkAdapter
    $interfaces[$numInterface] | Set-NetworkAdapter -NetworkName $preferredNetwork
    }