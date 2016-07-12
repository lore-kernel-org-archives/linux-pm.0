From: Meelis Roos <mroos@linux.ee>
Subject: 4.7-rc6: NMI in intel_idle on HP Proliant G6
Date: Tue, 12 Jul 2016 15:05:50 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:40432 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbcGLMD5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jul 2016 08:03:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>

On HP Proliant DL360 G6, Debian unstable 4.6 kernel runs fine but 
selfcompiled 4.7-rc6 and 4.7-rc7 sometimes crash with NMI from 
intel_idle. Sometimes it boots fine. With intel_idle disabled, it has 
booted successful so far in 2 tries, one with rc6 and one with rc7.

Screenshot with some backtrace: 
http://kodu.ut.ee/~mroos/intel-idle-NMI.png

ROM setup settings that might be of interest:

Advanced memory protection: advanced ecc support
HP power profile: custom
HP power regulator: hp dynamic power savings mode (not OS control)
Intel qpi link power management: enabled
Minimum processor idle power core state: C6
Minimum processor idle power package state: C6
Dynamic power saving mode response: fast
Collaborative power control: enabled


Full dmesg from successful boot:

[    0.000000] Linux version 4.7.0-rc7-00004-g08d27eb (mroos@dl360g6) (gcc version 5.4.0 20160609 (Debian 5.4.0-6) ) #4 SMP Tue Jul 12 13:51:51 EEST 2016
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.7.0-rc7-00004-g08d27eb root=/dev/sda1 ro
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000df61efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df61f000-0x00000000df62bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000df62c000-0x00000000df62cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df62d000-0x00000000e3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000061fffefff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP ProLiant DL360 G6, BIOS P64 01/22/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x61ffff max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask FFE0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xdf62d max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4f80-0x000f4f8f] mapped at [ffff8800000f4f80]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] BRK [0x025a8000, 0x025a8fff] PGTABLE
[    0.000000] BRK [0x025a9000, 0x025a9fff] PGTABLE
[    0.000000] BRK [0x025aa000, 0x025aafff] PGTABLE
[    0.000000] BRK [0x025ab000, 0x025abfff] PGTABLE
[    0.000000] BRK [0x025ac000, 0x025acfff] PGTABLE
[    0.000000] BRK [0x025ad000, 0x025adfff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F4F00 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x00000000DF620140 0000B4 (v01 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FACP 0x00000000DF620240 0000F4 (v03 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20160422/tbfadt-708)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 32, using default 8 (20160422/tbfadt-708)
[    0.000000] ACPI: DSDT 0x00000000DF620340 00206D (v01 HP     DSDT     00000001 INTL 20030228)
[    0.000000] ACPI: FACS 0x00000000DF61F100 000040
[    0.000000] ACPI: FACS 0x00000000DF61F100 000040
[    0.000000] ACPI: SPCR 0x00000000DF61F140 000050 (v01 HP     SPCRRBSU 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: MCFG 0x00000000DF61F1C0 00003C (v01 HP     ProLiant 00000001      00000000)
[    0.000000] ACPI: HPET 0x00000000DF61F200 000038 (v01 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FFFF 0x00000000DF61F240 000064 (v02 HP     ProLiant 00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: SPMI 0x00000000DF61F2C0 000040 (v05 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: ERST 0x00000000DF61F300 0001D0 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: APIC 0x00000000DF61F500 00015E (v01 HP     ProLiant 00000002      00000000)
[    0.000000] ACPI: SRAT 0x00000000DF61F680 000570 (v01 HP     Proliant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: FFFF 0x00000000DF61FC00 000176 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: BERT 0x00000000DF61FD80 000030 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: HEST 0x00000000DF61FDC0 0000BC (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: DMAR 0x00000000DF61FE80 000164 (v01 HP     ProLiant 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: SSDT 0x00000000DF6223C0 000125 (v03 HP     CRSPCI0  00000002 HP   00000001)
[    0.000000] ACPI: SSDT 0x00000000DF622500 0001CF (v03 HP     riser1a  00000002 INTL 20061109)
[    0.000000] ACPI: SSDT 0x00000000DF622700 0003BB (v01 HP     pcc      00000001 INTL 20090625)
[    0.000000] ACPI: SSDT 0x00000000DF622AC0 000377 (v01 HP     pmab     00000001 INTL 20090625)
[    0.000000] ACPI: SSDT 0x00000000DF622E40 002B64 (v01 INTEL  PPM RCM  00000001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x10 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x11 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x12 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x13 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x14 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x15 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x16 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x17 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0xdfffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x31fffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x320000000-0x61fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xdfffffff] + [mem 0x100000000-0x31fffffff] -> [mem 0x00000000-0x31fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x31fffe000-0x31fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x61fffd000-0x61fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000061fffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000df61efff]
[    0.000000]   node   0: [mem 0x00000000df62c000-0x00000000df62cfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000031fffffff]
[    0.000000]   node   1: [mem 0x0000000320000000-0x000000061fffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000031fffffff]
[    0.000000] On node 0 totalpages: 3143102
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14233 pages used for memmap
[    0.000000]   DMA32 zone: 910880 pages, LIFO batch:31
[    0.000000]   Normal zone: 34816 pages used for memmap
[    0.000000]   Normal zone: 2228224 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000320000000-0x000000061fffefff]
[    0.000000] On node 1 totalpages: 3145727
[    0.000000]   Normal zone: 49152 pages used for memmap
[    0.000000]   Normal zone: 3145727 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x908
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 0, version 32, address 0xfec80000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: 32 Processors exceeds NR_CPUS limit of 16
[    0.000000] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf61f000-0xdf62bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf62d000-0xe3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfee0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee10000-0xff7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.000000] e820: [mem 0xe4000000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:2
[    0.000000] percpu: Embedded 32 pages/cpu @ffff880313c00000 s90712 r8192 d32168 u262144
[    0.000000] pcpu-alloc: s90712 r8192 d32168 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 02 04 06 08 10 12 14 [1] 01 03 05 07 09 11 13 15 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 6190543
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.7.0-rc7-00004-g08d27eb root=/dev/sda1 ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 24671356K/25155316K available (9451K kernel code, 8104K rwdata, 1692K rodata, 944K init, 800K bss, 483960K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:960 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2533.430 MHz processor
[    0.000020] Calibrating delay loop (skipped), value calculated using timer frequency.. 5066.86 BogoMIPS (lpj=10133720)
[    0.000487] pid_max: default: 32768 minimum: 301
[    0.000720] ACPI: Core revision 20160422
[    0.002704] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.010727] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.014542] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.014818] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.015638] CPU: Physical Processor ID: 0
[    0.015865] CPU: Processor Core ID: 0
[    0.016093] mce: CPU supports 9 MCE banks
[    0.016324] CPU0: Thermal monitoring enabled (TM1)
[    0.016563] process: using mwait in idle threads
[    0.016798] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.017035] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.017596] Freeing SMP alternatives memory: 24K (ffffffff824d8000 - ffffffff824de000)
[    0.018158] smpboot: Max logical packages: 8
[    0.018388] smpboot: APIC(0) Converting physical 0 to logical package 0
[    0.018632] smpboot: APIC(10) Converting physical 1 to logical package 1
[    0.018879] DMAR-IR: This system BIOS has enabled interrupt remapping
               on a chipset that contains an erratum making that
               feature unstable.  To maintain system stability
               interrupt remapping is being disabled.  Please
               contact your BIOS vendor for an update
[    0.019910] Switched APIC routing to physical flat.
[    0.020681] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.165846] smpboot: CPU0: Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz (family: 0x6, model: 0x1a, stepping: 0x5)
[    0.166384] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Broken BIOS detected, complain to your hardware vendor.
[    0.166976] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR 38d is 330)
[    0.167395] Intel PMU driver.
[    0.167612] core: CPU erratum AAJ80 worked around
[    0.171487] core: CPUID marked event: 'bus cycles' unavailable
[    0.171731] ... version:                3
[    0.171959] ... bit width:              48
[    0.172186] ... generic registers:      4
[    0.172410] ... value mask:             0000ffffffffffff
[    0.172644] ... max period:             000000007fffffff
[    0.172880] ... fixed-purpose events:   3
[    0.173108] ... event mask:             000000070000000f
[    0.174387] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.174935] x86: Booting SMP configuration:
[    0.175165] .... node  #1, CPUs:        #1
[    0.274374] .... node  #0, CPUs:    #2
[    0.356250] .... node  #1, CPUs:    #3
[    0.436254] .... node  #0, CPUs:    #4
[    0.516237] .... node  #1, CPUs:    #5
[    0.596241] .... node  #0, CPUs:    #6
[    0.676234] .... node  #1, CPUs:    #7
[    0.756230] .... node  #0, CPUs:    #8
[    0.836255] .... node  #1, CPUs:    #9
[    0.916223] .... node  #0, CPUs:   #10
[    0.996227] .... node  #1, CPUs:   #11
[    1.076220] .... node  #0, CPUs:   #12
[    1.156232] .... node  #1, CPUs:   #13
[    1.236218] .... node  #0, CPUs:   #14
[    1.316226] .... node  #1, CPUs:   #15
[    1.395922] x86: Booted up 2 nodes, 16 CPUs
[    1.396356] smpboot: Total of 16 processors activated (81067.44 BogoMIPS)
[    1.411498] devtmpfs: initialized
[    1.412019] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.412034] kworker/u33:0 (108) used greatest stack depth: 13560 bytes left
[    1.412885] NET: Registered protocol family 16
[    1.421838] cpuidle: using governor menu
[    1.422109] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.422523] ACPI: bus type PCI registered
[    1.422845] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000-0xe3ffffff] (base 0xe0000000)
[    1.423271] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in E820
[    1.423518] PCI: Using configuration type 1 for base access
[    1.423755] PCI: HP ProLiant DL360 detected, enabling pci=bfsort.
[    1.468052] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.468562] ACPI: Added _OSI(Module Device)
[    1.468788] ACPI: Added _OSI(Processor Device)
[    1.469015] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.469243] ACPI: Added _OSI(Processor Aggregator Device)
[    1.472005] ACPI: 6 ACPI AML tables successfully acquired and loaded

