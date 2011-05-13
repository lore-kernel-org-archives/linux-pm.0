From: Dwight Schauer <dschauer@gmail.com>
Subject: Re: xHCI and suspend/resume
Date: Fri, 13 May 2011 14:21:29 -0500
Message-ID: <BANLkTinSgyFRsY+7dca1HfVmF-tV8cHb-g__31830.4250984967$1305564307$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105122358.01514.rjw@sisk.pl> <201105130029.33667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105130029.33667.rjw@sisk.pl>
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
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
>> On Thursday, May 12, 2011, Alan Stern wrote:
>> > For new readers: The problem is that an xHCI USB host controller does
>> > not wake up a suspended system properly.
>> >
>> > On Thu, 12 May 2011, Dwight Schauer wrote:
>> >
>> > > Thanks Alan.
>> > >
>> > > OK, this is with 2.6.39-rc7-gregkh
>> > >
>> > > 05:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
>> > > Controller (rev 03) (prog-if 30 [XHCI])
>> > > =A0 =A0 =A0 =A0 Subsystem: Melco Inc Device 0241
>> > > =A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VG=
ASnoop-
>> > > ParErr- Stepping- SERR+ FastB2B- DisINTx+
>> > > =A0 =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Df=
ast >TAbort-
>> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> > > =A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 17
>> > > =A0 =A0 =A0 =A0 Region 0: Memory at fe9fe000 (64-bit, non-prefetchab=
le) [size=3D8K]
>> > > =A0 =A0 =A0 =A0 Capabilities: [50] Power Management version 3
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1- D2- AuxCurre=
nt=3D0mA
>> > > PME(D0+,D1-,D2-,D3hot+,D3cold-)
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D3 NoSoftRst+ PME-Enable+ DS=
el=3D0 DScale=3D0 PME+
>> >
>> > That's the important part for power management and wakeup. =A0The
>> > controller does support PCI wakeup. =A0In fact, at the time you ran ls=
pci
>> > the controller _was_ suspended and it was signalling a wakeup request!
>> > Obviously something is wrong somewhere...
>> >
>> > > @@@ With "on" in power/control I get this upon plugging in a keyboar=
d:
>> > ...
>> > > @@@ and upon removing it:
>> >
>> > All normal.
>> >
>> > > @@@ If I put "auto" in power/control I get this:
>> > >
>> > > xhci_hcd 0000:05:00.0: hcd_pci_runtime_suspend: 0
>> > > xhci_hcd 0000:05:00.0: PME# enabled
>> >
>> > This means the controller was suspended with wakeup enabled, as it
>> > should be.
>> >
>> > > @@@ Upon plugging in a keyboard nothing.
>> >
>> > Indeed, that is a problem. =A0Since wakeup doesn't work right at runti=
me,
>> > it's not surprising that it also fails during system sleep.
>> >
....
>> >
>> > Clearly something is wrong. =A0But it looks like the problem might be
>> > somewhere else, not in the xHCI driver. =A0Is your BIOS up to date?
>> >
>> > CC-ing the linux-pm mailing list in case anybody there has some ideas.
>>
>> I need a boot log from 2.6.39-rc6 (or current Linus') on the affected sy=
stem.
>
> That should have been -rc7, sorry.
>
> Thanks,
> Rafael

Rafael,

I updated the BIOS, but the results are the same.

description: Motherboard
       product: M4A89GTD-PRO/USB3
       vendor: ASUSTeK Computer INC.
       physical id: 0
       version: Rev 1.xx
       serial: 108760400001508

description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 2101
          date: 04/08/2011

I put 2.6.39-rc7 (no patches) on my system and used it for the following.

@@@ boot up log

May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys cpuset
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys cpu
May 13 13:51:39 daslab-c kernel: Linux version 2.6.39-rc7-mainline
(root@daslab-c) (gcc version 4.3.4 (GCC) ) #1 SMP PREEMPT Fri May 13
10:21:35 CDT 2011
May 13 13:51:39 daslab-c kernel: Command line:
initrd=3D/kernel26-mainline.img
root=3D/dev/disk/by-uuid/1353ed1e-5cb8-11e0-b0b0-bcaec5631586
resume=3D/dev/disk/by-uuid/135368bc-5cb8-11e0-8e1e-bcaec5631586 ro quiet
vga=3D0x31A BOOT_IMAGE=3D/vmlinuz26-mainline
May 13 13:51:39 daslab-c kernel: BIOS-provided physical RAM map:
May 13 13:51:39 daslab-c kernel: BIOS-e820: 0000000000000000 -
0000000000099800 (usable)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 0000000000099800 -
00000000000a0000 (reserved)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 00000000000e4000 -
0000000000100000 (reserved)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 0000000000100000 -
00000000cfe90000 (usable)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 00000000cfe90000 -
00000000cfea8000 (ACPI data)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 00000000cfea8000 -
00000000cfed0000 (ACPI NVS)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 00000000cfed0000 -
00000000cff00000 (reserved)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 00000000ffe00000 -
0000000100000000 (reserved)
May 13 13:51:39 daslab-c kernel: BIOS-e820: 0000000100000000 -
0000000120000000 (usable)
May 13 13:51:39 daslab-c kernel: NX (Execute Disable) protection: active
May 13 13:51:39 daslab-c kernel: DMI present.
May 13 13:51:39 daslab-c kernel: DMI: System manufacturer System
Product Name/M4A89GTD-PRO/USB3, BIOS 2101    04/08/2011
May 13 13:51:39 daslab-c kernel: e820 update range: 0000000000000000 -
0000000000010000 (usable) =3D=3D> (reserved)
May 13 13:51:39 daslab-c kernel: e820 remove range: 00000000000a0000 -
0000000000100000 (usable)
May 13 13:51:39 daslab-c kernel: No AGP bridge found
May 13 13:51:39 daslab-c kernel: last_pfn =3D 0x120000 max_arch_pfn =3D 0x4=
00000000
May 13 13:51:39 daslab-c kernel: MTRR default type: uncachable
May 13 13:51:39 daslab-c kernel: MTRR fixed ranges enabled:
May 13 13:51:39 daslab-c kernel: 00000-9FFFF write-back
May 13 13:51:39 daslab-c kernel: A0000-EFFFF uncachable
May 13 13:51:39 daslab-c kernel: F0000-FFFFF write-protect
May 13 13:51:39 daslab-c kernel: MTRR variable ranges enabled:
May 13 13:51:39 daslab-c kernel: 0 base 000000000000 mask FFFF80000000
write-back
May 13 13:51:39 daslab-c kernel: 1 base 000080000000 mask FFFFC0000000
write-back
May 13 13:51:39 daslab-c kernel: 2 base 0000C0000000 mask FFFFF0000000
write-back
May 13 13:51:39 daslab-c kernel: 3 disabled
May 13 13:51:39 daslab-c kernel: 4 disabled
May 13 13:51:39 daslab-c kernel: 5 disabled
May 13 13:51:39 daslab-c kernel: 6 disabled
May 13 13:51:39 daslab-c kernel: 7 disabled
May 13 13:51:39 daslab-c kernel: TOM2: 0000000130000000 aka 4864M
May 13 13:51:39 daslab-c kernel: x86 PAT enabled: cpu 0, old
0x7040600070406, new 0x7010600070106
May 13 13:51:39 daslab-c kernel: e820 update range: 00000000d0000000 -
0000000100000000 (usable) =3D=3D> (reserved)
May 13 13:51:39 daslab-c kernel: last_pfn =3D 0xcfe90 max_arch_pfn =3D 0x40=
0000000
May 13 13:51:39 daslab-c kernel: found SMP MP-table at [ffff8800000ff780] f=
f780
May 13 13:51:39 daslab-c kernel: initial memory mapped : 0 - 20000000
May 13 13:51:39 daslab-c kernel: Base memory trampoline at
[ffff880000094000] 94000 size 20480
May 13 13:51:39 daslab-c kernel: Using GB pages for direct mapping
May 13 13:51:39 daslab-c kernel: init_memory_mapping:
0000000000000000-00000000cfe90000
May 13 13:51:39 daslab-c kernel: 0000000000 - 00c0000000 page 1G
May 13 13:51:39 daslab-c kernel: 00c0000000 - 00cfe00000 page 2M
May 13 13:51:39 daslab-c kernel: 00cfe00000 - 00cfe90000 page 4k
May 13 13:51:39 daslab-c kernel: kernel direct mapping tables up to
cfe90000 @ cfe8d000-cfe90000
May 13 13:51:39 daslab-c kernel: init_memory_mapping:
0000000100000000-0000000120000000
May 13 13:51:39 daslab-c kernel: 0100000000 - 0120000000 page 2M
May 13 13:51:39 daslab-c kernel: kernel direct mapping tables up to
120000000 @ 11fffe000-120000000
May 13 13:51:39 daslab-c kernel: RAMDISK: 7fe1d000 - 7ffff000
May 13 13:51:39 daslab-c kernel: ACPI: RSDP 00000000000fba90 00024 (v02 ACP=
IAM)
May 13 13:51:39 daslab-c kernel: ACPI: XSDT 00000000cfe90100 0005C
(v01 040811 XSDT1330 20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: FACP 00000000cfe90290 000F4
(v03 040811 FACP1330 20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: DSDT 00000000cfe90450 0E793
(v01  A1608 A1608000 00000000 INTL 20060113)
May 13 13:51:39 daslab-c kernel: ACPI: FACS 00000000cfea8000 00040
May 13 13:51:39 daslab-c kernel: ACPI: APIC 00000000cfe90390 0007C
(v01 040811 APIC1330 20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: MCFG 00000000cfe90410 0003C
(v01 040811 OEMMCFG  20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: OEMB 00000000cfea8040 00072
(v01 040811 OEMB1330 20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: SRAT 00000000cfe9f8a0 000E8
(v01 AMD    FAM_F_10 00000002 AMD  00000001)
May 13 13:51:39 daslab-c kernel: ACPI: HPET 00000000cfe9f990 00038
(v01 040811 OEMHPET  20110408 MSFT 00000097)
May 13 13:51:39 daslab-c kernel: ACPI: SSDT 00000000cfe9f9d0 0088C
(v01 A M I  POWERNOW 00000001 AMD  00000001)
May 13 13:51:39 daslab-c kernel: ACPI: Local APIC address 0xfee00000
May 13 13:51:39 daslab-c kernel: SRAT: PXM 0 -> APIC 0x00 -> Node 0
May 13 13:51:39 daslab-c kernel: SRAT: PXM 0 -> APIC 0x01 -> Node 0
May 13 13:51:39 daslab-c kernel: SRAT: PXM 0 -> APIC 0x02 -> Node 0
May 13 13:51:39 daslab-c kernel: SRAT: PXM 0 -> APIC 0x03 -> Node 0
May 13 13:51:39 daslab-c kernel: SRAT: Node 0 PXM 0 0-a0000
May 13 13:51:39 daslab-c kernel: SRAT: Node 0 PXM 0 100000-d0000000
May 13 13:51:39 daslab-c kernel: SRAT: Node 0 PXM 0 100000000-130000000
May 13 13:51:39 daslab-c kernel: NUMA: Node 0 [0,a0000) +
[100000,d0000000) -> [0,d0000000)
May 13 13:51:39 daslab-c kernel: NUMA: Node 0 [0,d0000000) +
[100000000,130000000) -> [0,120000000)
May 13 13:51:39 daslab-c kernel: NUMA: Using 63 for the hash shift.
May 13 13:51:39 daslab-c kernel: Initmem setup node 0
0000000000000000-0000000120000000
May 13 13:51:39 daslab-c kernel: NODE_DATA [000000011fff9000 - 000000011fff=
dfff]
May 13 13:51:39 daslab-c kernel: [ffffea0000000000-ffffea0003ffffff]
PMD -> [ffff88011ba00000-ffff88011effffff] on node 0
May 13 13:51:39 daslab-c kernel: Zone PFN ranges:
May 13 13:51:39 daslab-c kernel: DMA      0x00000010 -> 0x00001000
May 13 13:51:39 daslab-c kernel: DMA32    0x00001000 -> 0x00100000
May 13 13:51:39 daslab-c kernel: Normal   0x00100000 -> 0x00120000
May 13 13:51:39 daslab-c kernel: Movable zone start PFN for each node
May 13 13:51:39 daslab-c kernel: early_node_map[3] active PFN ranges
May 13 13:51:39 daslab-c kernel: 0: 0x00000010 -> 0x00000099
May 13 13:51:39 daslab-c kernel: 0: 0x00000100 -> 0x000cfe90
May 13 13:51:39 daslab-c kernel: 0: 0x00100000 -> 0x00120000
May 13 13:51:39 daslab-c kernel: On node 0 totalpages: 982553
May 13 13:51:39 daslab-c kernel: DMA zone: 56 pages used for memmap
May 13 13:51:39 daslab-c kernel: DMA zone: 5 pages reserved
May 13 13:51:39 daslab-c kernel: DMA zone: 3916 pages, LIFO batch:0
May 13 13:51:39 daslab-c kernel: DMA32 zone: 14280 pages used for memmap
May 13 13:51:39 daslab-c kernel: DMA32 zone: 833224 pages, LIFO batch:31
May 13 13:51:39 daslab-c kernel: Normal zone: 1792 pages used for memmap
May 13 13:51:39 daslab-c kernel: Normal zone: 129280 pages, LIFO batch:31
May 13 13:51:39 daslab-c kernel: ACPI: PM-Timer IO Port: 0x808
May 13 13:51:39 daslab-c kernel: ACPI: Local APIC address 0xfee00000
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x01]
lapic_id[0x00] enabled)
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x02]
lapic_id[0x01] enabled)
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x03]
lapic_id[0x02] enabled)
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x04]
lapic_id[0x03] enabled)
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x05]
lapic_id[0x84] disabled)
May 13 13:51:39 daslab-c kernel: ACPI: LAPIC (acpi_id[0x06]
lapic_id[0x85] disabled)
May 13 13:51:39 daslab-c kernel: ACPI: IOAPIC (id[0x04]
address[0xfec00000] gsi_base[0])
May 13 13:51:39 daslab-c kernel: IOAPIC[0]: apic_id 4, version 33,
address 0xfec00000, GSI 0-23
May 13 13:51:39 daslab-c kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
May 13 13:51:39 daslab-c kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
May 13 13:51:39 daslab-c kernel: ACPI: IRQ0 used by override.
May 13 13:51:39 daslab-c kernel: ACPI: IRQ2 used by override.
May 13 13:51:39 daslab-c kernel: ACPI: IRQ9 used by override.
May 13 13:51:39 daslab-c kernel: Using ACPI (MADT) for SMP
configuration information
May 13 13:51:39 daslab-c kernel: ACPI: HPET id: 0x8300 base: 0xfed00000
May 13 13:51:39 daslab-c kernel: SMP: Allowing 6 CPUs, 2 hotplug CPUs
May 13 13:51:39 daslab-c kernel: nr_irqs_gsi: 40
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
0000000000099000 - 000000000009a000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
000000000009a000 - 00000000000a0000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000000a0000 - 00000000000e4000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000000e4000 - 0000000000100000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000cfe90000 - 00000000cfea8000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000cfea8000 - 00000000cfed0000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000cfed0000 - 00000000cff00000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000cff00000 - 00000000ffe00000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000ffe00000 - 0000000100000000
May 13 13:51:39 daslab-c kernel: Allocating PCI resources starting at
cff00000 (gap: cff00000:2ff00000)
May 13 13:51:39 daslab-c kernel: Booting paravirtualized kernel on bare har=
dware
May 13 13:51:39 daslab-c kernel: setup_percpu: NR_CPUS:64
nr_cpumask_bits:64 nr_cpu_ids:6 nr_node_ids:1
May 13 13:51:39 daslab-c kernel: PERCPU: Embedded 28 pages/cpu
@ffff88011fc00000 s83008 r8192 d23488 u262144
May 13 13:51:39 daslab-c kernel: pcpu-alloc: s83008 r8192 d23488
u262144 alloc=3D1*2097152
May 13 13:51:39 daslab-c kernel: pcpu-alloc: [0] 0 1 2 3 4 5 - -
May 13 13:51:39 daslab-c kernel: Built 1 zonelists in Node order,
mobility grouping on.  Total pages: 966420
May 13 13:51:39 daslab-c kernel: Policy zone: Normal
May 13 13:51:39 daslab-c kernel: Kernel command line:
initrd=3D/kernel26-mainline.img
root=3D/dev/disk/by-uuid/1353ed1e-5cb8-11e0-b0b0-bcaec5631586
resume=3D/dev/disk/by-uuid/135368bc-5cb8-11e0-8e1e-bcaec5631586 ro quiet
vga=3D0x31A BOOT_IMAGE=3D/vmlinuz26-mainline
May 13 13:51:39 daslab-c kernel: PID hash table entries: 4096 (order:
3, 32768 bytes)
May 13 13:51:39 daslab-c kernel: Checking aperture...
May 13 13:51:39 daslab-c kernel: No AGP bridge found
May 13 13:51:39 daslab-c kernel: Node 0: aperture @ c0000000 size 32 MB
May 13 13:51:39 daslab-c kernel: Aperture pointing to e820 RAM. Ignoring.
May 13 13:51:39 daslab-c kernel: Your BIOS doesn't leave a aperture memory =
hole
May 13 13:51:39 daslab-c kernel: Please enable the IOMMU option in the
BIOS setup
May 13 13:51:39 daslab-c kernel: This costs you 64 MB of RAM
May 13 13:51:39 daslab-c kernel: Mapping aperture over 65536 KB of RAM
@ c0000000
May 13 13:51:39 daslab-c kernel: PM: Registered nosave memory:
00000000c0000000 - 00000000c4000000
May 13 13:51:39 daslab-c kernel: Memory: 3732304k/4718592k available
(3906k kernel code, 788380k absent, 197908k reserved, 2294k data, 608k
init)
May 13 13:51:39 daslab-c kernel: SLUB: Genslabs=3D15, HWalign=3D64,
Order=3D0-3, MinObjects=3D0, CPUs=3D6, Nodes=3D1
May 13 13:51:39 daslab-c kernel: Preemptable hierarchical RCU implementatio=
n.
May 13 13:51:39 daslab-c kernel: 	RCU-based detection of stalled CPUs
is disabled.
May 13 13:51:39 daslab-c kernel: 	Verbose stalled-CPUs detection is disable=
d.
May 13 13:51:39 daslab-c kernel: NR_IRQS:2304
May 13 13:51:39 daslab-c kernel: Extended CMOS year: 2000
May 13 13:51:39 daslab-c kernel: Console: colour dummy device 80x25
May 13 13:51:39 daslab-c kernel: console [tty0] enabled
May 13 13:51:39 daslab-c kernel: allocated 31457280 bytes of page_cgroup
May 13 13:51:39 daslab-c kernel: please try 'cgroup_disable=3Dmemory'
option if you don't want memory cgroups
May 13 13:51:39 daslab-c kernel: hpet clockevent registered
May 13 13:51:39 daslab-c kernel: Fast TSC calibration using PIT
May 13 13:51:39 daslab-c kernel: Detected 3612.737 MHz processor.
May 13 13:51:39 daslab-c kernel: Calibrating delay loop (skipped),
value calculated using timer frequency.. 7228.53 BogoMIPS
(lpj=3D12042456)
May 13 13:51:39 daslab-c kernel: pid_max: default: 32768 minimum: 301
May 13 13:51:39 daslab-c kernel: Security Framework initialized
May 13 13:51:39 daslab-c kernel: AppArmor: AppArmor disabled by boot
time parameter
May 13 13:51:39 daslab-c kernel: Dentry cache hash table entries:
524288 (order: 10, 4194304 bytes)
May 13 13:51:39 daslab-c kernel: Inode-cache hash table entries:
262144 (order: 9, 2097152 bytes)
May 13 13:51:39 daslab-c kernel: Mount-cache hash table entries: 256
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys ns
May 13 13:51:39 daslab-c kernel: ns_cgroup deprecated: consider using
the 'clone_children' flag without the ns_cgroup.
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys cpuacct
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys memory
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys devices
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys freezer
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys net_cls
May 13 13:51:39 daslab-c kernel: Initializing cgroup subsys blkio
May 13 13:51:39 daslab-c kernel: tseg: 0000000000
May 13 13:51:39 daslab-c kernel: CPU: Physical Processor ID: 0
May 13 13:51:39 daslab-c kernel: CPU: Processor Core ID: 0
May 13 13:51:39 daslab-c kernel: mce: CPU supports 6 MCE banks
May 13 13:51:39 daslab-c kernel: using C1E aware idle routine
May 13 13:51:39 daslab-c kernel: ACPI: Core revision 20110316
May 13 13:51:39 daslab-c kernel: Setting APIC routing to flat
May 13 13:51:39 daslab-c kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2
apic2=3D-1 pin2=3D-1
May 13 13:51:39 daslab-c kernel: CPU0: AMD Phenom(tm) II X4 975
Processor stepping 03
May 13 13:51:39 daslab-c kernel: Performance Events: AMD PMU driver.
May 13 13:51:39 daslab-c kernel: ... version:                0
May 13 13:51:39 daslab-c kernel: ... bit width:              48
May 13 13:51:39 daslab-c kernel: ... generic registers:      4
May 13 13:51:39 daslab-c kernel: ... value mask:             0000ffffffffff=
ff
May 13 13:51:39 daslab-c kernel: ... max period:             00007fffffffff=
ff
May 13 13:51:39 daslab-c kernel: ... fixed-purpose events:   0
May 13 13:51:39 daslab-c kernel: ... event mask:             00000000000000=
0f
May 13 13:51:39 daslab-c kernel: System has AMD C1E enabled
May 13 13:51:39 daslab-c kernel: Switch to broadcast mode on CPU0
May 13 13:51:39 daslab-c kernel: NMI watchdog enabled, takes one hw-pmu cou=
nter.
May 13 13:51:39 daslab-c kernel: Booting Node   0, Processors  #1
May 13 13:51:39 daslab-c kernel: smpboot cpu 1: start_ip =3D 94000
May 13 13:51:39 daslab-c kernel: Switch to broadcast mode on CPU1
May 13 13:51:39 daslab-c kernel: NMI watchdog enabled, takes one hw-pmu cou=
nter.
May 13 13:51:39 daslab-c kernel: #2
May 13 13:51:39 daslab-c kernel: smpboot cpu 2: start_ip =3D 94000
May 13 13:51:39 daslab-c kernel: NMI watchdog enabled, takes one hw-pmu cou=
nter.
May 13 13:51:39 daslab-c kernel: Switch to broadcast mode on CPU2
May 13 13:51:39 daslab-c kernel: #3
May 13 13:51:39 daslab-c kernel: smpboot cpu 3: start_ip =3D 94000
May 13 13:51:39 daslab-c kernel: NMI watchdog enabled, takes one hw-pmu cou=
nter.
May 13 13:51:39 daslab-c kernel: Switch to broadcast mode on CPU3
May 13 13:51:39 daslab-c kernel: Brought up 4 CPUs
May 13 13:51:39 daslab-c kernel: Total of 4 processors activated
(28913.09 BogoMIPS).
May 13 13:51:39 daslab-c kernel: devtmpfs: initialized
May 13 13:51:39 daslab-c kernel: PM: Registering ACPI NVS region at
cfea8000 (163840 bytes)
May 13 13:51:39 daslab-c kernel: NET: Registered protocol family 16
May 13 13:51:39 daslab-c kernel: node 0 link 0: io port [1000, ffffff]
May 13 13:51:39 daslab-c kernel: TOM: 00000000d0000000 aka 3328M
May 13 13:51:39 daslab-c kernel: Fam 10h mmconf [e0000000, efffffff]
May 13 13:51:39 daslab-c kernel: node 0 link 0: mmio [a0000, bffff]
May 13 13:51:39 daslab-c kernel: node 0 link 0: mmio [d0000000,
efffffff] =3D=3D> [d0000000, dfffffff]
May 13 13:51:39 daslab-c kernel: node 0 link 0: mmio [f0000000, fe4fffff]
May 13 13:51:39 daslab-c kernel: node 0 link 0: mmio [fe500000, fe6fffff]
May 13 13:51:39 daslab-c kernel: node 0 link 0: mmio [fe700000, ffdfffff]
May 13 13:51:39 daslab-c kernel: TOM2: 0000000130000000 aka 4864M
May 13 13:51:39 daslab-c kernel: bus: [00, 07] on node 0 link 0
May 13 13:51:39 daslab-c kernel: bus: 00 index 0 [io  0x0000-0xffff]
May 13 13:51:39 daslab-c kernel: bus: 00 index 1 [mem 0x000a0000-0x000bffff]
May 13 13:51:39 daslab-c kernel: bus: 00 index 2 [mem 0xd0000000-0xdfffffff]
May 13 13:51:39 daslab-c kernel: bus: 00 index 3 [mem 0xf0000000-0xffffffff]
May 13 13:51:39 daslab-c kernel: bus: 00 index 4 [mem 0x130000000-0xfcfffff=
fff]
May 13 13:51:39 daslab-c kernel: Extended Config Space enabled on 1 nodes
May 13 13:51:39 daslab-c kernel: ACPI: bus type pci registered
May 13 13:51:39 daslab-c kernel: PCI: MMCONFIG for domain 0000 [bus
00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
May 13 13:51:39 daslab-c kernel: PCI: not using MMCONFIG
May 13 13:51:39 daslab-c kernel: PCI: Using configuration type 1 for base a=
ccess
May 13 13:51:39 daslab-c kernel: PCI: Using configuration type 1 for
extended access
May 13 13:51:39 daslab-c kernel: bio: create slab <bio-0> at 0
May 13 13:51:39 daslab-c kernel: ACPI: EC: Look up EC in DSDT
May 13 13:51:39 daslab-c kernel: ACPI: Executed 3 blocks of
module-level executable AML code
May 13 13:51:39 daslab-c kernel: ACPI: Interpreter enabled
May 13 13:51:39 daslab-c kernel: ACPI: (supports S0 S1 S3 S4 S5)
May 13 13:51:39 daslab-c kernel: ACPI: Using IOAPIC for interrupt routing
May 13 13:51:39 daslab-c kernel: PCI: MMCONFIG for domain 0000 [bus
00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
May 13 13:51:39 daslab-c kernel: PCI: MMCONFIG at [mem
0xe0000000-0xefffffff] reserved in ACPI motherboard resources
May 13 13:51:39 daslab-c kernel: ACPI: EC: GPE =3D 0xa, I/O:
command/status =3D 0x66, data =3D 0x62
May 13 13:51:39 daslab-c kernel: ACPI: No dock devices found.
May 13 13:51:39 daslab-c kernel: HEST: Table not found.
May 13 13:51:39 daslab-c kernel: PCI: Using host bridge windows from
ACPI; if necessary, use "pci=3Dnocrs" and report a bug
May 13 13:51:39 daslab-c kernel: ACPI: PCI Root Bridge [PCI0] (domain
0000 [bus 00-ff])
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [io  0x0000-0x0cf7]
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [io  0x0d00-0xffff]
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [mem 0x000a0000-0x000bffff]
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [mem 0x000d0000-0x000dffff]
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [mem 0xcff00000-0xdfffffff]
May 13 13:51:39 daslab-c kernel: pci_root PNP0A03:00: host bridge
window [mem 0xf0000000-0xfebfffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:00.0: [1022:9601] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0: [1022:9602] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: [1022:9608] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: PME# supported from
D0 D3hot D3cold
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: [1022:9609] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: PME# supported from
D0 D3hot D3cold
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: [1002:4391] type 0
class 0x000106
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 10: [io  0xb000-0xb0=
07]
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 14: [io  0xa000-0xa0=
03]
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 18: [io  0x9000-0x90=
07]
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 1c: [io  0x8000-0x80=
03]
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 20: [io  0x7000-0x70=
0f]
May 13 13:51:39 daslab-c kernel: pci 0000:00:11.0: reg 24: [mem
0xfe4ffc00-0xfe4fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.0: [1002:4397] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.0: reg 10: [mem
0xfe4fe000-0xfe4fefff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.2: [1002:4396] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.2: reg 10: [mem
0xfe4ff800-0xfe4ff8ff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.2: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.2: PME# supported from
D0 D1 D2 D3hot
May 13 13:51:39 daslab-c kernel: pci 0000:00:12.2: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.0: [1002:4397] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.0: reg 10: [mem
0xfe4fd000-0xfe4fdfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.2: [1002:4396] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.2: reg 10: [mem
0xfe4ff400-0xfe4ff4ff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.2: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.2: PME# supported from
D0 D1 D2 D3hot
May 13 13:51:39 daslab-c kernel: pci 0000:00:13.2: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.0: [1002:4385] type 0
class 0x000c05
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.2: [1002:4383] type 0
class 0x000403
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.2: reg 10: [mem
0xfe4f4000-0xfe4f7fff 64bit]
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.2: PME# supported from
D0 D3hot D3cold
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.2: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.3: [1002:439d] type 0
class 0x000601
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4: [1002:4384] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.5: [1002:4399] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.5: reg 10: [mem
0xfe4fc000-0xfe4fcfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: [1002:43a0] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: [1002:43a1] type 1
class 0x000604
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.0: [1002:4397] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.0: reg 10: [mem
0xfe4f3000-0xfe4f3fff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.2: [1002:4396] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.2: reg 10: [mem
0xfe4ff000-0xfe4ff0ff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.2: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.2: PME# supported from
D0 D1 D2 D3hot
May 13 13:51:39 daslab-c kernel: pci 0000:00:16.2: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:18.0: [1022:1200] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:00:18.1: [1022:1201] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:00:18.2: [1022:1202] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:00:18.3: [1022:1203] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:00:18.4: [1022:1204] type 0
class 0x000600
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: [1002:9714] type 0
class 0x000300
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: reg 10: [mem
0xd0000000-0xdfffffff pref]
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: reg 14: [io  0xc000-0xc0=
ff]
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: reg 18: [mem
0xfe6f0000-0xfe6fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: reg 24: [mem
0xfe500000-0xfe5fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.1: [1002:970f] type 0
class 0x000403
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.1: reg 10: [mem
0xfe6e8000-0xfe6ebfff]
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.1: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0: PCI bridge to [bus 01-01]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window [io
 0xc000-0xcfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window
[mem 0xfe500000-0xfe6fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window
[mem 0xd0000000-0xdfffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:02:00.0: [1033:0194] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:02:00.0: reg 10: [mem
0xfe7fe000-0xfe7fffff 64bit]
May 13 13:51:39 daslab-c kernel: pci 0000:02:00.0: PME# supported from
D0 D3hot D3cold
May 13 13:51:39 daslab-c kernel: pci 0000:02:00.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: PCI bridge to [bus 02-02]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window [io
 0xf000-0x0000] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window
[mem 0xfe700000-0xfe7fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window
[mem 0xfff00000-0x000fffff pref] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.0: [197b:2361] type 0
class 0x000101
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.0: reg 24: [mem
0xfe8fbc00-0xfe8fbdff]
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.0: PME# supported from D3hot
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: [197b:0368] type 0
class 0x000101
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: reg 10: [io  0xdc00-0xdc=
07]
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: reg 14: [io  0xd880-0xd8=
83]
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: reg 18: [io  0xd800-0xd8=
07]
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: reg 1c: [io  0xd480-0xd4=
83]
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: reg 20: [io  0xd400-0xd4=
0f]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: PCI bridge to [bus 03-03]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window [io
 0xd000-0xdfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window
[mem 0xfe800000-0xfe8fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window
[mem 0xfff00000-0x000fffff pref] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4: PCI bridge to [bus
04-04] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window [io
 0xf000-0x0000] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0xfff00000-0x000fffff] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0xfff00000-0x000fffff pref] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window [io
 0x0000-0x0cf7] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window [io
 0x0d00-0xffff] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0x000a0000-0x000bffff] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0x000d0000-0x000dffff] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0xcff00000-0xdfffffff] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem 0xf0000000-0xfebfffff] (subtractive decode)
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: [10ec:8168] type 0
class 0x000200
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: reg 10: [io  0xe800-0xe8=
ff]
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: reg 18: [mem
0xfdfff000-0xfdffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: reg 20: [mem
0xfdff8000-0xfdffbfff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: supports D1 D2
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: PME# supported from
D0 D1 D2 D3hot D3cold
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: PCI bridge to [bus 05-05]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window [io
 0xe000-0xefff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window
[mem 0xfff00000-0x000fffff] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window
[mem 0xfdf00000-0xfdffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:06:00.0: [1033:0194] type 0
class 0x000c03
May 13 13:51:39 daslab-c kernel: pci 0000:06:00.0: reg 10: [mem
0xfe9fe000-0xfe9fffff 64bit]
May 13 13:51:39 daslab-c kernel: pci 0000:06:00.0: PME# supported from D0 D=
3hot
May 13 13:51:39 daslab-c kernel: pci 0000:06:00.0: PME# disabled
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: PCI bridge to [bus 06-06]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window [io
 0xf000-0x0000] (disabled)
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window
[mem 0xfe900000-0xfe9fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window
[mem 0xfff00000-0x000fffff pref] (disabled)
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0P1._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCE9._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCEA._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P0PC._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PE20._PRT]
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PE21._PRT]
May 13 13:51:39 daslab-c kernel: pci0000:00: Requesting ACPI _OSC control (=
0x1d)
May 13 13:51:39 daslab-c kernel: pci0000:00: ACPI _OSC control (0x1d) grant=
ed
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
4 7 *10 11 14 15)
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs
4 7 *10 11 14 15)
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
4 7 10 *11 14 15)
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
4 *7 10 11 14 15)
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs
4 7 10 11 14 15) *0, disabled.
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs
4 7 10 11 14 15) *0, disabled.
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs
4 7 10 11 14 15) *0, disabled.
May 13 13:51:39 daslab-c kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs
4 7 10 11 14 15) *0, disabled.
May 13 13:51:39 daslab-c kernel: vgaarb: device added:
PCI:0000:01:05.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
May 13 13:51:39 daslab-c kernel: vgaarb: loaded
May 13 13:51:39 daslab-c kernel: PCI: Using ACPI for IRQ routing
May 13 13:51:39 daslab-c kernel: PCI: pci_cache_line_size set to 64 bytes
May 13 13:51:39 daslab-c kernel: reserve RAM buffer: 0000000000099800
- 000000000009ffff
May 13 13:51:39 daslab-c kernel: reserve RAM buffer: 00000000cfe90000
- 00000000cfffffff
May 13 13:51:39 daslab-c kernel: NetLabel: Initializing
May 13 13:51:39 daslab-c kernel: NetLabel:  domain hash size =3D 128
May 13 13:51:39 daslab-c kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4
May 13 13:51:39 daslab-c kernel: NetLabel:  unlabeled traffic allowed by de=
fault
May 13 13:51:39 daslab-c kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
May 13 13:51:39 daslab-c kernel: hpet0: 3 comparators, 32-bit
14.318180 MHz counter
May 13 13:51:39 daslab-c kernel: Switching to clocksource hpet
May 13 13:51:39 daslab-c kernel: pnp: PnP ACPI init
May 13 13:51:39 daslab-c kernel: ACPI: bus type pnp registered
May 13 13:51:39 daslab-c kernel: pnp 00:00: [bus 00-ff]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [io  0x0cf8-0x0cff]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [io  0x0000-0x0cf7 window]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [io  0x0d00-0xffff window]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [mem 0x000a0000-0x000bffff wind=
ow]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [mem 0x000d0000-0x000dffff wind=
ow]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [mem 0xcff00000-0xdfffffff wind=
ow]
May 13 13:51:39 daslab-c kernel: pnp 00:00: [mem 0xf0000000-0xfebfffff wind=
ow]
May 13 13:51:39 daslab-c kernel: pnp 00:00: Plug and Play ACPI device,
IDs PNP0a03 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:01: [mem
0x00000000-0xffffffffffffffff disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:01: [mem
0x00000000-0xffffffffffffffff disabled]
May 13 13:51:39 daslab-c kernel: Switched to NOHz mode on CPU #1
May 13 13:51:39 daslab-c kernel: Switched to NOHz mode on CPU #2
May 13 13:51:39 daslab-c kernel: Switched to NOHz mode on CPU #3
May 13 13:51:39 daslab-c kernel: Switched to NOHz mode on CPU #0
May 13 13:51:39 daslab-c kernel: system 00:01: Plug and Play ACPI
device, IDs PNP0c02 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:02: [dma 4]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x0000-0x000f]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x0081-0x0083]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x0087]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x0089-0x008b]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x008f]
May 13 13:51:39 daslab-c kernel: pnp 00:02: [io  0x00c0-0x00df]
May 13 13:51:39 daslab-c kernel: pnp 00:02: Plug and Play ACPI device,
IDs PNP0200 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:03: [io  0x0070-0x0071]
May 13 13:51:39 daslab-c kernel: pnp 00:03: [irq 8]
May 13 13:51:39 daslab-c kernel: pnp 00:03: Plug and Play ACPI device,
IDs PNP0b00 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:04: [io  0x0061]
May 13 13:51:39 daslab-c kernel: pnp 00:04: Plug and Play ACPI device,
IDs PNP0800 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:05: [io  0x00f0-0x00ff]
May 13 13:51:39 daslab-c kernel: pnp 00:05: [irq 13]
May 13 13:51:39 daslab-c kernel: pnp 00:05: Plug and Play ACPI device,
IDs PNP0c04 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:06: [io  0x03f8-0x03ff]
May 13 13:51:39 daslab-c kernel: pnp 00:06: [irq 4]
May 13 13:51:39 daslab-c kernel: pnp 00:06: [dma 0 disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:06: Plug and Play ACPI device,
IDs PNP0501 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:07: [mem 0xfed00000-0xfed003ff]
May 13 13:51:39 daslab-c kernel: pnp 00:07: Plug and Play ACPI device,
IDs PNP0103 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:08: [mem 0xfec00000-0xfec00fff]
May 13 13:51:39 daslab-c kernel: pnp 00:08: [mem 0xfee00000-0xfee00fff]
May 13 13:51:39 daslab-c kernel: system 00:08: [mem
0xfec00000-0xfec00fff] could not be reserved
May 13 13:51:39 daslab-c kernel: system 00:08: [mem
0xfee00000-0xfee00fff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:08: Plug and Play ACPI
device, IDs PNP0c02 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0010-0x001f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0022-0x003f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0062-0x0063]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0065-0x006f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0072-0x007f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0080]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0084-0x0086]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0088]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x008c-0x008e]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0090-0x009f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x00a2-0x00bf]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x00b1]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x00e0-0x00ef]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x04d0-0x04d1]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x040b]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x04d6]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c00-0x0c01]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c14]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c50-0x0c51]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c52]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c6c]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0c6f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0cd0-0x0cd1]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0cd2-0x0cd3]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0cd4-0x0cd5]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0cd6-0x0cd7]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0cd8-0x0cdf]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0800-0x089f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io
0x0000-0xffffffffffffffff disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0b00-0x0b1f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0b20-0x0b3f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0900-0x090f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0910-0x091f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0xfe00-0xfefe]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0060-0x005f disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [io  0x0064-0x0063 disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [mem 0xcff00000-0xcfffffff]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [mem 0xffb80000-0xffbfffff]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [mem 0xfec10000-0xfec1001f]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [mem 0xfed80000-0xfed80fff]
May 13 13:51:39 daslab-c kernel: pnp 00:09: [mem
0x00000000-0xffffffffffffffff disabled]
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x04d0-0x04d1] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x040b] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x04d6] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c00-0x0c01] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c14] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c50-0x0c51] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c52] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c6c] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0c6f] has been reserv=
ed
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0cd0-0x0cd1] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0cd2-0x0cd3] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0cd4-0x0cd5] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0cd6-0x0cd7] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0cd8-0x0cdf] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0800-0x089f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0b00-0x0b1f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0b20-0x0b3f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0900-0x090f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0x0910-0x091f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [io  0xfe00-0xfefe] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [mem
0xcff00000-0xcfffffff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [mem
0xffb80000-0xffbfffff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [mem
0xfec10000-0xfec1001f] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: [mem
0xfed80000-0xfed80fff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:09: Plug and Play ACPI
device, IDs PNP0c02 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:0a: [io  0x0060]
May 13 13:51:39 daslab-c kernel: pnp 00:0a: [io  0x0064]
May 13 13:51:39 daslab-c kernel: pnp 00:0a: [irq 1]
May 13 13:51:39 daslab-c kernel: pnp 00:0a: Plug and Play ACPI device,
IDs PNP0303 PNP030b (active)
May 13 13:51:39 daslab-c kernel: pnp 00:0b: [io
0x0000-0xffffffffffffffff disabled]
May 13 13:51:39 daslab-c kernel: pnp 00:0b: [io  0x0230-0x023f]
May 13 13:51:39 daslab-c kernel: pnp 00:0b: [io  0x0290-0x029f]
May 13 13:51:39 daslab-c kernel: pnp 00:0b: [io  0x0f40-0x0f4f]
May 13 13:51:39 daslab-c kernel: pnp 00:0b: [io  0x0a30-0x0a3f]
May 13 13:51:39 daslab-c kernel: system 00:0b: [io  0x0230-0x023f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:0b: [io  0x0290-0x029f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:0b: [io  0x0f40-0x0f4f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:0b: [io  0x0a30-0x0a3f] has
been reserved
May 13 13:51:39 daslab-c kernel: system 00:0b: Plug and Play ACPI
device, IDs PNP0c02 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:0c: [mem 0xe0000000-0xefffffff]
May 13 13:51:39 daslab-c kernel: system 00:0c: [mem
0xe0000000-0xefffffff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:0c: Plug and Play ACPI
device, IDs PNP0c02 (active)
May 13 13:51:39 daslab-c kernel: pnp 00:0d: [mem 0x00000000-0x0009ffff]
May 13 13:51:39 daslab-c kernel: pnp 00:0d: [mem 0x000c0000-0x000cffff]
May 13 13:51:39 daslab-c kernel: pnp 00:0d: [mem 0x000e0000-0x000fffff]
May 13 13:51:39 daslab-c kernel: pnp 00:0d: [mem 0x00100000-0xcfefffff]
May 13 13:51:39 daslab-c kernel: pnp 00:0d: [mem 0xfec00000-0xffffffff]
May 13 13:51:39 daslab-c kernel: system 00:0d: [mem
0x00000000-0x0009ffff] could not be reserved
May 13 13:51:39 daslab-c kernel: system 00:0d: [mem
0x000c0000-0x000cffff] has been reserved
May 13 13:51:39 daslab-c kernel: system 00:0d: [mem
0x000e0000-0x000fffff] could not be reserved
May 13 13:51:39 daslab-c kernel: system 00:0d: [mem
0x00100000-0xcfefffff] could not be reserved
May 13 13:51:39 daslab-c kernel: system 00:0d: [mem
0xfec00000-0xffffffff] could not be reserved
May 13 13:51:39 daslab-c kernel: system 00:0d: Plug and Play ACPI
device, IDs PNP0c01 (active)
May 13 13:51:39 daslab-c kernel: pnp: PnP ACPI: found 14 devices
May 13 13:51:39 daslab-c kernel: ACPI: ACPI bus type pnp unregistered
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0: PCI bridge to [bus 01-01]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window [io
 0xc000-0xcfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window
[mem 0xfe500000-0xfe6fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0:   bridge window
[mem 0xd0000000-0xdfffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: PCI bridge to [bus 02-02]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window [io
 disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window
[mem 0xfe700000-0xfe7fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0:   bridge window
[mem pref disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: PCI bridge to [bus 03-03]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window [io
 0xd000-0xdfff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window
[mem 0xfe800000-0xfe8fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0:   bridge window
[mem pref disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4: PCI bridge to [bus 04-04]
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window [io
 disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:14.4:   bridge window
[mem pref disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: PCI bridge to [bus 05-05]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window [io
 0xe000-0xefff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window
[mem disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0:   bridge window
[mem 0xfdf00000-0xfdffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: PCI bridge to [bus 06-06]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window [io
 disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window
[mem 0xfe900000-0xfe9fffff]
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1:   bridge window
[mem pref disabled]
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: PCI INT A -> GSI 17
(level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: pci 0000:00:09.0: setting latency timer to=
 64
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: PCI INT A -> GSI 18
(level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: pci 0000:00:0a.0: setting latency timer to=
 64
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: PCI INT A -> GSI 16
(level, low) -> IRQ 16
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.0: setting latency timer to=
 64
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: PCI INT A -> GSI 16
(level, low) -> IRQ 16
May 13 13:51:39 daslab-c kernel: pci 0000:00:15.1: setting latency timer to=
 64
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x=
0cf7]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0x=
ffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 6 [mem
0x000a0000-0x000bffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 7 [mem
0x000d0000-0x000dffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 8 [mem
0xcff00000-0xdfffffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:00: resource 9 [mem
0xf0000000-0xfebfffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:01: resource 0 [io  0xc000-0x=
cfff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:01: resource 1 [mem
0xfe500000-0xfe6fffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:01: resource 2 [mem
0xd0000000-0xdfffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:02: resource 1 [mem
0xfe700000-0xfe7fffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:03: resource 0 [io  0xd000-0x=
dfff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:03: resource 1 [mem
0xfe800000-0xfe8fffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 4 [io  0x0000-0x=
0cf7]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 5 [io  0x0d00-0x=
ffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 6 [mem
0x000a0000-0x000bffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 7 [mem
0x000d0000-0x000dffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 8 [mem
0xcff00000-0xdfffffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:04: resource 9 [mem
0xf0000000-0xfebfffff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:05: resource 0 [io  0xe000-0x=
efff]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:05: resource 2 [mem
0xfdf00000-0xfdffffff 64bit pref]
May 13 13:51:39 daslab-c kernel: pci_bus 0000:06: resource 1 [mem
0xfe900000-0xfe9fffff]
May 13 13:51:39 daslab-c kernel: NET: Registered protocol family 2
May 13 13:51:39 daslab-c kernel: IP route cache hash table entries:
131072 (order: 8, 1048576 bytes)
May 13 13:51:39 daslab-c kernel: TCP established hash table entries:
524288 (order: 11, 8388608 bytes)
May 13 13:51:39 daslab-c kernel: TCP bind hash table entries: 65536
(order: 8, 1048576 bytes)
May 13 13:51:39 daslab-c kernel: TCP: Hash tables configured
(established 524288 bind 65536)
May 13 13:51:39 daslab-c kernel: TCP reno registered
May 13 13:51:39 daslab-c kernel: UDP hash table entries: 2048 (order:
4, 65536 bytes)
May 13 13:51:39 daslab-c kernel: UDP-Lite hash table entries: 2048
(order: 4, 65536 bytes)
May 13 13:51:39 daslab-c kernel: NET: Registered protocol family 1
May 13 13:51:39 daslab-c kernel: pci 0000:00:01.0: MSI quirk detected;
subordinate MSI disabled
May 13 13:51:39 daslab-c kernel: pci 0000:01:05.0: Boot video device
May 13 13:51:39 daslab-c kernel: PCI: CLS 64 bytes, default 64
May 13 13:51:39 daslab-c kernel: Unpacking initramfs...
May 13 13:51:39 daslab-c kernel: Freeing initrd memory: 1928k freed
May 13 13:51:39 daslab-c kernel: PCI-DMA: Disabling AGP.
May 13 13:51:39 daslab-c kernel: PCI-DMA: aperture base @ c0000000 size 655=
36 KB
May 13 13:51:39 daslab-c kernel: PCI-DMA: using GART IOMMU.
May 13 13:51:39 daslab-c kernel: PCI-DMA: Reserving 64MB of IOMMU area
in the AGP aperture
May 13 13:51:39 daslab-c kernel: audit: initializing netlink socket (disabl=
ed)
May 13 13:51:39 daslab-c kernel: type=3D2000 audit(1305312688.453:1): initi=
alized
May 13 13:51:39 daslab-c kernel: HugeTLB registered 2 MB page size,
pre-allocated 0 pages
May 13 13:51:39 daslab-c kernel: VFS: Disk quotas dquot_6.5.2
May 13 13:51:39 daslab-c kernel: Dquot-cache hash table entries: 512
(order 0, 4096 bytes)
May 13 13:51:39 daslab-c kernel: msgmni has been set to 7422
May 13 13:51:39 daslab-c kernel: Block layer SCSI generic (bsg) driver
version 0.4 loaded (major 253)
May 13 13:51:39 daslab-c kernel: io scheduler noop registered
May 13 13:51:39 daslab-c kernel: io scheduler deadline registered
May 13 13:51:39 daslab-c kernel: io scheduler cfq registered (default)
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:09.0: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:09.0: irq 40 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:0a.0: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:0a.0: irq 41 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.0: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.0: irq 42 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.1: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.1: irq 43 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:09.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pci 0000:02:00.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pcie_pme 0000:00:09.0:pcie01: service
driver pcie_pme loaded
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:0a.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pci 0000:03:00.1: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pcie_pme 0000:00:0a.0:pcie01: service
driver pcie_pme loaded
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pci 0000:05:00.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pcie_pme 0000:00:15.0:pcie01: service
driver pcie_pme loaded
May 13 13:51:39 daslab-c kernel: pcieport 0000:00:15.1: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pci 0000:06:00.0: Signaling PME
through PCIe PME interrupt
May 13 13:51:39 daslab-c kernel: pcie_pme 0000:00:15.1:pcie01: service
driver pcie_pme loaded
May 13 13:51:39 daslab-c kernel: vesafb: mode is 1280x1024x16,
linelength=3D2560, pages=3D5
May 13 13:51:39 daslab-c kernel: vesafb: scrolling: redraw
May 13 13:51:39 daslab-c kernel: vesafb: Truecolor: size=3D0:5:6:5, shift=
=3D0:11:5:0
May 13 13:51:39 daslab-c kernel: vesafb: framebuffer at 0xd0000000,
mapped to 0xffffc90011100000, using 5120k, total 16384k
May 13 13:51:39 daslab-c kernel: Console: switching to colour frame
buffer device 160x64
May 13 13:51:39 daslab-c kernel: fb0: VESA VGA frame buffer device
May 13 13:51:39 daslab-c kernel: ERST: Table is not found!
May 13 13:51:39 daslab-c kernel: Serial: 8250/16550 driver, 4 ports,
IRQ sharing disabled
May 13 13:51:39 daslab-c kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D
4) is a 16550A
May 13 13:51:39 daslab-c kernel: 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) is a=
 16550A
May 13 13:51:39 daslab-c kernel: Linux agpgart interface v0.103
May 13 13:51:39 daslab-c kernel: i8042: PNP: PS/2 Controller
[PNP0303:PS2K] at 0x60,0x64 irq 1
May 13 13:51:39 daslab-c kernel: i8042: PNP: PS/2 appears to have AUX
port disabled, if this is incorrect please boot with i8042.nopnp
May 13 13:51:39 daslab-c kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 13 13:51:39 daslab-c kernel: mousedev: PS/2 mouse device common for all=
 mice
May 13 13:51:39 daslab-c kernel: rtc_cmos 00:03: RTC can wake from S4
May 13 13:51:39 daslab-c kernel: input: AT Translated Set 2 keyboard
as /devices/platform/i8042/serio0/input/input0
May 13 13:51:39 daslab-c kernel: rtc_cmos 00:03: rtc core: registered
rtc_cmos as rtc0
May 13 13:51:39 daslab-c kernel: rtc0: alarms up to one month, y3k,
114 bytes nvram, hpet irqs
May 13 13:51:39 daslab-c kernel: cpuidle: using governor ladder
May 13 13:51:39 daslab-c kernel: cpuidle: using governor menu
May 13 13:51:39 daslab-c kernel: TCP cubic registered
May 13 13:51:39 daslab-c kernel: NET: Registered protocol family 17
May 13 13:51:39 daslab-c kernel: Registering the dns_resolver key type
May 13 13:51:39 daslab-c kernel: PM: Checking hibernation image
partition /dev/disk/by-uuid/135368bc-5cb8-11e0-8e1e-bcaec5631586
May 13 13:51:39 daslab-c kernel: PM: Hibernation image not present or
could not be loaded.
May 13 13:51:39 daslab-c kernel: registered taskstats version 1
May 13 13:51:39 daslab-c kernel: rtc_cmos 00:03: setting system clock
to 2011-05-13 18:51:29 UTC (1305312689)
May 13 13:51:39 daslab-c kernel: Initializing network drop monitor service
May 13 13:51:39 daslab-c kernel: Freeing unused kernel memory: 608k freed
May 13 13:51:39 daslab-c kernel: usbcore: registered new interface driver u=
sbfs
May 13 13:51:39 daslab-c kernel: usbcore: registered new interface driver h=
ub
May 13 13:51:39 daslab-c kernel: usbcore: registered new device driver usb
May 13 13:51:39 daslab-c kernel: SCSI subsystem initialized
May 13 13:51:39 daslab-c kernel: ehci_hcd: USB 2.0 'Enhanced' Host
Controller (EHCI) Driver
May 13 13:51:39 daslab-c kernel: ehci_hcd: block sizes: qh 104 qtd 96
itd 192 sitd 96
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: PCI INT B ->
GSI 17 (level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating
file 'devices'
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: new USB bus
registered, assigned bus number 1
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: reset
hcs_params 0x101505 dbg=3D1 cc=3D1 pcc=3D5 ordered !ppc ports=3D5
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: reset
hcc_params a072 thresh 7 uframes 256/512/1024
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
May 13 13:51:39 daslab-c kernel: QUIRK: Enable AMD PLL fix
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: debug port 1
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: MWI active
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: irq 17, io mem
0xfe4ff800
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: init command
0010005 (park)=3D0 ithresh=3D1 period=3D512 RUN
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: PCI INT A ->
GSI 17 (level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
02'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: new USB bus
registered, assigned bus number 2
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: USB 2.0
started, EHCI 1.00
May 13 13:51:39 daslab-c kernel: usb usb1: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb1: udev 1, busnum 1, minor =3D 0
May 13 13:51:39 daslab-c kernel: usb usb1: New USB device found,
idVendor=3D1d6b, idProduct=3D0002
May 13 13:51:39 daslab-c kernel: usb usb1: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb1: Product: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb1: Manufacturer: Linux
2.6.39-rc7-mainline ehci_hcd
May 13 13:51:39 daslab-c kernel: usb usb1: SerialNumber: 0000:00:12.2
May 13 13:51:39 daslab-c kernel: usb usb1: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb1: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: usb usb1: adding 1-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: 5 ports detected
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: PCI INT B ->
GSI 17 (level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
03'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: new USB bus
registered, assigned bus number 3
May 13 13:51:39 daslab-c kernel: libata version 3.00 loaded.
May 13 13:51:39 daslab-c kernel: pata_jmicron 0000:03:00.1: enabling
device (0000 -> 0001)
May 13 13:51:39 daslab-c kernel: pata_jmicron 0000:03:00.1: PCI INT B
-> GSI 19 (level, low) -> IRQ 19
May 13 13:51:39 daslab-c kernel: pata_jmicron 0000:03:00.1: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: scsi0 : pata_jmicron
May 13 13:51:39 daslab-c kernel: scsi1 : pata_jmicron
May 13 13:51:39 daslab-c kernel: ata1: PATA max UDMA/100 cmd 0xdc00
ctl 0xd880 bmdma 0xd400 irq 19
May 13 13:51:39 daslab-c kernel: ata2: PATA max UDMA/100 cmd 0xd800
ctl 0xd480 bmdma 0xd408 irq 19
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 17, io mem
0xfe7fe000
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 44 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 45 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 46 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 47 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: irq 48 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: usb usb2: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb2: udev 1, busnum 2, minor =3D 128
May 13 13:51:39 daslab-c kernel: usb usb2: New USB device found,
idVendor=3D1d6b, idProduct=3D0002
May 13 13:51:39 daslab-c kernel: usb usb2: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb2: Product: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb2: Manufacturer: Linux
2.6.39-rc7-mainline xhci_hcd
May 13 13:51:39 daslab-c kernel: usb usb2: SerialNumber: 0000:02:00.0
May 13 13:51:39 daslab-c kernel: usb usb2: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb2: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: xHCI xhci_add_endpoint called for root hub
May 13 13:51:39 daslab-c kernel: xHCI xhci_check_bandwidth called for root =
hub
May 13 13:51:39 daslab-c kernel: usb usb2: adding 2-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: 2 ports detected
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: individual port power switchi=
ng
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: Single TT
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: TT requires at most 8 FS
bit times (666 ns)
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: enabling power on all ports
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
04'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: new USB bus
registered, assigned bus number 4
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: reset
hcs_params 0x101505 dbg=3D1 cc=3D1 pcc=3D5 ordered !ppc ports=3D5
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: reset
hcc_params a072 thresh 7 uframes 256/512/1024
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: debug port 1
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: MWI active
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: irq 17, io mem
0xfe4ff400
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: init command
0010005 (park)=3D0 ithresh=3D1 period=3D512 RUN
May 13 13:51:39 daslab-c kernel: ohci_hcd: USB 1.1 'Open' Host
Controller (OHCI) Driver
May 13 13:51:39 daslab-c kernel: ohci_hcd: block sizes: ed 80 td 96
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:02:00.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: usb usb4: skipped 1 descriptor after endpo=
int
May 13 13:51:39 daslab-c kernel: usb usb4: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb4: udev 1, busnum 4, minor =3D 384
May 13 13:51:39 daslab-c kernel: usb usb4: New USB device found,
idVendor=3D1d6b, idProduct=3D0003
May 13 13:51:39 daslab-c kernel: usb usb4: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb4: Product: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb4: Manufacturer: Linux
2.6.39-rc7-mainline xhci_hcd
May 13 13:51:39 daslab-c kernel: usb usb4: SerialNumber: 0000:02:00.0
May 13 13:51:39 daslab-c kernel: usb usb4: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb4: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: xHCI xhci_add_endpoint called for root hub
May 13 13:51:39 daslab-c kernel: xHCI xhci_check_bandwidth called for root =
hub
May 13 13:51:39 daslab-c kernel: usb usb4: adding 4-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: 2 ports detected
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: individual port power switchi=
ng
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: TT requires at most 8 FS
bit times (666 ns)
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: enabling power on all ports
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: PCI INT A ->
GSI 17 (level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
05'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: new USB bus
registered, assigned bus number 5
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: USB 2.0
started, EHCI 1.00
May 13 13:51:39 daslab-c kernel: usb usb3: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb3: udev 1, busnum 3, minor =3D 256
May 13 13:51:39 daslab-c kernel: usb usb3: New USB device found,
idVendor=3D1d6b, idProduct=3D0002
May 13 13:51:39 daslab-c kernel: usb usb3: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb3: Product: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb3: Manufacturer: Linux
2.6.39-rc7-mainline ehci_hcd
May 13 13:51:39 daslab-c kernel: usb usb3: SerialNumber: 0000:00:13.2
May 13 13:51:39 daslab-c kernel: usb usb3: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb3: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: usb usb3: adding 3-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: 5 ports detected
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: PCI INT B ->
GSI 17 (level, low) -> IRQ 17
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
06'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: new USB bus
registered, assigned bus number 6
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 17, io mem
0xfe9fe000
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 49 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 50 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 51 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 52 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: irq 53 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: usb usb5: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb5: udev 1, busnum 5, minor =3D 512
May 13 13:51:39 daslab-c kernel: usb usb5: New USB device found,
idVendor=3D1d6b, idProduct=3D0002
May 13 13:51:39 daslab-c kernel: usb usb5: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb5: Product: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb5: Manufacturer: Linux
2.6.39-rc7-mainline xhci_hcd
May 13 13:51:39 daslab-c kernel: usb usb5: SerialNumber: 0000:06:00.0
May 13 13:51:39 daslab-c kernel: usb usb5: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb5: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: xHCI xhci_add_endpoint called for root hub
May 13 13:51:39 daslab-c kernel: xHCI xhci_check_bandwidth called for root =
hub
May 13 13:51:39 daslab-c kernel: usb usb5: adding 5-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: 2 ports detected
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: individual port power switchi=
ng
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: Single TT
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: TT requires at most 8 FS
bit times (666 ns)
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: enabling power on all ports
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
07'
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: new USB bus
registered, assigned bus number 7
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: reset
hcs_params 0x101404 dbg=3D1 cc=3D1 pcc=3D4 ordered !ppc ports=3D4
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: reset
hcc_params a072 thresh 7 uframes 256/512/1024
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: debug port 1
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: MWI active
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: irq 17, io mem
0xfe4ff000
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: reset command
0080002 (park)=3D0 ithresh=3D8 period=3D1024 Reset HALT
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: init command
0010005 (park)=3D0 ithresh=3D1 period=3D512 RUN
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: USB 2.0
started, EHCI 1.00
May 13 13:51:39 daslab-c kernel: usb usb6: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb6: udev 1, busnum 6, minor =3D 640
May 13 13:51:39 daslab-c kernel: usb usb6: New USB device found,
idVendor=3D1d6b, idProduct=3D0002
May 13 13:51:39 daslab-c kernel: usb usb6: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb6: Product: EHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb6: Manufacturer: Linux
2.6.39-rc7-mainline ehci_hcd
May 13 13:51:39 daslab-c kernel: usb usb6: SerialNumber: 0000:00:16.2
May 13 13:51:39 daslab-c kernel: usb usb6: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb6: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: usb usb6: adding 6-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: 4 ports detected
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ahci 0000:00:11.0: version 3.0
May 13 13:51:39 daslab-c kernel: ahci 0000:00:11.0: PCI INT A -> GSI
19 (level, low) -> IRQ 19
May 13 13:51:39 daslab-c kernel: ahci 0000:00:11.0: irq 54 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: ahci 0000:00:11.0: AHCI 0001.0200 32
slots 6 ports 6 Gbps 0x3f impl SATA mode
May 13 13:51:39 daslab-c kernel: ahci 0000:00:11.0: flags: 64bit ncq
sntf ilck pm led clo pmp pio slum part
May 13 13:51:39 daslab-c kernel: scsi2 : ahci
May 13 13:51:39 daslab-c kernel: scsi3 : ahci
May 13 13:51:39 daslab-c kernel: scsi4 : ahci
May 13 13:51:39 daslab-c kernel: scsi5 : ahci
May 13 13:51:39 daslab-c kernel: scsi6 : ahci
May 13 13:51:39 daslab-c kernel: scsi7 : ahci
May 13 13:51:39 daslab-c kernel: ata3: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4ffd00 irq 54
May 13 13:51:39 daslab-c kernel: ata4: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4ffd80 irq 54
May 13 13:51:39 daslab-c kernel: ata5: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4ffe00 irq 54
May 13 13:51:39 daslab-c kernel: ata6: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4ffe80 irq 54
May 13 13:51:39 daslab-c kernel: ata7: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4fff00 irq 54
May 13 13:51:39 daslab-c kernel: ata8: SATA max UDMA/133 abar
m1024@0xfe4ffc00 port 0xfe4fff80 irq 54
May 13 13:51:39 daslab-c kernel: ahci 0000:03:00.0: PCI INT A -> GSI
18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: ahci 0000:03:00.0: JMB361 has only one port
May 13 13:51:39 daslab-c kernel: ahci 0000:03:00.0: AHCI 0001.0100 32
slots 1 ports 3 Gbps 0x1 impl SATA mode
May 13 13:51:39 daslab-c kernel: ahci 0000:03:00.0: flags: 64bit ncq
pm led clo pmp pio slum part
May 13 13:51:39 daslab-c kernel: ahci 0000:03:00.0: setting latency timer t=
o 64
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: PCI INT A ->
GSI 18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
08'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: new USB bus
registered, assigned bus number 8
May 13 13:51:39 daslab-c kernel: scsi8 : ahci
May 13 13:51:39 daslab-c kernel: ata9: SATA max UDMA/133 abar
m512@0xfe8fbc00 port 0xfe8fbd00 irq 18
May 13 13:51:39 daslab-c kernel: xhci_hcd 0000:06:00.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: usb usb7: skipped 1 descriptor after endpo=
int
May 13 13:51:39 daslab-c kernel: usb usb7: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb7: udev 1, busnum 7, minor =3D 768
May 13 13:51:39 daslab-c kernel: usb usb7: New USB device found,
idVendor=3D1d6b, idProduct=3D0003
May 13 13:51:39 daslab-c kernel: usb usb7: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb7: Product: xHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb7: Manufacturer: Linux
2.6.39-rc7-mainline xhci_hcd
May 13 13:51:39 daslab-c kernel: usb usb7: SerialNumber: 0000:06:00.0
May 13 13:51:39 daslab-c kernel: usb usb7: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb7: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: xHCI xhci_add_endpoint called for root hub
May 13 13:51:39 daslab-c kernel: xHCI xhci_check_bandwidth called for root =
hub
May 13 13:51:39 daslab-c kernel: usb usb7: adding 7-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: 2 ports detected
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: individual port power switchi=
ng
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: individual port
over-current protection
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: TT requires at most 8 FS
bit times (666 ns)
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: power on to power good time: =
20ms
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: enabling power on all ports
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: enabled AMD
prefetch quirk
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: created debug files
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: irq 18, io mem
0xfe4fe000
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: GetStatus
port:4 status 001403 0  ACK POWER sig=3Dk CSC CONNECT
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: port 4: status 0501 change 00=
01
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: state 7 ports 2 chg 0000 evt =
0000
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: state 7 ports 2 chg 0000 evt =
0000
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: GetStatus
port:1 status 001403 0  ACK POWER sig=3Dk CSC CONNECT
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: port 1: status 0501 change 00=
01
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: state 7 ports 2 chg 0000 evt =
0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: OHCI controller sta=
te
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: OHCI 1.0, NO
legacy support registers
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: control 0x283
RWC HCFS=3Doperational CBSR=3D3
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: cmdstatus 0x00000 S=
OC=3D0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: intrstatus 0x000000=
04 SF
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: intrenable
0x8000005a MIE RHSC UE RD WDH
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: hcca frame #0005
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: roothub.a
02001205 POTPGT=3D2 NOCP NPS NDP=3D5(5)
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: roothub.b
00000000 PPCM=3D0000 DR=3D0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: roothub.status
00008000 DRWE
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0:
roothub.portstatus [0] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0:
roothub.portstatus [1] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0:
roothub.portstatus [2] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0:
roothub.portstatus [3] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0:
roothub.portstatus [4] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: usb usb8: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb8: udev 1, busnum 8, minor =3D 896
May 13 13:51:39 daslab-c kernel: usb usb8: New USB device found,
idVendor=3D1d6b, idProduct=3D0001
May 13 13:51:39 daslab-c kernel: usb usb8: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb8: Product: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb8: Manufacturer: Linux
2.6.39-rc7-mainline ohci_hcd
May 13 13:51:39 daslab-c kernel: usb usb8: SerialNumber: 0000:00:12.0
May 13 13:51:39 daslab-c kernel: usb usb8: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb8: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: usb usb8: adding 8-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: 5 ports detected
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: no over-current protection
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: power on to power good time: =
4ms
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: HS companion
for 0000:00:12.0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: PCI INT A ->
GSI 18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
09'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: new USB bus
registered, assigned bus number 9
May 13 13:51:39 daslab-c kernel: ata1.00: ATAPI: _NEC DVD_RW ND-2510A,
2.15, max UDMA/33
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: state 7 ports 4 chg 0000 evt =
0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: enabled AMD
prefetch quirk
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: created debug files
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: irq 18, io mem
0xfe4fd000
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: state 7 ports 2 chg 0000 evt =
0000
May 13 13:51:39 daslab-c kernel: ata1.00: configured for UDMA/33
May 13 13:51:39 daslab-c kernel: scsi 0:0:0:0: CD-ROM            _NEC
   DVD_RW ND-2510A  2.15 PQ: 0 ANSI: 5
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: state 7 ports 5 chg 0010 evt =
0000
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: port 4, status 0501,
change 0000, 480 Mb/s
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: port 4 low
speed --> companion
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: OHCI controller sta=
te
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: OHCI 1.0, NO
legacy support registers
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: control 0x283
RWC HCFS=3Doperational CBSR=3D3
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: cmdstatus 0x00000 S=
OC=3D0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: intrstatus 0x000000=
04 SF
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: intrenable
0x8000005a MIE RHSC UE RD WDH
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: hcca frame #0005
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: roothub.a
02001205 POTPGT=3D2 NOCP NPS NDP=3D5(5)
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: roothub.b
00000000 PPCM=3D0000 DR=3D0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: roothub.status
00008000 DRWE
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0:
roothub.portstatus [0] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0:
roothub.portstatus [1] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0:
roothub.portstatus [2] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0:
roothub.portstatus [3] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0:
roothub.portstatus [4] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: usb usb9: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb9: udev 1, busnum 9, minor =3D 1024
May 13 13:51:39 daslab-c kernel: usb usb9: New USB device found,
idVendor=3D1d6b, idProduct=3D0001
May 13 13:51:39 daslab-c kernel: usb usb9: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb9: Product: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb9: Manufacturer: Linux
2.6.39-rc7-mainline ohci_hcd
May 13 13:51:39 daslab-c kernel: usb usb9: SerialNumber: 0000:00:13.0
May 13 13:51:39 daslab-c kernel: usb usb9: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb9: configuration #1 chosen from 1 c=
hoice
May 13 13:51:39 daslab-c kernel: usb usb9: adding 9-0:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: 5 ports detected
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: no over-current protection
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: power on to power good time: =
4ms
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: HS companion
for 0000:00:13.0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: PCI INT C ->
GSI 18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
10'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: new USB bus
registered, assigned bus number 10
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: GetStatus
port:4 status 003002 0  ACK POWER OWNER sig=3Dse0 CSC
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: GetStatus
roothub.portstatus [3] =3D 0x00010301 CSC LSDA PPS CCS
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: port 4: status 0301 change 00=
01
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: state 7 ports 5 chg 0000 evt =
0010
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: state 7 ports 5 chg 0002 evt =
0000
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: port 1, status 0501,
change 0000, 480 Mb/s
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: port 1 low
speed --> companion
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: enabled AMD
prefetch quirk
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: created debug files
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: irq 18, io mem
0xfe4fc000
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: GetStatus
port:1 status 003002 0  ACK POWER OWNER sig=3Dse0 CSC
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: state 7 ports 5 chg 0000 evt =
0002
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: OHCI controller sta=
te
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: OHCI 1.0, NO
legacy support registers
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: control 0x283
RWC HCFS=3Doperational CBSR=3D3
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: cmdstatus 0x00000 S=
OC=3D0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: intrstatus 0x000000=
04 SF
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: intrenable
0x8000005a MIE RHSC UE RD WDH
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: hcca frame #0005
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: roothub.a
02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: roothub.b
00000000 PPCM=3D0000 DR=3D0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: roothub.status
00008000 DRWE
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5:
roothub.portstatus [0] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5:
roothub.portstatus [1] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: usb usb10: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb10: udev 1, busnum 10, minor =3D 11=
52
May 13 13:51:39 daslab-c kernel: usb usb10: New USB device found,
idVendor=3D1d6b, idProduct=3D0001
May 13 13:51:39 daslab-c kernel: usb usb10: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb10: Product: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb10: Manufacturer: Linux
2.6.39-rc7-mainline ohci_hcd
May 13 13:51:39 daslab-c kernel: usb usb10: SerialNumber: 0000:00:14.5
May 13 13:51:39 daslab-c kernel: usb usb10: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb10: configuration #1 chosen
from 1 choice
May 13 13:51:39 daslab-c kernel: usb usb10: adding 10-0:1.0 (config
#1, interface 0)
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: 2 ports detected
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: no over-current protection
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: power on to power good time:=
 4ms
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: PCI INT A ->
GSI 18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
11'
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: new USB bus
registered, assigned bus number 11
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: GetStatus
roothub.portstatus [0] =3D 0x00010301 CSC LSDA PPS CCS
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: port 1: status 0301 change 00=
01
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: enabled AMD
prefetch quirk
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: created debug files
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: supports USB
remote wakeup
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: irq 18, io mem
0xfe4f3000
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: state 7 ports 5 chg 0010 evt =
0000
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: port 4, status 0301,
change 0000, 1.5 Mb/s
May 13 13:51:39 daslab-c kernel: Refined TSC clocksource calibration:
3612.065 MHz.
May 13 13:51:39 daslab-c kernel: Switching to clocksource tsc
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: port[3] reset
timeout, stat 00000311
May 13 13:51:39 daslab-c kernel: ata5: SATA link down (SStatus 0 SControl 3=
00)
May 13 13:51:39 daslab-c kernel: ata9: SATA link down (SStatus 0 SControl 3=
00)
May 13 13:51:39 daslab-c kernel: ata8: SATA link down (SStatus 0 SControl 3=
00)
May 13 13:51:39 daslab-c kernel: ata6: SATA link down (SStatus 0 SControl 3=
00)
May 13 13:51:39 daslab-c kernel: ata7: SATA link down (SStatus 0 SControl 3=
00)
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: OHCI controller sta=
te
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: OHCI 1.0, NO
legacy support registers
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: control 0x283
RWC HCFS=3Doperational CBSR=3D3
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: cmdstatus 0x00000 S=
OC=3D0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: intrstatus 0x000000=
04 SF
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: intrenable
0x8000005a MIE RHSC UE RD WDH
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: hcca frame #0005
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: roothub.a
02001204 POTPGT=3D2 NOCP NPS NDP=3D4(4)
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: roothub.b
00000000 PPCM=3D0000 DR=3D0000
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: roothub.status
00008000 DRWE
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0:
roothub.portstatus [0] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0:
roothub.portstatus [1] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0:
roothub.portstatus [2] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0:
roothub.portstatus [3] 0x00000100 PPS
May 13 13:51:39 daslab-c kernel: usb usb11: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb usb11: udev 1, busnum 11, minor =3D 12=
80
May 13 13:51:39 daslab-c kernel: usb usb11: New USB device found,
idVendor=3D1d6b, idProduct=3D0001
May 13 13:51:39 daslab-c kernel: usb usb11: New USB device strings:
Mfr=3D3, Product=3D2, SerialNumber=3D1
May 13 13:51:39 daslab-c kernel: usb usb11: Product: OHCI Host Controller
May 13 13:51:39 daslab-c kernel: usb usb11: Manufacturer: Linux
2.6.39-rc7-mainline ohci_hcd
May 13 13:51:39 daslab-c kernel: usb usb11: SerialNumber: 0000:00:16.0
May 13 13:51:39 daslab-c kernel: usb usb11: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb usb11: configuration #1 chosen
from 1 choice
May 13 13:51:39 daslab-c kernel: usb usb11: adding 11-0:1.0 (config
#1, interface 0)
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: usb_probe_interface - got id
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: USB hub found
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: 4 ports detected
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: standalone hub
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: no power switching (usb 1.0)
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: no over-current protection
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: power on to power good time:=
 4ms
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: local power source is good
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: trying to enable port
power on non-switchable hub
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
01'
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: HS companion
for 0000:00:16.0
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: GetStatus
roothub.portstatus [3] =3D 0x00100303 PRSC LSDA PPS PES CCS
May 13 13:51:39 daslab-c kernel: usb 8-4: new low speed USB device
number 2 using ohci_hcd
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: port[3] reset
timeout, stat 00000313
May 13 13:51:39 daslab-c kernel: ata3: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
May 13 13:51:39 daslab-c kernel: ata4: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
May 13 13:51:39 daslab-c kernel: ata4.00: ATA-8: WDC
WD2500AAKX-001CA0, 15.01H15, max UDMA/133
May 13 13:51:39 daslab-c kernel: ata4.00: 488397168 sectors, multi 0:
LBA48 NCQ (depth 31/32), AA
May 13 13:51:39 daslab-c kernel: ata4.00: configured for UDMA/133
May 13 13:51:39 daslab-c kernel: ata3.00: ATA-8: WDC
WD1600AAJS-00WAA0, 58.01D58, max UDMA/133
May 13 13:51:39 daslab-c kernel: ata3.00: 312581808 sectors, multi 0:
LBA48 NCQ (depth 31/32), AA
May 13 13:51:39 daslab-c kernel: ata3.00: configured for UDMA/133
May 13 13:51:39 daslab-c kernel: scsi 2:0:0:0: Direct-Access     ATA
   WDC WD1600AAJS-0 58.0 PQ: 0 ANSI: 5
May 13 13:51:39 daslab-c kernel: scsi 3:0:0:0: Direct-Access     ATA
   WDC WD2500AAKX-0 15.0 PQ: 0 ANSI: 5
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:12.0: GetStatus
roothub.portstatus [3] =3D 0x00100303 PRSC LSDA PPS PES CCS
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: [sda] 312581808 512-byte
logical blocks: (160 GB/149 GiB)
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: [sda] Write Protect is off
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: [sdb] 488397168 512-byte
logical blocks: (250 GB/232 GiB)
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: [sdb] Write Protect is off
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
May 13 13:51:39 daslab-c kernel: sda: sda1 sda2 sda3
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: [sda] Attached SCSI disk
May 13 13:51:39 daslab-c kernel: sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
sdb7 sdb8 sdb9
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: [sdb] Attached SCSI disk
May 13 13:51:39 daslab-c kernel: sr0: scsi3-mmc drive: 40x/40x writer
cd/rw xa/form2 cdda tray
May 13 13:51:39 daslab-c kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
May 13 13:51:39 daslab-c kernel: sr 0:0:0:0: Attached scsi CD-ROM sr0
May 13 13:51:39 daslab-c kernel: usb 8-4: skipped 1 descriptor after interf=
ace
May 13 13:51:39 daslab-c kernel: usb 8-4: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb 8-4: udev 2, busnum 8, minor =3D 897
May 13 13:51:39 daslab-c kernel: usb 8-4: New USB device found,
idVendor=3D413c, idProduct=3D2005
May 13 13:51:39 daslab-c kernel: usb 8-4: New USB device strings:
Mfr=3D1, Product=3D2, SerialNumber=3D0
May 13 13:51:39 daslab-c kernel: usb 8-4: Product: DELL USB Keyboard
May 13 13:51:39 daslab-c kernel: usb 8-4: Manufacturer: DELL
May 13 13:51:39 daslab-c kernel: usb 8-4: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb 8-4: configuration #1 chosen from 1 ch=
oice
May 13 13:51:39 daslab-c kernel: usb 8-4: adding 8-4:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
02'
May 13 13:51:39 daslab-c kernel: hub 8-0:1.0: state 7 ports 5 chg 0000 evt =
0010
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: state 7 ports 2 chg 0000 evt=
 0000
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: state 7 ports 5 chg 0002 evt =
0000
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: port 1, status 0301,
change 0000, 1.5 Mb/s
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: port[0] reset
timeout, stat 00000311
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: GetStatus
roothub.portstatus [0] =3D 0x00100303 PRSC LSDA PPS PES CCS
May 13 13:51:39 daslab-c kernel: usb 9-1: new low speed USB device
number 2 using ohci_hcd
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: port[0] reset
timeout, stat 00000313
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:13.0: GetStatus
roothub.portstatus [0] =3D 0x00100303 PRSC LSDA PPS PES CCS
May 13 13:51:39 daslab-c kernel: usb 9-1: skipped 1 descriptor after interf=
ace
May 13 13:51:39 daslab-c kernel: usb 9-1: default language 0x0409
May 13 13:51:39 daslab-c kernel: usb 9-1: udev 2, busnum 9, minor =3D 1025
May 13 13:51:39 daslab-c kernel: usb 9-1: New USB device found,
idVendor=3D046d, idProduct=3Dc03d
May 13 13:51:39 daslab-c kernel: usb 9-1: New USB device strings:
Mfr=3D1, Product=3D2, SerialNumber=3D0
May 13 13:51:39 daslab-c kernel: usb 9-1: Product: USB-PS/2 Optical Mouse
May 13 13:51:39 daslab-c kernel: usb 9-1: Manufacturer: Logitech
May 13 13:51:39 daslab-c kernel: usb 9-1: usb_probe_device
May 13 13:51:39 daslab-c kernel: usb 9-1: configuration #1 chosen from 1 ch=
oice
May 13 13:51:39 daslab-c kernel: usb 9-1: adding 9-1:1.0 (config #1,
interface 0)
May 13 13:51:39 daslab-c kernel: drivers/usb/core/inode.c: creating file '0=
02'
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: state 7 ports 4 chg 0000 evt=
 0000
May 13 13:51:39 daslab-c kernel: hub 9-0:1.0: state 7 ports 5 chg 0000 evt =
0002
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: auto-stop root hub
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: auto-stop root hub
May 13 13:51:39 daslab-c kernel: hub 2-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb2: bus auto-suspend
May 13 13:51:39 daslab-c kernel: hub 4-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb4: bus auto-suspend
May 13 13:51:39 daslab-c kernel: hub 5-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb5: bus auto-suspend
May 13 13:51:39 daslab-c kernel: hub 6-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb6: bus auto-suspend
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:16.2: suspend root hub
May 13 13:51:39 daslab-c kernel: hub 7-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb7: bus auto-suspend
May 13 13:51:39 daslab-c kernel: hub 1-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb1: bus auto-suspend
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:12.2: suspend root hub
May 13 13:51:39 daslab-c kernel: hub 3-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb3: bus auto-suspend
May 13 13:51:39 daslab-c kernel: ehci_hcd 0000:00:13.2: suspend root hub
May 13 13:51:39 daslab-c kernel: hub 10-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb10: bus auto-suspend
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:14.5: suspend root hub
May 13 13:51:39 daslab-c kernel: hub 11-0:1.0: hub_suspend
May 13 13:51:39 daslab-c kernel: usb usb11: bus auto-suspend
May 13 13:51:39 daslab-c kernel: ohci_hcd 0000:00:16.0: suspend root hub
May 13 13:51:39 daslab-c kernel: PM: Starting manual resume from disk
May 13 13:51:39 daslab-c kernel: PM: Hibernation image partition 8:18 prese=
nt
May 13 13:51:39 daslab-c kernel: PM: Looking for hibernation image.
May 13 13:51:39 daslab-c kernel: PM: Image not found (code -22)
May 13 13:51:39 daslab-c kernel: PM: Hibernation image not present or
could not be loaded.
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb3): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
May 13 13:51:39 daslab-c kernel: ACPI: Power Button [PWRB]
May 13 13:51:39 daslab-c kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
May 13 13:51:39 daslab-c kernel: ACPI: Power Button [PWRF]
May 13 13:51:39 daslab-c kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input3
May 13 13:51:39 daslab-c kernel: ATK0110 ATK0110:00: EC enabled
May 13 13:51:39 daslab-c kernel: SP5100 TCO timer: SP5100 TCO WatchDog
Timer Driver v0.01
May 13 13:51:39 daslab-c kernel: SP5100 TCO timer: mmio address
0xb8fe00 already in use
May 13 13:51:39 daslab-c kernel: piix4_smbus 0000:00:14.0: SMBus Host
Controller at 0xb00, revision 0
May 13 13:51:39 daslab-c kernel: wmi: Mapper loaded
May 13 13:51:39 daslab-c kernel: pci_hotplug: PCI Hot Plug PCI Core version=
: 0.5
May 13 13:51:39 daslab-c kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI l=
oaded
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: PCI INT A -> GSI
16 (level, low) -> IRQ 16
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: setting latency timer =
to 64
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: (unregistered
net_device): unknown MAC, using family default
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: irq 55 for MSI/MSI-X
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: eth0:
RTL8168b/8111b at 0xffffc90011812000, bc:ae:c5:63:15:86, XID 0c200000
IRQ 55
May 13 13:51:39 daslab-c kernel: sr 0:0:0:0: Attached scsi generic sg0 type=
 5
May 13 13:51:39 daslab-c kernel: sd 2:0:0:0: Attached scsi generic sg1 type=
 0
May 13 13:51:39 daslab-c kernel: sd 3:0:0:0: Attached scsi generic sg2 type=
 0
May 13 13:51:39 daslab-c kernel: shpchp 0000:00:01.0: HPC vendor_id
1022 device_id 9602 ss_vid 1022 ss_did 9602
May 13 13:51:39 daslab-c kernel: shpchp 0000:00:01.0: Cannot reserve MMIO r=
egion
May 13 13:51:39 daslab-c kernel: ACPI: acpi_idle registered with cpuidle
May 13 13:51:39 daslab-c kernel: ACPI: processor limited to max C-state 1
May 13 13:51:39 daslab-c kernel: shpchp: Standard Hot Plug PCI
Controller Driver version: 0.4
May 13 13:51:39 daslab-c kernel: MCE: In-kernel MCE decoding enabled.
May 13 13:51:39 daslab-c kernel: HDA Intel 0000:00:14.2: PCI INT A ->
GSI 16 (level, low) -> IRQ 16
May 13 13:51:39 daslab-c kernel: hda_intel: position_fix set to 1 for
device 1043:8410
May 13 13:51:39 daslab-c kernel: [drm] Initialized drm 1.1.0 20060810
May 13 13:51:39 daslab-c kernel: EDAC MC: Ver: 2.1.0 May 13 2011
May 13 13:51:39 daslab-c kernel: usbhid 8-4:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: usbhid 8-4:1.0: usb_probe_interface - got =
id
May 13 13:51:39 daslab-c kernel: input: DELL DELL USB Keyboard as
/devices/pci0000:00/0000:00:12.0/usb8/8-4/8-4:1.0/input/input4
May 13 13:51:39 daslab-c kernel: generic-usb 0003:413C:2005.0001:
input,hidraw0: USB HID v1.10 Keyboard [DELL DELL USB Keyboard] on
usb-0000:00:12.0-4/input0
May 13 13:51:39 daslab-c kernel: usbhid 9-1:1.0: usb_probe_interface
May 13 13:51:39 daslab-c kernel: usbhid 9-1:1.0: usb_probe_interface - got =
id
May 13 13:51:39 daslab-c kernel: input: Logitech USB-PS/2 Optical
Mouse as /devices/pci0000:00/0000:00:13.0/usb9/9-1/9-1:1.0/input/input5
May 13 13:51:39 daslab-c kernel: generic-usb 0003:046D:C03D.0002:
input,hidraw1: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse]
on usb-0000:00:13.0-1/input0
May 13 13:51:39 daslab-c kernel: usbcore: registered new interface driver u=
sbhid
May 13 13:51:39 daslab-c kernel: usbhid: USB HID core driver
May 13 13:51:39 daslab-c kernel: hda_codec: ALC892: BIOS auto-probing.
May 13 13:51:39 daslab-c kernel: input: HDA ATI SB Headphone as
/devices/pci0000:00/0000:00:14.2/sound/card0/input6
May 13 13:51:39 daslab-c kernel: HDA Intel 0000:01:05.1: PCI INT B ->
GSI 19 (level, low) -> IRQ 19
May 13 13:51:39 daslab-c kernel: HDA Intel 0000:01:05.1: setting
latency timer to 64
May 13 13:51:39 daslab-c kernel: AMD64 EDAC driver v3.4.0
May 13 13:51:39 daslab-c kernel: EDAC amd64: DRAM ECC disabled.
May 13 13:51:39 daslab-c kernel: EDAC amd64: ECC disabled in the BIOS
or no ECC capability, module will not load.
May 13 13:51:39 daslab-c kernel: Either enable ECC checking or force
module loading by setting 'ecc_enable_override'.
May 13 13:51:39 daslab-c kernel: (Note that use of the override may
cause unknown side effects.)
May 13 13:51:39 daslab-c kernel: [drm] radeon defaulting to kernel modesett=
ing.
May 13 13:51:39 daslab-c kernel: [drm] radeon kernel modesetting enabled.
May 13 13:51:39 daslab-c kernel: checking generic (d0000000 1000000)
vs hw (d0000000 10000000)
May 13 13:51:39 daslab-c kernel: fb: conflicting fb hw usage
radeondrmfb vs VESA VGA - removing generic driver
May 13 13:51:39 daslab-c kernel: Console: switching to colour dummy device =
80x25
May 13 13:51:39 daslab-c kernel: radeon 0000:01:05.0: PCI INT A -> GSI
18 (level, low) -> IRQ 18
May 13 13:51:39 daslab-c kernel: radeon 0000:01:05.0: setting latency
timer to 64
May 13 13:51:39 daslab-c kernel: [drm] initializing kernel modesetting
(RS880 0x1002:0x9714).
May 13 13:51:39 daslab-c kernel: [drm] register mmio base: 0xFE6F0000
May 13 13:51:39 daslab-c kernel: [drm] register mmio size: 65536
May 13 13:51:39 daslab-c kernel: ATOM BIOS: B43106_DVI
May 13 13:51:39 daslab-c kernel: radeon 0000:01:05.0: VRAM: 368M
0x00000000C0000000 - 0x00000000D6FFFFFF (368M used)
May 13 13:51:39 daslab-c kernel: radeon 0000:01:05.0: GTT: 512M
0x00000000A0000000 - 0x00000000BFFFFFFF
May 13 13:51:39 daslab-c kernel: [drm] Detected VRAM RAM=3D368M, BAR=3D256M
May 13 13:51:39 daslab-c kernel: [drm] RAM width 32bits DDR
May 13 13:51:39 daslab-c kernel: [TTM] Zone  kernel: Available
graphics memory: 1900396 kiB.
May 13 13:51:39 daslab-c kernel: [TTM] Initializing pool allocator.
May 13 13:51:39 daslab-c kernel: [drm] radeon: 368M of VRAM memory ready
May 13 13:51:39 daslab-c kernel: [drm] radeon: 512M of GTT memory ready.
May 13 13:51:39 daslab-c kernel: [drm] Supports vblank timestamp
caching Rev 1 (10.10.2010).
May 13 13:51:39 daslab-c kernel: [drm] Driver supports precise vblank
timestamp query.
May 13 13:51:39 daslab-c kernel: [drm] radeon: irq initialized.
May 13 13:51:39 daslab-c kernel: [drm] GART: num cpu pages 131072, num
gpu pages 131072
May 13 13:51:39 daslab-c kernel: [drm] Loading RS780 Microcode
May 13 13:51:39 daslab-c kernel: radeon 0000:01:05.0: WB enabled
May 13 13:51:39 daslab-c kernel: [drm] ring test succeeded in 1 usecs
May 13 13:51:39 daslab-c kernel: [drm] radeon: ib pool ready.
May 13 13:51:39 daslab-c kernel: [drm] ib test succeeded in 0 usecs
May 13 13:51:39 daslab-c kernel: [drm] Enabling audio support
May 13 13:51:39 daslab-c kernel: [drm] Radeon Display Connectors
May 13 13:51:39 daslab-c kernel: [drm] Connector 0:
May 13 13:51:39 daslab-c kernel: [drm]   VGA
May 13 13:51:39 daslab-c kernel: [drm]   DDC: 0x7e40 0x7e40 0x7e44
0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
May 13 13:51:39 daslab-c kernel: [drm]   Encoders:
May 13 13:51:39 daslab-c kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
May 13 13:51:39 daslab-c kernel: [drm] Connector 1:
May 13 13:51:39 daslab-c kernel: [drm]   DVI-D
May 13 13:51:39 daslab-c kernel: [drm]   HPD3
May 13 13:51:39 daslab-c kernel: [drm]   DDC: 0x7e50 0x7e50 0x7e54
0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
May 13 13:51:39 daslab-c kernel: [drm]   Encoders:
May 13 13:51:39 daslab-c kernel: [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
May 13 13:51:39 daslab-c kernel: [drm] radeon: power management initialized
May 13 13:51:39 daslab-c kernel: [drm] fb mappable at 0xD0141000
May 13 13:51:39 daslab-c kernel: [drm] vram apper at 0xD0000000
May 13 13:51:39 daslab-c kernel: [drm] size 5242880
May 13 13:51:39 daslab-c kernel: [drm] fb depth is 24
May 13 13:51:39 daslab-c kernel: [drm]    pitch is 5120
May 13 13:51:39 daslab-c kernel: fbcon: radeondrmfb (fb0) is primary device
May 13 13:51:39 daslab-c kernel: Console: switching to colour frame
buffer device 160x64
May 13 13:51:39 daslab-c kernel: fb0: radeondrmfb frame buffer device
May 13 13:51:39 daslab-c kernel: drm: registered panic notifier
May 13 13:51:39 daslab-c kernel: [drm] Initialized radeon 2.9.0
20080528 for 0000:01:05.0 on minor 0
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb3): re-mounted. Opts:
errors=3Dremount-ro
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb3): re-mounted. Opts:
errors=3Dremount-ro
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb4): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb5): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb6): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb7): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb8): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: EXT4-fs (sdb9): mounted filesystem
with ordered data mode. Opts: (null)
May 13 13:51:39 daslab-c kernel: Adding 8388604k swap on /dev/sdb2.
Priority:-1 extents:1 across:8388604k
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: eth0: link down
May 13 13:51:39 daslab-c kernel: r8169 0000:05:00.0: eth0: link down
May 13 13:51:43 daslab-c kernel: r8169 0000:05:00.0: eth0: link up
May 13 13:51:54 daslab-c kernel: NET: Registered protocol family 10
May 13 13:52:04 daslab-c kernel: eth0: no IPv6 routers present



@@@ Plugged in keyboard ("on" in power/control)
usb usb5: usb wakeup-resume
usb usb5: usb auto-resume
hub 5-0:1.0: hub_resume
hub 5-0:1.0: port 2: status 0101 change 0001
hub 5-0:1.0: state 7 ports 2 chg 0004 evt 0000
hub 5-0:1.0: port 2, status 0101, change 0000, 12 Mb/s
usb 5-2: new low speed USB device number 3 using xhci_hcd
usb 5-2: skipped 1 descriptor after interface
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: default language 0x0409
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: udev 3, busnum 5, minor =3D 514
usb 5-2: New USB device found, idVendor=3D413c, idProduct=3D2005
usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 5-2: Product: DELL USB Keyboard
usb 5-2: Manufacturer: DELL
usb 5-2: usb_probe_device
usb 5-2: configuration #1 chosen from 1 choice
usb 5-2: ep 0x81 - rounding interval to 64 microframes, ep desc says
80 microframes
usb 5-2: Successful Endpoint Configure command
usb 5-2: adding 5-2:1.0 (config #1, interface 0)
usbhid 5-2:1.0: usb_probe_interface
usbhid 5-2:1.0: usb_probe_interface - got id
input: DELL DELL USB Keyboard as
/devices/pci0000:00/0000:00:15.1/0000:06:00.0/usb5/5-2/5-2:1.0/input/input8
generic-usb 0003:413C:2005.0004: input,hidraw0: USB HID v1.10 Keyboard
[DELL DELL USB Keyboard] on usb-0000:06:00.0-2/input0
drivers/usb/core/inode.c: creating file '003'

@@@ Put "auto" in power/control
@@@ Unplugged keyboard

hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0004
hub 5-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
usb 5-2: USB disconnect, device number 3
usb 5-2: unregistering device
usb 5-2: unregistering interface 5-2:1.0
xhci_hcd 0000:06:00.0: shutdown urb ffff8801179e3f00 ep1in-intr
usb 5-2: usb_disable_device nuking all URBs
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
Fri 13May11 14:04:43 /sys/devices/pci0000:00/0000:00:15.1/0000:06:00.0/power
dschauer@daslab-c $ sudo dmesg -c
hub 5-0:1.0: hub_suspend
usb usb5: bus auto-suspend
xhci_hcd 0000:06:00.0: hcd_pci_runtime_suspend: 0
xhci_hcd 0000:06:00.0: PME# enabled

@@@ Plugged keyboard back in, nothing
@@@ Put "on" in power/control

xhci_hcd 0000:06:00.0: PME# disabled
xhci_hcd 0000:06:00.0: setting latency timer to 64
xhci_hcd 0000:06:00.0: hcd_pci_runtime_resume: 0
usb usb5: usb wakeup-resume
usb usb5: usb auto-resume
hub 5-0:1.0: hub_resume
hub 5-0:1.0: port 2: status 0101 change 0001
hub 5-0:1.0: state 7 ports 2 chg 0004 evt 0000
hub 5-0:1.0: port 2, status 0101, change 0000, 12 Mb/s
usb 5-2: new low speed USB device number 4 using xhci_hcd
usb 5-2: skipped 1 descriptor after interface
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: default language 0x0409
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: udev 4, busnum 5, minor =3D 515
usb 5-2: New USB device found, idVendor=3D413c, idProduct=3D2005
usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 5-2: Product: DELL USB Keyboard
usb 5-2: Manufacturer: DELL
usb 5-2: usb_probe_device
usb 5-2: configuration #1 chosen from 1 choice
usb 5-2: ep 0x81 - rounding interval to 64 microframes, ep desc says
80 microframes
usb 5-2: Successful Endpoint Configure command
usb 5-2: adding 5-2:1.0 (config #1, interface 0)
usbhid 5-2:1.0: usb_probe_interface
usbhid 5-2:1.0: usb_probe_interface - got id
input: DELL DELL USB Keyboard as
/devices/pci0000:00/0000:00:15.1/0000:06:00.0/usb5/5-2/5-2:1.0/input/input9
generic-usb 0003:413C:2005.0005: input,hidraw0: USB HID v1.10 Keyboard
[DELL DELL USB Keyboard] on usb-0000:06:00.0-2/input0
drivers/usb/core/inode.c: creating file '004'

@@@ output of lspci -vv

06:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 03) (prog-if 30 [XHCI])
	Subsystem: Melco Inc Device 0241
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fe9fe000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
		Vector table: BAR=3D0 offset=3D00001000
		PBA: BAR=3D0 offset=3D00001080
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unli=
mited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
<4us, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
	Capabilities: [150 v1] #18
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci-hcd


@@@ That is all

Dwight Schauer
