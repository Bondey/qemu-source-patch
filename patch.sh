# git clone https://github.com/coreboot/seabios.git
# git clone --recursive https://github.com/qemu/qemu.git


# Path de bios tras make:
# "/usr/share/qemu/bios.bin"
# "/usr/share/qemu/bios-256k.bin" 


echo '[+] Patching QEMU clues'
if ! sed -i 's/CPUID_EXT_AES | CPUID_EXT_HYPERVISOR)/CPUID_EXT_AES)/g' qemu*/target/i386/cpu.c; then
    echo 'CPUID Hypervisor bit was not replaced in target/i386/cpu.c'; fail=1
fi
if ! sed -i 's/TCGTCGTCGTCG/GenuineIntel/g' qemu*/target/i386/cpu.c; then
    echo 'TCGTCGTCGTCG was not replaced in target/i386/cpu.c'; fail=1
fi
if ! sed -i 's/QEMU Virtual CPU version /Intel(R) Core(TM) i5-4460 CPU /g' qemu*/target/i386/cpu.c; then
    echo 'QEMU Virtual CPU was not replaced in target/i386/cpu.c'; fail=1
fi
if ! sed -i 's/QEMU HARDDISK/Hitachi HD6134A341/g' qemu*/hw/ide/core.c; then
    echo 'QEMU HARDDISK was not replaced in core.c'; fail=1
fi
if ! sed -i 's/QEMU HARDDISK/Hitachi HD6134A341/g' qemu*/hw/scsi/scsi-disk.c; then
    echo 'QEMU HARDDISK was not replaced in scsi-disk.c'; fail=1
fi
if ! sed -i 's/QEMU DVD-ROM/Asustek DVD-ROM/g' qemu*/hw/ide/core.c; then
    echo 'QEMU DVD-ROM was not replaced in core.c'; fail=1
fi
if ! sed -i 's/QEMU DVD-ROM/Asustek DVD-ROM/g' qemu*/hw/ide/atapi.c; then
    echo 'QEMU DVD-ROM was not replaced in atapi.c'; fail=1
fi
if ! sed -i 's/s->vendor = g_strdup("QEMU");/s->vendor = g_strdup("Asustek");/g' qemu*/hw/scsi/scsi-disk.c; then
    echo 'Vendor string was not replaced in scsi-disk.c'; fail=1
fi
if ! sed -i 's/QEMU CD-ROM/Asustek CD-ROM/g' qemu*/hw/scsi/scsi-disk.c; then
    echo 'QEMU CD-ROM was not patched in scsi-disk.c'; fail=1
fi
if ! sed -i 's/padstr8(buf + 8, 8, "QEMU");/padstr8(buf + 8, 8, "Asustek");/g' qemu*/hw/ide/atapi.c; then
    echo 'padstr was not replaced in atapi.c'; fail=1
fi
if ! sed -i 's/QEMU MICRODRIVE/Hitachi HD6134A341/g' qemu*/hw/ide/core.c; then
    echo 'QEMU MICRODRIVE was not replaced in core.c'; fail=1
fi
if ! sed -i 's/KVMKVMKVM\\0\\0\\0/GenuineIntel/g' qemu*/target/i386/kvm.c; then
    echo 'KVMKVMKVM was not replaced in kvm.c'; fail=1
fi
# by @http_error_418
if  sed -i 's/Microsoft Hv/GenuineIntel/g' qemu*/target/i386/kvm.c; then
    echo 'Microsoft Hv was not replaced in target/i386/kvm.c'; fail=1
fi
if ! sed -i 's/"bochs"/"hawks"/g' qemu*/block/bochs.c; then
    echo 'BOCHS was not replaced in block/bochs.c'; fail=1
fi
# by Tim Shelton (redsand) @ HAWK (hawk.io)
if ! sed -i 's/"BOCHS "/"ALASKA"/g' qemu*/include/hw/acpi/aml-build.h; then
    echo 'bochs was not replaced in include/hw/acpi/aml-build.h'; fail=1
fi
# by Tim Shelton (redsand) @ HAWK (hawk.io)
if ! sed -i 's/Bochs Pseudo/Intel RealTime/g' qemu*/roms/ipxe/src/drivers/net/pnic.c; then
    echo 'Bochs Pseudo was not replaced in roms/ipxe/src/drivers/net/pnic.c'; fail=1
fi


echo "[+] deleting BOCHS APCI tables"
echo "[+] Generating SeaBios Kconfig"
#./scripts/kconfig/merge_config.sh -o . >/dev/null 2>&1
#sed -i 's/CONFIG_ACPI_DSDT=y/CONFIG_ACPI_DSDT=n/g' .config
#sed -i 's/CONFIG_XEN=y/CONFIG_XEN=n/g' .config
echo "[+] Fixing SeaBios antivms"
if ! sed -i 's/Bochs/Megatrends/g' seabios/src/config.h; then
    echo 'Bochs was not replaced in seabios/src/config.h'; fail=1
fi
if ! sed -i 's/BOCHSCPU/IntelCore/g' seabios/src/config.h; then
    echo 'BOCHSCPU was not replaced in seabios/src/config.h'; fail=1
fi
if ! sed -i 's/"BOCHS "/"Megatrends"/g' seabios/src/config.h; then
    echo 'BOCHS was not replaced in seabios/src/config.h'; fail=1
fi
if ! sed -i 's/BXPC/Megatrends/g' seabios/src/config.h; then
    echo 'BXPC was not replaced in seabios/src/config.h'; fail=1
fi
if ! sed -i 's/QEMU0001/Megatrends/g' seabios/src/fw/ssdt-misc.dsl; then
    echo 'QEMU0001 was not replaced in seabios/src/fw/ssdt-misc.dsl'; fail=1
