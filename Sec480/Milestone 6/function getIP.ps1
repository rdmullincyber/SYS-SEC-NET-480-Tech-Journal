function getIP{
    Param ([string]$vmname)
    $vm = Get-VM -Name $vmname
    $vm.Guest.IPAddress[0]
    write-host $vm.Guest.IPAddress[0] hostname=$vm.Name
    }