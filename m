From: Greg KH <greg@kroah.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 14:14:13 -0700
Message-ID: <20090817211413.GA30252@kroah.com>
References: <200908172028.26817.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 17, 2009 at 04:53:46PM -0400, Alan Stern wrote:
> On Mon, 17 Aug 2009, Rafael J. Wysocki wrote:
> 
> > I wonder where exactly it hangs.
> > 
> > Can you rebuild the kernel with CONFIG_PM_VERBOSE set and
> > repeat the test with 'echo 8 > /proc/sys/kernel/printk' before the last
> > command?
> 
> That was an interesting experience.  I booted with a serial console in 
> addition to the VT console.  Here's the recorded log of the boot-up:
> 
> [    0.000000] Linux version 2.6.31-rc6 (stern@iolanthe.rowland.org) (gcc version 4.3.2 20081105 (Red Hat 4.3.2-7) (GCC) ) #2 SMP PREEMPT Mon Aug 17 15:44:09 EDT 2009
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   NSC Geode by NSC
> [    0.000000]   Cyrix CyrixInstead
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   Transmeta GenuineTMx86
> [    0.000000]   Transmeta TransmetaCPU
> [    0.000000]   UMC UMC UMC UMC
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000002fe40000 (usable)
> [    0.000000]  BIOS-e820: 000000002fe40000 - 000000002fe50000 (ACPI data)
> [    0.000000]  BIOS-e820: 000000002fe50000 - 000000002ff00000 (ACPI NVS)
> [    0.000000] console [earlyser0] enabled
> [    0.000000] DMI 2.3 present.
> [    0.000000] last_pfn = 0x2fe40 max_arch_pfn = 0x100000
> [    0.000000] init_memory_mapping: 0000000000000000-000000002fe40000
> [    0.000000] RAMDISK: 2fb31000 - 2fe2fafc
> [    0.000000] ACPI: RSDP 000f7300 00014 (v00 ACPIAM)
> [    0.000000] ACPI: RSDT 2fe40000 00030 (v01 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: FACP 2fe40200 00081 (v02 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: DSDT 2fe40370 03FD7 (v01 INTEL  D845GBV2 0000010A MSFT 0100000D)
> [    0.000000] ACPI: FACS 2fe50000 00040
> [    0.000000] ACPI: APIC 2fe40300 00068 (v01 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: ASF! 2fe44350 00084 (v16 AMIASF I845GASF 00000001 MSFT 0100000D)
> [    0.000000] 766MB LOWMEM available.
> [    0.000000]   mapped low ram: 0 - 2fe40000
> [    0.000000]   low ram: 0 - 2fe40000
> [    0.000000]   node 0 low ram: 00000000 - 2fe40000
> [    0.000000]   node 0 bootmap 00008000 - 0000dfc8
> [    0.000000] (9 early reservations) ==> bootmem [0000000000 - 002fe40000]
> [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
> [    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
> [    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
> [    0.000000]   #3 [0001000000 - 0001848fe4]    TEXT DATA BSS ==> [0001000000 - 0001848fe4]
> [    0.000000]   #4 [002fb31000 - 002fe2fafc]          RAMDISK ==> [002fb31000 - 002fe2fafc]
> [    0.000000]   #5 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
> [    0.000000]   #6 [0001849000 - 0001850178]              BRK ==> [0001849000 - 0001850178]
> [    0.000000]   #7 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
> [    0.000000]   #8 [0000008000 - 000000e000]          BOOTMAP ==> [0000008000 - 000000e000]
> [    0.000000] found SMP MP-table at [c00ff780] ff780
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x0002fe40
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x0000009f
> [    0.000000]     0: 0x00000100 -> 0x0002fe40
> [    0.000000] Using APIC driver default
> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] SMP: Allowing 2 CPUs, 1 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
> [    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
> [    0.000000] Allocating PCI resources starting at 2ff00000 (gap: 2ff00000:d0100000)
> [    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 13 pages at c221b000, static data 30620 bytes
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193572
> [    0.000000] Kernel command line: ro root=UUID=38b19631-670b-4ec8-be1a-a65458d523ae resume=/dev/hda7 console=ttyS0,115200 console=tty0 earlyprintk=serial,ttyS0,115200 no_console_suspend init=/bin/bash
> [    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Enabling fast FPU save and restore... done.
> [    0.000000] Enabling unmasked SIMD FPU exception support... done.
> [    0.000000] Initializing CPU#0
> [    0.000000] Memory: 761564k/784640k available (1816k kernel code, 22528k reserved, 1141k data, 264k init, 0k highmem)
> [    0.000000] virtual kernel memory layout:
> [    0.000000]     fixmap  : 0xfff1f000 - 0xfffff000   ( 896 kB)
> [    0.000000]     vmalloc : 0xf0640000 - 0xfff1d000   ( 248 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xefe40000   ( 766 MB)
> [    0.000000]       .init : 0xc12e8000 - 0xc132a000   ( 264 kB)
> [    0.000000]       .data : 0xc11c61db - 0xc12e3730   (1141 kB)
> [    0.000000]       .text : 0xc1000000 - 0xc11c61db   (1816 kB)
> [    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    0.000000] SLUB: Genslabs=13, HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] NR_IRQS:512
> [    0.000000] Fast TSC calibration using PIT
> [    0.000000] Detected 1799.633 MHz processor.
> [    0.001874] Console: colour VGA+ 80x25
> [    0.004000] console handover: boot [earlyser0] -> real [tty0]
> [    0.000000] Linux version 2.6.31-rc6 (stern@iolanthe.rowland.org) (gcc version 4.3.2 20081105 (Red Hat 4.3.2-7) (GCC) ) #2 SMP PREEMPT Mon Aug 17 15:44:09 EDT 2009
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   NSC Geode by NSC
> [    0.000000]   Cyrix CyrixInstead
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   Transmeta GenuineTMx86
> [    0.000000]   Transmeta TransmetaCPU
> [    0.000000]   UMC UMC UMC UMC
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000002fe40000 (usable)
> [    0.000000]  BIOS-e820: 000000002fe40000 - 000000002fe50000 (ACPI data)
> [    0.000000]  BIOS-e820: 000000002fe50000 - 000000002ff00000 (ACPI NVS)
> [    0.000000] console [earlyser0] enabled
> [    0.000000] DMI 2.3 present.
> [    0.000000] last_pfn = 0x2fe40 max_arch_pfn = 0x100000
> [    0.000000] init_memory_mapping: 0000000000000000-000000002fe40000
> [    0.000000] RAMDISK: 2fb31000 - 2fe2fafc
> [    0.000000] ACPI: RSDP 000f7300 00014 (v00 ACPIAM)
> [    0.000000] ACPI: RSDT 2fe40000 00030 (v01 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: FACP 2fe40200 00081 (v02 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: DSDT 2fe40370 03FD7 (v01 INTEL  D845GBV2 0000010A MSFT 0100000D)
> [    0.000000] ACPI: FACS 2fe50000 00040
> [    0.000000] ACPI: APIC 2fe40300 00068 (v01 INTEL  D845GBV2 20030714 MSFT 00000097)
> [    0.000000] ACPI: ASF! 2fe44350 00084 (v16 AMIASF I845GASF 00000001 MSFT 0100000D)
> [    0.000000] 766MB LOWMEM available.
> [    0.000000]   mapped low ram: 0 - 2fe40000
> [    0.000000]   low ram: 0 - 2fe40000
> [    0.000000]   node 0 low ram: 00000000 - 2fe40000
> [    0.000000]   node 0 bootmap 00008000 - 0000dfc8
> [    0.000000] (9 early reservations) ==> bootmem [0000000000 - 002fe40000]
> [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
> [    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
> [    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
> [    0.000000]   #3 [0001000000 - 0001848fe4]    TEXT DATA BSS ==> [0001000000 - 0001848fe4]
> [    0.000000]   #4 [002fb31000 - 002fe2fafc]          RAMDISK ==> [002fb31000 - 002fe2fafc]
> [    0.000000]   #5 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
> [    0.000000]   #6 [0001849000 - 0001850178]              BRK ==> [0001849000 - 0001850178]
> [    0.000000]   #7 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
> [    0.000000]   #8 [0000008000 - 000000e000]          BOOTMAP ==> [0000008000 - 000000e000]
> [    0.000000] found SMP MP-table at [c00ff780] ff780
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x0002fe40
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x0000009f
> [    0.000000]     0: 0x00000100 -> 0x0002fe40
> [    0.000000] Using APIC driver default
> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] SMP: Allowing 2 CPUs, 1 hotplug CPUs
> [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
> [    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
> [    0.000000] Allocating PCI resources starting at 2ff00000 (gap: 2ff00000:d0100000)
> [    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 13 pages at c221b000, static data 30620 bytes
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193572
> [    0.000000] Kernel command line: ro root=UUID=38b19631-670b-4ec8-be1a-a65458d523ae resume=/dev/hda7 console=ttyS0,115200 console=tty0 earlyprintk=serial,ttyS0,115200 no_console_suspend init=/bin/bash
> [    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Enabling fast FPU save and restore... done.
> [    0.000000] Enabling unmasked SIMD FPU exception support... done.
> [    0.000000] Initializing CPU#0
> [    0.000000] Memory: 761564k/784640k available (1816k kernel code, 22528k reserved, 1141k data, 264k init, 0k highmem)
> [    0.000000] virtual kernel memory layout:
> [    0.000000]     fixmap  : 0xfff1f000 - 0xfffff000   ( 896 kB)
> [    0.000000]     vmalloc : 0xf0640000 - 0xfff1d000   ( 248 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xefe40000   ( 766 MB)
> [    0.000000]       .init : 0xc12e8000 - 0xc132a000   ( 264 kB)
> [    0.000000]       .data : 0xc11c61db - 0xc12e3730   (1141 kB)
> [    0.000000]       .text : 0xc1000000 - 0xc11c61db   (1816 kB)
> [    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    0.000000] SLUB: Genslabs=13, HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] NR_IRQS:512
> [    0.000000] Fast TSC calibration using PIT
> [    0.000000] Detected 1799.633 MHz processor.
> [    0.001874] Console: colour VGA+ 80x25
> [    0.004000] console handover: boot [earlyser0] -> real [tty0]
> [    0.004000] console [ttyS0] enabled
> [    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.004000] ... MAX_LOCK_DEPTH:          48
> [    0.004000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.004000] ... CLASSHASH_SIZE:          4096
> [    0.004000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.004000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.004000] ... CHAINHASH_SIZE:          16384
> [    0.004000]  memory used by lock dependency info: 3487 kB
> [    0.004000]  per task-struct memory footprint: 1152 bytes
> [    0.004037] Calibrating delay loop (skipped), value calculated using timer frequency.. 3599.26 BogoMIPS (lpj=7198532)
> [    0.011166] Mount-cache hash table entries: 512
> [    0.018020] CPU: Trace cache: 12K uops, L1 D cache: 8K
> [    0.021658] CPU: L2 cache: 512K
> [    0.024008] CPU: Hyper-Threading is disabled
> [    0.028011] mce: CPU supports 4 MCE banks
> [    0.032061] Checking 'hlt' instruction... OK.
> [    0.052910] lockdep: fixing up alternatives.
> [    0.056009] SMP alternatives: switching to UP code
> [    0.067195] ACPI: Core revision 20090521
> [    0.105689] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.151484] CPU0: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 07
> [    0.160001] Brought up 1 CPUs
> [    0.160001] Total of 1 processors activated (3599.26 BogoMIPS).
> [    0.166324] NET: Registered protocol family 16
> [    0.173435] ACPI: bus type pci registered
> [    0.176897] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
> [    0.180059] PCI: Using configuration type 1 for base access
> [    0.198601] bio: create slab <bio-0> at 0
> [    0.255019] ACPI: Interpreter enabled
> [    0.256016] ACPI: (supports S0 S1 S3 S4 S5)
> [    0.261893] ACPI: Using IOAPIC for interrupt routing
> [    0.311020] ACPI: Power Resource [URP1] (off)
> [    0.312233] ACPI: Power Resource [FDDP] (off)
> [    0.316316] ACPI: Power Resource [LPTP] (off)
> [    0.321187] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [    0.328848] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.332027] pci 0000:00:1d.7: PME# disabled
> [    0.336143] * The chipset may have PM-Timer Bug. Due to workarounds for a bug,
> [    0.336146] * this clock source is slow. If you are sure your timer does not have
> [    0.336149] * this bug, please use "acpi_pm_good" to disable the workaround
> [    0.340095] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
> [    0.344012] pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH4 GPIO
> [    0.348506] pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
> [    0.352013] pci 0000:00:1f.5: PME# disabled
> [    0.356205] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
> [    0.360012] pci 0000:01:00.0: PME# disabled
> [    0.364182] pci 0000:01:00.1: PME# supported from D0 D1 D2 D3hot
> [    0.368012] pci 0000:01:00.1: PME# disabled
> [    0.372183] pci 0000:01:00.2: PME# supported from D0 D1 D2 D3hot
> [    0.376012] pci 0000:01:00.2: PME# disabled
> [    0.380524] pci 0000:01:01.2: PME# supported from D0 D3hot
> [    0.384012] pci 0000:01:01.2: PME# disabled
> [    0.388341] pci 0000:01:08.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.392012] pci 0000:01:08.0: PME# disabled
> [    0.396084] pci 0000:00:1e.0: transparent bridge
> [    0.422147] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> [    0.430851] ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
> [    0.439806] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
> [    0.444759] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
> [    0.453153] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> [    0.462070] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> [    0.470773] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
> [    0.479435] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
> [    0.485472] PCI: Using ACPI for IRQ routing
> [    0.492311] pnp: PnP ACPI init
> [    0.495524] ACPI: bus type pnp registered
> [    0.522218] pnp: PnP ACPI: found 14 devices
> [    0.526503] ACPI: ACPI bus type pnp unregistered
> [    0.532161] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
> [    0.538638] system 00:0c: ioport range 0x400-0x47f has been reserved
> [    0.545085] system 00:0c: ioport range 0x680-0x6ff has been reserved
> [    0.551533] system 00:0c: ioport range 0x480-0x4bf has been reserved
> [    0.558178] system 00:0c: iomem range 0xfec00000-0xfec00fff could not be reserved
> [    0.565796] system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
> [    0.573051] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
> [    0.579764] system 00:0d: iomem range 0xc0000-0xdffff could not be reserved
> [    0.586823] system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
> [    0.593885] system 00:0d: iomem range 0x100000-0x2fefffff could not be reserved
> [    0.639223] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:01
> [    0.645241] pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
> [    0.650649] pci 0000:00:1e.0:   MEM window: 0xff800000-0xff8fffff
> [    0.656834] pci 0000:00:1e.0:   PREFETCH window: 0xe6a00000-0xe6afffff
> [    0.663806] NET: Registered protocol family 2
> [    0.668830] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.677816] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.686847] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
> [    0.709925] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.716756] TCP reno registered
> [    0.720476] NET: Registered protocol family 1
> [    0.725945] Trying to unpack rootfs image as initramfs...
> [    0.963522] Freeing initrd memory: 3066k freed
> [    1.019820] msgmni has been set to 1493
> [    1.024409] alg: No test for stdrng (krng)
> [    1.028896] io scheduler noop registered
> [    1.032909] io scheduler anticipatory registered
> [    1.037784] io scheduler deadline registered
> [    1.043005] io scheduler cfq registered (default)
> [    2.628026] pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?) 01010001
> [    2.635535] pci 0000:01:08.0: Firmware left e100 interrupts enabled; disabling
> [    2.680223] Real Time Clock Driver v1.12b
> [    2.685039] Linux agpgart interface v0.103
> [    2.689372] agpgart-intel 0000:00:00.0: Intel 830M Chipset
> [    2.695334] agpgart-intel 0000:00:00.0: detected 892K stolen memory
> [    2.704642] agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xf0000000
> [    2.712241] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    2.719398] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    2.729430] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    2.749711] brd: module loaded
> [    2.752875] Uniform Multi-Platform E-IDE driver
> [    2.759073] piix 0000:00:1f.1: IDE controller (0x8086:0x24cb rev 0x02)
> [    2.765724] PIIX_IDE 0000:00:1f.1: enabling device (0005 -> 0007)
> [    2.771992] PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [    2.779459] piix 0000:00:1f.1: not 100% native mode: will probe irqs later
> [    2.786433]     ide0: BM-DMA at 0xffa0-0xffa7
> [    2.790993]     ide1: BM-DMA at 0xffa8-0xffaf
> [    3.084274] hda: ST380011A, ATA DISK drive
> [    3.424027] hdb: Maxtor 6Y080P0, ATA DISK drive
> [    3.429511] hda: UDMA/100 mode selected
> [    3.433842] hdb: UDMA/100 mode selected
> [    4.172272] hdc: PLEXTOR DVDR PX-740A, ATAPI CD/DVD-ROM drive
> [    4.848864] hdc: UDMA/33 mode selected
> [    4.853099] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [    4.858158] ide1 at 0x170-0x177,0x376 on irq 15
> [    4.864920] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> [    4.874833] ide-gd driver 1.18
> [    4.878204] hda: max request size: 512KiB
> [    4.892503] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63
> [    4.900328] hda: cache flushes supported
> [    4.904796]  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 > hda4
> [    5.003502] hdb: max request size: 128KiB
> [    5.016666] hdb: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
> [    5.024297] hdb: cache flushes supported
> [    5.028551]  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 >
> [    5.101170] ide-cd driver 5.00
> [    5.106018] ide-cd: hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
> [    5.113647] Uniform CD-ROM driver Revision: 3.20
> [    5.131270] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> [    5.142474] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    5.147626] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    5.153721] mice: PS/2 mouse device common for all mice
> [    5.160998] cpuidle: using governor ladder
> [    5.165411] cpuidle: using governor menu
> [    5.170726] TCP cubic registered
> [    5.174050] NET: Registered protocol family 17
> [    5.178694] Using IPI No-Shortcut mode
> [    5.185668] Freeing unused kernel memory: 264k freed
> [    5.191539] Write protecting the kernel text: 1820k
> [    5.196823] Write protecting the kernel read-only data: 888k
> [    5.509740] input: PS2++ Logitech Mouse as /devices/platform/i8042/serio1/input/input0
> [    5.560195] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    8.394440] kjournald starting.  Commit interval 5 seconds
> [    8.400608] EXT3-fs: mounted filesystem with writeback data mode.
> 
> Here's where I changed the log level and began the suspend:
> 
> [   11.480553] SysRq : Changing Loglevel
> [   11.484004] Loglevel set to 8
> [   24.279093] PM: Syncing filesystems ... done.
> [   24.285068] PM: Preparing system for mem sleep
> [   24.290143] PM: Adding info for No Bus:vcs63
> [   24.290700] PM: Adding info for No Bus:vcsa63
> [   24.305317] Freezing user space processes ... (elapsed 0.00 seconds) done.
> [   24.331507] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> [   24.339078] PM: Entering mem sleep
> [   24.342844] agpgart-intel 0000:00:00.0: preparing suspend
> [   24.348404] pci 0000:00:02.0: preparing suspend
> [   24.352988] pci 0000:00:1d.0: preparing suspend
> [   24.357569] pci 0000:00:1d.1: preparing suspend
> [   24.362150] pci 0000:00:1d.2: preparing suspend
> [   24.366731] pci 0000:00:1d.7: preparing suspend
> [   24.371312] pci 0000:00:1e.0: preparing suspend
> [   24.375893] pci 0000:00:1f.0: preparing suspend
> [   24.380475] PIIX_IDE 0000:00:1f.1: preparing suspend
> [   24.385490] pci 0000:00:1f.3: preparing suspend
> [   24.390070] pci 0000:00:1f.5: preparing suspend
> [   24.394651] pci 0000:01:00.0: preparing suspend
> [   24.399232] pci 0000:01:00.1: preparing suspend
> [   24.403813] pci 0000:01:00.2: preparing suspend
> [   24.408395] pci 0000:01:01.0: preparing suspend
> [   24.412976] pci 0000:01:01.1: preparing suspend
> [   24.417557] pci 0000:01:01.2: preparing suspend
> [   24.422138] pci 0000:01:02.0: preparing suspend
> [   24.426719] pci 0000:01:08.0: preparing suspend
> [   24.431376] platform pcspkr: preparing suspend
> [   24.436080] serial8250 serial8250: preparing suspend
> [   24.441337] i8042 i8042: preparing suspend
> [   24.445577] psmouse serio1: legacy suspend
> [   24.856816] atkbd serio0: legacy suspend
> [   25.328042] i8042 i8042: suspend
> [   25.331538] ide-cdrom 1.0: legacy suspend
> [   25.335933] ide-gd 0.1: legacy suspend
> [   25.406305] ide-gd 0.0: legacy suspend
> [   25.412454] serial8250 serial8250: suspend
> [   25.416844] platform pcspkr: suspend
> [   25.420534] system 00:0d: legacy suspend
> [   25.424567] system 00:0c: legacy suspend
> [   25.428595] i8042 aux 00:0b: legacy suspend
> [   25.432883] i8042 kbd 00:0a: legacy suspend
> [   25.437169] pnp 00:09: legacy suspend
> [   25.440923] serial 00:08: legacy suspend
> 
> A lot more stuff appeared on the screen here but didn't get sent over
> the serial link.  Then after 5 seconds the system did resume.  A lot of
> messages about PCI config-space settings appeared on the screen but not
> on the serial link.  Then came this -- it did _not_ appear on the
> screen:
> 
> [   30.497131] serial 00:08: activated
> [   30.501039] pnp 00:09: legacy resume
> [   30.505030] i8042 kbd 00:0a: legacy resume
> [   30.509553] i8042 aux 00:0b: legacy resume
> [   30.514075] system 00:0c: legacy resume
> [   30.518333] system 00:0d: legacy resume
> [   30.522616] platform pcspkr: resume
> [   30.526714] serial8250 serial8250: resume
> [   30.531260] ide-gd 0.0: legacy resume
> [   30.537364] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   33.776044] hda: UDMA/100 mode selected
> [   33.780946] ide-gd 0.1: legacy resume
> [   33.787040] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   37.052038] hdb: UDMA/100 mode selected
> [   37.056646] ide-cdrom 1.0: legacy resume
> [   37.063003] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   37.070384] hdc: UDMA/33 mode selected
> [   37.075131] i8042 i8042: resume
> [   37.079067] atkbd serio0: legacy resume
> [   37.083382] psmouse serio1: legacy resume
> [   37.087868] i8042 i8042: completing resume
> [   37.092576] serial8250 serial8250: completing resume
> [   37.098178] platform pcspkr: completing resume
> [   37.103122] pci 0000:01:08.0: completing resume
> [   37.108093] pci 0000:01:02.0: completing resume
> [   37.113054] pci 0000:01:01.2: completing resume
> [   37.118016] pci 0000:01:01.1: completing resume
> [   37.122978] pci 0000:01:01.0: completing resume
> [   37.127940] pci 0000:01:00.2: completing resume
> [   37.132902] pci 0000:01:00.1: completing resume
> [   37.137864] pci 0000:01:00.0: completing resume
> [   37.142825] pci 0000:00:1f.5: completing resume
> [   37.147787] pci 0000:00:1f.3: completing resume
> [   37.152749] PIIX_IDE 0000:00:1f.1: completing resume
> [   37.158155] pci 0000:00:1f.0: completing resume
> [   37.163117] pci 0000:00:1e.0: completing resume
> [   37.168079] pci 0000:00:1d.7: completing resume
> [   37.173041] pci 0000:00:1d.2: completing resume
> [   37.178003] pci 0000:00:1d.1: completing resume
> [   37.182964] pci 0000:00:1d.0: completing resume
> [   37.187926] pci 0000:00:02.0: completing resume
> [   37.192889] agpgart-intel 0000:00:00.0: completing resume
> [   37.198935] PM: Finishing wakeup.
> [   37.202656] Restarting tasks ... done.
> 
> As far as I can tell, the system was running again.  But the screen was
> still set to the alternate VT!  There was no response to normal
> keystrokes or Alt-F1.  But it did respond to Alt-SysRq-h:
> 
> [   46.826069] SysRq : HELP : loglevel(0-9) reBoot Crash show-all-locks(D) terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) thaw-filesystems(J) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) 
> 
> (That's from the serial log; it wasn't on the screen.)
> 
> It appears that some part of the resume messed up the VT console
> driver.

Can you try the patch below from Jiri that I just added to my tree to
hopefully resolve this issue?

thanks,

greg k-h

------------------

From: Jiri Slaby <jirislaby@gmail.com>
Subject: tty: Power: fix suspend vt regression
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>


vt_waitactive no longer accepts console parameter as console-1
since commit "vt: add an event interface". It expects console
number directly (as viewed by userspace -- counting from 1).

Fix a deadlock suspend regression by redefining adding one
to vt in vt_move_to_console.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/vt_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -1757,7 +1757,7 @@ int vt_move_to_console(unsigned int vt, 
 		return -EIO;
 	}
 	release_console_sem();
-	if (vt_waitactive(vt)) {
+	if (vt_waitactive(vt + 1)) {
 		pr_debug("Suspend: Can't switch VCs.");
 		return -EINTR;
 	}
