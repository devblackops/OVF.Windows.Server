#require -modules poshspec

param(
    $FreeSystemDriveMBytesThreshold = 500,
    $FreeSystemDrivePctThreshold = .05,
    $FreeNonSystemDriveMBytesThreshold = 1000,
    $FreeNonSystemDrivePctThreshold = .05
)

Import-Module -Name poshspec -Verbose:$false -ErrorAction Stop

describe 'Logical Disks' {

    $vols = Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and $_.FileSystemLabel -ne 'System Reserved' }
    context 'Availablity' {
        $vols | % {
            it "Volume [$($_.DriveLetter)] is healthy" {
                $_.HealthStatus | should be 'Healthy'
            }
        }
    }

    context 'Capacity' {
        $systemDriveLetter = $env:SystemDrive.Substring(0, 1)
        $sysVol = $vols | Where DriveLetter -eq $systemDriveLetter
        $nonSysVols = $vols | Where DriveLetter -ne $systemDriveLetter

        it "System drive [$systemDriveLetter] has $FreeSystemDriveMBytesThreshold MB and $('{0:p0}' -f $FreeSystemDrivePctThreshold) free" {
            ($sysVol.SizeRemaining / 1MB) -ge $FreeSystemDriveMBytesThreshold | should be $true
            ($sysVol.SizeRemaining / $sysVol.Size) -ge $FreeSystemDriveThresholdPct | should be $true
        }

        foreach ($volume in $nonSysVols) {
            $driveLetter = $volume.DriveLetter
            it "Non-System drive [$driveLetter] has greater than $FreeNonSystemDriveMBytesThreshold MB and $('{0:p0}' -f $FreeNonSystemDrivePctThreshold) free" {
                ($volume.SizeRemaining / 1MB) -ge $FreeNonSystemDriveThreshold | should be $true
                ($volume.SizeRemaining / $volume.Size) -ge $FreeNonSystemDriveThresholdPct | should be $true
            }
        }
    }
}
