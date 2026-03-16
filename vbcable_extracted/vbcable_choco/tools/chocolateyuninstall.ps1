$ErrorActionPreference = 'Stop'
$toolsDir = split-path -parent $MyInvocation.MyCommand.Definition

if ((([environment]::OSVersion.version.major) -eq 6) -And (([environment]::OSVersion.version.minor) -eq 1)) {
  $inf = Join-Path $toolsDir "vbMmeCable_win7.inf"
} else {
  $inf = Join-Path $toolsDir "vbMmeCable_2003.inf"
}

$rundll = Join-Path (Join-Path $Env:SystemRoot "System32") "rundll32.exe"
Start-ChocolateyProcessAsAdmin "SETUPAPI.DLL,InstallHinfSection DefaultUninstall 132 $inf" "$rundll"
