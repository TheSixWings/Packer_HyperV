iso_url="D:/Shares/Share/ISO/en-us_windows_server_2022_updated_feb_2022_x64_dvd_d4a089c1.iso"
iso_checksum_type="sha256"
iso_checksum="5140AC5FB8F48EFDF4BFCF1E7BE14030F9164A824F12A9D08A45CDC72DAC8D15"
switch_name="VMnet8"
vlan_id=""
vm_name="packer-winserver2022"
disk_size="80000"
output_directory="output-winserver2022"
secondary_iso_image="./Templates/winserver2022/secondary.iso"
output_vagrant="./VagrantBox/packer-winserver2022.box"
vagrantfile_template="./Templates/winserver2022/vagrantfile.template"
sysprep_unattended="./Templates/winserver2022/XML/unattend.xml"
vagrant_sysprep_unattended="./Templates/winserver2022/XML/unattend_vagrant.xml"
upgrade_timeout="120"