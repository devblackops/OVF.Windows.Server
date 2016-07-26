#require -modules poshspec

param(
    $FreeRamMbytesThreshold = 500,
    $FreeSystemPageTableEntriesThreshold = 5000
)

Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Memory' {
    context 'Capacity' {
        it "MB Free should be greater than $FreeRamMbytesThreshold" {
            $freeRam = (Get-CimInstance -Query 'SELECT FreePhysicalMemory FROM Win32_OperatingSystem' | Select -ExpandProperty FreePhysicalMemory)/1KB
            $freeRam | should begreaterthan $FreeRamMbytesThreshold
        }

        it 'Free System Page Table Entries is greather than 5000' {
            $freeSPTE = (Get-Counter -Counter '\Memory\Free System Page Table Entries').CounterSamples[0].CookedValue
            $freeSPTE | should begreaterthan $FreeSystemPageTableEntriesThreshold
        }
    }
}