[    1.473698] ================================================================================
[    1.474120] UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
[    1.474537] index -1 is out of range for type 'acpi_operand_object *[9]'
[    1.474781] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G          I     4.7.0-rc7-00004-g08d27eb #4
[    1.475201] Hardware name: HP ProLiant DL360 G6, BIOS P64 01/22/2015
[    1.475441]  0000000000000036 ffff880311cf3a58 ffffffff81433aaf 000000000000003c
[    1.475993]  ffff880311cf3a80 ffffffffffffffff ffff880311cf3a70 ffffffff8148aa0d
[    1.476544]  ffffffff82056be0 ffff880311cf3ac8 ffffffff8148b125 0000000000000202
[    1.477100] Call Trace:
[    1.477323]  [<ffffffff81433aaf>] dump_stack+0x4e/0x6f
[    1.477561]  [<ffffffff8148aa0d>] ubsan_epilogue+0xd/0x40
[    1.477797]  [<ffffffff8148b125>] __ubsan_handle_out_of_bounds+0x75/0xa0
[    1.478041]  [<ffffffff8100312d>] ? map_vdso+0x11d/0x1b0
[    1.478278]  [<ffffffff81527259>] ? acpi_ut_update_ref_count+0x52/0x335
[    1.478487]  [<ffffffff8150571b>] acpi_ds_create_operand+0x244/0x2e4
[    1.478666]  [<ffffffff815058e3>] acpi_ds_create_operands+0x128/0x179
[    1.478846]  [<ffffffff814ed591>] ? acpi_os_release_object+0x9/0xd
[    1.479025]  [<ffffffff8152a9da>] ? acpi_ut_delete_generic_state+0x18/0x1a
[    1.479204]  [<ffffffff81505f8e>] acpi_ds_exec_end_op+0x109/0x56a
[    1.479381]  [<ffffffff8151e984>] acpi_ps_parse_loop+0x722/0x774
[    1.479621]  [<ffffffff8151f9e0>] acpi_ps_parse_aml+0xa7/0x2d2
[    1.479861]  [<ffffffff8152059e>] acpi_ps_execute_method+0x1e3/0x21d
[    1.480104]  [<ffffffff815186d9>] acpi_ns_evaluate+0x228/0x2b8
[    1.480341]  [<ffffffff8151c575>] acpi_evaluate_object+0x13b/0x255
[    1.480581]  [<ffffffff82439240>] ? acpi_sleep_proc_init+0x28/0x28
[    1.480821]  [<ffffffff814f25fe>] acpi_run_osc+0xfb/0x26d
[    1.481058]  [<ffffffff82439240>] ? acpi_sleep_proc_init+0x28/0x28
[    1.481299]  [<ffffffff8243938b>] acpi_init+0x14b/0x2d5
[    1.481535]  [<ffffffff8100046c>] do_one_initcall+0x5c/0x1e0
[    1.481775]  [<ffffffff82404589>] kernel_init_freeable+0x306/0x39c
[    1.482017]  [<ffffffff8192db0a>] kernel_init+0xa/0x120
[    1.482253]  [<ffffffff81936dbf>] ret_from_fork+0x1f/0x40
[    1.482490]  [<ffffffff8192db00>] ? rest_init+0x80/0x80
[    1.482726] ================================================================================
[    1.485314] ACPI: Interpreter enabled
[    1.485551] ACPI: (supports S0 S4 S5)
[    1.485774] ACPI: Using IOAPIC for interrupt routing
[    1.486027] HEST: Table parsing has been initialized.
[    1.486263] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.490258] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
[    1.490504] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.490931] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.491193] acpi PNP0A08:00: host bridge window expanded to [mem 0xfed00000-0xfed44fff window]; [mem 0xfed00000-0xfed44fff window] ignored
[    1.491702] PCI host bridge to bus 0000:00
[    1.491933] pci_bus 0000:00: root bus resource [mem 0xe7000000-0xfbffffff window]
[    1.492351] pci_bus 0000:00: root bus resource [io  0x1000-0x6fff window]
[    1.492595] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.492839] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.493083] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
[    1.493328] pci_bus 0000:00: root bus resource [mem 0xfed00000-0xfed44fff window]
[    1.493746] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    1.493990] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    1.494233] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.494649] pci_bus 0000:00: root bus resource [bus 00-0f]
[    1.494896] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
[    1.494952] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.495031] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    1.495084] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.495161] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    1.495211] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.495285] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    1.495336] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.495412] pci 0000:00:04.0: [8086:340b] type 01 class 0x060400
[    1.495462] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    1.495536] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
[    1.495586] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    1.495659] pci 0000:00:06.0: [8086:340d] type 01 class 0x060400
[    1.495709] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    1.495783] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    1.495834] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.495915] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    1.495965] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    1.496040] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    1.496090] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    1.496164] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    1.496215] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.496290] pci 0000:00:0d.0: [8086:343a] type 00 class 0x060000
[    1.496389] pci 0000:00:0d.1: [8086:343b] type 00 class 0x060000
[    1.496487] pci 0000:00:0d.2: [8086:343c] type 00 class 0x060000
[    1.496581] pci 0000:00:0d.3: [8086:343d] type 00 class 0x060000
[    1.496675] pci 0000:00:0d.4: [8086:3418] type 00 class 0x060000
[    1.496770] pci 0000:00:0d.5: [8086:3419] type 00 class 0x060000
[    1.496865] pci 0000:00:0d.6: [8086:341a] type 00 class 0x060000
[    1.496962] pci 0000:00:0e.0: [8086:341c] type 00 class 0x060000
[    1.497057] pci 0000:00:0e.1: [8086:341d] type 00 class 0x060000
[    1.497152] pci 0000:00:0e.2: [8086:341e] type 00 class 0x060000
[    1.497249] pci 0000:00:0e.3: [8086:341f] type 00 class 0x060000
[    1.497343] pci 0000:00:0e.4: [8086:3439] type 00 class 0x060000
[    1.497440] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    1.497542] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    1.497639] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    1.497749] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    1.497813] pci 0000:00:1d.0: reg 0x20: [io  0x1000-0x101f]
[    1.497927] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    1.497991] pci 0000:00:1d.1: reg 0x20: [io  0x1020-0x103f]
[    1.498105] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    1.498170] pci 0000:00:1d.2: reg 0x20: [io  0x1040-0x105f]
[    1.498288] pci 0000:00:1d.3: [8086:3a39] type 00 class 0x0c0300
[    1.498351] pci 0000:00:1d.3: reg 0x20: [io  0x1060-0x107f]
[    1.498466] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    1.498486] pci 0000:00:1d.7: reg 0x10: [mem 0xf5df0000-0xf5df03ff]
[    1.498566] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.498633] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.498738] pci 0000:00:1f.0: [8086:3a18] type 00 class 0x060100
[    1.498889] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
[    1.498902] pci 0000:00:1f.2: reg 0x10: [io  0x1080-0x1087]
[    1.498910] pci 0000:00:1f.2: reg 0x14: [io  0x1088-0x108b]
[    1.498917] pci 0000:00:1f.2: reg 0x18: [io  0x1090-0x1097]
[    1.498924] pci 0000:00:1f.2: reg 0x1c: [io  0x1098-0x109b]
[    1.498932] pci 0000:00:1f.2: reg 0x20: [io  0x10a0-0x10af]
[    1.498939] pci 0000:00:1f.2: reg 0x24: [io  0x10b0-0x10bf]
[    1.499064] pci 0000:03:00.0: [103c:323a] type 00 class 0x010400
[    1.499079] pci 0000:03:00.0: reg 0x10: [mem 0xfbc00000-0xfbdfffff 64bit]
[    1.499090] pci 0000:03:00.0: reg 0x18: [mem 0xfbbf0000-0xfbbf0fff 64bit]
[    1.499097] pci 0000:03:00.0: reg 0x20: [io  0x4000-0x40ff]
[    1.499110] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.499148] pci 0000:03:00.0: PME# supported from D0
[    1.507900] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.508140] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    1.508143] pci 0000:00:01.0:   bridge window [mem 0xfbb00000-0xfbdfffff]
[    1.508185] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.508513] pci 0000:07:00.0: [1077:2432] type 00 class 0x0c0400
[    1.508529] pci 0000:07:00.0: reg 0x10: [io  0x6000-0x60ff]
[    1.508542] pci 0000:07:00.0: reg 0x14: [mem 0xfbff0000-0xfbff3fff 64bit]
[    1.508573] pci 0000:07:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.508701] pci 0000:07:00.1: [1077:2432] type 00 class 0x0c0400
[    1.508716] pci 0000:07:00.1: reg 0x10: [io  0x6400-0x64ff]
[    1.508729] pci 0000:07:00.1: reg 0x14: [mem 0xfbfe0000-0xfbfe3fff 64bit]
[    1.508760] pci 0000:07:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.515906] pci 0000:00:03.0: PCI bridge to [bus 07-09]
[    1.516146] pci 0000:00:03.0:   bridge window [io  0x6000-0x6fff]
[    1.516149] pci 0000:00:03.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    1.516190] pci 0000:00:04.0: PCI bridge to [bus 0b]
[    1.516464] pci 0000:00:05.0: PCI bridge to [bus 0c]
[    1.516735] pci 0000:00:06.0: PCI bridge to [bus 0d]
[    1.517012] pci 0000:00:07.0: PCI bridge to [bus 0e]
[    1.517292] pci 0000:02:00.0: [14e4:1639] type 00 class 0x020000
[    1.517309] pci 0000:02:00.0: reg 0x10: [mem 0xf8000000-0xf9ffffff 64bit]
[    1.517340] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.517396] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.517464] pci 0000:02:00.1: [14e4:1639] type 00 class 0x020000
[    1.517480] pci 0000:02:00.1: reg 0x10: [mem 0xf6000000-0xf7ffffff 64bit]
[    1.517511] pci 0000:02:00.1: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.517566] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
[    1.523907] pci 0000:00:08.0: PCI bridge to [bus 02]
[    1.524149] pci 0000:00:08.0:   bridge window [mem 0xf6000000-0xf9ffffff]
[    1.524294] pci 0000:04:00.0: [8086:105e] type 00 class 0x020000
[    1.524312] pci 0000:04:00.0: reg 0x10: [mem 0xfbee0000-0xfbefffff]
[    1.524324] pci 0000:04:00.0: reg 0x14: [mem 0xfbec0000-0xfbedffff]
[    1.524335] pci 0000:04:00.0: reg 0x18: [io  0x5000-0x501f]
[    1.524369] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.524423] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.524543] pci 0000:04:00.1: [8086:105e] type 00 class 0x020000
[    1.524560] pci 0000:04:00.1: reg 0x10: [mem 0xfbea0000-0xfbebffff]
[    1.524572] pci 0000:04:00.1: reg 0x14: [mem 0xfbe80000-0xfbe9ffff]
[    1.524583] pci 0000:04:00.1: reg 0x18: [io  0x5020-0x503f]
[    1.524617] pci 0000:04:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.524670] pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
[    1.531908] pci 0000:00:09.0: PCI bridge to [bus 04-06]
[    1.532150] pci 0000:00:09.0:   bridge window [io  0x5000-0x5fff]
[    1.532155] pci 0000:00:09.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.532214] pci 0000:00:0a.0: PCI bridge to [bus 0f]
[    1.532519] pci 0000:01:03.0: [1002:515e] type 00 class 0x030000
[    1.532540] pci 0000:01:03.0: reg 0x10: [mem 0xe8000000-0xefffffff pref]
[    1.532552] pci 0000:01:03.0: reg 0x14: [io  0x3000-0x30ff]
[    1.532565] pci 0000:01:03.0: reg 0x18: [mem 0xf5ff0000-0xf5ffffff]
[    1.532604] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.532642] pci 0000:01:03.0: supports D1 D2
[    1.532710] pci 0000:01:04.0: [0e11:b203] type 00 class 0x088000
[    1.532735] pci 0000:01:04.0: reg 0x10: [io  0x2800-0x28ff]
[    1.532750] pci 0000:01:04.0: reg 0x14: [mem 0xf5fe0000-0xf5fe01ff]
[    1.532832] pci 0000:01:04.0: PME# supported from D0 D3hot D3cold
[    1.532923] pci 0000:01:04.2: [0e11:b204] type 00 class 0x088000
[    1.532945] pci 0000:01:04.2: reg 0x10: [io  0x3400-0x34ff]
[    1.532959] pci 0000:01:04.2: reg 0x14: [mem 0xf5fd0000-0xf5fd07ff]
[    1.532972] pci 0000:01:04.2: reg 0x18: [mem 0xf5fc0000-0xf5fc3fff]
[    1.532985] pci 0000:01:04.2: reg 0x1c: [mem 0xf5f00000-0xf5f7ffff]
[    1.533018] pci 0000:01:04.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.533059] pci 0000:01:04.2: PME# supported from D0 D3hot D3cold
[    1.533141] pci 0000:01:04.4: [103c:3300] type 00 class 0x0c0300
[    1.533202] pci 0000:01:04.4: reg 0x20: [io  0x3800-0x381f]
[    1.533263] pci 0000:01:04.4: PME# supported from D0 D3hot D3cold
[    1.533340] pci 0000:01:04.6: [103c:3302] type 00 class 0x0c0701
[    1.533360] pci 0000:01:04.6: reg 0x10: [mem 0xf5ef0000-0xf5ef00ff]
[    1.533449] pci 0000:01:04.6: PME# supported from D0 D3hot D3cold
[    1.533555] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
[    1.533806] pci 0000:00:1e.0:   bridge window [io  0x2000-0x3fff]
[    1.533812] pci 0000:00:1e.0:   bridge window [mem 0xf5e00000-0xf5ffffff]
[    1.533819] pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
[    1.533822] pci 0000:00:1e.0:   bridge window [mem 0xe7000000-0xfbffffff window] (subtractive decode)
[    1.533826] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff window] (subtractive decode)
[    1.533829] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    1.533832] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    1.533835] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x0fff window] (subtractive decode)
[    1.533839] pci 0000:00:1e.0:   bridge window [mem 0xfed00000-0xfed44fff window] (subtractive decode)
[    1.533842] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03bb window] (subtractive decode)
[    1.533845] pci 0000:00:1e.0:   bridge window [io  0x03c0-0x03df window] (subtractive decode)
[    1.533848] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    1.534427] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *7 10 11)
[    1.534969] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
[    1.535506] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10 11) *0, disabled.
[    1.536130] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
[    1.536752] ACPI: PCI Interrupt Link [LNKE] (IRQs *5 7 10 11)
[    1.537288] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 *10 11)
[    1.537825] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 *10 11)
[    1.538361] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 *7 10 11)
[    1.539082] vgaarb: setting as boot device: PCI:0000:01:03.0
[    1.539324] vgaarb: device added: PCI:0000:01:03.0,decodes=io+mem,owns=io+mem,locks=none
[    1.539748] vgaarb: loaded
[    1.539975] vgaarb: bridge control possible 0000:01:03.0
[    1.540308] SCSI subsystem initialized
[    1.540541] ACPI: bus type USB registered
[    1.540800] usbcore: registered new interface driver usbfs
[    1.541055] usbcore: registered new interface driver hub
[    1.541361] usbcore: registered new device driver usb
[    1.541629] pps_core: LinuxPPS API ver. 1 registered
[    1.541862] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.542300] PTP clock support registered
[    1.542551] PCI: Using ACPI for IRQ routing
[    1.544167] PCI: Discovered peer bus 3e
[    1.544396] PCI: root bus 3e: using default resources
[    1.544398] PCI: Probing PCI hardware (bus 3e)
[    1.544442] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.544678] PCI host bridge to bus 0000:3e
[    1.544910] pci_bus 0000:3e: root bus resource [io  0x0000-0xffff]
[    1.545154] pci_bus 0000:3e: root bus resource [mem 0x00000000-0xffffffffff]
[    1.545403] pci_bus 0000:3e: No busn resource found for root bus, will use [bus 3e-ff]
[    1.545832] pci 0000:3e:00.0: [8086:2c40] type 00 class 0x060000
[    1.545907] pci 0000:3e:00.1: [8086:2c01] type 00 class 0x060000
[    1.545979] pci 0000:3e:02.0: [8086:2c10] type 00 class 0x060000
[    1.546048] pci 0000:3e:02.1: [8086:2c11] type 00 class 0x060000
[    1.546118] pci 0000:3e:02.4: [8086:2c14] type 00 class 0x060000
[    1.546187] pci 0000:3e:02.5: [8086:2c15] type 00 class 0x060000
[    1.546257] pci 0000:3e:03.0: [8086:2c18] type 00 class 0x060000
[    1.546328] pci 0000:3e:03.1: [8086:2c19] type 00 class 0x060000
[    1.546398] pci 0000:3e:03.2: [8086:2c1a] type 00 class 0x060000
[    1.546468] pci 0000:3e:03.4: [8086:2c1c] type 00 class 0x060000
[    1.546540] pci 0000:3e:04.0: [8086:2c20] type 00 class 0x060000
[    1.546608] pci 0000:3e:04.1: [8086:2c21] type 00 class 0x060000
[    1.546676] pci 0000:3e:04.2: [8086:2c22] type 00 class 0x060000
[    1.546745] pci 0000:3e:04.3: [8086:2c23] type 00 class 0x060000
[    1.546819] pci 0000:3e:05.0: [8086:2c28] type 00 class 0x060000
[    1.546889] pci 0000:3e:05.1: [8086:2c29] type 00 class 0x060000
[    1.546959] pci 0000:3e:05.2: [8086:2c2a] type 00 class 0x060000
[    1.547029] pci 0000:3e:05.3: [8086:2c2b] type 00 class 0x060000
[    1.547102] pci 0000:3e:06.0: [8086:2c30] type 00 class 0x060000
[    1.547182] pci 0000:3e:06.1: [8086:2c31] type 00 class 0x060000
[    1.547253] pci 0000:3e:06.2: [8086:2c32] type 00 class 0x060000
[    1.547323] pci 0000:3e:06.3: [8086:2c33] type 00 class 0x060000
[    1.547423] pci_bus 0000:3e: busn_res: [bus 3e-ff] end is updated to 3e
[    1.547435] PCI: Discovered peer bus 3f
[    1.547632] PCI: root bus 3f: using default resources
[    1.547634] PCI: Probing PCI hardware (bus 3f)
[    1.547674] ACPI: \: failed to evaluate _DSM (0x1001)
[    1.547855] PCI host bridge to bus 0000:3f
[    1.548042] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    1.548228] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xffffffffff]
[    1.548415] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    1.548774] pci 0000:3f:00.0: [8086:2c40] type 00 class 0x060000
[    1.548849] pci 0000:3f:00.1: [8086:2c01] type 00 class 0x060000
[    1.548920] pci 0000:3f:02.0: [8086:2c10] type 00 class 0x060000
[    1.548985] pci 0000:3f:02.1: [8086:2c11] type 00 class 0x060000
[    1.549056] pci 0000:3f:02.4: [8086:2c14] type 00 class 0x060000
[    1.549123] pci 0000:3f:02.5: [8086:2c15] type 00 class 0x060000
[    1.549191] pci 0000:3f:03.0: [8086:2c18] type 00 class 0x060000
[    1.549257] pci 0000:3f:03.1: [8086:2c19] type 00 class 0x060000
[    1.549325] pci 0000:3f:03.2: [8086:2c1a] type 00 class 0x060000
[    1.549393] pci 0000:3f:03.4: [8086:2c1c] type 00 class 0x060000
[    1.549462] pci 0000:3f:04.0: [8086:2c20] type 00 class 0x060000
[    1.549527] pci 0000:3f:04.1: [8086:2c21] type 00 class 0x060000
[    1.549605] pci 0000:3f:04.2: [8086:2c22] type 00 class 0x060000
[    1.549676] pci 0000:3f:04.3: [8086:2c23] type 00 class 0x060000
[    1.549745] pci 0000:3f:05.0: [8086:2c28] type 00 class 0x060000
[    1.549812] pci 0000:3f:05.1: [8086:2c29] type 00 class 0x060000
[    1.549879] pci 0000:3f:05.2: [8086:2c2a] type 00 class 0x060000
[    1.549958] pci 0000:3f:05.3: [8086:2c2b] type 00 class 0x060000
[    1.550029] pci 0000:3f:06.0: [8086:2c30] type 00 class 0x060000
[    1.550096] pci 0000:3f:06.1: [8086:2c31] type 00 class 0x060000
[    1.550164] pci 0000:3f:06.2: [8086:2c32] type 00 class 0x060000
[    1.550232] pci 0000:3f:06.3: [8086:2c33] type 00 class 0x060000
[    1.550320] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    1.550334] PCI: pci_cache_line_size set to 64 bytes
[    1.550498] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    1.550501] e820: reserve RAM buffer [mem 0xdf61f000-0xdfffffff]
[    1.550504] e820: reserve RAM buffer [mem 0xdf62d000-0xdfffffff]
[    1.550506] e820: reserve RAM buffer [mem 0x61ffff000-0x61fffffff]
[    1.550845] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    1.551096] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.551515] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    1.554481] amd_nb: Cannot enumerate AMD northbridges
[    1.554753] clocksource: Switched to clocksource hpet
[    1.555140] pnp: PnP ACPI init
[    1.555721] system 00:00: [io  0x0408-0x040f] has been reserved
[    1.555975] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    1.556216] system 00:00: [io  0x0700-0x071f] has been reserved
[    1.556457] system 00:00: [io  0x0880-0x08ff] has been reserved
[    1.556698] system 00:00: [io  0x0900-0x097f] has been reserved
[    1.556941] system 00:00: [io  0x0c80-0x0c83] has been reserved
[    1.557183] system 00:00: [io  0x0cd4-0x0cd7] has been reserved
[    1.557427] system 00:00: [io  0x0f50-0x0f58] has been reserved
[    1.557669] system 00:00: [io  0x0ca0-0x0ca1] has been reserved
[    1.557925] system 00:00: [io  0x0ca4-0x0ca5] has been reserved
[    1.561770] system 00:00: [io  0x02f8-0x02ff] has been reserved
[    1.562014] system 00:00: [mem 0xe0000000-0xe3ffffff] has been reserved
[    1.562263] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    1.562509] system 00:00: [mem 0xe7ffe000-0xe7ffffff] has been reserved
[    1.562780] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.562864] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.562909] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    1.563209] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    1.563306] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.563547] pnp: PnP ACPI: found 5 devices
[    1.570719] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.571256] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbb00000-0xfbb7ffff pref]
[    1.571673] pci 0000:00:01.0: PCI bridge to [bus 03]
[    1.571909] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    1.572153] pci 0000:00:01.0:   bridge window [mem 0xfbb00000-0xfbdfffff]
[    1.572403] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.572641] pci 0000:07:00.0: BAR 6: assigned [mem 0xfbf00000-0xfbf3ffff pref]
[    1.573057] pci 0000:07:00.1: BAR 6: assigned [mem 0xfbf40000-0xfbf7ffff pref]
[    1.573474] pci 0000:00:03.0: PCI bridge to [bus 07-09]
[    1.573710] pci 0000:00:03.0:   bridge window [io  0x6000-0x6fff]
[    1.573953] pci 0000:00:03.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    1.574203] pci 0000:00:04.0: PCI bridge to [bus 0b]
[    1.574443] pci 0000:00:05.0: PCI bridge to [bus 0c]
[    1.574683] pci 0000:00:06.0: PCI bridge to [bus 0d]
[    1.574949] pci 0000:00:07.0: PCI bridge to [bus 0e]
[    1.575188] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00010000 pref]
[    1.575435] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x00010000 pref]
[    1.575853] pci 0000:02:00.1: BAR 6: no space for [mem size 0x00010000 pref]
[    1.576101] pci 0000:02:00.1: BAR 6: failed to assign [mem size 0x00010000 pref]
[    1.576520] pci 0000:00:08.0: PCI bridge to [bus 02]
[    1.576756] pci 0000:00:08.0:   bridge window [mem 0xf6000000-0xf9ffffff]
[    1.577006] pci 0000:04:00.0: BAR 6: assigned [mem 0xfbe00000-0xfbe1ffff pref]
[    1.577423] pci 0000:04:00.1: BAR 6: assigned [mem 0xfbe20000-0xfbe3ffff pref]
[    1.577841] pci 0000:00:09.0: PCI bridge to [bus 04-06]
[    1.578077] pci 0000:00:09.0:   bridge window [io  0x5000-0x5fff]
[    1.578321] pci 0000:00:09.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.578571] pci 0000:00:0a.0: PCI bridge to [bus 0f]
[    1.578833] pci 0000:01:03.0: BAR 6: assigned [mem 0xf5e00000-0xf5e1ffff pref]
[    1.579251] pci 0000:01:04.2: BAR 6: assigned [mem 0xf5e20000-0xf5e2ffff pref]
[    1.579668] pci 0000:00:1e.0: PCI bridge to [bus 01]
[    1.579904] pci 0000:00:1e.0:   bridge window [io  0x2000-0x3fff]
[    1.580148] pci 0000:00:1e.0:   bridge window [mem 0xf5e00000-0xf5ffffff]
[    1.580396] pci 0000:00:1e.0:   bridge window [mem 0xe8000000-0xefffffff 64bit pref]
[    1.580821] pci_bus 0000:00: resource 4 [mem 0xe7000000-0xfbffffff window]
[    1.580823] pci_bus 0000:00: resource 5 [io  0x1000-0x6fff window]
[    1.580825] pci_bus 0000:00: resource 6 [io  0x0000-0x03af window]
[    1.580827] pci_bus 0000:00: resource 7 [io  0x03e0-0x0cf7 window]
[    1.580829] pci_bus 0000:00: resource 8 [io  0x0d00-0x0fff window]
[    1.580832] pci_bus 0000:00: resource 9 [mem 0xfed00000-0xfed44fff window]
[    1.580833] pci_bus 0000:00: resource 10 [io  0x03b0-0x03bb window]
[    1.580836] pci_bus 0000:00: resource 11 [io  0x03c0-0x03df window]
[    1.580838] pci_bus 0000:00: resource 12 [mem 0x000a0000-0x000bffff window]
[    1.580840] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    1.580842] pci_bus 0000:03: resource 1 [mem 0xfbb00000-0xfbdfffff]
[    1.580844] pci_bus 0000:07: resource 0 [io  0x6000-0x6fff]
[    1.580846] pci_bus 0000:07: resource 1 [mem 0xfbf00000-0xfbffffff]
[    1.580848] pci_bus 0000:02: resource 1 [mem 0xf6000000-0xf9ffffff]
[    1.580851] pci_bus 0000:04: resource 0 [io  0x5000-0x5fff]
[    1.580853] pci_bus 0000:04: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.580855] pci_bus 0000:01: resource 0 [io  0x2000-0x3fff]
[    1.580857] pci_bus 0000:01: resource 1 [mem 0xf5e00000-0xf5ffffff]
[    1.580859] pci_bus 0000:01: resource 2 [mem 0xe8000000-0xefffffff 64bit pref]
[    1.580861] pci_bus 0000:01: resource 4 [mem 0xe7000000-0xfbffffff window]
[    1.580863] pci_bus 0000:01: resource 5 [io  0x1000-0x6fff window]
[    1.580865] pci_bus 0000:01: resource 6 [io  0x0000-0x03af window]
[    1.580867] pci_bus 0000:01: resource 7 [io  0x03e0-0x0cf7 window]
[    1.580869] pci_bus 0000:01: resource 8 [io  0x0d00-0x0fff window]
[    1.580871] pci_bus 0000:01: resource 9 [mem 0xfed00000-0xfed44fff window]
[    1.580873] pci_bus 0000:01: resource 10 [io  0x03b0-0x03bb window]
[    1.580875] pci_bus 0000:01: resource 11 [io  0x03c0-0x03df window]
[    1.580877] pci_bus 0000:01: resource 12 [mem 0x000a0000-0x000bffff window]
[    1.580886] pci_bus 0000:3e: resource 4 [io  0x0000-0xffff]
[    1.580888] pci_bus 0000:3e: resource 5 [mem 0x00000000-0xffffffffff]
[    1.580896] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    1.580898] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xffffffffff]
[    1.580951] NET: Registered protocol family 2
[    1.581482] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.582373] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.582717] TCP: Hash tables configured (established 262144 bind 65536)
[    1.582977] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    1.583268] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    1.583675] NET: Registered protocol family 1
[    1.602891] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.604131] PCI: CLS 64 bytes, default 64
[    1.604166] DMAR: Host address width 39
[    1.604340] DMAR: DRHD base: 0x000000e7ffe000 flags: 0x1
[    1.604522] DMAR: dmar0: reg_base_addr e7ffe000 ver 1:0 cap c90780106f0462 ecap f0207e
[    1.604829] DMAR: RMRR base: 0x000000df7fc000 end: 0x000000df7fdfff
[    1.605007] DMAR: RMRR base: 0x000000df7f5000 end: 0x000000df7fafff
[    1.605184] DMAR: RMRR base: 0x000000df63e000 end: 0x000000df63ffff
[    1.605360] DMAR: ATSR flags: 0x0
[    1.608685] DMAR: dmar0: Using Queued invalidation
[    1.608891] DMAR: Setting RMRR:
[    1.609194] DMAR: Setting identity map for device 0000:01:04.0 [0xdf63e000 - 0xdf63ffff]
[    1.609523] DMAR: Setting identity map for device 0000:01:04.2 [0xdf63e000 - 0xdf63ffff]
[    1.609944] DMAR: Setting identity map for device 0000:03:00.0 [0xdf63e000 - 0xdf63ffff]
[    1.610387] DMAR: Setting identity map for device 0000:04:00.0 [0xdf63e000 - 0xdf63ffff]
[    1.610873] DMAR: Setting identity map for device 0000:04:00.1 [0xdf63e000 - 0xdf63ffff]
[    1.611342] DMAR: Setting identity map for device 0000:07:00.0 [0xdf63e000 - 0xdf63ffff]
[    1.611799] DMAR: Setting identity map for device 0000:07:00.1 [0xdf63e000 - 0xdf63ffff]
[    1.612259] DMAR: Setting identity map for device 0000:00:1d.0 [0xdf7f5000 - 0xdf7fafff]
[    1.612718] DMAR: Setting identity map for device 0000:00:1d.1 [0xdf7f5000 - 0xdf7fafff]
[    1.613168] DMAR: Setting identity map for device 0000:00:1d.2 [0xdf7f5000 - 0xdf7fafff]
[    1.613619] DMAR: Setting identity map for device 0000:00:1d.3 [0xdf7f5000 - 0xdf7fafff]
[    1.613949] DMAR: Setting identity map for device 0000:01:04.0 [0xdf7f5000 - 0xdf7fafff]
[    1.614260] DMAR: Setting identity map for device 0000:01:04.2 [0xdf7f5000 - 0xdf7fafff]
[    1.614571] DMAR: Setting identity map for device 0000:01:04.4 [0xdf7f5000 - 0xdf7fafff]
[    1.615024] DMAR: Setting identity map for device 0000:00:1d.7 [0xdf7fc000 - 0xdf7fdfff]
[    1.615355] DMAR: Prepare 0-16MiB unity mapping for LPC
[    1.615642] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    1.616105] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.616383] iommu: Adding device 0000:00:00.0 to group 0
[    1.616580] iommu: Adding device 0000:00:01.0 to group 1
[    1.616772] iommu: Adding device 0000:00:02.0 to group 2
[    1.616966] iommu: Adding device 0000:00:03.0 to group 3
[    1.617157] iommu: Adding device 0000:00:04.0 to group 4
[    1.617350] iommu: Adding device 0000:00:05.0 to group 5
[    1.617541] iommu: Adding device 0000:00:06.0 to group 6
[    1.617733] iommu: Adding device 0000:00:07.0 to group 7
[    1.617923] iommu: Adding device 0000:00:08.0 to group 8
[    1.618116] iommu: Adding device 0000:00:09.0 to group 9
[    1.618307] iommu: Adding device 0000:00:0a.0 to group 10
[    1.618573] iommu: Adding device 0000:00:0d.0 to group 11
[    1.618779] iommu: Adding device 0000:00:0d.1 to group 11
[    1.618968] iommu: Adding device 0000:00:0d.2 to group 11
[    1.619156] iommu: Adding device 0000:00:0d.3 to group 11
[    1.619344] iommu: Adding device 0000:00:0d.4 to group 11
[    1.619533] iommu: Adding device 0000:00:0d.5 to group 11
[    1.619727] iommu: Adding device 0000:00:0d.6 to group 11
[    1.619971] iommu: Adding device 0000:00:0e.0 to group 12
[    1.620166] iommu: Adding device 0000:00:0e.1 to group 12
[    1.620358] iommu: Adding device 0000:00:0e.2 to group 12
[    1.620551] iommu: Adding device 0000:00:0e.3 to group 12
[    1.620742] iommu: Adding device 0000:00:0e.4 to group 12
[    1.620962] iommu: Adding device 0000:00:14.0 to group 13
[    1.621158] iommu: Adding device 0000:00:14.1 to group 13
[    1.621354] iommu: Adding device 0000:00:14.2 to group 13
[    1.621596] iommu: Adding device 0000:00:1d.0 to group 14
[    1.621787] iommu: Adding device 0000:00:1d.1 to group 14
[    1.621977] iommu: Adding device 0000:00:1d.2 to group 14
[    1.622167] iommu: Adding device 0000:00:1d.3 to group 14
[    1.622358] iommu: Adding device 0000:00:1d.7 to group 14
[    1.622549] iommu: Adding device 0000:00:1e.0 to group 15
[    1.622770] iommu: Adding device 0000:00:1f.0 to group 16
[    1.622966] iommu: Adding device 0000:00:1f.2 to group 16
[    1.623150] iommu: Adding device 0000:01:03.0 to group 15
[    1.623333] iommu: Adding device 0000:01:04.0 to group 15
[    1.623511] iommu: Adding device 0000:01:04.2 to group 15
[    1.623689] iommu: Adding device 0000:01:04.4 to group 15
[    1.623867] iommu: Adding device 0000:01:04.6 to group 15
[    1.624084] iommu: Adding device 0000:02:00.0 to group 17
[    1.624285] iommu: Adding device 0000:02:00.1 to group 17
[    1.624479] iommu: Adding device 0000:03:00.0 to group 18
[    1.624673] iommu: Adding device 0000:04:00.0 to group 19
[    1.624866] iommu: Adding device 0000:04:00.1 to group 20
[    1.625081] iommu: Adding device 0000:07:00.0 to group 21
[    1.625281] iommu: Adding device 0000:07:00.1 to group 21
[    1.625491] iommu: Adding device 0000:3e:00.0 to group 22
[    1.625685] iommu: Adding device 0000:3e:00.1 to group 22
[    1.625914] iommu: Adding device 0000:3e:02.0 to group 23
[    1.626108] iommu: Adding device 0000:3e:02.1 to group 23
[    1.626302] iommu: Adding device 0000:3e:02.4 to group 23
[    1.626495] iommu: Adding device 0000:3e:02.5 to group 23
[    1.626723] iommu: Adding device 0000:3e:03.0 to group 24
[    1.626935] iommu: Adding device 0000:3e:03.1 to group 24
[    1.627130] iommu: Adding device 0000:3e:03.2 to group 24
[    1.627326] iommu: Adding device 0000:3e:03.4 to group 24
[    1.627555] iommu: Adding device 0000:3e:04.0 to group 25
[    1.627750] iommu: Adding device 0000:3e:04.1 to group 25
[    1.627945] iommu: Adding device 0000:3e:04.2 to group 25
[    1.628140] iommu: Adding device 0000:3e:04.3 to group 25
[    1.628369] iommu: Adding device 0000:3e:05.0 to group 26
[    1.628565] iommu: Adding device 0000:3e:05.1 to group 26
[    1.628760] iommu: Adding device 0000:3e:05.2 to group 26
[    1.628957] iommu: Adding device 0000:3e:05.3 to group 26
[    1.629185] iommu: Adding device 0000:3e:06.0 to group 27
[    1.629382] iommu: Adding device 0000:3e:06.1 to group 27
[    1.629577] iommu: Adding device 0000:3e:06.2 to group 27
[    1.629772] iommu: Adding device 0000:3e:06.3 to group 27
[    1.629982] iommu: Adding device 0000:3f:00.0 to group 28
[    1.630177] iommu: Adding device 0000:3f:00.1 to group 28
[    1.630406] iommu: Adding device 0000:3f:02.0 to group 29
[    1.630602] iommu: Adding device 0000:3f:02.1 to group 29
[    1.630811] iommu: Adding device 0000:3f:02.4 to group 29
[    1.631008] iommu: Adding device 0000:3f:02.5 to group 29
[    1.631236] iommu: Adding device 0000:3f:03.0 to group 30
[    1.631433] iommu: Adding device 0000:3f:03.1 to group 30
[    1.631630] iommu: Adding device 0000:3f:03.2 to group 30
[    1.635279] iommu: Adding device 0000:3f:03.4 to group 30
[    1.635509] iommu: Adding device 0000:3f:04.0 to group 31
[    1.635703] iommu: Adding device 0000:3f:04.1 to group 31
[    1.635895] iommu: Adding device 0000:3f:04.2 to group 31
[    1.636088] iommu: Adding device 0000:3f:04.3 to group 31
[    1.636313] iommu: Adding device 0000:3f:05.0 to group 32
[    1.636512] iommu: Adding device 0000:3f:05.1 to group 32
[    1.636709] iommu: Adding device 0000:3f:05.2 to group 32
[    1.636906] iommu: Adding device 0000:3f:05.3 to group 32
[    1.637133] iommu: Adding device 0000:3f:06.0 to group 33
[    1.637329] iommu: Adding device 0000:3f:06.1 to group 33
[    1.637528] iommu: Adding device 0000:3f:06.2 to group 33
[    1.637725] iommu: Adding device 0000:3f:06.3 to group 33
[    1.640599] Scanning for low memory corruption every 60 seconds
[    1.641213] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    1.641796] workingset: timestamp_bits=58 max_order=23 bucket_order=0
[    1.644255] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.644569] io scheduler noop registered
[    1.644741] io scheduler deadline registered
[    1.644947] io scheduler cfq registered (default)
[    1.645553] intel_idle: MWAIT substates: 0x1120
[    1.645555] intel_idle: v0.4.1 model 0x1A
[    1.646108] intel_idle: lapic_timer_reliable_states 0x2
[    1.646189] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.646506] ACPI: Power Button [PWRF]
[    1.647481] thermal LNXTHERM:00: registered as thermal_zone0
[    1.647664] ACPI: Thermal Zone [THM0] (8 C)
[    1.647886] ERST: Failed to get Error Log Address Range.
[    1.648160] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    1.648574] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.669200] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.689949] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.691516] Non-volatile memory driver v1.3
[    1.692083] Linux agpgart interface v0.103
[    1.692315] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    1.692665] [drm] Initialized drm 1.1.0 20060810
[    1.699832] loop: module loaded
[    1.700098] HP HPSA Driver (v 3.4.16-0)
[    1.700294] hpsa 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.700714] hpsa 0000:03:00.0: MSI-X capable controller
[    1.701055] hpsa 0000:03:00.0: Logical aborts not supported
[    1.701235] hpsa 0000:03:00.0: HP SSD Smart Path aborts not supported
[    1.731579] scsi host0: hpsa
[    1.732450] tun: Universal TUN/TAP device driver, 1.6
[    1.732635] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.733023] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.733214] ehci-pci: EHCI PCI platform driver
[    1.733611] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.733799] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    1.734127] ehci-pci 0000:00:1d.7: debug port 1
[    1.738226] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    1.738243] ehci-pci 0000:00:1d.7: irq 20, io mem 0xf5df0000
[    1.742740] hpsa 0000:03:00.0: scsi 0:0:0:0: added RAID              HP       P410i            controller SSDSmartPathCap- En- Exp=1
[    1.743131] hpsa 0000:03:00.0: scsi 0:0:1:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    1.743458] hpsa 0000:03:00.0: scsi 0:0:2:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    1.743781] hpsa 0000:03:00.0: scsi 0:0:3:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    1.744106] hpsa 0000:03:00.0: scsi 0:0:4:0: masked Direct-Access     HP       DH072ABAA6       PHYS DRV SSDSmartPathCap- En- Exp=0
[    1.744430] hpsa 0000:03:00.0: scsi 0:0:5:0: masked Enclosure         PMCSIERA  SRC 8x6G        enclosure SSDSmartPathCap- En- Exp=0
[    1.744755] hpsa 0000:03:00.0: scsi 0:1:0:0: added Direct-Access     HP       LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    1.746008] scsi 0:0:0:0: RAID              HP       P410i            6.64 PQ: 0 ANSI: 5
[    1.747065] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.747876] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.748061] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.748378] usb usb1: Product: EHCI Host Controller
[    1.748557] usb usb1: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb ehci_hcd
[    1.748744] usb usb1: SerialNumber: 0000:00:1d.7
[    1.749271] hub 1-0:1.0: USB hub found
[    1.749512] hub 1-0:1.0: 8 ports detected
[    1.750520] uhci_hcd: USB Universal Host Controller Interface driver
[    1.750940] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.751138] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.751461] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.751659] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001000
[    1.752009] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.752195] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.752505] usb usb2: Product: UHCI Host Controller
[    1.752679] usb usb2: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb uhci_hcd
[    1.752858] usb usb2: SerialNumber: 0000:00:1d.0
[    1.753317] hub 2-0:1.0: USB hub found
[    1.753506] hub 2-0:1.0: 2 ports detected
[    1.753963] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.754150] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    1.754471] uhci_hcd 0000:00:1d.1: detected 2 ports
[    1.754678] uhci_hcd 0000:00:1d.1: irq 23, io base 0x00001020
[    1.754983] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.755176] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.755491] usb usb3: Product: UHCI Host Controller
[    1.755669] usb usb3: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb uhci_hcd
[    1.755852] usb usb3: SerialNumber: 0000:00:1d.1
[    1.756336] hub 3-0:1.0: USB hub found
[    1.756527] hub 3-0:1.0: 2 ports detected
[    1.756975] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.757162] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    1.757483] uhci_hcd 0000:00:1d.2: detected 2 ports
[    1.757687] uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001040
[    1.757941] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.758126] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.758445] usb usb4: Product: UHCI Host Controller
[    1.758623] usb usb4: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb uhci_hcd
[    1.758857] usb usb4: SerialNumber: 0000:00:1d.2
[    1.759323] hub 4-0:1.0: USB hub found
[    1.759513] hub 4-0:1.0: 2 ports detected
[    1.759954] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    1.760141] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    1.760463] uhci_hcd 0000:00:1d.3: detected 2 ports
[    1.760659] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001060
[    1.760912] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.761096] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.761411] usb usb5: Product: UHCI Host Controller
[    1.761590] usb usb5: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb uhci_hcd
[    1.761772] usb usb5: SerialNumber: 0000:00:1d.3
[    1.762217] hub 5-0:1.0: USB hub found
[    1.762408] hub 5-0:1.0: 2 ports detected
[    1.762828] uhci_hcd 0000:01:04.4: UHCI Host Controller
[    1.763023] uhci_hcd 0000:01:04.4: new USB bus registered, assigned bus number 6
[    1.763354] uhci_hcd 0000:01:04.4: detected 8 ports
[    1.763533] uhci_hcd 0000:01:04.4: port count misdetected? forcing to 2 ports
[    1.764511] uhci_hcd 0000:01:04.4: irq 22, io base 0x00003800
[    1.764923] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.765107] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.765424] usb usb6: Product: UHCI Host Controller
[    1.765603] usb usb6: Manufacturer: Linux 4.7.0-rc7-00004-g08d27eb uhci_hcd
[    1.765784] usb usb6: SerialNumber: 0000:01:04.4
[    1.766227] hub 6-0:1.0: USB hub found
[    1.766413] hub 6-0:1.0: 2 ports detected
[    1.766844] usbcore: registered new interface driver usb-storage
[    1.767090] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    1.769304] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.769486] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.769815] rtc_cmos 00:04: RTC can wake from S4
[    1.770261] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.770481] rtc_cmos 00:04: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    1.770920] hidraw: raw HID events driver (C) Jiri Kosina
[    1.771159] usbcore: registered new interface driver usbhid
[    1.771343] usbhid: USB HID core driver
[    1.771950] NET: Registered protocol family 10
[    1.772610] mip6: Mobile IPv6
[    1.772790] sit: IPv6 over IPv4 tunneling driver
[    1.773211] NET: Registered protocol family 17
[    1.774135] microcode: CPU0 sig=0x106a5, pf=0x1, revision=0x19
[    1.774368] microcode: CPU1 sig=0x106a5, pf=0x1, revision=0x19
[    1.774614] microcode: CPU2 sig=0x106a5, pf=0x1, revision=0x19
[    1.775032] microcode: CPU3 sig=0x106a5, pf=0x1, revision=0x19
[    1.775279] microcode: CPU4 sig=0x106a5, pf=0x1, revision=0x19
[    1.775545] microcode: CPU5 sig=0x106a5, pf=0x1, revision=0x19
[    1.775795] microcode: CPU6 sig=0x106a5, pf=0x1, revision=0x19
[    1.775983] microcode: CPU7 sig=0x106a5, pf=0x1, revision=0x19
[    1.776219] microcode: CPU8 sig=0x106a5, pf=0x1, revision=0x19
[    1.776452] microcode: CPU9 sig=0x106a5, pf=0x1, revision=0x19
[    1.776685] microcode: CPU10 sig=0x106a5, pf=0x1, revision=0x19
[    1.776924] microcode: CPU11 sig=0x106a5, pf=0x1, revision=0x19
[    1.777158] microcode: CPU12 sig=0x106a5, pf=0x1, revision=0x19
[    1.777390] microcode: CPU13 sig=0x106a5, pf=0x1, revision=0x19
[    1.777630] microcode: CPU14 sig=0x106a5, pf=0x1, revision=0x19
[    1.777829] microcode: CPU15 sig=0x106a5, pf=0x1, revision=0x19
[    1.781682] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.782474] registered taskstats version 1
[    1.783832] console [netcon0] enabled
[    1.784014] netconsole: network logging started
[    1.785832] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.786008] EDD information not available.
[    1.795771] scsi 0:1:0:0: Direct-Access     HP       LOGICAL VOLUME   6.64 PQ: 0 ANSI: 5
[    1.809001] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.835230] scsi 0:0:0:0: Attached scsi generic sg0 type 12
[    1.835781] sd 0:1:0:0: Attached scsi generic sg1 type 0
[    1.836102] sd 0:1:0:0: [sda] 286615665 512-byte logical blocks: (147 GB/137 GiB)
[    1.836847] sd 0:1:0:0: [sda] Write Protect is off
[    1.837029] sd 0:1:0:0: [sda] Mode Sense: 6b 00 00 08
[    1.837221] sd 0:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    1.843484]  sda: sda1 sda2 < sda5 >
[    1.845508] sd 0:1:0:0: [sda] Attached SCSI disk
[    1.846175] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    1.846964] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    1.850480] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    1.850674] EXT4-fs (sda1): write access will be enabled during recovery
[    1.889972] EXT4-fs (sda1): recovery complete
[    1.939498] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.939826] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    1.947186] devtmpfs: mounted
[    1.951229] Freeing unused kernel memory: 944K (ffffffff823ec000 - ffffffff824d8000)
[    1.951546] Write protecting the kernel read-only data: 12288k
[    1.955527] Freeing unused kernel memory: 768K (ffff880001940000 - ffff880001a00000)
[    1.958678] Freeing unused kernel memory: 356K (ffff880001ba7000 - ffff880001c00000)
[    1.974074] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.074943] usb 6-1: new full-speed USB device number 2 using uhci_hcd
[    2.222937] usb 6-1: New USB device found, idVendor=03f0, idProduct=1027
[    2.223124] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.223306] usb 6-1: Product: Virtual Keyboard
[    2.223482] usb 6-1: Manufacturer: HP
[    2.233298] input: HP Virtual Keyboard as /devices/pci0000:00/0000:00:1e.0/0000:01:04.4/usb6/6-1/6-1:1.0/0003:03F0:1027.0001/input/input3
[    2.286951] hid-generic 0003:03F0:1027.0001: input,hidraw0: USB HID v1.01 Keyboard [HP Virtual Keyboard] on usb-0000:01:04.4-1/input0
[    2.295365] input: HP Virtual Keyboard as /devices/pci0000:00/0000:00:1e.0/0000:01:04.4/usb6/6-1/6-1:1.1/0003:03F0:1027.0002/input/input4
[    2.295755] hid-generic 0003:03F0:1027.0002: input,hidraw1: USB HID v1.01 Mouse [HP Virtual Keyboard] on usb-0000:01:04.4-1/input1
[    2.532100] random: systemd urandom read with 37 bits of entropy available
[    2.570699] systemd[1]: systemd 230 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    2.571743] systemd[1]: Detected architecture x86-64.
[    2.579421] systemd[1]: Set hostname to <dl360g6>.
[    2.639033] tsc: Refined TSC clocksource calibration: 2533.422 MHz
[    2.639223] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x24848ea16a3, max_idle_ns: 440795313972 ns
[    2.644894] systemd-dbus1-g (1015) used greatest stack depth: 13416 bytes left
[    2.652175] systemd-getty-g (1006) used greatest stack depth: 12776 bytes left
[    2.652501] systemd-rc-loca (1016) used greatest stack depth: 12488 bytes left
[    3.019078] systemd[1]: Listening on udev Control Socket.
[    3.019804] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    3.020462] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.021238] systemd[1]: Listening on Syslog Socket.
[    3.021907] systemd[1]: Created slice User and Session Slice.
[    3.022542] systemd[1]: Listening on udev Kernel Socket.
[    3.023266] systemd[1]: Created slice System Slice.
[    3.023925] systemd[1]: Created slice system-getty.slice.
[    3.024575] systemd[1]: Listening on Journal Socket.
[    3.039048] systemd[1]: Mounting Debug File System...
[    3.040119] systemd[1]: Mounting Huge Pages File System...
[    3.041285] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    3.041981] systemd[1]: Reached target Encrypted Volumes.
[    3.042854] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.047991] systemd[1]: Reached target Remote File Systems (Pre).
[    3.050551] systemd[1]: Starting Set the console keyboard layout...
[    3.051247] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.052012] systemd[1]: Reached target Paths.
[    3.053116] systemd[1]: Mounting POSIX Message Queue File System...
[    3.053725] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.054382] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.055577] systemd[1]: Starting File System Check on Root Device...
[    3.060557] systemd[1]: Starting Load Kernel Modules...
[    3.061101] systemd[1]: Reached target Remote File Systems.
[    3.061723] systemd[1]: Reached target Slices.
[    3.082358] modprobe (1030) used greatest stack depth: 12296 bytes left
[    3.083115] systemd[1]: Starting Journal Service...
[    3.099396] systemd[1]: Started File System Check Daemon to report status.
[    3.127202] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    3.128612] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.137758] systemd[1]: Started Load Kernel Modules.
[    3.139411] systemd[1]: Starting Apply Kernel Variables...
[    3.164632] systemd[1]: Started Apply Kernel Variables.
[    3.247410] systemd[1]: Mounted Debug File System.
[    3.248100] systemd[1]: Mounted Huge Pages File System.
[    3.248764] systemd[1]: Mounted POSIX Message Queue File System.
[    3.255203] systemd[1]: Started Journal Service.
[    3.516124] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    3.639396] clocksource: Switched to clocksource tsc
[    3.639900] systemd-journald[1031]: Received request to flush runtime journal from PID 1
[    3.956167] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1600 MHz, 2533 MHz
[    3.956332] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.956935] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.957526] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.958152] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.958742] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.959398] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.959979] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.960522] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.964560] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.965131] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.965670] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.966210] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.966767] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.967308] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.968158] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.968702] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    3.992988] EDAC MC: Ver: 3.0.0
[    4.001437] EDAC MC1: Giving out device to module i7core_edac.c controller i7 core #1: DEV 0000:3e:03.0 (INTERRUPT)
[    4.001820] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3e:03.0 (POLLED)
[    4.002422] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (INTERRUPT)
[    4.002787] EDAC PCI1: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[    4.003125] EDAC i7core: Driver loaded, 2 memory controller(s) found.
[    4.004131] ACPI Warning: SystemIO range 0x0000000000000928-0x000000000000092F conflicts with OpRegion 0x0000000000000920-0x000000000000092F (\SGPE) (20160422/utaddress-255)
[    4.004668] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    4.005023] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    4.008344] ipmi message handler version 39.2
[    4.028892] hpwdt 0000:01:04.0: HPE Watchdog Timer Driver: NMI decoding initialized, allow kernel dump: ON (default = 1/ON)
[    4.029267] hpwdt 0000:01:04.0: HPE Watchdog Timer Driver: 1.3.3, timer margin: 30 seconds (nowayout=0).
[    4.085956] ipmi_si IPI0001:00: ipmi_si: probing via ACPI
[    4.086179] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[    4.086359] ipmi_si: Adding ACPI-specified kcs state machine
[    4.086592] IPMI System Interface driver.
[    4.086793] ipmi_si 0000:01:04.6: probing via PCI
[    4.087047] ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21
[    4.087361] ipmi_si: Adding PCI-specified kcs state machine
[    4.087594] ipmi_si: probing via SMBIOS
[    4.087768] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    4.087944] ipmi_si: Adding SMBIOS-specified kcs state machine duplicate interface
[    4.088290] ipmi_si: probing via SPMI
[    4.088459] ipmi_si: SPMI: io 0xca2 regsize 2 spacing 2 irq 0
[    4.088631] ipmi_si: Adding SPMI-specified kcs state machine duplicate interface
[    4.088975] ipmi_si: Trying PCI-specified kcs state machine at mem address 0xf5ef0000, slave address 0x0, irq 21
[    4.098208] bnx2: QLogic bnx2 Gigabit Ethernet Driver v2.2.6 (January 29, 2014)
[    4.099411] bnx2 0000:02:00.0 eth0: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem f8000000, IRQ 42, node addr 00:26:55:1a:e8:90
[    4.100509] bnx2 0000:02:00.1 eth1: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem f6000000, IRQ 43, node addr 00:26:55:1a:e8:92
[    4.112045] libata version 3.00 loaded.
[    4.170429] ata_piix 0000:00:1f.2: version 2.13
[    4.170612] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    4.230334] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.07.00.33-k.
[    4.230787] qla2xxx [0000:07:00.0]-001d: : Found an ISP2432 irq 44 iobase 0xffffc90003598000.
[    4.231363] qla2xxx [0000:07:00.0]-0034:1: MSI-X: Unsupported ISP 2432 SSVID/SSDID (0x103C,0x7041).
[    4.235032] iTCO_vendor_support: vendor-support=0
[    4.238670] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    4.238907] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[    4.241794] [drm] radeon kernel modesetting enabled.
[    4.242375] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[    4.242704] [drm] register mmio base: 0xF5FF0000
[    4.242885] [drm] register mmio size: 65536
[    4.243151] radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
[    4.243462] radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[    4.243782] [drm] Detected VRAM RAM=128M, BAR=128M
[    4.243958] [drm] RAM width 16bits DDR
[    4.244192] [TTM] Zone  kernel: Available graphics memory: 12369700 kiB
[    4.244370] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    4.244548] [TTM] Initializing pool allocator
[    4.244728] [TTM] Initializing DMA pool allocator
[    4.244925] [drm] radeon: 64M of VRAM memory ready
[    4.245101] [drm] radeon: 512M of GTT memory ready.
[    4.245301] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    4.266011] [drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
[    4.266207] radeon 0000:01:03.0: WB disabled
[    4.266384] radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800de2cd000
[    4.266700] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.266968] [drm] Driver supports precise vblank timestamp query.
[    4.267160] [drm] radeon: irq initialized.
[    4.267344] [drm] Loading R100 Microcode
[    4.276402] [drm] radeon: ring at 0x00000000C8001000
[    4.276604] [drm] ring test succeeded in 1 usecs
[    4.290108] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.290286] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.290628] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.301461] bnx2 0000:02:00.0 enp2s0f0: renamed from eth0
[    4.315025] ================================================================================
[    4.315345] UBSAN: Undefined behaviour in drivers/scsi/qla2xxx/qla_isr.c:2500:14
[    4.315670] shift exponent 32 is too large for 32-bit type 'int'
[    4.315848] CPU: 6 PID: 1725 Comm: systemd-udevd Tainted: G          I     4.7.0-rc7-00004-g08d27eb #4
[    4.316168] Hardware name: HP ProLiant DL360 G6, BIOS P64 01/22/2015
[    4.316296] bnx2 0000:02:00.1 enp2s0f1: renamed from eth1
[    4.316522]  0000000000000001 ffff8800de18b698 ffffffff81433aaf 0000000000000034
[    4.316968]  ffff8800de18b6c0 ffffffffa032a6e0 ffff8800de18b6b0 ffffffff8148aa0d
[    4.317410]  0000000000000020 ffff8800de18b740 ffffffff8148b059 0000000000000002
[    4.317858] Call Trace:
[    4.318032]  [<ffffffff81433aaf>] dump_stack+0x4e/0x6f
[    4.318210]  [<ffffffff8148aa0d>] ubsan_epilogue+0xd/0x40
[    4.318386]  [<ffffffff8148b059>] __ubsan_handle_shift_out_of_bounds+0xf9/0x150
[    4.318701]  [<ffffffff81137631>] ? try_to_del_timer_sync+0x51/0x90
[    4.318930]  [<ffffffff811377b2>] ? del_timer_sync+0x22/0x60
[    4.319126]  [<ffffffffa027507a>] qla24xx_mbx_completion+0x13a/0x170 [qla2xxx]
[    4.319452]  [<ffffffffa027cd8f>] qla24xx_intr_handler+0x20f/0x3b0 [qla2xxx]
[    4.319641]  [<ffffffffa025d9e4>] qla2x00_mailbox_command+0x644/0xf70 [qla2xxx]
[    4.319954]  [<ffffffff81440006>] ? __rb_insert_augmented+0x96/0x640
[    4.320140]  [<ffffffffa029d830>] ? qla82xx_get_flash_version+0x5a0/0x5a0 [qla2xxx]
[    4.320462]  [<ffffffffa025f481>] qla2x00_mbx_reg_test+0xa1/0x140 [qla2xxx]
[    4.320650]  [<ffffffffa024f866>] qla24xx_chip_diag+0x66/0xe0 [qla2xxx]
[    4.320840]  [<ffffffffa02579a8>] qla2x00_initialize_adapter+0x2b8/0xa30 [qla2xxx]
[    4.321172]  [<ffffffffa0247de1>] qla2x00_probe_one+0x1021/0x2e20 [qla2xxx]
[    4.321354]  [<ffffffff813222c7>] ? kernfs_activate+0x87/0x160
[    4.321537]  [<ffffffff8149d249>] local_pci_probe+0x59/0xf0
[    4.321714]  [<ffffffff8149f07b>] pci_device_probe+0x14b/0x1c0
[    4.321889]  [<ffffffff8162b6e0>] driver_probe_device+0x110/0x6d0
[    4.322063]  [<ffffffff8162bd8e>] __driver_attach+0xee/0x150
[    4.322236]  [<ffffffff8162bca0>] ? driver_probe_device+0x6d0/0x6d0
[    4.322412]  [<ffffffff81628707>] bus_for_each_dev+0x67/0xb0
[    4.322586]  [<ffffffff8162abf2>] driver_attach+0x22/0x40
[    4.322842]  [<ffffffff8162a3b2>] bus_add_driver+0x172/0x340
[    4.323022]  [<ffffffffa00e7000>] ? 0xffffffffa00e7000
[    4.323203]  [<ffffffff8162c968>] driver_register+0x78/0x130
[    4.323380]  [<ffffffff8149cab2>] __pci_register_driver+0x62/0xa0
[    4.323567]  [<ffffffffa00e71c9>] qla2x00_module_init+0x1c9/0x217 [qla2xxx]
[    4.323746]  [<ffffffff8100046c>] do_one_initcall+0x5c/0x1e0
[    4.323924]  [<ffffffff81252f23>] ? kfree+0x153/0x260
[    4.324099]  [<ffffffff81251f31>] ? kmem_cache_alloc+0xc1/0x170
[    4.324277]  [<ffffffff811b7d44>] do_init_module+0x91/0x25f
[    4.324453]  [<ffffffff81160ea5>] load_module+0x21e5/0x3570
[    4.324627]  [<ffffffff8115dba0>] ? resolve_symbol_wait+0x170/0x170
[    4.324803]  [<ffffffff81279421>] ? kernel_read+0x61/0xe0
[    4.324979]  [<ffffffff81162443>] SYSC_finit_module+0xc3/0xf0
[    4.325157]  [<ffffffff81162489>] SyS_finit_module+0x9/0x10
[    4.325341]  [<ffffffff81002a21>] do_syscall_64+0x71/0x150
[    4.325519]  [<ffffffff81936c40>] entry_SYSCALL64_slow_path+0x25/0x25
[    4.325696] ================================================================================
[    4.327773] scsi host2: ata_piix
[    4.328362] scsi host3: ata_piix
[    4.328606] ata1: SATA max UDMA/133 cmd 0x1080 ctl 0x1088 bmdma 0x10a0 irq 17
[    4.328792] ata2: SATA max UDMA/133 cmd 0x1090 ctl 0x1098 bmdma 0x10a8 irq 17
[    4.467301] e1000e 0000:04:00.0 eth0: (PCI Express:2.5GT/s:Width x4) 00:1b:78:59:c4:e6
[    4.467619] e1000e 0000:04:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.467888] e1000e 0000:04:00.0 eth0: MAC: 0, PHY: 4, PBA No: D51930-003
[    4.468222] e1000e 0000:04:00.1: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.531442] random: nonblocking pool is initialized
[    4.531705] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[    4.539191] ipmi_si 0000:01:04.6: Using irq 21
[    4.560534] ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
[    4.560856] ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[    4.581340] IPMI SSIF Interface driver
[    4.647689] e1000e 0000:04:00.1 eth1: (PCI Express:2.5GT/s:Width x4) 00:1b:78:59:c4:e7
[    4.648009] e1000e 0000:04:00.1 eth1: Intel(R) PRO/1000 Network Connection
[    4.648261] e1000e 0000:04:00.1 eth1: MAC: 0, PHY: 4, PBA No: D51930-003
[    4.666796] e1000e 0000:04:00.1 ens1f1: renamed from eth1
[    4.683219] e1000e 0000:04:00.0 ens1f0: renamed from eth0
[    4.703549] scsi host1: qla2xxx
[    4.704403] qla2xxx [0000:07:00.0]-00fb:1: QLogic HPAE312A - PCI-Express Dual Port 4Gb Fibre Channel HBA.
[    4.704733] qla2xxx [0000:07:00.0]-00fc:1: ISP2432: PCIe (2.5GT/s x4) @ 0000:07:00.0 hdma+ host#=1 fw=8.03.00 (9496).
[    4.705194] qla2xxx [0000:07:00.1]-001d: : Found an ISP2432 irq 49 iobase 0xffffc9000359c000.
[    4.705879] qla2xxx [0000:07:00.1]-0034:4: MSI-X: Unsupported ISP 2432 SSVID/SSDID (0x103C,0x7041).
[    4.779184] [drm] ib test succeeded in 0 usecs
[    4.779709] [drm] No TV DAC info found in BIOS
[    4.779938] [drm] Radeon Display Connectors
[    4.780114] [drm] Connector 0:
[    4.780289] [drm]   VGA-1
[    4.780459] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    4.780635] [drm]   Encoders:
[    4.780805] [drm]     CRT1: INTERNAL_DAC1
[    4.780979] [drm] Connector 1:
[    4.781148] [drm]   VGA-2
[    4.781318] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[    4.781493] [drm]   Encoders:
[    4.781663] [drm]     CRT2: INTERNAL_DAC2
[    4.843122] CE: hpet increased min_delta_ns to 20115 nsec
[    4.854762] [drm] fb mappable at 0xE8040000
[    4.854971] [drm] vram apper at 0xE8000000
[    4.855145] [drm] size 1310720
[    4.855315] [drm] fb depth is 8
[    4.855483] [drm]    pitch is 1280
[    4.855785] fbcon: radeondrmfb (fb0) is primary device
[    4.962088] ata2.00: SATA link down (SStatus 4 SControl 300)
[    4.962100] ata2.01: SATA link down (SStatus 4 SControl 300)
[    5.017076] Console: switching to colour frame buffer device 160x64
[    5.030345] radeon 0000:01:03.0: fb0: radeondrmfb frame buffer device
[    5.062755] [drm] Initialized radeon 2.45.0 20080528 for 0000:01:03.0 on minor 0
[    5.075384] scsi host4: qla2xxx
[    5.076065] qla2xxx [0000:07:00.1]-00fb:4: QLogic HPAE312A - PCI-Express Dual Port 4Gb Fibre Channel HBA.
[    5.076216] qla2xxx [0000:07:00.1]-00fc:4: ISP2432: PCIe (2.5GT/s x4) @ 0000:07:00.1 hdma+ host#=4 fw=8.03.00 (9496).
[    5.091897] Adding 25153532k swap on /dev/sda5.  Priority:-1 extents:1 across:25153532k 
[    5.107278] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.107391] ata1.01: SATA link down (SStatus 4 SControl 300)
[    5.107485] ata1.01: link offline, clearing class 3 to NONE
[    5.109936] ata1.00: ATAPI: DV-28S-V, C.0F, max UDMA/100
[    5.143186] ata1.00: configured for UDMA/100
[    5.176744] scsi: waiting for bus probes to complete ...
[    5.752734] bnx2 0000:02:00.0 enp2s0f0: using MSIX
[    5.756949] IPv6: ADDRCONF(NETDEV_UP): enp2s0f0: link is not ready
[    5.761242] ip (2860) used greatest stack depth: 11336 bytes left
[    6.133007] systemd[1]: apt-daily.timer: Adding 9h 12min 9.123225s random time.
[    6.180841] systemd[1]: apt-daily.timer: Adding 8h 21min 59.870462s random time.
[    7.348053] bnx2 0000:02:00.0 enp2s0f0: NIC Copper Link is Up, 100 Mbps full duplex
[    7.348174] , receive & transmit flow control ON
[    7.348350] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f0: link becomes ready
[   10.106248] scsi 2:0:0:0: CD-ROM            TEAC     DV-28S-V         C.0F PQ: 0 ANSI: 5
[   10.175329] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   10.175446] cdrom: Uniform CD-ROM driver Revision: 3.20
[   10.175898] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   10.176041] sr 2:0:0:0: Attached scsi generic sg2 type 5
[   11.331160] systemd[1]: apt-daily.timer: Adding 10h 33min 13.434728s random time.
[   11.443874] systemd[1]: apt-daily.timer: Adding 8h 51min 9.603614s random time.

-- 
Meelis Roos (mroos@linux.ee)
