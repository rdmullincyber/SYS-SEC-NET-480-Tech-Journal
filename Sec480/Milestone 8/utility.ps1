$connection = Read-Host -Prompt 'Input your VI server'
Connect-VIServer -Server $connection
if (-not $?) {
    throw "Failed, make sure you are inputting the correct server or credentials"
}
function createSwitch{
    Param ([string]$h,[string]$n)
    $esx_Hostname = Get-VMhost -Name $h
    $virtualSwitch = New-VirtualSwitch -VMHost $esx_Hostname -Name $n -ErrorAction Ignore
    New-VirtualPortGroup -VirtualSwitch $virtualSwitch -Name $n
    }
function setNetwork{
        Param ([string]$vmname,[string]$preferredNetwork, [int] $numInterface)
        $vm = Get-VM -Name $vmname
        $interfaces = $vm | Get-NetworkAdapter
        $interfaces[$numInterface] | Set-NetworkAdapter -NetworkName $preferredNetwork
        }
function getIP{
            Param ([string]$vmname2)
            $vm = Get-VM -Name $vmname2
            $vm.Guest.IPAddress[0]
            write-host $vm.Guest.IPAddress[0] hostname=$vm.Name
            }
createSwitch -h "super15.cyber.local" -n "BLUE15-LAN" 
setNetwork -vmname "fw-blue15" -preferredNetwork "BLUE15-LAN" -numInterface 1
getIP -vmname2 fw-blue15 