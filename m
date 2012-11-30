From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Runtime PM/PCI D3 issue
Date: Fri, 30 Nov 2012 13:36:00 -0800
Message-ID: <20121130213600.GA5056@xanatos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been trying to test D3 on the xHCI host controller for my Lenovo
x230 laptop.  However, the host controller (and other PCI devices) never
seem to go into D3.  This happens on a modified version of 3.7-rc6
(Greg KH's usb-next branch plus a couple patches) and on 3.6.6.

I enable runtime PM for the PCI device:

root@xanatos:/sys/bus/pci/devices# echo auto > 0000:00:14.0/power/control
root@xanatos:/sys/bus/pci/devices# cat 0000:00:14.0/power/control
auto

Both the USB 2.0 and USB 3.0 bus children under the xHCI host controller
are also set to auto runtime PM:

root@xanatos:/sys/bus/pci/devices# lsusb -t
3-1.6:1.0: No such file or directory
3-1.6:1.1: No such file or directory
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 480M
root@xanatos:/sys/bus/pci/devices# cat /sys/bus/usb/devices/usb1/power/control
auto
root@xanatos:/sys/bus/pci/devices# cat /sys/bus/usb/devices/usb2/power/control
auto

But dmesg never shows the bus or host being suspended.  The
runtime_status remains active, and the runtime_suspended_time remains at
zero.  There are no USB devices under the xHCI host, so I'm not sure why
the host isn't being suspended.  Is there some new runtime PM sysfs file
that I'm missing?

I'm not sure if it's related, but dmesg from early boot shows that ASPM
is being disabled:

Nov 30 12:19:23 xanatos kernel: [    0.406306]  pci0000:00: Requesting ACPI _OSC control (0x1d)
Nov 30 12:19:23 xanatos kernel: [    0.406558]  pci0000:00: ACPI _OSC request failed (AE_SUPPORT), returned control mask: 0x0d
Nov 30 12:19:23 xanatos kernel: [    0.406559] ACPI _OSC control for PCIe not granted, disabling ASPM

I attempted to force ASPM on with the pcie_aspm=force command line
option, but the log file shows:

Nov 30 13:06:08 xanatos kernel: [    0.212186] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it

dmesg, .config, and lspci are attached.  Any pointers as to how I can
get the host into D3 are appreciated.

Sarah Sharp

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="d3-disabled-dmesg.txt"

Nov 30 12:18:54 xanatos kernel: Kernel logging (proc) stopped.
Nov 30 12:19:23 xanatos kernel: imklog 5.8.6, log source = /proc/kmsg started.
Nov 30 12:19:23 xanatos kernel: [    0.000000] Initializing cgroup subsys cpuset
Nov 30 12:19:23 xanatos kernel: [    0.000000] Initializing cgroup subsys cpu
Nov 30 12:19:23 xanatos kernel: [    0.000000] Linux version 3.7.0-rc6+ (sarah@xanatos) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #984 SMP PREEMPT Fri Nov 30 11:50:31 PST 2012
Nov 30 12:19:23 xanatos kernel: [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.7.0-rc6+ root=UUID=1fbe6830-593c-44fd-af78-f7d2d6a83746 ro quiet splash vt.handoff=7
Nov 30 12:19:23 xanatos kernel: [    0.000000] KERNEL supported cpus:
Nov 30 12:19:23 xanatos kernel: [    0.000000]   Intel GenuineIntel
Nov 30 12:19:23 xanatos kernel: [    0.000000]   AMD AuthenticAMD
Nov 30 12:19:23 xanatos kernel: [    0.000000]   Centaur CentaurHauls
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: BIOS-provided physical RAM map:
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000040003fff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000040004000-0x0000000040004fff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000040005000-0x00000000cec2ffff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000cec30000-0x00000000dae9efff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000dae9f000-0x00000000daf9efff] ACPI NVS
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000daf9f000-0x00000000daffefff] ACPI data
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000df9fffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000011e5fffff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] NX (Execute Disable) protection: active
Nov 30 12:19:23 xanatos kernel: [    0.000000] DMI 2.7 present.
Nov 30 12:19:23 xanatos kernel: [    0.000000] DMI: LENOVO 2325AP7/2325AP7, BIOS G2ET82WW (2.02 ) 09/11/2012
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
Nov 30 12:19:23 xanatos kernel: [    0.000000] No AGP bridge found
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: last_pfn = 0x11e600 max_arch_pfn = 0x400000000
Nov 30 12:19:23 xanatos kernel: [    0.000000] MTRR default type: uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000] MTRR fixed ranges enabled:
Nov 30 12:19:23 xanatos kernel: [    0.000000]   00000-9FFFF write-back
Nov 30 12:19:23 xanatos kernel: [    0.000000]   A0000-BFFFF uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000]   C0000-FFFFF write-protect
Nov 30 12:19:23 xanatos kernel: [    0.000000] MTRR variable ranges enabled:
Nov 30 12:19:23 xanatos kernel: [    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
Nov 30 12:19:23 xanatos kernel: [    0.000000]   1 base 000000000 mask F80000000 write-back
Nov 30 12:19:23 xanatos kernel: [    0.000000]   2 base 080000000 mask FC0000000 write-back
Nov 30 12:19:23 xanatos kernel: [    0.000000]   3 base 0C0000000 mask FE0000000 write-back
Nov 30 12:19:23 xanatos kernel: [    0.000000]   4 base 0DC000000 mask FFC000000 uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000]   5 base 0DB000000 mask FFF000000 uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000]   6 base 100000000 mask FE0000000 write-back
Nov 30 12:19:23 xanatos kernel: [    0.000000]   7 base 11F000000 mask FFF000000 uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000]   8 base 11E800000 mask FFF800000 uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000]   9 base 11E600000 mask FFFE00000 uncachable
Nov 30 12:19:23 xanatos kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: last_pfn = 0xcec30 max_arch_pfn = 0x400000000
Nov 30 12:19:23 xanatos kernel: [    0.000000] initial memory mapped: [mem 0x00000000-0x1fffffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
Nov 30 12:19:23 xanatos kernel: [    0.000000] init_memory_mapping: [mem 0x00000000-0xcec2ffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]  [mem 0x00000000-0xcebfffff] page 2M
Nov 30 12:19:23 xanatos kernel: [    0.000000]  [mem 0xcec00000-0xcec2ffff] page 4k
Nov 30 12:19:23 xanatos kernel: [    0.000000] kernel direct mapping tables up to 0xcec2ffff @ [mem 0x1fffa000-0x1fffffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] init_memory_mapping: [mem 0x100000000-0x11e5fffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]  [mem 0x100000000-0x11e5fffff] page 2M
Nov 30 12:19:23 xanatos kernel: [    0.000000] kernel direct mapping tables up to 0x11e5fffff @ [mem 0xcec2e000-0xcec2ffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] RAMDISK: [mem 0x3143e000-0x34a16fff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: RSDP 00000000000f0120 00024 (v02 LENOVO)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: XSDT 00000000daffe170 000BC (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: FACP 00000000dafe6000 0010C (v05 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: DSDT 00000000dafe8000 10E11 (v01 LENOVO TP-G2    00002020 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: FACS 00000000daf5a000 00040
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SLIC 00000000daffd000 00176 (v01 LENOVO TP-G2    00002020 PTL  00000001)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: TCPA 00000000daffc000 00032 (v02    PTL   LENOVO 06040000 LNVO 00000001)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SSDT 00000000daffb000 00408 (v01 LENOVO TP-SSDT2 00000200 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SSDT 00000000daffa000 00033 (v01 LENOVO TP-SSDT1 00000100 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SSDT 00000000daff9000 007A8 (v01 LENOVO SataAhci 00001000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: HPET 00000000dafe4000 00038 (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: APIC 00000000dafe3000 00098 (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: MCFG 00000000dafe2000 0003C (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: ECDT 00000000dafe1000 00052 (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: FPDT 00000000dafe0000 00064 (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: ASF! 00000000dafe7000 000A5 (v32 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: UEFI 00000000dafdf000 0003E (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: UEFI 00000000dafde000 00042 (v01 PTL      COMBUF 00000001 PTL  00000001)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: POAT 00000000dafdd000 00055 (v03 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SSDT 00000000dafdc000 00C79 (v01  PmRef  Cpu0Ist 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: SSDT 00000000dafdb000 00A7E (v01  PmRef    CpuPm 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: UEFI 00000000dafda000 002A6 (v01 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: DBG2 00000000dafd9000 000E9 (v00 LENOVO TP-G2    00002020 PTL  00000002)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Nov 30 12:19:23 xanatos kernel: [    0.000000]  [ffffea0000000000-ffffea00047fffff] PMD -> [ffff88011a000000-ffff88011dbfffff] on node 0
Nov 30 12:19:23 xanatos kernel: [    0.000000] Zone ranges:
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   Normal   [mem 0x100000000-0x11e5fffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] Movable zone start for each node
Nov 30 12:19:23 xanatos kernel: [    0.000000] Early memory node ranges
Nov 30 12:19:23 xanatos kernel: [    0.000000]   node   0: [mem 0x00010000-0x0009cfff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   node   0: [mem 0x20200000-0x40003fff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   node   0: [mem 0x40005000-0xcec2ffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000]   node   0: [mem 0x100000000-0x11e5fffff]
Nov 30 12:19:23 xanatos kernel: [    0.000000] On node 0 totalpages: 970684
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA zone: 64 pages used for memmap
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA zone: 6 pages reserved
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA zone: 3911 pages, LIFO batch:0
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA32 zone: 16320 pages used for memmap
Nov 30 12:19:23 xanatos kernel: [    0.000000]   DMA32 zone: 825967 pages, LIFO batch:31
Nov 30 12:19:23 xanatos kernel: [    0.000000]   Normal zone: 1944 pages used for memmap
Nov 30 12:19:23 xanatos kernel: [    0.000000]   Normal zone: 122472 pages, LIFO batch:31
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x408
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: NR_CPUS/possible_cpus limit of 2 reached.  Processor 2/0x2 ignored.
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: NR_CPUS/possible_cpus limit of 2 reached.  Processor 3/0x3 ignored.
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Nov 30 12:19:23 xanatos kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: IRQ0 used by override.
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: IRQ2 used by override.
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: IRQ9 used by override.
Nov 30 12:19:23 xanatos kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Nov 30 12:19:23 xanatos kernel: [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] smpboot: 8 Processors exceeds NR_CPUS limit of 2
Nov 30 12:19:23 xanatos kernel: [    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
Nov 30 12:19:23 xanatos kernel: [    0.000000] nr_irqs_gsi: 40
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 0000000040004000 - 0000000040005000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000cec30000 - 00000000dae9f000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000dae9f000 - 00000000daf9f000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000daf9f000 - 00000000dafff000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000dafff000 - 00000000dfa00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000dfa00000 - 00000000f8000000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed08000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed08000 - 00000000fed09000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed09000 - 00000000fed10000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed1a000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffc00000
Nov 30 12:19:23 xanatos kernel: [    0.000000] PM: Registered nosave memory: 00000000ffc00000 - 0000000100000000
Nov 30 12:19:23 xanatos kernel: [    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devices
Nov 30 12:19:23 xanatos kernel: [    0.000000] Booting paravirtualized kernel on bare hardware
Nov 30 12:19:23 xanatos kernel: [    0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
Nov 30 12:19:23 xanatos kernel: [    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88011e200000 s81024 r8192 d21376 u1048576
Nov 30 12:19:23 xanatos kernel: [    0.000000] pcpu-alloc: s81024 r8192 d21376 u1048576 alloc=1*2097152
Nov 30 12:19:23 xanatos kernel: [    0.000000] pcpu-alloc: [0] 0 1 
Nov 30 12:19:23 xanatos kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 952350
Nov 30 12:19:23 xanatos kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.7.0-rc6+ root=UUID=1fbe6830-593c-44fd-af78-f7d2d6a83746 ro quiet splash vt.handoff=7
Nov 30 12:19:23 xanatos kernel: [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.000000] __ex_table already sorted, skipping sort
Nov 30 12:19:23 xanatos kernel: [    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
Nov 30 12:19:23 xanatos kernel: [    0.000000] Checking aperture...
Nov 30 12:19:23 xanatos kernel: [    0.000000] No AGP bridge found
Nov 30 12:19:23 xanatos kernel: [    0.000000] Memory: 3674424k/4691968k available (5363k kernel code, 809232k absent, 208312k reserved, 5371k data, 596k init)
Nov 30 12:19:23 xanatos kernel: [    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Nov 30 12:19:23 xanatos kernel: [    0.000000] Preemptible hierarchical RCU implementation.
Nov 30 12:19:23 xanatos kernel: [    0.000000] NR_IRQS:4352 nr_irqs:512 16
Nov 30 12:19:23 xanatos kernel: [    0.000000] Extended CMOS year: 2000
Nov 30 12:19:23 xanatos kernel: [    0.000000] Console: colour dummy device 80x25
Nov 30 12:19:23 xanatos kernel: [    0.000000] console [tty0] enabled
Nov 30 12:19:23 xanatos kernel: [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... MAX_LOCK_DEPTH:          48
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... CLASSHASH_SIZE:          4096
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
Nov 30 12:19:23 xanatos kernel: [    0.000000] ... CHAINHASH_SIZE:          16384
Nov 30 12:19:23 xanatos kernel: [    0.000000]  memory used by lock dependency info: 5823 kB
Nov 30 12:19:23 xanatos kernel: [    0.000000]  per task-struct memory footprint: 1920 bytes
Nov 30 12:19:23 xanatos kernel: [    0.000000] hpet clockevent registered
Nov 30 12:19:23 xanatos kernel: [    0.000000] tsc: Fast TSC calibration using PIT
Nov 30 12:19:23 xanatos kernel: [    0.004000] tsc: Detected 2593.949 MHz processor
Nov 30 12:19:23 xanatos kernel: [    0.000001] Calibrating delay loop (skipped), value calculated using timer frequency.. 5187.89 BogoMIPS (lpj=10375796)
Nov 30 12:19:23 xanatos kernel: [    0.000004] pid_max: default: 32768 minimum: 301
Nov 30 12:19:23 xanatos kernel: [    0.000048] Mount-cache hash table entries: 256
Nov 30 12:19:23 xanatos kernel: [    0.000342] Initializing cgroup subsys cpuacct
Nov 30 12:19:23 xanatos kernel: [    0.000343] Initializing cgroup subsys freezer
Nov 30 12:19:23 xanatos kernel: [    0.000372] CPU: Physical Processor ID: 0
Nov 30 12:19:23 xanatos kernel: [    0.000373] CPU: Processor Core ID: 0
Nov 30 12:19:23 xanatos kernel: [    0.000377] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
Nov 30 12:19:23 xanatos kernel: [    0.000377] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
Nov 30 12:19:23 xanatos kernel: [    0.000721] process: using mwait in idle threads
Nov 30 12:19:23 xanatos kernel: [    0.000723] Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
Nov 30 12:19:23 xanatos kernel: [    0.000723] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
Nov 30 12:19:23 xanatos kernel: [    0.000723] tlb_flushall_shift: 1
Nov 30 12:19:23 xanatos kernel: [    0.000865] Freeing SMP alternatives: 20k freed
Nov 30 12:19:23 xanatos kernel: [    0.001490] ACPI: Core revision 20120913
Nov 30 12:19:23 xanatos kernel: [    0.018259] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Nov 30 12:19:23 xanatos kernel: [    0.057867] smpboot: CPU0: Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz (fam: 06, model: 3a, stepping: 09)
Nov 30 12:19:23 xanatos kernel: [    0.164483] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events, Intel PMU driver.
Nov 30 12:19:23 xanatos kernel: [    0.164493] ... version:                3
Nov 30 12:19:23 xanatos kernel: [    0.164494] ... bit width:              48
Nov 30 12:19:23 xanatos kernel: [    0.164495] ... generic registers:      4
Nov 30 12:19:23 xanatos kernel: [    0.164496] ... value mask:             0000ffffffffffff
Nov 30 12:19:23 xanatos kernel: [    0.164497] ... max period:             000000007fffffff
Nov 30 12:19:23 xanatos kernel: [    0.164497] ... fixed-purpose events:   3
Nov 30 12:19:23 xanatos kernel: [    0.164498] ... event mask:             000000070000000f
Nov 30 12:19:23 xanatos kernel: [    0.196500] SMP alternatives: lockdep: fixing up alternatives
Nov 30 12:19:23 xanatos kernel: [    0.196506] smpboot: Booting Node   0, Processors  #1 OK
Nov 30 12:19:23 xanatos kernel: [    0.210032] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
Nov 30 12:19:23 xanatos kernel: [    0.210045] Brought up 2 CPUs
Nov 30 12:19:23 xanatos kernel: [    0.210047] smpboot: Total of 2 processors activated (10375.79 BogoMIPS)
Nov 30 12:19:23 xanatos kernel: [    0.211881] PM: Registering ACPI NVS region [mem 0xdae9f000-0xdaf9efff] (1048576 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.211997] NET: Registered protocol family 16
Nov 30 12:19:23 xanatos kernel: [    0.212176] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
Nov 30 12:19:23 xanatos kernel: [    0.212181] ACPI: bus type pci registered
Nov 30 12:19:23 xanatos kernel: [    0.212398] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
Nov 30 12:19:23 xanatos kernel: [    0.212400] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
Nov 30 12:19:23 xanatos kernel: [    0.220271] PCI: Using configuration type 1 for base access
Nov 30 12:19:23 xanatos kernel: [    0.221217] bio: create slab <bio-0> at 0
Nov 30 12:19:23 xanatos kernel: [    0.221292] ACPI: Added _OSI(Module Device)
Nov 30 12:19:23 xanatos kernel: [    0.221294] ACPI: Added _OSI(Processor Device)
Nov 30 12:19:23 xanatos kernel: [    0.221295] ACPI: Added _OSI(3.0 _SCP Extensions)
Nov 30 12:19:23 xanatos kernel: [    0.221297] ACPI: Added _OSI(Processor Aggregator Device)
Nov 30 12:19:23 xanatos kernel: [    0.225837] ACPI: EC: EC description table is found, configuring boot EC
Nov 30 12:19:23 xanatos kernel: [    0.238265] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
Nov 30 12:19:23 xanatos kernel: [    0.299282] ACPI: SSDT 00000000dae3a018 00A01 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.300472] ACPI: Dynamic OEM Table Load:
Nov 30 12:19:23 xanatos kernel: [    0.300475] ACPI: SSDT           (null) 00A01 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.318264] ACPI: SSDT 00000000dae3ba98 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.319540] ACPI: Dynamic OEM Table Load:
Nov 30 12:19:23 xanatos kernel: [    0.319542] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.337878] ACPI: SSDT 00000000dae39d98 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.339061] ACPI: Dynamic OEM Table Load:
Nov 30 12:19:23 xanatos kernel: [    0.339063] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
Nov 30 12:19:23 xanatos kernel: [    0.358194] ACPI: Interpreter enabled
Nov 30 12:19:23 xanatos kernel: [    0.358197] ACPI: (supports S0 S3 S4 S5)
Nov 30 12:19:23 xanatos kernel: [    0.358228] ACPI: Using IOAPIC for interrupt routing
Nov 30 12:19:23 xanatos kernel: [    0.378229] ACPI: Power Resource [PUBS] (on)
Nov 30 12:19:23 xanatos kernel: [    0.384004] ACPI: EC: GPE = 0x11, I/O: command/status = 0x66, data = 0x62
Nov 30 12:19:23 xanatos kernel: [    0.386438] ACPI: ACPI Dock Station Driver: 3 docks/bays found
Nov 30 12:19:23 xanatos kernel: [    0.386441] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Nov 30 12:19:23 xanatos kernel: [    0.386621] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
Nov 30 12:19:23 xanatos kernel: [    0.386707] PCI host bridge to bus 0000:00
Nov 30 12:19:23 xanatos kernel: [    0.386710] pci_bus 0000:00: root bus resource [bus 00-3f]
Nov 30 12:19:23 xanatos kernel: [    0.386712] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
Nov 30 12:19:23 xanatos kernel: [    0.386713] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
Nov 30 12:19:23 xanatos kernel: [    0.386715] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
Nov 30 12:19:23 xanatos kernel: [    0.386717] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff]
Nov 30 12:19:23 xanatos kernel: [    0.386718] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff]
Nov 30 12:19:23 xanatos kernel: [    0.386720] pci_bus 0000:00: scanning bus
Nov 30 12:19:23 xanatos kernel: [    0.386735] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
Nov 30 12:19:23 xanatos kernel: [    0.386745] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0xa
Nov 30 12:19:23 xanatos kernel: [    0.386798] pci 0000:00:02.0: [8086:0166] type 00 class 0x030000
Nov 30 12:19:23 xanatos kernel: [    0.386811] pci 0000:00:02.0: reg 10: [mem 0xf0000000-0xf03fffff 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.386818] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.386823] pci 0000:00:02.0: reg 20: [io  0x5000-0x503f]
Nov 30 12:19:23 xanatos kernel: [    0.386904] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
Nov 30 12:19:23 xanatos kernel: [    0.386930] pci 0000:00:14.0: reg 10: [mem 0xf2520000-0xf252ffff 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.387015] pci 0000:00:14.0: PME# supported from D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387027] pci 0000:00:14.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387055] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
Nov 30 12:19:23 xanatos kernel: [    0.387083] pci 0000:00:16.0: reg 10: [mem 0xf2535000-0xf253500f 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.387173] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387178] pci 0000:00:16.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387205] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
Nov 30 12:19:23 xanatos kernel: [    0.387228] pci 0000:00:16.3: reg 10: [io  0x50b0-0x50b7]
Nov 30 12:19:23 xanatos kernel: [    0.387239] pci 0000:00:16.3: reg 14: [mem 0xf253c000-0xf253cfff]
Nov 30 12:19:23 xanatos kernel: [    0.387363] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
Nov 30 12:19:23 xanatos kernel: [    0.387384] pci 0000:00:19.0: reg 10: [mem 0xf2500000-0xf251ffff]
Nov 30 12:19:23 xanatos kernel: [    0.387395] pci 0000:00:19.0: reg 14: [mem 0xf253b000-0xf253bfff]
Nov 30 12:19:23 xanatos kernel: [    0.387404] pci 0000:00:19.0: reg 18: [io  0x5080-0x509f]
Nov 30 12:19:23 xanatos kernel: [    0.387477] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387481] pci 0000:00:19.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387508] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
Nov 30 12:19:23 xanatos kernel: [    0.387532] pci 0000:00:1a.0: reg 10: [mem 0xf253a000-0xf253a3ff]
Nov 30 12:19:23 xanatos kernel: [    0.387636] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387641] pci 0000:00:1a.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387670] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
Nov 30 12:19:23 xanatos kernel: [    0.387691] pci 0000:00:1b.0: reg 10: [mem 0xf2530000-0xf2533fff 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.387776] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387781] pci 0000:00:1b.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387807] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
Nov 30 12:19:23 xanatos kernel: [    0.387871] pci 0000:00:1c.0: calling pci_fixup_transparent_bridge+0x0/0x1d
Nov 30 12:19:23 xanatos kernel: [    0.387943] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.387948] pci 0000:00:1c.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.387982] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
Nov 30 12:19:23 xanatos kernel: [    0.388045] pci 0000:00:1c.1: calling pci_fixup_transparent_bridge+0x0/0x1d
Nov 30 12:19:23 xanatos kernel: [    0.388119] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.388124] pci 0000:00:1c.1: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.388158] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
Nov 30 12:19:23 xanatos kernel: [    0.388222] pci 0000:00:1c.2: calling pci_fixup_transparent_bridge+0x0/0x1d
Nov 30 12:19:23 xanatos kernel: [    0.388295] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.388301] pci 0000:00:1c.2: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.388345] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
Nov 30 12:19:23 xanatos kernel: [    0.388370] pci 0000:00:1d.0: reg 10: [mem 0xf2539000-0xf25393ff]
Nov 30 12:19:23 xanatos kernel: [    0.388476] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.388481] pci 0000:00:1d.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.388508] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
Nov 30 12:19:23 xanatos kernel: [    0.388647] pci 0000:00:1f.2: [8086:1e03] type 00 class 0x010601
Nov 30 12:19:23 xanatos kernel: [    0.388670] pci 0000:00:1f.2: reg 10: [io  0x50a8-0x50af]
Nov 30 12:19:23 xanatos kernel: [    0.388680] pci 0000:00:1f.2: reg 14: [io  0x50bc-0x50bf]
Nov 30 12:19:23 xanatos kernel: [    0.388690] pci 0000:00:1f.2: reg 18: [io  0x50a0-0x50a7]
Nov 30 12:19:23 xanatos kernel: [    0.388700] pci 0000:00:1f.2: reg 1c: [io  0x50b8-0x50bb]
Nov 30 12:19:23 xanatos kernel: [    0.388709] pci 0000:00:1f.2: reg 20: [io  0x5060-0x507f]
Nov 30 12:19:23 xanatos kernel: [    0.388719] pci 0000:00:1f.2: reg 24: [mem 0xf2538000-0xf25387ff]
Nov 30 12:19:23 xanatos kernel: [    0.388778] pci 0000:00:1f.2: PME# supported from D3hot
Nov 30 12:19:23 xanatos kernel: [    0.388782] pci 0000:00:1f.2: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.388803] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
Nov 30 12:19:23 xanatos kernel: [    0.388823] pci 0000:00:1f.3: reg 10: [mem 0xf2534000-0xf25340ff 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.388848] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
Nov 30 12:19:23 xanatos kernel: [    0.388884] pci_bus 0000:00: fixups for bus
Nov 30 12:19:23 xanatos kernel: [    0.388889] pci 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 0
Nov 30 12:19:23 xanatos kernel: [    0.388956] pci_bus 0000:02: scanning bus
Nov 30 12:19:23 xanatos kernel: [    0.389038] pci 0000:02:00.0: [1180:e823] type 00 class 0x088001
Nov 30 12:19:23 xanatos kernel: [    0.389065] pci 0000:02:00.0: reg 10: [mem 0xf1d00000-0xf1d000ff]
Nov 30 12:19:23 xanatos kernel: [    0.389274] pci 0000:02:00.0: supports D1 D2
Nov 30 12:19:23 xanatos kernel: [    0.389275] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.389281] pci 0000:02:00.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.397812] pci_bus 0000:02: fixups for bus
Nov 30 12:19:23 xanatos kernel: [    0.397814] pci 0000:00:1c.0: PCI bridge to [bus 02]
Nov 30 12:19:23 xanatos kernel: [    0.397818] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
Nov 30 12:19:23 xanatos kernel: [    0.397824] pci 0000:00:1c.0:   bridge window [mem 0xf1d00000-0xf24fffff]
Nov 30 12:19:23 xanatos kernel: [    0.397832] pci 0000:00:1c.0:   bridge window [mem 0xf0400000-0xf0bfffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.397834] pci_bus 0000:02: bus scan returning with max=02
Nov 30 12:19:23 xanatos kernel: [    0.397840] pci 0000:00:1c.1: scanning [bus 03-03] behind bridge, pass 0
Nov 30 12:19:23 xanatos kernel: [    0.397907] pci_bus 0000:03: scanning bus
Nov 30 12:19:23 xanatos kernel: [    0.398058] pci 0000:03:00.0: [8086:0085] type 00 class 0x028000
Nov 30 12:19:23 xanatos kernel: [    0.398256] pci 0000:03:00.0: reg 10: [mem 0xf1c00000-0xf1c01fff 64bit]
Nov 30 12:19:23 xanatos kernel: [    0.399020] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
Nov 30 12:19:23 xanatos kernel: [    0.399055] pci 0000:03:00.0: PME# disabled
Nov 30 12:19:23 xanatos kernel: [    0.405680] pci_bus 0000:03: fixups for bus
Nov 30 12:19:23 xanatos kernel: [    0.405681] pci 0000:00:1c.1: PCI bridge to [bus 03]
Nov 30 12:19:23 xanatos kernel: [    0.405690] pci 0000:00:1c.1:   bridge window [mem 0xf1c00000-0xf1cfffff]
Nov 30 12:19:23 xanatos kernel: [    0.405698] pci_bus 0000:03: bus scan returning with max=03
Nov 30 12:19:23 xanatos kernel: [    0.405704] pci 0000:00:1c.2: scanning [bus 04-0b] behind bridge, pass 0
Nov 30 12:19:23 xanatos kernel: [    0.405770] pci_bus 0000:04: scanning bus
Nov 30 12:19:23 xanatos kernel: [    0.405773] pci_bus 0000:04: fixups for bus
Nov 30 12:19:23 xanatos kernel: [    0.405775] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
Nov 30 12:19:23 xanatos kernel: [    0.405780] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
Nov 30 12:19:23 xanatos kernel: [    0.405784] pci 0000:00:1c.2:   bridge window [mem 0xf1400000-0xf1bfffff]
Nov 30 12:19:23 xanatos kernel: [    0.405793] pci 0000:00:1c.2:   bridge window [mem 0xf0c00000-0xf13fffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.405794] pci_bus 0000:04: bus scan returning with max=04
Nov 30 12:19:23 xanatos kernel: [    0.405800] pci 0000:00:1c.0: scanning [bus 02-02] behind bridge, pass 1
Nov 30 12:19:23 xanatos kernel: [    0.405808] pci 0000:00:1c.1: scanning [bus 03-03] behind bridge, pass 1
Nov 30 12:19:23 xanatos kernel: [    0.405817] pci 0000:00:1c.2: scanning [bus 04-0b] behind bridge, pass 1
Nov 30 12:19:23 xanatos kernel: [    0.405823] pci_bus 0000:00: bus scan returning with max=0b
Nov 30 12:19:23 xanatos kernel: [    0.405825] pci_bus 0000:00: on NUMA node 0
Nov 30 12:19:23 xanatos kernel: [    0.405828] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov 30 12:19:23 xanatos kernel: [    0.405992] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
Nov 30 12:19:23 xanatos kernel: [    0.406045] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
Nov 30 12:19:23 xanatos kernel: [    0.406086] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
Nov 30 12:19:23 xanatos kernel: [    0.406306]  pci0000:00: Requesting ACPI _OSC control (0x1d)
Nov 30 12:19:23 xanatos kernel: [    0.406558]  pci0000:00: ACPI _OSC request failed (AE_SUPPORT), returned control mask: 0x0d
Nov 30 12:19:23 xanatos kernel: [    0.406559] ACPI _OSC control for PCIe not granted, disabling ASPM
Nov 30 12:19:23 xanatos kernel: [    0.410834] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
Nov 30 12:19:23 xanatos kernel: [    0.410960] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11)
Nov 30 12:19:23 xanatos kernel: [    0.411084] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
Nov 30 12:19:23 xanatos kernel: [    0.411206] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11)
Nov 30 12:19:23 xanatos kernel: [    0.411325] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
Nov 30 12:19:23 xanatos kernel: [    0.411444] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 9 10 11)
Nov 30 12:19:23 xanatos kernel: [    0.411565] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11)
Nov 30 12:19:23 xanatos kernel: [    0.411684] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11)
Nov 30 12:19:23 xanatos kernel: [    0.411798] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
Nov 30 12:19:23 xanatos kernel: [    0.411803] vgaarb: loaded
Nov 30 12:19:23 xanatos kernel: [    0.411804] vgaarb: bridge control possible 0000:00:02.0
Nov 30 12:19:23 xanatos kernel: [    0.411869] SCSI subsystem initialized
Nov 30 12:19:23 xanatos kernel: [    0.411870] ACPI: bus type scsi registered
Nov 30 12:19:23 xanatos kernel: [    0.411913] libata version 3.00 loaded.
Nov 30 12:19:23 xanatos kernel: [    0.411975] PCI: Using ACPI for IRQ routing
Nov 30 12:19:23 xanatos kernel: [    0.413918] PCI: pci_cache_line_size set to 64 bytes
Nov 30 12:19:23 xanatos kernel: [    0.413926] pci 0000:00:02.0: BAR 0: reserving [mem 0xf0000000-0xf03fffff flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413929] pci 0000:00:02.0: BAR 2: reserving [mem 0xe0000000-0xefffffff flags 0x14220c] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413931] pci 0000:00:02.0: BAR 4: reserving [io  0x5000-0x503f flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413937] pci 0000:00:14.0: BAR 0: reserving [mem 0xf2520000-0xf252ffff flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413941] pci 0000:00:16.0: BAR 0: reserving [mem 0xf2535000-0xf253500f flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413945] pci 0000:00:16.3: BAR 0: reserving [io  0x50b0-0x50b7 flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413947] pci 0000:00:16.3: BAR 1: reserving [mem 0xf253c000-0xf253cfff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413953] pci 0000:00:19.0: BAR 0: reserving [mem 0xf2500000-0xf251ffff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413955] pci 0000:00:19.0: BAR 1: reserving [mem 0xf253b000-0xf253bfff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413957] pci 0000:00:19.0: BAR 2: reserving [io  0x5080-0x509f flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413961] pci 0000:00:1a.0: BAR 0: reserving [mem 0xf253a000-0xf253a3ff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413965] pci 0000:00:1b.0: BAR 0: reserving [mem 0xf2530000-0xf2533fff flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413977] pci 0000:00:1d.0: BAR 0: reserving [mem 0xf2539000-0xf25393ff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413983] pci 0000:00:1f.2: BAR 0: reserving [io  0x50a8-0x50af flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413985] pci 0000:00:1f.2: BAR 1: reserving [io  0x50bc-0x50bf flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413987] pci 0000:00:1f.2: BAR 2: reserving [io  0x50a0-0x50a7 flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413989] pci 0000:00:1f.2: BAR 3: reserving [io  0x50b8-0x50bb flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413991] pci 0000:00:1f.2: BAR 4: reserving [io  0x5060-0x507f flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.413993] pci 0000:00:1f.2: BAR 5: reserving [mem 0xf2538000-0xf25387ff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.414000] pci 0000:00:1f.3: BAR 0: reserving [mem 0xf2534000-0xf25340ff flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.414002] pci 0000:00:1f.3: BAR 4: reserving [io  0xefa0-0xefbf flags 0x40101] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.414141] pci 0000:02:00.0: BAR 0: reserving [mem 0xf1d00000-0xf1d000ff flags 0x40200] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.414169] pci 0000:03:00.0: BAR 0: reserving [mem 0xf1c00000-0xf1c01fff flags 0x140204] (d=0, p=0)
Nov 30 12:19:23 xanatos kernel: [    0.414419] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
Nov 30 12:19:23 xanatos kernel: [    0.414421] e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
Nov 30 12:19:23 xanatos kernel: [    0.414422] e820: reserve RAM buffer [mem 0xcec30000-0xcfffffff]
Nov 30 12:19:23 xanatos kernel: [    0.414423] e820: reserve RAM buffer [mem 0x11e600000-0x11fffffff]
Nov 30 12:19:23 xanatos kernel: [    0.414531] Bluetooth: Core ver 2.16
Nov 30 12:19:23 xanatos kernel: [    0.414540] NET: Registered protocol family 31
Nov 30 12:19:23 xanatos kernel: [    0.414541] Bluetooth: HCI device and connection manager initialized
Nov 30 12:19:23 xanatos kernel: [    0.414548] Bluetooth: HCI socket layer initialized
Nov 30 12:19:23 xanatos kernel: [    0.414551] Bluetooth: L2CAP socket layer initialized
Nov 30 12:19:23 xanatos kernel: [    0.414558] Bluetooth: SCO socket layer initialized
Nov 30 12:19:23 xanatos kernel: [    0.414613] Switching to clocksource hpet
Nov 30 12:19:23 xanatos kernel: [    0.414696] pnp: PnP ACPI init
Nov 30 12:19:23 xanatos kernel: [    0.414711] ACPI: bus type pnp registered
Nov 30 12:19:23 xanatos kernel: [    0.415479] pnp 00:00: [mem 0x00000000-0x0009ffff]
Nov 30 12:19:23 xanatos kernel: [    0.415481] pnp 00:00: [mem 0x000c0000-0x000c3fff]
Nov 30 12:19:23 xanatos kernel: [    0.415483] pnp 00:00: [mem 0x000c4000-0x000c7fff]
Nov 30 12:19:23 xanatos kernel: [    0.415484] pnp 00:00: [mem 0x000c8000-0x000cbfff]
Nov 30 12:19:23 xanatos kernel: [    0.415485] pnp 00:00: [mem 0x000cc000-0x000cffff]
Nov 30 12:19:23 xanatos kernel: [    0.415487] pnp 00:00: [mem 0x000d0000-0x000d3fff]
Nov 30 12:19:23 xanatos kernel: [    0.415488] pnp 00:00: [mem 0x000d4000-0x000d7fff]
Nov 30 12:19:23 xanatos kernel: [    0.415489] pnp 00:00: [mem 0x000d8000-0x000dbfff]
Nov 30 12:19:23 xanatos kernel: [    0.415491] pnp 00:00: [mem 0x000dc000-0x000dffff]
Nov 30 12:19:23 xanatos kernel: [    0.415492] pnp 00:00: [mem 0x000e0000-0x000e3fff]
Nov 30 12:19:23 xanatos kernel: [    0.415494] pnp 00:00: [mem 0x000e4000-0x000e7fff]
Nov 30 12:19:23 xanatos kernel: [    0.415495] pnp 00:00: [mem 0x000e8000-0x000ebfff]
Nov 30 12:19:23 xanatos kernel: [    0.415496] pnp 00:00: [mem 0x000ec000-0x000effff]
Nov 30 12:19:23 xanatos kernel: [    0.415498] pnp 00:00: [mem 0x000f0000-0x000fffff]
Nov 30 12:19:23 xanatos kernel: [    0.415500] pnp 00:00: [mem 0x00100000-0xdf9fffff]
Nov 30 12:19:23 xanatos kernel: [    0.415502] pnp 00:00: [mem 0xfec00000-0xfed3ffff]
Nov 30 12:19:23 xanatos kernel: [    0.415503] pnp 00:00: [mem 0xfed4c000-0xffffffff]
Nov 30 12:19:23 xanatos kernel: [    0.415545] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415547] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415549] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415551] system 00:00: [mem 0x000c8000-0x000cbfff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415553] system 00:00: [mem 0x000cc000-0x000cffff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415554] system 00:00: [mem 0x000d0000-0x000d3fff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415556] system 00:00: [mem 0x000d4000-0x000d7fff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415558] system 00:00: [mem 0x000d8000-0x000dbfff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415559] system 00:00: [mem 0x000dc000-0x000dffff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415561] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415563] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415565] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415567] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415568] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415570] system 00:00: [mem 0x00100000-0xdf9fffff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415572] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415574] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
Nov 30 12:19:23 xanatos kernel: [    0.415586] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
Nov 30 12:19:23 xanatos kernel: [    0.415615] pnp 00:01: [bus 00-3f]
Nov 30 12:19:23 xanatos kernel: [    0.415617] pnp 00:01: [io  0x0cf8-0x0cff]
Nov 30 12:19:23 xanatos kernel: [    0.415619] pnp 00:01: [io  0x0000-0x0cf7 window]
Nov 30 12:19:23 xanatos kernel: [    0.415620] pnp 00:01: [io  0x0d00-0xffff window]
Nov 30 12:19:23 xanatos kernel: [    0.415622] pnp 00:01: [mem 0x000a0000-0x000bffff window]
Nov 30 12:19:23 xanatos kernel: [    0.415623] pnp 00:01: [mem 0x000c0000-0x000c3fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415625] pnp 00:01: [mem 0x000c4000-0x000c7fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415626] pnp 00:01: [mem 0x000c8000-0x000cbfff window]
Nov 30 12:19:23 xanatos kernel: [    0.415628] pnp 00:01: [mem 0x000cc000-0x000cffff window]
Nov 30 12:19:23 xanatos kernel: [    0.415629] pnp 00:01: [mem 0x000d0000-0x000d3fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415630] pnp 00:01: [mem 0x000d4000-0x000d7fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415632] pnp 00:01: [mem 0x000d8000-0x000dbfff window]
Nov 30 12:19:23 xanatos kernel: [    0.415633] pnp 00:01: [mem 0x000dc000-0x000dffff window]
Nov 30 12:19:23 xanatos kernel: [    0.415635] pnp 00:01: [mem 0x000e0000-0x000e3fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415636] pnp 00:01: [mem 0x000e4000-0x000e7fff window]
Nov 30 12:19:23 xanatos kernel: [    0.415638] pnp 00:01: [mem 0x000e8000-0x000ebfff window]
Nov 30 12:19:23 xanatos kernel: [    0.415639] pnp 00:01: [mem 0x000ec000-0x000effff window]
Nov 30 12:19:23 xanatos kernel: [    0.415641] pnp 00:01: [mem 0xdfa00000-0xfebfffff window]
Nov 30 12:19:23 xanatos kernel: [    0.415642] pnp 00:01: [mem 0xfed40000-0xfed4bfff window]
Nov 30 12:19:23 xanatos kernel: [    0.415677] pnp 00:01: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
Nov 30 12:19:23 xanatos kernel: [    0.415791] pnp 00:02: [io  0x0010-0x001f]
Nov 30 12:19:23 xanatos kernel: [    0.415793] pnp 00:02: [io  0x0090-0x009f]
Nov 30 12:19:23 xanatos kernel: [    0.415794] pnp 00:02: [io  0x0024-0x0025]
Nov 30 12:19:23 xanatos kernel: [    0.415796] pnp 00:02: [io  0x0028-0x0029]
Nov 30 12:19:23 xanatos kernel: [    0.415797] pnp 00:02: [io  0x002c-0x002d]
Nov 30 12:19:23 xanatos kernel: [    0.415798] pnp 00:02: [io  0x0030-0x0031]
Nov 30 12:19:23 xanatos kernel: [    0.415799] pnp 00:02: [io  0x0034-0x0035]
Nov 30 12:19:23 xanatos kernel: [    0.415801] pnp 00:02: [io  0x0038-0x0039]
Nov 30 12:19:23 xanatos kernel: [    0.415802] pnp 00:02: [io  0x003c-0x003d]
Nov 30 12:19:23 xanatos kernel: [    0.415803] pnp 00:02: [io  0x00a4-0x00a5]
Nov 30 12:19:23 xanatos kernel: [    0.415805] pnp 00:02: [io  0x00a8-0x00a9]
Nov 30 12:19:23 xanatos kernel: [    0.415806] pnp 00:02: [io  0x00ac-0x00ad]
Nov 30 12:19:23 xanatos kernel: [    0.415807] pnp 00:02: [io  0x00b0-0x00b5]
Nov 30 12:19:23 xanatos kernel: [    0.415808] pnp 00:02: [io  0x00b8-0x00b9]
Nov 30 12:19:23 xanatos kernel: [    0.415810] pnp 00:02: [io  0x00bc-0x00bd]
Nov 30 12:19:23 xanatos kernel: [    0.415811] pnp 00:02: [io  0x0050-0x0053]
Nov 30 12:19:23 xanatos kernel: [    0.415812] pnp 00:02: [io  0x0072-0x0077]
Nov 30 12:19:23 xanatos kernel: [    0.415814] pnp 00:02: [io  0x0400-0x047f]
Nov 30 12:19:23 xanatos kernel: [    0.415815] pnp 00:02: [io  0x0500-0x057f]
Nov 30 12:19:23 xanatos kernel: [    0.415816] pnp 00:02: [io  0x0800-0x080f]
Nov 30 12:19:23 xanatos kernel: [    0.415819] pnp 00:02: [io  0x15e0-0x15ef]
Nov 30 12:19:23 xanatos kernel: [    0.415820] pnp 00:02: [io  0x1600-0x167f]
Nov 30 12:19:23 xanatos kernel: [    0.415821] pnp 00:02: [mem 0xf8000000-0xfbffffff]
Nov 30 12:19:23 xanatos kernel: [    0.415823] pnp 00:02: [mem 0xfffff000-0xffffffff]
Nov 30 12:19:23 xanatos kernel: [    0.415824] pnp 00:02: [mem 0xfed1c000-0xfed1ffff]
Nov 30 12:19:23 xanatos kernel: [    0.415826] pnp 00:02: [mem 0xfed10000-0xfed13fff]
Nov 30 12:19:23 xanatos kernel: [    0.415827] pnp 00:02: [mem 0xfed18000-0xfed18fff]
Nov 30 12:19:23 xanatos kernel: [    0.415828] pnp 00:02: [mem 0xfed19000-0xfed19fff]
Nov 30 12:19:23 xanatos kernel: [    0.415830] pnp 00:02: [mem 0xfed45000-0xfed4bfff]
Nov 30 12:19:23 xanatos kernel: [    0.415876] system 00:02: [io  0x0400-0x047f] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415878] system 00:02: [io  0x0500-0x057f] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415880] system 00:02: [io  0x0800-0x080f] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415881] system 00:02: [io  0x15e0-0x15ef] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415883] system 00:02: [io  0x1600-0x167f] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415885] system 00:02: [mem 0xf8000000-0xfbffffff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415887] system 00:02: [mem 0xfffff000-0xffffffff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415889] system 00:02: [mem 0xfed1c000-0xfed1ffff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415891] system 00:02: [mem 0xfed10000-0xfed13fff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415892] system 00:02: [mem 0xfed18000-0xfed18fff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415894] system 00:02: [mem 0xfed19000-0xfed19fff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415896] system 00:02: [mem 0xfed45000-0xfed4bfff] has been reserved
Nov 30 12:19:23 xanatos kernel: [    0.415899] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
Nov 30 12:19:23 xanatos kernel: [    0.415972] pnp 00:03: [mem 0xfed00000-0xfed003ff]
Nov 30 12:19:23 xanatos kernel: [    0.416002] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416021] pnp 00:04: [io  0x0000-0x000f]
Nov 30 12:19:23 xanatos kernel: [    0.416023] pnp 00:04: [io  0x0080-0x008f]
Nov 30 12:19:23 xanatos kernel: [    0.416024] pnp 00:04: [io  0x00c0-0x00df]
Nov 30 12:19:23 xanatos kernel: [    0.416026] pnp 00:04: [dma 4]
Nov 30 12:19:23 xanatos kernel: [    0.416050] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416061] pnp 00:05: [io  0x0061]
Nov 30 12:19:23 xanatos kernel: [    0.416084] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416095] pnp 00:06: [io  0x00f0]
Nov 30 12:19:23 xanatos kernel: [    0.416105] pnp 00:06: [irq 13]
Nov 30 12:19:23 xanatos kernel: [    0.416130] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416141] pnp 00:07: [io  0x0070-0x0071]
Nov 30 12:19:23 xanatos kernel: [    0.416149] pnp 00:07: [irq 8]
Nov 30 12:19:23 xanatos kernel: [    0.416173] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416185] pnp 00:08: [io  0x0060]
Nov 30 12:19:23 xanatos kernel: [    0.416186] pnp 00:08: [io  0x0064]
Nov 30 12:19:23 xanatos kernel: [    0.416193] pnp 00:08: [irq 1]
Nov 30 12:19:23 xanatos kernel: [    0.416217] pnp 00:08: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416235] pnp 00:09: [irq 12]
Nov 30 12:19:23 xanatos kernel: [    0.416261] pnp 00:09: Plug and Play ACPI device, IDs LEN0020 PNP0f13 (active)
Nov 30 12:19:23 xanatos kernel: [    0.416319] pnp 00:0a: [mem 0xfed40000-0xfed44fff]
Nov 30 12:19:23 xanatos kernel: [    0.416346] pnp 00:0a: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
Nov 30 12:19:23 xanatos kernel: [    0.417063] pnp: PnP ACPI: found 11 devices
Nov 30 12:19:23 xanatos kernel: [    0.417065] ACPI: ACPI bus type pnp unregistered
Nov 30 12:19:23 xanatos kernel: [    0.422756] pci 0000:00:1c.0: PCI bridge to [bus 02]
Nov 30 12:19:23 xanatos kernel: [    0.422763] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
Nov 30 12:19:23 xanatos kernel: [    0.422770] pci 0000:00:1c.0:   bridge window [mem 0xf1d00000-0xf24fffff]
Nov 30 12:19:23 xanatos kernel: [    0.422775] pci 0000:00:1c.0:   bridge window [mem 0xf0400000-0xf0bfffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.422784] pci 0000:00:1c.1: PCI bridge to [bus 03]
Nov 30 12:19:23 xanatos kernel: [    0.422791] pci 0000:00:1c.1:   bridge window [mem 0xf1c00000-0xf1cfffff]
Nov 30 12:19:23 xanatos kernel: [    0.422803] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
Nov 30 12:19:23 xanatos kernel: [    0.422806] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
Nov 30 12:19:23 xanatos kernel: [    0.422813] pci 0000:00:1c.2:   bridge window [mem 0xf1400000-0xf1bfffff]
Nov 30 12:19:23 xanatos kernel: [    0.422818] pci 0000:00:1c.2:   bridge window [mem 0xf0c00000-0xf13fffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.422860] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
Nov 30 12:19:23 xanatos kernel: [    0.422862] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
Nov 30 12:19:23 xanatos kernel: [    0.422864] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
Nov 30 12:19:23 xanatos kernel: [    0.422865] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0xfebfffff]
Nov 30 12:19:23 xanatos kernel: [    0.422867] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed4bfff]
Nov 30 12:19:23 xanatos kernel: [    0.422868] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
Nov 30 12:19:23 xanatos kernel: [    0.422870] pci_bus 0000:02: resource 1 [mem 0xf1d00000-0xf24fffff]
Nov 30 12:19:23 xanatos kernel: [    0.422871] pci_bus 0000:02: resource 2 [mem 0xf0400000-0xf0bfffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.422873] pci_bus 0000:03: resource 1 [mem 0xf1c00000-0xf1cfffff]
Nov 30 12:19:23 xanatos kernel: [    0.422875] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
Nov 30 12:19:23 xanatos kernel: [    0.422876] pci_bus 0000:04: resource 1 [mem 0xf1400000-0xf1bfffff]
Nov 30 12:19:23 xanatos kernel: [    0.422878] pci_bus 0000:04: resource 2 [mem 0xf0c00000-0xf13fffff 64bit pref]
Nov 30 12:19:23 xanatos kernel: [    0.422907] NET: Registered protocol family 2
Nov 30 12:19:23 xanatos kernel: [    0.423058] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.423751] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.425984] TCP: Hash tables configured (established 262144 bind 65536)
Nov 30 12:19:23 xanatos kernel: [    0.426028] TCP: reno registered
Nov 30 12:19:23 xanatos kernel: [    0.426037] UDP hash table entries: 2048 (order: 6, 327680 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.426192] UDP-Lite hash table entries: 2048 (order: 6, 327680 bytes)
Nov 30 12:19:23 xanatos kernel: [    0.426402] NET: Registered protocol family 1
Nov 30 12:19:23 xanatos kernel: [    0.426419] pci 0000:00:02.0: calling pci_fixup_video+0x0/0xaa
Nov 30 12:19:23 xanatos kernel: [    0.426421] pci 0000:00:02.0: Boot video device
Nov 30 12:19:23 xanatos kernel: [    0.426426] pci 0000:00:14.0: calling quirk_usb_early_handoff+0x0/0x790
Nov 30 12:19:23 xanatos kernel: [    0.426475] pci 0000:00:14.0: Configurable ports to enable SuperSpeed: 0xf
Nov 30 12:19:23 xanatos kernel: [    0.426480] pci 0000:00:14.0: USB 3.0 ports that are now enabled under xHCI: 0xf
Nov 30 12:19:23 xanatos kernel: [    0.426483] pci 0000:00:14.0: Configurable USB 2.0 ports to hand over to xCHI: 0xf
Nov 30 12:19:23 xanatos kernel: [    0.426488] pci 0000:00:14.0: USB 2.0 ports that are now switched over to xHCI: 0xf
Nov 30 12:19:23 xanatos kernel: [    0.426510] pci 0000:00:19.0: calling quirk_e100_interrupt+0x0/0x169
Nov 30 12:19:23 xanatos kernel: [    0.426517] pci 0000:00:1a.0: calling quirk_usb_early_handoff+0x0/0x790
Nov 30 12:19:23 xanatos kernel: [    0.426570] pci 0000:00:1d.0: calling quirk_usb_early_handoff+0x0/0x790
Nov 30 12:19:23 xanatos kernel: [    0.426873] PCI: CLS 64 bytes, default 64
Nov 30 12:19:23 xanatos kernel: [    0.426945] Trying to unpack rootfs image as initramfs...
Nov 30 12:19:23 xanatos kernel: [    1.266215] Freeing initrd memory: 55140k freed
Nov 30 12:19:23 xanatos kernel: [    1.274745] DMA-API: preallocated 32768 debug entries
Nov 30 12:19:23 xanatos kernel: [    1.274748] DMA-API: debugging enabled by kernel config
Nov 30 12:19:23 xanatos kernel: [    1.274750] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Nov 30 12:19:23 xanatos kernel: [    1.274753] software IO TLB [mem 0xcac2e000-0xcec2dfff] (64MB) mapped at [ffff8800cac2e000-ffff8800cec2dfff]
Nov 30 12:19:23 xanatos kernel: [    1.275078] audit: initializing netlink socket (disabled)
Nov 30 12:19:23 xanatos kernel: [    1.275108] type=2000 audit(1354306757.172:1): initialized
Nov 30 12:19:23 xanatos kernel: [    1.289650] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Nov 30 12:19:23 xanatos kernel: [    1.291897] fuse init (API version 7.20)
Nov 30 12:19:23 xanatos kernel: [    1.291965] msgmni has been set to 7284
Nov 30 12:19:23 xanatos kernel: [    1.292277] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Nov 30 12:19:23 xanatos kernel: [    1.292284] io scheduler noop registered
Nov 30 12:19:23 xanatos kernel: [    1.292286] io scheduler deadline registered
Nov 30 12:19:23 xanatos kernel: [    1.292312] io scheduler cfq registered (default)
Nov 30 12:19:23 xanatos kernel: [    1.293629] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Nov 30 12:19:23 xanatos kernel: [    1.293672] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Nov 30 12:19:23 xanatos kernel: [    1.293847] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
Nov 30 12:19:23 xanatos kernel: [    1.294007] ACPI: AC Adapter [AC] (on-line)
Nov 30 12:19:23 xanatos kernel: [    1.294197] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
Nov 30 12:19:23 xanatos kernel: [    1.294410] ACPI: Lid Switch [LID]
Nov 30 12:19:23 xanatos kernel: [    1.294453] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
Nov 30 12:19:23 xanatos kernel: [    1.294466] ACPI: Sleep Button [SLPB]
Nov 30 12:19:23 xanatos kernel: [    1.294523] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
Nov 30 12:19:23 xanatos kernel: [    1.294526] ACPI: Power Button [PWRF]
Nov 30 12:19:23 xanatos kernel: [    1.294663] ACPI: Requesting acpi_cpufreq
Nov 30 12:19:23 xanatos kernel: [    1.313678] Monitor-Mwait will be used to enter C-1 state
Nov 30 12:19:23 xanatos kernel: [    1.313688] Monitor-Mwait will be used to enter C-2 state
Nov 30 12:19:23 xanatos kernel: [    1.313727] ACPI: acpi_idle registered with cpuidle
Nov 30 12:19:23 xanatos kernel: [    1.323135] thermal LNXTHERM:00: registered as thermal_zone0
Nov 30 12:19:23 xanatos kernel: [    1.323137] ACPI: Thermal Zone [THM0] (50 C)
Nov 30 12:19:23 xanatos kernel: [    1.323154] XENFS: not registering filesystem on non-xen platform
Nov 30 12:19:23 xanatos kernel: [    1.323269] Linux agpgart interface v0.103
Nov 30 12:19:23 xanatos kernel: [    1.324786] brd: module loaded
Nov 30 12:19:23 xanatos kernel: [    1.325563] loop: module loaded
Nov 30 12:19:23 xanatos kernel: [    1.325683] ahci 0000:00:1f.2: version 3.0
Nov 30 12:19:23 xanatos kernel: [    1.325775] ahci 0000:00:1f.2: irq 40 for MSI/MSI-X
Nov 30 12:19:23 xanatos kernel: [    1.325837] ahci: SSS flag set, parallel bus scan disabled
Nov 30 12:19:23 xanatos kernel: [    1.333908] ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
Nov 30 12:19:23 xanatos kernel: [    1.333915] ACPI: Battery Slot [BAT0] (battery present)
Nov 30 12:19:23 xanatos kernel: [    1.340950] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x13 impl SATA mode
Nov 30 12:19:23 xanatos kernel: [    1.340953] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part ems sxs apst 
Nov 30 12:19:23 xanatos kernel: [    1.340961] ahci 0000:00:1f.2: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    1.357448] scsi0 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357574] scsi1 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357657] scsi2 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357737] scsi3 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357819] scsi4 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357896] scsi5 : ahci
Nov 30 12:19:23 xanatos kernel: [    1.357948] ata1: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf2538100 irq 40
Nov 30 12:19:23 xanatos kernel: [    1.357951] ata2: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf2538180 irq 40
Nov 30 12:19:23 xanatos kernel: [    1.357952] ata3: DUMMY
Nov 30 12:19:23 xanatos kernel: [    1.357953] ata4: DUMMY
Nov 30 12:19:23 xanatos kernel: [    1.357956] ata5: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf2538300 irq 40
Nov 30 12:19:23 xanatos kernel: [    1.357957] ata6: DUMMY
Nov 30 12:19:23 xanatos kernel: [    1.358076] e1000e: Intel(R) PRO/1000 Network Driver - 2.1.4-k
Nov 30 12:19:23 xanatos kernel: [    1.358077] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
Nov 30 12:19:23 xanatos kernel: [    1.358108] e1000e 0000:00:19.0: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    1.358178] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
Nov 30 12:19:23 xanatos kernel: [    1.358216] e1000e 0000:00:19.0: irq 41 for MSI/MSI-X
Nov 30 12:19:23 xanatos kernel: [    1.555409] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 3c:97:0e:39:d7:10
Nov 30 12:19:23 xanatos kernel: [    1.555412] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
Nov 30 12:19:23 xanatos kernel: [    1.555458] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 1000FF-0FF
Nov 30 12:19:23 xanatos kernel: [    1.555476] PPP generic driver version 2.4.2
Nov 30 12:19:23 xanatos kernel: [    1.555557] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Nov 30 12:19:23 xanatos kernel: [    1.557071] serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 30 12:19:23 xanatos kernel: [    1.557134] serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 30 12:19:23 xanatos kernel: [    1.557209] mousedev: PS/2 mouse device common for all mice
Nov 30 12:19:23 xanatos kernel: [    1.557441] rtc_cmos 00:07: RTC can wake from S4
Nov 30 12:19:23 xanatos kernel: [    1.557598] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
Nov 30 12:19:23 xanatos kernel: [    1.557635] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
Nov 30 12:19:23 xanatos kernel: [    1.557731] device-mapper: uevent: version 1.0.3
Nov 30 12:19:23 xanatos kernel: [    1.557793] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Nov 30 12:19:23 xanatos kernel: [    1.557860] device-mapper: multipath: version 1.5.0 loaded
Nov 30 12:19:23 xanatos kernel: [    1.557871] device-mapper: multipath round-robin: version 1.0.0 loaded
Nov 30 12:19:23 xanatos kernel: [    1.557997] cpuidle: using governor ladder
Nov 30 12:19:23 xanatos kernel: [    1.558108] cpuidle: using governor menu
Nov 30 12:19:23 xanatos kernel: [    1.558239] TCP: cubic registered
Nov 30 12:19:23 xanatos kernel: [    1.558386] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
Nov 30 12:19:23 xanatos kernel: [    1.558517] NET: Registered protocol family 10
Nov 30 12:19:23 xanatos kernel: [    1.558733] NET: Registered protocol family 17
Nov 30 12:19:23 xanatos kernel: [    1.558770] Key type dns_resolver registered
Nov 30 12:19:23 xanatos kernel: [    1.558855] PM: Checking hibernation image partition /dev/sda2
Nov 30 12:19:23 xanatos kernel: [    1.676343] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov 30 12:19:23 xanatos kernel: [    1.677400] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
Nov 30 12:19:23 xanatos kernel: [    1.677405] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Nov 30 12:19:23 xanatos kernel: [    1.677803] ata1.00: ATA-7: INTEL SSDSA2M160G2GC, 2CV102M3, max UDMA/133
Nov 30 12:19:23 xanatos kernel: [    1.677806] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
Nov 30 12:19:23 xanatos kernel: [    1.677923] ata1.00: failed to get Identify Device Data, Emask 0x1
Nov 30 12:19:23 xanatos kernel: [    1.679117] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
Nov 30 12:19:23 xanatos kernel: [    1.679120] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Nov 30 12:19:23 xanatos kernel: [    1.679615] ata1.00: failed to get Identify Device Data, Emask 0x1
Nov 30 12:19:23 xanatos kernel: [    1.679619] ata1.00: configured for UDMA/133
Nov 30 12:19:23 xanatos kernel: [    1.684450] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA2M160 2CV1 PQ: 0 ANSI: 5
Nov 30 12:19:23 xanatos kernel: [    1.684884] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
Nov 30 12:19:23 xanatos kernel: [    1.684920] sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov 30 12:19:23 xanatos kernel: [    1.684983] sd 0:0:0:0: [sda] Write Protect is off
Nov 30 12:19:23 xanatos kernel: [    1.684986] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Nov 30 12:19:23 xanatos kernel: [    1.685018] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Nov 30 12:19:23 xanatos kernel: [    1.685956]  sda: sda1 sda2 < sda5 >
Nov 30 12:19:23 xanatos kernel: [    1.686438] sd 0:0:0:0: [sda] Attached SCSI disk
Nov 30 12:19:23 xanatos kernel: [    2.011714] ata2: SATA link down (SStatus 0 SControl 300)
Nov 30 12:19:23 xanatos kernel: [    2.271221] tsc: Refined TSC clocksource calibration: 2594.108 MHz
Nov 30 12:19:23 xanatos kernel: [    2.271226] Switching to clocksource tsc
Nov 30 12:19:23 xanatos kernel: [    2.339084] ata5: SATA link down (SStatus 0 SControl 300)
Nov 30 12:19:23 xanatos kernel: [    2.413341] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd002a3/0x940300/0x123800, board id: 1611, fw id: 1099905
Nov 30 12:19:23 xanatos kernel: [    2.413346] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
Nov 30 12:19:23 xanatos kernel: [    2.452447] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input4
Nov 30 12:19:23 xanatos kernel: [    2.455241] PM: Hibernation image partition 8:2 present
Nov 30 12:19:23 xanatos kernel: [    2.455244] PM: Looking for hibernation image.
Nov 30 12:19:23 xanatos kernel: [    2.562641] attempt to access beyond end of device
Nov 30 12:19:23 xanatos kernel: [    2.562648] sda2: rw=16, want=8, limit=2
Nov 30 12:19:23 xanatos kernel: [    2.562660] Read-error on swap-device (8:2:0)
Nov 30 12:19:23 xanatos kernel: [    2.562674] PM: Image not found (code -22)
Nov 30 12:19:23 xanatos kernel: [    2.562675] PM: Hibernation image not present or could not be loaded.
Nov 30 12:19:23 xanatos kernel: [    2.562692] registered taskstats version 1
Nov 30 12:19:23 xanatos kernel: [    2.563260] rtc_cmos 00:07: setting system clock to 2012-11-30 20:19:19 UTC (1354306759)
Nov 30 12:19:23 xanatos kernel: [    2.563262] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
Nov 30 12:19:23 xanatos kernel: [    2.563263] EDD information not available.
Nov 30 12:19:23 xanatos kernel: [    2.564241] Freeing unused kernel memory: 596k freed
Nov 30 12:19:23 xanatos kernel: [    2.564311] Write protecting the kernel read-only data: 10240k
Nov 30 12:19:23 xanatos kernel: [    2.566152] Freeing unused kernel memory: 772k freed
Nov 30 12:19:23 xanatos kernel: [    2.570388] Freeing unused kernel memory: 1816k freed
Nov 30 12:19:23 xanatos kernel: [    2.699264] ACPI: bus type usb registered
Nov 30 12:19:23 xanatos kernel: [    2.699314] usbcore: registered new interface driver usbfs
Nov 30 12:19:23 xanatos kernel: [    2.699375] usbcore: registered new interface driver hub
Nov 30 12:19:23 xanatos kernel: [    2.705115] [drm] Initialized drm 1.1.0 20060810
Nov 30 12:19:23 xanatos kernel: [    2.710625] usbcore: registered new device driver usb
Nov 30 12:19:23 xanatos kernel: [    2.712732] xhci_hcd 0000:00:14.0: enabling bus mastering
Nov 30 12:19:23 xanatos kernel: [    2.712746] xhci_hcd 0000:00:14.0: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    2.712753] xhci_hcd 0000:00:14.0: xHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    2.712821] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Nov 30 12:19:23 xanatos kernel: [    2.712839] xhci_hcd 0000:00:14.0: xHCI capability registers at ffffc90005e40000:
Nov 30 12:19:23 xanatos kernel: [    2.712843] xhci_hcd 0000:00:14.0: CAPLENGTH AND HCIVERSION 0x1000080:
Nov 30 12:19:23 xanatos kernel: [    2.712846] xhci_hcd 0000:00:14.0: CAPLENGTH: 0x80
Nov 30 12:19:23 xanatos kernel: [    2.712848] xhci_hcd 0000:00:14.0: HCIVERSION: 0x100
Nov 30 12:19:23 xanatos kernel: [    2.712854] xhci_hcd 0000:00:14.0: HCSPARAMS 1: 0x8000820
Nov 30 12:19:23 xanatos kernel: [    2.712856] xhci_hcd 0000:00:14.0:   Max device slots: 32
Nov 30 12:19:23 xanatos kernel: [    2.712858] xhci_hcd 0000:00:14.0:   Max interrupters: 8
Nov 30 12:19:23 xanatos kernel: [    2.712861] xhci_hcd 0000:00:14.0:   Max ports: 8
Nov 30 12:19:23 xanatos kernel: [    2.712867] xhci_hcd 0000:00:14.0: HCSPARAMS 2: 0x84000054
Nov 30 12:19:23 xanatos kernel: [    2.712869] xhci_hcd 0000:00:14.0:   Isoc scheduling threshold: 4
Nov 30 12:19:23 xanatos kernel: [    2.712872] xhci_hcd 0000:00:14.0:   Maximum allowed segments in event ring: 5
Nov 30 12:19:23 xanatos kernel: [    2.712875] xhci_hcd 0000:00:14.0: HCSPARAMS 3 0x200000a:
Nov 30 12:19:23 xanatos kernel: [    2.712878] xhci_hcd 0000:00:14.0:   Worst case U1 device exit latency: 10
Nov 30 12:19:23 xanatos kernel: [    2.712880] xhci_hcd 0000:00:14.0:   Worst case U2 device exit latency: 512
Nov 30 12:19:23 xanatos kernel: [    2.712886] xhci_hcd 0000:00:14.0: HCC PARAMS 0x20007181:
Nov 30 12:19:23 xanatos kernel: [    2.712888] xhci_hcd 0000:00:14.0:   HC generates 64 bit addresses
Nov 30 12:19:23 xanatos kernel: [    2.712890] xhci_hcd 0000:00:14.0:   FIXME: more HCCPARAMS debugging
Nov 30 12:19:23 xanatos kernel: [    2.712896] xhci_hcd 0000:00:14.0: RTSOFF 0x2000:
Nov 30 12:19:23 xanatos kernel: [    2.712899] xhci_hcd 0000:00:14.0: xHCI operational registers at ffffc90005e40080:
Nov 30 12:19:23 xanatos kernel: [    2.712903] xhci_hcd 0000:00:14.0: USBCMD 0x0:
Nov 30 12:19:23 xanatos kernel: [    2.712905] xhci_hcd 0000:00:14.0:   HC is being stopped
Nov 30 12:19:23 xanatos kernel: [    2.712908] xhci_hcd 0000:00:14.0:   HC has finished hard reset
Nov 30 12:19:23 xanatos kernel: [    2.712910] xhci_hcd 0000:00:14.0:   Event Interrupts disabled
Nov 30 12:19:23 xanatos kernel: [    2.712913] xhci_hcd 0000:00:14.0:   Host System Error Interrupts disabled
Nov 30 12:19:23 xanatos kernel: [    2.712915] xhci_hcd 0000:00:14.0:   HC has finished light reset
Nov 30 12:19:23 xanatos kernel: [    2.712921] xhci_hcd 0000:00:14.0: USBSTS 0x1:
Nov 30 12:19:23 xanatos kernel: [    2.712924] xhci_hcd 0000:00:14.0:   Event ring is empty
Nov 30 12:19:23 xanatos kernel: [    2.712926] xhci_hcd 0000:00:14.0:   No Host System Error
Nov 30 12:19:23 xanatos kernel: [    2.712928] xhci_hcd 0000:00:14.0:   HC is halted
Nov 30 12:19:23 xanatos kernel: [    2.712935] xhci_hcd 0000:00:14.0: ffffc90005e40480 port status reg = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.712939] xhci_hcd 0000:00:14.0: ffffc90005e40484 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712944] xhci_hcd 0000:00:14.0: ffffc90005e40488 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712948] xhci_hcd 0000:00:14.0: ffffc90005e4048c port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712952] xhci_hcd 0000:00:14.0: ffffc90005e40490 port status reg = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.712956] xhci_hcd 0000:00:14.0: ffffc90005e40494 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712961] xhci_hcd 0000:00:14.0: ffffc90005e40498 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712966] xhci_hcd 0000:00:14.0: ffffc90005e4049c port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712970] xhci_hcd 0000:00:14.0: ffffc90005e404a0 port status reg = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.712973] xhci_hcd 0000:00:14.0: ffffc90005e404a4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712978] xhci_hcd 0000:00:14.0: ffffc90005e404a8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712982] xhci_hcd 0000:00:14.0: ffffc90005e404ac port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712987] xhci_hcd 0000:00:14.0: ffffc90005e404b0 port status reg = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.712991] xhci_hcd 0000:00:14.0: ffffc90005e404b4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.712995] xhci_hcd 0000:00:14.0: ffffc90005e404b8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713000] xhci_hcd 0000:00:14.0: ffffc90005e404bc port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713004] xhci_hcd 0000:00:14.0: ffffc90005e404c0 port status reg = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.713008] xhci_hcd 0000:00:14.0: ffffc90005e404c4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713012] xhci_hcd 0000:00:14.0: ffffc90005e404c8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713016] xhci_hcd 0000:00:14.0: ffffc90005e404cc port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713020] xhci_hcd 0000:00:14.0: ffffc90005e404d0 port status reg = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.713024] xhci_hcd 0000:00:14.0: ffffc90005e404d4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713028] xhci_hcd 0000:00:14.0: ffffc90005e404d8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713033] xhci_hcd 0000:00:14.0: ffffc90005e404dc port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713037] xhci_hcd 0000:00:14.0: ffffc90005e404e0 port status reg = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.713041] xhci_hcd 0000:00:14.0: ffffc90005e404e4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713045] xhci_hcd 0000:00:14.0: ffffc90005e404e8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713050] xhci_hcd 0000:00:14.0: ffffc90005e404ec port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713054] xhci_hcd 0000:00:14.0: ffffc90005e404f0 port status reg = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.713058] xhci_hcd 0000:00:14.0: ffffc90005e404f4 port power reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713061] xhci_hcd 0000:00:14.0: ffffc90005e404f8 port link reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713067] xhci_hcd 0000:00:14.0: ffffc90005e404fc port reserved reg = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713069] xhci_hcd 0000:00:14.0: // Halt the HC
Nov 30 12:19:23 xanatos kernel: [    2.713076] xhci_hcd 0000:00:14.0: Resetting HCD
Nov 30 12:19:23 xanatos kernel: [    2.713079] xhci_hcd 0000:00:14.0: // Reset the HC
Nov 30 12:19:23 xanatos kernel: [    2.713087] xhci_hcd 0000:00:14.0: Wait for controller to be ready for doorbell rings
Nov 30 12:19:23 xanatos kernel: [    2.713091] xhci_hcd 0000:00:14.0: Reset complete
Nov 30 12:19:23 xanatos kernel: [    2.713094] xhci_hcd 0000:00:14.0: Enabling 64-bit DMA addresses.
Nov 30 12:19:23 xanatos kernel: [    2.713096] xhci_hcd 0000:00:14.0: Calling HCD init
Nov 30 12:19:23 xanatos kernel: [    2.713098] xhci_hcd 0000:00:14.0: xhci_init
Nov 30 12:19:23 xanatos kernel: [    2.713101] xhci_hcd 0000:00:14.0: xHCI doesn't need link TRB QUIRK
Nov 30 12:19:23 xanatos kernel: [    2.713108] xhci_hcd 0000:00:14.0: Supported page size register = 0x1
Nov 30 12:19:23 xanatos kernel: [    2.713110] xhci_hcd 0000:00:14.0: Supported page size of 4K
Nov 30 12:19:23 xanatos kernel: [    2.713112] xhci_hcd 0000:00:14.0: HCD page size set to 4K
Nov 30 12:19:23 xanatos kernel: [    2.713116] xhci_hcd 0000:00:14.0: // xHC can handle at most 32 device slots.
Nov 30 12:19:23 xanatos kernel: [    2.713120] xhci_hcd 0000:00:14.0: // Setting Max device slots reg = 0x20.
Nov 30 12:19:23 xanatos kernel: [    2.713147] xhci_hcd 0000:00:14.0: // Device context base array address = 0x34800000 (DMA), ffff880034800000 (virt)
Nov 30 12:19:23 xanatos kernel: [    2.713188] xhci_hcd 0000:00:14.0: Allocated command ring at ffff88010ce39c80
Nov 30 12:19:23 xanatos kernel: [    2.713191] xhci_hcd 0000:00:14.0: First segment DMA is 0x34801000
Nov 30 12:19:23 xanatos kernel: [    2.713199] xhci_hcd 0000:00:14.0: // Setting command ring address to 0x20
Nov 30 12:19:23 xanatos kernel: [    2.713204] xhci_hcd 0000:00:14.0: // xHC command ring deq ptr low bits + flags = @00000000
Nov 30 12:19:23 xanatos kernel: [    2.713206] xhci_hcd 0000:00:14.0: // xHC command ring deq ptr high bits = @00000000
Nov 30 12:19:23 xanatos kernel: [    2.713222] xhci_hcd 0000:00:14.0: // Doorbell array is located at offset 0x3000 from cap regs base addr
Nov 30 12:19:23 xanatos kernel: [    2.713225] xhci_hcd 0000:00:14.0: // xHCI capability registers at ffffc90005e40000:
Nov 30 12:19:23 xanatos kernel: [    2.713230] xhci_hcd 0000:00:14.0: // @ffffc90005e40000 = 0x1000080 (CAPLENGTH AND HCIVERSION)
Nov 30 12:19:23 xanatos kernel: [    2.713233] xhci_hcd 0000:00:14.0: //   CAPLENGTH: 0x80
Nov 30 12:19:23 xanatos kernel: [    2.713236] xhci_hcd 0000:00:14.0: // xHCI operational registers at ffffc90005e40080:
Nov 30 12:19:23 xanatos kernel: [    2.713243] xhci_hcd 0000:00:14.0: // @ffffc90005e40018 = 0x2000 RTSOFF
Nov 30 12:19:23 xanatos kernel: [    2.713245] xhci_hcd 0000:00:14.0: // xHCI runtime registers at ffffc90005e42000:
Nov 30 12:19:23 xanatos kernel: [    2.713251] xhci_hcd 0000:00:14.0: // @ffffc90005e40014 = 0x3000 DBOFF
Nov 30 12:19:23 xanatos kernel: [    2.713253] xhci_hcd 0000:00:14.0: // Doorbell array at ffffc90005e43000:
Nov 30 12:19:23 xanatos kernel: [    2.713256] xhci_hcd 0000:00:14.0: xHCI runtime registers at ffffc90005e42000:
Nov 30 12:19:23 xanatos kernel: [    2.713262] xhci_hcd 0000:00:14.0:   ffffc90005e42000: Microframe index = 0x0
Nov 30 12:19:23 xanatos kernel: [    2.713282] xhci_hcd 0000:00:14.0: // Allocating event ring
Nov 30 12:19:23 xanatos kernel: [    2.713286] xhci_hcd 0000:00:14.0: TRB math tests passed.
Nov 30 12:19:23 xanatos kernel: [    2.713295] xhci_hcd 0000:00:14.0: // Allocated event ring segment table at 0x34803000
Nov 30 12:19:23 xanatos kernel: [    2.713298] xhci_hcd 0000:00:14.0: Set ERST to 0; private num segs = 1, virt addr = ffff880034803000, dma addr = 0x34803000
Nov 30 12:19:23 xanatos kernel: [    2.713304] xhci_hcd 0000:00:14.0: // Write ERST size = 1 to ir_set 0 (some bits preserved)
Nov 30 12:19:23 xanatos kernel: [    2.713306] xhci_hcd 0000:00:14.0: // Set ERST entries to point to event ring.
Nov 30 12:19:23 xanatos kernel: [    2.713308] xhci_hcd 0000:00:14.0: // Set ERST base address for ir_set 0 = 0x34803000
Nov 30 12:19:23 xanatos kernel: [    2.713315] xhci_hcd 0000:00:14.0: // Write event ring dequeue pointer, preserving EHB bit
Nov 30 12:19:23 xanatos kernel: [    2.713318] xhci_hcd 0000:00:14.0: Wrote ERST address to ir_set 0.
Nov 30 12:19:23 xanatos kernel: [    2.713322] xhci_hcd 0000:00:14.0: Allocating 16 scratchpad buffers
Nov 30 12:19:23 xanatos kernel: [    2.713455] xhci_hcd 0000:00:14.0: Ext Cap ffffc90005e48000, port offset = 1, count = 4, revision = 0x2
Nov 30 12:19:23 xanatos kernel: [    2.713457] xhci_hcd 0000:00:14.0: xHCI 1.0: support USB2 software lpm
Nov 30 12:19:23 xanatos kernel: [    2.713465] xhci_hcd 0000:00:14.0: Ext Cap ffffc90005e48020, port offset = 5, count = 4, revision = 0x3
Nov 30 12:19:23 xanatos kernel: [    2.713468] xhci_hcd 0000:00:14.0: Found 4 USB 2.0 ports and 4 USB 3.0 ports.
Nov 30 12:19:23 xanatos kernel: [    2.713470] xhci_hcd 0000:00:14.0: USB 2.0 port at index 0, addr = ffffc90005e40480
Nov 30 12:19:23 xanatos kernel: [    2.713473] xhci_hcd 0000:00:14.0: USB 2.0 port at index 1, addr = ffffc90005e40490
Nov 30 12:19:23 xanatos kernel: [    2.713476] xhci_hcd 0000:00:14.0: USB 2.0 port at index 2, addr = ffffc90005e404a0
Nov 30 12:19:23 xanatos kernel: [    2.713478] xhci_hcd 0000:00:14.0: USB 2.0 port at index 3, addr = ffffc90005e404b0
Nov 30 12:19:23 xanatos kernel: [    2.713481] xhci_hcd 0000:00:14.0: USB 3.0 port at index 4, addr = ffffc90005e404c0
Nov 30 12:19:23 xanatos kernel: [    2.713483] xhci_hcd 0000:00:14.0: USB 3.0 port at index 5, addr = ffffc90005e404d0
Nov 30 12:19:23 xanatos kernel: [    2.713486] xhci_hcd 0000:00:14.0: USB 3.0 port at index 6, addr = ffffc90005e404e0
Nov 30 12:19:23 xanatos kernel: [    2.713488] xhci_hcd 0000:00:14.0: USB 3.0 port at index 7, addr = ffffc90005e404f0
Nov 30 12:19:23 xanatos kernel: [    2.713494] xhci_hcd 0000:00:14.0: Finished xhci_init
Nov 30 12:19:23 xanatos kernel: [    2.713496] xhci_hcd 0000:00:14.0: Called HCD init
Nov 30 12:19:23 xanatos kernel: [    2.713503] xhci_hcd 0000:00:14.0: Got SBRN 48
Nov 30 12:19:23 xanatos kernel: [    2.713512] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
Nov 30 12:19:23 xanatos kernel: [    2.713515] xhci_hcd 0000:00:14.0: Finished xhci_pci_reinit
Nov 30 12:19:23 xanatos kernel: [    2.713517] xhci_hcd 0000:00:14.0: supports USB remote wakeup
Nov 30 12:19:23 xanatos kernel: [    2.713547] xhci_hcd 0000:00:14.0: irq 16, io mem 0xf2520000
Nov 30 12:19:23 xanatos kernel: [    2.713549] xhci_hcd 0000:00:14.0: xhci_run
Nov 30 12:19:23 xanatos kernel: [    2.713573] xhci_hcd 0000:00:14.0: Failed to enable MSI-X
Nov 30 12:19:23 xanatos kernel: [    2.713641] xhci_hcd 0000:00:14.0: irq 42 for MSI/MSI-X
Nov 30 12:19:23 xanatos kernel: [    2.713688] xhci_hcd 0000:00:14.0: Setting event ring polling timer
Nov 30 12:19:23 xanatos kernel: [    2.713692] xhci_hcd 0000:00:14.0: Command ring memory map follows:
Nov 30 12:19:23 xanatos kernel: [    2.713695] xhci_hcd 0000:00:14.0: @0000000034801000 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713698] xhci_hcd 0000:00:14.0: @0000000034801010 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713701] xhci_hcd 0000:00:14.0: @0000000034801020 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713703] xhci_hcd 0000:00:14.0: @0000000034801030 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713706] xhci_hcd 0000:00:14.0: @0000000034801040 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713709] xhci_hcd 0000:00:14.0: @0000000034801050 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713712] xhci_hcd 0000:00:14.0: @0000000034801060 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713714] xhci_hcd 0000:00:14.0: @0000000034801070 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713717] xhci_hcd 0000:00:14.0: @0000000034801080 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713720] xhci_hcd 0000:00:14.0: @0000000034801090 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713723] xhci_hcd 0000:00:14.0: @00000000348010a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713725] xhci_hcd 0000:00:14.0: @00000000348010b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713728] xhci_hcd 0000:00:14.0: @00000000348010c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713731] xhci_hcd 0000:00:14.0: @00000000348010d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713733] xhci_hcd 0000:00:14.0: @00000000348010e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713736] xhci_hcd 0000:00:14.0: @00000000348010f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713739] xhci_hcd 0000:00:14.0: @0000000034801100 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713742] xhci_hcd 0000:00:14.0: @0000000034801110 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713744] xhci_hcd 0000:00:14.0: @0000000034801120 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713747] xhci_hcd 0000:00:14.0: @0000000034801130 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713750] xhci_hcd 0000:00:14.0: @0000000034801140 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713752] xhci_hcd 0000:00:14.0: @0000000034801150 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713755] xhci_hcd 0000:00:14.0: @0000000034801160 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713758] xhci_hcd 0000:00:14.0: @0000000034801170 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713761] xhci_hcd 0000:00:14.0: @0000000034801180 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713764] xhci_hcd 0000:00:14.0: @0000000034801190 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713767] xhci_hcd 0000:00:14.0: @00000000348011a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713769] xhci_hcd 0000:00:14.0: @00000000348011b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713772] xhci_hcd 0000:00:14.0: @00000000348011c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713775] xhci_hcd 0000:00:14.0: @00000000348011d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713777] xhci_hcd 0000:00:14.0: @00000000348011e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713780] xhci_hcd 0000:00:14.0: @00000000348011f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713783] xhci_hcd 0000:00:14.0: @0000000034801200 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713786] xhci_hcd 0000:00:14.0: @0000000034801210 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713789] xhci_hcd 0000:00:14.0: @0000000034801220 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713791] xhci_hcd 0000:00:14.0: @0000000034801230 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713794] xhci_hcd 0000:00:14.0: @0000000034801240 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713797] xhci_hcd 0000:00:14.0: @0000000034801250 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713799] xhci_hcd 0000:00:14.0: @0000000034801260 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713802] xhci_hcd 0000:00:14.0: @0000000034801270 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713804] xhci_hcd 0000:00:14.0: @0000000034801280 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713807] xhci_hcd 0000:00:14.0: @0000000034801290 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713810] xhci_hcd 0000:00:14.0: @00000000348012a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713812] xhci_hcd 0000:00:14.0: @00000000348012b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713815] xhci_hcd 0000:00:14.0: @00000000348012c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713818] xhci_hcd 0000:00:14.0: @00000000348012d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713820] xhci_hcd 0000:00:14.0: @00000000348012e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713823] xhci_hcd 0000:00:14.0: @00000000348012f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713826] xhci_hcd 0000:00:14.0: @0000000034801300 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713828] xhci_hcd 0000:00:14.0: @0000000034801310 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713831] xhci_hcd 0000:00:14.0: @0000000034801320 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713834] xhci_hcd 0000:00:14.0: @0000000034801330 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713836] xhci_hcd 0000:00:14.0: @0000000034801340 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713839] xhci_hcd 0000:00:14.0: @0000000034801350 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713841] xhci_hcd 0000:00:14.0: @0000000034801360 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713844] xhci_hcd 0000:00:14.0: @0000000034801370 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713847] xhci_hcd 0000:00:14.0: @0000000034801380 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713850] xhci_hcd 0000:00:14.0: @0000000034801390 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713852] xhci_hcd 0000:00:14.0: @00000000348013a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713855] xhci_hcd 0000:00:14.0: @00000000348013b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713858] xhci_hcd 0000:00:14.0: @00000000348013c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713861] xhci_hcd 0000:00:14.0: @00000000348013d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713863] xhci_hcd 0000:00:14.0: @00000000348013e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713866] xhci_hcd 0000:00:14.0: @00000000348013f0 34801000 00000000 00000000 00001802
Nov 30 12:19:23 xanatos kernel: [    2.713868] xhci_hcd 0000:00:14.0:   Ring has not been updated
Nov 30 12:19:23 xanatos kernel: [    2.713871] xhci_hcd 0000:00:14.0: Ring deq = ffff880034801000 (virt), 0x34801000 (dma)
Nov 30 12:19:23 xanatos kernel: [    2.713873] xhci_hcd 0000:00:14.0: Ring deq updated 0 times
Nov 30 12:19:23 xanatos kernel: [    2.713875] xhci_hcd 0000:00:14.0: Ring enq = ffff880034801000 (virt), 0x34801000 (dma)
Nov 30 12:19:23 xanatos kernel: [    2.713878] xhci_hcd 0000:00:14.0: Ring enq updated 0 times
Nov 30 12:19:23 xanatos kernel: [    2.713885] xhci_hcd 0000:00:14.0: // xHC command ring deq ptr low bits + flags = @00000000
Nov 30 12:19:23 xanatos kernel: [    2.713887] xhci_hcd 0000:00:14.0: // xHC command ring deq ptr high bits = @00000000
Nov 30 12:19:23 xanatos kernel: [    2.713890] xhci_hcd 0000:00:14.0: ERST memory map follows:
Nov 30 12:19:23 xanatos kernel: [    2.713893] xhci_hcd 0000:00:14.0: @0000000034803000 34801400 00000000 00000040 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713895] xhci_hcd 0000:00:14.0: Event ring:
Nov 30 12:19:23 xanatos kernel: [    2.713898] xhci_hcd 0000:00:14.0: @0000000034801400 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713900] xhci_hcd 0000:00:14.0: @0000000034801410 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713903] xhci_hcd 0000:00:14.0: @0000000034801420 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713906] xhci_hcd 0000:00:14.0: @0000000034801430 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713908] xhci_hcd 0000:00:14.0: @0000000034801440 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713911] xhci_hcd 0000:00:14.0: @0000000034801450 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713913] xhci_hcd 0000:00:14.0: @0000000034801460 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713917] xhci_hcd 0000:00:14.0: @0000000034801470 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713919] xhci_hcd 0000:00:14.0: @0000000034801480 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713922] xhci_hcd 0000:00:14.0: @0000000034801490 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713925] xhci_hcd 0000:00:14.0: @00000000348014a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713928] xhci_hcd 0000:00:14.0: @00000000348014b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713931] xhci_hcd 0000:00:14.0: @00000000348014c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713933] xhci_hcd 0000:00:14.0: @00000000348014d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713937] xhci_hcd 0000:00:14.0: @00000000348014e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713939] xhci_hcd 0000:00:14.0: @00000000348014f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713942] xhci_hcd 0000:00:14.0: @0000000034801500 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713945] xhci_hcd 0000:00:14.0: @0000000034801510 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713947] xhci_hcd 0000:00:14.0: @0000000034801520 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713950] xhci_hcd 0000:00:14.0: @0000000034801530 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713952] xhci_hcd 0000:00:14.0: @0000000034801540 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713955] xhci_hcd 0000:00:14.0: @0000000034801550 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713958] xhci_hcd 0000:00:14.0: @0000000034801560 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713960] xhci_hcd 0000:00:14.0: @0000000034801570 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713963] xhci_hcd 0000:00:14.0: @0000000034801580 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713966] xhci_hcd 0000:00:14.0: @0000000034801590 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713969] xhci_hcd 0000:00:14.0: @00000000348015a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713971] xhci_hcd 0000:00:14.0: @00000000348015b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713974] xhci_hcd 0000:00:14.0: @00000000348015c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713977] xhci_hcd 0000:00:14.0: @00000000348015d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713980] xhci_hcd 0000:00:14.0: @00000000348015e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713982] xhci_hcd 0000:00:14.0: @00000000348015f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713985] xhci_hcd 0000:00:14.0: @0000000034801600 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713988] xhci_hcd 0000:00:14.0: @0000000034801610 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713991] xhci_hcd 0000:00:14.0: @0000000034801620 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713994] xhci_hcd 0000:00:14.0: @0000000034801630 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713996] xhci_hcd 0000:00:14.0: @0000000034801640 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.713999] xhci_hcd 0000:00:14.0: @0000000034801650 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714002] xhci_hcd 0000:00:14.0: @0000000034801660 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714004] xhci_hcd 0000:00:14.0: @0000000034801670 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714007] xhci_hcd 0000:00:14.0: @0000000034801680 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714010] xhci_hcd 0000:00:14.0: @0000000034801690 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714012] xhci_hcd 0000:00:14.0: @00000000348016a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714015] xhci_hcd 0000:00:14.0: @00000000348016b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714018] xhci_hcd 0000:00:14.0: @00000000348016c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714020] xhci_hcd 0000:00:14.0: @00000000348016d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714023] xhci_hcd 0000:00:14.0: @00000000348016e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714026] xhci_hcd 0000:00:14.0: @00000000348016f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714028] xhci_hcd 0000:00:14.0: @0000000034801700 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714031] xhci_hcd 0000:00:14.0: @0000000034801710 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714033] xhci_hcd 0000:00:14.0: @0000000034801720 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714036] xhci_hcd 0000:00:14.0: @0000000034801730 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714039] xhci_hcd 0000:00:14.0: @0000000034801740 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714042] xhci_hcd 0000:00:14.0: @0000000034801750 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714045] xhci_hcd 0000:00:14.0: @0000000034801760 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714047] xhci_hcd 0000:00:14.0: @0000000034801770 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714050] xhci_hcd 0000:00:14.0: @0000000034801780 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714053] xhci_hcd 0000:00:14.0: @0000000034801790 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714056] xhci_hcd 0000:00:14.0: @00000000348017a0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714058] xhci_hcd 0000:00:14.0: @00000000348017b0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714061] xhci_hcd 0000:00:14.0: @00000000348017c0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714064] xhci_hcd 0000:00:14.0: @00000000348017d0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714067] xhci_hcd 0000:00:14.0: @00000000348017e0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714070] xhci_hcd 0000:00:14.0: @00000000348017f0 00000000 00000000 00000000 00000000
Nov 30 12:19:23 xanatos kernel: [    2.714072] xhci_hcd 0000:00:14.0:   Ring has not been updated
Nov 30 12:19:23 xanatos kernel: [    2.714075] xhci_hcd 0000:00:14.0: Ring deq = ffff880034801400 (virt), 0x34801400 (dma)
Nov 30 12:19:23 xanatos kernel: [    2.714077] xhci_hcd 0000:00:14.0: Ring deq updated 0 times
Nov 30 12:19:23 xanatos kernel: [    2.714079] xhci_hcd 0000:00:14.0: Ring enq = ffff880034801400 (virt), 0x34801400 (dma)
Nov 30 12:19:23 xanatos kernel: [    2.714081] xhci_hcd 0000:00:14.0: Ring enq updated 0 times
Nov 30 12:19:23 xanatos kernel: [    2.714088] xhci_hcd 0000:00:14.0: ERST deq = 64'h34801400
Nov 30 12:19:23 xanatos kernel: [    2.714090] xhci_hcd 0000:00:14.0: // Set the interrupt modulation register
Nov 30 12:19:23 xanatos kernel: [    2.714097] xhci_hcd 0000:00:14.0: // Enable interrupts, cmd = 0x4.
Nov 30 12:19:23 xanatos kernel: [    2.714102] xhci_hcd 0000:00:14.0: // Enabling event ring interrupter ffffc90005e42020 by writing 0x2 to irq_pending
Nov 30 12:19:23 xanatos kernel: [    2.714106] xhci_hcd 0000:00:14.0:   ffffc90005e42020: ir_set[0]
Nov 30 12:19:23 xanatos kernel: [    2.714108] xhci_hcd 0000:00:14.0:   ffffc90005e42020: ir_set.pending = 0x2
Nov 30 12:19:23 xanatos kernel: [    2.714113] xhci_hcd 0000:00:14.0:   ffffc90005e42024: ir_set.control = 0xa0
Nov 30 12:19:23 xanatos kernel: [    2.714118] xhci_hcd 0000:00:14.0:   ffffc90005e42028: ir_set.erst_size = 0x1
Nov 30 12:19:23 xanatos kernel: [    2.714124] xhci_hcd 0000:00:14.0:   ffffc90005e42030: ir_set.erst_base = @34803000
Nov 30 12:19:23 xanatos kernel: [    2.714129] xhci_hcd 0000:00:14.0:   ffffc90005e42038: ir_set.erst_dequeue = @34801400
Nov 30 12:19:23 xanatos kernel: [    2.714132] xhci_hcd 0000:00:14.0: Finished xhci_run for USB2 roothub
Nov 30 12:19:23 xanatos kernel: [    2.714251] usb usb1: default language 0x0409
Nov 30 12:19:23 xanatos kernel: [    2.714264] usb usb1: udev 1, busnum 1, minor = 0
Nov 30 12:19:23 xanatos kernel: [    2.714266] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Nov 30 12:19:23 xanatos kernel: [    2.714282] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 30 12:19:23 xanatos kernel: [    2.714284] usb usb1: Product: xHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    2.714287] usb usb1: Manufacturer: Linux 3.7.0-rc6+ xhci_hcd
Nov 30 12:19:23 xanatos kernel: [    2.714289] usb usb1: SerialNumber: 0000:00:14.0
Nov 30 12:19:23 xanatos kernel: [    2.721544] usb usb1: usb_probe_device
Nov 30 12:19:23 xanatos kernel: [    2.721550] usb usb1: configuration #1 chosen from 1 choice
Nov 30 12:19:23 xanatos kernel: [    2.721595] xHCI xhci_add_endpoint called for root hub
Nov 30 12:19:23 xanatos kernel: [    2.721597] xHCI xhci_check_bandwidth called for root hub
Nov 30 12:19:23 xanatos kernel: [    2.721611] usb usb1: adding 1-0:1.0 (config #1, interface 0)
Nov 30 12:19:23 xanatos kernel: [    2.721677] hub 1-0:1.0: usb_probe_interface
Nov 30 12:19:23 xanatos kernel: [    2.721680] hub 1-0:1.0: usb_probe_interface - got id
Nov 30 12:19:23 xanatos kernel: [    2.721685] hub 1-0:1.0: USB hub found
Nov 30 12:19:23 xanatos kernel: [    2.721726] hub 1-0:1.0: 4 ports detected
Nov 30 12:19:23 xanatos kernel: [    2.721728] hub 1-0:1.0: standalone hub
Nov 30 12:19:23 xanatos kernel: [    2.721730] hub 1-0:1.0: no power switching (usb 1.0)
Nov 30 12:19:23 xanatos kernel: [    2.721732] hub 1-0:1.0: individual port over-current protection
Nov 30 12:19:23 xanatos kernel: [    2.721735] hub 1-0:1.0: Single TT
Nov 30 12:19:23 xanatos kernel: [    2.721737] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
Nov 30 12:19:23 xanatos kernel: [    2.721739] hub 1-0:1.0: power on to power good time: 20ms
Nov 30 12:19:23 xanatos kernel: [    2.721769] hub 1-0:1.0: local power source is good
Nov 30 12:19:23 xanatos kernel: [    2.724157] hub 1-0:1.0: trying to enable port power on non-switchable hub
Nov 30 12:19:23 xanatos kernel: [    2.724172] xhci_hcd 0000:00:14.0: set port power, actual port 0 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.724186] xhci_hcd 0000:00:14.0: set port power, actual port 1 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.724195] xhci_hcd 0000:00:14.0: set port power, actual port 2 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.724205] xhci_hcd 0000:00:14.0: set port power, actual port 3 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.724382] xhci_hcd 0000:00:14.0: xHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    2.724390] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
Nov 30 12:19:23 xanatos kernel: [    2.724400] xhci_hcd 0000:00:14.0: Enabling 64-bit DMA addresses.
Nov 30 12:19:23 xanatos kernel: [    2.724403] xhci_hcd 0000:00:14.0: supports USB remote wakeup
Nov 30 12:19:23 xanatos kernel: [    2.724408] xhci_hcd 0000:00:14.0: // Turn on HC, cmd = 0x5.
Nov 30 12:19:23 xanatos kernel: [    2.724411] xhci_hcd 0000:00:14.0: Finished xhci_run for USB3 roothub
Nov 30 12:19:23 xanatos kernel: [    2.724438] usb usb2: skipped 1 descriptor after endpoint
Nov 30 12:19:23 xanatos kernel: [    2.724443] usb usb2: default language 0x0409
Nov 30 12:19:23 xanatos kernel: [    2.724455] usb usb2: udev 1, busnum 2, minor = 128
Nov 30 12:19:23 xanatos kernel: [    2.724458] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
Nov 30 12:19:23 xanatos kernel: [    2.724461] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 30 12:19:23 xanatos kernel: [    2.724463] usb usb2: Product: xHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    2.724465] usb usb2: Manufacturer: Linux 3.7.0-rc6+ xhci_hcd
Nov 30 12:19:23 xanatos kernel: [    2.724468] usb usb2: SerialNumber: 0000:00:14.0
Nov 30 12:19:23 xanatos kernel: [    2.724598] usb usb2: usb_probe_device
Nov 30 12:19:23 xanatos kernel: [    2.724601] usb usb2: configuration #1 chosen from 1 choice
Nov 30 12:19:23 xanatos kernel: [    2.724605] xHCI xhci_add_endpoint called for root hub
Nov 30 12:19:23 xanatos kernel: [    2.724607] xHCI xhci_check_bandwidth called for root hub
Nov 30 12:19:23 xanatos kernel: [    2.724617] usb usb2: adding 2-0:1.0 (config #1, interface 0)
Nov 30 12:19:23 xanatos kernel: [    2.724658] hub 2-0:1.0: usb_probe_interface
Nov 30 12:19:23 xanatos kernel: [    2.724661] hub 2-0:1.0: usb_probe_interface - got id
Nov 30 12:19:23 xanatos kernel: [    2.724665] hub 2-0:1.0: USB hub found
Nov 30 12:19:23 xanatos kernel: [    2.724679] hub 2-0:1.0: 4 ports detected
Nov 30 12:19:23 xanatos kernel: [    2.724682] hub 2-0:1.0: standalone hub
Nov 30 12:19:23 xanatos kernel: [    2.724684] hub 2-0:1.0: no power switching (usb 1.0)
Nov 30 12:19:23 xanatos kernel: [    2.724687] hub 2-0:1.0: individual port over-current protection
Nov 30 12:19:23 xanatos kernel: [    2.724690] hub 2-0:1.0: TT requires at most 8 FS bit times (666 ns)
Nov 30 12:19:23 xanatos kernel: [    2.724692] hub 2-0:1.0: power on to power good time: 20ms
Nov 30 12:19:23 xanatos kernel: [    2.724700] hub 2-0:1.0: local power source is good
Nov 30 12:19:23 xanatos kernel: [    2.725873] hub 2-0:1.0: trying to enable port power on non-switchable hub
Nov 30 12:19:23 xanatos kernel: [    2.725883] xhci_hcd 0000:00:14.0: set port power, actual port 0 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.725892] xhci_hcd 0000:00:14.0: set port power, actual port 1 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.725899] xhci_hcd 0000:00:14.0: set port power, actual port 2 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.725907] xhci_hcd 0000:00:14.0: set port power, actual port 3 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.743105] pci 0000:00:00.0: Intel Ivybridge Chipset
Nov 30 12:19:23 xanatos kernel: [    2.743231] pci 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
Nov 30 12:19:23 xanatos kernel: [    2.744259] pci 0000:00:00.0: detected 65536K stolen memory
Nov 30 12:19:23 xanatos kernel: [    2.744345] i915 0000:00:02.0: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    2.790572] i915 0000:00:02.0: irq 43 for MSI/MSI-X
Nov 30 12:19:23 xanatos kernel: [    2.790582] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
Nov 30 12:19:23 xanatos kernel: [    2.790583] [drm] Driver supports precise vblank timestamp query.
Nov 30 12:19:23 xanatos kernel: [    2.790651] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
Nov 30 12:19:23 xanatos kernel: [    2.822184] xhci_hcd 0000:00:14.0: get port status, actual port 0 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822186] xhci_hcd 0000:00:14.0: Get port status returned 0x100
Nov 30 12:19:23 xanatos kernel: [    2.822196] xhci_hcd 0000:00:14.0: get port status, actual port 1 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822198] xhci_hcd 0000:00:14.0: Get port status returned 0x100
Nov 30 12:19:23 xanatos kernel: [    2.822204] xhci_hcd 0000:00:14.0: get port status, actual port 2 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822205] xhci_hcd 0000:00:14.0: Get port status returned 0x100
Nov 30 12:19:23 xanatos kernel: [    2.822211] xhci_hcd 0000:00:14.0: get port status, actual port 3 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822212] xhci_hcd 0000:00:14.0: Get port status returned 0x100
Nov 30 12:19:23 xanatos kernel: [    2.822223] hub 1-0:1.0: state 7 ports 4 chg 0000 evt 0000
Nov 30 12:19:23 xanatos kernel: [    2.822225] xhci_hcd 0000:00:14.0: get port status, actual port 0 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.822228] xhci_hcd 0000:00:14.0: Get port status returned 0x2002a0
Nov 30 12:19:23 xanatos kernel: [    2.822239] xhci_hcd 0000:00:14.0: clear port warm(BH) reset change, actual port 0 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822244] xhci_hcd 0000:00:14.0: get port status, actual port 1 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.822246] xhci_hcd 0000:00:14.0: Get port status returned 0x2002a0
Nov 30 12:19:23 xanatos kernel: [    2.822253] xhci_hcd 0000:00:14.0: clear port warm(BH) reset change, actual port 1 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822258] xhci_hcd 0000:00:14.0: get port status, actual port 2 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.822259] xhci_hcd 0000:00:14.0: Get port status returned 0x2002a0
Nov 30 12:19:23 xanatos kernel: [    2.822265] xhci_hcd 0000:00:14.0: clear port warm(BH) reset change, actual port 2 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.822270] xhci_hcd 0000:00:14.0: get port status, actual port 3 status  = 0x802a0
Nov 30 12:19:23 xanatos kernel: [    2.822271] xhci_hcd 0000:00:14.0: Get port status returned 0x2002a0
Nov 30 12:19:23 xanatos kernel: [    2.822277] xhci_hcd 0000:00:14.0: clear port warm(BH) reset change, actual port 3 status  = 0x2a0
Nov 30 12:19:23 xanatos kernel: [    2.921980] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
Nov 30 12:19:23 xanatos kernel: [    3.003914] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp off
Nov 30 12:19:23 xanatos kernel: [    3.293440] fb0: inteldrmfb frame buffer device
Nov 30 12:19:23 xanatos kernel: [    3.293443] drm: registered panic notifier
Nov 30 12:19:23 xanatos kernel: [    3.371293] acpi device:01: registered as cooling_device2
Nov 30 12:19:23 xanatos kernel: [    3.371599] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Nov 30 12:19:23 xanatos kernel: [    3.371666] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input5
Nov 30 12:19:23 xanatos kernel: [    3.371783] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
Nov 30 12:19:23 xanatos kernel: [    1.685620] ACPI: Invalid Power Resource to register!
Nov 30 12:19:23 xanatos kernel: [    4.199607] Console: switching to colour frame buffer device 170x48
Nov 30 12:19:23 xanatos kernel: [    4.879122] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Nov 30 12:19:23 xanatos kernel: [    6.483181] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
Nov 30 12:19:23 xanatos kernel: [    6.601739] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Nov 30 12:19:23 xanatos kernel: [    6.601744] ehci_hcd: block sizes: qh 104 qtd 96 itd 192 sitd 96
Nov 30 12:19:23 xanatos kernel: [    6.605811] ehci-pci: EHCI PCI platform driver
Nov 30 12:19:23 xanatos kernel: [    6.605909] ehci-pci 0000:00:1a.0: enabling bus mastering
Nov 30 12:19:23 xanatos kernel: [    6.605919] ehci-pci 0000:00:1a.0: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    6.605924] ehci-pci 0000:00:1a.0: EHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    6.605935] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
Nov 30 12:19:23 xanatos kernel: [    6.605950] ehci-pci 0000:00:1a.0: reset hcs_params 0x200003 dbg=2 cc=0 pcc=0 ordered !ppc ports=3
Nov 30 12:19:23 xanatos kernel: [    6.605955] ehci-pci 0000:00:1a.0: reset hcc_params 36881 caching frame 1024 64 bit addr
Nov 30 12:19:23 xanatos kernel: [    6.606044] ehci-pci 0000:00:1a.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
Nov 30 12:19:23 xanatos kernel: [    6.618825] ehci-pci 0000:00:1a.0: debug port 2
Nov 30 12:19:23 xanatos kernel: [    6.619499] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
Nov 30 12:19:23 xanatos kernel: [    6.619503] ehci-pci 0000:00:1a.0: supports USB remote wakeup
Nov 30 12:19:23 xanatos kernel: [    6.619524] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf253a000
Nov 30 12:19:23 xanatos kernel: [    6.619534] ehci-pci 0000:00:1a.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
Nov 30 12:19:23 xanatos kernel: [    6.632353] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
Nov 30 12:19:23 xanatos kernel: [    6.632416] usb usb3: default language 0x0409
Nov 30 12:19:23 xanatos kernel: [    6.632429] usb usb3: udev 1, busnum 3, minor = 256
Nov 30 12:19:23 xanatos kernel: [    6.632433] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
Nov 30 12:19:23 xanatos kernel: [    6.632436] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 30 12:19:23 xanatos kernel: [    6.632439] usb usb3: Product: EHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    6.632441] usb usb3: Manufacturer: Linux 3.7.0-rc6+ ehci_hcd
Nov 30 12:19:23 xanatos kernel: [    6.632443] usb usb3: SerialNumber: 0000:00:1a.0
Nov 30 12:19:23 xanatos kernel: [    6.632627] usb usb3: usb_probe_device
Nov 30 12:19:23 xanatos kernel: [    6.632631] usb usb3: configuration #1 chosen from 1 choice
Nov 30 12:19:23 xanatos kernel: [    6.632645] usb usb3: adding 3-0:1.0 (config #1, interface 0)
Nov 30 12:19:23 xanatos kernel: [    6.632868] hub 3-0:1.0: usb_probe_interface
Nov 30 12:19:23 xanatos kernel: [    6.632871] hub 3-0:1.0: usb_probe_interface - got id
Nov 30 12:19:23 xanatos kernel: [    6.632876] hub 3-0:1.0: USB hub found
Nov 30 12:19:23 xanatos kernel: [    6.632885] hub 3-0:1.0: 3 ports detected
Nov 30 12:19:23 xanatos kernel: [    6.632887] hub 3-0:1.0: standalone hub
Nov 30 12:19:23 xanatos kernel: [    6.632890] hub 3-0:1.0: no power switching (usb 1.0)
Nov 30 12:19:23 xanatos kernel: [    6.632892] hub 3-0:1.0: individual port over-current protection
Nov 30 12:19:23 xanatos kernel: [    6.632895] hub 3-0:1.0: power on to power good time: 20ms
Nov 30 12:19:23 xanatos kernel: [    6.632903] hub 3-0:1.0: local power source is good
Nov 30 12:19:23 xanatos kernel: [    6.633290] hub 3-0:1.0: trying to enable port power on non-switchable hub
Nov 30 12:19:23 xanatos kernel: [    6.633467] ehci-pci 0000:00:1d.0: enabling bus mastering
Nov 30 12:19:23 xanatos kernel: [    6.633476] ehci-pci 0000:00:1d.0: setting latency timer to 64
Nov 30 12:19:23 xanatos kernel: [    6.633493] ehci-pci 0000:00:1d.0: EHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    6.633502] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
Nov 30 12:19:23 xanatos kernel: [    6.633515] ehci-pci 0000:00:1d.0: reset hcs_params 0x200003 dbg=2 cc=0 pcc=0 ordered !ppc ports=3
Nov 30 12:19:23 xanatos kernel: [    6.633519] ehci-pci 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
Nov 30 12:19:23 xanatos kernel: [    6.633598] ehci-pci 0000:00:1d.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
Nov 30 12:19:23 xanatos kernel: [    6.637480] ehci-pci 0000:00:1d.0: debug port 2
Nov 30 12:19:23 xanatos kernel: [    6.637494] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
Nov 30 12:19:23 xanatos kernel: [    6.637497] ehci-pci 0000:00:1d.0: supports USB remote wakeup
Nov 30 12:19:23 xanatos kernel: [    6.637527] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf2539000
Nov 30 12:19:23 xanatos kernel: [    6.637536] ehci-pci 0000:00:1d.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
Nov 30 12:19:23 xanatos kernel: [    6.662596] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
Nov 30 12:19:23 xanatos kernel: [    6.662660] usb usb4: default language 0x0409
Nov 30 12:19:23 xanatos kernel: [    6.662673] usb usb4: udev 1, busnum 4, minor = 384
Nov 30 12:19:23 xanatos kernel: [    6.662676] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
Nov 30 12:19:23 xanatos kernel: [    6.662679] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Nov 30 12:19:23 xanatos kernel: [    6.662681] usb usb4: Product: EHCI Host Controller
Nov 30 12:19:23 xanatos kernel: [    6.662684] usb usb4: Manufacturer: Linux 3.7.0-rc6+ ehci_hcd
Nov 30 12:19:23 xanatos kernel: [    6.662686] usb usb4: SerialNumber: 0000:00:1d.0
Nov 30 12:19:23 xanatos kernel: [    6.662843] usb usb4: usb_probe_device
Nov 30 12:19:23 xanatos kernel: [    6.662846] usb usb4: configuration #1 chosen from 1 choice
Nov 30 12:19:23 xanatos kernel: [    6.662860] usb usb4: adding 4-0:1.0 (config #1, interface 0)
Nov 30 12:19:23 xanatos kernel: [    6.662917] hub 4-0:1.0: usb_probe_interface
Nov 30 12:19:23 xanatos kernel: [    6.662920] hub 4-0:1.0: usb_probe_interface - got id
Nov 30 12:19:23 xanatos kernel: [    6.662925] hub 4-0:1.0: USB hub found
Nov 30 12:19:23 xanatos kernel: [    6.662934] hub 4-0:1.0: 3 ports detected
Nov 30 12:19:23 xanatos kernel: [    6.662937] hub 4-0:1.0: standalone hub
Nov 30 12:19:23 xanatos kernel: [    6.662939] hub 4-0:1.0: no power switching (usb 1.0)
Nov 30 12:19:23 xanatos kernel: [    6.662941] hub 4-0:1.0: individual port over-current protection
Nov 30 12:19:23 xanatos kernel: [    6.662944] hub 4-0:1.0: power on to power good time: 20ms
Nov 30 12:19:23 xanatos kernel: [    6.662952] hub 4-0:1.0: local power source is good
Nov 30 12:19:23 xanatos kernel: [    6.663211] hub 4-0:1.0: trying to enable port power on non-switchable hub
Nov 30 12:19:23 xanatos kernel: [    6.729202] cfg80211: Calling CRDA to update world regulatory domain
Nov 30 12:19:23 xanatos kernel: [    6.730820] ehci-pci 0000:00:1a.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
Nov 30 12:19:23 xanatos kernel: [    6.730827] hub 3-0:1.0: port 1: status 0501 change 0001
Nov 30 12:19:23 xanatos kernel: [    6.763278] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
Nov 30 12:19:23 xanatos kernel: [    6.763287] hub 4-0:1.0: port 1: status 0501 change 0001
Nov 30 12:19:23 xanatos kernel: [    6.772393] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x13
Nov 30 12:19:23 xanatos kernel: [    6.780483] Intel(R) Wireless WiFi driver for Linux, in-tree:
Nov 30 12:19:23 xanatos kernel: [    6.780486] Copyright(c) 2003-2012 Intel Corporation
Nov 30 12:19:23 xanatos kernel: [    6.780618] iwlwifi 0000:03:00.0: pci_resource_len = 0x00002000
Nov 30 12:19:23 xanatos kernel: [    6.780621] iwlwifi 0000:03:00.0: pci_resource_base = ffffc90000070000
Nov 30 12:19:23 xanatos kernel: [    6.780624] iwlwifi 0000:03:00.0: HW Revision ID = 0x34
Nov 30 12:19:23 xanatos kernel: [    6.780809] iwlwifi 0000:03:00.0: irq 44 for MSI/MSI-X
Nov 30 12:19:23 xanatos kernel: [    6.787180] iwlwifi 0000:03:00.0: loaded firmware version 18.168.6.1
Nov 30 12:19:23 xanatos kernel: [    6.831356] hub 3-0:1.0: state 7 ports 3 chg 0002 evt 0000
Nov 30 12:19:23 xanatos kernel: [    6.831375] hub 3-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
Nov 30 12:19:23 xanatos kernel: [    6.886682] ehci-pci 0000:00:1a.0: port 1 reset complete, port enabled
Nov 30 12:19:23 xanatos kernel: [    6.886690] ehci-pci 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
Nov 30 12:19:23 xanatos kernel: [    6.912939] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x13
Nov 30 12:19:23 xanatos kernel: [    6.922158] microcode: Microcode Update Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
Nov 30 12:19:23 xanatos kernel: [    6.942620] usb 3-1: new high-speed USB device number 2 using ehci-pci
Nov 30 12:19:23 xanatos kernel: [    6.998471] ehci-pci 0000:00:1a.0: port 1 reset complete, port enabled
Nov 30 12:19:23 xanatos kernel: [    6.998479] ehci-pci 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
Nov 30 12:19:23 xanatos kernel: [    7.038285] cfg80211: World regulatory domain updated:
Nov 30 12:19:23 xanatos kernel: [    7.038289] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
Nov 30 12:19:23 xanatos kernel: [    7.038291] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
Nov 30 12:19:23 xanatos kernel: [    7.038294] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
Nov 30 12:19:23 xanatos kernel: [    7.038296] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
Nov 30 12:19:23 xanatos kernel: [    7.038298] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
Nov 30 12:19:23 xanatos kernel: [    7.038300] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
Nov 30 12:19:23 xanatos kernel: [    7.051135] iwldvm: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
Nov 30 12:19:23 xanatos kernel: [    7.051139] iwldvm: Copyright(c) 2003-2012 Intel Corporation
Nov 30 12:19:23 xanatos kernel: [    7.051171] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG disabled
Nov 30 12:19:23 xanatos kernel: [    7.051174] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
Nov 30 12:19:23 xanatos kernel: [    7.051176] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
Nov 30 12:19:23 xanatos kernel: [    7.051178] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
Nov 30 12:19:23 xanatos kernel: [    7.051179] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_P2P enabled
Nov 30 12:19:23 xanatos kernel: [    7.051182] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R) Advanced-N 6205 AGN, REV=0xB0
Nov 30 12:19:23 xanatos kernel: [    7.051516] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
Nov 30 12:19:24 xanatos kernel: [    7.059788] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
Nov 30 12:19:24 xanatos kernel: [    7.061928] iwlwifi 0000:03:00.0: RF_KILL bit toggled to disable radio.
Nov 30 12:19:24 xanatos kernel: [    7.075393] usb 3-1: udev 2, busnum 3, minor = 257
Nov 30 12:19:24 xanatos kernel: [    7.075398] usb 3-1: New USB device found, idVendor=8087, idProduct=0024
Nov 30 12:19:24 xanatos kernel: [    7.075401] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Nov 30 12:19:24 xanatos kernel: [    7.075504] usb 3-1: usb_probe_device
Nov 30 12:19:24 xanatos kernel: [    7.075508] usb 3-1: configuration #1 chosen from 1 choice
Nov 30 12:19:24 xanatos kernel: [    7.075606] usb 3-1: adding 3-1:1.0 (config #1, interface 0)
Nov 30 12:19:24 xanatos kernel: [    7.075658] hub 3-1:1.0: usb_probe_interface
Nov 30 12:19:24 xanatos kernel: [    7.075661] hub 3-1:1.0: usb_probe_interface - got id
Nov 30 12:19:24 xanatos kernel: [    7.075665] hub 3-1:1.0: USB hub found
Nov 30 12:19:24 xanatos kernel: [    7.075835] hub 3-1:1.0: 6 ports detected
Nov 30 12:19:24 xanatos kernel: [    7.075838] hub 3-1:1.0: standalone hub
Nov 30 12:19:24 xanatos kernel: [    7.075840] hub 3-1:1.0: individual port power switching
Nov 30 12:19:24 xanatos kernel: [    7.075843] hub 3-1:1.0: individual port over-current protection
Nov 30 12:19:24 xanatos kernel: [    7.075847] hub 3-1:1.0: Single TT
Nov 30 12:19:24 xanatos kernel: [    7.075850] hub 3-1:1.0: TT requires at most 8 FS bit times (666 ns)
Nov 30 12:19:24 xanatos kernel: [    7.075852] hub 3-1:1.0: power on to power good time: 100ms
Nov 30 12:19:24 xanatos kernel: [    7.076086] hub 3-1:1.0: local power source is good
Nov 30 12:19:24 xanatos kernel: [    7.077438] hub 3-1:1.0: enabling power on all ports
Nov 30 12:19:24 xanatos kernel: [    7.078655] hub 4-0:1.0: state 7 ports 3 chg 0002 evt 0000
Nov 30 12:19:24 xanatos kernel: [    7.078667] hub 4-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
Nov 30 12:19:24 xanatos kernel: [    7.117127] iwlwifi 0000:03:00.0: device EEPROM VER=0x715, CALIB=0x6
Nov 30 12:19:24 xanatos kernel: [    7.117132] iwlwifi 0000:03:00.0: Device SKU: 0x1F0
Nov 30 12:19:24 xanatos kernel: [    7.117135] iwlwifi 0000:03:00.0: Valid Tx ant: 0x3, Valid Rx ant: 0x3
Nov 30 12:19:24 xanatos kernel: [    7.131588] SKU: Nid=0x1d sku_cfg=0x40138205
Nov 30 12:19:24 xanatos kernel: [    7.131591] SKU: port_connectivity=0x1
Nov 30 12:19:24 xanatos kernel: [    7.131593] SKU: enable_pcbeep=0x1
Nov 30 12:19:24 xanatos kernel: [    7.131594] SKU: check_sum=0x00000003
Nov 30 12:19:24 xanatos kernel: [    7.131595] SKU: customization=0x00000082
Nov 30 12:19:24 xanatos kernel: [    7.131597] SKU: external_amp=0x0
Nov 30 12:19:24 xanatos kernel: [    7.131598] SKU: platform_type=0x1
Nov 30 12:19:24 xanatos kernel: [    7.131599] SKU: swap=0x0
Nov 30 12:19:24 xanatos kernel: [    7.131600] SKU: override=0x1
Nov 30 12:19:24 xanatos kernel: [    7.131609] autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Nov 30 12:19:24 xanatos kernel: [    7.131611]    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Nov 30 12:19:24 xanatos kernel: [    7.131613]    hp_outs=2 (0x15/0x1b/0x0/0x0/0x0)
Nov 30 12:19:24 xanatos kernel: [    7.131614]    mono: mono_out=0x0
Nov 30 12:19:24 xanatos kernel: [    7.131615]    inputs:
Nov 30 12:19:24 xanatos kernel: [    7.131617]      Internal Mic=0x12
Nov 30 12:19:24 xanatos kernel: [    7.131619]      Mic=0x18
Nov 30 12:19:24 xanatos kernel: [    7.131621]      Dock Mic=0x19
Nov 30 12:19:24 xanatos kernel: [    7.133190] realtek: No valid SSID, checking pincfg 0x40138205 for NID 0x1d
Nov 30 12:19:24 xanatos kernel: [    7.133192] realtek: Enabling init ASM_ID=0x8205 CODEC_ID=10ec0269
Nov 30 12:19:24 xanatos kernel: [    7.134215] ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
Nov 30 12:19:24 xanatos kernel: [    7.134222] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
Nov 30 12:19:24 xanatos kernel: [    7.135385] Registered led device: phy0-led
Nov 30 12:19:24 xanatos kernel: [    7.148875] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
Nov 30 12:19:24 xanatos kernel: [    7.155254] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
Nov 30 12:19:24 xanatos kernel: [    7.178282] hub 3-1:1.0: port 2: status 0101 change 0001
Nov 30 12:19:24 xanatos kernel: [    7.179023] hub 3-1:1.0: port 6: status 0101 change 0001
Nov 30 12:19:24 xanatos kernel: [    7.190091] usb 4-1: new high-speed USB device number 2 using ehci-pci
Nov 30 12:19:24 xanatos kernel: [    7.248750] ehci-pci 0000:00:1d.0: port 1 reset complete, port enabled
Nov 30 12:19:24 xanatos kernel: [    7.248758] ehci-pci 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
Nov 30 12:19:24 xanatos kernel: [    7.277810] usb 3-1: link qh256-0001/ffff88010e4d8280 start 1 [1/0 us]
Nov 30 12:19:24 xanatos kernel: [    7.322185] usb 4-1: udev 2, busnum 4, minor = 385
Nov 30 12:19:24 xanatos kernel: [    7.322190] usb 4-1: New USB device found, idVendor=8087, idProduct=0024
Nov 30 12:19:24 xanatos kernel: [    7.322193] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Nov 30 12:19:24 xanatos kernel: [    7.322290] usb 4-1: usb_probe_device
Nov 30 12:19:24 xanatos kernel: [    7.322293] usb 4-1: configuration #1 chosen from 1 choice
Nov 30 12:19:24 xanatos kernel: [    7.322421] usb 4-1: adding 4-1:1.0 (config #1, interface 0)
Nov 30 12:19:24 xanatos kernel: [    7.322504] hub 4-1:1.0: usb_probe_interface
Nov 30 12:19:24 xanatos kernel: [    7.322507] hub 4-1:1.0: usb_probe_interface - got id
Nov 30 12:19:24 xanatos kernel: [    7.322512] hub 4-1:1.0: USB hub found
Nov 30 12:19:24 xanatos kernel: [    7.323213] hub 4-1:1.0: 8 ports detected
Nov 30 12:19:24 xanatos kernel: [    7.323217] hub 4-1:1.0: standalone hub
Nov 30 12:19:24 xanatos kernel: [    7.323220] hub 4-1:1.0: individual port power switching
Nov 30 12:19:24 xanatos kernel: [    7.323222] hub 4-1:1.0: individual port over-current protection
Nov 30 12:19:24 xanatos kernel: [    7.323226] hub 4-1:1.0: Single TT
Nov 30 12:19:24 xanatos kernel: [    7.323229] hub 4-1:1.0: TT requires at most 8 FS bit times (666 ns)
Nov 30 12:19:24 xanatos kernel: [    7.323231] hub 4-1:1.0: power on to power good time: 100ms
Nov 30 12:19:24 xanatos kernel: [    7.323491] hub 4-1:1.0: local power source is good
Nov 30 12:19:24 xanatos kernel: [    7.332461] hub 4-1:1.0: enabling power on all ports
Nov 30 12:19:24 xanatos kernel: [    7.338006] hub 3-1:1.0: state 7 ports 6 chg 0044 evt 0000
Nov 30 12:19:24 xanatos kernel: [    7.338113] hub 3-1:1.0: port 2, status 0101, change 0000, 12 Mb/s
Nov 30 12:19:24 xanatos kernel: [    7.358669] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input6
Nov 30 12:19:24 xanatos kernel: [    7.409715] usb 3-1.2: new full-speed USB device number 3 using ehci-pci
Nov 30 12:19:24 xanatos kernel: [    7.438419] usb 4-1: link qh256-0001/ffff880119f06c00 start 1 [1/0 us]
Nov 30 12:19:24 xanatos kernel: [    7.501319] usb 3-1.2: ep0 maxpacket = 8
Nov 30 12:19:24 xanatos kernel: [    7.503297] usb 3-1.2: default language 0x0409
Nov 30 12:19:24 xanatos kernel: [    7.504784] usb 3-1.2: udev 3, busnum 3, minor = 258
Nov 30 12:19:24 xanatos kernel: [    7.504789] usb 3-1.2: New USB device found, idVendor=058f, idProduct=9254
Nov 30 12:19:24 xanatos kernel: [    7.504792] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 30 12:19:24 xanatos kernel: [    7.504795] usb 3-1.2: Product: Generic USB Hub
Nov 30 12:19:24 xanatos kernel: [    7.504797] usb 3-1.2: Manufacturer: ALCOR
Nov 30 12:19:24 xanatos kernel: [    7.504911] usb 3-1.2: usb_probe_device
Nov 30 12:19:24 xanatos kernel: [    7.504915] usb 3-1.2: configuration #1 chosen from 1 choice
Nov 30 12:19:24 xanatos kernel: [    7.505681] usb 3-1.2: adding 3-1.2:1.0 (config #1, interface 0)
Nov 30 12:19:24 xanatos kernel: [    7.505741] hub 3-1.2:1.0: usb_probe_interface
Nov 30 12:19:24 xanatos kernel: [    7.505744] hub 3-1.2:1.0: usb_probe_interface - got id
Nov 30 12:19:24 xanatos kernel: [    7.505749] hub 3-1.2:1.0: USB hub found
Nov 30 12:19:24 xanatos kernel: [    7.506026] hub 3-1.2:1.0: 4 ports detected
Nov 30 12:19:24 xanatos kernel: [    7.506030] hub 3-1.2:1.0: standalone hub
Nov 30 12:19:24 xanatos kernel: [    7.506032] hub 3-1.2:1.0: individual port power switching
Nov 30 12:19:24 xanatos kernel: [    7.506034] hub 3-1.2:1.0: individual port over-current protection
Nov 30 12:19:24 xanatos kernel: [    7.506039] hub 3-1.2:1.0: power on to power good time: 44ms
Nov 30 12:19:24 xanatos kernel: [    7.506635] hub 3-1.2:1.0: local power source is good
Nov 30 12:19:24 xanatos kernel: [    7.506711] hub 3-1.2:1.0: enabling power on all ports
Nov 30 12:19:24 xanatos kernel: [    7.509503] hub 3-1:1.0: port 6, status 0101, change 0000, 12 Mb/s
Nov 30 12:19:24 xanatos kernel: [    7.532530] bio: create slab <bio-1> at 1
Nov 30 12:19:24 xanatos kernel: [    7.581266] usb 3-1.6: new high-speed USB device number 4 using ehci-pci
Nov 30 12:19:24 xanatos kernel: [    7.605719] hub 3-1.2:1.0: port 2: status 0301 change 0001
Nov 30 12:19:24 xanatos kernel: [    7.605964] hub 3-1.2:1.0: port 3: status 0301 change 0001
Nov 30 12:19:24 xanatos kernel: [    7.680307] usb 3-1.6: skipped 1 descriptor after configuration
Nov 30 12:19:24 xanatos kernel: [    7.680311] usb 3-1.6: skipped 6 descriptors after interface
Nov 30 12:19:24 xanatos kernel: [    7.680315] usb 3-1.6: skipped 1 descriptor after endpoint
Nov 30 12:19:24 xanatos kernel: [    7.680318] usb 3-1.6: skipped 20 descriptors after interface
Nov 30 12:19:24 xanatos kernel: [    7.680637] usb 3-1.6: default language 0x0409
Nov 30 12:19:24 xanatos kernel: [    7.681449] usb 3-1.6: udev 4, busnum 3, minor = 259
Nov 30 12:19:24 xanatos kernel: [    7.681453] usb 3-1.6: New USB device found, idVendor=04f2, idProduct=b2ea
Nov 30 12:19:24 xanatos kernel: [    7.681455] usb 3-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 30 12:19:24 xanatos kernel: [    7.681456] usb 3-1.6: Product: Integrated Camera
Nov 30 12:19:24 xanatos kernel: [    7.681458] usb 3-1.6: Manufacturer: Chicony Electronics Co., Ltd.
Nov 30 12:19:24 xanatos kernel: [    7.681553] usb 3-1.6: usb_probe_device
Nov 30 12:19:24 xanatos kernel: [    7.681556] usb 3-1.6: configuration #1 chosen from 1 choice
Nov 30 12:19:24 xanatos kernel: [    7.681693] usb 3-1.6: adding 3-1.6:1.0 (config #1, interface 0)
Nov 30 12:19:24 xanatos kernel: [    7.682616] usb 3-1.6: adding 3-1.6:1.1 (config #1, interface 1)
Nov 30 12:19:24 xanatos kernel: [    7.683167] hub 3-1:1.0: state 7 ports 6 chg 0000 evt 0040
Nov 30 12:19:24 xanatos kernel: [    7.683489] hub 4-1:1.0: state 7 ports 8 chg 0000 evt 0000
Nov 30 12:19:24 xanatos kernel: [    7.704969] usb 3-1.2: link qh128-0e01/ffff8801119ed900 start 2 [1/2 us]
Nov 30 12:19:24 xanatos kernel: [    7.704982] hub 3-1.2:1.0: state 7 ports 4 chg 000c evt 0000
Nov 30 12:19:24 xanatos kernel: [    7.705153] hub 3-1.2:1.0: port 2, status 0301, change 0000, 1.5 Mb/s
Nov 30 12:19:24 xanatos kernel: [    7.712130] e1000e 0000:00:19.0: irq 41 for MSI/MSI-X
Nov 30 12:19:24 xanatos kernel: [    7.776896] usb 3-1.2.2: new low-speed USB device number 5 using ehci-pci
Nov 30 12:19:24 xanatos kernel: [    7.815388] e1000e 0000:00:19.0: irq 41 for MSI/MSI-X
Nov 30 12:19:24 xanatos kernel: [    7.815621] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
Nov 30 12:19:24 xanatos kernel: [    7.849106] Adding 4085756k swap on /dev/mapper/cryptswap1.  Priority:-1 extents:1 across:4085756k SS
Nov 30 12:19:24 xanatos kernel: [    7.877577] usb 3-1.2.2: skipped 1 descriptor after interface
Nov 30 12:19:24 xanatos kernel: [    7.877582] usb 3-1.2.2: skipped 1 descriptor after interface
Nov 30 12:19:24 xanatos kernel: [    7.878429] usb 3-1.2.2: default language 0x0409
Nov 30 12:19:24 xanatos kernel: [    7.881946] usb 3-1.2.2: udev 5, busnum 3, minor = 260
Nov 30 12:19:24 xanatos kernel: [    7.881951] usb 3-1.2.2: New USB device found, idVendor=046d, idProduct=c30a
Nov 30 12:19:24 xanatos kernel: [    7.881954] usb 3-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 30 12:19:24 xanatos kernel: [    7.881956] usb 3-1.2.2: Product: Logitech USB Keyboard
Nov 30 12:19:24 xanatos kernel: [    7.881958] usb 3-1.2.2: Manufacturer: Logitech
Nov 30 12:19:24 xanatos kernel: [    7.882068] usb 3-1.2.2: usb_probe_device
Nov 30 12:19:24 xanatos kernel: [    7.882072] usb 3-1.2.2: configuration #1 chosen from 1 choice
Nov 30 12:19:24 xanatos kernel: [    7.882728] usb 3-1.2.2: adding 3-1.2.2:1.0 (config #1, interface 0)
Nov 30 12:19:24 xanatos kernel: [    7.882801] usb 3-1.2.2: adding 3-1.2.2:1.1 (config #1, interface 1)
Nov 30 12:19:24 xanatos kernel: [    7.887210] hub 3-1.2:1.0: port 3, status 0301, change 0000, 1.5 Mb/s
Nov 30 12:19:24 xanatos kernel: [    7.956741] usb 3-1.2.3: new low-speed USB device number 6 using ehci-pci
Nov 30 12:19:25 xanatos kernel: [    8.052313] usb 3-1.2.3: skipped 1 descriptor after interface
Nov 30 12:19:25 xanatos kernel: [    8.052317] usb 3-1.2.3: skipped 1 descriptor after interface
Nov 30 12:19:25 xanatos kernel: [    8.053075] usb 3-1.2.3: default language 0x0409
Nov 30 12:19:25 xanatos kernel: [    8.055336] usb 3-1.2.3: udev 6, busnum 3, minor = 261
Nov 30 12:19:25 xanatos kernel: [    8.055339] usb 3-1.2.3: New USB device found, idVendor=046d, idProduct=c521
Nov 30 12:19:25 xanatos kernel: [    8.055341] usb 3-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 30 12:19:25 xanatos kernel: [    8.055343] usb 3-1.2.3: Product: USB Receiver
Nov 30 12:19:25 xanatos kernel: [    8.055344] usb 3-1.2.3: Manufacturer: Logitech
Nov 30 12:19:25 xanatos kernel: [    8.055429] usb 3-1.2.3: usb_probe_device
Nov 30 12:19:25 xanatos kernel: [    8.055433] usb 3-1.2.3: configuration #1 chosen from 1 choice
Nov 30 12:19:25 xanatos kernel: [    8.057178] usb 3-1.2.3: adding 3-1.2.3:1.0 (config #1, interface 0)
Nov 30 12:19:25 xanatos kernel: [    8.057248] usb 3-1.2.3: adding 3-1.2.3:1.1 (config #1, interface 1)
Nov 30 12:19:25 xanatos kernel: [    8.057360] hub 3-1.2:1.0: state 7 ports 4 chg 0000 evt 0008
Nov 30 12:19:25 xanatos kernel: [    8.077388] usbhid 3-1.2.2:1.0: usb_probe_interface
Nov 30 12:19:25 xanatos kernel: [    8.077393] usbhid 3-1.2.2:1.0: usb_probe_interface - got id
Nov 30 12:19:25 xanatos kernel: [    8.081650] usbhid 3-1.2.2:1.1: usb_probe_interface
Nov 30 12:19:25 xanatos kernel: [    8.081654] usbhid 3-1.2.2:1.1: usb_probe_interface - got id
Nov 30 12:19:25 xanatos kernel: [    8.089157] usbhid 3-1.2.3:1.0: usb_probe_interface
Nov 30 12:19:25 xanatos kernel: [    8.089161] usbhid 3-1.2.3:1.0: usb_probe_interface - got id
Nov 30 12:19:25 xanatos kernel: [    8.092863] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2.3/3-1.2.3:1.0/input/input7
Nov 30 12:19:25 xanatos kernel: [    8.093028] hid-generic 0003:046D:C521.0003: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1a.0-1.2.3/input0
Nov 30 12:19:25 xanatos kernel: [    8.093052] usbhid 3-1.2.3:1.1: usb_probe_interface
Nov 30 12:19:25 xanatos kernel: [    8.093054] usbhid 3-1.2.3:1.1: usb_probe_interface - got id
Nov 30 12:19:25 xanatos kernel: [    8.099622] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2.3/3-1.2.3:1.1/input/input8
Nov 30 12:19:25 xanatos kernel: [    8.099668] usb 3-1.2.3: link qh8-0e01/ffff8801119ec900 start 3 [1/2 us]
Nov 30 12:19:25 xanatos kernel: [    8.099709] usbhid 3-1.2.3:1.1: looking for a minor, starting at 96
Nov 30 12:19:25 xanatos kernel: [    8.099896] hid-generic 0003:046D:C521.0004: input,hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1a.0-1.2.3/input1
Nov 30 12:19:25 xanatos kernel: [    8.100007] usbcore: registered new interface driver usbhid
Nov 30 12:19:25 xanatos kernel: [    8.100009] usbhid: USB HID core driver
Nov 30 12:19:25 xanatos kernel: [    8.109085] input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2.2/3-1.2.2:1.0/input/input9
Nov 30 12:19:25 xanatos kernel: [    8.109113] usb 3-1.2.2: link qh8-0e01/ffff88010d16e380 start 4 [1/2 us]
Nov 30 12:19:25 xanatos kernel: [    8.109382] logitech 0003:046D:C30A.0001: input,hidraw2: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1a.0-1.2.2/input0
Nov 30 12:19:25 xanatos kernel: [    8.111525] input: Logitech Logitech USB Keyboard as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2.2/3-1.2.2:1.1/input/input10
Nov 30 12:19:25 xanatos kernel: [    8.111542] usb 3-1.2.2: link qh32-0e01/ffff88010c559000 start 5 [1/2 us]
Nov 30 12:19:25 xanatos kernel: [    8.111718] logitech 0003:046D:C30A.0002: input,hidraw3: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1a.0-1.2.2/input1
Nov 30 12:19:25 xanatos kernel: [    8.266189] usb 3-1.2.3: link qh8-0e01/ffff88010c559200 start 6 [1/2 us]
Nov 30 12:19:28 xanatos kernel: [   11.340973] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
Nov 30 12:19:28 xanatos kernel: [   11.342194] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Nov 30 12:20:19 xanatos kernel: [   62.693992] xhci_hcd 0000:00:14.0: Poll event ring: 4294907968

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x230-lspci-n.txt"

00:00.0 0600: 8086:0154 (rev 09)
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 0300: 8086:0166 (rev 09) (prog-if 00 [VGA controller])
	Subsystem: 17aa:21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 5000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 41d1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 0c03: 8086:1e31 (rev 04) (prog-if 30 [XHCI])
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at f2520000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 41c1
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci-hcd

00:16.0 0780: 8086:1e3a (rev 04)
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2535000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000

00:16.3 0700: 8086:1e3d (rev 04) (prog-if 02 [16550])
	Subsystem: 17aa:21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 50b0 [size=8]
	Region 1: Memory at f253c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000

00:19.0 0200: 8086:1502 (rev 04)
	Subsystem: 17aa:21f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f2500000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f253b000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 5080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0200c  Data: 4162
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e

00:1a.0 0c03: 8086:1e2d (rev 04) (prog-if 20 [EHCI])
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f253a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci-pci

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f2530000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4142
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd-hda-intel

00:1c.0 0604: 8086:1e10 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f1d00000-f24fffff
	Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: 17aa:21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 0604: 8086:1e12 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f1c00000-f1cfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: 17aa:21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.2 0604: 8086:1e14 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1400000-f1bfffff
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f13fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: 17aa:21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 0c03: 8086:1e26 (rev 04) (prog-if 20 [EHCI])
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f2539000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci-pci

00:1f.0 0601: 8086:1e55 (rev 04)
	Subsystem: 17aa:21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:1f.2 0106: 8086:1e03 (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: 17aa:21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 40
	Region 0: I/O ports at 50a8 [size=8]
	Region 1: I/O ports at 50bc [size=4]
	Region 2: I/O ports at 50a0 [size=8]
	Region 3: I/O ports at 50b8 [size=4]
	Region 4: I/O ports at 5060 [size=32]
	Region 5: Memory at f2538000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 4191
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 0c05: 8086:1e22 (rev 04)
	Subsystem: 17aa:21fa
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at f2534000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel modules: i2c-i801

02:00.0 0880: 1180:e823 (rev 04) (prog-if 01)
	Subsystem: 17aa:21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f1d00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

03:00.0 0280: 8086:0085 (rev 34)
	Subsystem: 8086:1311
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f1c00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 41e1
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 60-67-20-ff-ff-8a-a6-20
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x230-lspci.txt"

00:00.0 Host bridge: Intel Corporation Ivy Bridge DRAM Controller (rev 09)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Ivy Bridge Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 5000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 41d1
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 USB controller: Intel Corporation Panther Point USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at f2520000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 41c1
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci-hcd

00:16.0 Communication controller: Intel Corporation Panther Point MEI Controller #1 (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2535000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000

00:16.3 Serial controller: Intel Corporation Panther Point KT Controller (rev 04) (prog-if 02 [16550])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 50b0 [size=8]
	Region 1: Memory at f253c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
	Subsystem: Lenovo Device 21f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f2500000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f253b000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 5080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0200c  Data: 4162
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation Panther Point USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f253a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci-pci

00:1b.0 Audio device: Intel Corporation Panther Point High Definition Audio Controller (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f2530000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4142
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation Panther Point PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f1d00000-f24fffff
	Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation Panther Point PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f1c00000-f1cfffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation Panther Point PCI Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1400000-f1bfffff
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f13fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation Panther Point USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f2539000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Panther Point LPC Controller (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:1f.2 SATA controller: Intel Corporation Panther Point 6 port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 40
	Region 0: I/O ports at 50a8 [size=8]
	Region 1: I/O ports at 50bc [size=4]
	Region 2: I/O ports at 50a0 [size=8]
	Region 3: I/O ports at 50b8 [size=4]
	Region 4: I/O ports at 5060 [size=32]
	Region 5: Memory at f2538000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0100c  Data: 4191
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Panther Point SMBus Controller (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at f2534000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel modules: i2c-i801

02:00.0 System peripheral: Ricoh Co Ltd Device e823 (rev 04) (prog-if 01)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f1d00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205 (rev 34)
	Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f1c00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 41e1
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 60-67-20-ff-ff-8a-a6-20
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 3.7.0-rc6 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_DEFAULT_IDLE=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CPU_AUTOPROBE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_X86_HT=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11"
CONFIG_ARCH_CPU_PROBE_RELEASE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_FHANDLE is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y
# CONFIG_AUDIT_LOGINUID_IMMUTABLE is not set
CONFIG_HAVE_GENERIC_HARDIRQS=y

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_USER_QS is not set
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_BOOST is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_RESOURCE_COUNTERS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_PID_NS=y
# CONFIG_NET_NS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_EXPERT=y
CONFIG_HAVE_UID16=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PCI_QUIRKS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_GENERIC_KERNEL_THREAD=y
CONFIG_GENERIC_KERNEL_EXECVE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_RCU_USER_QS=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_MODULES_USE_ELF_RELA=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_PARAVIRT_GUEST=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_XEN=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PRIVILEGED_GUEST=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_MAX_DOMAIN_MEMORY=500
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_KVM_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MEMTEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_XADD=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DIRECT_GBPAGES=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_RELOCATABLE=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION="/dev/sda2"
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM_RUNTIME=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS is not set
CONFIG_ACPI_PROCFS_POWER=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_DEBUG_FUNC_TRACE=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_SBS=m
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_APEI is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# x86 CPU frequency scaling drivers
#
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Memory power savings
#
CONFIG_I7300_IDLE_IOAT_CHANNEL=y
CONFIG_I7300_IDLE=m

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
CONFIG_PCI_DEBUG=y
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_HT_IRQ=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_IOAPIC=y
CONFIG_PCI_LABEL=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_RAPIDIO is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_KEYS_COMPAT=y
CONFIG_HAVE_TEXT_POKE_SMP=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_LRO=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
# CONFIG_NF_CT_PROTO_DCCP is not set
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=m
CONFIG_NF_CT_PROTO_UDPLITE=m
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
# CONFIG_NF_CONNTRACK_SNMP is not set
CONFIG_NF_CONNTRACK_PPTP=m
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE_CT is not set
CONFIG_NETFILTER_TPROXY=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=m
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_IPVS is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=y
# CONFIG_IP_VS_PE_SIP is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_ULOG=m
# CONFIG_NF_NAT_IPV4 is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
# CONFIG_NF_NAT_IPV6 is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_NETPRIO_CGROUP is not set
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
CONFIG_BT=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
# CONFIG_AF_RXRPC is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
# CONFIG_MAC80211_RC_PID is not set
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_SYS_HYPERVISOR=y
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_DMA_SHARED_BUFFER=y

#
# Bus devices
#
# CONFIG_OMAP_OCP2SCP is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_BMP085_I2C is not set
# CONFIG_BMP085_SPI is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_TGT=m
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_FC_TGT_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_SRP_TGT_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_SCSI_BNX2X_FCOE is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=m
# CONFIG_SCSI_HPSA is not set
CONFIG_SCSI_3W_9XXX=m
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=m
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_LIBFCOE is not set
# CONFIG_FCOE is not set
# CONFIG_FCOE_FNIC is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_SRP=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_HIGHBANK is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARASAN_CF is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MULTICORE_RAID456 is not set
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=y
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_MIRROR=y
# CONFIG_DM_RAID is not set
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
# CONFIG_DM_MULTIPATH_ST is not set
# CONFIG_DM_DELAY is not set
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_MII=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_VETH=m
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=y
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_ZNET is not set
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_SEEQ8005 is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
# CONFIG_SFC is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
# CONFIG_SLIP is not set
CONFIG_SLHC=y

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_DM9601=m
# CONFIG_USB_NET_SMSC75XX is not set
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
# CONFIG_USB_NET_CX82310_ETH is not set
CONFIG_USB_NET_KALMIA=m
# CONFIG_USB_NET_QMI_WWAN is not set
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
# CONFIG_USB_VL600 is not set
CONFIG_WLAN=y
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_AIRO is not set
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
# CONFIG_PRISM54 is not set
CONFIG_USB_ZD1201=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_RTL8180 is not set
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
# CONFIG_ADM8211 is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_MWL8K is not set
# CONFIG_ATH_COMMON is not set
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMFMAC is not set
# CONFIG_HOSTAP is not set
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLWIFI=m
CONFIG_IWLDVM=m

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
# CONFIG_IWLWIFI_DEBUGFS is not set
CONFIG_IWLWIFI_P2P=y
# CONFIG_IWLWIFI_EXPERIMENTAL_MFP is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_LIBERTAS is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_RT2X00 is not set
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_WL_TI is not set
# CONFIG_ZD1211RW is not set
# CONFIG_MWIFIEX is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=m
CONFIG_WIMAX_I2400M_USB=m
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
# CONFIG_WAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
CONFIG_XEN_NETDEV_BACKEND=m
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_WACOM=m
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=0
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set
CONFIG_FIX_EARLYCON_MEM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_MFD_HSU is not set
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_INTEL_MID is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_TLE62X0=m
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable Device Drivers -> PPS to see the PTP clock options.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_BATTERY_BQ27x00 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_APPLESMC=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=m
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CS5535 is not set
CONFIG_LPC_SCH=m
# CONFIG_LPC_ICH is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_REGULATOR is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_RC_SUPPORT is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#

#
# Customise DVB Frontends
#
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=m
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_NOUVEAU is not set

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_KMS=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_STUB_POULSBO is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=m
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_EXYNOS_VIDEO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_KCTL_JACK=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=m
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_INPUT_JACK is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO_TPKBD is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_ROCCAT=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB_ARCH_HAS_XHCI=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=m
CONFIG_USB_XHCI_HCD_DEBUGGING=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_ISP1760_HCD=m
CONFIG_USB_ISP1362_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_WHCI_HCD=m
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_FUNSOFT=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
# CONFIG_USB_SERIAL_IUU is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MOTOROLA=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
# CONFIG_USB_SERIAL_SYMBOL is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_VIVOPAY_SERIAL=m
CONFIG_USB_SERIAL_ZIO=m
CONFIG_USB_SERIAL_ZTE=m
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_SISUSBVGA_CON is not set
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m

#
# USB Physical Layer drivers
#
# CONFIG_OMAP_USB2 is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_RCAR_PHY is not set
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
CONFIG_USB_G_NCM=m
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set

#
# OTG and related infrastructure
#
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
# CONFIG_UWB_I1480U is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA9633 is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_TRIGGERS=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC=y

#
# Reporting subsystems
#
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_X38=m
# CONFIG_EDAC_I5400 is not set
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6902=m
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_DS3234=m
# CONFIG_RTC_DRV_PCF2123 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_DS2404 is not set

#
# on-CPU RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_INTEL_MID_DMAC is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_TIMB_DMA is not set
# CONFIG_PCH_DMA is not set
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
CONFIG_XEN_SCRUB_PAGES=y
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
CONFIG_XEN_GRANT_DEV_ALLOC=m
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=y
CONFIG_XEN_PCIDEV_BACKEND=m
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_ACPI_PROCESSOR=m
CONFIG_STAGING=y
# CONFIG_ET131X is not set
# CONFIG_SLICOSS is not set
# CONFIG_USBIP_CORE is not set
CONFIG_W35UND=m
CONFIG_PRISM2_USB=m
# CONFIG_ECHO is not set
# CONFIG_COMEDI is not set
CONFIG_ASUS_OLED=m
# CONFIG_R8187SE is not set
CONFIG_RTL8192U=m
# CONFIG_RTLLIB is not set
CONFIG_R8712U=m
# CONFIG_RTS_PSTOR is not set
# CONFIG_RTS5139 is not set
CONFIG_TRANZPORT=m
# CONFIG_IDE_PHISON is not set
CONFIG_LINE6_USB=m
# CONFIG_LINE6_USB_DEBUG is not set
# CONFIG_LINE6_USB_DUMP_CTRL is not set
# CONFIG_LINE6_USB_DUMP_MIDI is not set
# CONFIG_LINE6_USB_DUMP_PCM is not set
# CONFIG_LINE6_USB_RAW is not set
# CONFIG_LINE6_USB_IMPULSE_RESPONSE is not set
CONFIG_USB_SERIAL_QUATECH2=m
# CONFIG_VT6655 is not set
CONFIG_VT6656=m
# CONFIG_DX_SEP is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_CRYSTALHD is not set
# CONFIG_FB_XGI is not set
# CONFIG_ACPI_QUICKSTART is not set
CONFIG_USB_ENESTORAGE=m
# CONFIG_BCM_WIMAX is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_PHONE is not set
# CONFIG_USB_WPAN_HCD is not set
# CONFIG_USB_G_CCG is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_WIMAX_GDM72XX is not set
# CONFIG_NET_VENDOR_SILICOM is not set
# CONFIG_CED1401 is not set
# CONFIG_DGRP is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_IBM_RTL is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set

#
# Hardware Spinlock drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_IOMMU_SUPPORT=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers (EXPERIMENTAL)
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers (EXPERIMENTAL)
#
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_XATTR=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_GENERIC_ACL=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=m
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V2=m
CONFIG_NFS_V3=m
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_SWAP is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHEDSTATS=y
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_PROVE_RCU_DELAY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_CPU_STALL_VERBOSE=y
# CONFIG_RCU_CPU_STALL_INFO is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_LKDTM is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DMA_API_DEBUG=y
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_KMEMCHECK is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_STRICT_DEVMEM=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
# CONFIG_DEBUG_NX_TEST is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_ASYNC_TX_DISABLE_PQ_VAL_DMA=y
CONFIG_ASYNC_TX_DISABLE_XOR_VAL_DMA=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ABLK_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_ZLIB is not set
CONFIG_CRYPTO_LZO=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_AVERAGE=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set

--Kj7319i9nmIyA2yE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
