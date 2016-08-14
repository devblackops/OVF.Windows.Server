#require -modules poshspec

param(
    [string[]]$Interfaces = (Get-NetAdapter -Physical).Name
)

Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Network Adapters' {
    context 'Availability' {
        $adapters = Get-NetAdapter -Name $Interfaces -Physical
        $adapters | % {
            interface $_.Name Status { should be up }
        }
    }
}
