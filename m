From: Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 16:27:41 +0100
Message-ID: <20061030152741.GA7689@lorenz.eu.org>
References: <20061029231358.GI27968@stusta.de>
	<20061030135625.GB1601@mellanox.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061030135625.GB1601@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, linux-pm@osdl.org, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2006 at 03:56:26PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Adrian Bunk <bunk@stusta.de>:
> > Subject    : T60 stops triggering any ACPI events
> > References : http://lkml.org/lkml/2006/10/4/425
> >              http://lkml.org/lkml/2006/10/16/262
> >              http://bugzilla.kernel.org/show_bug.cgi?id=7408
> > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > Status     : unknown
> 
> OK, I spent half a night with git-bisect, and the patch that triggers this issue
> seems to be this:
> 
> commit d7dd8fd9557840162b724a8ac1366dd78a12dff

great!
I was about bisecting myself this weekend but had to let go in favour 
of my daughter...
thank you for that

> I am currently running on 2.6.19-rc3 minus
> d7dd8fd9557840162b724a8ac1366dd78a12dff, and in a full day of use I have not

applied your patch and compiling...

but I can hardly belive something in the block_dev layer can interfere with
ACPI to result in the behavieour we experienced


> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index bc8f27c..b15ad29 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c

and it dosen't change anything for me



gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg.2.6.19-rc3-ts-tp-ie-e1-44.1+1430-g06df5d4f-dirty.boot"

    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   521952
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   521952
[    0.000000] On node 0 totalpages: 521952
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2285 pages used for memmap
[    0.000000]   HighMem zone: 290291 pages, LIFO batch:31
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v002 LENOVO                                ) @ 0x000f6870
[    0.000000] ACPI: XSDT (v001 LENOVO TP-7B    0x00001100  LTP 0x00000000) @ 0x7f6e6526
[    0.000000] ACPI: FADT (v003 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6e6600
[    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 MSFT 0x0100000e) @ 0x7f6e67b4
[    0.000000] ACPI: ECDT (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2d45
[    0.000000] ACPI: TCPA (v002 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2d97
[    0.000000] ACPI: MADT (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2dc9
[    0.000000] ACPI: MCFG (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2e31
[    0.000000] ACPI: HPET (v001 LENOVO TP-7B    0x00001100 LNVO 0x00000001) @ 0x7f6f2e6f
[    0.000000] ACPI: BOOT (v001 LENOVO TP-7B    0x00001100  LTP 0x00000001) @ 0x7f6f2fd8
[    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 INTL 0x20050513) @ 0x7f6e5ae1
[    0.000000] ACPI: SSDT (v001 LENOVO TP-7B    0x00001100 INTL 0x20050513) @ 0x7f6e5909
[    0.000000] ACPI: DSDT (v001 LENOVO TP-7B    0x00001100 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:14 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 6:14 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
[    0.000000] Detected 1662.624 MHz processor.
[   10.539368] Built 1 zonelists.  Total pages: 517875
[   10.539373] Kernel command line: root=/dev/sda5 ro resume
[   10.539720] mapped APIC to ffffd000 (fee00000)
[   10.539724] mapped IOAPIC to ffffc000 (fec00000)
[   10.539728] Enabling fast FPU save and restore... done.
[   10.539733] Enabling unmasked SIMD FPU exception support... done.
[   10.539737] Initializing CPU#0
[   10.539818] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   10.541567] Console: colour VGA+ 80x25
[   10.545995] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   10.546589] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   10.688172] Memory: 2065788k/2087808k available (1949k kernel code, 20860k reserved, 775k data, 176k init, 1170304k highmem)
[   10.688330] virtual kernel memory layout:
[   10.688332]     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
[   10.688334]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   10.688336]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   10.688339]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   10.688341]       .init : 0xc0400000 - 0xc042c000   ( 176 kB)
[   10.688343]       .data : 0xc02e77a9 - 0xc03a9414   ( 775 kB)
[   10.688346]       .text : 0xc0100000 - 0xc02e77a9   (1949 kB)
[   10.689084] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   10.689471] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   10.689749] hpet0: 3 64-bit timers, 14318180 Hz
[   10.690845] Using HPET for base-timer
[   10.750381] Calibrating delay using timer specific routine.. 3328.29 BogoMIPS (lpj=1664148)
[   10.750612] Security Framework v1.0.0 initialized
[   10.750710] Capability LSM initialized
[   10.750819] Mount-cache hash table entries: 512
[   10.751046] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[   10.751058] monitor/mwait feature present.
[   10.751150] using mwait in idle threads.
[   10.751243] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.751392] CPU: L2 cache: 2048K
[   10.751481] CPU: Physical Processor ID: 0
[   10.751571] CPU: Processor Core ID: 0
[   10.751661] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[   10.751672] Intel machine check architecture supported.
[   10.751771] Intel machine check reporting enabled on CPU#0.
[   10.751869] Compat vDSO mapped to ffffe000.
[   10.751972] Checking 'hlt' instruction... OK.
[   10.755540] SMP alternatives: switching to UP code
[   10.755838] ACPI: Core revision 20060707
[   10.779647] CPU0: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[   10.779925] SMP alternatives: switching to SMP code
[   10.780081] Booting processor 1/1 eip 3000
[   10.791299] Initializing CPU#1
[   10.851566] Calibrating delay using timer specific routine.. 3325.08 BogoMIPS (lpj=1662541)
[   10.851575] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[   10.851584] monitor/mwait feature present.
[   10.851589] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.851593] CPU: L2 cache: 2048K
[   10.851596] CPU: Physical Processor ID: 0
[   10.851599] CPU: Processor Core ID: 1
[   10.851601] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[   10.851610] Intel machine check architecture supported.
[   10.851619] Intel machine check reporting enabled on CPU#1.
[   10.851890] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[   10.853013] Total of 2 processors activated (6653.37 BogoMIPS).
[   10.853317] ENABLING IO-APIC IRQs
[   10.853624] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   10.965046] checking TSC synchronization across 2 CPUs: 
[    0.000086] CPU#0 had -172 usecs TSC skew, fixed it up.
[    0.000181] CPU#1 had 172 usecs TSC skew, fixed it up.
[    0.000949] Brought up 2 CPUs
[    0.307634] migration_cost=117
[    0.308430] NET: Registered protocol family 16
[    0.308637] ACPI: bus type pci registered
[    0.308735] PCI: Using MMCONFIG
[    0.309658] Setting up standard PCI resources
[    0.328979] ACPI: Interpreter enabled
[    0.329072] ACPI: Using IOAPIC for interrupt routing
[    0.330596] ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11)
[    0.332204] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11)
[    0.333820] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11)
[    0.335446] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11)
[    0.337062] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.338682] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.340286] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11)
[    0.341902] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.343116] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.343214] PCI: Probing PCI hardware (bus 00)
[    0.348387] Boot video device is 0000:00:02.0
[    0.348988] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.349086] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.349227] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.350564] PCI: Transparent bridge - 0000:00:1e.0
[    0.350806] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.358912] ACPI: Power Resource [PUBS] (on)
[    0.361453] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[    0.361772] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.362089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.362477] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.362853] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.365662] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.365766] pnp: PnP ACPI init
[    0.372613] pnp: PnP ACPI: found 12 devices
[    0.372737] intel_rng: FWH not detected
[    0.373008] SCSI subsystem initialized
[    0.373188] PCI: Using ACPI for IRQ routing
[    0.373280] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.374947] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    0.375046] PCI: Bridge: 0000:00:1c.0
[    0.375138]   IO window: 2000-2fff
[    0.375231]   MEM window: ee000000-ee0fffff
[    0.375323]   PREFETCH window: disabled.
[    0.375425] PCI: Bridge: 0000:00:1c.1
[    0.375516]   IO window: 3000-4fff
[    0.375609]   MEM window: ec000000-edffffff
[    0.375702]   PREFETCH window: e4000000-e40fffff
[    0.375798] PCI: Bridge: 0000:00:1c.2
[    0.375891]   IO window: 5000-6fff
[    0.375985]   MEM window: e8000000-e9ffffff
[    0.376080]   PREFETCH window: e4100000-e41fffff
[    0.376175] PCI: Bridge: 0000:00:1c.3
[    0.376267]   IO window: 7000-8fff
[    0.376370]   MEM window: ea000000-ebffffff
[    0.376465]   PREFETCH window: e4200000-e42fffff
[    0.376567] PCI: Bus 22, cardbus bridge: 0000:15:00.0
[    0.376661]   IO window: 00009000-000090ff
[    0.376756]   IO window: 00009400-000094ff
[    0.376852]   PREFETCH window: e0000000-e1ffffff
[    0.376948]   MEM window: e6000000-e7ffffff
[    0.377042] PCI: Bridge: 0000:00:1e.0
[    0.377135]   IO window: 9000-cfff
[    0.377229]   MEM window: e4300000-e7ffffff
[    0.377324]   PREFETCH window: e0000000-e3ffffff
[    0.377449] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
[    0.377635] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.377658] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 17
[    0.377843] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.377866] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
[    0.378050] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.378072] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 19
[    0.378257] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.378268] PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
[    0.378374] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.378393] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.378579] PCI: Setting latency timer of device 0000:15:00.0 to 64
[    0.378614] NET: Registered protocol family 2
[    0.391378] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.391621] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.394548] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.395357] TCP: Hash tables configured (established 262144 bind 65536)
[    0.395453] TCP reno registered
[    0.395768] Simple Boot Flag at 0x35 set to 0x1
[    0.396509] audit: initializing netlink socket (disabled)
[    0.396620] audit(1162223349.853:1): initialized
[    0.396812] highmem bounce pool size: 64 pages
[    0.397170] io scheduler noop registered
[    0.397313] io scheduler anticipatory registered
[    0.397454] io scheduler deadline registered
[    0.397607] io scheduler cfq registered (default)
[    0.398102] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.398156] assign_interrupt_mode Found MSI capability
[    0.398309] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.398370] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.398428] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.398548] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.398601] assign_interrupt_mode Found MSI capability
[    0.399564] Allocate Port Service[0000:00:1c.1:pcie00]
[    0.399614] Allocate Port Service[0000:00:1c.1:pcie02]
[    0.399661] Allocate Port Service[0000:00:1c.1:pcie03]
[    0.399775] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.399828] assign_interrupt_mode Found MSI capability
[    0.399962] Allocate Port Service[0000:00:1c.2:pcie00]
[    0.400009] Allocate Port Service[0000:00:1c.2:pcie02]
[    0.400061] Allocate Port Service[0000:00:1c.2:pcie03]
[    0.400175] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.400228] assign_interrupt_mode Found MSI capability
[    0.400368] Allocate Port Service[0000:00:1c.3:pcie00]
[    0.400418] Allocate Port Service[0000:00:1c.3:pcie02]
[    0.400465] Allocate Port Service[0000:00:1c.3:pcie03]
[    0.433651] Real Time Clock Driver v1.12ac
[    0.433809] hpet_resources: 0xfed00000 is busy
[    0.433837] Linux agpgart interface v0.101 (c) Dave Jones
[    0.433975] agpgart: Detected an Intel 945GM Chipset.
[    0.435945] agpgart: Detected 7932K stolen memory.
[    0.453538] agpgart: AGP aperture is 256M @ 0xd0000000
[    0.453679] [drm] Initialized drm 1.0.1 20051102
[    0.454166] loop: loaded (max 8 devices)
[    0.454264] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2-NAPI
[    0.454358] Copyright (c) 1999-2006 Intel Corporation.
[    0.454526] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.454719] PCI: Setting latency timer of device 0000:02:00.0 to 64
[    0.460267] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:16:d3:22:9b:82
[    0.505134] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    0.505373] netconsole: not configured, aborting
[    0.505579] libata version 2.00 loaded.
[    0.505629] ahci 0000:00:1f.2: version 2.0
[    0.505647] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[    1.507573] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    1.507583] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[    1.507722] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    1.507910] ata1: SATA max UDMA/133 cmd 0xF8824500 ctl 0x0 bmdma 0x0 irq 219
[    1.508079] ata2: SATA max UDMA/133 cmd 0xF8824580 ctl 0x0 bmdma 0x0 irq 219
[    1.508251] ata3: SATA max UDMA/133 cmd 0xF8824600 ctl 0x0 bmdma 0x0 irq 219
[    1.508419] ata4: SATA max UDMA/133 cmd 0xF8824680 ctl 0x0 bmdma 0x0 irq 219
[    1.508524] scsi0 : ahci
[    1.966832] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.967289] ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
[    1.967424] ata1.00: ata1: dev 0 multi count 16
[    1.969850] ata1.00: configured for UDMA/100
[    1.969952] scsi1 : ahci
[    2.273333] ata2: SATA link down (SStatus 0 SControl 0)
[    2.273440] scsi2 : ahci
[    2.576850] ata3: SATA link down (SStatus 0 SControl 0)
[    2.576953] scsi3 : ahci
[    2.880368] ata4: SATA link down (SStatus 0 SControl 0)
[    2.880597] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0084 PQ: 0 ANSI: 5
[    2.880870] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.880982] sda: Write Protect is off
[    2.881073] sda: Mode Sense: 00 3a 00 00
[    2.881099] SCSI device sda: drive cache: write back
[    2.881251] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.881362] sda: Write Protect is off
[    2.881453] sda: Mode Sense: 00 3a 00 00
[    2.881478] SCSI device sda: drive cache: write back
[    2.881575]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
[    3.052953] sd 0:0:0:0: Attached scsi disk sda
[    3.053295] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.064269] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.064367] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.064626] mice: PS/2 mouse device common for all mice
[    3.064722] i2c /dev entries driver
[    3.064957] ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 19
[    3.065268] hdaps: LENOVO ThinkPad X60 detected, inverting axes
[    3.069987] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.076297] hdaps: initial mode latch is 0x05
[    3.076468] hdaps: setting ec_rate=250, filter_order=2
[    3.076509] hdaps: fake_data_mode set to 0
[    3.076732] hdaps: device successfully initialized.
[    3.076906] input: hdaps as /class/input/input1
[    3.076999] hdaps: driver successfully loaded.
[    3.077093] EDAC MC: Ver: 2.0.1 Oct 30 2006
[    3.077714] thinkpad_ec: thinkpad_ec 0.30 loaded.
[    3.077956] TCP bic registered
[    3.078057] NET: Registered protocol family 1
[    3.078153] NET: Registered protocol family 17
[    3.078263] Starting balanced_irq
[    3.078359] Using IPI No-Shortcut mode
[    3.078884] ACPI: (supports S0 S3 S4 S5)
[    3.079246] Time: tsc clocksource has been installed.
[    3.079386] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    3.082224] VFS: Mounted root (ext2 filesystem) readonly.
[    3.082457] Freeing unused kernel memory: 176k freed
[    6.179063] ieee1394: Initialized config rom entry `ip1394'
[    6.181760] ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 21
[    6.181958] PCI: Setting latency timer of device 0000:15:00.1 to 64
[    6.235209] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    6.349287] input: PC Speaker as /class/input/input2
[    6.712159] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    6.712263] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    6.908445] usbcore: registered new interface driver usbfs
[    6.908579] usbcore: registered new interface driver hub
[    6.908711] usbcore: registered new device driver usb
[    7.089196] irda_init()
[    7.089213] NET: Registered protocol family 23
[    7.146382] USB Universal Host Controller Interface driver v3.0
[    7.146545] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[    7.146745] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    7.146751] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    7.147058] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    7.147234] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
[    7.147488] usb usb1: configuration #1 chosen from 1 choice
[    7.147628] hub 1-0:1.0: USB hub found
[    7.147726] hub 1-0:1.0: 2 ports detected
[    7.198161] sdhci: Secure Digital Host Controller Interface driver, 0.12
[    7.198263] sdhci: Copyright(c) Pierre Ossman
[    7.248594] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
[    7.248798] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    7.248804] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    7.248942] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    7.249108] uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001840
[    7.249338] usb usb2: configuration #1 chosen from 1 choice
[    7.249818] hub 2-0:1.0: USB hub found
[    7.249917] hub 2-0:1.0: 2 ports detected
[    7.351432] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
[    7.351634] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    7.351640] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    7.351771] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    7.351940] uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001860
[    7.352165] usb usb3: configuration #1 chosen from 1 choice
[    7.352305] hub 3-0:1.0: USB hub found
[    7.352401] hub 3-0:1.0: 2 ports detected
[    7.453217] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[    7.453403] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    7.453408] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    7.453537] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    7.453701] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001880
[    7.453921] usb usb4: configuration #1 chosen from 1 choice
[    7.454051] hub 4-0:1.0: USB hub found
[    7.454150] hub 4-0:1.0: 2 ports detected
[    7.499170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40600192017]
[    7.555770] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[    7.555969] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    7.555975] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    7.556109] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    7.556283] ehci_hcd 0000:00:1d.7: debug port 1
[    7.556384] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    7.556395] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xee444000
[    7.560381] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    7.560837] usb usb5: configuration #1 chosen from 1 choice
[    7.560967] hub 5-0:1.0: USB hub found
[    7.561064] hub 5-0:1.0: 8 ports detected
[    7.563438] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[    7.637032] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    7.657935] input: TPPS/2 IBM TrackPoint as /class/input/input3
[    7.661955] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
[    7.663374] pnp: Device 00:0a activated.
[    7.663471] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 7 ; dma 1.
[    7.663500] nsc-ircc, chip->init
[    7.663605] nsc-ircc, Found chip at base=0x164e
[    7.663738] nsc-ircc, driver loaded (Dag Brattli)
[    7.663925] IrDA: Registered device irda0
[    7.664080] nsc-ircc, Found dongle: No dongle connected
[    7.664183] nsc_ircc_init_dongle_interface(), No dongle connected
[    7.785417] Yenta: ISA IRQ mask 0x0c38, PCI irq 20
[    7.785519] Socket status: 30000006
[    7.785615] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
[    7.785713] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
[    7.785812] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
[    7.786199] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[    7.786450] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[    8.303763] usb 4-1: new full speed USB device using uhci_hcd and address 2
[    8.465387] usb 4-1: configuration #1 chosen from 1 choice
[    8.550092] Bluetooth: Core ver 2.11
[    8.550695] NET: Registered protocol family 31
[    8.550795] Bluetooth: HCI device and connection manager initialized
[    8.550892] Bluetooth: HCI socket layer initialized
[    8.559175] Bluetooth: HCI USB driver ver 2.9
[    8.677160] usb 4-2: new full speed USB device using uhci_hcd and address 3
[    8.833905] hda_intel: No response from codec, disabling MSI...
[    8.842826] usb 4-2: configuration #1 chosen from 1 choice
[    8.847946] usbcore: registered new interface driver hci_usb
[    9.833318] hda_intel: azx_get_response timeout, switching to polling mode...
[   10.832730] hda_intel: azx_get_response timeout, switching to single_cmd mode...
[   21.618159] sdhci: SDHCI controller found at 0000:15:00.2 [1180:0822] (rev 18)
[   21.619154] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
[   21.620362] PCI: Setting latency timer of device 0000:15:00.2 to 64
[   21.622574] mmc0: SDHCI at 0xe4301800 irq 22 DMA
[   22.346566] Adding 1951856k swap on /dev/sda12.  Priority:-1 extents:1 across:1951856k
[   22.347780] Adding 2931820k swap on /dev/sda13.  Priority:-2 extents:1 across:2931820k
[   22.692872] Non-volatile memory driver v1.2
[   22.731265] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   22.731365] ieee1394: sbp2: Try serialize_io=0 for better performance
[   22.764737] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[   22.764844] ibm_acpi: http://ibm-acpi.sf.net/
[   22.785014] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   22.785828] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   22.787166] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   22.787446] ACPI: Processor [CPU0] (supports 8 throttling states)
[   22.788615] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   22.789318] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   22.790705] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   22.790991] ACPI: Processor [CPU1] (supports 8 throttling states)
[   23.002000] Time: hpet clocksource has been installed.
[   23.019000] mmcblk0: mmc0:b368 SD    249856KiB 
[   23.019000]  mmcblk0: p1
[   38.427000] ReiserFS: sda14: found reiserfs format "3.6" with standard journal
[   38.427000] ReiserFS: sda14: warning: CONFIG_REISERFS_CHECK is set ON
[   38.427000] ReiserFS: sda14: warning: - it is slow mode for debugging.
[   38.427000] ReiserFS: sda14: using ordered data mode
[   38.450000] ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.451000] ReiserFS: sda14: checking transaction log (sda14)
[   38.451000] ReiserFS: sda14: journal-1153: found in header: first_unflushed_offset 7418, last_flushed_trans_id 30277
[   38.453000] ReiserFS: sda14: journal-1206: Starting replay from offset 130043019795706, trans_id 3223281428
[   38.453000] ReiserFS: sda14: journal-1299: Setting newest_mount_id to 176
[   38.495000] ReiserFS: sda14: Using r5 hash to sort names
[   38.558000] ReiserFS: sda8: found reiserfs format "3.6" with standard journal
[   38.558000] ReiserFS: sda8: warning: CONFIG_REISERFS_CHECK is set ON
[   38.558000] ReiserFS: sda8: warning: - it is slow mode for debugging.
[   38.558000] ReiserFS: sda8: using ordered data mode
[   38.565000] ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.566000] ReiserFS: sda8: checking transaction log (sda8)
[   38.566000] ReiserFS: sda8: journal-1153: found in header: first_unflushed_offset 6697, last_flushed_trans_id 571523
[   38.574000] ReiserFS: sda8: journal-1206: Starting replay from offset 2454676888885801, trans_id 3223281428
[   38.574000] ReiserFS: sda8: journal-1299: Setting newest_mount_id to 176
[   38.617000] ReiserFS: sda8: Using r5 hash to sort names
[   38.687000] ReiserFS: sda11: found reiserfs format "3.6" with standard journal
[   38.688000] ReiserFS: sda11: warning: CONFIG_REISERFS_CHECK is set ON
[   38.688000] ReiserFS: sda11: warning: - it is slow mode for debugging.
[   38.688000] ReiserFS: sda11: using ordered data mode
[   38.715000] ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.716000] ReiserFS: sda11: checking transaction log (sda11)
[   38.716000] ReiserFS: sda11: journal-1153: found in header: first_unflushed_offset 5253, last_flushed_trans_id 20436
[   38.749000] ReiserFS: sda11: journal-1206: Starting replay from offset 87776246633605, trans_id 3223281428
[   38.749000] ReiserFS: sda11: journal-1299: Setting newest_mount_id to 176
[   38.771000] ReiserFS: sda11: Using r5 hash to sort names
[   38.798000] ReiserFS: sda10: found reiserfs format "3.6" with standard journal
[   38.799000] ReiserFS: sda10: warning: CONFIG_REISERFS_CHECK is set ON
[   38.799000] ReiserFS: sda10: warning: - it is slow mode for debugging.
[   38.799000] ReiserFS: sda10: using ordered data mode
[   38.809000] ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.809000] ReiserFS: sda10: checking transaction log (sda10)
[   38.810000] ReiserFS: sda10: journal-1153: found in header: first_unflushed_offset 3806, last_flushed_trans_id 20392
[   38.820000] ReiserFS: sda10: journal-1206: Starting replay from offset 87587268071134, trans_id 3223281428
[   38.820000] ReiserFS: sda10: journal-1299: Setting newest_mount_id to 176
[   38.831000] ReiserFS: sda10: Using r5 hash to sort names
[   38.848000] ReiserFS: sda9: found reiserfs format "3.6" with standard journal
[   38.848000] ReiserFS: sda9: warning: CONFIG_REISERFS_CHECK is set ON
[   38.848000] ReiserFS: sda9: warning: - it is slow mode for debugging.
[   38.849000] ReiserFS: sda9: using ordered data mode
[   38.855000] ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.856000] ReiserFS: sda9: checking transaction log (sda9)
[   38.856000] ReiserFS: sda9: journal-1153: found in header: first_unflushed_offset 6872, last_flushed_trans_id 96225
[   38.859000] ReiserFS: sda9: journal-1206: Starting replay from offset 413287523031768, trans_id 4155609112
[   38.859000] ReiserFS: sda9: journal-1299: Setting newest_mount_id to 176
[   38.871000] ReiserFS: sda9: Using r5 hash to sort names
[   38.898000] ReiserFS: sda7: found reiserfs format "3.6" with standard journal
[   38.898000] ReiserFS: sda7: warning: CONFIG_REISERFS_CHECK is set ON
[   38.899000] ReiserFS: sda7: warning: - it is slow mode for debugging.
[   38.899000] ReiserFS: sda7: using ordered data mode
[   38.903000] ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.903000] ReiserFS: sda7: checking transaction log (sda7)
[   38.904000] ReiserFS: sda7: journal-1153: found in header: first_unflushed_offset 5590, last_flushed_trans_id 581233
[   38.909000] ReiserFS: sda7: journal-1206: Starting replay from offset 2496381021328854, trans_id 24000000
[   38.910000] ReiserFS: sda7: journal-1299: Setting newest_mount_id to 176
[   38.953000] ReiserFS: sda7: Using r5 hash to sort names
[   39.014000] ReiserFS: sda6: found reiserfs format "3.6" with standard journal
[   39.015000] ReiserFS: sda6: warning: CONFIG_REISERFS_CHECK is set ON
[   39.015000] ReiserFS: sda6: warning: - it is slow mode for debugging.
[   39.015000] ReiserFS: sda6: using ordered data mode
[   39.052000] ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   39.052000] ReiserFS: sda6: checking transaction log (sda6)
[   39.052000] ReiserFS: sda6: journal-1153: found in header: first_unflushed_offset 2919, last_flushed_trans_id 787426
[   39.078000] ReiserFS: sda6: journal-1206: Starting replay from offset 3381973212990311, trans_id 30000000
[   39.078000] ReiserFS: sda6: journal-1299: Setting newest_mount_id to 176
[   39.167000] ReiserFS: sda6: Using r5 hash to sort names
[   39.284000] kjournald starting.  Commit interval 5 seconds
[   39.284000] EXT3 FS on mmcblk0p1, internal journal
[   39.284000] EXT3-fs: mounted filesystem with ordered data mode.

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg.2.6.19-rc3-ts-tp-ie-e1-44.1+1430-g06df5d4f-dirty.run"

 IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
[    0.000000] Detected 1662.624 MHz processor.
[   10.539368] Built 1 zonelists.  Total pages: 517875
[   10.539373] Kernel command line: root=/dev/sda5 ro resume
[   10.539720] mapped APIC to ffffd000 (fee00000)
[   10.539724] mapped IOAPIC to ffffc000 (fec00000)
[   10.539728] Enabling fast FPU save and restore... done.
[   10.539733] Enabling unmasked SIMD FPU exception support... done.
[   10.539737] Initializing CPU#0
[   10.539818] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   10.541567] Console: colour VGA+ 80x25
[   10.545995] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   10.546589] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   10.688172] Memory: 2065788k/2087808k available (1949k kernel code, 20860k reserved, 775k data, 176k init, 1170304k highmem)
[   10.688330] virtual kernel memory layout:
[   10.688332]     fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
[   10.688334]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   10.688336]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   10.688339]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   10.688341]       .init : 0xc0400000 - 0xc042c000   ( 176 kB)
[   10.688343]       .data : 0xc02e77a9 - 0xc03a9414   ( 775 kB)
[   10.688346]       .text : 0xc0100000 - 0xc02e77a9   (1949 kB)
[   10.689084] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   10.689471] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   10.689749] hpet0: 3 64-bit timers, 14318180 Hz
[   10.690845] Using HPET for base-timer
[   10.750381] Calibrating delay using timer specific routine.. 3328.29 BogoMIPS (lpj=1664148)
[   10.750612] Security Framework v1.0.0 initialized
[   10.750710] Capability LSM initialized
[   10.750819] Mount-cache hash table entries: 512
[   10.751046] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[   10.751058] monitor/mwait feature present.
[   10.751150] using mwait in idle threads.
[   10.751243] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.751392] CPU: L2 cache: 2048K
[   10.751481] CPU: Physical Processor ID: 0
[   10.751571] CPU: Processor Core ID: 0
[   10.751661] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[   10.751672] Intel machine check architecture supported.
[   10.751771] Intel machine check reporting enabled on CPU#0.
[   10.751869] Compat vDSO mapped to ffffe000.
[   10.751972] Checking 'hlt' instruction... OK.
[   10.755540] SMP alternatives: switching to UP code
[   10.755838] ACPI: Core revision 20060707
[   10.779647] CPU0: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[   10.779925] SMP alternatives: switching to SMP code
[   10.780081] Booting processor 1/1 eip 3000
[   10.791299] Initializing CPU#1
[   10.851566] Calibrating delay using timer specific routine.. 3325.08 BogoMIPS (lpj=1662541)
[   10.851575] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[   10.851584] monitor/mwait feature present.
[   10.851589] CPU: L1 I cache: 32K, L1 D cache: 32K
[   10.851593] CPU: L2 cache: 2048K
[   10.851596] CPU: Physical Processor ID: 0
[   10.851599] CPU: Processor Core ID: 1
[   10.851601] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[   10.851610] Intel machine check architecture supported.
[   10.851619] Intel machine check reporting enabled on CPU#1.
[   10.851890] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[   10.853013] Total of 2 processors activated (6653.37 BogoMIPS).
[   10.853317] ENABLING IO-APIC IRQs
[   10.853624] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   10.965046] checking TSC synchronization across 2 CPUs: 
[    0.000086] CPU#0 had -172 usecs TSC skew, fixed it up.
[    0.000181] CPU#1 had 172 usecs TSC skew, fixed it up.
[    0.000949] Brought up 2 CPUs
[    0.307634] migration_cost=117
[    0.308430] NET: Registered protocol family 16
[    0.308637] ACPI: bus type pci registered
[    0.308735] PCI: Using MMCONFIG
[    0.309658] Setting up standard PCI resources
[    0.328979] ACPI: Interpreter enabled
[    0.329072] ACPI: Using IOAPIC for interrupt routing
[    0.330596] ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11)
[    0.332204] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11)
[    0.333820] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11)
[    0.335446] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11)
[    0.337062] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.338682] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.340286] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11)
[    0.341902] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.343116] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.343214] PCI: Probing PCI hardware (bus 00)
[    0.348387] Boot video device is 0000:00:02.0
[    0.348988] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.349086] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.349227] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.350564] PCI: Transparent bridge - 0000:00:1e.0
[    0.350806] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.358912] ACPI: Power Resource [PUBS] (on)
[    0.361453] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[    0.361772] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.362089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.362477] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP3._PRT]
[    0.362853] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.365662] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.365766] pnp: PnP ACPI init
[    0.372613] pnp: PnP ACPI: found 12 devices
[    0.372737] intel_rng: FWH not detected
[    0.373008] SCSI subsystem initialized
[    0.373188] PCI: Using ACPI for IRQ routing
[    0.373280] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.374947] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    0.375046] PCI: Bridge: 0000:00:1c.0
[    0.375138]   IO window: 2000-2fff
[    0.375231]   MEM window: ee000000-ee0fffff
[    0.375323]   PREFETCH window: disabled.
[    0.375425] PCI: Bridge: 0000:00:1c.1
[    0.375516]   IO window: 3000-4fff
[    0.375609]   MEM window: ec000000-edffffff
[    0.375702]   PREFETCH window: e4000000-e40fffff
[    0.375798] PCI: Bridge: 0000:00:1c.2
[    0.375891]   IO window: 5000-6fff
[    0.375985]   MEM window: e8000000-e9ffffff
[    0.376080]   PREFETCH window: e4100000-e41fffff
[    0.376175] PCI: Bridge: 0000:00:1c.3
[    0.376267]   IO window: 7000-8fff
[    0.376370]   MEM window: ea000000-ebffffff
[    0.376465]   PREFETCH window: e4200000-e42fffff
[    0.376567] PCI: Bus 22, cardbus bridge: 0000:15:00.0
[    0.376661]   IO window: 00009000-000090ff
[    0.376756]   IO window: 00009400-000094ff
[    0.376852]   PREFETCH window: e0000000-e1ffffff
[    0.376948]   MEM window: e6000000-e7ffffff
[    0.377042] PCI: Bridge: 0000:00:1e.0
[    0.377135]   IO window: 9000-cfff
[    0.377229]   MEM window: e4300000-e7ffffff
[    0.377324]   PREFETCH window: e0000000-e3ffffff
[    0.377449] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 16
[    0.377635] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.377658] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 17
[    0.377843] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.377866] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
[    0.378050] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.378072] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 19
[    0.378257] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.378268] PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
[    0.378374] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.378393] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.378579] PCI: Setting latency timer of device 0000:15:00.0 to 64
[    0.378614] NET: Registered protocol family 2
[    0.391378] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.391621] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.394548] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.395357] TCP: Hash tables configured (established 262144 bind 65536)
[    0.395453] TCP reno registered
[    0.395768] Simple Boot Flag at 0x35 set to 0x1
[    0.396509] audit: initializing netlink socket (disabled)
[    0.396620] audit(1162223349.853:1): initialized
[    0.396812] highmem bounce pool size: 64 pages
[    0.397170] io scheduler noop registered
[    0.397313] io scheduler anticipatory registered
[    0.397454] io scheduler deadline registered
[    0.397607] io scheduler cfq registered (default)
[    0.398102] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.398156] assign_interrupt_mode Found MSI capability
[    0.398309] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.398370] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.398428] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.398548] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.398601] assign_interrupt_mode Found MSI capability
[    0.399564] Allocate Port Service[0000:00:1c.1:pcie00]
[    0.399614] Allocate Port Service[0000:00:1c.1:pcie02]
[    0.399661] Allocate Port Service[0000:00:1c.1:pcie03]
[    0.399775] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.399828] assign_interrupt_mode Found MSI capability
[    0.399962] Allocate Port Service[0000:00:1c.2:pcie00]
[    0.400009] Allocate Port Service[0000:00:1c.2:pcie02]
[    0.400061] Allocate Port Service[0000:00:1c.2:pcie03]
[    0.400175] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.400228] assign_interrupt_mode Found MSI capability
[    0.400368] Allocate Port Service[0000:00:1c.3:pcie00]
[    0.400418] Allocate Port Service[0000:00:1c.3:pcie02]
[    0.400465] Allocate Port Service[0000:00:1c.3:pcie03]
[    0.433651] Real Time Clock Driver v1.12ac
[    0.433809] hpet_resources: 0xfed00000 is busy
[    0.433837] Linux agpgart interface v0.101 (c) Dave Jones
[    0.433975] agpgart: Detected an Intel 945GM Chipset.
[    0.435945] agpgart: Detected 7932K stolen memory.
[    0.453538] agpgart: AGP aperture is 256M @ 0xd0000000
[    0.453679] [drm] Initialized drm 1.0.1 20051102
[    0.454166] loop: loaded (max 8 devices)
[    0.454264] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2-NAPI
[    0.454358] Copyright (c) 1999-2006 Intel Corporation.
[    0.454526] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.454719] PCI: Setting latency timer of device 0000:02:00.0 to 64
[    0.460267] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:16:d3:22:9b:82
[    0.505134] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    0.505373] netconsole: not configured, aborting
[    0.505579] libata version 2.00 loaded.
[    0.505629] ahci 0000:00:1f.2: version 2.0
[    0.505647] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[    1.507573] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    1.507583] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[    1.507722] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    1.507910] ata1: SATA max UDMA/133 cmd 0xF8824500 ctl 0x0 bmdma 0x0 irq 219
[    1.508079] ata2: SATA max UDMA/133 cmd 0xF8824580 ctl 0x0 bmdma 0x0 irq 219
[    1.508251] ata3: SATA max UDMA/133 cmd 0xF8824600 ctl 0x0 bmdma 0x0 irq 219
[    1.508419] ata4: SATA max UDMA/133 cmd 0xF8824680 ctl 0x0 bmdma 0x0 irq 219
[    1.508524] scsi0 : ahci
[    1.966832] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.967289] ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
[    1.967424] ata1.00: ata1: dev 0 multi count 16
[    1.969850] ata1.00: configured for UDMA/100
[    1.969952] scsi1 : ahci
[    2.273333] ata2: SATA link down (SStatus 0 SControl 0)
[    2.273440] scsi2 : ahci
[    2.576850] ata3: SATA link down (SStatus 0 SControl 0)
[    2.576953] scsi3 : ahci
[    2.880368] ata4: SATA link down (SStatus 0 SControl 0)
[    2.880597] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0084 PQ: 0 ANSI: 5
[    2.880870] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.880982] sda: Write Protect is off
[    2.881073] sda: Mode Sense: 00 3a 00 00
[    2.881099] SCSI device sda: drive cache: write back
[    2.881251] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.881362] sda: Write Protect is off
[    2.881453] sda: Mode Sense: 00 3a 00 00
[    2.881478] SCSI device sda: drive cache: write back
[    2.881575]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
[    3.052953] sd 0:0:0:0: Attached scsi disk sda
[    3.053295] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.064269] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.064367] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.064626] mice: PS/2 mouse device common for all mice
[    3.064722] i2c /dev entries driver
[    3.064957] ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 19
[    3.065268] hdaps: LENOVO ThinkPad X60 detected, inverting axes
[    3.069987] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.076297] hdaps: initial mode latch is 0x05
[    3.076468] hdaps: setting ec_rate=250, filter_order=2
[    3.076509] hdaps: fake_data_mode set to 0
[    3.076732] hdaps: device successfully initialized.
[    3.076906] input: hdaps as /class/input/input1
[    3.076999] hdaps: driver successfully loaded.
[    3.077093] EDAC MC: Ver: 2.0.1 Oct 30 2006
[    3.077714] thinkpad_ec: thinkpad_ec 0.30 loaded.
[    3.077956] TCP bic registered
[    3.078057] NET: Registered protocol family 1
[    3.078153] NET: Registered protocol family 17
[    3.078263] Starting balanced_irq
[    3.078359] Using IPI No-Shortcut mode
[    3.078884] ACPI: (supports S0 S3 S4 S5)
[    3.079246] Time: tsc clocksource has been installed.
[    3.079386] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    3.082224] VFS: Mounted root (ext2 filesystem) readonly.
[    3.082457] Freeing unused kernel memory: 176k freed
[    6.179063] ieee1394: Initialized config rom entry `ip1394'
[    6.181760] ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 21
[    6.181958] PCI: Setting latency timer of device 0000:15:00.1 to 64
[    6.235209] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    6.349287] input: PC Speaker as /class/input/input2
[    6.712159] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    6.712263] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    6.908445] usbcore: registered new interface driver usbfs
[    6.908579] usbcore: registered new interface driver hub
[    6.908711] usbcore: registered new device driver usb
[    7.089196] irda_init()
[    7.089213] NET: Registered protocol family 23
[    7.146382] USB Universal Host Controller Interface driver v3.0
[    7.146545] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[    7.146745] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    7.146751] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    7.147058] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    7.147234] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
[    7.147488] usb usb1: configuration #1 chosen from 1 choice
[    7.147628] hub 1-0:1.0: USB hub found
[    7.147726] hub 1-0:1.0: 2 ports detected
[    7.198161] sdhci: Secure Digital Host Controller Interface driver, 0.12
[    7.198263] sdhci: Copyright(c) Pierre Ossman
[    7.248594] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
[    7.248798] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    7.248804] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    7.248942] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    7.249108] uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001840
[    7.249338] usb usb2: configuration #1 chosen from 1 choice
[    7.249818] hub 2-0:1.0: USB hub found
[    7.249917] hub 2-0:1.0: 2 ports detected
[    7.351432] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
[    7.351634] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    7.351640] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    7.351771] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    7.351940] uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001860
[    7.352165] usb usb3: configuration #1 chosen from 1 choice
[    7.352305] hub 3-0:1.0: USB hub found
[    7.352401] hub 3-0:1.0: 2 ports detected
[    7.453217] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[    7.453403] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    7.453408] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    7.453537] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    7.453701] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001880
[    7.453921] usb usb4: configuration #1 chosen from 1 choice
[    7.454051] hub 4-0:1.0: USB hub found
[    7.454150] hub 4-0:1.0: 2 ports detected
[    7.499170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40600192017]
[    7.555770] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[    7.555969] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    7.555975] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    7.556109] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    7.556283] ehci_hcd 0000:00:1d.7: debug port 1
[    7.556384] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    7.556395] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xee444000
[    7.560381] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    7.560837] usb usb5: configuration #1 chosen from 1 choice
[    7.560967] hub 5-0:1.0: USB hub found
[    7.561064] hub 5-0:1.0: 8 ports detected
[    7.563438] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[    7.637032] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    7.657935] input: TPPS/2 IBM TrackPoint as /class/input/input3
[    7.661955] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
[    7.663374] pnp: Device 00:0a activated.
[    7.663471] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 7 ; dma 1.
[    7.663500] nsc-ircc, chip->init
[    7.663605] nsc-ircc, Found chip at base=0x164e
[    7.663738] nsc-ircc, driver loaded (Dag Brattli)
[    7.663925] IrDA: Registered device irda0
[    7.664080] nsc-ircc, Found dongle: No dongle connected
[    7.664183] nsc_ircc_init_dongle_interface(), No dongle connected
[    7.785417] Yenta: ISA IRQ mask 0x0c38, PCI irq 20
[    7.785519] Socket status: 30000006
[    7.785615] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
[    7.785713] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
[    7.785812] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
[    7.786199] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[    7.786450] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[    8.303763] usb 4-1: new full speed USB device using uhci_hcd and address 2
[    8.465387] usb 4-1: configuration #1 chosen from 1 choice
[    8.550092] Bluetooth: Core ver 2.11
[    8.550695] NET: Registered protocol family 31
[    8.550795] Bluetooth: HCI device and connection manager initialized
[    8.550892] Bluetooth: HCI socket layer initialized
[    8.559175] Bluetooth: HCI USB driver ver 2.9
[    8.677160] usb 4-2: new full speed USB device using uhci_hcd and address 3
[    8.833905] hda_intel: No response from codec, disabling MSI...
[    8.842826] usb 4-2: configuration #1 chosen from 1 choice
[    8.847946] usbcore: registered new interface driver hci_usb
[    9.833318] hda_intel: azx_get_response timeout, switching to polling mode...
[   10.832730] hda_intel: azx_get_response timeout, switching to single_cmd mode...
[   21.618159] sdhci: SDHCI controller found at 0000:15:00.2 [1180:0822] (rev 18)
[   21.619154] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
[   21.620362] PCI: Setting latency timer of device 0000:15:00.2 to 64
[   21.622574] mmc0: SDHCI at 0xe4301800 irq 22 DMA
[   22.346566] Adding 1951856k swap on /dev/sda12.  Priority:-1 extents:1 across:1951856k
[   22.347780] Adding 2931820k swap on /dev/sda13.  Priority:-2 extents:1 across:2931820k
[   22.692872] Non-volatile memory driver v1.2
[   22.731265] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   22.731365] ieee1394: sbp2: Try serialize_io=0 for better performance
[   22.764737] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[   22.764844] ibm_acpi: http://ibm-acpi.sf.net/
[   22.785014] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   22.785828] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   22.787166] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   22.787446] ACPI: Processor [CPU0] (supports 8 throttling states)
[   22.788615] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   22.789318] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   22.790705] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   22.790991] ACPI: Processor [CPU1] (supports 8 throttling states)
[   23.002000] Time: hpet clocksource has been installed.
[   23.019000] mmcblk0: mmc0:b368 SD    249856KiB 
[   23.019000]  mmcblk0: p1
[   38.427000] ReiserFS: sda14: found reiserfs format "3.6" with standard journal
[   38.427000] ReiserFS: sda14: warning: CONFIG_REISERFS_CHECK is set ON
[   38.427000] ReiserFS: sda14: warning: - it is slow mode for debugging.
[   38.427000] ReiserFS: sda14: using ordered data mode
[   38.450000] ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.451000] ReiserFS: sda14: checking transaction log (sda14)
[   38.451000] ReiserFS: sda14: journal-1153: found in header: first_unflushed_offset 7418, last_flushed_trans_id 30277
[   38.453000] ReiserFS: sda14: journal-1206: Starting replay from offset 130043019795706, trans_id 3223281428
[   38.453000] ReiserFS: sda14: journal-1299: Setting newest_mount_id to 176
[   38.495000] ReiserFS: sda14: Using r5 hash to sort names
[   38.558000] ReiserFS: sda8: found reiserfs format "3.6" with standard journal
[   38.558000] ReiserFS: sda8: warning: CONFIG_REISERFS_CHECK is set ON
[   38.558000] ReiserFS: sda8: warning: - it is slow mode for debugging.
[   38.558000] ReiserFS: sda8: using ordered data mode
[   38.565000] ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.566000] ReiserFS: sda8: checking transaction log (sda8)
[   38.566000] ReiserFS: sda8: journal-1153: found in header: first_unflushed_offset 6697, last_flushed_trans_id 571523
[   38.574000] ReiserFS: sda8: journal-1206: Starting replay from offset 2454676888885801, trans_id 3223281428
[   38.574000] ReiserFS: sda8: journal-1299: Setting newest_mount_id to 176
[   38.617000] ReiserFS: sda8: Using r5 hash to sort names
[   38.687000] ReiserFS: sda11: found reiserfs format "3.6" with standard journal
[   38.688000] ReiserFS: sda11: warning: CONFIG_REISERFS_CHECK is set ON
[   38.688000] ReiserFS: sda11: warning: - it is slow mode for debugging.
[   38.688000] ReiserFS: sda11: using ordered data mode
[   38.715000] ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.716000] ReiserFS: sda11: checking transaction log (sda11)
[   38.716000] ReiserFS: sda11: journal-1153: found in header: first_unflushed_offset 5253, last_flushed_trans_id 20436
[   38.749000] ReiserFS: sda11: journal-1206: Starting replay from offset 87776246633605, trans_id 3223281428
[   38.749000] ReiserFS: sda11: journal-1299: Setting newest_mount_id to 176
[   38.771000] ReiserFS: sda11: Using r5 hash to sort names
[   38.798000] ReiserFS: sda10: found reiserfs format "3.6" with standard journal
[   38.799000] ReiserFS: sda10: warning: CONFIG_REISERFS_CHECK is set ON
[   38.799000] ReiserFS: sda10: warning: - it is slow mode for debugging.
[   38.799000] ReiserFS: sda10: using ordered data mode
[   38.809000] ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.809000] ReiserFS: sda10: checking transaction log (sda10)
[   38.810000] ReiserFS: sda10: journal-1153: found in header: first_unflushed_offset 3806, last_flushed_trans_id 20392
[   38.820000] ReiserFS: sda10: journal-1206: Starting replay from offset 87587268071134, trans_id 3223281428
[   38.820000] ReiserFS: sda10: journal-1299: Setting newest_mount_id to 176
[   38.831000] ReiserFS: sda10: Using r5 hash to sort names
[   38.848000] ReiserFS: sda9: found reiserfs format "3.6" with standard journal
[   38.848000] ReiserFS: sda9: warning: CONFIG_REISERFS_CHECK is set ON
[   38.848000] ReiserFS: sda9: warning: - it is slow mode for debugging.
[   38.849000] ReiserFS: sda9: using ordered data mode
[   38.855000] ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.856000] ReiserFS: sda9: checking transaction log (sda9)
[   38.856000] ReiserFS: sda9: journal-1153: found in header: first_unflushed_offset 6872, last_flushed_trans_id 96225
[   38.859000] ReiserFS: sda9: journal-1206: Starting replay from offset 413287523031768, trans_id 4155609112
[   38.859000] ReiserFS: sda9: journal-1299: Setting newest_mount_id to 176
[   38.871000] ReiserFS: sda9: Using r5 hash to sort names
[   38.898000] ReiserFS: sda7: found reiserfs format "3.6" with standard journal
[   38.898000] ReiserFS: sda7: warning: CONFIG_REISERFS_CHECK is set ON
[   38.899000] ReiserFS: sda7: warning: - it is slow mode for debugging.
[   38.899000] ReiserFS: sda7: using ordered data mode
[   38.903000] ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.903000] ReiserFS: sda7: checking transaction log (sda7)
[   38.904000] ReiserFS: sda7: journal-1153: found in header: first_unflushed_offset 5590, last_flushed_trans_id 581233
[   38.909000] ReiserFS: sda7: journal-1206: Starting replay from offset 2496381021328854, trans_id 24000000
[   38.910000] ReiserFS: sda7: journal-1299: Setting newest_mount_id to 176
[   38.953000] ReiserFS: sda7: Using r5 hash to sort names
[   39.014000] ReiserFS: sda6: found reiserfs format "3.6" with standard journal
[   39.015000] ReiserFS: sda6: warning: CONFIG_REISERFS_CHECK is set ON
[   39.015000] ReiserFS: sda6: warning: - it is slow mode for debugging.
[   39.015000] ReiserFS: sda6: using ordered data mode
[   39.052000] ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   39.052000] ReiserFS: sda6: checking transaction log (sda6)
[   39.052000] ReiserFS: sda6: journal-1153: found in header: first_unflushed_offset 2919, last_flushed_trans_id 787426
[   39.078000] ReiserFS: sda6: journal-1206: Starting replay from offset 3381973212990311, trans_id 30000000
[   39.078000] ReiserFS: sda6: journal-1299: Setting newest_mount_id to 176
[   39.167000] ReiserFS: sda6: Using r5 hash to sort names
[   39.284000] kjournald starting.  Commit interval 5 seconds
[   39.284000] EXT3 FS on mmcblk0p1, internal journal
[   39.284000] EXT3-fs: mounted filesystem with ordered data mode.
[   51.071000] ACPI: AC Adapter [AC] (off-line)
[   51.096000] ACPI: Battery Slot [BAT0] (battery present)
[   51.111000] ACPI: Power Button (FF) [PWRF]
[   51.111000] ACPI: Lid Switch [LID]
[   51.111000] ACPI: Sleep Button (CM) [SLPB]
[   51.127000] ACPI: ACPI Dock Station Driver 
[   51.177000] ACPI: Thermal Zone [THM0] (46 C)
[   51.179000] ACPI: Thermal Zone [THM1] (47 C)
[   51.194000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   51.195000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   64.840000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[   65.195000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[   65.195000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[   65.198000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   66.484000] hda_intel: No response from codec, disabling MSI...
[   67.485000] hda_intel: azx_get_response timeout, switching to polling mode...
[   71.911000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 20
[   71.912000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[  155.470000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
[  155.470000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
[  155.914000] ACPI: docking
[  156.289000] usb 5-6: new high speed USB device using ehci_hcd and address 4
[  156.403000] usb 5-6: configuration #1 chosen from 1 choice
[  156.403000] hub 5-6:1.0: USB hub found
[  156.403000] hub 5-6:1.0: 4 ports detected
[  156.682000] usb 5-6.1: new low speed USB device using ehci_hcd and address 5
[  156.773000] usb 5-6.1: configuration #1 chosen from 1 choice
[  156.951000] usb 5-6.3: new low speed USB device using ehci_hcd and address 6
[  157.057000] usb 5-6.3: configuration #1 chosen from 1 choice
[  157.202000] usbcore: registered new interface driver hiddev
[  157.204000] input: Logitech USB-PS/2 Optical Mouse as /class/input/input4
[  157.205000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.7-6.1
[  157.212000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input5
[  157.212000] input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  157.223000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input6
[  157.223000] input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  157.223000] usbcore: registered new interface driver usbhid
[  157.223000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg.2.6.19-rc3-ts-tp-ie-e1-44.1+1430-g06df5d4f-dirty.run2"

ded (max 8 devices)
[    0.454264] Intel(R) PRO/1000 Network Driver - version 7.2.9-k2-NAPI
[    0.454358] Copyright (c) 1999-2006 Intel Corporation.
[    0.454526] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[    0.454719] PCI: Setting latency timer of device 0000:02:00.0 to 64
[    0.460267] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:32-bit) 00:16:d3:22:9b:82
[    0.505134] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    0.505373] netconsole: not configured, aborting
[    0.505579] libata version 2.00 loaded.
[    0.505629] ahci 0000:00:1f.2: version 2.0
[    0.505647] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[    1.507573] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    1.507583] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[    1.507722] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    1.507910] ata1: SATA max UDMA/133 cmd 0xF8824500 ctl 0x0 bmdma 0x0 irq 219
[    1.508079] ata2: SATA max UDMA/133 cmd 0xF8824580 ctl 0x0 bmdma 0x0 irq 219
[    1.508251] ata3: SATA max UDMA/133 cmd 0xF8824600 ctl 0x0 bmdma 0x0 irq 219
[    1.508419] ata4: SATA max UDMA/133 cmd 0xF8824680 ctl 0x0 bmdma 0x0 irq 219
[    1.508524] scsi0 : ahci
[    1.966832] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.967289] ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
[    1.967424] ata1.00: ata1: dev 0 multi count 16
[    1.969850] ata1.00: configured for UDMA/100
[    1.969952] scsi1 : ahci
[    2.273333] ata2: SATA link down (SStatus 0 SControl 0)
[    2.273440] scsi2 : ahci
[    2.576850] ata3: SATA link down (SStatus 0 SControl 0)
[    2.576953] scsi3 : ahci
[    2.880368] ata4: SATA link down (SStatus 0 SControl 0)
[    2.880597] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2080B 0084 PQ: 0 ANSI: 5
[    2.880870] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.880982] sda: Write Protect is off
[    2.881073] sda: Mode Sense: 00 3a 00 00
[    2.881099] SCSI device sda: drive cache: write back
[    2.881251] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    2.881362] sda: Write Protect is off
[    2.881453] sda: Mode Sense: 00 3a 00 00
[    2.881478] SCSI device sda: drive cache: write back
[    2.881575]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
[    3.052953] sd 0:0:0:0: Attached scsi disk sda
[    3.053295] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.064269] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.064367] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.064626] mice: PS/2 mouse device common for all mice
[    3.064722] i2c /dev entries driver
[    3.064957] ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 19
[    3.065268] hdaps: LENOVO ThinkPad X60 detected, inverting axes
[    3.069987] input: AT Translated Set 2 keyboard as /class/input/input0
[    3.076297] hdaps: initial mode latch is 0x05
[    3.076468] hdaps: setting ec_rate=250, filter_order=2
[    3.076509] hdaps: fake_data_mode set to 0
[    3.076732] hdaps: device successfully initialized.
[    3.076906] input: hdaps as /class/input/input1
[    3.076999] hdaps: driver successfully loaded.
[    3.077093] EDAC MC: Ver: 2.0.1 Oct 30 2006
[    3.077714] thinkpad_ec: thinkpad_ec 0.30 loaded.
[    3.077956] TCP bic registered
[    3.078057] NET: Registered protocol family 1
[    3.078153] NET: Registered protocol family 17
[    3.078263] Starting balanced_irq
[    3.078359] Using IPI No-Shortcut mode
[    3.078884] ACPI: (supports S0 S3 S4 S5)
[    3.079246] Time: tsc clocksource has been installed.
[    3.079386] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    3.082224] VFS: Mounted root (ext2 filesystem) readonly.
[    3.082457] Freeing unused kernel memory: 176k freed
[    6.179063] ieee1394: Initialized config rom entry `ip1394'
[    6.181760] ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 21
[    6.181958] PCI: Setting latency timer of device 0000:15:00.1 to 64
[    6.235209] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    6.349287] input: PC Speaker as /class/input/input2
[    6.712159] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    6.712263] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    6.908445] usbcore: registered new interface driver usbfs
[    6.908579] usbcore: registered new interface driver hub
[    6.908711] usbcore: registered new device driver usb
[    7.089196] irda_init()
[    7.089213] NET: Registered protocol family 23
[    7.146382] USB Universal Host Controller Interface driver v3.0
[    7.146545] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[    7.146745] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    7.146751] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    7.147058] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    7.147234] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
[    7.147488] usb usb1: configuration #1 chosen from 1 choice
[    7.147628] hub 1-0:1.0: USB hub found
[    7.147726] hub 1-0:1.0: 2 ports detected
[    7.198161] sdhci: Secure Digital Host Controller Interface driver, 0.12
[    7.198263] sdhci: Copyright(c) Pierre Ossman
[    7.248594] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
[    7.248798] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    7.248804] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    7.248942] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    7.249108] uhci_hcd 0000:00:1d.1: irq 21, io base 0x00001840
[    7.249338] usb usb2: configuration #1 chosen from 1 choice
[    7.249818] hub 2-0:1.0: USB hub found
[    7.249917] hub 2-0:1.0: 2 ports detected
[    7.351432] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
[    7.351634] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    7.351640] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    7.351771] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    7.351940] uhci_hcd 0000:00:1d.2: irq 22, io base 0x00001860
[    7.352165] usb usb3: configuration #1 chosen from 1 choice
[    7.352305] hub 3-0:1.0: USB hub found
[    7.352401] hub 3-0:1.0: 2 ports detected
[    7.453217] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[    7.453403] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    7.453408] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    7.453537] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    7.453701] uhci_hcd 0000:00:1d.3: irq 23, io base 0x00001880
[    7.453921] usb usb4: configuration #1 chosen from 1 choice
[    7.454051] hub 4-0:1.0: USB hub found
[    7.454150] hub 4-0:1.0: 2 ports detected
[    7.499170] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40600192017]
[    7.555770] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[    7.555969] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    7.555975] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    7.556109] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    7.556283] ehci_hcd 0000:00:1d.7: debug port 1
[    7.556384] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    7.556395] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xee444000
[    7.560381] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    7.560837] usb usb5: configuration #1 chosen from 1 choice
[    7.560967] hub 5-0:1.0: USB hub found
[    7.561064] hub 5-0:1.0: 8 ports detected
[    7.563438] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[    7.637032] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    7.657935] input: TPPS/2 IBM TrackPoint as /class/input/input3
[    7.661955] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
[    7.663374] pnp: Device 00:0a activated.
[    7.663471] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 7 ; dma 1.
[    7.663500] nsc-ircc, chip->init
[    7.663605] nsc-ircc, Found chip at base=0x164e
[    7.663738] nsc-ircc, driver loaded (Dag Brattli)
[    7.663925] IrDA: Registered device irda0
[    7.664080] nsc-ircc, Found dongle: No dongle connected
[    7.664183] nsc_ircc_init_dongle_interface(), No dongle connected
[    7.785417] Yenta: ISA IRQ mask 0x0c38, PCI irq 20
[    7.785519] Socket status: 30000006
[    7.785615] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
[    7.785713] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
[    7.785812] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
[    7.786199] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[    7.786450] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[    8.303763] usb 4-1: new full speed USB device using uhci_hcd and address 2
[    8.465387] usb 4-1: configuration #1 chosen from 1 choice
[    8.550092] Bluetooth: Core ver 2.11
[    8.550695] NET: Registered protocol family 31
[    8.550795] Bluetooth: HCI device and connection manager initialized
[    8.550892] Bluetooth: HCI socket layer initialized
[    8.559175] Bluetooth: HCI USB driver ver 2.9
[    8.677160] usb 4-2: new full speed USB device using uhci_hcd and address 3
[    8.833905] hda_intel: No response from codec, disabling MSI...
[    8.842826] usb 4-2: configuration #1 chosen from 1 choice
[    8.847946] usbcore: registered new interface driver hci_usb
[    9.833318] hda_intel: azx_get_response timeout, switching to polling mode...
[   10.832730] hda_intel: azx_get_response timeout, switching to single_cmd mode...
[   21.618159] sdhci: SDHCI controller found at 0000:15:00.2 [1180:0822] (rev 18)
[   21.619154] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
[   21.620362] PCI: Setting latency timer of device 0000:15:00.2 to 64
[   21.622574] mmc0: SDHCI at 0xe4301800 irq 22 DMA
[   22.346566] Adding 1951856k swap on /dev/sda12.  Priority:-1 extents:1 across:1951856k
[   22.347780] Adding 2931820k swap on /dev/sda13.  Priority:-2 extents:1 across:2931820k
[   22.692872] Non-volatile memory driver v1.2
[   22.731265] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   22.731365] ieee1394: sbp2: Try serialize_io=0 for better performance
[   22.764737] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[   22.764844] ibm_acpi: http://ibm-acpi.sf.net/
[   22.785014] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   22.785828] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   22.787166] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   22.787446] ACPI: Processor [CPU0] (supports 8 throttling states)
[   22.788615] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   22.789318] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   22.790705] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   22.790991] ACPI: Processor [CPU1] (supports 8 throttling states)
[   23.002000] Time: hpet clocksource has been installed.
[   23.019000] mmcblk0: mmc0:b368 SD    249856KiB 
[   23.019000]  mmcblk0: p1
[   38.427000] ReiserFS: sda14: found reiserfs format "3.6" with standard journal
[   38.427000] ReiserFS: sda14: warning: CONFIG_REISERFS_CHECK is set ON
[   38.427000] ReiserFS: sda14: warning: - it is slow mode for debugging.
[   38.427000] ReiserFS: sda14: using ordered data mode
[   38.450000] ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.451000] ReiserFS: sda14: checking transaction log (sda14)
[   38.451000] ReiserFS: sda14: journal-1153: found in header: first_unflushed_offset 7418, last_flushed_trans_id 30277
[   38.453000] ReiserFS: sda14: journal-1206: Starting replay from offset 130043019795706, trans_id 3223281428
[   38.453000] ReiserFS: sda14: journal-1299: Setting newest_mount_id to 176
[   38.495000] ReiserFS: sda14: Using r5 hash to sort names
[   38.558000] ReiserFS: sda8: found reiserfs format "3.6" with standard journal
[   38.558000] ReiserFS: sda8: warning: CONFIG_REISERFS_CHECK is set ON
[   38.558000] ReiserFS: sda8: warning: - it is slow mode for debugging.
[   38.558000] ReiserFS: sda8: using ordered data mode
[   38.565000] ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.566000] ReiserFS: sda8: checking transaction log (sda8)
[   38.566000] ReiserFS: sda8: journal-1153: found in header: first_unflushed_offset 6697, last_flushed_trans_id 571523
[   38.574000] ReiserFS: sda8: journal-1206: Starting replay from offset 2454676888885801, trans_id 3223281428
[   38.574000] ReiserFS: sda8: journal-1299: Setting newest_mount_id to 176
[   38.617000] ReiserFS: sda8: Using r5 hash to sort names
[   38.687000] ReiserFS: sda11: found reiserfs format "3.6" with standard journal
[   38.688000] ReiserFS: sda11: warning: CONFIG_REISERFS_CHECK is set ON
[   38.688000] ReiserFS: sda11: warning: - it is slow mode for debugging.
[   38.688000] ReiserFS: sda11: using ordered data mode
[   38.715000] ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.716000] ReiserFS: sda11: checking transaction log (sda11)
[   38.716000] ReiserFS: sda11: journal-1153: found in header: first_unflushed_offset 5253, last_flushed_trans_id 20436
[   38.749000] ReiserFS: sda11: journal-1206: Starting replay from offset 87776246633605, trans_id 3223281428
[   38.749000] ReiserFS: sda11: journal-1299: Setting newest_mount_id to 176
[   38.771000] ReiserFS: sda11: Using r5 hash to sort names
[   38.798000] ReiserFS: sda10: found reiserfs format "3.6" with standard journal
[   38.799000] ReiserFS: sda10: warning: CONFIG_REISERFS_CHECK is set ON
[   38.799000] ReiserFS: sda10: warning: - it is slow mode for debugging.
[   38.799000] ReiserFS: sda10: using ordered data mode
[   38.809000] ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.809000] ReiserFS: sda10: checking transaction log (sda10)
[   38.810000] ReiserFS: sda10: journal-1153: found in header: first_unflushed_offset 3806, last_flushed_trans_id 20392
[   38.820000] ReiserFS: sda10: journal-1206: Starting replay from offset 87587268071134, trans_id 3223281428
[   38.820000] ReiserFS: sda10: journal-1299: Setting newest_mount_id to 176
[   38.831000] ReiserFS: sda10: Using r5 hash to sort names
[   38.848000] ReiserFS: sda9: found reiserfs format "3.6" with standard journal
[   38.848000] ReiserFS: sda9: warning: CONFIG_REISERFS_CHECK is set ON
[   38.848000] ReiserFS: sda9: warning: - it is slow mode for debugging.
[   38.849000] ReiserFS: sda9: using ordered data mode
[   38.855000] ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.856000] ReiserFS: sda9: checking transaction log (sda9)
[   38.856000] ReiserFS: sda9: journal-1153: found in header: first_unflushed_offset 6872, last_flushed_trans_id 96225
[   38.859000] ReiserFS: sda9: journal-1206: Starting replay from offset 413287523031768, trans_id 4155609112
[   38.859000] ReiserFS: sda9: journal-1299: Setting newest_mount_id to 176
[   38.871000] ReiserFS: sda9: Using r5 hash to sort names
[   38.898000] ReiserFS: sda7: found reiserfs format "3.6" with standard journal
[   38.898000] ReiserFS: sda7: warning: CONFIG_REISERFS_CHECK is set ON
[   38.899000] ReiserFS: sda7: warning: - it is slow mode for debugging.
[   38.899000] ReiserFS: sda7: using ordered data mode
[   38.903000] ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   38.903000] ReiserFS: sda7: checking transaction log (sda7)
[   38.904000] ReiserFS: sda7: journal-1153: found in header: first_unflushed_offset 5590, last_flushed_trans_id 581233
[   38.909000] ReiserFS: sda7: journal-1206: Starting replay from offset 2496381021328854, trans_id 24000000
[   38.910000] ReiserFS: sda7: journal-1299: Setting newest_mount_id to 176
[   38.953000] ReiserFS: sda7: Using r5 hash to sort names
[   39.014000] ReiserFS: sda6: found reiserfs format "3.6" with standard journal
[   39.015000] ReiserFS: sda6: warning: CONFIG_REISERFS_CHECK is set ON
[   39.015000] ReiserFS: sda6: warning: - it is slow mode for debugging.
[   39.015000] ReiserFS: sda6: using ordered data mode
[   39.052000] ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   39.052000] ReiserFS: sda6: checking transaction log (sda6)
[   39.052000] ReiserFS: sda6: journal-1153: found in header: first_unflushed_offset 2919, last_flushed_trans_id 787426
[   39.078000] ReiserFS: sda6: journal-1206: Starting replay from offset 3381973212990311, trans_id 30000000
[   39.078000] ReiserFS: sda6: journal-1299: Setting newest_mount_id to 176
[   39.167000] ReiserFS: sda6: Using r5 hash to sort names
[   39.284000] kjournald starting.  Commit interval 5 seconds
[   39.284000] EXT3 FS on mmcblk0p1, internal journal
[   39.284000] EXT3-fs: mounted filesystem with ordered data mode.
[   51.071000] ACPI: AC Adapter [AC] (off-line)
[   51.096000] ACPI: Battery Slot [BAT0] (battery present)
[   51.111000] ACPI: Power Button (FF) [PWRF]
[   51.111000] ACPI: Lid Switch [LID]
[   51.111000] ACPI: Sleep Button (CM) [SLPB]
[   51.127000] ACPI: ACPI Dock Station Driver 
[   51.177000] ACPI: Thermal Zone [THM0] (46 C)
[   51.179000] ACPI: Thermal Zone [THM1] (47 C)
[   51.194000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   51.195000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   64.840000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[   65.195000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[   65.195000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[   65.198000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   66.484000] hda_intel: No response from codec, disabling MSI...
[   67.485000] hda_intel: azx_get_response timeout, switching to polling mode...
[   71.911000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 20
[   71.912000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[  155.470000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
[  155.470000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
[  155.914000] ACPI: docking
[  156.289000] usb 5-6: new high speed USB device using ehci_hcd and address 4
[  156.403000] usb 5-6: configuration #1 chosen from 1 choice
[  156.403000] hub 5-6:1.0: USB hub found
[  156.403000] hub 5-6:1.0: 4 ports detected
[  156.682000] usb 5-6.1: new low speed USB device using ehci_hcd and address 5
[  156.773000] usb 5-6.1: configuration #1 chosen from 1 choice
[  156.951000] usb 5-6.3: new low speed USB device using ehci_hcd and address 6
[  157.057000] usb 5-6.3: configuration #1 chosen from 1 choice
[  157.202000] usbcore: registered new interface driver hiddev
[  157.204000] input: Logitech USB-PS/2 Optical Mouse as /class/input/input4
[  157.205000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.7-6.1
[  157.212000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input5
[  157.212000] input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  157.223000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input6
[  157.223000] input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  157.223000] usbcore: registered new interface driver usbhid
[  157.223000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  579.730000] usb 5-6.2: new high speed USB device using ehci_hcd and address 7
[  579.815000] usb 5-6.2: configuration #1 chosen from 1 choice
[  579.882000] Initializing USB Mass Storage driver...
[  579.882000] scsi4 : SCSI emulation for USB Mass Storage devices
[  579.882000] usb-storage: device found at 7
[  579.882000] usb-storage: waiting for device to settle before scanning
[  579.882000] usbcore: registered new interface driver usb-storage
[  579.882000] USB Mass Storage support registered.
[  584.884000] scsi 4:0:0:0: Direct-Access     USB 2.0  memory           0.00 PQ: 0 ANSI: 2
[  584.885000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[  584.886000] sdb: Write Protect is off
[  584.886000] sdb: Mode Sense: 00 00 00 00
[  584.886000] sdb: assuming drive cache: write through
[  584.888000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[  584.888000] sdb: Write Protect is off
[  584.888000] sdb: Mode Sense: 00 00 00 00
[  584.888000] sdb: assuming drive cache: write through
[  584.889000]  sdb: sdb1
[  585.076000] sd 4:0:0:0: Attached scsi removable disk sdb
[  585.077000] usb-storage: device scan complete
[  599.265000] usb 5-6.2: USB disconnect, address 7
[  702.852000] ACPI: undocking
[  703.083000] usb 5-6: USB disconnect, address 4
[  703.083000] usb 5-6.1: USB disconnect, address 5
[  703.083000] usb 5-6.3: USB disconnect, address 6
[  708.397000] e1000: eth0: e1000_watchdog: NIC Link is Down
[  729.483000] Disabling non-boot CPUs ...
[  729.537000] Breaking affinity for irq 219
[  729.538000] CPU 1 is now offline
[  729.538000] SMP alternatives: switching to UP code
[  729.547000] CPU1 is down
[  729.547000] Stopping tasks: =========================================================================================================================|
[  730.081000] Suspending console(s)
[  730.081000]  usbdev4.3_ep83: PM: suspend 0->2, parent 4-2:1.0 already 2
[  730.081000]  usbdev4.3_ep02: PM: suspend 0->2, parent 4-2:1.0 already 2
[  730.081000]  usbdev4.3_ep81: PM: suspend 0->2, parent 4-2:1.0 already 2
[  730.081000] usb 4-2:1.0: PM: suspend 2->2, parent 4-2 already 2
[  730.081000]  usbdev4.3_ep00: PM: suspend 0->2, parent 4-2 already 2
[  730.094000] hdaps: setting ec_rate=0, filter_order=1
[  731.775000] pnp: Device 00:0a disabled.
[  731.776000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
[  731.798000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
[  731.846000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[  731.859000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[  731.870000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[  731.982000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[  731.982000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[  731.982000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[  731.982000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[  731.984000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[  731.995000] Intel machine check architecture supported.
[  731.995000] Intel machine check reporting enabled on CPU#0.
[  731.995000] Back to C!
[ 1633.713000] PM: Writing back config space on device 0000:00:02.1 at offset 1 (was 900000, writing 900003)
[ 1633.725000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100106, writing 100100)
[ 1633.725000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[ 1633.725000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
[ 1633.725000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.2 at offset 7 (was 20006050, writing 6050)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100107, writing 100507)
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset f (was 40400, writing 4040b)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset 9 (was 10001, writing e421e421)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset 8 (was 0, writing ebf0ea00)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset 7 (was 20000000, writing 8070)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset 3 (was 810000, writing 810010)
[ 1633.743000] PM: Writing back config space on device 0000:00:1c.3 at offset 1 (was 100000, writing 100507)
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[ 1633.743000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[ 1633.743000] usb usb1: root hub lost power or was reset
[ 1633.743000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[ 1633.743000] usb usb2: root hub lost power or was reset
[ 1633.743000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[ 1633.743000] usb usb3: root hub lost power or was reset
[ 1633.743000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
[ 1633.743000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[ 1633.743000] usb usb4: root hub lost power or was reset
[ 1634.104000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
[ 1634.104000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[ 1634.104000] PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100005, writing 100007)
[ 1634.104000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[ 1634.115000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
[ 1634.115000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[ 1635.129000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[ 1635.129000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[ 1635.172000] PM: Writing back config space on device 0000:15:00.0 at offset 1 (was 2100000, writing 2100007)
[ 1635.172000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[ 1635.214000] PM: Writing back config space on device 0000:15:00.1 at offset 4 (was 0, writing e4301000)
[ 1635.214000] PM: Writing back config space on device 0000:15:00.1 at offset 3 (was 800000, writing 804000)
[ 1635.214000] PM: Writing back config space on device 0000:15:00.1 at offset 1 (was 2100000, writing 2100006)
[ 1635.225000] PM: Writing back config space on device 0000:15:00.2 at offset 4 (was 0, writing e4301800)
[ 1635.225000] PM: Writing back config space on device 0000:15:00.2 at offset 3 (was 800000, writing 804000)
[ 1635.225000] PM: Writing back config space on device 0000:15:00.2 at offset 1 (was 2100000, writing 2100006)
[ 1635.225000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
[ 1635.400000] pnp: Device 00:08 does not support activation.
[ 1635.400000] pnp: Device 00:09 does not support activation.
[ 1635.401000] pnp: Device 00:0a activated.
[ 1635.421000] ata2: SATA link down (SStatus 0 SControl 0)
[ 1635.421000] ata3: SATA link down (SStatus 0 SControl 0)
[ 1635.421000] ata4: SATA link down (SStatus 0 SControl 0)
[ 1635.680000] hdaps: initial mode latch is 0x05
[ 1635.680000] hdaps: setting ec_rate=250, filter_order=2
[ 1635.680000] hdaps: fake_data_mode set to 0
[ 1635.821000] nsc_ircc_init_dongle_interface(), No dongle connected
[ 1635.821000] nsc_ircc_change_dongle_speed(), No dongle connected is not for IrDA mode
[ 1635.821000]  usbdev4.2_ep00: PM: resume from 0, parent 4-1 still 2
[ 1635.821000] hci_usb 4-1:1.0: PM: resume from 2, parent 4-1 still 2
[ 1635.821000]  usbdev4.2_ep81: PM: resume from 0, parent 4-1:1.0 still 2
[ 1635.821000]  usbdev4.2_ep82: PM: resume from 0, parent 4-1:1.0 still 2
[ 1635.821000]  usbdev4.2_ep02: PM: resume from 0, parent 4-1:1.0 still 2
[ 1635.821000] hci_usb 4-1:1.1: PM: resume from 2, parent 4-1 still 2
[ 1635.821000] usb 4-1:1.2: PM: resume from 2, parent 4-1 still 2
[ 1635.821000]  usbdev4.2_ep84: PM: resume from 0, parent 4-1:1.2 still 2
[ 1635.821000]  usbdev4.2_ep04: PM: resume from 0, parent 4-1:1.2 still 2
[ 1635.821000] usb 4-1:1.3: PM: resume from 2, parent 4-1 still 2
[ 1635.821000]  usbdev4.3_ep00: PM: resume from 0, parent 4-2 still 2
[ 1635.821000]  usbdev4.3_ep81: PM: resume from 0, parent 4-2:1.0 still 2
[ 1635.821000]  usbdev4.3_ep02: PM: resume from 0, parent 4-2:1.0 still 2
[ 1635.821000]  usbdev4.3_ep83: PM: resume from 0, parent 4-2:1.0 still 2
[ 1635.821000]  usbdev4.2_ep83: PM: resume from 0, parent 4-1:1.1 still 2
[ 1635.821000]  usbdev4.2_ep03: PM: resume from 0, parent 4-1:1.1 still 2
[ 1635.821000]  hci0: PM: resume from 0, parent 4-1:1.0 still 2
[ 1635.822000] Restarting tasks...<6>usb 4-1: USB disconnect, address 2
[ 1635.832000]  done
[ 1635.832000] Enabling non-boot CPUs ...
[ 1635.845000] SMP alternatives: switching to SMP code
[ 1635.846000] Booting processor 1/1 eip 3000
[ 1635.856000] Initializing CPU#1
[ 1635.917000] Calibrating delay using timer specific routine.. 3325.06 BogoMIPS (lpj=1662531)
[ 1635.917000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[ 1635.917000] monitor/mwait feature present.
[ 1635.917000] CPU: L1 I cache: 32K, L1 D cache: 32K
[ 1635.917000] CPU: L2 cache: 2048K
[ 1635.917000] CPU: Physical Processor ID: 0
[ 1635.917000] CPU: Processor Core ID: 1
[ 1635.917000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[ 1635.917000] Intel machine check architecture supported.
[ 1635.917000] Intel machine check reporting enabled on CPU#1.
[ 1635.917000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
[ 1635.996000] usb 4-2: USB disconnect, address 3
[ 1636.202000] usb 4-2: new full speed USB device using uhci_hcd and address 4
[ 1636.365000] usb 4-2: configuration #1 chosen from 1 choice
[ 1636.647000] ata1: waiting for device to spin up (7 secs)
[ 1636.817000] usb 4-1: new full speed USB device using uhci_hcd and address 5
[ 1636.977000] usb 4-1: configuration #1 chosen from 1 choice
[ 1638.293000] CPU1 is up
[ 1644.484000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 1644.488000] ata1.00: configured for UDMA/100
[ 1644.489000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[ 1644.489000] sda: Write Protect is off
[ 1644.489000] sda: Mode Sense: 00 3a 00 00
[ 1644.489000] SCSI device sda: drive cache: write back
[ 1831.582000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3: (0x11:0x00)->0x80

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="ibm_acpi.dump.2006-10-30-150116-UTC_before"

/proc/acpi/ibm/bay
status:		not supported
================================================================

/proc/acpi/ibm/beep
status:		supported
commands:	<cmd> (<cmd> is 0-17)
================================================================

/proc/acpi/ibm/bluetooth
status:		enabled
commands:	enable, disable
================================================================

/proc/acpi/ibm/brightness
level:		3
commands:	up, down
commands:	level <level> (<level> is 0-7)
================================================================

/proc/acpi/ibm/cmos
status:		supported
commands:	<cmd> (<cmd> is 0-21)
================================================================

/proc/acpi/ibm/driver
driver:		IBM ThinkPad ACPI Extras
version:	0.12a
================================================================

/proc/acpi/ibm/ecdump
EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
EC 0x00: *a6 *05 *a0 *01 *fe *96  00  00 *1f *02 *47  00  00  00 *80  00
EC 0x10:  00  00 *ff *ff *f4 *3c *87 *09 *43 *ff *82 *01 *ff *ff *2d  00
EC 0x20:  00  00  00  00  00  00  00  00  00  00  00  00 *85  00  00 *80
EC 0x30: *4a *03 *12  00 *30 *04  00  00 *c5  00 *b0 *10  00 *50  00  00
EC 0x40:  00  00  00  00  00  00 *84 *01 *0a  00  00  00  00  00  00  00
EC 0x50:  00 *c0 *02 *23 *41  00 *33 *2d *03 *2f *2d *06 *21 *23 *30  00
EC 0x60: *80  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0x70:  00  00  00  00  00 *12 *30 *40 *2e *2a *80 *2d *21 *80 *1f *80
EC 0x80:  00  00  00 *06  00  00 *03  00  00  00 *0e *78  00  00  00  00
EC 0x90:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xa0: *11 *0a *74 *0a *62  00 *61  00 *34 *fc *3b *3f *ff *ff *e0  00
EC 0xb0:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xc0: *2b *29 *80 *80 *80 *80 *80 *80  00  00  00  00  00  00 *10  00
EC 0xd0: *06  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xe0:  00  00  00  00  00  00  00  00 *10 *80 *a6 *04 *24 *2e *55 *03
EC 0xf0: *37 *42 *48 *54 *33 *35 *57 *57 *0c *f5 *60 *7c *0c *e7 *63 *93
================================================================

/proc/acpi/ibm/fan
status:		enabled
speed:		0
commands:	enable, disable
================================================================

/proc/acpi/ibm/hotkey
status:		enabled
mask:		0xff9f
commands:	enable, disable, reset, <mask>
================================================================

/proc/acpi/ibm/led
status:		supported
commands:	<led> on, <led> off, <led> blink (<led> is 0-7)
================================================================

/proc/acpi/ibm/light
status:		off
commands:	on, off
================================================================

/proc/acpi/ibm/thermal
temperatures:	46 42 -128 45 33 -128 31 -128
================================================================

/proc/acpi/ibm/video
status:		supported
lcd:		enabled
crt:		enabled
dvi:		disabled
auto:		enabled
commands:	lcd_enable, lcd_disable
commands:	crt_enable, crt_disable
commands:	dvi_enable, dvi_disable
commands:	auto_enable, auto_disable
commands:	video_switch, expand_toggle
================================================================

/proc/acpi/ibm/volume
level:		10
mute:		on
commands:	up, down, mute
commands:	level <level> (<level> is 0-15)
================================================================

/proc/acpi/ibm/wan
status:		not installed
================================================================


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="ibm_acpi.dump.2006-10-30-151632-UTC_after1"

/proc/acpi/ibm/bay
status:		not supported
================================================================

/proc/acpi/ibm/beep
status:		supported
commands:	<cmd> (<cmd> is 0-17)
================================================================

/proc/acpi/ibm/bluetooth
status:		enabled
commands:	enable, disable
================================================================

/proc/acpi/ibm/brightness
level:		3
commands:	up, down
commands:	level <level> (<level> is 0-7)
================================================================

/proc/acpi/ibm/cmos
status:		supported
commands:	<cmd> (<cmd> is 0-21)
================================================================

/proc/acpi/ibm/driver
driver:		IBM ThinkPad ACPI Extras
version:	0.12a
================================================================

/proc/acpi/ibm/ecdump
EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
EC 0x00: *a7  05  a0  01  fe  96  00  00  1f  02  47  00  00  00  80  00
EC 0x10:  00  00  ff  ff  f4  3c  87  09  43  ff  82  01  ff  ff  2d  00
EC 0x20:  00  00  00  00  00  00  00  00  00  00  00  00  85  00  00  80
EC 0x30:  4a  03 *02  00  30  04 *04  00  c5  00 *30  10 *2a  50  00  00
EC 0x40:  00  00  00  00  00  00  84  01  0a  00  00  00  00  00 *04  00
EC 0x50:  00  c0  02  23  41  00  33  2d  03  2f  2d  06  21  23  30  00
EC 0x60:  80  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0x70:  00  00  00  00  00  12  30  40 *24 *1e  80 *20 *1c  80 *1c  80
EC 0x80:  00  00  00  06  00  00  03  00  00  00  0e  78  00  00  00  00
EC 0x90:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xa0: *ef *09  74  0a *6e  00 *5f  00 *9e  fc *f0 *3e  ff  ff *c0  00
EC 0xb0:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xc0: *1d *1e  80  80  80  80  80  80  00  00  00  00  00  00  10  00
EC 0xd0:  06  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xe0:  00  00  00  00  00  00  00  00  10  80  a6  04  24  2e  55  03
EC 0xf0:  37  42  48  54  33  35  57  57  0c  f5  60  7c  0c  e7  63  93
================================================================

/proc/acpi/ibm/fan
status:		enabled
speed:		0
commands:	enable, disable
================================================================

/proc/acpi/ibm/hotkey
status:		enabled
mask:		0xff9f
commands:	enable, disable, reset, <mask>
================================================================

/proc/acpi/ibm/led
status:		supported
commands:	<led> on, <led> off, <led> blink (<led> is 0-7)
================================================================

/proc/acpi/ibm/light
status:		off
commands:	on, off
================================================================

/proc/acpi/ibm/thermal
temperatures:	41 31 -128 37 29 -128 28 -128
================================================================

/proc/acpi/ibm/video
status:		supported
lcd:		enabled
crt:		enabled
dvi:		disabled
auto:		enabled
commands:	lcd_enable, lcd_disable
commands:	crt_enable, crt_disable
commands:	dvi_enable, dvi_disable
commands:	auto_enable, auto_disable
commands:	video_switch, expand_toggle
================================================================

/proc/acpi/ibm/volume
level:		10
mute:		on
commands:	up, down, mute
commands:	level <level> (<level> is 0-15)
================================================================

/proc/acpi/ibm/wan
status:		not installed
================================================================


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="ibm_acpi.dump.2006-10-30-151747-UTC_after2"

/proc/acpi/ibm/bay
status:		not supported
================================================================

/proc/acpi/ibm/beep
status:		supported
commands:	<cmd> (<cmd> is 0-17)
================================================================

/proc/acpi/ibm/bluetooth
status:		enabled
commands:	enable, disable
================================================================

/proc/acpi/ibm/brightness
level:		3
commands:	up, down
commands:	level <level> (<level> is 0-7)
================================================================

/proc/acpi/ibm/cmos
status:		supported
commands:	<cmd> (<cmd> is 0-21)
================================================================

/proc/acpi/ibm/driver
driver:		IBM ThinkPad ACPI Extras
version:	0.12a
================================================================

/proc/acpi/ibm/ecdump
EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
EC 0x00:  a7  05  a0  01  fe  96  00  00  1f  02  47  00  00  00  80  00
EC 0x10:  00  00  ff  ff  f4  3c  87  09  43  ff  82  01  ff  ff  2d  00
EC 0x20:  00  00  00  00  00  00  00  00  00  00  00  00  85  00  00  80
EC 0x30:  4a  03  02  00  30  04  00  00  c5  00  30  10  2a  50  00  00
EC 0x40:  00  00  00  00  00  00  84  01  0a  00  00  00  00  00  00  00
EC 0x50:  00  c0  02  23  41  00  33  2d  03  2f  2d  06  21  23  30  00
EC 0x60:  80  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0x70:  00  00  00  00  00  12  30  40 *2b *1f  80 *26  1d  80  1c  80
EC 0x80:  00  00  00  06  00  00  03  00  00  00  0e  78  00  00  00  00
EC 0x90:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xa0: *c7  09  74  0a *4d  00 *5e  00 *28  fc *87  3e  ff  ff  c0  00
EC 0xb0:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xc0: *20 *21  80  80  80  80  80  80  00  00  00  00  00  00  10  00
EC 0xd0:  06  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xe0:  00  00  00  00  00  00  00  00  10  80  a6  04  24  2e  55  03
EC 0xf0:  37  42  48  54  33  35  57  57  0c  f5  60  7c  0c  e7  63  93
================================================================

/proc/acpi/ibm/fan
status:		enabled
speed:		0
commands:	enable, disable
================================================================

/proc/acpi/ibm/hotkey
status:		disabled
mask:		0x080c
commands:	enable, disable, reset, <mask>
================================================================

/proc/acpi/ibm/led
status:		supported
commands:	<led> on, <led> off, <led> blink (<led> is 0-7)
================================================================

/proc/acpi/ibm/light
status:		off
commands:	on, off
================================================================

/proc/acpi/ibm/thermal
temperatures:	45 32 -128 40 29 -128 28 -128
================================================================

/proc/acpi/ibm/video
status:		supported
lcd:		enabled
crt:		enabled
dvi:		disabled
auto:		enabled
commands:	lcd_enable, lcd_disable
commands:	crt_enable, crt_disable
commands:	dvi_enable, dvi_disable
commands:	auto_enable, auto_disable
commands:	video_switch, expand_toggle
================================================================

/proc/acpi/ibm/volume
level:		10
mute:		on
commands:	up, down, mute
commands:	level <level> (<level> is 0-15)
================================================================

/proc/acpi/ibm/wan
status:		not installed
================================================================


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--tThc/1wpZn/ma/RB--
