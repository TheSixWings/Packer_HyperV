#https://www.petri.com/manage-windows-updates-with-powershell-module
#install Windows Updates
# For test run disable updates
# exit

Write-Output "Phase-4 [START] - Updates"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
try {
    Write-Output "Phase-4 [INFO] - Installing Nuget"
    Get-PackageProvider -Name "Nuget" -ForceBootstrap -Verbose -ErrorAction Stop
}
catch {
    Write-Output "Phase-4 [WARN] - Installation of nuget failed, exiting"
}
try {
    Write-Output "Phase-4 [INFO] - Installing PSWindowsUpdate"
    Install-Module PSWindowsUpdate -Force -Confirm:$false -Verbose -ErrorAction Stop
    Import-Module PSWindowsUpdate
    Get-WUServiceManager
}
catch {
    Write-Output "Phase-4 [INFO]- Installation of PSWindowsUpdate failed, exiting"
    exit (1)
}
try {
    Write-Output "Phase-4 [INFO] - Updating process started"

    Write-Output "Install all updatres"
    Install-WindowsUpdate -AcceptAll -IgnoreReboot -ErrorAction SilentlyContinue
    #Get-WUHistory

    Write-Output "Phase-4 [INFO] - Updating process completed"
}
catch {
    Write-Output "Phase-4 [WARN] - Updating process failed, not critical"
    exit (0)
}

Write-Output "Phase-4 [END] - Updates"
exit 0
