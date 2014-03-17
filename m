From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: No suspend to RAM support
Date: Mon, 17 Mar 2014 20:53:12 +0000
Message-ID: <20140317205302.GA14066@sucs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:52430 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbaCQVdM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Mar 2014 17:33:12 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

Hi,

I have an (old) Athlon II Neo N36L but I've noticed that with the 3.2
Debian stable kernel only disk is present in /sys/power/state so
suspend to RAM can't be used (but hibernating and resuming work fine).

The machine seemingly supports S5 ACPI so I'm guessing there's a reason
suspend has been disabled but does anyone know what it is?

The same issue happens with the 3.11 kernel on a Fedora LiveCD. dmesg
below:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-4-amd64 (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP Debian 3.2.54-2
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.2.0-4-amd64 root=/dev/mapper/trypticon-root ro quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e2000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bff90000 (usable)
[    0.000000]  BIOS-e820: 00000000bff9e000 - 00000000bffa0000 (reserved)
[    0.000000]  BIOS-e820: 00000000bffa0000 - 00000000bffaa600 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bffaa600 - 00000000bffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bffe0000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffa00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: HP ProLiant MicroServer, BIOS O41     10/01/2013
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x130000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000130000000 aka 4864M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbff90 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 20480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000bff90000
[    0.000000]  0000000000 - 0080000000 page 1G
[    0.000000]  0080000000 - 00bfe00000 page 2M
[    0.000000]  00bfe00000 - 00bff90000 page 4k
[    0.000000] kernel direct mapping tables up to bff90000 @ 1fffd000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-0000000130000000
[    0.000000]  0100000000 - 0130000000 page 2M
[    0.000000] kernel direct mapping tables up to 130000000 @ bff8e000-bff90000
[    0.000000] RAMDISK: 36a28000 - 3750c000
[    0.000000] ACPI: RSDP 00000000000f8f50 00024 (v02 HP    )
[    0.000000] ACPI: XSDT 00000000bffa0100 0007C (v01 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: FACP 00000000bffa0290 000F4 (v03 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: DSDT 00000000bffa0620 06868 (v01 HP     ProLiant 00000006 INTL 20051117)
[    0.000000] ACPI: FACS 00000000bffae000 00040
[    0.000000] ACPI: APIC 00000000bffa0390 00072 (v01 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: MCFG 00000000bffa0410 0003C (v01 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: SPMI 00000000bffa0450 00041 (v05 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: OEMB 00000000bffae040 00072 (v01 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: HPET 00000000bffab4e0 00038 (v01 HP     ProLiant 20131001 HP   00000097)
[    0.000000] ACPI: EINJ 00000000bffab520 00130 (v01  AMIER AMI_EINJ 20131001 HP   00000097)
[    0.000000] ACPI: BERT 00000000bffab6b0 00030 (v01  AMIER AMI_BERT 20131001 HP   00000097)
[    0.000000] ACPI: ERST 00000000bffab6e0 001B0 (v01  AMIER AMI_ERST 20131001 HP   00000097)
[    0.000000] ACPI: HEST 00000000bffab890 000A8 (v01  AMIER ABC_HEST 20131001 HP   00000097)
[    0.000000] ACPI: SSDT 00000000bffab940 00386 (v01 HP     ProLiant 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000130000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000130000000
[    0.000000]   NODE_DATA [000000012fffb000 - 000000012fffffff]
[    0.000000]  [ffffea0000000000-ffffea00043fffff] PMD -> [ffff88012ba00000-ffff88012effffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00130000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bff90
[    0.000000]     0: 0x00100000 -> 0x00130000
[    0.000000] On node 0 totalpages: 982814
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3921 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 767944 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 000000000009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e2000
[    0.000000] PM: Registered nosave memory: 00000000000e2000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bff90000 - 00000000bff9e000
[    0.000000] PM: Registered nosave memory: 00000000bff9e000 - 00000000bffa0000
[    0.000000] PM: Registered nosave memory: 00000000bffa0000 - 00000000bffaa000
[    0.000000] PM: Registered nosave memory: 00000000bffaa000 - 00000000bffab000
[    0.000000] PM: Registered nosave memory: 00000000bffab000 - 00000000bffe0000
[    0.000000] PM: Registered nosave memory: 00000000bffe0000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000ffa00000
[    0.000000] PM: Registered nosave memory: 00000000ffa00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:20000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88012fc00000 s82944 r8192 d23552 u524288
[    0.000000] pcpu-alloc: s82944 r8192 d23552 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 965785
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.2.0-4-amd64 root=/dev/mapper/trypticon-root ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ 3dc2000000 size 32 MB
[    0.000000] Aperture beyond 4GB. Ignoring.
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ b4000000
[    0.000000] PM: Registered nosave memory: 00000000b4000000 - 00000000b8000000
[    0.000000] Memory: 3724248k/4980736k available (3429k kernel code, 1049480k absent, 207008k reserved, 3309k data, 576k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:712 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1297.914 MHz processor.
[    0.004005] Calibrating delay loop (skipped), value calculated using timer frequency.. 2595.82 BogoMIPS (lpj=5191656)
[    0.004013] pid_max: default: 32768 minimum: 301
[    0.004096] Security Framework initialized
[    0.004104] AppArmor: AppArmor disabled by boot time parameter
[    0.008259] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010271] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.011208] Mount-cache hash table entries: 256
[    0.011401] Initializing cgroup subsys cpuacct
[    0.011409] Initializing cgroup subsys memory
[    0.011428] Initializing cgroup subsys devices
[    0.011434] Initializing cgroup subsys freezer
[    0.011438] Initializing cgroup subsys net_cls
[    0.011442] Initializing cgroup subsys blkio
[    0.011453] Initializing cgroup subsys perf_event
[    0.011498] tseg: 0000000000
[    0.011521] CPU: Physical Processor ID: 0
[    0.011524] CPU: Processor Core ID: 0
[    0.011528] mce: CPU supports 6 MCE banks
[    0.011542] using AMD E400 aware idle routine
[    0.012097] ACPI: Core revision 20110623
[    0.019112] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.059892] CPU0: AMD Athlon(tm) II Neo N36L Dual-Core Processor stepping 03
[    0.060003] Performance Events: AMD PMU driver.
[    0.060003] ... version:                0
[    0.060003] ... bit width:              48
[    0.060003] ... generic registers:      4
[    0.060003] ... value mask:             0000ffffffffffff
[    0.060003] ... max period:             00007fffffffffff
[    0.060003] ... fixed-purpose events:   0
[    0.060003] ... event mask:             000000000000000f
[    0.060003] NMI watchdog enabled, takes one hw-pmu counter.
[    0.060003] Booting Node   0, Processors  #1
[    0.060003] smpboot cpu 1: start_ip = 99000
[    0.148038] NMI watchdog enabled, takes one hw-pmu counter.
[    0.148072] Brought up 2 CPUs
[    0.148069] System has AMD C1E enabled
[    0.148086] Total of 2 processors activated (5191.58 BogoMIPS).
[    0.148069] Switch to broadcast mode on CPU1
[    0.149032] Switch to broadcast mode on CPU0
[    0.149032] devtmpfs: initialized
[    0.156099] PM: Registering ACPI NVS region at bffaa600 (219648 bytes)
[    0.156391] print_constraints: dummy: 
[    0.156508] NET: Registered protocol family 16
[    0.156660] node 0 link 0: io port [1000, ffffff]
[    0.156665] TOM: 00000000d0000000 aka 3328M
[    0.156670] Fam 10h mmconf [mem 0xe0000000-0xefffffff]
[    0.156676] node 0 link 0: mmio [a0000, bffff]
[    0.156681] node 0 link 0: mmio [d0000000, efffffff] ==> [d0000000, dfffffff]
[    0.156688] node 0 link 0: mmio [f0000000, fe6fffff]
[    0.156692] node 0 link 0: mmio [fe700000, fe8fffff]
[    0.156697] node 0 link 0: mmio [fe900000, ffdfffff]
[    0.156701] TOM2: 0000000130000000 aka 4864M
[    0.156705] bus: [00, 1f] on node 0 link 0
[    0.156709] bus: 00 index 0 [io  0x0000-0xffff]
[    0.156713] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
[    0.156716] bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
[    0.156720] bus: 00 index 3 [mem 0xf0000000-0xffffffff]
[    0.156724] bus: 00 index 4 [mem 0x130000000-0xfcffffffff]
[    0.156736] Extended Config Space enabled on 1 nodes
[    0.156763] ACPI: bus type pci registered
[    0.156865] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.156870] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.199858] PCI: Using configuration type 1 for base access
[    0.200893] bio: create slab <bio-0> at 0
[    0.200893] ACPI: Added _OSI(Module Device)
[    0.200893] ACPI: Added _OSI(Processor Device)
[    0.200893] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.200893] ACPI: Added _OSI(Processor Aggregator Device)
[    0.201351] ACPI: EC: Look up EC in DSDT
[    0.204119] ACPI: Executed 2 blocks of module-level executable AML code
[    0.208547] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.220115] ACPI: OEMN 00000000bffaaeb0 00624 (v01 AMD    NAHP     00000001 INTL 20051117)
[    0.220452] ACPI: Dynamic OEM Table Load:
[    0.220457] ACPI: OEMN           (null) 00624 (v01 AMD    NAHP     00000001 INTL 20051117)
[    0.232241] \_SB_:_OSC evaluation returned wrong type
[    0.232246] _OSC request data:1 17 
[    0.232536] ACPI: Interpreter enabled
[    0.232542] ACPI: (supports S0 S4 S5)
[    0.232573] ACPI: Using IOAPIC for interrupt routing
[    0.239970] ACPI: No dock devices found.
[    0.240049] HEST: Table parsing has been initialized.
[    0.240056] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.240423] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.240760] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.240765] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.240770] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.240775] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff]
[    0.240780] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff]
[    0.240784] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfebfffff]
[    0.240794] pci_root PNP0A08:00: ignoring host bridge window [mem 0x000d0000-0x000dffff] (conflicts with Adapter ROM [mem 0x000cf000-0x000d19ff])
[    0.240817] pci 0000:00:00.0: [1022:9601] type 0 class 0x000600
[    0.240901] pci 0000:00:01.0: [103c:9602] type 1 class 0x000604
[    0.240965] pci 0000:00:06.0: [1022:9606] type 1 class 0x000604
[    0.241021] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.241069] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    0.241096] pci 0000:00:11.0: reg 10: [io  0xd000-0xd007]
[    0.241109] pci 0000:00:11.0: reg 14: [io  0xc000-0xc003]
[    0.241122] pci 0000:00:11.0: reg 18: [io  0xb000-0xb007]
[    0.241134] pci 0000:00:11.0: reg 1c: [io  0xa000-0xa003]
[    0.241147] pci 0000:00:11.0: reg 20: [io  0x9000-0x900f]
[    0.241160] pci 0000:00:11.0: reg 24: [mem 0xfe6ffc00-0xfe6fffff]
[    0.241244] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    0.241262] pci 0000:00:12.0: reg 10: [mem 0xfe6fe000-0xfe6fefff]
[    0.241348] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    0.241372] pci 0000:00:12.2: reg 10: [mem 0xfe6ff800-0xfe6ff8ff]
[    0.241469] pci 0000:00:12.2: supports D1 D2
[    0.241473] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.241504] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    0.241521] pci 0000:00:13.0: reg 10: [mem 0xfe6fd000-0xfe6fdfff]
[    0.241608] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    0.241631] pci 0000:00:13.2: reg 10: [mem 0xfe6ff400-0xfe6ff4ff]
[    0.241727] pci 0000:00:13.2: supports D1 D2
[    0.241731] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.241762] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    0.241852] pci 0000:00:14.1: [1002:439c] type 0 class 0x000101
[    0.241869] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
[    0.241882] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
[    0.241895] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
[    0.241907] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
[    0.241920] pci 0000:00:14.1: reg 20: [io  0xff00-0xff0f]
[    0.241966] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    0.242057] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    0.242116] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    0.242133] pci 0000:00:16.0: reg 10: [mem 0xfe6fc000-0xfe6fcfff]
[    0.242219] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    0.242243] pci 0000:00:16.2: reg 10: [mem 0xfe6ff000-0xfe6ff0ff]
[    0.242340] pci 0000:00:16.2: supports D1 D2
[    0.242343] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.242373] pci 0000:00:18.0: [1022:1200] type 0 class 0x000600
[    0.242404] pci 0000:00:18.1: [1022:1201] type 0 class 0x000600
[    0.242429] pci 0000:00:18.2: [1022:1202] type 0 class 0x000600
[    0.242455] pci 0000:00:18.3: [1022:1203] type 0 class 0x000600
[    0.242485] pci 0000:00:18.4: [1022:1204] type 0 class 0x000600
[    0.242552] pci 0000:01:05.0: [1002:9712] type 0 class 0x000300
[    0.242566] pci 0000:01:05.0: reg 10: [mem 0xd0000000-0xdfffffff pref]
[    0.242575] pci 0000:01:05.0: reg 14: [io  0xe000-0xe0ff]
[    0.242583] pci 0000:01:05.0: reg 18: [mem 0xfe8f0000-0xfe8fffff]
[    0.242599] pci 0000:01:05.0: reg 24: [mem 0xfe700000-0xfe7fffff]
[    0.242627] pci 0000:01:05.0: supports D1 D2
[    0.242675] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.242681] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.242686] pci 0000:00:01.0:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.242693] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.242761] pci 0000:02:00.0: [14e4:165b] type 0 class 0x000200
[    0.242786] pci 0000:02:00.0: reg 10: [mem 0xfe9f0000-0xfe9fffff 64bit]
[    0.242911] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.248068] pci 0000:00:06.0: PCI bridge to [bus 02-02]
[    0.248080] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.248163] pci 0000:00:14.4: PCI bridge to [bus 03-03] (subtractive decode)
[    0.248176] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.248181] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.248186] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.248190] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xdfffffff] (subtractive decode)
[    0.248195] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xfebfffff] (subtractive decode)
[    0.248219] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.248679] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.248762] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE6._PRT]
[    0.249125]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.249480]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.259482] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.259591] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.259697] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.259800] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.259884] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.259949] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.260026] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.260095] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.260284] vgaarb: device added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
[    0.260284] vgaarb: loaded
[    0.260284] vgaarb: bridge control possible 0000:01:05.0
[    0.260284] PCI: Using ACPI for IRQ routing
[    0.270145] PCI: pci_cache_line_size set to 64 bytes
[    0.270249] reserve RAM buffer: 000000000009e800 - 000000000009ffff 
[    0.270254] reserve RAM buffer: 00000000bff90000 - 00000000bfffffff 
[    0.270450] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.270458] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.272068] Switching to clocksource hpet
[    0.274827] pnp: PnP ACPI init
[    0.274858] ACPI: bus type pnp registered
[    0.275065] pnp 00:00: [bus 00-ff]
[    0.275070] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.275074] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.275078] pnp 00:00: [io  0x0d00-0xffff window]
[    0.275083] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.275087] pnp 00:00: [mem 0x000d0000-0x000dffff window]
[    0.275091] pnp 00:00: [mem 0xc0000000-0xdfffffff window]
[    0.275095] pnp 00:00: [mem 0xf0000000-0xfebfffff window]
[    0.275192] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.275660] pnp 00:01: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.275664] pnp 00:01: [mem 0xc0000000-0xcfffffff]
[    0.275748] system 00:01: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.275754] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.275849] pnp 00:02: [dma 4]
[    0.275852] pnp 00:02: [io  0x0000-0x000f]
[    0.275856] pnp 00:02: [io  0x0081-0x0083]
[    0.275860] pnp 00:02: [io  0x0087]
[    0.275863] pnp 00:02: [io  0x0089-0x008b]
[    0.275867] pnp 00:02: [io  0x008f]
[    0.275870] pnp 00:02: [io  0x00c0-0x00df]
[    0.275922] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.275940] pnp 00:03: [io  0x0070-0x0071]
[    0.275956] pnp 00:03: [irq 8]
[    0.276020] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.276095] pnp 00:04: [io  0x0061]
[    0.276149] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.276166] pnp 00:05: [io  0x00f0-0x00ff]
[    0.276208] pnp 00:05: [irq 13]
[    0.276259] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.276306] pnp 00:06: [mem 0xfed00000-0xfed003ff]
[    0.276358] pnp 00:06: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.276503] pnp 00:07: [io  0x0060]
[    0.276507] pnp 00:07: [io  0x0064]
[    0.276511] pnp 00:07: [mem 0xfec00000-0xfec00fff]
[    0.276515] pnp 00:07: [mem 0xfee00000-0xfee00fff]
[    0.276594] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.276600] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.276605] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.276858] pnp 00:08: [io  0x0010-0x001f]
[    0.276862] pnp 00:08: [io  0x0022-0x003f]
[    0.276865] pnp 00:08: [io  0x0062-0x0063]
[    0.276869] pnp 00:08: [io  0x0065-0x006f]
[    0.276872] pnp 00:08: [io  0x0072-0x007f]
[    0.276876] pnp 00:08: [io  0x0080]
[    0.276879] pnp 00:08: [io  0x0084-0x0086]
[    0.276883] pnp 00:08: [io  0x0088]
[    0.276886] pnp 00:08: [io  0x008c-0x008e]
[    0.276889] pnp 00:08: [io  0x0090-0x009f]
[    0.276893] pnp 00:08: [io  0x00a2-0x00bf]
[    0.276896] pnp 00:08: [io  0x00b1]
[    0.276900] pnp 00:08: [io  0x00e0-0x00ef]
[    0.276903] pnp 00:08: [io  0x04d0-0x04d1]
[    0.276907] pnp 00:08: [io  0x040b]
[    0.276910] pnp 00:08: [io  0x04d6]
[    0.276913] pnp 00:08: [io  0x0c00-0x0c01]
[    0.276917] pnp 00:08: [io  0x0c14]
[    0.276920] pnp 00:08: [io  0x0c50-0x0c51]
[    0.276924] pnp 00:08: [io  0x0c52]
[    0.276927] pnp 00:08: [io  0x0c6c]
[    0.276930] pnp 00:08: [io  0x0c6f]
[    0.276933] pnp 00:08: [io  0x0cd0-0x0cd1]
[    0.276939] pnp 00:08: [io  0x0cd2-0x0cd3]
[    0.276942] pnp 00:08: [io  0x0cd4-0x0cd5]
[    0.276946] pnp 00:08: [io  0x0cd6-0x0cd7]
[    0.276949] pnp 00:08: [io  0x0cd8-0x0cdf]
[    0.276953] pnp 00:08: [io  0x0800-0x089f]
[    0.276957] pnp 00:08: [io  0x0000-0xffffffffffffffff disabled]
[    0.276961] pnp 00:08: [io  0x0b00-0x0b1f]
[    0.276964] pnp 00:08: [io  0x0b20-0x0b3f]
[    0.276968] pnp 00:08: [io  0x0900-0x090f]
[    0.276971] pnp 00:08: [io  0x0910-0x091f]
[    0.276975] pnp 00:08: [io  0xfe00-0xfefe]
[    0.276978] pnp 00:08: [io  0x0060]
[    0.276982] pnp 00:08: [io  0x0064]
[    0.276985] pnp 00:08: [mem 0xffb80000-0xffbfffff]
[    0.276989] pnp 00:08: [mem 0xfec10000-0xfec1001f]
[    0.276993] pnp 00:08: [mem 0xfed80000-0xfed80fff]
[    0.276997] pnp 00:08: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.277136] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.277141] system 00:08: [io  0x040b] has been reserved
[    0.277146] system 00:08: [io  0x04d6] has been reserved
[    0.277151] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    0.277155] system 00:08: [io  0x0c14] has been reserved
[    0.277160] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    0.277165] system 00:08: [io  0x0c52] has been reserved
[    0.277169] system 00:08: [io  0x0c6c] has been reserved
[    0.277174] system 00:08: [io  0x0c6f] has been reserved
[    0.277178] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    0.277183] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    0.277188] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    0.277193] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    0.277197] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    0.277202] system 00:08: [io  0x0800-0x089f] has been reserved
[    0.277207] system 00:08: [io  0x0b00-0x0b1f] has been reserved
[    0.277212] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    0.277216] system 00:08: [io  0x0900-0x090f] has been reserved
[    0.277222] system 00:08: [io  0x0910-0x091f] has been reserved
[    0.277227] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    0.277233] system 00:08: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.277238] system 00:08: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.277243] system 00:08: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.277249] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.277322] pnp 00:09: [mem 0xe0000000-0xefffffff]
[    0.277401] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    0.277407] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.277581] pnp 00:0a: [mem 0x00000000-0x0009ffff]
[    0.277586] pnp 00:0a: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.277590] pnp 00:0a: [mem 0x000e0000-0x000fffff]
[    0.277594] pnp 00:0a: [mem 0x00100000-0xbfffffff]
[    0.277598] pnp 00:0a: [mem 0xfec00000-0xffffffff]
[    0.277630] pnp 00:0a: [Firmware Bug]: [mem 0x00000000-0xffffffffffffffff disabled] covers only part of AMD MMCONFIG area [mem 0xe0000000-0xefffffff]; adding more reservations
[    0.277695] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.277700] system 00:0a: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.277706] system 00:0a: [mem 0x00100000-0xbfffffff] could not be reserved
[    0.277711] system 00:0a: [mem 0xfec00000-0xffffffff] could not be reserved
[    0.277716] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.277869] pnp: PnP ACPI: found 11 devices
[    0.277873] ACPI: ACPI bus type pnp unregistered
[    0.293882] PCI: max bus depth: 1 pci_try_num: 2
[    0.293909] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.293914] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.293920] pci 0000:00:01.0:   bridge window [mem 0xfe700000-0xfe8fffff]
[    0.293926] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.293933] pci 0000:00:06.0: PCI bridge to [bus 02-02]
[    0.293939] pci 0000:00:06.0:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.293946] pci 0000:00:14.4: PCI bridge to [bus 03-03]
[    0.293983] pci 0000:00:06.0: setting latency timer to 64
[    0.293994] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.293998] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.294002] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.294006] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xdfffffff]
[    0.294010] pci_bus 0000:00: resource 8 [mem 0xf0000000-0xfebfffff]
[    0.294015] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.294018] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe8fffff]
[    0.294023] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.294027] pci_bus 0000:02: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.294032] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7]
[    0.294036] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff]
[    0.294040] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff]
[    0.294044] pci_bus 0000:03: resource 7 [mem 0xc0000000-0xdfffffff]
[    0.294048] pci_bus 0000:03: resource 8 [mem 0xf0000000-0xfebfffff]
[    0.294180] NET: Registered protocol family 2
[    0.294421] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.296206] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.300270] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.300758] TCP: Hash tables configured (established 524288 bind 65536)
[    0.300763] TCP reno registered
[    0.300780] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.300831] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.301056] NET: Registered protocol family 1
[    0.301076] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
[    1.764214] pci 0000:01:05.0: Boot video device
[    1.764229] PCI: CLS 64 bytes, default 64
[    1.764330] Unpacking initramfs...
[    2.201506] Freeing initrd memory: 11152k freed
[    2.207266] PCI-DMA: Disabling AGP.
[    2.207427] PCI-DMA: aperture base @ b4000000 size 65536 KB
[    2.207431] PCI-DMA: using GART IOMMU.
[    2.207436] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    2.214246] IBS: LVT offset 1 assigned
[    2.214285] perf: AMD IBS detected (0x0000001f)
[    2.214719] audit: initializing netlink socket (disabled)
[    2.214739] type=2000 audit(1394060049.212:1): initialized
[    2.240871] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.242430] VFS: Disk quotas dquot_6.5.2
[    2.242498] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.242662] msgmni has been set to 7424
[    2.243069] alg: No test for stdrng (krng)
[    2.243134] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.243140] io scheduler noop registered
[    2.243143] io scheduler deadline registered
[    2.243186] io scheduler cfq registered (default)
[    2.243421] pcieport 0000:00:06.0: setting latency timer to 64
[    2.243478] pcieport 0000:00:06.0: irq 40 for MSI/MSI-X
[    2.243746] pcieport 0000:00:06.0: Signaling PME through PCIe PME interrupt
[    2.243752] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    2.243758] pcie_pme 0000:00:06.0:pcie01: service driver pcie_pme loaded
[    2.243794] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.243829] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.243832] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.244514] APEI: Can not request iomem region <00000000bffc21ea-00000000bffc21ec> for GARs.
[    2.244639] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    2.244769] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    2.244944] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.281203] Linux agpgart interface v0.103
[    2.281382] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    3.212105] Refined TSC clocksource calibration: 1297.838 MHz.
[    3.212114] Switching to clocksource tsc
[    3.307660] i8042: No controller found
[    3.307842] mousedev: PS/2 mouse device common for all mice
[    3.307904] rtc_cmos 00:03: RTC can wake from S4
[    3.308153] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    3.308191] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.308210] cpuidle: using governor ladder
[    3.308213] cpuidle: using governor menu
[    3.308555] TCP cubic registered
[    3.308638] NET: Registered protocol family 10
[    3.309425] Mobile IPv6
[    3.309430] NET: Registered protocol family 17
[    3.309436] Registering the dns_resolver key type
[    3.309937] PM: Hibernation image not present or could not be loaded.
[    3.309959] registered taskstats version 1
[    3.311387] rtc_cmos 00:03: setting system clock to 2014-03-05 22:54:10 UTC (1394060050)
[    3.311463] Initializing network drop monitor service
[    3.313611] Freeing unused kernel memory: 576k freed
[    3.313832] Write protecting the kernel read-only data: 6144k
[    3.318416] Freeing unused kernel memory: 648k freed
[    3.323655] Freeing unused kernel memory: 688k freed
[    3.348152] udevd[48]: starting version 175
[    3.396104] usbcore: registered new interface driver usbfs
[    3.396147] usbcore: registered new interface driver hub
[    3.397660] SCSI subsystem initialized
[    3.419417] usbcore: registered new device driver usb
[    3.419892] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.420068] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    3.420119] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[    3.420134] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    3.420166] QUIRK: Enable AMD PLL fix
[    3.420181] ehci_hcd 0000:00:12.2: debug port 1
[    3.420218] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe6ff800
[    3.426937] libata version 3.00 loaded.
[    3.432112] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    3.432158] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.432164] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.432169] usb usb1: Product: EHCI Host Controller
[    3.432172] usb usb1: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    3.432176] usb usb1: SerialNumber: 0000:00:12.2
[    3.432399] hub 1-0:1.0: USB hub found
[    3.432408] hub 1-0:1.0: 5 ports detected
[    3.432558] tg3.c:v3.121 (November 2, 2011)
[    3.432621] tg3 0000:02:00.0: setting latency timer to 64
[    3.436903] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.440768] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    3.440797] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[    3.440813] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    3.440850] ehci_hcd 0000:00:13.2: debug port 1
[    3.440872] ehci_hcd 0000:00:13.2: irq 17, io mem 0xfe6ff400
[    3.452106] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    3.452155] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.452161] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.452166] usb usb2: Product: EHCI Host Controller
[    3.452169] usb usb2: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    3.452173] usb usb2: SerialNumber: 0000:00:13.2
[    3.456789] hub 2-0:1.0: USB hub found
[    3.456798] hub 2-0:1.0: 5 ports detected
[    3.482973] tg3 0000:02:00.0: eth0: Tigon3 [partno(BCM95723) rev 5784100] (PCI Express) MAC address 3c:4a:92:72:37:f6
[    3.482980] tg3 0000:02:00.0: eth0: attached PHY is 5784 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.482987] tg3 0000:02:00.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    3.482992] tg3 0000:02:00.0: eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    3.483400] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    3.483418] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 3
[    3.483430] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    3.483466] ehci_hcd 0000:00:16.2: debug port 1
[    3.483487] ehci_hcd 0000:00:16.2: irq 17, io mem 0xfe6ff000
[    3.492254] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    3.492301] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    3.492307] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.492311] usb usb3: Product: EHCI Host Controller
[    3.492315] usb usb3: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    3.492318] usb usb3: SerialNumber: 0000:00:16.2
[    3.492627] hub 3-0:1.0: USB hub found
[    3.492638] hub 3-0:1.0: 4 ports detected
[    3.493419] pata_atiixp 0000:00:14.1: setting latency timer to 64
[    3.494343] scsi0 : pata_atiixp
[    3.494636] scsi1 : pata_atiixp
[    3.495948] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    3.495952] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    3.496158] ahci 0000:00:11.0: version 3.0
[    3.496289] ahci 0000:00:11.0: irq 41 for MSI/MSI-X
[    3.496419] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    3.496426] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    3.497831] scsi2 : ahci
[    3.497984] scsi3 : ahci
[    3.498124] scsi4 : ahci
[    3.498260] scsi5 : ahci
[    3.498417] ata3: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffd00 irq 41
[    3.498423] ata4: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffd80 irq 41
[    3.498428] ata5: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffe00 irq 41
[    3.498434] ata6: SATA max UDMA/133 abar m1024@0xfe6ffc00 port 0xfe6ffe80 irq 41
[    3.498727] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    3.498747] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
[    3.498789] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe6fe000
[    3.556176] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    3.556182] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.556187] usb usb4: Product: OHCI Host Controller
[    3.556190] usb usb4: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    3.556194] usb usb4: SerialNumber: 0000:00:12.0
[    3.556474] hub 4-0:1.0: USB hub found
[    3.556520] hub 4-0:1.0: 5 ports detected
[    3.556722] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    3.556737] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
[    3.556765] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe6fd000
[    3.616168] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.616175] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.616179] usb usb5: Product: OHCI Host Controller
[    3.616182] usb usb5: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    3.616185] usb usb5: SerialNumber: 0000:00:13.0
[    3.616498] hub 5-0:1.0: USB hub found
[    3.616546] hub 5-0:1.0: 5 ports detected
[    3.616802] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    3.616826] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 6
[    3.616861] ohci_hcd 0000:00:16.0: irq 18, io mem 0xfe6fc000
[    3.678612] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.678619] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.678623] usb usb6: Product: OHCI Host Controller
[    3.678626] usb usb6: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    3.678630] usb usb6: SerialNumber: 0000:00:16.0
[    3.678941] hub 6-0:1.0: USB hub found
[    3.678989] hub 6-0:1.0: 4 ports detected
[    3.816176] ata4: SATA link down (SStatus 0 SControl 300)
[    3.820202] ata6: SATA link down (SStatus 0 SControl 300)
[    3.820266] ata5: SATA link down (SStatus 0 SControl 300)
[    3.912122] usb 4-1: new low-speed USB device number 2 using ohci_hcd
[    3.992159] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.992880] ata3.00: failed to enable AA (error_mask=0x1)
[    3.992932] ata3.00: ATA-8: VB0250EAVER, HPG0, max UDMA/100
[    3.992938] ata3.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    3.993901] ata3.00: failed to enable AA (error_mask=0x1)
[    3.993956] ata3.00: configured for UDMA/100
[    3.994316] scsi 2:0:0:0: Direct-Access     ATA      VB0250EAVER      HPG0 PQ: 0 ANSI: 5
[    4.002845] sd 2:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[    4.003183] sd 2:0:0:0: [sda] Write Protect is off
[    4.003189] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.003219] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    4.034673]  sda: sda1 sda2 < sda5 >
[    4.035826] sd 2:0:0:0: [sda] Attached SCSI disk
[    4.039052] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    4.093274] usb 4-1: New USB device found, idVendor=046d, idProduct=c05b
[    4.093281] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.093286] usb 4-1: Product: USB Optical Mouse
[    4.093290] usb 4-1: Manufacturer: Logitech
[    4.104637] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb4/4-1/4-1:1.0/input/input0
[    4.104975] generic-usb 0003:046D:C05B.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-1/input0
[    4.105010] usbcore: registered new interface driver usbhid
[    4.105014] usbhid: USB HID core driver
[    4.330505] device-mapper: uevent: version 1.0.3
[    4.330794] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    4.684102] PM: Starting manual resume from disk
[    4.684109] PM: Hibernation image partition 254:1 present
[    4.684112] PM: Looking for hibernation image.
[    4.684399] PM: Image not found (code -22)
[    4.684405] PM: Hibernation image not present or could not be loaded.
[    4.703018] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[    4.703573] SGI XFS Quota Management subsystem
[    4.706110] XFS (dm-0): Mounting Filesystem
[    4.864432] XFS (dm-0): Ending clean mount
[    6.133531] udevd[350]: starting version 175
[    6.382562] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    6.411512] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    6.411523] ACPI: Power Button [PWRB]
[    6.411625] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    6.411631] ACPI: Power Button [PWRF]
[    6.527689] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    6.576298] ACPI: processor limited to max C-state 1
[    6.583029] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    6.600114] EDAC MC: Ver: 2.1.0
[    6.603224] MCE: In-kernel MCE decoding enabled.
[    6.605713] AMD64 EDAC driver v3.4.0
[    6.605776] EDAC amd64: DRAM ECC enabled.
[    6.605792] EDAC amd64: F10h detected (node 0).
[    6.605825] EDAC MC: DCT0 chip selects:
[    6.605829] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[    6.605833] EDAC amd64: MC: 2:     0MB 3:     0MB
[    6.605836] EDAC amd64: MC: 4:     0MB 5:     0MB
[    6.605839] EDAC amd64: MC: 6:     0MB 7:     0MB
[    6.605842] EDAC MC: DCT1 chip selects:
[    6.605845] EDAC amd64: MC: 0:  1024MB 1:  1024MB
[    6.605848] EDAC amd64: MC: 2:     0MB 3:     0MB
[    6.605852] EDAC amd64: MC: 4:     0MB 5:     0MB
[    6.605855] EDAC amd64: MC: 6:     0MB 7:     0MB
[    6.605857] EDAC amd64: using x4 syndromes.
[    6.605860] EDAC amd64: MCT channel count: 2
[    6.605913] EDAC amd64: CS0: Unbuffered DDR3 RAM
[    6.605917] EDAC amd64: CS1: Unbuffered DDR3 RAM
[    6.605961] EDAC MC0: Giving out device to 'amd64_edac' 'F10h': DEV 0000:00:18.2
[    6.606101] EDAC PCI0: Giving out device to module 'amd64_edac' controller 'EDAC PCI controller': DEV '0000:00:18.2' (POLLED)
[    6.728453] powernow-k8: Found 1 AMD Athlon(tm) II Neo N36L Dual-Core Processor (2 cpu cores) (version 2.20.00)
[    6.728520] powernow-k8:    0 : pstate 0 (1300 MHz)
[    6.728524] powernow-k8:    1 : pstate 1 (1100 MHz)
[    6.728527] powernow-k8:    2 : pstate 2 (800 MHz)
[    6.806305] Error: Driver 'pcspkr' is already registered, aborting...
[    6.949049] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
[    6.949243] SP5100 TCO timer: mmio address 0xb8fe00 already in use
[    7.008296] [drm] Initialized drm 1.1.0 20060810
[    7.059680] [drm] radeon defaulting to kernel modesetting.
[    7.059685] [drm] radeon kernel modesetting enabled.
[    7.101553] radeon 0000:01:05.0: setting latency timer to 64
[    7.101572] [drm] initializing kernel modesetting (RS880 0x1002:0x9712 0x103C:0x1609).
[    7.101659] [drm] register mmio base: 0xFE8F0000
[    7.101665] [drm] register mmio size: 65536
[    7.109661] ATOM BIOS: AMD_1407_150
[    7.109704] radeon 0000:01:05.0: VRAM: 256M 0x00000000C0000000 - 0x00000000CFFFFFFF (256M used)
[    7.109713] radeon 0000:01:05.0: GTT: 512M 0x00000000A0000000 - 0x00000000BFFFFFFF
[    7.110666] [drm] Detected VRAM RAM=256M, BAR=256M
[    7.110675] [drm] RAM width 32bits DDR
[    7.110864] [TTM] Zone  kernel: Available graphics memory: 1901632 kiB
[    7.110872] [TTM] Initializing pool allocator
[    7.110886] [TTM] Initializing DMA pool allocator
[    7.110951] [drm] radeon: 256M of VRAM memory ready
[    7.110957] [drm] radeon: 512M of GTT memory ready.
[    7.111000] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    7.112883] [drm] radeon: ib pool ready.
[    7.113115] [drm] Loading RS780 Microcode
[    7.227706] platform radeon_cp.0: firmware: agent loaded radeon/RS780_pfp.bin into memory
[    7.242212] platform radeon_cp.0: firmware: agent loaded radeon/RS780_me.bin into memory
[    7.260760] platform radeon_cp.0: firmware: agent loaded radeon/R600_rlc.bin into memory
[    7.265958] [drm] PCIE GART of 512M enabled (table at 0x00000000C0040000).
[    7.266162] radeon 0000:01:05.0: WB enabled
[    7.266172] [drm] fence driver on ring 0 use gpu addr 0xa0000c00 and cpu addr 0xffff88012a094c00
[    7.266183] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    7.266189] [drm] Driver supports precise vblank timestamp query.
[    7.266225] [drm] radeon: irq initialized.
[    7.299077] [drm] ring test on 0 succeeded in 0 usecs
[    7.299309] [drm] ib test on ring 0 succeeded in 0 usecs
[    7.299774] [drm] Radeon Display Connectors
[    7.299779] [drm] Connector 0:
[    7.299783] [drm]   VGA
[    7.299789] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[    7.299794] [drm]   Encoders:
[    7.299799] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    7.299843] [drm] radeon: power management initialized
[    7.325634] [drm] fb mappable at 0xD0142000
[    7.325641] [drm] vram apper at 0xD0000000
[    7.325645] [drm] size 3145728
[    7.325650] [drm] fb depth is 24
[    7.325654] [drm]    pitch is 4096
[    7.325887] fbcon: radeondrmfb (fb0) is primary device
[    7.356585] Console: switching to colour frame buffer device 128x48
[    7.368438] fb0: radeondrmfb frame buffer device
[    7.368443] drm: registered panic notifier
[    7.368458] [drm] Initialized radeon 2.16.0 20080528 for 0000:01:05.0 on minor 0
[    9.132162] loop: module loaded
[    9.861118] Adding 7860220k swap on /dev/mapper/trypticon-swap_1.  Priority:-1 extents:1 across:7860220k 
[   10.505039] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   10.538238] XFS (dm-2): Mounting Filesystem
[   10.775473] XFS (dm-2): Ending clean mount
[   10.827900] ISO 9660 Extensions: Microsoft Joliet Level 3
[   10.866468] ISO 9660 Extensions: RRIP_1991A
[   11.844588] tg3 0000:02:00.0: irq 42 for MSI/MSI-X
[   12.620772] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.079766] tg3 0000:02:00.0: eth0: Link is up at 1000 Mbps, full duplex
[   15.079778] tg3 0000:02:00.0: eth0: Flow control is on for TX and on for RX
[   15.081270] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.171156] RPC: Registered named UNIX socket transport module.
[   19.171165] RPC: Registered udp transport module.
[   19.171171] RPC: Registered tcp transport module.
[   19.171177] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   19.197217] FS-Cache: Loaded
[   19.235733] FS-Cache: Netfs 'nfs' registered for caching
[   19.255659] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   26.056195] eth0: no IPv6 routers present
[  218.551240] PM: Marking nosave pages: 000000000009e000 - 0000000000100000
[  218.551249] PM: Marking nosave pages: 00000000bff90000 - 0000000100000000
[  218.553517] PM: Marking nosave pages: 00000000b4000000 - 00000000b8000000
[  218.554001] PM: Basic memory bitmaps created
[  218.554003] PM: Syncing filesystems ... done.
[  218.771097] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  218.784179] PM: Preallocating image memory... done (allocated 48733 pages)
[  218.949998] PM: Allocated 194932 kbytes in 0.16 seconds (1218.32 MB/s)
[  218.950003] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  218.964314] Suspending console(s) (use no_console_suspend to debug)
[  220.000695] PM: freeze of devices complete after 1036.369 msecs
[  220.001144] PM: late freeze of devices complete after 0.444 msecs
[  220.001290] ACPI: Preparing to enter system sleep state S4
[  220.001955] PM: Saving platform NVS memory
[  220.003314] Disabling non-boot CPUs ...
[  220.004877] CPU 1 is now offline
[  220.005533] Extended CMOS year: 2000
[  220.005612] PM: Creating hibernation image:
[  220.008857] PM: Need to copy 48569 pages
[  220.008857] PM: Normal pages needed: 48569 + 1024, available pages: 917782
[  220.008857] PM: Restoring platform NVS memory
[  220.008857] PCI-DMA: Resuming GART IOMMU
[  220.008857] PCI-DMA: Restoring GART aperture settings
[  220.008857] Extended CMOS year: 2000
[  220.008857] Enabling non-boot CPUs ...
[  220.008857] Booting Node 0 Processor 1 APIC 0x1
[  220.008857] smpboot cpu 1: start_ip = 99000
[  220.004852] Calibrating delay loop (skipped) already calibrated this CPU
[  220.004852] Switch to broadcast mode on CPU1
[  220.037584] NMI watchdog enabled, takes one hw-pmu counter.
[  220.038087] CPU1 is up
[  220.038898] ACPI: Waking up from system sleep state S4
[  220.039916] PM: early restore of devices complete after 0.721 msecs
[  220.083312] radeon 0000:01:05.0: setting latency timer to 64
[  220.090507] tg3 0000:02:00.0: eth0: Link is down
[  220.218079] usb usb4: root hub lost power or was reset
[  220.222140] usb usb5: root hub lost power or was reset
[  220.226200] usb usb6: root hub lost power or was reset
[  220.226280] usb usb1: root hub lost power or was reset
[  220.226363] usb usb2: root hub lost power or was reset
[  220.226420] usb usb3: root hub lost power or was reset
[  220.241999] [drm] PCIE GART of 512M enabled (table at 0x00000000C0040000).
[  220.243146] radeon 0000:01:05.0: WB enabled
[  220.243151] [drm] fence driver on ring 0 use gpu addr 0xa0000c00 and cpu addr 0xffff88012a094c00
[  220.283279] [drm] ring test on 0 succeeded in 0 usecs
[  220.283333] [drm] ib test on ring 0 succeeded in 0 usecs
[  220.331728] sd 2:0:0:0: [sda] Starting disk
[  220.524265] ata5: SATA link down (SStatus 0 SControl 300)
[  220.968195] ata4: SATA link down (SStatus 0 SControl 300)
[  220.976193] ata6: SATA link down (SStatus 0 SControl 300)
[  221.140168] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  221.140888] ata3.00: failed to enable AA (error_mask=0x1)
[  221.141836] ata3.00: failed to enable AA (error_mask=0x1)
[  221.141847] ata3.00: configured for UDMA/100
[  221.178350] PM: restore of devices complete after 1095.515 msecs
[  221.178761] PM: Image restored successfully.
[  221.178764] Restarting tasks ... 
[  221.178988] usb 4-1: USB disconnect, device number 2
[  221.180411] done.
[  221.180448] PM: Basic memory bitmaps freed
[  223.268088] tg3 0000:02:00.0: eth0: Link is up at 1000 Mbps, full duplex
[  223.268099] tg3 0000:02:00.0: eth0: Flow control is on for TX and on for RX

-- 
Sitsofe | http://sucs.org/~sits/
