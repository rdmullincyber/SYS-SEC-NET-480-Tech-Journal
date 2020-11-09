function getMAC{
    Param ([string]$vmname,[string] $InterfaceChoice)
    $vm = Get-VM -Name $vmname
    $vm | Get-NetworkAdapter| Select-Object NETWORKNAME, MacAddress
    }