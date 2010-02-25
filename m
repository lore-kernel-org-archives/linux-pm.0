From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Thu, 25 Feb 2010 23:49:10 +0100
Message-ID: <4B86FE66.7000901@maroy.hu>
References: <4B86F96A.1010306@maroy.hu> <201002252337.39683.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010703020208050807020907"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002252337.39683.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703020208050807020907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rafael,

> Please try
> 
> # echo core > /sys/power/pm_test
> # echo disk > /sys/power/state
> 
> That should return to the command prompt after ~5 sec.

thanks. indeed, it does return, this is what I get in /var/log/messages:

Feb 25 23:46:24 tonkachi kernel: [   77.846865] PM: Syncing filesystems
... done.
Feb 25 23:46:24 tonkachi kernel: [   77.997120] Freezing user space
processes ... (elapsed 0.00 seconds) done.
Feb 25 23:46:24 tonkachi kernel: [   77.998042] Freezing remaining
freezable tasks ... (elapsed 0.00 seconds) done.
Feb 25 23:46:24 tonkachi kernel: [   77.998269] PM: Preallocating image
memory... done (allocated 1936029 pages)
Feb 25 23:46:24 tonkachi kernel: [   80.480913] PM: Allocated 7744116
kbytes in 2.48 seconds (3122.62 MB/s)
Feb 25 23:46:24 tonkachi kernel: [   80.480918] Suspending console(s)
(use no_console_suspend to debug)
Feb 25 23:46:24 tonkachi kernel: [   81.030959] Registered led device:
iwl-phy0::radio
Feb 25 23:46:24 tonkachi kernel: [   81.030989] Registered led device:
iwl-phy0::assoc
Feb 25 23:46:24 tonkachi kernel: [   81.031016] Registered led device:
iwl-phy0::RX
Feb 25 23:46:24 tonkachi kernel: [   81.031041] Registered led device:
iwl-phy0::TX
Feb 25 23:46:24 tonkachi kernel: [   81.166877] Restarting tasks ...
Feb 25 23:46:24 tonkachi kernel: [   81.169743] done.


my dmesg is much more talkative - please find it attached.


Akos




