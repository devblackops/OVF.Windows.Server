# Define global variables used by tasks
properties {
    $projectRoot = $ENV:BHProjectPath
    $sut = "$projectRoot\OVF.Windows.Server"
    if(-not $projectRoot) {
        $projectRoot = $PSScriptRoot
    }
}

task Default -depends Test

Task Init {
    $lines
    Set-Location $ProjectRoot
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"
}

# Test entire project
task Test -depends Init, Analyze, Pester  {
}

task Analyze -Depends Init {
    $saResults = Invoke-ScriptAnalyzer -Path $sut -Severity Error -Recurse -Verbose:$false
    if ($saResults) {
        $saResults | Format-Table
        Write-Error -Message 'One or more Script Analyzer errors/warnings where found. Build cannot continue!'
    }
}

task Pester -Depends Init {   
    if(-not $ENV:BHProjectPath) {
        Set-BuildEnvironment -Path $PSScriptRoot\..
    }
    Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
    Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force

    $testResults = Invoke-Pester -Path $tests -PassThru
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
    }
}

task Deploy {
    Invoke-PSDeploy -Path .\ovf.psdeploy.ps1 -Verbose -Force
}