fi
if ! sed -i 's/QEMU\/Bochs/IntelCore\/Megatrends/g' seabios/vgasrc/Kconfig; then
    echo 'QEMU\/Bochs was not replaced in seabios/vgasrc/Kconfig'; fail=1
fi
if ! sed -i 's/qemu /Intelcore /g' seabios/vgasrc/Kconfig; then
    echo 'qemu was not replaced in seabios/vgasrc/Kconfig'; fail=1
fi

if ! sed -i 's/"QEMU/"Intelcore/g' "seabios/src/hw/blockcmd.c"; then
    echo "QEMU was not replaced in seabios/src/hw/blockcmd.c"; fail=1
fi

if ! sed -i 's/"QEMU/"Intelcore/g' "seabios/src/fw/paravirt.c"; then
    echo "QEMU was not replaced in seabios/src/fw/paravirt.c"; fail=1
fi

if ! sed -i 's/"QEMU"/"Intelcore"/g' "seabios/src/hw/blockcmd.c"; then
    echo '"QEMU" was not replaced in  seabios/src/hw/blockcmd.c'; fail=1
fi

if ! sed -i 's/"BXPC"/Intelcore"/g' "seabios/src/fw/acpi-dsdt.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/acpi-dsdt.dsl"; fail=1
fi
if ! sed -i 's/"BXDSDT"/"Intelcore"/g' "seabios/src/fw/acpi-dsdt.dsl"; then
    echo "BXDSDT was not replaced in seabios/src/fw/acpi-dsdt.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"Intelcore"/g' "seabios/src/fw/q35-acpi-dsdt.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/q35-acpi-dsdt.dsl"; fail=1
fi
if ! sed -i 's/"BXDSDT"/"Intelcore"/g' "seabios/src/fw/q35-acpi-dsdt.dsl"; then
    echo "BXDSDT was not replaced in seabios/src/fw/q35-acpi-dsdt.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"Intelcore"/g' "seabios/src/fw/ssdt-pcihp.dsl"; then
    echo 'BXPC was not replaced in src/fw/ssdt-pcihp.dsl'; fail=1
fi
if ! sed -i 's/"BXDSDT"/"Intelcore"/g' "seabios/src/fw/ssdt-pcihp.dsl"; then
    echo 'BXDSDT was not replaced in src/fw/ssdt-pcihp.dsl'; fail=1
fi
if ! sed -i 's/"BXPC"/"Intelcore"/g' "seabios/src/fw/ssdt-proc.dsl"; then
    echo 'BXPC was not replaced in "src/fw/ssdt-proc.dsl"'; fail=1
fi
if ! sed -i 's/"BXSSDT"/"Intelcore"/g' "seabios/src/fw/ssdt-proc.dsl"; then
    echo 'BXSSDT was not replaced in src/fw/ssdt-proc.dsl'; fail=1
fi
if ! sed -i 's/"BXPC"/"Intelcore"/g' "seabios/src/fw/ssdt-misc.dsl"; then
    echo 'BXPC was not replaced in src/fw/ssdt-misc.dsl'; fail=1
fi
if ! sed -i 's/"BXSSDTSU"/"Intelcore"/g' "seabios/src/fw/ssdt-misc.dsl"; then
    echo 'BXDSDT was not replaced in src/fw/ssdt-misc.dsl'; fail=1
fi
if ! sed -i 's/"BXSSDTSUSP"/"Intelcore"/g' seabios/src/fw/ssdt-misc.dsl; then
    echo 'BXSSDTSUSP was not replaced in src/fw/ssdt-misc.dsl'; fail=1
fi
if ! sed -i 's/"BXSSDT"/"Intelcore"/g' seabios/src/fw/ssdt-proc.dsl; then
    echo 'BXSSDT was not replaced in src/fw/ssdt-proc.dsl'; fail=1
fi
if ! sed -i 's/"BXSSDTPCIHP"/"Intelcore"/g' seabios/src/fw/ssdt-pcihp.dsl; then
    echo 'BXPC was not replaced in src/fw/ssdt-pcihp.dsl'; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/q35-acpi-dsdt.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/q35-acpi-dsdt.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/acpi-dsdt.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/acpi-dsdt.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/ssdt-misc.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/ssdt-misc.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/ssdt-proc.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/ssdt-proc.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/ssdt-pcihp.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/ssdt-pcihp.dsl"; fail=1
fi

if ! sed -i 's/"BXPC"/"A M I"/g' "seabios/src/fw/ssdt-pcihp.dsl"; then
    echo "BXPC was not replaced in seabios/src/fw/ssdt-pcihp.dsl"; fail=1
fi



# https://github.com/qemu/qemu/blob/master/target/i386/cpu.c QEMU Virtual CPU version
#                                          target/i386/cpu.c memcpy(signature, "TCGTCGTCGTCG", 12);
# TCGTCGTCGTCG
# Microsoft Hv
# 
# QEMU Virtual CPU version 
# Intel(R) Core(TM) i5-4460 CPU 
# 
# if  sed -i 's/TCGTCGTCGTCG/GenuineIntel/g' qemu*/target/i386/cpu.c; then
#     echo 'TCGTCGTCGTCG was not replaced in target/i386/cpu.c'; fail=1
# fi
# if  sed -i 's/QEMU Virtual CPU version /Intel(R) Core(TM) i5-4460 CPU /g' qemu*/target/i386/cpu.c; then
#     echo 'QEMU Virtual CPU was not replaced in target/i386/cpu.c'; fail=1
# fi
# 
# seabios/