$projectPath = ""
$configPath = ""
try {
  $version = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo.FileVersion
  if(-not $version) {
    Write-Output "No installed version of Chrome found"
    exit 1
  }
}
catch{
    Write-Output "No installed version of Chrome found"
    exit 1
}
$Major = $version.Split(".")[0]
$nugetPackages = (Find-Package Selenium.WebDriver.ChromeDriver -Source https://nuget.org/api/v2 -AllVersions | findstr -firc:". ${Major}\."
if($nugetPackages.Count -eq 0) {
  Write-Output "Unable to find matching nuget package for version ${Major}"
  exit 1
}
$versionToGoTo = $nugetPackages[0].Split(" ")[1]
nuget update $configPath -Id Selenium.WebDriver.ChromeDriver $projectPath -Source https://nuget.org/api/v2 -Version $versionToGoTo
