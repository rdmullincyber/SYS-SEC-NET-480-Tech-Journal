interfaces {
    ethernet eth0 {
        address 192.168.3.55/24
        hw-id 00:0c:29:e2:7c:b2
    }
    ethernet eth1 {
        address 10.0.17.2/24
        hw-id 00:0c:29:e2:7c:bc
    }
    loopback lo {
    }
}
nat {
    source {
        rule 10 {
            description "NAT to Cyber"
            outbound-interface eth0
            source {
                address 10.0.17.0/24
            }
            translation {
                address masquerade
            }
        }
    }
}
protocols {
    static {
        route 0.0.0.0/0 {
            next-hop 192.168.3.250 {
            }
        }
    }
}
service {
    dns {
        forwarding {
            allow-from 10.0.17.0/24
            listen-address 10.0.17.2
            system
        }
    }
}
system {
    config-management {
        commit-revisions 100
    }
    console {
        device ttyS0 {
            speed 115200
        }
    }
    host-name 480-fw15
    login {
        user vyos {
            authentication {
                encrypted-password $6$vcjvTTBYSf/$aC/Yh/gm0VSyXOav4sBlzpe0oH2UV4G.IDvbPpqEMeMFX85wigd8OqTq5AUbDT/hUlD.alf/ERmHWJ/0V.BcL.
                plaintext-password ""
            }
        }
    }
    name-server 192.168.4.4
    name-server 192.168.4.5
    ntp {
        server 0.pool.ntp.org {
        }
        server 1.pool.ntp.org {
        }
        server 2.pool.ntp.org {
        }
    }
    syslog {
        global {
            facility all {
                level info
            }
            facility protocols {
                level debug
            }
        }
    }
}


// Warning: Do not remove the following line.
// vyos-config-version: "broadcast-relay@1:cluster@1:config-management@1:conntrack@1:conntrack-sync@1:dhcp-relay@2:dhcp-server@5:dhcpv6-server@1:dns-forwarding@3:firewall@5:https@2:interfaces@11:ipoe-server@1:ipsec@5:l2tp@3:lldp@1:mdns@1:nat@5:ntp@1:pppoe-server@3:pptp@2:qos@1:quagga@6:salt@1:snmp@1:ssh@1:sstp@2:system@18:vrrp@2:vyos-accel-ppp@2:wanloadbalance@3:webgui@1:webproxy@2:zone-policy@1"
// Release version: 1.3-rolling-202007010117
