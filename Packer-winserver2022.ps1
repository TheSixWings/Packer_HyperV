# Build images

# Get Start Time
$startDTM = (Get-Date)

# Variables
$OS = "winserver2022"
$machine = "Windows Server 2022 Datacenter Gen-2 Vagrant"

$template_file = ".\Templates\$OS\Template.pkr.hcl"
$var_file = ".\Templates\$OS\Variables.pkr.hcl"
$vbox = ".\VagrantBox\packer-$OS.box"
$vbox_checksum = ".\VagrantBox\packer-$OS.box.sha256"
$packer_log = 0

Write-Host "Build secondary.iso for Windows VM on Hyper-V"
.\Scripts\New-IsoFile.ps1 ".\Templates\$OS\XML\Autounattend.xml",".\Scripts\Hyper-V\bootstrap.ps1" -Path ".\Templates\$OS\secondary.iso" -Force
Write-Host "secondary.iso created."

# Packer Script

if ((Test-Path -Path "$template_file") -and (Test-Path -Path "$var_file")) {
  Write-Output "Template and var file found"
  Write-Output "Building: $machine"
  try {
    $env:PACKER_LOG=$packer_log
    packer validate -var-file="$var_file" "$template_file"
  }
  catch {
    Write-Output "Packer validation failed, exiting."
    exit (-1)
  }
  try {
    $env:PACKER_LOG=$packer_log
    packer version
    packer build --force -var-file="$var_file" "$template_file"
    if ($?) {
      Write-Output "Calculating checksums"
      Get-FileHash -Algorithm SHA256 -Path "$vbox"|Out-File "$vbox_checksum" -Verbose
    }
  }
  catch {
    Write-Output "Packer build failed, exiting."
    exit (-1)
  }
}
else {
  Write-Output "Template or Var file not found - exiting"
  exit (-1)
}

$endDTM = (Get-Date)
Write-Host "[INFO]  - Elapsed Time: $(($endDTM-$startDTM).totalseconds) seconds" -ForegroundColor Yellow