--------------010703020208050807020907
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32.8-usb-debug (root@tonkachi) (gcc version 4.4.1 (Ubuntu 4.4.1-4ubuntu9) ) #1 SMP Thu Feb 25 22:03:46 CET 2010
[    0.000000] Command line: root=/dev/mapper/isw_cdfcbdcfed_RAID-02 ro quiet splash 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
[    0.000000]  BIOS-e820: 000000000009bc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bf682000 (usable)
[    0.000000]  BIOS-e820: 00000000bf682000 - 00000000bf6bf000 (reserved)
[    0.000000]  BIOS-e820: 00000000bf6bf000 - 00000000bf75c000 (usable)
[    0.000000]  BIOS-e820: 00000000bf75c000 - 00000000bf7bf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bf7bf000 - 00000000bf7e4000 (usable)
[    0.000000]  BIOS-e820: 00000000bf7e4000 - 00000000bf7ff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bf7ff000 - 00000000bf800000 (usable)
[    0.000000]  BIOS-e820: 00000000bf800000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000feb00000 - 00000000feb04000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1b000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
[    0.000000] DMI 2.6 present.
[    0.000000] last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-combining
[    0.000000]   C0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-combining
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 0FFE00000 mask FFFE00000 write-protect
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0BF800000 mask FFF800000 uncachable
[    0.000000]   4 base 100000000 mask F00000000 write-back
[    0.000000]   5 base 200000000 mask FC0000000 write-back
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0xbf800 max_arch_pfn = 0x400000000
[    0.000000] e820 update range: 0000000000001000 - 0000000000006000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000001000 (usable)
[    0.000000]  modified: 0000000000001000 - 0000000000006000 (reserved)
[    0.000000]  modified: 0000000000006000 - 000000000009bc00 (usable)
[    0.000000]  modified: 000000000009bc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000bf682000 (usable)
[    0.000000]  modified: 00000000bf682000 - 00000000bf6bf000 (reserved)
[    0.000000]  modified: 00000000bf6bf000 - 00000000bf75c000 (usable)
[    0.000000]  modified: 00000000bf75c000 - 00000000bf7bf000 (ACPI NVS)
[    0.000000]  modified: 00000000bf7bf000 - 00000000bf7e4000 (usable)
[    0.000000]  modified: 00000000bf7e4000 - 00000000bf7ff000 (ACPI data)
[    0.000000]  modified: 00000000bf7ff000 - 00000000bf800000 (usable)
[    0.000000]  modified: 00000000bf800000 - 00000000c0000000 (reserved)
[    0.000000]  modified: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  modified: 00000000feb00000 - 00000000feb04000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  modified: 00000000fed10000 - 00000000fed14000 (reserved)
[    0.000000]  modified: 00000000fed18000 - 00000000fed1a000 (reserved)
[    0.000000]  modified: 00000000fed1b000 - 00000000fed20000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ffe80000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000240000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000bf800000
[    0.000000]  0000000000 - 00bf800000 page 2M
[    0.000000] kernel direct mapping tables up to bf800000 @ 8000-c000
[    0.000000] init_memory_mapping: 0000000100000000-0000000240000000
[    0.000000]  0100000000 - 0240000000 page 2M
[    0.000000] kernel direct mapping tables up to 240000000 @ a000-14000
[    0.000000] RAMDISK: 33d19000 - 37fef0a6
[    0.000000] ACPI: RSDP 00000000000fe020 00024 (v02 HP    )
[    0.000000] ACPI: XSDT 00000000bf7fe120 0009C (v01 HPQOEM SLIC-MPC 00000001      01000013)
[    0.000000] ACPI: FACP 00000000bf7fc000 000F4 (v04 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: DSDT 00000000bf7ee000 0ABEA (v02 HP     SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: FACS 00000000bf76e000 00040
[    0.000000] ACPI: ASF! 00000000bf7fd000 000A5 (v32 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: HPET 00000000bf7fb000 00038 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: APIC 00000000bf7fa000 0008C (v02 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 00000000bf7f9000 0003C (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SLIC 00000000bf7ed000 00176 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7ec000 0073D (v01 TrmRef PtidDevc 00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000bf7eb000 00172 (v01  VaRef  Va_Acpi 00003000 INTL 20051117)
[    0.000000] ACPI: BOOT 00000000bf7ea000 00028 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7e9000 00C39 (v01 INTEL   SataPri 00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000bf7e8000 006C5 (v01 INTEL   SataSec 00001000 INTL 20051117)
[    0.000000] ACPI: SPCR 00000000bf7e7000 00050 (v01 HPQOEM SLIC-MPC 00000000 MSFT 01000013)
[    0.000000] ACPI: ASPT 00000000bf7e6000 00034 (v04 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: WDAT 00000000bf7e5000 00224 (v01 HPQOEM SLIC-MPC 00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7e4000 009F1 (v01  PmRef    CpuPm 00003000 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000240000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000240000000
[    0.000000]   NODE_DATA [000000000000f000 - 0000000000013fff]
[    0.000000]   bootmap [0000000000014000 -  000000000005bfff] pages 48
[    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0240000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 0001a157c4]    TEXT DATA BSS ==> [0001000000 - 0001a157c4]
[    0.000000]   #3 [0033d19000 - 0037fef0a6]          RAMDISK ==> [0033d19000 - 0037fef0a6]
[    0.000000]   #4 [000009bc00 - 0000100000]    BIOS reserved ==> [000009bc00 - 0000100000]
[    0.000000]   #5 [0001a16000 - 0001a16230]              BRK ==> [0001a16000 - 0001a16230]
[    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000]   #7 [000000a000 - 000000f000]          PGTABLE ==> [000000a000 - 000000f000]
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD -> [ffff880028600000-ffff88002f5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00240000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000001
[    0.000000]     0: 0x00000006 -> 0x0000009b
[    0.000000]     0: 0x00000100 -> 0x000bf682
[    0.000000]     0: 0x000bf6bf -> 0x000bf75c
[    0.000000]     0: 0x000bf7bf -> 0x000bf7e4
[    0.000000]     0: 0x000bf7ff -> 0x000bf800
[    0.000000]     0: 0x00100000 -> 0x00240000
[    0.000000] On node 0 totalpages: 2094811
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 110 pages reserved
[    0.000000]   DMA zone: 3824 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 765821 pages, LIFO batch:31
[    0.000000]   Normal zone: 17920 pages used for memmap
[    0.000000]   Normal zone: 1292800 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 0000000000001000 - 0000000000006000
[    0.000000] PM: Registered nosave memory: 000000000009b000 - 000000000009c000
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bf682000 - 00000000bf6bf000
[    0.000000] PM: Registered nosave memory: 00000000bf75c000 - 00000000bf7bf000
[    0.000000] PM: Registered nosave memory: 00000000bf7e4000 - 00000000bf7ff000
[    0.000000] PM: Registered nosave memory: 00000000bf800000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000feb00000
[    0.000000] PM: Registered nosave memory: 00000000feb00000 - 00000000feb04000
[    0.000000] PM: Registered nosave memory: 00000000feb04000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed14000
[    0.000000] PM: Registered nosave memory: 00000000fed14000 - 00000000fed18000
[    0.000000] PM: Registered nosave memory: 00000000fed18000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1b000
[    0.000000] PM: Registered nosave memory: 00000000fed1b000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffe80000
[    0.000000] PM: Registered nosave memory: 00000000ffe80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:20000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880028200000 s91224 r8192 d23464 u262144
[    0.000000] pcpu-alloc: s91224 r8192 d23464 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2062445
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/mapper/isw_cdfcbdcfed_RAID-02 ro quiet splash 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
[    0.000000] software IO TLB at phys 0x20000000 - 0x24000000
[    0.000000] Memory: 8118524k/9437184k available (5407k kernel code, 1057940k absent, 260720k reserved, 3084k data, 692k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:472
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 83886080 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000]   alloc irq_desc for 24 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 25 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 26 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 27 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 28 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.000000] Fast TSC calibration using PIT
[    0.010000] Detected 1595.779 MHz processor.
[    0.000009] Calibrating delay loop (skipped), value calculated using timer frequency.. 3191.55 BogoMIPS (lpj=15957790)
[    0.000026] Security Framework initialized
[    0.000031] SELinux:  Disabled at boot.
[    0.000731] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.002931] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003852] Mount-cache hash table entries: 256
[    0.003959] Initializing cgroup subsys ns
[    0.003962] Initializing cgroup subsys cpuacct
[    0.003967] Initializing cgroup subsys memory
[    0.003972] Initializing cgroup subsys freezer
[    0.003974] Initializing cgroup subsys net_cls
[    0.003990] CPU: Physical Processor ID: 0
[    0.003992] CPU: Processor Core ID: 0
[    0.003995] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.003998] CPU: L2 cache: 256K
[    0.003999] CPU: L3 cache: 6144K
[    0.004002] CPU 0/0x0 -> Node 0
[    0.004005] mce: CPU supports 9 MCE banks
[    0.004016] CPU0: Thermal monitoring enabled (TM1)
[    0.004020] CPU 0 MCA banks CMCI:2 CMCI:3 CMCI:5 CMCI:6 SHD:8
[    0.004029] using mwait in idle threads.
[    0.004031] Performance Events: Nehalem/Corei7 events, Intel PMU driver.
[    0.004036] ... version:                3
[    0.004038] ... bit width:              48
[    0.004039] ... generic registers:      4
[    0.004041] ... value mask:             0000ffffffffffff
[    0.004042] ... max period:             000000007fffffff
[    0.004044] ... fixed-purpose events:   3
[    0.004045] ... event mask:             000000070000000f
[    0.006508] ACPI: Core revision 20090903
[    0.039575] Setting APIC routing to flat
[    0.039953] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.139855] CPU0: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    0.257764] Booting processor 1 APIC 0x2 ip 0x6000
[    0.268340] Initializing CPU#1
[    0.417495] CPU: Physical Processor ID: 0
[    0.417496] CPU: Processor Core ID: 1
[    0.417499] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.417501] CPU: L2 cache: 256K
[    0.417502] CPU: L3 cache: 6144K
[    0.417505] CPU 1/0x2 -> Node 0
[    0.417517] CPU1: Thermal monitoring enabled (TM1)
[    0.417521] CPU 1 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
[    0.417617] CPU1: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    0.417629] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.437694] Booting processor 2 APIC 0x4 ip 0x6000
[    0.448031] Initializing CPU#2
[    0.597321] CPU: Physical Processor ID: 0
[    0.597323] CPU: Processor Core ID: 2
[    0.597325] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.597327] CPU: L2 cache: 256K
[    0.597329] CPU: L3 cache: 6144K
[    0.597331] CPU 2/0x4 -> Node 0
[    0.597343] CPU2: Thermal monitoring enabled (TM1)
[    0.597347] CPU 2 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
[    0.597447] CPU2: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    0.597458] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.617525] Booting processor 3 APIC 0x6 ip 0x6000
[    0.627862] Initializing CPU#3
[    0.777147] CPU: Physical Processor ID: 0
[    0.777149] CPU: Processor Core ID: 3
[    0.777152] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.777154] CPU: L2 cache: 256K
[    0.777155] CPU: L3 cache: 6144K
[    0.777157] CPU 3/0x6 -> Node 0
[    0.777170] CPU3: Thermal monitoring enabled (TM1)
[    0.777173] CPU 3 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6 SHD:8
[    0.777277] CPU3: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    0.777288] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.797357] Booting processor 4 APIC 0x1 ip 0x6000
[    0.807699] Initializing CPU#4
[    0.956975] CPU: Physical Processor ID: 0
[    0.956976] CPU: Processor Core ID: 0
[    0.956980] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.956982] CPU: L2 cache: 256K
[    0.956984] CPU: L3 cache: 6144K
[    0.956987] CPU 4/0x1 -> Node 0
[    0.957000] CPU4: Thermal monitoring enabled (TM1)
[    0.957004] CPU 4 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
[    0.957029] CPU4: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    0.957042] checking TSC synchronization [CPU#0 -> CPU#4]: passed.
[    0.977111] Booting processor 5 APIC 0x3 ip 0x6000
[    0.987447] Initializing CPU#5
[    1.136800] CPU: Physical Processor ID: 0
[    1.136801] CPU: Processor Core ID: 1
[    1.136804] CPU: L1 I cache: 32K, L1 D cache: 32K
[    1.136806] CPU: L2 cache: 256K
[    1.136807] CPU: L3 cache: 6144K
[    1.136810] CPU 5/0x3 -> Node 0
[    1.136822] CPU5: Thermal monitoring enabled (TM1)
[    1.136825] CPU 5 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
[    1.136864] CPU5: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    1.136876] checking TSC synchronization [CPU#0 -> CPU#5]: passed.
[    1.156942] Booting processor 6 APIC 0x5 ip 0x6000
[    1.167279] Initializing CPU#6
[    1.316626] CPU: Physical Processor ID: 0
[    1.316628] CPU: Processor Core ID: 2
[    1.316630] CPU: L1 I cache: 32K, L1 D cache: 32K
[    1.316632] CPU: L2 cache: 256K
[    1.316633] CPU: L3 cache: 6144K
[    1.316636] CPU 6/0x5 -> Node 0
[    1.316648] CPU6: Thermal monitoring enabled (TM1)
[    1.316651] CPU 6 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
[    1.316695] CPU6: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    1.316707] checking TSC synchronization [CPU#0 -> CPU#6]: passed.
[    1.336775] Booting processor 7 APIC 0x7 ip 0x6000
[    1.347111] Initializing CPU#7
[    1.496452] CPU: Physical Processor ID: 0
[    1.496454] CPU: Processor Core ID: 3
[    1.496457] CPU: L1 I cache: 32K, L1 D cache: 32K
[    1.496458] CPU: L2 cache: 256K
[    1.496460] CPU: L3 cache: 6144K
[    1.496462] CPU 7/0x7 -> Node 0
[    1.496474] CPU7: Thermal monitoring enabled (TM1)
[    1.496477] CPU 7 MCA banks SHD:2 SHD:3 SHD:5 SHD:6 SHD:8
[    1.496527] CPU7: Intel(R) Core(TM) i7 CPU       Q 720  @ 1.60GHz stepping 05
[    1.496539] checking TSC synchronization [CPU#0 -> CPU#7]: passed.
[    1.516540] Brought up 8 CPUs
[    1.516543] Total of 8 processors activated (25535.22 BogoMIPS).
[    1.520265] CPU0 attaching sched-domain:
[    1.520269]  domain 0: span 0,4 level SIBLING
[    1.520272]   groups: 0 (cpu_power = 589) 4 (cpu_power = 589)
[    1.520277]   domain 1: span 0-7 level MC
[    1.520280]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[    1.520290] CPU1 attaching sched-domain:
[    1.520292]  domain 0: span 1,5 level SIBLING
[    1.520295]   groups: 1 (cpu_power = 589) 5 (cpu_power = 589)
[    1.520299]   domain 1: span 0-7 level MC
[    1.520302]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[    1.520311] CPU2 attaching sched-domain:
[    1.520312]  domain 0: span 2,6 level SIBLING
[    1.520315]   groups: 2 (cpu_power = 589) 6 (cpu_power = 589)
[    1.520320]   domain 1: span 0-7 level MC
[    1.520322]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[    1.520330] CPU3 attaching sched-domain:
[    1.520332]  domain 0: span 3,7 level SIBLING
[    1.520335]   groups: 3 (cpu_power = 589) 7 (cpu_power = 589)
[    1.520339]   domain 1: span 0-7 level MC
[    1.520342]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[    1.520350] CPU4 attaching sched-domain:
[    1.520352]  domain 0: span 0,4 level SIBLING
[    1.520354]   groups: 4 (cpu_power = 589) 0 (cpu_power = 589)
[    1.520359]   domain 1: span 0-7 level MC
[    1.520361]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[    1.520370] CPU5 attaching sched-domain:
[    1.520372]  domain 0: span 1,5 level SIBLING
[    1.520374]   groups: 5 (cpu_power = 589) 1 (cpu_power = 589)
[    1.520379]   domain 1: span 0-7 level MC
[    1.520381]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[    1.520390] CPU6 attaching sched-domain:
[    1.520392]  domain 0: span 2,6 level SIBLING
[    1.520394]   groups: 6 (cpu_power = 589) 2 (cpu_power = 589)
[    1.520399]   domain 1: span 0-7 level MC
[    1.520401]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[    1.520410] CPU7 attaching sched-domain:
[    1.520412]  domain 0: span 3,7 level SIBLING
[    1.520414]   groups: 7 (cpu_power = 589) 3 (cpu_power = 589)
[    1.520419]   domain 1: span 0-7 level MC
[    1.520421]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[    1.521089] regulator: core version 0.5
[    1.521120] Time: 22:45:04  Date: 02/25/10
[    1.521163] NET: Registered protocol family 16
[    1.521269] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.521272] ACPI: bus type pci registered
[    1.521357] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    1.521360] PCI: MCFG area at e0000000 reserved in E820
[    1.530448] PCI: Using MMCONFIG at e0000000 - efffffff
[    1.530450] PCI: Using configuration type 1 for base access
[    1.531317] bio: create slab <bio-0> at 0
[    1.532877] ACPI: EC: Look up EC in DSDT
[    1.534640] ACPI: Executed 1 blocks of module-level executable AML code
[    1.539336] ACPI: BIOS _OSI(Linux) query ignored
[    1.551624] ACPI Error (psargs-0359): [\_PR_.CPU0._PPC] Namespace lookup failure, AE_NOT_FOUND
[    1.551635] ACPI Error (psparse-0537): Method parse/execution failed [\CPUT] (Node ffff8802370570a0), AE_NOT_FOUND
[    1.551684] ACPI Error (psparse-0537): Method parse/execution failed [\PSSC] (Node ffff8802370570c0), AE_NOT_FOUND
[    1.551732] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff88023703fa60), AE_NOT_FOUND
[    1.551799] Fail in evaluating the _REG object of EC device. Broken bios is suspected.
[    1.551896] ACPI: Interpreter enabled
[    1.551900] ACPI: (supports S0 S3 S4 S5)
[    1.551948] ACPI: Using IOAPIC for interrupt routing
[    1.564465] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    1.565393] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    1.566441] _OSC invalid UUID
[    1.566444] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    1.566590] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.566594] pci 0000:00:03.0: PME# disabled
[    1.566660] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    1.566663] pci 0000:00:05.0: PME# disabled
[    1.566996] pci 0000:00:1b.0: reg 10 64bit mmio: [0xd4200000-0xd4203fff]
[    1.567048] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.567057] pci 0000:00:1b.0: PME# disabled
[    1.567140] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.567148] pci 0000:00:1c.0: PME# disabled
[    1.567227] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.567235] pci 0000:00:1c.1: PME# disabled
[    1.567307] pci 0000:00:1d.0: reg 10 32bit mmio: [0xd4205800-0xd4205bff]
[    1.567373] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.567382] pci 0000:00:1d.0: PME# disabled
[    1.567617] pci 0000:00:1f.2: reg 10 io port: [0x5048-0x504f]
[    1.567628] pci 0000:00:1f.2: reg 14 io port: [0x5054-0x5057]
[    1.567639] pci 0000:00:1f.2: reg 18 io port: [0x5040-0x5047]
[    1.567650] pci 0000:00:1f.2: reg 1c io port: [0x5050-0x5053]
[    1.567660] pci 0000:00:1f.2: reg 20 io port: [0x5020-0x503f]
[    1.567671] pci 0000:00:1f.2: reg 24 32bit mmio: [0xd4205000-0xd42057ff]
[    1.567713] pci 0000:00:1f.2: PME# supported from D3hot
[    1.567722] pci 0000:00:1f.2: PME# disabled
[    1.567769] pci 0000:00:1f.3: reg 10 64bit mmio: [0xd4205c00-0xd4205cff]
[    1.567787] pci 0000:00:1f.3: reg 20 io port: [0x5000-0x501f]
[    1.567860] pci 0000:01:00.0: reg 10 64bit mmio pref: [0xc0000000-0xcfffffff]
[    1.567870] pci 0000:01:00.0: reg 18 64bit mmio: [0xd4100000-0xd411ffff]
[    1.567876] pci 0000:01:00.0: reg 20 io port: [0x4000-0x40ff]
[    1.567886] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xfffe0000-0xffffffff]
[    1.567906] pci 0000:01:00.0: supports D1 D2
[    1.567941] pci 0000:01:00.1: reg 10 64bit mmio: [0xd4120000-0xd4123fff]
[    1.567979] pci 0000:01:00.1: supports D1 D2
[    1.568017] pci 0000:00:03.0: bridge io port: [0x4000-0x4fff]
[    1.568020] pci 0000:00:03.0: bridge 32bit mmio: [0xd4100000-0xd41fffff]
[    1.568026] pci 0000:00:03.0: bridge 64bit mmio pref: [0xc0000000-0xcfffffff]
[    1.568075] pci 0000:02:00.0: reg 10 64bit mmio: [0xd4000000-0xd4001fff]
[    1.568129] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.568135] pci 0000:02:00.0: PME# disabled
[    1.568176] pci 0000:00:05.0: bridge 32bit mmio: [0xd4000000-0xd40fffff]
[    1.568765] pci 0000:03:00.0: reg 10 64bit mmio: [0xd3000000-0xd3001fff]
[    1.569539] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.569579] pci 0000:03:00.0: PME# disabled
[    1.569838] pci 0000:00:1c.0: bridge io port: [0x3000-0x3fff]
[    1.569847] pci 0000:00:1c.0: bridge 32bit mmio: [0xd3000000-0xd3ffffff]
[    1.569858] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xd0000000-0xd0ffffff]
[    1.569931] pci 0000:04:00.0: reg 10 64bit mmio: [0xd2000000-0xd203ffff]
[    1.569945] pci 0000:04:00.0: reg 18 io port: [0x2000-0x207f]
[    1.570017] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.570026] pci 0000:04:00.0: PME# disabled
[    1.570086] pci 0000:00:1c.1: bridge io port: [0x2000-0x2fff]
[    1.570095] pci 0000:00:1c.1: bridge 32bit mmio: [0xd2000000-0xd2ffffff]
[    1.570106] pci 0000:00:1c.1: bridge 64bit mmio pref: [0xd1000000-0xd1ffffff]
[    1.570165] pci 0000:00:1e.0: transparent bridge
[    1.570217] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.570508] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    1.570731] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.570869] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.571048] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG3._PRT]
[    1.571185] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG5._PRT]
[    1.571430] _OSC invalid UUID
[    1.584153] ACPI: PCI Root Bridge [CPBG] (0000:ff)
[    1.585205] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.585390] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    1.585569] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    1.585749] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    1.585931] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.586109] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.586288] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    1.586474] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[    1.586620] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.586631] vgaarb: loaded
[    1.586727] SCSI subsystem initialized
[    1.586859] libata version 3.00 loaded.
[    1.586934] usbcore: registered new interface driver usbfs
[    1.586948] usbcore: registered new interface driver hub
[    1.586975] usbcore: registered new device driver usb
[    1.587130] ACPI: WMI: Mapper loaded
[    1.587132] PCI: Using ACPI for IRQ routing
[    1.587437] Bluetooth: Core ver 2.15
[    1.587468] NET: Registered protocol family 31
[    1.587470] Bluetooth: HCI device and connection manager initialized
[    1.587472] Bluetooth: HCI socket layer initialized
[    1.587474] NetLabel: Initializing
[    1.587476] NetLabel:  domain hash size = 128
[    1.587477] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.587490] NetLabel:  unlabeled traffic allowed by default
[    1.587531] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    1.587538] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.596433] hpet: hpet2 irq 24 for MSI
[    1.596592] hpet: hpet3 irq 25 for MSI
[    1.606593] hpet: hpet4 irq 26 for MSI
[    1.616586] hpet: hpet5 irq 27 for MSI
[    1.626489] hpet: hpet6 irq 28 for MSI
[    1.656471] Switching to clocksource tsc
[    1.658121] pnp: PnP ACPI init
[    1.658130] ACPI: bus type pnp registered
[    1.661142]   alloc irq_desc for 23 on node 0
[    1.661144]   alloc kstat_irqs on node 0
[    1.663442] pnp: PnP ACPI: found 12 devices
[    1.663444] ACPI: ACPI bus type pnp unregistered
[    1.663455] system 00:05: ioport range 0x680-0x69f has been reserved
[    1.663458] system 00:05: ioport range 0x800-0x80f has been reserved
[    1.663461] system 00:05: ioport range 0xffff-0xffff has been reserved
[    1.663464] system 00:05: ioport range 0xffff-0xffff has been reserved
[    1.663467] system 00:05: ioport range 0x400-0x47f has been reserved
[    1.663469] system 00:05: ioport range 0x500-0x57f has been reserved
[    1.663472] system 00:05: ioport range 0x164e-0x164f has been reserved
[    1.663475] system 00:05: ioport range 0x380-0x38e has been reserved
[    1.663482] system 00:0a: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    1.663486] system 00:0a: iomem range 0xfed1b000-0xfed1bfff has been reserved
[    1.663489] system 00:0a: iomem range 0xe0000000-0xefffffff has been reserved
[    1.663491] system 00:0a: iomem range 0xfed20000-0xfed3ffff has been reserved
[    1.663495] system 00:0a: iomem range 0xfed45000-0xfed8ffff has been reserved
[    1.663498] system 00:0a: iomem range 0xff000000-0xffffffff could not be reserved
[    1.663501] system 00:0a: iomem range 0xfee00000-0xfeefffff could not be reserved
[    1.663504] system 00:0a: iomem range 0x0-0xfff could not be reserved
[    1.668184] pci 0000:01:00.0: BAR 6: no parent found for of device [0xfffe0000-0xffffffff]
[    1.668341] pci 0000:00:03.0: PCI bridge, secondary bus 0000:01
[    1.668345] pci 0000:00:03.0:   IO window: 0x4000-0x4fff
[    1.668349] pci 0000:00:03.0:   MEM window: 0xd4100000-0xd41fffff
[    1.668353] pci 0000:00:03.0:   PREFETCH window: 0x000000c0000000-0x000000cfffffff
[    1.668359] pci 0000:00:05.0: PCI bridge, secondary bus 0000:02
[    1.668361] pci 0000:00:05.0:   IO window: disabled
[    1.668365] pci 0000:00:05.0:   MEM window: 0xd4000000-0xd40fffff
[    1.668368] pci 0000:00:05.0:   PREFETCH window: disabled
[    1.668373] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:03
[    1.668381] pci 0000:00:1c.0:   IO window: 0x3000-0x3fff
[    1.668391] pci 0000:00:1c.0:   MEM window: 0xd3000000-0xd3ffffff
[    1.668400] pci 0000:00:1c.0:   PREFETCH window: 0x000000d0000000-0x000000d0ffffff
[    1.668411] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:04
[    1.668419] pci 0000:00:1c.1:   IO window: 0x2000-0x2fff
[    1.668428] pci 0000:00:1c.1:   MEM window: 0xd2000000-0xd2ffffff
[    1.668437] pci 0000:00:1c.1:   PREFETCH window: 0x000000d1000000-0x000000d1ffffff
[    1.668448] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    1.668450] pci 0000:00:1e.0:   IO window: disabled
[    1.668459] pci 0000:00:1e.0:   MEM window: disabled
[    1.668467] pci 0000:00:1e.0:   PREFETCH window: disabled
[    1.668484]   alloc irq_desc for 16 on node -1
[    1.668486]   alloc kstat_irqs on node -1
[    1.668491] pci 0000:00:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.668495] pci 0000:00:03.0: setting latency timer to 64
[    1.668502] pci 0000:00:05.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.668506] pci 0000:00:05.0: setting latency timer to 64
[    1.668518]   alloc irq_desc for 17 on node -1
[    1.668519]   alloc kstat_irqs on node -1
[    1.668523] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.668528] pci 0000:00:1c.0: setting latency timer to 64
[    1.668545] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    1.668554] pci 0000:00:1c.1: setting latency timer to 64
[    1.668569] pci 0000:00:1e.0: setting latency timer to 64
[    1.668577] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    1.668580] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    1.668583] pci_bus 0000:01: resource 0 io:  [0x4000-0x4fff]
[    1.668585] pci_bus 0000:01: resource 1 mem: [0xd4100000-0xd41fffff]
[    1.668588] pci_bus 0000:01: resource 2 pref mem [0xc0000000-0xcfffffff]
[    1.668591] pci_bus 0000:02: resource 1 mem: [0xd4000000-0xd40fffff]
[    1.668593] pci_bus 0000:03: resource 0 io:  [0x3000-0x3fff]
[    1.668596] pci_bus 0000:03: resource 1 mem: [0xd3000000-0xd3ffffff]
[    1.668598] pci_bus 0000:03: resource 2 pref mem [0xd0000000-0xd0ffffff]
[    1.668601] pci_bus 0000:04: resource 0 io:  [0x2000-0x2fff]
[    1.668604] pci_bus 0000:04: resource 1 mem: [0xd2000000-0xd2ffffff]
[    1.668606] pci_bus 0000:04: resource 2 pref mem [0xd1000000-0xd1ffffff]
[    1.668609] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    1.668611] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    1.668614] pci_bus 0000:ff: resource 0 io:  [0x00-0xffff]
[    1.668616] pci_bus 0000:ff: resource 1 mem: [0x000000-0xffffffffffffffff]
[    1.668651] NET: Registered protocol family 2
[    1.668902] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.670064] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.673592] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.674020] TCP: Hash tables configured (established 524288 bind 65536)
[    1.674023] TCP reno registered
[    1.674115] NET: Registered protocol family 1
[    1.674168] pci 0000:00:1d.0: EHCI: BIOS handoff
[    1.689158] pci 0000:01:00.0: Boot video device
[    1.691244] pci 0000:02:00.0: xHCI HW did not halt within 2000 usec status = 0x0
[    1.691311] Trying to unpack rootfs image as initramfs...
[    3.455397] Freeing initrd memory: 68440k freed
[    3.466688] Simple Boot Flag at 0x44 set to 0x1
[    3.467248] Scanning for low memory corruption every 60 seconds
[    3.467374] audit: initializing netlink socket (disabled)
[    3.467386] type=2000 audit(1267137905.280:1): initialized
[    3.479762] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.481276] VFS: Disk quotas dquot_6.5.2
[    3.481333] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.481968] fuse init (API version 7.13)
[    3.482052] msgmni has been set to 15990
[    3.482337] alg: No test for stdrng (krng)
[    3.482348] io scheduler noop registered
[    3.482351] io scheduler anticipatory registered
[    3.482353] io scheduler deadline registered
[    3.482400] io scheduler cfq registered (default)
[    3.482535]   alloc irq_desc for 29 on node -1
[    3.482538]   alloc kstat_irqs on node -1
[    3.482546] pcieport 0000:00:03.0: irq 29 for MSI/MSI-X
[    3.482553] pcieport 0000:00:03.0: setting latency timer to 64
[    3.482655]   alloc irq_desc for 30 on node -1
[    3.482657]   alloc kstat_irqs on node -1
[    3.482663] pcieport 0000:00:05.0: irq 30 for MSI/MSI-X
[    3.482669] pcieport 0000:00:05.0: setting latency timer to 64
[    3.482774]   alloc irq_desc for 31 on node -1
[    3.482776]   alloc kstat_irqs on node -1
[    3.482788] pcieport 0000:00:1c.0: irq 31 for MSI/MSI-X
[    3.482800] pcieport 0000:00:1c.0: setting latency timer to 64
[    3.482919]   alloc irq_desc for 32 on node -1
[    3.482921]   alloc kstat_irqs on node -1
[    3.482932] pcieport 0000:00:1c.1: irq 32 for MSI/MSI-X
[    3.482945] pcieport 0000:00:1c.1: setting latency timer to 64
[    3.483180] _OSC invalid UUID
[    3.483183] aer 0000:00:03.0:pcie02: AER service couldn't init device: _OSC failed
[    3.483305] _OSC invalid UUID
[    3.483307] aer 0000:00:05.0:pcie02: AER service couldn't init device: _OSC failed
[    3.483318] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    3.483450] _OSC invalid UUID
[    3.483611] _OSC invalid UUID
[    3.483785] _OSC invalid UUID
[    3.483944] _OSC invalid UUID
[    3.483987] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    3.484498] ACPI: AC Adapter [ACAD] (on-line)
[    3.484580] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    3.484583] ACPI: Power Button [PWRB]
[    3.484623] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    3.484990] ACPI: Lid Switch [LID0]
[    3.485053] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.485056] ACPI: Power Button [PWRF]
[    3.486609] ACPI: SSDT 00000000bf691a98 002DA (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
[    3.487331] ACPI: SSDT 00000000bf690618 005CD (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    3.488062] Monitor-Mwait will be used to enter C-1 state
[    3.488084] Monitor-Mwait will be used to enter C-2 state
[    3.488121] processor LNXCPU:00: registered as cooling_device0
[    3.488774] ACPI: SSDT 00000000bf691718 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    3.489461] ACPI: SSDT 00000000bf68fd98 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    3.490364] processor LNXCPU:01: registered as cooling_device1
[    3.491457] processor LNXCPU:02: registered as cooling_device2
[    3.492542] processor LNXCPU:03: registered as cooling_device3
[    3.493606] processor LNXCPU:04: registered as cooling_device4
[    3.494711] processor LNXCPU:05: registered as cooling_device5
[    3.495798] processor LNXCPU:06: registered as cooling_device6
[    3.496897] processor LNXCPU:07: registered as cooling_device7
[    3.505333] thermal LNXTHERM:01: registered as thermal_zone0
[    3.505341] ACPI: Thermal Zone [TZ01] (61 C)
[    3.506909] Linux agpgart interface v0.103
[    3.506913] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.508392] brd: module loaded
[    3.508989] loop: module loaded
[    3.509055] input: Macintosh mouse button emulation as /devices/virtual/input/input3
[    3.509178] ahci 0000:00:1f.2: version 3.0
[    3.509196]   alloc irq_desc for 19 on node -1
[    3.509198]   alloc kstat_irqs on node -1
[    3.509237] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    3.509274]   alloc irq_desc for 33 on node -1
[    3.509276]   alloc kstat_irqs on node -1
[    3.509288] ahci 0000:00:1f.2: irq 33 for MSI/MSI-X
[    3.509355] ahci: SSS flag set, parallel bus scan disabled
[    3.509393] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x23 impl RAID mode
[    3.509397] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pio slum part ems sxs apst 
[    3.509406] ahci 0000:00:1f.2: setting latency timer to 64
[    3.512416] ACPI: Battery Slot [BAT0] (battery present)
[    3.512789] ACPI: Battery Slot [BAT1] (battery absent)
[    3.546576] scsi0 : ahci
[    3.546650] scsi1 : ahci
[    3.546701] scsi2 : ahci
[    3.546747] scsi3 : ahci
[    3.546791] scsi4 : ahci
[    3.546837] scsi5 : ahci
[    3.547076] ata1: SATA max UDMA/133 abar m2048@0xd4205000 port 0xd4205100 irq 33
[    3.547084] ata2: SATA max UDMA/133 abar m2048@0xd4205000 port 0xd4205180 irq 33
[    3.547087] ata3: DUMMY
[    3.547088] ata4: DUMMY
[    3.547089] ata5: DUMMY
[    3.547095] ata6: SATA max UDMA/133 abar m2048@0xd4205000 port 0xd4205380 irq 33
[    3.547914] Fixed MDIO Bus: probed
[    3.547950] PPP generic driver version 2.4.2
[    3.548023] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.548026] ehci_hcd: block sizes: qh 104 qtd 96 itd 192 sitd 96
[    3.548051]   alloc irq_desc for 20 on node -1
[    3.548053]   alloc kstat_irqs on node -1
[    3.548058] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.548074] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.548082] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.548096] drivers/usb/core/inode.c: creating file 'devices'
[    3.548104] drivers/usb/core/inode.c: creating file '001'
[    3.548127] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    3.548140] ehci_hcd 0000:00:1d.0: reset hcs_params 0x200002 dbg=2 cc=0 pcc=0 ordered !ppc ports=2
[    3.548148] ehci_hcd 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[    3.548182] ehci_hcd 0000:00:1d.0: debug port 2
[    3.548192] ehci_hcd 0000:00:1d.0: reset command 080012 (park)=0 ithresh=8 Periodic period=1024 Reset HALT
[    3.552088] ehci_hcd 0000:00:1d.0: cache line size of 32 is not supported
[    3.552090] ehci_hcd 0000:00:1d.0: supports USB remote wakeup
[    3.552106] ehci_hcd 0000:00:1d.0: irq 20, io mem 0xd4205800
[    3.552115] ehci_hcd 0000:00:1d.0: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    3.556003] ehci_hcd 0000:00:1d.0: init command 010001 (park)=0 ithresh=1 period=1024 RUN
[    3.576461] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.576505] usb usb1: default language 0x0409
[    3.576517] usb usb1: udev 1, busnum 1, minor = 0
[    3.576521] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.576526] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.576532] usb usb1: Product: EHCI Host Controller
[    3.576534] usb usb1: Manufacturer: Linux 2.6.32.8-usb-debug ehci_hcd
[    3.576536] usb usb1: SerialNumber: 0000:00:1d.0
[    3.576573] usb usb1: uevent
[    3.576584] usb usb1: usb_probe_device
[    3.576586] usb usb1: configuration #1 chosen from 1 choice
[    3.576593] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.576606] usb 1-0:1.0: uevent
[    3.576616] hub 1-0:1.0: usb_probe_interface
[    3.576618] hub 1-0:1.0: usb_probe_interface - got id
[    3.576620] hub 1-0:1.0: USB hub found
[    3.576626] hub 1-0:1.0: 2 ports detected
[    3.576628] hub 1-0:1.0: standalone hub
[    3.576630] hub 1-0:1.0: no power switching (usb 1.0)
[    3.576632] hub 1-0:1.0: individual port over-current protection
[    3.576634] hub 1-0:1.0: power on to power good time: 20ms
[    3.576638] hub 1-0:1.0: local power source is good
[    3.576640] hub 1-0:1.0: trying to enable port power on non-switchable hub
[    3.576668] drivers/usb/core/inode.c: creating file '001'
[    3.576700] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.576703] ohci_hcd: block sizes: ed 80 td 96
[    3.576719] uhci_hcd: USB Universal Host Controller Interface driver
[    3.576810] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    3.590044] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.590050] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.590105] mice: PS/2 mouse device common for all mice
[    3.590193] rtc_cmos 00:06: RTC can wake from S4
[    3.590222] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    3.590261] rtc0: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    3.590386] device-mapper: uevent: version 1.0.3
[    3.591411] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    3.591533] device-mapper: multipath: version 1.1.0 loaded
[    3.591536] device-mapper: multipath round-robin: version 1.0.0 loaded
[    3.592029] cpuidle: using governor ladder
[    3.592304] cpuidle: using governor menu
[    3.592703] TCP cubic registered
[    3.592833] NET: Registered protocol family 10
[    3.593314] lo: Disabled Privacy Extensions
[    3.593622] NET: Registered protocol family 17
[    3.593637] Bluetooth: L2CAP ver 2.14
[    3.593639] Bluetooth: L2CAP socket layer initialized
[    3.593642] Bluetooth: SCO (Voice Link) ver 0.6
[    3.593643] Bluetooth: SCO socket layer initialized
[    3.593663] Bluetooth: RFCOMM TTY layer initialized
[    3.593665] Bluetooth: RFCOMM socket layer initialized
[    3.593667] Bluetooth: RFCOMM ver 1.11
[    3.593697] ------------[ cut here ]------------
[    3.593703] WARNING: at arch/x86/kernel/hpet.c:392 hpet_next_event+0x75/0x90()
[    3.593705] Hardware name: HP ENVY 15 Notebook PC
[    3.593707] Modules linked in:
[    3.593710] Pid: 0, comm: swapper Not tainted 2.6.32.8-usb-debug #1
[    3.593712] Call Trace:
[    3.593717]  [<ffffffff810601c8>] warn_slowpath_common+0x78/0xb0
[    3.593721]  [<ffffffff8106020f>] warn_slowpath_null+0xf/0x20
[    3.593724]  [<ffffffff810344a5>] hpet_next_event+0x75/0x90
[    3.593727]  [<ffffffff810344eb>] hpet_legacy_next_event+0xb/0x10
[    3.593732]  [<ffffffff8108a9cf>] clockevents_program_event+0x4f/0x90
[    3.593736]  [<ffffffff8108bdf0>] tick_dev_program_event+0x40/0xd0
[    3.593739]  [<ffffffff8108b796>] tick_broadcast_oneshot_control+0x116/0x120
[    3.593743]  [<ffffffff8108b015>] tick_notify+0x335/0x410
[    3.593747]  [<ffffffff81036449>] ? default_spin_lock_flags+0x9/0x10
[    3.593807]  [<ffffffff81543bb7>] notifier_call_chain+0x47/0x90
[    3.593812]  [<ffffffff810824f1>] raw_notifier_call_chain+0x11/0x20
[    3.593815]  [<ffffffff8108a802>] clockevents_notify+0x32/0x150
[    3.593820]  [<ffffffff812e93a9>] lapic_timer_state_broadcast+0x41/0x43
[    3.593824]  [<ffffffff812e9abe>] acpi_idle_enter_simple+0x91/0x13b
[    3.593828]  [<ffffffff8141dad5>] ? menu_select+0x105/0x2b0
[    3.593833]  [<ffffffff8141cabf>] cpuidle_idle_call+0x9f/0x130
[    3.593837]  [<ffffffff81010e4b>] cpu_idle+0xab/0x100
[    3.593841]  [<ffffffff8153a7e3>] start_secondary+0x18d/0x192
[    3.593847] ---[ end trace 27507780c8f5b248 ]---
[    3.597137] PM: Resume from disk failed.
[    3.597143] registered taskstats version 1
[    3.597645]   Magic number: 14:424:806
[    3.597788] rtc_cmos 00:06: setting system clock to 2010-02-25 22:45:06 UTC (1267137906)
[    3.597795] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    3.597797] EDD information not available.
[    3.611872] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    3.676451] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
[    3.676461] hub 1-0:1.0: port 1: status 0501 change 0001
[    3.774531] hub 1-0:1.0: state 7 ports 2 chg 0002 evt 0000
[    3.774548] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    3.834774] ehci_hcd 0000:00:1d.0: port 1 high speed
[    3.834777] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005 POWER sig=se0 PE CONNECT
[    3.894382] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.894395] usb 1-1: new high speed USB device using ehci_hcd and address 2
[    3.894743] ata1.00: ATA-7: INTEL SSDSA1M160G2HP, 2CV102HA, max UDMA/100
[    3.894746] ata1.00: 312581808 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    3.895431] ata1.00: configured for UDMA/100
[    3.914471] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA1M160 2CV1 PQ: 0 ANSI: 5
[    3.914560] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.914706] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    3.914741] sd 0:0:0:0: [sda] Write Protect is off
[    3.914742] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.914755] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.914823]  sda: sda1 sda2 sda3 sda4
[    3.915572] sda: p2 size 408211650 exceeds device capacity, limited to end of disk
[    3.915614] sda: p3 ignored, start 453065130 is behind the end of the disk
[    3.915616] sda: p4 ignored, start 441803565 is behind the end of the disk
[    3.915785] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.954533] ehci_hcd 0000:00:1d.0: port 1 high speed
[    3.954536] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005 POWER sig=se0 PE CONNECT
[    4.046391] usb 1-1: udev 2, busnum 1, minor = 1
[    4.046396] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    4.046401] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.046471] usb 1-1: uevent
[    4.046491] usb 1-1: usb_probe_device
[    4.046496] usb 1-1: configuration #1 chosen from 1 choice
[    4.046621] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[    4.046650] usb 1-1:1.0: uevent
[    4.046671] hub 1-1:1.0: usb_probe_interface
[    4.046675] hub 1-1:1.0: usb_probe_interface - got id
[    4.046679] hub 1-1:1.0: USB hub found
[    4.046882] hub 1-1:1.0: 8 ports detected
[    4.046886] hub 1-1:1.0: standalone hub
[    4.046889] hub 1-1:1.0: individual port power switching
[    4.046892] hub 1-1:1.0: individual port over-current protection
[    4.046896] hub 1-1:1.0: Single TT
[    4.046900] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    4.046903] hub 1-1:1.0: Port indicators are supported
[    4.046907] hub 1-1:1.0: power on to power good time: 100ms
[    4.047255] hub 1-1:1.0: local power source is good
[    4.047261] hub 1-1:1.0: enabling power on all ports
[    4.048283] drivers/usb/core/inode.c: creating file '002'
[    4.144787] hub 1-1:1.0: port 5: status 0101 change 0001
[    4.145044] hub 1-1:1.0: port 6: status 0101 change 0001
[    4.243973] usb 1-1: link qh256-0001/ffff880227ceee80 start 1 [1/0 us]
[    4.243993] hub 1-1:1.0: state 7 ports 8 chg 0060 evt 0000
[    4.244248] hub 1-1:1.0: port 5, status 0101, change 0000, 12 Mb/s
[    4.324182] usb 1-1.5: new high speed USB device using ehci_hcd and address 3
[    4.438448] usb 1-1.5: skipped 1 descriptor after configuration
[    4.438454] usb 1-1.5: skipped 5 descriptors after interface
[    4.438460] usb 1-1.5: skipped 1 descriptor after endpoint
[    4.438465] usb 1-1.5: skipped 8 descriptors after interface
[    4.438693] usb 1-1.5: default language 0x0409
[    4.439817] usb 1-1.5: udev 3, busnum 1, minor = 2
[    4.439823] usb 1-1.5: New USB device found, idVendor=04f2, idProduct=b16c
[    4.439828] usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.439833] usb 1-1.5: Product: HP Webcam
[    4.439837] usb 1-1.5: Manufacturer: Chicony Electronics Co., Ltd.
[    4.439911] usb 1-1.5: uevent
[    4.439931] usb 1-1.5: usb_probe_device
[    4.439936] usb 1-1.5: configuration #1 chosen from 1 choice
[    4.440208] usb 1-1.5: adding 1-1.5:1.0 (config #1, interface 0)
[    4.440699] usb 1-1.5:1.0: uevent
[    4.440741] usb 1-1.5: adding 1-1.5:1.1 (config #1, interface 1)
[    4.440777] usb 1-1.5:1.1: uevent
[    4.440795] drivers/usb/core/inode.c: creating file '003'
[    4.441077] hub 1-1:1.0: port 6, status 0101, change 0000, 12 Mb/s
[    4.513863] usb 1-1.6: new full speed USB device using ehci_hcd and address 4
[    4.628529] usb 1-1.6: skipped 1 descriptor after interface
[    4.628887] usb 1-1.6: default language 0x0409
[    4.629638] usb 1-1.6: udev 4, busnum 1, minor = 3
[    4.629644] usb 1-1.6: New USB device found, idVendor=03f0, idProduct=231d
[    4.629650] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.629655] usb 1-1.6: Product: HP Integrated Module
[    4.629658] usb 1-1.6: Manufacturer: Broadcom Corp
[    4.629733] usb 1-1.6: uevent
[    4.629753] usb 1-1.6: usb_probe_device
[    4.629758] usb 1-1.6: configuration #1 chosen from 1 choice
[    4.630024] usb 1-1.6: adding 1-1.6:1.0 (config #1, interface 0)
[    4.630058] usb 1-1.6:1.0: uevent
[    4.630130] usb 1-1.6: adding 1-1.6:1.1 (config #1, interface 1)
[    4.630151] usb 1-1.6:1.1: uevent
[    4.630166] usb 1-1.6: adding 1-1.6:1.2 (config #1, interface 2)
[    4.630175] usb 1-1.6:1.2: uevent
[    4.630189] usb 1-1.6: adding 1-1.6:1.3 (config #1, interface 3)
[    4.630197] usb 1-1.6:1.3: uevent
[    4.630202] drivers/usb/core/inode.c: creating file '004'
[    4.630213] hub 1-1:1.0: state 7 ports 8 chg 0000 evt 0040
[    4.663562] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.663919] ata2.00: ATA-7: INTEL SSDSA1M160G2HP, 2CV102HA, max UDMA/100
[    4.663927] ata2.00: 312581808 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    4.664628] ata2.00: configured for UDMA/100
[    4.683569] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSA1M160 2CV1 PQ: 0 ANSI: 5
[    4.683657] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    4.683661] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    4.683733] sd 1:0:0:0: [sdb] Write Protect is off
[    4.683736] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.683765] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.683839]  sdb: unknown partition table
[    4.685085] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.033129] ata6: SATA link down (SStatus 0 SControl 300)
[    5.053290] Freeing unused kernel memory: 692k freed
[    5.053398] Write protecting the kernel read-only data: 7732k
[    5.121902] usb usb1: uevent
[    5.121920] usb 1-0:1.0: uevent
[    5.121949] usb 1-1: uevent
[    5.121975] usb 1-1.5: uevent
[    5.122000] usb 1-1.5:1.0: uevent
[    5.122021] usb 1-1.5:1.1: uevent
[    5.122040] usb 1-1.6: uevent
[    5.122064] usb 1-1.6:1.0: uevent
[    5.122089] usb 1-1.6:1.1: uevent
[    5.122114] usb 1-1.6:1.2: uevent
[    5.122140] usb 1-1.6:1.3: uevent
[    5.122166] usb 1-1:1.0: uevent
[    5.132844] usb usb1: uevent
[    5.149090] usb 1-1: uevent
[    5.155922] usb 1-1.5: uevent
[    5.155995] usb 1-1.6: uevent
[    5.163862] acpi device:23: registered as cooling_device8
[    5.178952] acpi device:25: registered as cooling_device9
[    5.179102] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:21/LNXVIDEO:01/input/input5
[    5.179132] ACPI: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
[    6.775462] PM: Starting manual resume from disk
[    6.775465] PM: Resume from partition 252:2
[    6.775466] PM: Checking hibernation image.
[    6.775652] PM: Error -22 checking image file
[    6.775654] PM: Resume from disk failed.
[    6.790646] EXT4-fs (dm-3): mounted filesystem with ordered data mode
[    6.961771] Adding 16795916k swap on /dev/mapper/isw_cdfcbdcfed_RAID-01.  Priority:-1 extents:1 across:16795916k 
[    7.010004] udev: starting version 147
[    7.026844] usb usb1: uevent
[    7.026871] usb 1-0:1.0: uevent
[    7.026902] usb 1-1: uevent
[    7.026930] usb 1-1.5: uevent
[    7.026957] usb 1-1.5:1.0: uevent
[    7.026985] usb 1-1.5:1.1: uevent
[    7.027016] usb 1-1.6: uevent
[    7.027043] usb 1-1.6:1.0: uevent
[    7.027071] usb 1-1.6:1.1: uevent
[    7.027098] usb 1-1.6:1.2: uevent
[    7.027125] usb 1-1.6:1.3: uevent
[    7.027151] usb 1-1:1.0: uevent
[    7.035923] usb usb1: uevent
[    7.046779] usb 1-1: uevent
[    7.054996] usb 1-1.5: uevent
[    7.059805] usb 1-1.6: uevent
[    7.092567] fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[    7.092573] Disabling lock debugging due to kernel taint
[    7.201187] [fglrx] Maximum main memory to use for locked dma buffers: 7762 MBytes.
[    7.201520] [fglrx]   vendor: 1002 device: 68a1 count: 1
[    7.202093] [fglrx] ioport: bar 4, base 0x4000, size: 0x100
[    7.202131] pci 0000:01:00.0: power state changed by ACPI to D0
[    7.202142] pci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    7.202149] pci 0000:01:00.0: setting latency timer to 64
[    7.202379] [fglrx] Kernel PAT support is enabled
[    7.202399] [fglrx] module loaded - fglrx 8.70.3 [Feb  2 2010] with 1 minors
[    7.242181] cfg80211: Calling CRDA to update world regulatory domain
[    7.253362] atl1c 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    7.253378] atl1c 0000:04:00.0: setting latency timer to 64
[    7.259963] cfg80211: World regulatory domain updated:
[    7.259966] 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[    7.259969] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    7.259972] 	(2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[    7.259975] 	(2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[    7.259978] 	(5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    7.259980] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    7.262099] xhci_hcd 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    7.262165] xhci_hcd 0000:02:00.0: setting latency timer to 64
[    7.262169] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    7.262179] drivers/usb/core/inode.c: creating file '002'
[    7.262233] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    7.262246] xhci_hcd 0000:02:00.0: xHCI capability registers at ffffc90011790000:
[    7.262251] xhci_hcd 0000:02:00.0: CAPLENGTH AND HCIVERSION 0x960020:
[    7.262254] xhci_hcd 0000:02:00.0: CAPLENGTH: 0x20
[    7.262257] xhci_hcd 0000:02:00.0: HCIVERSION: 0x96
[    7.262260] xhci_hcd 0000:02:00.0: HCSPARAMS 1: 0x4000820
[    7.262263] xhci_hcd 0000:02:00.0:   Max device slots: 32
[    7.262266] xhci_hcd 0000:02:00.0:   Max interrupters: 8
[    7.262268] xhci_hcd 0000:02:00.0:   Max ports: 4
[    7.262272] xhci_hcd 0000:02:00.0: HCSPARAMS 2: 0x11
[    7.262274] xhci_hcd 0000:02:00.0:   Isoc scheduling threshold: 1
[    7.262277] xhci_hcd 0000:02:00.0:   Maximum allowed segments in event ring: 1
[    7.262281] xhci_hcd 0000:02:00.0: HCSPARAMS 3 0x0:
[    7.262283] xhci_hcd 0000:02:00.0:   Worst case U1 device exit latency: 0
[    7.262285] xhci_hcd 0000:02:00.0:   Worst case U2 device exit latency: 0
[    7.262288] xhci_hcd 0000:02:00.0: HCC PARAMS 0x14042cb:
[    7.262290] xhci_hcd 0000:02:00.0:   HC generates 64 bit addresses
[    7.262292] xhci_hcd 0000:02:00.0:   FIXME: more HCCPARAMS debugging
[    7.262295] xhci_hcd 0000:02:00.0: RTSOFF 0x600:
[    7.262297] xhci_hcd 0000:02:00.0: xHCI operational registers at ffffc90011790020:
[    7.262301] xhci_hcd 0000:02:00.0: USBCMD 0x0:
[    7.262303] xhci_hcd 0000:02:00.0:   HC is being stopped
[    7.262304] xhci_hcd 0000:02:00.0:   HC has finished hard reset
[    7.262307] xhci_hcd 0000:02:00.0:   Event Interrupts disabled
[    7.262309] xhci_hcd 0000:02:00.0:   Host System Error Interrupts disabled
[    7.262311] xhci_hcd 0000:02:00.0:   HC has finished light reset
[    7.262314] xhci_hcd 0000:02:00.0: USBSTS 0x1:
[    7.262316] xhci_hcd 0000:02:00.0:   Event ring is empty
[    7.262318] xhci_hcd 0000:02:00.0:   No Host System Error
[    7.262320] xhci_hcd 0000:02:00.0:   HC is halted
[    7.262323] xhci_hcd 0000:02:00.0: ffffc90011790420 port status reg = 0x2a0
[    7.262327] xhci_hcd 0000:02:00.0: ffffc90011790424 port power reg = 0x0
[    7.262330] xhci_hcd 0000:02:00.0: ffffc90011790428 port link reg = 0x0
[    7.262334] xhci_hcd 0000:02:00.0: ffffc9001179042c port reserved reg = 0x0
[    7.262337] xhci_hcd 0000:02:00.0: ffffc90011790430 port status reg = 0x2a0
[    7.262341] xhci_hcd 0000:02:00.0: ffffc90011790434 port power reg = 0x0
[    7.262344] xhci_hcd 0000:02:00.0: ffffc90011790438 port link reg = 0x0
[    7.262348] xhci_hcd 0000:02:00.0: ffffc9001179043c port reserved reg = 0x0
[    7.262351] xhci_hcd 0000:02:00.0: ffffc90011790440 port status reg = 0x2a0
[    7.262354] xhci_hcd 0000:02:00.0: ffffc90011790444 port power reg = 0x0
[    7.262358] xhci_hcd 0000:02:00.0: ffffc90011790448 port link reg = 0x0
[    7.262361] xhci_hcd 0000:02:00.0: ffffc9001179044c port reserved reg = 0x0
[    7.262364] xhci_hcd 0000:02:00.0: ffffc90011790450 port status reg = 0x2a0
[    7.262368] xhci_hcd 0000:02:00.0: ffffc90011790454 port power reg = 0x0
[    7.262371] xhci_hcd 0000:02:00.0: ffffc90011790458 port link reg = 0x0
[    7.262374] xhci_hcd 0000:02:00.0: ffffc9001179045c port reserved reg = 0x0
[    7.262376] xhci_hcd 0000:02:00.0: // Halt the HC
[    7.262380] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790020, 32'h0, 4'hf);
[    7.262384] xhci_hcd 0000:02:00.0: Resetting HCD
[    7.262387] xhci_hcd 0000:02:00.0: // Reset the HC
[    7.262390] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790020, 32'h2, 4'hf);
[    7.262432] xhci_hcd 0000:02:00.0: Reset complete
[    7.262434] xhci_hcd 0000:02:00.0: Calling HCD init
[    7.262436] xhci_hcd 0000:02:00.0: xhci_init
[    7.262438] xhci_hcd 0000:02:00.0: xHCI doesn't need link TRB QUIRK
[    7.262441] xhci_hcd 0000:02:00.0: Supported page size register = 0x1
[    7.262443] xhci_hcd 0000:02:00.0: Supported page size of 4K
[    7.262445] xhci_hcd 0000:02:00.0: HCD page size set to 4K
[    7.262448] xhci_hcd 0000:02:00.0: // xHC can handle at most 32 device slots.
[    7.262451] xhci_hcd 0000:02:00.0: // Setting Max device slots reg = 0x20.
[    7.262454] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790058, 32'h20, 4'hf);
[    7.262487] xhci_hcd 0000:02:00.0: // Device context base array address = 0x37804000 (DMA), ffff880037804000 (virt)
[    7.262493] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 64'hffffc90011790050, 64'h37804000, 4'hf);
[    7.262500] xhci_hcd 0000:02:00.0: Allocating ring at ffff8802279fc480
[    7.262505] xhci_hcd 0000:02:00.0: Allocating priv segment structure at ffff8802327cc7c0
[    7.262534] xhci_hcd 0000:02:00.0: // Allocating segment at ffff880037805000 (virtual) 0x37805000 (DMA)
[    7.262541] xhci_hcd 0000:02:00.0: Linking segment 0x37805000 to segment 0x37805000 (DMA)
[    7.262546] xhci_hcd 0000:02:00.0: Wrote link toggle flag to segment ffff8802327cc7c0 (virtual), 0x37805000 (DMA)
[    7.262552] xhci_hcd 0000:02:00.0: Allocated command ring at ffff8802279fc480
[    7.262564] xhci_hcd 0000:02:00.0: First segment DMA is 0x37805000
[    7.262570] xhci_hcd 0000:02:00.0: // Setting command ring address to 0x20
[    7.262575] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 64'hffffc90011790038, 64'h37805001, 4'hf);
[    7.262583] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    7.262588] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr high bits = @00000000
[    7.262594] xhci_hcd 0000:02:00.0: // Doorbell array is located at offset 0x800 from cap regs base addr
[    7.262600] xhci_hcd 0000:02:00.0: // xHCI capability registers at ffffc90011790000:
[    7.262628] xhci_hcd 0000:02:00.0: // @ffffc90011790000 = 0x960020 (CAPLENGTH AND HCIVERSION)
[    7.262632] xhci_hcd 0000:02:00.0: //   CAPLENGTH: 0x20
[    7.262636] xhci_hcd 0000:02:00.0: // xHCI operational registers at ffffc90011790020:
[    7.262642] xhci_hcd 0000:02:00.0: // @ffffc90011790018 = 0x600 RTSOFF
[    7.262646] xhci_hcd 0000:02:00.0: // xHCI runtime registers at ffffc90011790600:
[    7.262652] xhci_hcd 0000:02:00.0: // @ffffc90011790014 = 0x800 DBOFF
[    7.262656] xhci_hcd 0000:02:00.0: // Doorbell array at ffffc90011790800:
[    7.262660] xhci_hcd 0000:02:00.0: xHCI runtime registers at ffffc90011790600:
[    7.262679] xhci_hcd 0000:02:00.0:   ffffc90011790600: Microframe index = 0x0
[    7.262690] xhci_hcd 0000:02:00.0: // Allocating event ring
[    7.262694] xhci_hcd 0000:02:00.0: Allocating ring at ffff8802279fcb40
[    7.262698] xhci_hcd 0000:02:00.0: Allocating priv segment structure at ffff8802327cc7e0
[    7.262704] xhci_hcd 0000:02:00.0: // Allocating segment at ffff880037805400 (virtual) 0x37805400 (DMA)
[    7.262710] xhci_hcd 0000:02:00.0: Linking segment 0x37805400 to segment 0x37805400 (DMA)
[    7.262716] xhci_hcd 0000:02:00.0: // Allocated event ring segment table at 0x37806000
[    7.262721] xhci_hcd 0000:02:00.0: Set ERST to 0; private num segs = 1, virt addr = ffff880037806000, dma addr = 0x37806000
[    7.262728] xhci_hcd 0000:02:00.0: // Write ERST size = 1 to ir_set 0 (some bits preserved)
[    7.262733] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790628, 32'h1, 4'hf);
[    7.262738] xhci_hcd 0000:02:00.0: // Set ERST entries to point to event ring.
[    7.262743] xhci_hcd 0000:02:00.0: // Set ERST base address for ir_set 0 = 0x37806000
[    7.262750] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 64'hffffc90011790630, 64'h37806000, 4'hf);
[    7.262758] xhci_hcd 0000:02:00.0: // Write event ring dequeue pointer, preserving EHB bit
[    7.262763] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 64'hffffc90011790638, 64'h37805400, 4'hf);
[    7.262769] xhci_hcd 0000:02:00.0: Wrote ERST address to ir_set 0.
[    7.262786] xhci_hcd 0000:02:00.0: Allocating 0 scratchpad buffers
[    7.262789] xhci_hcd 0000:02:00.0: Finished xhci_init
[    7.262793] xhci_hcd 0000:02:00.0: Called HCD init
[    7.262830] xhci_hcd 0000:02:00.0: Got SBRN 48
[    7.262837] xhci_hcd 0000:02:00.0: MWI active
[    7.262840] xhci_hcd 0000:02:00.0: Finished xhci_pci_reinit
[    7.262845] xhci_hcd 0000:02:00.0: supports USB remote wakeup
[    7.262862] xhci_hcd 0000:02:00.0: irq 16, io mem 0xd4000000
[    7.262866] xhci_hcd 0000:02:00.0: xhci_run
[    7.262869] xhci_hcd 0000:02:00.0: Setting event ring polling timer
[    7.262889] xhci_hcd 0000:02:00.0: Command ring memory map follows:
[    7.262894] xhci_hcd 0000:02:00.0: @37805000 00000000 00000000 00000000 00000000
[    7.262899] xhci_hcd 0000:02:00.0: @37805010 00000000 00000000 00000000 00000000
[    7.262904] xhci_hcd 0000:02:00.0: @37805020 00000000 00000000 00000000 00000000
[    7.262909] xhci_hcd 0000:02:00.0: @37805030 00000000 00000000 00000000 00000000
[    7.262913] xhci_hcd 0000:02:00.0: @37805040 00000000 00000000 00000000 00000000
[    7.262918] xhci_hcd 0000:02:00.0: @37805050 00000000 00000000 00000000 00000000
[    7.262922] xhci_hcd 0000:02:00.0: @37805060 00000000 00000000 00000000 00000000
[    7.262927] xhci_hcd 0000:02:00.0: @37805070 00000000 00000000 00000000 00000000
[    7.262932] xhci_hcd 0000:02:00.0: @37805080 00000000 00000000 00000000 00000000
[    7.262953] xhci_hcd 0000:02:00.0: @37805090 00000000 00000000 00000000 00000000
[    7.262958] xhci_hcd 0000:02:00.0: @378050a0 00000000 00000000 00000000 00000000
[    7.262963] xhci_hcd 0000:02:00.0: @378050b0 00000000 00000000 00000000 00000000
[    7.262967] xhci_hcd 0000:02:00.0: @378050c0 00000000 00000000 00000000 00000000
[    7.262971] xhci_hcd 0000:02:00.0: @378050d0 00000000 00000000 00000000 00000000
[    7.262976] xhci_hcd 0000:02:00.0: @378050e0 00000000 00000000 00000000 00000000
[    7.262981] xhci_hcd 0000:02:00.0: @378050f0 00000000 00000000 00000000 00000000
[    7.262986] xhci_hcd 0000:02:00.0: @37805100 00000000 00000000 00000000 00000000
[    7.262990] xhci_hcd 0000:02:00.0: @37805110 00000000 00000000 00000000 00000000
[    7.262994] xhci_hcd 0000:02:00.0: @37805120 00000000 00000000 00000000 00000000
[    7.263000] xhci_hcd 0000:02:00.0: @37805130 00000000 00000000 00000000 00000000
[    7.263005] xhci_hcd 0000:02:00.0: @37805140 00000000 00000000 00000000 00000000
[    7.263009] xhci_hcd 0000:02:00.0: @37805150 00000000 00000000 00000000 00000000
[    7.263014] xhci_hcd 0000:02:00.0: @37805160 00000000 00000000 00000000 00000000
[    7.263019] xhci_hcd 0000:02:00.0: @37805170 00000000 00000000 00000000 00000000
[    7.263023] xhci_hcd 0000:02:00.0: @37805180 00000000 00000000 00000000 00000000
[    7.263028] xhci_hcd 0000:02:00.0: @37805190 00000000 00000000 00000000 00000000
[    7.263032] xhci_hcd 0000:02:00.0: @378051a0 00000000 00000000 00000000 00000000
[    7.263037] xhci_hcd 0000:02:00.0: @378051b0 00000000 00000000 00000000 00000000
[    7.263041] xhci_hcd 0000:02:00.0: @378051c0 00000000 00000000 00000000 00000000
[    7.263046] xhci_hcd 0000:02:00.0: @378051d0 00000000 00000000 00000000 00000000
[    7.263051] xhci_hcd 0000:02:00.0: @378051e0 00000000 00000000 00000000 00000000
[    7.263056] xhci_hcd 0000:02:00.0: @378051f0 00000000 00000000 00000000 00000000
[    7.263060] xhci_hcd 0000:02:00.0: @37805200 00000000 00000000 00000000 00000000
[    7.263065] xhci_hcd 0000:02:00.0: @37805210 00000000 00000000 00000000 00000000
[    7.263069] xhci_hcd 0000:02:00.0: @37805220 00000000 00000000 00000000 00000000
[    7.263075] xhci_hcd 0000:02:00.0: @37805230 00000000 00000000 00000000 00000000
[    7.263080] xhci_hcd 0000:02:00.0: @37805240 00000000 00000000 00000000 00000000
[    7.263084] xhci_hcd 0000:02:00.0: @37805250 00000000 00000000 00000000 00000000
[    7.263090] xhci_hcd 0000:02:00.0: @37805260 00000000 00000000 00000000 00000000
[    7.263094] xhci_hcd 0000:02:00.0: @37805270 00000000 00000000 00000000 00000000
[    7.263099] xhci_hcd 0000:02:00.0: @37805280 00000000 00000000 00000000 00000000
[    7.263104] xhci_hcd 0000:02:00.0: @37805290 00000000 00000000 00000000 00000000
[    7.263109] xhci_hcd 0000:02:00.0: @378052a0 00000000 00000000 00000000 00000000
[    7.263113] xhci_hcd 0000:02:00.0: @378052b0 00000000 00000000 00000000 00000000
[    7.263118] xhci_hcd 0000:02:00.0: @378052c0 00000000 00000000 00000000 00000000
[    7.263123] xhci_hcd 0000:02:00.0: @378052d0 00000000 00000000 00000000 00000000
[    7.263129] xhci_hcd 0000:02:00.0: @378052e0 00000000 00000000 00000000 00000000
[    7.263133] xhci_hcd 0000:02:00.0: @378052f0 00000000 00000000 00000000 00000000
[    7.263138] xhci_hcd 0000:02:00.0: @37805300 00000000 00000000 00000000 00000000
[    7.263143] xhci_hcd 0000:02:00.0: @37805310 00000000 00000000 00000000 00000000
[    7.263148] xhci_hcd 0000:02:00.0: @37805320 00000000 00000000 00000000 00000000
[    7.263153] xhci_hcd 0000:02:00.0: @37805330 00000000 00000000 00000000 00000000
[    7.263158] xhci_hcd 0000:02:00.0: @37805340 00000000 00000000 00000000 00000000
[    7.263163] xhci_hcd 0000:02:00.0: @37805350 00000000 00000000 00000000 00000000
[    7.263168] xhci_hcd 0000:02:00.0: @37805360 00000000 00000000 00000000 00000000
[    7.263172] xhci_hcd 0000:02:00.0: @37805370 00000000 00000000 00000000 00000000
[    7.263177] xhci_hcd 0000:02:00.0: @37805380 00000000 00000000 00000000 00000000
[    7.263182] xhci_hcd 0000:02:00.0: @37805390 00000000 00000000 00000000 00000000
[    7.263187] xhci_hcd 0000:02:00.0: @378053a0 00000000 00000000 00000000 00000000
[    7.263191] xhci_hcd 0000:02:00.0: @378053b0 00000000 00000000 00000000 00000000
[    7.263196] xhci_hcd 0000:02:00.0: @378053c0 00000000 00000000 00000000 00000000
[    7.263201] xhci_hcd 0000:02:00.0: @378053d0 00000000 00000000 00000000 00000000
[    7.263205] xhci_hcd 0000:02:00.0: @378053e0 00000000 00000000 00000000 00000000
[    7.263210] xhci_hcd 0000:02:00.0: @378053f0 37805000 00000000 00000000 00001802
[    7.263215] xhci_hcd 0000:02:00.0:   Ring has not been updated
[    7.263220] xhci_hcd 0000:02:00.0: Ring deq = ffff880037805000 (virt), 0x37805000 (dma)
[    7.263224] xhci_hcd 0000:02:00.0: Ring deq updated 0 times
[    7.263228] xhci_hcd 0000:02:00.0: Ring enq = ffff880037805000 (virt), 0x37805000 (dma)
[    7.263233] xhci_hcd 0000:02:00.0: Ring enq updated 0 times
[    7.263238] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    7.263243] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr high bits = @00000000
[    7.263247] xhci_hcd 0000:02:00.0: ERST memory map follows:
[    7.263251] xhci_hcd 0000:02:00.0: @37806000 37805400 00000000 00000040 00000000
[    7.263256] xhci_hcd 0000:02:00.0: Event ring:
[    7.263259] xhci_hcd 0000:02:00.0: @37805400 00000000 00000000 00000000 00000000
[    7.263304] xhci_hcd 0000:02:00.0: @37805410 00000000 00000000 00000000 00000000
[    7.263309] xhci_hcd 0000:02:00.0: @37805420 00000000 00000000 00000000 00000000
[    7.263314] xhci_hcd 0000:02:00.0: @37805430 00000000 00000000 00000000 00000000
[    7.263319] xhci_hcd 0000:02:00.0: @37805440 00000000 00000000 00000000 00000000
[    7.263323] xhci_hcd 0000:02:00.0: @37805450 00000000 00000000 00000000 00000000
[    7.263329] xhci_hcd 0000:02:00.0: @37805460 00000000 00000000 00000000 00000000
[    7.263333] xhci_hcd 0000:02:00.0: @37805470 00000000 00000000 00000000 00000000
[    7.263339] xhci_hcd 0000:02:00.0: @37805480 00000000 00000000 00000000 00000000
[    7.263344] xhci_hcd 0000:02:00.0: @37805490 00000000 00000000 00000000 00000000
[    7.263349] xhci_hcd 0000:02:00.0: @378054a0 00000000 00000000 00000000 00000000
[    7.263354] xhci_hcd 0000:02:00.0: @378054b0 00000000 00000000 00000000 00000000
[    7.263359] xhci_hcd 0000:02:00.0: @378054c0 00000000 00000000 00000000 00000000
[    7.263364] xhci_hcd 0000:02:00.0: @378054d0 00000000 00000000 00000000 00000000
[    7.263369] xhci_hcd 0000:02:00.0: @378054e0 00000000 00000000 00000000 00000000
[    7.263374] xhci_hcd 0000:02:00.0: @378054f0 00000000 00000000 00000000 00000000
[    7.263379] xhci_hcd 0000:02:00.0: @37805500 00000000 00000000 00000000 00000000
[    7.263384] xhci_hcd 0000:02:00.0: @37805510 00000000 00000000 00000000 00000000
[    7.263389] xhci_hcd 0000:02:00.0: @37805520 00000000 00000000 00000000 00000000
[    7.263394] xhci_hcd 0000:02:00.0: @37805530 00000000 00000000 00000000 00000000
[    7.263399] xhci_hcd 0000:02:00.0: @37805540 00000000 00000000 00000000 00000000
[    7.263404] xhci_hcd 0000:02:00.0: @37805550 00000000 00000000 00000000 00000000
[    7.263408] xhci_hcd 0000:02:00.0: @37805560 00000000 00000000 00000000 00000000
[    7.263413] xhci_hcd 0000:02:00.0: @37805570 00000000 00000000 00000000 00000000
[    7.263418] xhci_hcd 0000:02:00.0: @37805580 00000000 00000000 00000000 00000000
[    7.263446] xhci_hcd 0000:02:00.0: @37805590 00000000 00000000 00000000 00000000
[    7.263451] xhci_hcd 0000:02:00.0: @378055a0 00000000 00000000 00000000 00000000
[    7.263456] xhci_hcd 0000:02:00.0: @378055b0 00000000 00000000 00000000 00000000
[    7.263461] xhci_hcd 0000:02:00.0: @378055c0 00000000 00000000 00000000 00000000
[    7.263466] xhci_hcd 0000:02:00.0: @378055d0 00000000 00000000 00000000 00000000
[    7.263471] xhci_hcd 0000:02:00.0: @378055e0 00000000 00000000 00000000 00000000
[    7.263475] xhci_hcd 0000:02:00.0: @378055f0 00000000 00000000 00000000 00000000
[    7.263495] xhci_hcd 0000:02:00.0: @37805600 00000000 00000000 00000000 00000000
[    7.263500] xhci_hcd 0000:02:00.0: @37805610 00000000 00000000 00000000 00000000
[    7.263505] xhci_hcd 0000:02:00.0: @37805620 00000000 00000000 00000000 00000000
[    7.263509] xhci_hcd 0000:02:00.0: @37805630 00000000 00000000 00000000 00000000
[    7.263514] xhci_hcd 0000:02:00.0: @37805640 00000000 00000000 00000000 00000000
[    7.263519] xhci_hcd 0000:02:00.0: @37805650 00000000 00000000 00000000 00000000
[    7.263524] xhci_hcd 0000:02:00.0: @37805660 00000000 00000000 00000000 00000000
[    7.263529] xhci_hcd 0000:02:00.0: @37805670 00000000 00000000 00000000 00000000
[    7.263549] xhci_hcd 0000:02:00.0: @37805680 00000000 00000000 00000000 00000000
[    7.263554] xhci_hcd 0000:02:00.0: @37805690 00000000 00000000 00000000 00000000
[    7.263559] xhci_hcd 0000:02:00.0: @378056a0 00000000 00000000 00000000 00000000
[    7.263563] xhci_hcd 0000:02:00.0: @378056b0 00000000 00000000 00000000 00000000
[    7.263568] xhci_hcd 0000:02:00.0: @378056c0 00000000 00000000 00000000 00000000
[    7.263573] xhci_hcd 0000:02:00.0: @378056d0 00000000 00000000 00000000 00000000
[    7.263578] xhci_hcd 0000:02:00.0: @378056e0 00000000 00000000 00000000 00000000
[    7.263582] xhci_hcd 0000:02:00.0: @378056f0 00000000 00000000 00000000 00000000
[    7.263587] xhci_hcd 0000:02:00.0: @37805700 00000000 00000000 00000000 00000000
[    7.263592] xhci_hcd 0000:02:00.0: @37805710 00000000 00000000 00000000 00000000
[    7.263596] xhci_hcd 0000:02:00.0: @37805720 00000000 00000000 00000000 00000000
[    7.263601] xhci_hcd 0000:02:00.0: @37805730 00000000 00000000 00000000 00000000
[    7.263606] xhci_hcd 0000:02:00.0: @37805740 00000000 00000000 00000000 00000000
[    7.263611] xhci_hcd 0000:02:00.0: @37805750 00000000 00000000 00000000 00000000
[    7.263616] xhci_hcd 0000:02:00.0: @37805760 00000000 00000000 00000000 00000000
[    7.263621] xhci_hcd 0000:02:00.0: @37805770 00000000 00000000 00000000 00000000
[    7.263626] xhci_hcd 0000:02:00.0: @37805780 00000000 00000000 00000000 00000000
[    7.263631] xhci_hcd 0000:02:00.0: @37805790 00000000 00000000 00000000 00000000
[    7.263636] xhci_hcd 0000:02:00.0: @378057a0 00000000 00000000 00000000 00000000
[    7.263641] xhci_hcd 0000:02:00.0: @378057b0 00000000 00000000 00000000 00000000
[    7.263645] xhci_hcd 0000:02:00.0: @378057c0 00000000 00000000 00000000 00000000
[    7.263650] xhci_hcd 0000:02:00.0: @378057d0 00000000 00000000 00000000 00000000
[    7.263655] xhci_hcd 0000:02:00.0: @378057e0 00000000 00000000 00000000 00000000
[    7.263660] xhci_hcd 0000:02:00.0: @378057f0 00000000 00000000 00000000 00000000
[    7.263664] xhci_hcd 0000:02:00.0:   Ring has not been updated
[    7.263669] xhci_hcd 0000:02:00.0: Ring deq = ffff880037805400 (virt), 0x37805400 (dma)
[    7.263673] xhci_hcd 0000:02:00.0: Ring deq updated 0 times
[    7.263677] xhci_hcd 0000:02:00.0: Ring enq = ffff880037805400 (virt), 0x37805400 (dma)
[    7.263683] xhci_hcd 0000:02:00.0: Ring enq updated 0 times
[    7.263688] xhci_hcd 0000:02:00.0: ERST deq = 64'h37805400
[    7.263692] xhci_hcd 0000:02:00.0: // Set the interrupt modulation register
[    7.263697] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790624, 32'ha0, 4'hf);
[    7.263712] xhci_hcd 0000:02:00.0: // Enable interrupts, cmd = 0x4.
[    7.263716] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790020, 32'h4, 4'hf);
[    7.263723] xhci_hcd 0000:02:00.0: // Enabling event ring interrupter ffffc90011790620 by writing 0x2 to irq_pending
[    7.263730] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790620, 32'h2, 4'hf);
[    7.263737] xhci_hcd 0000:02:00.0:   ffffc90011790620: ir_set[0]
[    7.263741] xhci_hcd 0000:02:00.0:   ffffc90011790620: ir_set.pending = 0x2
[    7.263747] xhci_hcd 0000:02:00.0:   ffffc90011790624: ir_set.control = 0xa0
[    7.263753] xhci_hcd 0000:02:00.0:   ffffc90011790628: ir_set.erst_size = 0x1
[    7.263761] xhci_hcd 0000:02:00.0:   ffffc90011790630: ir_set.erst_base = @37806000
[    7.263770] xhci_hcd 0000:02:00.0:   ffffc90011790638: ir_set.erst_dequeue = @37805400
[    7.263777] xhci_hcd 0000:02:00.0: // Turn on HC, cmd = 0x5.
[    7.263783] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790020, 32'h5, 4'hf);
[    7.263791] xhci_hcd 0000:02:00.0: // @ffffc90011790020 = 0x5
[    7.263796] xhci_hcd 0000:02:00.0: Finished xhci_run
[    7.263842] usb usb2: config 1 interface 0 altsetting 0 endpoint 0x81 has no SuperSpeed companion descriptor
[    7.263853] usb usb2: default language 0x0409
[    7.263865] usb usb2: udev 1, busnum 2, minor = 128
[    7.263870] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    7.263877] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.263883] usb usb2: Product: xHCI Host Controller
[    7.263888] usb usb2: Manufacturer: Linux 2.6.32.8-usb-debug xhci_hcd
[    7.263894] usb usb2: SerialNumber: 0000:02:00.0
[    7.263960] usb usb2: uevent
[    7.263985] usb usb2: usb_probe_device
[    7.263992] usb usb2: configuration #1 chosen from 1 choice
[    7.263998] xHCI xhci_add_endpoint called for root hub
[    7.264004] xHCI xhci_check_bandwidth called for root hub
[    7.264015] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[    7.264041] usb 2-0:1.0: uevent
[    7.264087] hub 2-0:1.0: usb_probe_interface
[    7.264092] hub 2-0:1.0: usb_probe_interface - got id
[    7.264098] hub 2-0:1.0: USB hub found
[    7.264109] hub 2-0:1.0: 4 ports detected
[    7.264114] hub 2-0:1.0: standalone hub
[    7.264118] hub 2-0:1.0: individual port power switching
[    7.264122] hub 2-0:1.0: individual port over-current protection
[    7.264128] hub 2-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    7.264134] hub 2-0:1.0: power on to power good time: 20ms
[    7.264143] hub 2-0:1.0: local power source is good
[    7.264146] hub 2-0:1.0: enabling power on all ports
[    7.264154] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790420, 32'h2a0, 4'hf);
[    7.264163] xhci_hcd 0000:02:00.0: set port power, actual port 0 status  = 0x2a0
[    7.264174] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790430, 32'h2a0, 4'hf);
[    7.264183] xhci_hcd 0000:02:00.0: set port power, actual port 1 status  = 0x2a0
[    7.264194] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790440, 32'h2a0, 4'hf);
[    7.264204] xhci_hcd 0000:02:00.0: set port power, actual port 2 status  = 0x2a0
[    7.264214] xhci_hcd 0000:02:00.0: `MEM_WRITE_DWORD(3'b000, 32'hffffc90011790450, 32'h2a0, 4'hf);
[    7.264223] xhci_hcd 0000:02:00.0: set port power, actual port 3 status  = 0x2a0
[    7.264255] drivers/usb/core/inode.c: creating file '001'
[    7.267772] Bluetooth: Generic Bluetooth USB driver ver 0.6
[    7.267791] btusb 1-1.6:1.0: usb_probe_interface
[    7.267797] btusb 1-1.6:1.0: usb_probe_interface - got id
[    7.267900] btusb 1-1.6:1.2: usb_probe_interface
[    7.267906] btusb 1-1.6:1.2: usb_probe_interface - got id
[    7.267919] btusb 1-1.6:1.3: usb_probe_interface
[    7.267924] btusb 1-1.6:1.3: usb_probe_interface - got id
[    7.267949] usbcore: registered new interface driver btusb
[    7.281838] Linux video capture interface: v2.00
[    7.303420] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.303424] Bluetooth: BNEP filters: protocol multicast
[    7.306697] usb usb2: uevent
[    7.322362] uvcvideo 1-1.5:1.0: usb_probe_interface
[    7.322368] uvcvideo 1-1.5:1.0: usb_probe_interface - got id
[    7.322382] uvcvideo: Found UVC 1.00 device HP Webcam (04f2:b16c)
[    7.323608] input: HP Webcam as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input6
[    7.323689] usbcore: registered new interface driver uvcvideo
[    7.323696] USB Video Class driver (v0.1.0)
[    7.337038] usb usb2: uevent
[    7.337165] usb 2-0:1.0: uevent
[    7.338146] usb usb1: uevent
[    7.338252] usb 1-0:1.0: uevent
[    7.338309] usb 1-1: uevent
[    7.338393] usb 1-1.5: uevent
[    7.338477] usb 1-1.5:1.0: uevent
[    7.338684] usb 1-1.5:1.1: uevent
[    7.338742] usb 1-1.6: uevent
[    7.338843] usb 1-1.6:1.0: uevent
[    7.338987] usb 1-1.6:1.1: uevent
[    7.339039] usb 1-1.6:1.2: uevent
[    7.339089] usb 1-1.6:1.3: uevent
[    7.339141] usb 1-1:1.0: uevent
[    7.343294] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.345756] lp: driver loaded but no devices found
[    7.363944] atl1c 0000:04:00.0: version 1.0.0.1-NAPI
[    7.372854] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[    7.372860] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[    7.372870] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[    7.372872] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[    7.372881] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[    7.372884] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[    7.372889] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[    7.372893] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[    7.372901] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[    7.473553] usb 1-1.5: link qh16-0001/ffff8802273e3b80 start 2 [1/0 us]
[    7.473593] usb 1-1.5: unlink qh16-0001/ffff8802273e3b80 start 2 [1/0 us]
[    7.474511]   alloc irq_desc for 34 on node -1
[    7.474516]   alloc kstat_irqs on node -1
[    7.474534] atl1c 0000:04:00.0: irq 34 for MSI/MSI-X
[    7.474604] usb 1-1.5:1.0: uevent
[    7.474763] usb 1-1.5: uevent
[    7.475838] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.477174] usb 1-1.5:1.0: uevent
[    7.477286] usb 1-1.5: uevent
[    7.477377] usb 1-1.5:1.0: uevent
[    7.478672] usb 1-1.5:1.0: uevent
[    7.483707] ehci_hcd 0000:00:1d.0: reused qh ffff8802273e3b80 schedule
[    7.483713] usb 1-1.5: link qh16-0001/ffff8802273e3b80 start 2 [1/0 us]
[    7.485980] usb 1-1.5: unlink qh16-0001/ffff8802273e3b80 start 2 [1/0 us]
[    7.498976] iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27k
[    7.498979] iwlagn: Copyright(c) 2003-2009 Intel Corporation
[    7.499102] iwlagn 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    7.499131] iwlagn 0000:03:00.0: setting latency timer to 64
[    7.500008] iwlagn 0000:03:00.0: Detected Intel Wireless WiFi Link 6000 Series 2x2 AGN REV=0x74
[    7.521753] Bridge firewalling registered
[    7.523329] lis3lv02d: laptop model unknown, using default axes configuration
[    7.524250] lis3lv02d: 1-byte sensor found
[    7.536767] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input7
[    7.536871] Registered led device: hp::hddprotect
[    7.536897] lis3lv02d driver loaded.
[    7.536916] usb 1-1.6: link qh1-0e01/ffff88022b443800 start 0 [1/2 us]
[    7.541636] iwlagn 0000:03:00.0: Tunable channels: 13 802.11bg, 24 802.11a channels
[    7.541702]   alloc irq_desc for 35 on node -1
[    7.541706]   alloc kstat_irqs on node -1
[    7.541727] iwlagn 0000:03:00.0: irq 35 for MSI/MSI-X
[    7.553682] phy0: Selected rate control algorithm 'iwl-agn-rs'
[    7.564911] iwlagn 0000:03:00.0: firmware: requesting iwlwifi-6000-4.ucode
[    7.574355] iwlagn 0000:03:00.0: loaded firmware version 9.176.4.1
[    7.641653]   alloc irq_desc for 22 on node -1
[    7.641656]   alloc kstat_irqs on node -1
[    7.641663] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    7.641844] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    7.768846] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input8
[    7.784549] CE: hpet increasing min_delta_ns to 15000 nsec
[    7.869054] Registered led device: iwl-phy0::radio
[    7.869080] Registered led device: iwl-phy0::assoc
[    7.869109] Registered led device: iwl-phy0::RX
[    7.869138] Registered led device: iwl-phy0::TX
[    8.220232] Synaptics Touchpad, model: 1, fw: 7.4, id: 0x1e0b1, caps: 0xd04771/0xe40000
[    8.220234] Synaptics: Clickpad mode enabled
[    8.291150] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input9
[    8.502848] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    8.802668] hda-intel: azx_get_response timeout, switching to polling mode: last cmd=0x00bf0900
[    8.802822] input: HDA Intel Mic at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    8.802885] input: HDA Intel HP Out at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    8.803998] HDA Intel 0000:01:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    8.804064] HDA Intel 0000:01:00.1: setting latency timer to 64
[    8.816013] ppdev: user-space parallel port driver
[    8.879290] usb usb2: uevent
[    8.886974] usb usb1: uevent
[    8.890948] usb usb1: uevent
[    8.894843] usb 1-1: uevent
[    8.900160] usb 1-1.5: uevent
[    8.904769] usb 1-1.5: uevent
[    8.909861] usb 1-1: uevent
[    8.913872] usb 1-1.6: uevent
[    8.917868] usb 1-1.6: uevent
[    8.921796] usb 1-1.6: uevent
[    8.925766] usb 1-1.6: uevent
[    8.929854] usb 1-1: uevent
[    9.164117] CPU0 attaching NULL sched-domain.
[    9.164126] CPU1 attaching NULL sched-domain.
[    9.164130] CPU2 attaching NULL sched-domain.
[    9.164134] CPU3 attaching NULL sched-domain.
[    9.164138] CPU4 attaching NULL sched-domain.
[    9.164142] CPU5 attaching NULL sched-domain.
[    9.164146] CPU6 attaching NULL sched-domain.
[    9.164149] CPU7 attaching NULL sched-domain.
[    9.321742] CPU0 attaching sched-domain:
[    9.321745]  domain 0: span 0,4 level SIBLING
[    9.321747]   groups: 0 (cpu_power = 589) 4 (cpu_power = 589)
[    9.321751]   domain 1: span 0-7 level MC
[    9.321753]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[    9.321760] CPU1 attaching sched-domain:
[    9.321762]  domain 0: span 1,5 level SIBLING
[    9.321763]   groups: 1 (cpu_power = 589) 5 (cpu_power = 589)
[    9.321767]   domain 1: span 0-7 level MC
[    9.321768]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[    9.321775] CPU2 attaching sched-domain:
[    9.321776]  domain 0: span 2,6 level SIBLING
[    9.321778]   groups: 2 (cpu_power = 589) 6 (cpu_power = 589)
[    9.321781]   domain 1: span 0-7 level MC
[    9.321783]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[    9.321789] CPU3 attaching sched-domain:
[    9.321791]  domain 0: span 3,7 level SIBLING
[    9.321792]   groups: 3 (cpu_power = 589) 7 (cpu_power = 589)
[    9.321796]   domain 1: span 0-7 level MC
[    9.321797]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[    9.321804] CPU4 attaching sched-domain:
[    9.321805]  domain 0: span 0,4 level SIBLING
[    9.321806]   groups: 4 (cpu_power = 589) 0 (cpu_power = 589)
[    9.321810]   domain 1: span 0-7 level MC
[    9.321812]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[    9.321818] CPU5 attaching sched-domain:
[    9.321819]  domain 0: span 1,5 level SIBLING
[    9.321821]   groups: 5 (cpu_power = 589) 1 (cpu_power = 589)
[    9.321824]   domain 1: span 0-7 level MC
[    9.321826]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[    9.321832] CPU6 attaching sched-domain:
[    9.321833]  domain 0: span 2,6 level SIBLING
[    9.321835]   groups: 6 (cpu_power = 589) 2 (cpu_power = 589)
[    9.321839]   domain 1: span 0-7 level MC
[    9.321840]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[    9.321846] CPU7 attaching sched-domain:
[    9.321848]  domain 0: span 3,7 level SIBLING
[    9.321849]   groups: 7 (cpu_power = 589) 3 (cpu_power = 589)
[    9.321853]   domain 1: span 0-7 level MC
[    9.321854]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[    9.340832] usplash:555 freeing invalid memtype ffffffffc0000000-ffffffffc1000000
[    9.801861]   alloc irq_desc for 36 on node -1
[    9.801863]   alloc kstat_irqs on node -1
[    9.801871] fglrx_pci 0000:01:00.0: irq 36 for MSI/MSI-X
[    9.802367] [fglrx] Firegl kernel thread PID: 2065
[    9.910087] [fglrx] Gart USWC size:1279 M.
[    9.910089] [fglrx] Gart cacheable size:508 M.
[    9.910093] [fglrx] Reserved FB block: Shared offset:0, size:1000000 
[    9.910094] [fglrx] Reserved FB block: Unshared offset:f8ff000, size:401000 
[    9.910096] [fglrx] Reserved FB block: Unshared offset:3fff4000, size:c000 
[   11.216451] hub 2-0:1.0: hub_suspend
[   11.216459] usb usb2: bus auto-suspend
[   11.216462] usb usb2: bus suspend fail, err -2
[   11.216464] hub 2-0:1.0: hub_resume
[   11.216474] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   11.216477] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   11.216486] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   11.216489] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   11.216494] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   11.216496] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   11.216503] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   11.216505] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   11.216516] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   11.939537] usb usb1: uevent
[   11.939594] usb 1-0:1.0: uevent
[   11.939629] usb 1-1: uevent
[   11.939679] usb 1-1:1.0: uevent
[   11.939714] usb 1-1.5: uevent
[   11.939766] usb 1-1.5:1.0: uevent
[   11.939801] usb 1-1.5:1.1: uevent
[   11.939836] usb 1-1.6: uevent
[   11.939887] usb 1-1.6:1.0: uevent
[   11.939928] usb 1-1.6:1.1: uevent
[   11.939968] usb 1-1.6:1.2: uevent
[   11.940008] usb 1-1.6:1.3: uevent
[   11.940043] usb usb2: uevent
[   11.940095] usb 2-0:1.0: uevent
[   12.046746] usb usb2: uevent
[   12.047210] usb 2-0:1.0: uevent
[   12.047553] usb usb1: uevent
[   12.047942] usb 1-0:1.0: uevent
[   12.048279] usb 1-1: uevent
[   12.048674] usb 1-1.5: uevent
[   12.049067] usb 1-1.5:1.0: uevent
[   12.049614] usb 1-1.5:1.1: uevent
[   12.050015] usb 1-1.6: uevent
[   12.050413] usb 1-1.6:1.0: uevent
[   12.050747] usb 1-1.6:1.1: uevent
[   12.051077] usb 1-1.6:1.2: uevent
[   12.051414] usb 1-1.6:1.3: uevent
[   12.051747] usb 1-1:1.0: uevent
[   12.140469] CPU0 attaching NULL sched-domain.
[   12.140474] CPU1 attaching NULL sched-domain.
[   12.140475] CPU2 attaching NULL sched-domain.
[   12.140477] CPU3 attaching NULL sched-domain.
[   12.140479] CPU4 attaching NULL sched-domain.
[   12.140480] CPU5 attaching NULL sched-domain.
[   12.140482] CPU6 attaching NULL sched-domain.
[   12.140483] CPU7 attaching NULL sched-domain.
[   12.238511] CPU0 attaching sched-domain:
[   12.238516]  domain 0: span 0,4 level SIBLING
[   12.238518]   groups: 0 (cpu_power = 589) 4 (cpu_power = 589)
[   12.238524]   domain 1: span 0-7 level MC
[   12.238527]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[   12.238537] CPU1 attaching sched-domain:
[   12.238539]  domain 0: span 1,5 level SIBLING
[   12.238541]   groups: 1 (cpu_power = 589) 5 (cpu_power = 589)
[   12.238546]   domain 1: span 0-7 level MC
[   12.238549]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[   12.238557] CPU2 attaching sched-domain:
[   12.238559]  domain 0: span 2,6 level SIBLING
[   12.238561]   groups: 2 (cpu_power = 589) 6 (cpu_power = 589)
[   12.238566]   domain 1: span 0-7 level MC
[   12.238569]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[   12.238577] CPU3 attaching sched-domain:
[   12.238579]  domain 0: span 3,7 level SIBLING
[   12.238581]   groups: 3 (cpu_power = 589) 7 (cpu_power = 589)
[   12.238586]   domain 1: span 0-7 level MC
[   12.238588]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[   12.238597] CPU4 attaching sched-domain:
[   12.238599]  domain 0: span 0,4 level SIBLING
[   12.238601]   groups: 4 (cpu_power = 589) 0 (cpu_power = 589)
[   12.238606]   domain 1: span 0-7 level MC
[   12.238608]    groups: 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178)
[   12.238617] CPU5 attaching sched-domain:
[   12.238619]  domain 0: span 1,5 level SIBLING
[   12.238621]   groups: 5 (cpu_power = 589) 1 (cpu_power = 589)
[   12.238626]   domain 1: span 0-7 level MC
[   12.238628]    groups: 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178)
[   12.238637] CPU6 attaching sched-domain:
[   12.238639]  domain 0: span 2,6 level SIBLING
[   12.238641]   groups: 6 (cpu_power = 589) 2 (cpu_power = 589)
[   12.238646]   domain 1: span 0-7 level MC
[   12.238648]    groups: 2,6 (cpu_power = 1178) 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178)
[   12.238657] CPU7 attaching sched-domain:
[   12.238659]  domain 0: span 3,7 level SIBLING
[   12.238661]   groups: 7 (cpu_power = 589) 3 (cpu_power = 589)
[   12.238666]   domain 1: span 0-7 level MC
[   12.238668]    groups: 3,7 (cpu_power = 1178) 0,4 (cpu_power = 1178) 1,5 (cpu_power = 1178) 2,6 (cpu_power = 1178)
[   12.962613] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
[   14.123326] hub 2-0:1.0: hub_suspend
[   14.123340] usb usb2: bus auto-suspend
[   14.123345] usb usb2: bus suspend fail, err -2
[   14.123349] hub 2-0:1.0: hub_resume
[   14.123360] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   14.123365] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   14.123378] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   14.123382] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   14.123392] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   14.123396] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   14.123405] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   14.123410] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   14.123519] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   16.604428] usb usb1: uevent
[   16.604484] usb 1-0:1.0: uevent
[   16.604520] usb 1-1: uevent
[   16.604570] usb 1-1:1.0: uevent
[   16.604606] usb 1-1.5: uevent
[   16.604657] usb 1-1.5:1.0: uevent
[   16.604692] usb 1-1.5:1.1: uevent
[   16.604728] usb 1-1.6: uevent
[   16.604779] usb 1-1.6:1.0: uevent
[   16.604815] usb 1-1.6:1.1: uevent
[   16.604849] usb 1-1.6:1.2: uevent
[   16.604890] usb 1-1.6:1.3: uevent
[   16.604931] usb usb2: uevent
[   16.604991] usb 2-0:1.0: uevent
[   16.675770] usb usb1: uevent
[   16.675826] usb 1-0:1.0: uevent
[   16.675861] usb 1-1: uevent
[   16.675911] usb 1-1:1.0: uevent
[   16.675946] usb 1-1.5: uevent
[   16.675998] usb 1-1.5:1.0: uevent
[   16.676034] usb 1-1.5:1.1: uevent
[   16.676069] usb 1-1.6: uevent
[   16.676120] usb 1-1.6:1.0: uevent
[   16.676155] usb 1-1.6:1.1: uevent
[   16.676190] usb 1-1.6:1.2: uevent
[   16.676224] usb 1-1.6:1.3: uevent
[   16.676259] usb usb2: uevent
[   16.676310] usb 2-0:1.0: uevent
[   17.120075] hub 2-0:1.0: hub_suspend
[   17.120088] usb usb2: bus auto-suspend
[   17.120093] usb usb2: bus suspend fail, err -2
[   17.120097] hub 2-0:1.0: hub_resume
[   17.120108] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   17.120112] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   17.120124] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   17.120129] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   17.120138] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   17.120142] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   17.120152] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   17.120156] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   17.120238] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   19.902173] usb usb2: uevent
[   19.902284] usb 2-0:1.0: uevent
[   19.902352] usb usb1: uevent
[   19.902453] usb 1-0:1.0: uevent
[   19.902524] usb 1-1: uevent
[   19.902626] usb 1-1.5: uevent
[   19.902729] usb 1-1.5:1.0: uevent
[   19.902793] usb 1-1.5:1.1: uevent
[   19.902863] usb 1-1.6: uevent
[   19.902970] usb 1-1.6:1.0: uevent
[   19.903035] usb 1-1.6:1.1: uevent
[   19.903099] usb 1-1.6:1.2: uevent
[   19.903161] usb 1-1.6:1.3: uevent
[   19.903224] usb 1-1:1.0: uevent
[   20.118588] hub 2-0:1.0: hub_suspend
[   20.118601] usb usb2: bus auto-suspend
[   20.118606] usb usb2: bus suspend fail, err -2
[   20.118611] hub 2-0:1.0: hub_resume
[   20.118624] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   20.118629] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   20.118640] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   20.118644] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   20.118652] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   20.118657] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   20.118667] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   20.118671] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   20.118699] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   23.114506] hub 2-0:1.0: hub_suspend
[   23.114517] usb usb2: bus auto-suspend
[   23.114520] usb usb2: bus suspend fail, err -2
[   23.114523] hub 2-0:1.0: hub_resume
[   23.114535] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   23.114538] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   23.114548] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   23.114552] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   23.114559] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   23.114562] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   23.114568] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   23.114571] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   23.114589] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   25.550897] wlan0: deauthenticating from 00:1c:10:88:97:b6 by local choice (reason=3)
[   25.550964] wlan0: direct probe to AP 00:1c:10:88:97:b6 (try 1)
[   25.555864] wlan0: direct probe responded
[   25.555871] wlan0: authenticate with AP 00:1c:10:88:97:b6 (try 1)
[   25.557805] wlan0: authenticated
[   25.557835] wlan0: associate with AP 00:1c:10:88:97:b6 (try 1)
[   25.560456] wlan0: RX AssocResp from 00:1c:10:88:97:b6 (capab=0x411 status=0 aid=2)
[   25.560462] wlan0: associated
[   25.563255] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   26.110258] hub 2-0:1.0: hub_suspend
[   26.110270] usb usb2: bus auto-suspend
[   26.110275] usb usb2: bus suspend fail, err -2
[   26.110279] hub 2-0:1.0: hub_resume
[   26.110292] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   26.110297] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   26.110309] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   26.110313] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   26.110323] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   26.110327] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   26.110336] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   26.110341] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   26.110359] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   29.107009] hub 2-0:1.0: hub_suspend
[   29.107020] usb usb2: bus auto-suspend
[   29.107024] usb usb2: bus suspend fail, err -2
[   29.107027] hub 2-0:1.0: hub_resume
[   29.107038] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   29.107041] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   29.107052] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   29.107055] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   29.107062] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   29.107065] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   29.107071] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   29.107074] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   29.107086] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   31.775811] compiz.real[2499]: segfault at 3fe2000 ip 00007fddc97d4823 sp 00007fff7644b268 error 4 in libc-2.10.1.so[7fddc9752000+166000]
[   32.103794] hub 2-0:1.0: hub_suspend
[   32.103803] usb usb2: bus auto-suspend
[   32.103806] usb usb2: bus suspend fail, err -2
[   32.103808] hub 2-0:1.0: hub_resume
[   32.103818] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   32.103821] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   32.103829] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   32.103831] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   32.103836] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   32.103838] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   32.103845] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   32.103847] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   32.103855] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   35.101965] hub 2-0:1.0: hub_suspend
[   35.101979] usb usb2: bus auto-suspend
[   35.101984] usb usb2: bus suspend fail, err -2
[   35.101988] hub 2-0:1.0: hub_resume
[   35.102001] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   35.102006] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   35.102018] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   35.102022] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   35.102032] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   35.102036] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   35.102045] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   35.102050] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   35.102063] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   36.071295] wlan0: no IPv6 routers present
[   38.102004] hub 2-0:1.0: hub_suspend
[   38.102012] usb usb2: bus auto-suspend
[   38.102014] usb usb2: bus suspend fail, err -2
[   38.102016] hub 2-0:1.0: hub_resume
[   38.102025] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   38.102027] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   38.102033] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   38.102035] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   38.102040] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   38.102042] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   38.102046] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   38.102048] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   38.102058] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   41.099907] hub 2-0:1.0: hub_suspend
[   41.099920] usb usb2: bus auto-suspend
[   41.099925] usb usb2: bus suspend fail, err -2
[   41.099929] hub 2-0:1.0: hub_resume
[   41.099943] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   41.099947] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   41.099960] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   41.099964] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   41.099974] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   41.099978] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   41.099987] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   41.099992] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   41.100010] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   44.098610] hub 2-0:1.0: hub_suspend
[   44.098624] usb usb2: bus auto-suspend
[   44.098629] usb usb2: bus suspend fail, err -2
[   44.098633] hub 2-0:1.0: hub_resume
[   44.098646] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   44.098651] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   44.098663] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   44.098668] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   44.098677] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   44.098681] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   44.098691] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   44.098695] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   44.098710] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   47.094913] hub 2-0:1.0: hub_suspend
[   47.094926] usb usb2: bus auto-suspend
[   47.094931] usb usb2: bus suspend fail, err -2
[   47.094935] hub 2-0:1.0: hub_resume
[   47.094948] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   47.094952] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   47.094964] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   47.094969] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   47.094978] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   47.094983] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   47.094992] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   47.094996] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   47.095010] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   50.093251] hub 2-0:1.0: hub_suspend
[   50.093264] usb usb2: bus auto-suspend
[   50.093270] usb usb2: bus suspend fail, err -2
[   50.093274] hub 2-0:1.0: hub_resume
[   50.093287] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   50.093292] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   50.093304] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   50.093308] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   50.093318] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   50.093322] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   50.093332] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   50.093336] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   50.093351] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   53.091507] hub 2-0:1.0: hub_suspend
[   53.091520] usb usb2: bus auto-suspend
[   53.091525] usb usb2: bus suspend fail, err -2
[   53.091529] hub 2-0:1.0: hub_resume
[   53.091542] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   53.091547] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   53.091559] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   53.091563] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   53.091573] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   53.091577] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   53.091586] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   53.091591] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   53.091609] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   56.089773] hub 2-0:1.0: hub_suspend
[   56.089787] usb usb2: bus auto-suspend
[   56.089792] usb usb2: bus suspend fail, err -2
[   56.089796] hub 2-0:1.0: hub_resume
[   56.089809] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   56.089814] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   56.089826] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   56.089830] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   56.089840] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   56.089844] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   56.089854] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   56.089858] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   56.089873] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   59.088045] hub 2-0:1.0: hub_suspend
[   59.088058] usb usb2: bus auto-suspend
[   59.088063] usb usb2: bus suspend fail, err -2
[   59.088067] hub 2-0:1.0: hub_resume
[   59.088079] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   59.088084] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   59.088096] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   59.088101] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   59.088110] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   59.088115] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   59.088124] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   59.088128] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   59.088146] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   62.086212] hub 2-0:1.0: hub_suspend
[   62.086225] usb usb2: bus auto-suspend
[   62.086230] usb usb2: bus suspend fail, err -2
[   62.086235] hub 2-0:1.0: hub_resume
[   62.086248] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   62.086252] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   62.086264] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   62.086269] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   62.086278] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   62.086283] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   62.086292] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   62.086296] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   62.086310] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   65.084487] hub 2-0:1.0: hub_suspend
[   65.084500] usb usb2: bus auto-suspend
[   65.084505] usb usb2: bus suspend fail, err -2
[   65.084509] hub 2-0:1.0: hub_resume
[   65.084522] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   65.084527] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   65.084539] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   65.084543] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   65.084553] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   65.084557] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   65.084566] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   65.084571] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   65.084583] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   67.203292] xhci_hcd 0000:02:00.0: Poll event ring: 4294944003
[   67.203302] xhci_hcd 0000:02:00.0: op reg status = 0x0
[   67.203309] xhci_hcd 0000:02:00.0: ir_set 0 pending = 0x2
[   67.203313] xhci_hcd 0000:02:00.0: No-op commands handled = 0
[   67.203318] xhci_hcd 0000:02:00.0: HC error bitmask = 0x0
[   67.203322] xhci_hcd 0000:02:00.0: Event ring:
[   67.203328] xhci_hcd 0000:02:00.0: @37805400 00000000 00000000 00000000 00000000
[   67.203333] xhci_hcd 0000:02:00.0: @37805410 00000000 00000000 00000000 00000000
[   67.203338] xhci_hcd 0000:02:00.0: @37805420 00000000 00000000 00000000 00000000
[   67.203343] xhci_hcd 0000:02:00.0: @37805430 00000000 00000000 00000000 00000000
[   67.203348] xhci_hcd 0000:02:00.0: @37805440 00000000 00000000 00000000 00000000
[   67.203353] xhci_hcd 0000:02:00.0: @37805450 00000000 00000000 00000000 00000000
[   67.203358] xhci_hcd 0000:02:00.0: @37805460 00000000 00000000 00000000 00000000
[   67.203363] xhci_hcd 0000:02:00.0: @37805470 00000000 00000000 00000000 00000000
[   67.203368] xhci_hcd 0000:02:00.0: @37805480 00000000 00000000 00000000 00000000
[   67.203373] xhci_hcd 0000:02:00.0: @37805490 00000000 00000000 00000000 00000000
[   67.203378] xhci_hcd 0000:02:00.0: @378054a0 00000000 00000000 00000000 00000000
[   67.203383] xhci_hcd 0000:02:00.0: @378054b0 00000000 00000000 00000000 00000000
[   67.203388] xhci_hcd 0000:02:00.0: @378054c0 00000000 00000000 00000000 00000000
[   67.203393] xhci_hcd 0000:02:00.0: @378054d0 00000000 00000000 00000000 00000000
[   67.203398] xhci_hcd 0000:02:00.0: @378054e0 00000000 00000000 00000000 00000000
[   67.203403] xhci_hcd 0000:02:00.0: @378054f0 00000000 00000000 00000000 00000000
[   67.203408] xhci_hcd 0000:02:00.0: @37805500 00000000 00000000 00000000 00000000
[   67.203413] xhci_hcd 0000:02:00.0: @37805510 00000000 00000000 00000000 00000000
[   67.203418] xhci_hcd 0000:02:00.0: @37805520 00000000 00000000 00000000 00000000
[   67.203423] xhci_hcd 0000:02:00.0: @37805530 00000000 00000000 00000000 00000000
[   67.203428] xhci_hcd 0000:02:00.0: @37805540 00000000 00000000 00000000 00000000
[   67.203433] xhci_hcd 0000:02:00.0: @37805550 00000000 00000000 00000000 00000000
[   67.203438] xhci_hcd 0000:02:00.0: @37805560 00000000 00000000 00000000 00000000
[   67.203443] xhci_hcd 0000:02:00.0: @37805570 00000000 00000000 00000000 00000000
[   67.203448] xhci_hcd 0000:02:00.0: @37805580 00000000 00000000 00000000 00000000
[   67.203453] xhci_hcd 0000:02:00.0: @37805590 00000000 00000000 00000000 00000000
[   67.203458] xhci_hcd 0000:02:00.0: @378055a0 00000000 00000000 00000000 00000000
[   67.203463] xhci_hcd 0000:02:00.0: @378055b0 00000000 00000000 00000000 00000000
[   67.203468] xhci_hcd 0000:02:00.0: @378055c0 00000000 00000000 00000000 00000000
[   67.203473] xhci_hcd 0000:02:00.0: @378055d0 00000000 00000000 00000000 00000000
[   67.203478] xhci_hcd 0000:02:00.0: @378055e0 00000000 00000000 00000000 00000000
[   67.203483] xhci_hcd 0000:02:00.0: @378055f0 00000000 00000000 00000000 00000000
[   67.203488] xhci_hcd 0000:02:00.0: @37805600 00000000 00000000 00000000 00000000
[   67.203493] xhci_hcd 0000:02:00.0: @37805610 00000000 00000000 00000000 00000000
[   67.203498] xhci_hcd 0000:02:00.0: @37805620 00000000 00000000 00000000 00000000
[   67.203503] xhci_hcd 0000:02:00.0: @37805630 00000000 00000000 00000000 00000000
[   67.203508] xhci_hcd 0000:02:00.0: @37805640 00000000 00000000 00000000 00000000
[   67.203513] xhci_hcd 0000:02:00.0: @37805650 00000000 00000000 00000000 00000000
[   67.203518] xhci_hcd 0000:02:00.0: @37805660 00000000 00000000 00000000 00000000
[   67.203523] xhci_hcd 0000:02:00.0: @37805670 00000000 00000000 00000000 00000000
[   67.203528] xhci_hcd 0000:02:00.0: @37805680 00000000 00000000 00000000 00000000
[   67.203533] xhci_hcd 0000:02:00.0: @37805690 00000000 00000000 00000000 00000000
[   67.203538] xhci_hcd 0000:02:00.0: @378056a0 00000000 00000000 00000000 00000000
[   67.203543] xhci_hcd 0000:02:00.0: @378056b0 00000000 00000000 00000000 00000000
[   67.203548] xhci_hcd 0000:02:00.0: @378056c0 00000000 00000000 00000000 00000000
[   67.203553] xhci_hcd 0000:02:00.0: @378056d0 00000000 00000000 00000000 00000000
[   67.203558] xhci_hcd 0000:02:00.0: @378056e0 00000000 00000000 00000000 00000000
[   67.203563] xhci_hcd 0000:02:00.0: @378056f0 00000000 00000000 00000000 00000000
[   67.203568] xhci_hcd 0000:02:00.0: @37805700 00000000 00000000 00000000 00000000
[   67.203573] xhci_hcd 0000:02:00.0: @37805710 00000000 00000000 00000000 00000000
[   67.203578] xhci_hcd 0000:02:00.0: @37805720 00000000 00000000 00000000 00000000
[   67.203583] xhci_hcd 0000:02:00.0: @37805730 00000000 00000000 00000000 00000000
[   67.203588] xhci_hcd 0000:02:00.0: @37805740 00000000 00000000 00000000 00000000
[   67.203593] xhci_hcd 0000:02:00.0: @37805750 00000000 00000000 00000000 00000000
[   67.203598] xhci_hcd 0000:02:00.0: @37805760 00000000 00000000 00000000 00000000
[   67.203603] xhci_hcd 0000:02:00.0: @37805770 00000000 00000000 00000000 00000000
[   67.203608] xhci_hcd 0000:02:00.0: @37805780 00000000 00000000 00000000 00000000
[   67.203613] xhci_hcd 0000:02:00.0: @37805790 00000000 00000000 00000000 00000000
[   67.203618] xhci_hcd 0000:02:00.0: @378057a0 00000000 00000000 00000000 00000000
[   67.203622] xhci_hcd 0000:02:00.0: @378057b0 00000000 00000000 00000000 00000000
[   67.203627] xhci_hcd 0000:02:00.0: @378057c0 00000000 00000000 00000000 00000000
[   67.203632] xhci_hcd 0000:02:00.0: @378057d0 00000000 00000000 00000000 00000000
[   67.203637] xhci_hcd 0000:02:00.0: @378057e0 00000000 00000000 00000000 00000000
[   67.203642] xhci_hcd 0000:02:00.0: @378057f0 00000000 00000000 00000000 00000000
[   67.203649] xhci_hcd 0000:02:00.0: Ring deq = ffff880037805400 (virt), 0x37805400 (dma)
[   67.203653] xhci_hcd 0000:02:00.0: Ring deq updated 0 times
[   67.203658] xhci_hcd 0000:02:00.0: Ring enq = ffff880037805400 (virt), 0x37805400 (dma)
[   67.203663] xhci_hcd 0000:02:00.0: Ring enq updated 0 times
[   67.203672] xhci_hcd 0000:02:00.0: ERST deq = 64'h37805400
[   67.203676] xhci_hcd 0000:02:00.0: Command ring:
[   67.203681] xhci_hcd 0000:02:00.0: @37805000 00000000 00000000 00000000 00000000
[   67.203686] xhci_hcd 0000:02:00.0: @37805010 00000000 00000000 00000000 00000000
[   67.203691] xhci_hcd 0000:02:00.0: @37805020 00000000 00000000 00000000 00000000
[   67.203695] xhci_hcd 0000:02:00.0: @37805030 00000000 00000000 00000000 00000000
[   67.203700] xhci_hcd 0000:02:00.0: @37805040 00000000 00000000 00000000 00000000
[   67.203705] xhci_hcd 0000:02:00.0: @37805050 00000000 00000000 00000000 00000000
[   67.203710] xhci_hcd 0000:02:00.0: @37805060 00000000 00000000 00000000 00000000
[   67.203715] xhci_hcd 0000:02:00.0: @37805070 00000000 00000000 00000000 00000000
[   67.203720] xhci_hcd 0000:02:00.0: @37805080 00000000 00000000 00000000 00000000
[   67.203725] xhci_hcd 0000:02:00.0: @37805090 00000000 00000000 00000000 00000000
[   67.203729] xhci_hcd 0000:02:00.0: @378050a0 00000000 00000000 00000000 00000000
[   67.203734] xhci_hcd 0000:02:00.0: @378050b0 00000000 00000000 00000000 00000000
[   67.203739] xhci_hcd 0000:02:00.0: @378050c0 00000000 00000000 00000000 00000000
[   67.203744] xhci_hcd 0000:02:00.0: @378050d0 00000000 00000000 00000000 00000000
[   67.203749] xhci_hcd 0000:02:00.0: @378050e0 00000000 00000000 00000000 00000000
[   67.203754] xhci_hcd 0000:02:00.0: @378050f0 00000000 00000000 00000000 00000000
[   67.203759] xhci_hcd 0000:02:00.0: @37805100 00000000 00000000 00000000 00000000
[   67.203763] xhci_hcd 0000:02:00.0: @37805110 00000000 00000000 00000000 00000000
[   67.203768] xhci_hcd 0000:02:00.0: @37805120 00000000 00000000 00000000 00000000
[   67.203773] xhci_hcd 0000:02:00.0: @37805130 00000000 00000000 00000000 00000000
[   67.203778] xhci_hcd 0000:02:00.0: @37805140 00000000 00000000 00000000 00000000
[   67.203783] xhci_hcd 0000:02:00.0: @37805150 00000000 00000000 00000000 00000000
[   67.203788] xhci_hcd 0000:02:00.0: @37805160 00000000 00000000 00000000 00000000
[   67.203793] xhci_hcd 0000:02:00.0: @37805170 00000000 00000000 00000000 00000000
[   67.203797] xhci_hcd 0000:02:00.0: @37805180 00000000 00000000 00000000 00000000
[   67.203802] xhci_hcd 0000:02:00.0: @37805190 00000000 00000000 00000000 00000000
[   67.203807] xhci_hcd 0000:02:00.0: @378051a0 00000000 00000000 00000000 00000000
[   67.203812] xhci_hcd 0000:02:00.0: @378051b0 00000000 00000000 00000000 00000000
[   67.203817] xhci_hcd 0000:02:00.0: @378051c0 00000000 00000000 00000000 00000000
[   67.203822] xhci_hcd 0000:02:00.0: @378051d0 00000000 00000000 00000000 00000000
[   67.203827] xhci_hcd 0000:02:00.0: @378051e0 00000000 00000000 00000000 00000000
[   67.203831] xhci_hcd 0000:02:00.0: @378051f0 00000000 00000000 00000000 00000000
[   67.203836] xhci_hcd 0000:02:00.0: @37805200 00000000 00000000 00000000 00000000
[   67.203841] xhci_hcd 0000:02:00.0: @37805210 00000000 00000000 00000000 00000000
[   67.203846] xhci_hcd 0000:02:00.0: @37805220 00000000 00000000 00000000 00000000
[   67.203851] xhci_hcd 0000:02:00.0: @37805230 00000000 00000000 00000000 00000000
[   67.203856] xhci_hcd 0000:02:00.0: @37805240 00000000 00000000 00000000 00000000
[   67.203861] xhci_hcd 0000:02:00.0: @37805250 00000000 00000000 00000000 00000000
[   67.203865] xhci_hcd 0000:02:00.0: @37805260 00000000 00000000 00000000 00000000
[   67.203870] xhci_hcd 0000:02:00.0: @37805270 00000000 00000000 00000000 00000000
[   67.203875] xhci_hcd 0000:02:00.0: @37805280 00000000 00000000 00000000 00000000
[   67.203880] xhci_hcd 0000:02:00.0: @37805290 00000000 00000000 00000000 00000000
[   67.203885] xhci_hcd 0000:02:00.0: @378052a0 00000000 00000000 00000000 00000000
[   67.203890] xhci_hcd 0000:02:00.0: @378052b0 00000000 00000000 00000000 00000000
[   67.203895] xhci_hcd 0000:02:00.0: @378052c0 00000000 00000000 00000000 00000000
[   67.203899] xhci_hcd 0000:02:00.0: @378052d0 00000000 00000000 00000000 00000000
[   67.203904] xhci_hcd 0000:02:00.0: @378052e0 00000000 00000000 00000000 00000000
[   67.203909] xhci_hcd 0000:02:00.0: @378052f0 00000000 00000000 00000000 00000000
[   67.203914] xhci_hcd 0000:02:00.0: @37805300 00000000 00000000 00000000 00000000
[   67.203919] xhci_hcd 0000:02:00.0: @37805310 00000000 00000000 00000000 00000000
[   67.203924] xhci_hcd 0000:02:00.0: @37805320 00000000 00000000 00000000 00000000
[   67.203929] xhci_hcd 0000:02:00.0: @37805330 00000000 00000000 00000000 00000000
[   67.203933] xhci_hcd 0000:02:00.0: @37805340 00000000 00000000 00000000 00000000
[   67.203938] xhci_hcd 0000:02:00.0: @37805350 00000000 00000000 00000000 00000000
[   67.203943] xhci_hcd 0000:02:00.0: @37805360 00000000 00000000 00000000 00000000
[   67.203948] xhci_hcd 0000:02:00.0: @37805370 00000000 00000000 00000000 00000000
[   67.203953] xhci_hcd 0000:02:00.0: @37805380 00000000 00000000 00000000 00000000
[   67.203958] xhci_hcd 0000:02:00.0: @37805390 00000000 00000000 00000000 00000000
[   67.203963] xhci_hcd 0000:02:00.0: @378053a0 00000000 00000000 00000000 00000000
[   67.203967] xhci_hcd 0000:02:00.0: @378053b0 00000000 00000000 00000000 00000000
[   67.203972] xhci_hcd 0000:02:00.0: @378053c0 00000000 00000000 00000000 00000000
[   67.203977] xhci_hcd 0000:02:00.0: @378053d0 00000000 00000000 00000000 00000000
[   67.203982] xhci_hcd 0000:02:00.0: @378053e0 00000000 00000000 00000000 00000000
[   67.203987] xhci_hcd 0000:02:00.0: @378053f0 37805000 00000000 00000000 00001802
[   67.203992] xhci_hcd 0000:02:00.0: Ring deq = ffff880037805000 (virt), 0x37805000 (dma)
[   67.203996] xhci_hcd 0000:02:00.0: Ring deq updated 0 times
[   67.204001] xhci_hcd 0000:02:00.0: Ring enq = ffff880037805000 (virt), 0x37805000 (dma)
[   67.204005] xhci_hcd 0000:02:00.0: Ring enq updated 0 times
[   67.204014] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[   67.204019] xhci_hcd 0000:02:00.0: // xHC command ring deq ptr high bits = @00000000
[   68.082822] hub 2-0:1.0: hub_suspend
[   68.082834] usb usb2: bus auto-suspend
[   68.082839] usb usb2: bus suspend fail, err -2
[   68.082843] hub 2-0:1.0: hub_resume
[   68.082856] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   68.082860] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   68.082873] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   68.082877] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   68.082886] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   68.082891] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   68.082900] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   68.082904] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   68.082923] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   71.081070] hub 2-0:1.0: hub_suspend
[   71.081081] usb usb2: bus auto-suspend
[   71.081086] usb usb2: bus suspend fail, err -2
[   71.081090] hub 2-0:1.0: hub_resume
[   71.081102] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   71.081106] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   71.081119] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   71.081123] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   71.081133] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   71.081137] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   71.081146] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   71.081151] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   71.081165] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   74.079347] hub 2-0:1.0: hub_suspend
[   74.079358] usb usb2: bus auto-suspend
[   74.079363] usb usb2: bus suspend fail, err -2
[   74.079367] hub 2-0:1.0: hub_resume
[   74.079379] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   74.079384] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   74.079396] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   74.079400] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   74.079410] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   74.079414] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   74.079423] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   74.079428] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   74.079445] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   77.077541] hub 2-0:1.0: hub_suspend
[   77.077554] usb usb2: bus auto-suspend
[   77.077559] usb usb2: bus suspend fail, err -2
[   77.077563] hub 2-0:1.0: hub_resume
[   77.077576] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   77.077581] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   77.077593] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   77.077598] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   77.077607] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   77.077611] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   77.077621] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   77.077625] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   77.077639] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   77.845810] PM: Marking nosave pages: 0000000000001000 - 0000000000006000
[   77.845814] PM: Marking nosave pages: 000000000009b000 - 0000000000100000
[   77.845819] PM: Marking nosave pages: 00000000bf682000 - 00000000bf6bf000
[   77.845823] PM: Marking nosave pages: 00000000bf75c000 - 00000000bf7bf000
[   77.845828] PM: Marking nosave pages: 00000000bf7e4000 - 00000000bf7ff000
[   77.845831] PM: Marking nosave pages: 00000000bf800000 - 0000000100000000
[   77.846859] PM: Basic memory bitmaps created
[   77.846865] PM: Syncing filesystems ... done.
[   77.997120] Freezing user space processes ... (elapsed 0.00 seconds) done.
[   77.998042] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[   77.998269] PM: Preallocating image memory... done (allocated 1936029 pages)
[   80.480913] PM: Allocated 7744116 kbytes in 2.48 seconds (3122.62 MB/s)
[   80.480918] Suspending console(s) (use no_console_suspend to debug)
[   80.707848] hub 2-0:1.0: hub_suspend
[   80.707853] usb usb2: bus suspend
[   80.707855] usb usb2: bus suspend fail, err -2
[   80.707856] hub 2-0:1.0: hub_resume
[   80.707864] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   80.707866] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   80.707871] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   80.707872] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   80.707877] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   80.707879] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   80.707882] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   80.707884] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   80.707889] pm_op(): usb_dev_freeze+0x0/0x10 returns -2
[   80.707891] PM: Device usb2 failed to freeze: error -2
[   81.030959] Registered led device: iwl-phy0::radio
[   81.030989] Registered led device: iwl-phy0::assoc
[   81.031016] Registered led device: iwl-phy0::RX
[   81.031041] Registered led device: iwl-phy0::TX
[   81.166877] Restarting tasks ... 
[   81.166974] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   81.169743] done.
[   81.169816] PM: Basic memory bitmaps freed
[   84.075313] hub 2-0:1.0: hub_suspend
[   84.075406] usb usb2: bus auto-suspend
[   84.075412] usb usb2: bus suspend fail, err -2
[   84.075416] hub 2-0:1.0: hub_resume
[   84.075429] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   84.075434] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   84.075446] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   84.075450] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   84.075460] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   84.075464] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   84.075474] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   84.075478] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   84.075503] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   87.071724] hub 2-0:1.0: hub_suspend
[   87.071737] usb usb2: bus auto-suspend
[   87.071742] usb usb2: bus suspend fail, err -2
[   87.071746] hub 2-0:1.0: hub_resume
[   87.071760] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   87.071764] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   87.071777] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   87.071781] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   87.071791] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   87.071795] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   87.071804] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   87.071809] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   87.071823] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   90.070005] hub 2-0:1.0: hub_suspend
[   90.070018] usb usb2: bus auto-suspend
[   90.070023] usb usb2: bus suspend fail, err -2
[   90.070027] hub 2-0:1.0: hub_resume
[   90.070040] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   90.070045] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   90.070058] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   90.070062] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   90.070072] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   90.070076] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   90.070085] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   90.070090] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   90.070104] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   93.068319] hub 2-0:1.0: hub_suspend
[   93.068333] usb usb2: bus auto-suspend
[   93.068340] usb usb2: bus suspend fail, err -2
[   93.068345] hub 2-0:1.0: hub_resume
[   93.068360] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   93.068366] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   93.068382] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   93.068388] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   93.068402] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   93.068407] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   93.068416] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   93.068421] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   93.068435] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   96.066532] hub 2-0:1.0: hub_suspend
[   96.066546] usb usb2: bus auto-suspend
[   96.066551] usb usb2: bus suspend fail, err -2
[   96.066555] hub 2-0:1.0: hub_resume
[   96.066568] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   96.066573] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   96.066586] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   96.066590] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   96.066599] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   96.066604] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   96.066613] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   96.066618] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   96.066632] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[   99.064747] hub 2-0:1.0: hub_suspend
[   99.064760] usb usb2: bus auto-suspend
[   99.064766] usb usb2: bus suspend fail, err -2
[   99.064770] hub 2-0:1.0: hub_resume
[   99.064783] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[   99.064787] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   99.064800] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[   99.064804] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   99.064814] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[   99.064818] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   99.064828] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[   99.064832] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[   99.064842] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  102.063026] hub 2-0:1.0: hub_suspend
[  102.063039] usb usb2: bus auto-suspend
[  102.063045] usb usb2: bus suspend fail, err -2
[  102.063049] hub 2-0:1.0: hub_resume
[  102.063061] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  102.063066] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  102.063079] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  102.063083] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  102.063093] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  102.063097] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  102.063106] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  102.063111] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  102.063125] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  105.061291] hub 2-0:1.0: hub_suspend
[  105.061304] usb usb2: bus auto-suspend
[  105.061309] usb usb2: bus suspend fail, err -2
[  105.061313] hub 2-0:1.0: hub_resume
[  105.061326] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  105.061331] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  105.061343] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  105.061348] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  105.061357] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  105.061362] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  105.061371] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  105.061375] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  105.061394] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  108.059583] hub 2-0:1.0: hub_suspend
[  108.059596] usb usb2: bus auto-suspend
[  108.059601] usb usb2: bus suspend fail, err -2
[  108.059605] hub 2-0:1.0: hub_resume
[  108.059619] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  108.059623] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  108.059636] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  108.059640] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  108.059650] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  108.059654] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  108.059664] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  108.059668] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  108.059688] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  111.063393] hub 2-0:1.0: hub_suspend
[  111.063406] usb usb2: bus auto-suspend
[  111.063411] usb usb2: bus suspend fail, err -2
[  111.063415] hub 2-0:1.0: hub_resume
[  111.063428] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  111.063433] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  111.063446] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  111.063450] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  111.063460] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  111.063464] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  111.063474] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  111.063478] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  111.063491] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  114.056721] hub 2-0:1.0: hub_suspend
[  114.056734] usb usb2: bus auto-suspend
[  114.056739] usb usb2: bus suspend fail, err -2
[  114.056743] hub 2-0:1.0: hub_resume
[  114.056756] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  114.056761] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  114.056773] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  114.056777] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  114.056787] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  114.056791] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  114.056801] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  114.056805] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  114.056817] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  117.054315] hub 2-0:1.0: hub_suspend
[  117.054328] usb usb2: bus auto-suspend
[  117.054333] usb usb2: bus suspend fail, err -2
[  117.054337] hub 2-0:1.0: hub_resume
[  117.054350] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  117.054355] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  117.054368] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  117.054372] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  117.054382] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  117.054386] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  117.054395] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  117.054400] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  117.054417] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  120.052674] hub 2-0:1.0: hub_suspend
[  120.052687] usb usb2: bus auto-suspend
[  120.052692] usb usb2: bus suspend fail, err -2
[  120.052696] hub 2-0:1.0: hub_resume
[  120.052710] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  120.052714] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  120.052727] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  120.052731] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  120.052741] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  120.052745] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  120.052754] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  120.052759] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  120.052772] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  123.050916] hub 2-0:1.0: hub_suspend
[  123.050927] usb usb2: bus auto-suspend
[  123.050932] usb usb2: bus suspend fail, err -2
[  123.050936] hub 2-0:1.0: hub_resume
[  123.050948] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  123.050953] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  123.050965] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  123.050969] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  123.050979] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  123.050983] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  123.050992] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  123.050997] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  123.051011] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
[  126.049101] hub 2-0:1.0: hub_suspend
[  126.049112] usb usb2: bus auto-suspend
[  126.049116] usb usb2: bus suspend fail, err -2
[  126.049120] hub 2-0:1.0: hub_resume
[  126.049132] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[  126.049137] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  126.049149] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[  126.049153] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  126.049163] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[  126.049167] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  126.049176] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2a0
[  126.049181] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[  126.049195] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000

--------------010703020208050807020907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010703020208050807020907--
