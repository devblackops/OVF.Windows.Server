#require -modules poshspec

Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Operating System' {
    context 'Availability' {
        service DHCP status { should be running }
        service DNSCache status { should be running }
        service Eventlog status { should be running }
        service PlugPlay status { should be running }
        service RpcSs status { should be running }
        service lanmanserver status { should be running }
        service LmHosts status { should be running }
        service Lanmanworkstation status { should be running }
        service MpsSvc status { should be running }
        service WinRM status { should be running }
    }
}
