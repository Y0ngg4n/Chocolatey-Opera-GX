$version = '63.0.3368.56078'

$checksumUrl = 'https://get.geo.opera.com/pub/opera_gx/' + $version + '/win/Opera_GX_' + $version + '_Setup.exe.sha256sum'
$checksum64Url = 'https://get.geo.opera.com/pub/opera_gx/' + $version + '/win/Opera_GX_' + $version + '_Setup_x64.exe.sha256sum'

$WebRespone = Invoke-WebRequest $checksumUrl

$checksum   = $WebRespone.ToString()

$WebRespone = Invoke-WebRequest $checksum64Url 

$checksum64 = $WebRespone.ToString()

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_VERSION#', $version |
  Out-File tools/chocolateyinstall.ps1

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_CHECKSUM#', $checksum `
    -replace '#REPLACE_CHECKSUM_64#', $checksum64 |
  Out-File tools/chocolateyinstall.ps1

(Get-Content operagx.nuspec) `
    -replace '#REPLACE_VERSION#', $version |
Out-File operagx.nuspec

choco pack