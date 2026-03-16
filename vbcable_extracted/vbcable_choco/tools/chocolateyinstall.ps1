$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$toolsDir"

  url           = 'https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip'
  checksum      = '66FD0A4D9F4896FF41632B7E3D53892C085C4561F53E8AE8D0F0BC10EEDD1CDD'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Don't create shims for executables
$files = Get-ChildItem "$toolsDir" -Recurse -Include *.exe
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}

if ((([environment]::OSVersion.version.major) -eq 6) -And (([environment]::OSVersion.version.minor) -eq 1)) {
  $inf = Join-Path $toolsDir "vbMmeCable_win7.inf"
} else {
  $inf = Join-Path $toolsDir "vbMmeCable_2003.inf"
}

$rundll = Join-Path (Join-Path $Env:SystemRoot "System32") "rundll32.exe"
Start-ChocolateyProcessAsAdmin "advpack.dll,LaunchINFSectionEx $inf,,,4" "$rundll"
