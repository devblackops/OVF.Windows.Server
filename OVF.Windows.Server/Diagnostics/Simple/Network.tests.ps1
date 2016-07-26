#require -modules poshspec

Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Network Adapters' {
    context 'Availability' {
        interface 'Ethernet' Status { should be up }
        interface 'Ethernet' LinkSpeed { should be '1 Gbps' }
    }
}
