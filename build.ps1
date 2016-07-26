[cmdletbinding()]
param(
    [string[]]$Task = 'default'
)

Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
$modules = 'BuildHelpers', 'Pester', 'psake', 'PSDeploy'
$modules | % {
    if (!(Get-Module -Name $_ -ListAvailable)) { Install-Module -Name $_ -Repository PSGallery}
    Import-Module $_ -Verbose:$false
}

Set-BuildEnvironment

Import-Module psake -Verbose:$false
$psake.use_exit_on_error = $true
Invoke-psake -buildFile "$PSScriptRoot\psake.ps1" -taskList $task -nologo -Verbose:$VerbosePreference
if ($psake.build_success -eq $false) { exit 1 } else { exit 0 }