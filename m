From: Towheed Mohammed <towheedm@yahoo.com>
Subject: CPU Error when resuming from hiberanation.
Date: Fri, 22 Jul 2011 05:46:58 -0700 (PDT)
Message-ID: <1311338818.70861.YahooMailNeo@web113513.mail.gq1.yahoo.com>
Reply-To: Towheed Mohammed <towheedm@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

When I issue the command to hibernate, the image is saved to swap and the m=
achine powers off successfully. Up to this point everything is as =

expected. After resuming, the image is restored but then I get this =

error: CPU1 not responding. However, the boot process continues and I =

get back to my session exactly where I hibernated.=A0 However, as would be =

expected from the error message, I'm only running on one CPU now. CPU0 =

is online, but CPU1 is offline. Trying to online CPU1 manually with:

echo 1 > /sys/devices/system/cpu/cpu1/online
generates a bash write error.

Offlining CPU1 before the hibernate process still gives the CPU1 error when=
 resuming.

Note that suspend-to-RAM works perfectly all the times.


Machine Info:
dmi.bios.date: 09/27/2004
dmi.bios.vendor: Dell Computer Corporation
dmi.bios.version: A07
dmi.board.name: 0M2035
dmi.board.vendor: Dell Computer Corp.
dmi.chassis.type: 6
dmi.chassis.vendor: Dell Computer Corporation
dmi.modalias: dmi:bvnDellComp
uterCorporation:bvrA07:bd09/27/2004:svnDellComputerCorporation:pnDimension8=
300:pvr:rvnDellComputerCorp.:rn0M2035:rvr:cvnDellComputerCorporation:ct6:cv=
r:
dmi.product.name: Dimension 8300
dmi.sys.vendor: Dell Computer Corporation

dmesg output:

[=A0=A0=A0 0.000000] Initializing cgroup subsys cpu
[=A0=A0=A0 0.000000] Linux version 2.6.39.3-i686 (root@GA1A4CH) (gcc versio=
n 4.4.5 (Ubuntu/Linaro 4.4.4-14ubuntu5) ) #1 SMP Sat Jul 16 03:17:56 AST 20=
11
[=A0=A0=A0 0.000000] KERNEL supported cpus:
[=A0=A0=A0 0.000000]=A0=A0 Intel GenuineIntel
[=A0=A0=A0 0.000000] BIOS-provided physical RAM map:
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000000000 - 00000000000a0000 (usa=
ble)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000000f0000 - 0000000000100000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000100000 - 000000003ff74000 (usa=
ble)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACP=
I NVS)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACP=
I data)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000003ff97000 - 0000000040000000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fec00000 - 00000000fec10000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fed20000 - 00000000fed90000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000fee00000 - 00000000fee10000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000ffb00000 - 0000000100000000 (res=
erved)
[=A0=A0=A0 0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[=A0=A0=A0 0.000000] DMI 2.3 present.
[=A0=A0=A0 0.000000] DMI: Dell Computer Corporation Dimension 8300=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /0M2035, BIOS A07 09/27/2004
[=A0=A0=A0 0.000000] e820 update range: 0000000000000000 - 0000000000010000=
 (usable) =3D=3D> (reserved)
[=A0=A0=A0 0.000000] e820 remove range: 00000000000a0000 - 0000000000100000=
 (usable)
[=A0=A0=A0 0.000000] last_pfn =3D 0x3ff74 max_arch_pfn =3D 0x100000
[=A0=A0=A0 0.000000] MTRR default type: uncachable
[=A0=A0=A0 0.000000] MTRR fixed ranges enabled:
[=A0=A0=A0 0.000000]=A0=A0 00000-9FFFF write-back
[=A0=A0=A0 0.000000]=A0=A0 A0000-BFFFF uncachable
[=A0=A0=A0 0.000000]=A0=A0 C0000-FFFFF write-protect
[=A0=A0=A0 0.000000] MTRR variable ranges enabled:
[=A0=A0=A0 0.000000]=A0=A0 0 base 000000000 mask FC0000000 write-back
[=A0=A0=A0 0.000000]=A0=A0 1 disabled
[=A0=A0=A0 0.000000]=A0=A0 2 disabled
[=A0=A0=A0 0.000000]=A0=A0 3 disabled
[=A0=A0=A0 0.000000]=A0=A0 4 disabled
[=A0=A0=A0 0.000000]=A0=A0 5 disabled
[=A0=A0=A0 0.000000]=A0=A0 6 disabled
[=A0=A0=A0 0.000000]=A0=A0 7 disabled
[=A0=A0=A0 0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701=
0600070106
[=A0=A0=A0 0.000000] found SMP MP-table at [b00fe710] fe710
[=A0=A0=A0 0.000000] initial memory mapped : 0 - 00c00000
[=A0=A0=A0 0.000000] Base memory trampoline at [b009b000] 9b000 size 16384
[=A0=A0=A0 0.000000] init_memory_mapping: 0000000000000000-000000003ff74000
[=A0=A0=A0 0.000000]=A0 0000000000 - 0000400000 page 4k
[=A0=A0=A0 0.000000]=A0 0000400000 - 003fc00000 page 2M
[=A0=A0=A0 0.000000]=A0 003fc00000 - 003ff74000 page 4k
[=A0=A0=A0 0.000000] kernel direct mapping tables up to 3ff74000 @ bfb000-c=
00000
[=A0=A0=A0 0.000000] RAMDISK: 2fa39000 - 2ffd7000
[=A0=A0=A0 0.000000] ACPI: RSDP 000feb90 00014 (v00 DELL=A0 )
[=A0=A0=A0 0.000000] ACPI: RSDT 000fd1ca 00034 (v01 DELL=A0=A0=A0 8300=A0=
=A0=A0 00000008 ASL=A0 00000061)
[=A0=A0=A0 0.000000] ACPI: FACP 000fd1fe 00074 (v01 DELL=A0=A0=A0 8300=A0=
=A0=A0 00000008 ASL=A0 00000061)
[=A0=A0=A0 0.000000] ACPI: Override [DSDT-=A0=A0 dt_ex], this is unsafe: ta=
inting kernel
[=A0=A0=A0 0.000000] Disabling lock debugging due to kernel taint
[=A0=A0=A0 0.000000] ACPI: DSDT @ 0xfffc6e75 Table override, replaced with:
[=A0=A0=A0 0.000000] ACPI: DSDT b060c0c0 02331 (v01=A0=A0 DELL=A0=A0=A0 dt_=
ex 00001000 INTL 20090521)
[=A0=A0=A0 0.000000] ACPI: FACS 3ff74000 00040
[=A0=A0=A0 0.000000] ACPI: SSDT fffc93d8 000BA (v01=A0=A0 DELL=A0=A0=A0 st_=
ex 00001000 MSFT 0100000D)
[=A0=A0=A0 0.000000] ACPI: APIC 000fd272 0006C (v01 DELL=A0=A0=A0 8300=A0=
=A0=A0 00000008 ASL=A0 00000061)
[=A0=A0=A0 0.000000] ACPI: BOOT 000fd2de 00028 (v01 DELL=A0=A0=A0 8300=A0=
=A0=A0 00000008 ASL=A0 00000061)
[=A0=A0=A0 0.000000] ACPI: Local APIC address 0xfee00000
[=A0=A0=A0 0.000000] 0MB HIGHMEM available.
[=A0=A0=A0 0.000000] 1023MB LOWMEM available.
[=A0=A0=A0 0.000000]=A0=A0 mapped low ram: 0 - 3ff74000
[=A0=A0=A0 0.000000]=A0=A0 low ram: 0 - 3ff74000
[=A0=A0=A0 0.000000] Zone PFN ranges:
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0 0x00000010 -> 0x00001000
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0 0x00001000 -> 0x0003ff74
[=A0=A0=A0 0.000000]=A0=A0 HighMem=A0 empty
[=A0=A0=A0 0.000000] Movable zone start PFN for each node
[=A0=A0=A0 0.000000] early_node_map[2] active PFN ranges
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000010 -> 0x000000a0
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000100 -> 0x0003ff74
[=A0=A0=A0 0.000000] On node 0 totalpages: 261892
[=A0=A0=A0 0.000000] free_area_init_node: node 0, pgdat b0624980, node_mem_=
map ef773200
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 32 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 0 pages reserved
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 3952 pages, LIFO batch:0
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 2015 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 255893 pages, LIFO batch:31
[=A0=A0=A0 0.000000] Using APIC driver default
[=A0=A0=A0 0.000000] ACPI: PM-Timer IO Port: 0x808
[=A0=A0=A0 0.000000] ACPI: Local APIC address 0xfee00000
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
[=A0=A0=A0 0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
[=A0=A0=A0 0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[=A0=A0=A0 0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, =
GSI 0-23
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl df=
l)
[=A0=A0=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high l=
evel)
[=A0=A0=A0 0.000000] ACPI: IRQ0 used by override.
[=A0=A0=A0 0.000000] ACPI: IRQ2 used by override.
[=A0=A0=A0 0.000000] ACPI: IRQ9 used by override.
[=A0=A0=A0 0.000000] Using ACPI (MADT) for SMP configuration information
[=A0=A0=A0 0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[=A0=A0=A0 0.000000] nr_irqs_gsi: 40
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000=
000000f0000
[=A0=A0=A0 0.000000] PM: Registered nosave memory: 00000000000f0000 - 00000=
00000100000
[=A0=A0=A0 0.000000] Allocating PCI resources starting at 40000000 (gap: 40=
000000:bec00000)
[=A0=A0=A0 0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4=
 nr_node_ids:1
[=A0=A0=A0 0.000000] PERCPU: Embedded 12 pages/cpu @ef000000 s26240 r0 d229=
12 u1048576
[=A0=A0=A0 0.000000] pcpu-alloc: s26240 r0 d22912 u1048576 alloc=3D1*4194304
[=A0=A0=A0 0.000000] pcpu-alloc: [0] 0 1 2 3 =

[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
=A0 Total pages: 259845
[=A0=A0=A0 0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-2.6.39.3-i6=
86 root=3DUUID=3D9eb1494b-dd27-42a8-94ad-e78f31454dc0 ro console=3DttyS0,11=
5200n8 console=3Dtty0 resume=3D/dev/sdb13
[=A0=A0=A0 0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 131072 (order: 7, 524=
288 bytes)
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 65536 (order: 6, 26214=
4 bytes)
[=A0=A0=A0 0.000000] Initializing CPU#0
[=A0=A0=A0 0.000000] allocated 4191808 bytes of page_cgroup
[=A0=A0=A0 0.000000] please try 'cgroup_disable=3Dmemory' option if you don=
't want memory cgroups
[=A0=A0=A0 0.000000] Initializing HighMem for node 0 (00000000:00000000)
[=A0=A0=A0 0.000000] Memory: 1022216k/1048016k available (3634k kernel code=
, 25352k reserved, 1658k data, 476k init, 0k highmem)
[=A0=A0=A0 0.000000] virtual kernel memory layout:
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 fixmap=A0 : 0xfff17000 - 0xfffff000=A0=A0 =
( 928 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 pkmap=A0=A0 : 0xff800000 - 0xffc00000=A0=
=A0 (4096 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vmalloc : 0xf0774000 - 0xff7fe000=A0=A0 ( =
240 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 lowmem=A0 : 0xb0000000 - 0xeff74000=A0=A0 =
(1023 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .init : 0xb062c000 - 0xb06a3000=A0=
=A0 ( 476 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .data : 0xb048cacd - 0xb062b600=A0=
=A0 (1658 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .text : 0xb0100000 - 0xb048cacd=A0=
=A0 (3634 kB)
[=A0=A0=A0 0.000000] Checking if this processor honours the WP bit even in =
supervisor mode...Ok.
[=A0=A0=A0 0.000000] SLUB: Genslabs=3D15, HWalign=3D128, Order=3D0-3, MinOb=
jects=3D0, CPUs=3D4, Nodes=3D1
[=A0=A0=A0 0.000000] Hierarchical RCU implementation.
[=A0=A0=A0 0.000000] =A0=A0=A0 RCU-based detection of stalled CPUs is disab=
led.
[=A0=A0=A0 0.000000] NR_IRQS:512
[=A0=A0=A0 0.000000] CPU 0 irqstacks, hard=3Dee80c000 soft=3Dee80e000
[=A0=A0=A0 0.000000] Console: colour VGA+ 80x25
[=A0=A0=A0 0.000000] console [tty0] enabled
[=A0=A0=A0 0.000000] console [ttyS0] enabled
[=A0=A0=A0 0.000000] Fast TSC calibration using PIT
[=A0=A0=A0 0.000000] Detected 2793.580 MHz processor.
[=A0=A0=A0 0.010003] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 5589.95 BogoMIPS (lpj=3D9311933)
[=A0=A0=A0 0.016669] pid_max: default: 32768 minimum: 301
[=A0=A0=A0 0.020057] Security Framework initialized
[=A0=A0=A0 0.023350] AppArmor: AppArmor initialized
[=A0=A0=A0 0.026687] Mount-cache hash table entries: 512
[=A0=A0=A0 0.030218] Initializing cgroup subsys ns
[=A0=A0=A0 0.033337] ns_cgroup deprecated: consider using the 'clone_childr=
en' flag without the ns_cgroup.
[=A0=A0=A0 0.036668] Initializing cgroup subsys memory
[=A0=A0=A0 0.040011] Initializing cgroup subsys devices
[=A0=A0=A0 0.043335] Initializing cgroup subsys freezer
[=A0=A0=A0 0.046668] Initializing cgroup subsys net_cls
[=A0=A0=A0 0.050001] Initializing cgroup subsys blkio
[=A0=A0=A0 0.053360] CPU: Physical Processor ID: 0
[=A0=A0=A0 0.056667] CPU: Processor Core ID: 0
[=A0=A0=A0 0.060001] mce: CPU supports 4 MCE banks
[=A0=A0=A0 0.063342] CPU0: Thermal monitoring enabled (TM1)
[=A0=A0=A0 0.067172] ACPI: Core revision 20110316
[=A0=A0=A0 0.074332] Enabling APIC mode:=A0 Flat.=A0 Using 1 I/O APICs
[=A0=A0=A0 0.076956] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 p=
in2=3D-1
[=A0=A0=A0 0.115786] CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
[=A0=A0=A0 0.123325] Performance Events: Netburst events, Netburst P4/Xeon =
PMU driver.
[=A0=A0=A0 0.126667] ... version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0
[=A0=A0=A0 0.129994] ... bit width:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
40
[=A0=A0=A0 0.133327] ... generic registers:=A0=A0=A0=A0=A0 18
[=A0=A0=A0 0.136660] ... value mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
0000ffffffffff
[=A0=A0=A0 0.139993] ... max period:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
00007fffffffff
[=A0=A0=A0 0.143326] ... fixed-purpose events:=A0=A0 0
[=A0=A0=A0 0.146660] ... event mask:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00=
0000000003ffff
[=A0=A0=A0 0.153346] CPU 1 irqstacks, hard=3Dee890000 soft=3Dee892000
[=A0=A0=A0 0.153350] Booting Node=A0=A0 0, Processors=A0 #1
[=A0=A0=A0 0.156961] smpboot cpu 1: start_ip =3D 9b000
[=A0=A0=A0 0.013332] Initializing CPU#1
[=A0=A0=A0 0.256672] Brought up 2 CPUs
[=A0=A0=A0 0.259677] Total of 2 processors activated (11177.27 BogoMIPS).
[=A0=A0=A0 0.260277] devtmpfs: initialized
[=A0=A0=A0 0.263352] PM: Adding info for No Bus:platform
[=A0=A0=A0 0.263509] PM: Registering ACPI NVS region at 3ff74000 (8192 byte=
s)
[=A0=A0=A0 0.274226] xor: automatically using best checksumming function: p=
III_sse
[=A0=A0=A0 0.296514]=A0=A0=A0 pIII_sse=A0 :=A0 3643.200 MB/sec
[=A0=A0=A0 0.299984] xor: using function: pIII_sse (3643.200 MB/sec)
[=A0=A0=A0 0.303376] NET: Registered protocol family 16
[=A0=A0=A0 0.310088] PM: Adding info for No Bus:vtcon0
[=A0=A0=A0 0.310135] EISA bus registered
[=A0=A0=A0 0.313331] ACPI: bus type pci registered
[=A0=A0=A0 0.316725] PM: Adding info for No Bus:id
[=A0=A0=A0 0.316817] PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=
=3D2
[=A0=A0=A0 0.323316] PCI: Using configuration type 1 for base access
[=A0=A0=A0 0.331205] PM: Adding info for No Bus:default
[=A0=A0=A0 0.331205] bio: create slab <bio-0> at 0
[=A0=A0=A0 0.390078] raid6: int32x1=A0=A0=A0 459 MB/s
[=A0=A0=A0 0.449994] raid6: int32x2=A0=A0=A0 962 MB/s
[=A0=A0=A0 0.510024] raid6: int32x4=A0=A0=A0 733 MB/s
[=A0=A0=A0 0.570008] raid6: int32x8=A0=A0=A0 543 MB/s
[=A0=A0=A0 0.629989] raid6: mmxx1=A0=A0=A0=A0 2309 MB/s
[=A0=A0=A0 0.689965] raid6: mmxx2=A0=A0=A0=A0 2940 MB/s
[=A0=A0=A0 0.749974] raid6: sse1x1=A0=A0=A0 1361 MB/s
[=A0=A0=A0 0.809951] raid6: sse1x2=A0=A0=A0 2476 MB/s
[=A0=A0=A0 0.869951] raid6: sse2x1=A0=A0=A0 2920 MB/s
[=A0=A0=A0 0.929957] raid6: sse2x2=A0=A0=A0 3152 MB/s
[=A0=A0=A0 0.933276] raid6: using algorithm sse2x2 (3152 MB/s)
[=A0=A0=A0 0.937362] ACPI: EC: Look up EC in DSDT
[=A0=A0=A0 0.950123] ACPI: Interpreter enabled
[=A0=A0=A0 0.953281] ACPI: (supports S0 S1 S3 S4 S5)
[=A0=A0=A0 0.958150] ACPI: Using IOAPIC for interrupt routing
[=A0=A0=A0 0.960007] PM: Adding info for acpi:LNXSYSTM:00
[=A0=A0=A0 0.960047] PM: Adding info for acpi:LNXCPU:00
[=A0=A0=A0 0.960078] PM: Adding info for acpi:LNXCPU:01
[=A0=A0=A0 0.960129] PM: Adding info for acpi:device:00
[=A0=A0=A0 0.960193] PM: Adding info for acpi:PNP0C0C:00
[=A0=A0=A0 0.960246] PM: Adding info for acpi:PNP0C01:00
[=A0=A0=A0 0.962037] PM: Adding info for acpi:PNP0A03:00
[=A0=A0=A0 0.963001] PM: Adding info for acpi:device:01
[=A0=A0=A0 0.963997] PM: Adding info for acpi:device:02
[=A0=A0=A0 0.964955] PM: Adding info for acpi:device:03
[=A0=A0=A0 0.965918] PM: Adding info for acpi:device:04
[=A0=A0=A0 0.969617] PM: Adding info for acpi:device:05
[=A0=A0=A0 0.969676] PM: Adding info for acpi:device:06
[=A0=A0=A0 0.969725] PM: Adding info for acpi:PNP0200:00
[=A0=A0=A0 0.969777] PM: Adding info for acpi:PNP0C04:00
[=A0=A0=A0 0.969831] PM: Adding info for acpi:PNP0000:00
[=A0=A0=A0 0.969882] PM: Adding info for acpi:PNP0800:00
[=A0=A0=A0 0.969944] PM: Adding info for acpi:PNP0B00:00
[=A0=A0=A0 0.969996] PM: Adding info for acpi:PNP0100:00
[=A0=A0=A0 0.974078] PM: Adding info for acpi:PNP0501:00
[=A0=A0=A0 0.975145] PM: Adding info for acpi:PNP0401:00
[=A0=A0=A0 0.975205] PM: Adding info for acpi:PNP0C01:01
[=A0=A0=A0 0.975452] PM: Adding info for acpi:PNP0C0F:00
[=A0=A0=A0 0.975549] PM: Adding info for acpi:PNP0C0F:01
[=A0=A0=A0 0.975646] PM: Adding info for acpi:PNP0C0F:02
[=A0=A0=A0 0.975744] PM: Adding info for acpi:PNP0C0F:03
[=A0=A0=A0 0.975849] PM: Adding info for acpi:PNP0C0F:04
[=A0=A0=A0 0.975958] PM: Adding info for acpi:PNP0C0F:05
[=A0=A0=A0 0.976068] PM: Adding info for acpi:PNP0C0F:06
[=A0=A0=A0 0.976167] PM: Adding info for acpi:PNP0C0F:07
[=A0=A0=A0 0.976221] PM: Adding info for acpi:device:07
[=A0=A0=A0 0.976295] PM: Adding info for acpi:LNXPWRBN:00
[=A0=A0=A0 0.983279] HEST: Table not found.
[=A0=A0=A0 0.986610] PCI: Ignoring host bridge windows from ACPI; if necess=
ary, use "pci=3Duse_crs" and report a bug
[=A0=A0=A0 0.993577] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[=A0=A0=A0 0.996628] PM: Adding info for No Bus:pci0000:00
[=A0=A0=A0 0.996644] PM: Adding info for No Bus:0000:00
[=A0=A0=A0 1.000763] pci_root PNP0A03:00: host bridge window [io=A0 0x0000-=
0x0cf7] (ignored)
[=A0=A0=A0 1.000768] pci_root PNP0A03:00: host bridge window [io=A0 0x0d00-=
0xffff] (ignored)
[=A0=A0=A0 1.000772] pci_root PNP0A03:00: host bridge window [mem 0x000a000=
0-0x000bffff] (ignored)
[=A0=A0=A0 1.000775] pci_root PNP0A03:00: host bridge window [mem 0x8000000=
0-0xfebfffff] (ignored)
[=A0=A0=A0 1.000791] pci 0000:00:00.0: [8086:2578] type 0 class 0x000600
[=A0=A0=A0 1.000796] pci 0000:00:00.0: Enabling MCH 'Overflow' Device
[=A0=A0=A0 1.003279] pci 0000:00:00.0: reg 10: [mem 0xe8000000-0xefffffff p=
ref]
[=A0=A0=A0 1.003320] pci 0000:00:00.0: rpm_resume flags 0x0
[=A0=A0=A0 1.003323] pci 0000:00:00.0: rpm_resume returns -11
[=A0=A0=A0 1.003342] pci 0000:00:01.0: [8086:2579] type 1 class 0x000604
[=A0=A0=A0 1.003370] pci 0000:00:01.0: rpm_resume flags 0x0
[=A0=A0=A0 1.003373] pci 0000:00:01.0: rpm_resume returns -11
[=A0=A0=A0 1.003388] pci 0000:00:06.0: [8086:257e] type 0 class 0x000880
[=A0=A0=A0 1.003400] pci 0000:00:06.0: reg 10: [mem 0xfecf0000-0xfecf0fff]
[=A0=A0=A0 1.003443] pci 0000:00:06.0: rpm_resume flags 0x0
[=A0=A0=A0 1.003446] pci 0000:00:06.0: rpm_resume returns -11
[=A0=A0=A0 1.003484] pci 0000:00:1d.0: [8086:24d2] type 0 class 0x000c03
[=A0=A0=A0 1.003530] pci 0000:00:1d.0: reg 20: [io=A0 0xff80-0xff9f]
[=A0=A0=A0 1.003554] pci 0000:00:1d.0: rpm_resume flags 0x0
[=A0=A0=A0 1.003557] pci 0000:00:1d.0: rpm_resume returns -11
[=A0=A0=A0 1.003570] pci 0000:00:1d.1: [8086:24d4] type 0 class 0x000c03
[=A0=A0=A0 1.003616] pci 0000:00:1d.1: reg 20: [io=A0 0xff60-0xff7f]
[=A0=A0=A0 1.003640] pci 0000:00:1d.1: rpm_resume flags 0x0
[=A0=A0=A0 1.003643] pci 0000:00:1d.1: rpm_resume returns -11
[=A0=A0=A0 1.003655] pci 0000:00:1d.2: [8086:24d7] type 0 class 0x000c03
[=A0=A0=A0 1.003701] pci 0000:00:1d.2: reg 20: [io=A0 0xff40-0xff5f]
[=A0=A0=A0 1.003726] pci 0000:00:1d.2: rpm_resume flags 0x0
[=A0=A0=A0 1.003729] pci 0000:00:1d.2: rpm_resume returns -11
[=A0=A0=A0 1.003741] pci 0000:00:1d.3: [8086:24de] type 0 class 0x000c03
[=A0=A0=A0 1.003787] pci 0000:00:1d.3: reg 20: [io=A0 0xff20-0xff3f]
[=A0=A0=A0 1.003811] pci 0000:00:1d.3: rpm_resume flags 0x0
[=A0=A0=A0 1.003814] pci 0000:00:1d.3: rpm_resume returns -11
[=A0=A0=A0 1.003838] pci 0000:00:1d.7: [8086:24dd] type 0 class 0x000c03
[=A0=A0=A0 1.003861] pci 0000:00:1d.7: reg 10: [mem 0xffa80800-0xffa80bff]
[=A0=A0=A0 1.003938] pci 0000:00:1d.7: rpm_resume flags 0x0
[=A0=A0=A0 1.003941] pci 0000:00:1d.7: rpm_resume returns -11
[=A0=A0=A0 1.003950] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 1.003956] pci 0000:00:1d.7: PME# disabled
[=A0=A0=A0 1.003974] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[=A0=A0=A0 1.004008] pci 0000:00:1e.0: rpm_resume flags 0x0
[=A0=A0=A0 1.004011] pci 0000:00:1e.0: rpm_resume returns -11
[=A0=A0=A0 1.004024] pci 0000:00:1f.0: [8086:24d0] type 0 class 0x000601
[=A0=A0=A0 1.004088] pci 0000:00:1f.0: HPET at 0xfed00000
[=A0=A0=A0 1.004099] pci 0000:00:1f.0: rpm_resume flags 0x0
[=A0=A0=A0 1.004102] pci 0000:00:1f.0: rpm_resume returns -11
[=A0=A0=A0 1.004114] pci 0000:00:1f.1: [8086:24db] type 0 class 0x000101
[=A0=A0=A0 1.004129] pci 0000:00:1f.1: reg 10: [io=A0 0x01f0-0x01f7]
[=A0=A0=A0 1.004140] pci 0000:00:1f.1: reg 14: [io=A0 0x03f4-0x03f7]
[=A0=A0=A0 1.004151] pci 0000:00:1f.1: reg 18: [io=A0 0x0170-0x0177]
[=A0=A0=A0 1.004162] pci 0000:00:1f.1: reg 1c: [io=A0 0x0374-0x0377]
[=A0=A0=A0 1.004173] pci 0000:00:1f.1: reg 20: [io=A0 0xffa0-0xffaf]
[=A0=A0=A0 1.004184] pci 0000:00:1f.1: reg 24: [mem 0xfebffc00-0xfebfffff]
[=A0=A0=A0 1.004202] pci 0000:00:1f.1: rpm_resume flags 0x0
[=A0=A0=A0 1.004205] pci 0000:00:1f.1: rpm_resume returns -11
[=A0=A0=A0 1.004217] pci 0000:00:1f.2: [8086:24d1] type 0 class 0x000101
[=A0=A0=A0 1.004230] pci 0000:00:1f.2: reg 10: [io=A0 0xfe00-0xfe07]
[=A0=A0=A0 1.004240] pci 0000:00:1f.2: reg 14: [io=A0 0xfe10-0xfe13]
[=A0=A0=A0 1.004250] pci 0000:00:1f.2: reg 18: [io=A0 0xfe20-0xfe27]
[=A0=A0=A0 1.004260] pci 0000:00:1f.2: reg 1c: [io=A0 0xfe30-0xfe33]
[=A0=A0=A0 1.004269] pci 0000:00:1f.2: reg 20: [io=A0 0xfea0-0xfeaf]
[=A0=A0=A0 1.004292] pci 0000:00:1f.2: rpm_resume flags 0x0
[=A0=A0=A0 1.004295] pci 0000:00:1f.2: rpm_resume returns -11
[=A0=A0=A0 1.004307] pci 0000:00:1f.3: [8086:24d3] type 0 class 0x000c05
[=A0=A0=A0 1.004353] pci 0000:00:1f.3: reg 20: [io=A0 0xeda0-0xedbf]
[=A0=A0=A0 1.004377] pci 0000:00:1f.3: rpm_resume flags 0x0
[=A0=A0=A0 1.004380] pci 0000:00:1f.3: rpm_resume returns -11
[=A0=A0=A0 1.004400] pci 0000:00:1f.5: [8086:24d5] type 0 class 0x000401
[=A0=A0=A0 1.004417] pci 0000:00:1f.5: reg 10: [io=A0 0xee00-0xeeff]
[=A0=A0=A0 1.004427] pci 0000:00:1f.5: reg 14: [io=A0 0xedc0-0xedff]
[=A0=A0=A0 1.004438] pci 0000:00:1f.5: reg 18: [mem 0xfebffa00-0xfebffbff]
[=A0=A0=A0 1.004448] pci 0000:00:1f.5: reg 1c: [mem 0xfebff900-0xfebff9ff]
[=A0=A0=A0 1.004483] pci 0000:00:1f.5: rpm_resume flags 0x0
[=A0=A0=A0 1.004486] pci 0000:00:1f.5: rpm_resume returns -11
[=A0=A0=A0 1.004493] pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 1.004498] pci 0000:00:1f.5: PME# disabled
[=A0=A0=A0 1.004526] pci 0000:01:00.0: [10de:0322] type 0 class 0x000300
[=A0=A0=A0 1.004542] pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfdffffff]
[=A0=A0=A0 1.004551] pci 0000:01:00.0: reg 14: [mem 0xf0000000-0xf7ffffff p=
ref]
[=A0=A0=A0 1.004581] pci 0000:01:00.0: reg 30: [mem 0xfea00000-0xfea1ffff p=
ref]
[=A0=A0=A0 1.004597] pci 0000:01:00.0: rpm_resume flags 0x0
[=A0=A0=A0 1.004600] pci 0000:01:00.0: rpm_resume returns -11
[=A0=A0=A0 1.004641] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[=A0=A0=A0 1.006607] pci 0000:00:01.0:=A0=A0 bridge window [io=A0 0xf000-0x=
0000] (disabled)
[=A0=A0=A0 1.006613] pci 0000:00:01.0:=A0=A0 bridge window [mem 0xfd000000-=
0xfeafffff]
[=A0=A0=A0 1.006618] pci 0000:00:01.0:=A0=A0 bridge window [mem 0xf0000000-=
0xf7ffffff pref]
[=A0=A0=A0 1.006654] pci 0000:02:08.0: [8086:1050] type 0 class 0x000200
[=A0=A0=A0 1.006671] pci 0000:02:08.0: reg 10: [mem 0xfcfff000-0xfcffffff]
[=A0=A0=A0 1.006681] pci 0000:02:08.0: reg 14: [io=A0 0xdf40-0xdf7f]
[=A0=A0=A0 1.006732] pci 0000:02:08.0: rpm_resume flags 0x0
[=A0=A0=A0 1.006735] pci 0000:02:08.0: rpm_resume returns -11
[=A0=A0=A0 1.006742] pci 0000:02:08.0: supports D1 D2
[=A0=A0=A0 1.006745] pci 0000:02:08.0: PME# supported from D0 D1 D2 D3hot D=
3cold
[=A0=A0=A0 1.006750] pci 0000:02:08.0: PME# disabled
[=A0=A0=A0 1.006785] pci 0000:00:1e.0: PCI bridge to [bus 02-02] (subtracti=
ve decode)
[=A0=A0=A0 1.009941] pci 0000:00:1e.0:=A0=A0 bridge window [io=A0 0xd000-0x=
dfff]
[=A0=A0=A0 1.009947] pci 0000:00:1e.0:=A0=A0 bridge window [mem 0xfcf00000-=
0xfcffffff]
[=A0=A0=A0 1.009953] pci 0000:00:1e.0:=A0=A0 bridge window [mem 0xfff00000-=
0x000fffff pref] (disabled)
[=A0=A0=A0 1.009957] pci 0000:00:1e.0:=A0=A0 bridge window [io=A0 0x0000-0x=
ffff] (subtractive decode)
[=A0=A0=A0 1.009960] pci 0000:00:1e.0:=A0=A0 bridge window [mem 0x00000000-=
0xffffffff] (subtractive decode)
[=A0=A0=A0 1.009974] pci_bus 0000:00: on NUMA node 0
[=A0=A0=A0 1.009979] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[=A0=A0=A0 1.010215] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PR=
T]
[=A0=A0=A0 1.016319] PM: Adding info for pci:0000:00:00.0
[=A0=A0=A0 1.021698] PM: Adding info for pci:0000:00:01.0
[=A0=A0=A0 1.027084] PM: Adding info for pci:0000:00:06.0
[=A0=A0=A0 1.032566] PM: Adding info for pci:0000:00:1d.0
[=A0=A0=A0 1.037957] PM: Adding info for pci:0000:00:1d.1
[=A0=A0=A0 1.043331] PM: Adding info for pci:0000:00:1d.2
[=A0=A0=A0 1.048794] PM: Adding info for pci:0000:00:1d.3
[=A0=A0=A0 1.054178] PM: Adding info for pci:0000:00:1d.7
[=A0=A0=A0 1.059428] PM: Adding info for pci:0000:00:1e.0
[=A0=A0=A0 1.064804] PM: Adding info for pci:0000:00:1f.0
[=A0=A0=A0 1.070188] PM: Adding info for pci:0000:00:1f.1
[=A0=A0=A0 1.075663] PM: Adding info for pci:0000:00:1f.2
[=A0=A0=A0 1.081039] PM: Adding info for pci:0000:00:1f.3
[=A0=A0=A0 1.086320] PM: Adding info for pci:0000:00:1f.5
[=A0=A0=A0 1.086356] PM: Adding info for pci:0000:01:00.0
[=A0=A0=A0 1.086384] PM: Adding info for No Bus:0000:01
[=A0=A0=A0 1.086424] PM: Adding info for pci:0000:02:08.0
[=A0=A0=A0 1.086449] PM: Adding info for No Bus:0000:02
[=A0=A0=A0 1.086685] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *=
11 12 15)
[=A0=A0=A0 1.093988] ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 =
11 12 15)
[=A0=A0=A0 1.101778] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 =
11 12 15)
[=A0=A0=A0 1.109394] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 =
11 12 15)
[=A0=A0=A0 1.113555] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 =
11 12 15)
[=A0=A0=A0 1.120958] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 1=
1 12 15) *0, disabled.
[=A0=A0=A0 1.129992] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 1=
1 12 15) *0, disabled.
[=A0=A0=A0 1.138625] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 =
11 12 15)
[=A0=A0=A0 1.142968] PM: Adding info for No Bus:vga_arbiter
[=A0=A0=A0 1.142999] vgaarb: device added: PCI:0000:01:00.0,decodes=3Dio+me=
m,owns=3Dio+mem,locks=3Dnone
[=A0=A0=A0 1.143264] vgaarb: loaded
[=A0=A0=A0 1.146726] SCSI subsystem initialized
[=A0=A0=A0 1.149962] libata version 3.00 loaded.
[=A0=A0=A0 1.150005] usbcore: registered new interface driver usbfs
[=A0=A0=A0 1.153278] usbcore: registered new interface driver hub
[=A0=A0=A0 1.156613] usbcore: registered new device driver usb
[=A0=A0=A0 1.159987] wmi: Mapper loaded
[=A0=A0=A0 1.163261] PCI: Using ACPI for IRQ routing
[=A0=A0=A0 1.166596] PCI: pci_cache_line_size set to 64 bytes
[=A0=A0=A0 1.166677] reserve RAM buffer: 000000003ff74000 - 000000003ffffff=
f =

[=A0=A0=A0 1.166766] PM: Adding info for No Bus:lo
[=A0=A0=A0 1.166818] NetLabel: Initializing
[=A0=A0=A0 1.169928] NetLabel:=A0 domain hash size =3D 128
[=A0=A0=A0 1.173259] NetLabel:=A0 protocols =3D UNLABELED CIPSOv4
[=A0=A0=A0 1.176606] NetLabel:=A0 unlabeled traffic allowed by default
[=A0=A0=A0 1.180017] hpet clockevent registered
[=A0=A0=A0 1.180022] HPET: 3 timers in total, 0 timers will be used for per=
-cpu timer
[=A0=A0=A0 1.183263] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[=A0=A0=A0 1.187640] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[=A0=A0=A0 1.196610] Switching to clocksource hpet
[=A0=A0=A0 1.202368] Switched to NOHz mode on CPU #0
[=A0=A0=A0 1.202497] Switched to NOHz mode on CPU #1
[=A0=A0=A0 1.218956] AppArmor: AppArmor Filesystem Enabled
[=A0=A0=A0 1.223754] pnp: PnP ACPI init
[=A0=A0=A0 1.226866] PM: Adding info for No Bus:pnp0
[=A0=A0=A0 1.226871] ACPI: bus type pnp registered
[=A0=A0=A0 1.235285] pnp 00:00: [mem 0x00000000-0x0009ffff]
[=A0=A0=A0 1.235290] pnp 00:00: [mem 0x00100000-0x00ffffff]
[=A0=A0=A0 1.235293] pnp 00:00: [mem 0x01000000-0x3ff73fff]
[=A0=A0=A0 1.235296] pnp 00:00: [mem 0x000c0000-0x000fffff]
[=A0=A0=A0 1.235299] pnp 00:00: [mem 0xfec00000-0xfec0ffff]
[=A0=A0=A0 1.235303] pnp 00:00: [mem 0xfee00000-0xfee0ffff]
[=A0=A0=A0 1.235306] pnp 00:00: [mem 0xfed20000-0xfed8ffff]
[=A0=A0=A0 1.235309] pnp 00:00: [mem 0xfecf0000-0xfecf0fff]
[=A0=A0=A0 1.235312] pnp 00:00: [mem 0xffb00000-0xffbfffff]
[=A0=A0=A0 1.235315] pnp 00:00: [mem 0xffc00000-0xffffffff]
[=A0=A0=A0 1.235374] PM: Adding info for pnp:00:00
[=A0=A0=A0 1.235390] system 00:00: [mem 0x00000000-0x0009ffff] could not be=
 reserved
[=A0=A0=A0 1.242399] system 00:00: [mem 0x00100000-0x00ffffff] could not be=
 reserved
[=A0=A0=A0 1.249405] system 00:00: [mem 0x01000000-0x3ff73fff] could not be=
 reserved
[=A0=A0=A0 1.256407] system 00:00: [mem 0x000c0000-0x000fffff] could not be=
 reserved
[=A0=A0=A0 1.263409] system 00:00: [mem 0xfec00000-0xfec0ffff] could not be=
 reserved
[=A0=A0=A0 1.270410] system 00:00: [mem 0xfee00000-0xfee0ffff] has been res=
erved
[=A0=A0=A0 1.277066] system 00:00: [mem 0xfed20000-0xfed8ffff] has been res=
erved
[=A0=A0=A0 1.283721] system 00:00: [mem 0xfecf0000-0xfecf0fff] has been res=
erved
[=A0=A0=A0 1.290376] system 00:00: [mem 0xffb00000-0xffbfffff] has been res=
erved
[=A0=A0=A0 1.297031] system 00:00: [mem 0xffc00000-0xffffffff] has been res=
erved
[=A0=A0=A0 1.303688] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (=
active)
[=A0=A0=A0 1.304241] pnp 00:01: [bus 00-ff]
[=A0=A0=A0 1.304245] pnp 00:01: [io=A0 0x0cf8-0x0cff]
[=A0=A0=A0 1.304249] pnp 00:01: [io=A0 0x0000-0x0cf7 window]
[=A0=A0=A0 1.304252] pnp 00:01: [io=A0 0x0d00-0xffff window]
[=A0=A0=A0 1.304255] pnp 00:01: [mem 0x000a0000-0x000bffff window]
[=A0=A0=A0 1.304259] pnp 00:01: [mem 0x80000000-0xfebfffff window]
[=A0=A0=A0 1.304299] PM: Adding info for pnp:00:01
[=A0=A0=A0 1.304309] pnp 00:01: Plug and Play ACPI device, IDs PNP0a03 (act=
ive)
[=A0=A0=A0 1.306113] pnp 00:02: [io=A0 0x0080-0x009f]
[=A0=A0=A0 1.306117] pnp 00:02: [io=A0 0x0000-0x001f]
[=A0=A0=A0 1.306120] pnp 00:02: [io=A0 0x00c0-0x00df]
[=A0=A0=A0 1.306124] pnp 00:02: [dma 4]
[=A0=A0=A0 1.306150] PM: Adding info for pnp:00:02
[=A0=A0=A0 1.306160] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (act=
ive)
[=A0=A0=A0 1.306186] pnp 00:03: [io=A0 0x00f0-0x00ff]
[=A0=A0=A0 1.306199] pnp 00:03: [irq 13]
[=A0=A0=A0 1.306226] PM: Adding info for pnp:00:03
[=A0=A0=A0 1.306236] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (act=
ive)
[=A0=A0=A0 1.306264] pnp 00:04: [io=A0 0x0061]
[=A0=A0=A0 1.306292] PM: Adding info for pnp:00:04
[=A0=A0=A0 1.306302] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (act=
ive)
[=A0=A0=A0 1.306328] pnp 00:05: [io=A0 0x0070-0x007f]
[=A0=A0=A0 1.306334] pnp 00:05: [irq 8]
[=A0=A0=A0 1.306361] PM: Adding info for pnp:00:05
[=A0=A0=A0 1.306371] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (act=
ive)
[=A0=A0=A0 1.308437] pnp 00:06: [io=A0 0x03f8-0x03ff]
[=A0=A0=A0 1.308444] pnp 00:06: [irq 4]
[=A0=A0=A0 1.308516] PM: Adding info for pnp:00:06
[=A0=A0=A0 1.308527] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (act=
ive)
[=A0=A0=A0 1.309300] pnp 00:07: [io=A0 0x0378-0x037f]
[=A0=A0=A0 1.309304] pnp 00:07: [io=A0 0x0778-0x077f]
[=A0=A0=A0 1.309310] pnp 00:07: [irq 7]
[=A0=A0=A0 1.309313] pnp 00:07: [dma 0 disabled]
[=A0=A0=A0 1.309442] PM: Adding info for pnp:00:07
[=A0=A0=A0 1.309452] pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (act=
ive)
[=A0=A0=A0 1.310369] pnp 00:08: [io=A0 0x0060]
[=A0=A0=A0 1.310372] pnp 00:08: [io=A0 0x0064]
[=A0=A0=A0 1.310375] pnp 00:08: [io=A0 0x0062-0x0063]
[=A0=A0=A0 1.310378] pnp 00:08: [io=A0 0x0065-0x006f]
[=A0=A0=A0 1.310381] pnp 00:08: [io=A0 0x00e0-0x00ef]
[=A0=A0=A0 1.310383] pnp 00:08: [io=A0 0x0800-0x085f]
[=A0=A0=A0 1.310386] pnp 00:08: [io=A0 0x0c00-0x0c7f]
[=A0=A0=A0 1.310389] pnp 00:08: [io=A0 0x0860-0x08ff]
[=A0=A0=A0 1.310446] PM: Adding info for pnp:00:08
[=A0=A0=A0 1.310460] system 00:08: [io=A0 0x0800-0x085f] has been reserved
[=A0=A0=A0 1.316424] system 00:08: [io=A0 0x0c00-0x0c7f] has been reserved
[=A0=A0=A0 1.322386] system 00:08: [io=A0 0x0860-0x08ff] has been reserved
[=A0=A0=A0 1.328348] system 00:08: Plug and Play ACPI device, IDs PNP0c01 (=
active)
[=A0=A0=A0 1.328561] pnp: PnP ACPI: found 9 devices
[=A0=A0=A0 1.332700] ACPI: ACPI bus type pnp unregistered
[=A0=A0=A0 1.337361] PnPBIOS: Disabled by ACPI PNP
[=A0=A0=A0 1.341471] PM: Adding info for No Bus:mem
[=A0=A0=A0 1.341502] PM: Adding info for No Bus:null
[=A0=A0=A0 1.341534] PM: Adding info for No Bus:port
[=A0=A0=A0 1.341560] PM: Adding info for No Bus:zero
[=A0=A0=A0 1.341589] PM: Adding info for No Bus:full
[=A0=A0=A0 1.341616] PM: Adding info for No Bus:random
[=A0=A0=A0 1.341645] PM: Adding info for No Bus:urandom
[=A0=A0=A0 1.341672] PM: Adding info for No Bus:kmsg
[=A0=A0=A0 1.341701] PM: Adding info for No Bus:tty
[=A0=A0=A0 1.341729] PM: Adding info for No Bus:console
[=A0=A0=A0 1.341758] PM: Adding info for No Bus:tty0
[=A0=A0=A0 1.341796] PM: Adding info for No Bus:vcs
[=A0=A0=A0 1.341822] PM: Adding info for No Bus:vcsa
[=A0=A0=A0 1.341848] PM: Adding info for No Bus:vcs1
[=A0=A0=A0 1.341875] PM: Adding info for No Bus:vcsa1
[=A0=A0=A0 1.341907] PM: Adding info for No Bus:tty1
[=A0=A0=A0 1.341933] PM: Adding info for No Bus:tty2
[=A0=A0=A0 1.341966] PM: Adding info for No Bus:tty3
[=A0=A0=A0 1.341996] PM: Adding info for No Bus:tty4
[=A0=A0=A0 1.342022] PM: Adding info for No Bus:tty5
[=A0=A0=A0 1.342049] PM: Adding info for No Bus:tty6
[=A0=A0=A0 1.342084] PM: Adding info for No Bus:tty7
[=A0=A0=A0 1.342113] PM: Adding info for No Bus:tty8
[=A0=A0=A0 1.342139] PM: Adding info for No Bus:tty9
[=A0=A0=A0 1.342166] PM: Adding info for No Bus:tty10
[=A0=A0=A0 1.342196] PM: Adding info for No Bus:tty11
[=A0=A0=A0 1.342223] PM: Adding info for No Bus:tty12
[=A0=A0=A0 1.342250] PM: Adding info for No Bus:tty13
[=A0=A0=A0 1.342277] PM: Adding info for No Bus:tty14
[=A0=A0=A0 1.342307] PM: Adding info for No Bus:tty15
[=A0=A0=A0 1.342335] PM: Adding info for No Bus:tty16
[=A0=A0=A0 1.342362] PM: Adding info for No Bus:tty17
[=A0=A0=A0 1.342393] PM: Adding info for No Bus:tty18
[=A0=A0=A0 1.342420] PM: Adding info for No Bus:tty19
[=A0=A0=A0 1.342448] PM: Adding info for No Bus:tty20
[=A0=A0=A0 1.342483] PM: Adding info for No Bus:tty21
[=A0=A0=A0 1.342511] PM: Adding info for No Bus:tty22
[=A0=A0=A0 1.342543] PM: Adding info for No Bus:tty23
[=A0=A0=A0 1.342574] PM: Adding info for No Bus:tty24
[=A0=A0=A0 1.342605] PM: Adding info for No Bus:tty25
[=A0=A0=A0 1.342635] PM: Adding info for No Bus:tty26
[=A0=A0=A0 1.342664] PM: Adding info for No Bus:tty27
[=A0=A0=A0 1.342693] PM: Adding info for No Bus:tty28
[=A0=A0=A0 1.342722] PM: Adding info for No Bus:tty29
[=A0=A0=A0 1.342752] PM: Adding info for No Bus:tty30
[=A0=A0=A0 1.342781] PM: Adding info for No Bus:tty31
[=A0=A0=A0 1.342813] PM: Adding info for No Bus:tty32
[=A0=A0=A0 1.342844] PM: Adding info for No Bus:tty33
[=A0=A0=A0 1.342874] PM: Adding info for No Bus:tty34
[=A0=A0=A0 1.342903] PM: Adding info for No Bus:tty35
[=A0=A0=A0 1.342934] PM: Adding info for No Bus:tty36
[=A0=A0=A0 1.342964] PM: Adding info for No Bus:tty37
[=A0=A0=A0 1.342993] PM: Adding info for No Bus:tty38
[=A0=A0=A0 1.343033] PM: Adding info for No Bus:tty39
[=A0=A0=A0 1.343064] PM: Adding info for No Bus:tty40
[=A0=A0=A0 1.343094] PM: Adding info for No Bus:tty41
[=A0=A0=A0 1.343126] PM: Adding info for No Bus:tty42
[=A0=A0=A0 1.343156] PM: Adding info for No Bus:tty43
[=A0=A0=A0 1.343186] PM: Adding info for No Bus:tty44
[=A0=A0=A0 1.343216] PM: Adding info for No Bus:tty45
[=A0=A0=A0 1.343251] PM: Adding info for No Bus:tty46
[=A0=A0=A0 1.343281] PM: Adding info for No Bus:tty47
[=A0=A0=A0 1.343312] PM: Adding info for No Bus:tty48
[=A0=A0=A0 1.343357] PM: Adding info for No Bus:tty49
[=A0=A0=A0 1.343388] PM: Adding info for No Bus:tty50
[=A0=A0=A0 1.343421] PM: Adding info for No Bus:tty51
[=A0=A0=A0 1.343453] PM: Adding info for No Bus:tty52
[=A0=A0=A0 1.343486] PM: Adding info for No Bus:tty53
[=A0=A0=A0 1.343518] PM: Adding info for No Bus:tty54
[=A0=A0=A0 1.343553] PM: Adding info for No Bus:tty55
[=A0=A0=A0 1.343585] PM: Adding info for No Bus:tty56
[=A0=A0=A0 1.343624] PM: Adding info for No Bus:tty57
[=A0=A0=A0 1.343656] PM: Adding info for No Bus:tty58
[=A0=A0=A0 1.343690] PM: Adding info for No Bus:tty59
[=A0=A0=A0 1.343724] PM: Adding info for No Bus:tty60
[=A0=A0=A0 1.343756] PM: Adding info for No Bus:tty61
[=A0=A0=A0 1.343789] PM: Adding info for No Bus:tty62
[=A0=A0=A0 1.343823] PM: Adding info for No Bus:tty63
[=A0=A0=A0 1.378464] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[=A0=A0=A0 1.383736] pci 0000:00:01.0:=A0=A0 bridge window [io=A0 disabled]
[=A0=A0=A0 1.389440] pci 0000:00:01.0:=A0=A0 bridge window [mem 0xfd000000-=
0xfeafffff]
[=A0=A0=A0 1.396269] pci 0000:00:01.0:=A0=A0 bridge window [mem 0xf0000000-=
0xf7ffffff pref]
[=A0=A0=A0 1.403545] pci 0000:00:1e.0: PCI bridge to [bus 02-02]
[=A0=A0=A0 1.408811] pci 0000:00:1e.0:=A0=A0 bridge window [io=A0 0xd000-0x=
dfff]
[=A0=A0=A0 1.414947] pci 0000:00:1e.0:=A0=A0 bridge window [mem 0xfcf00000-=
0xfcffffff]
[=A0=A0=A0 1.421777] pci 0000:00:1e.0:=A0=A0 bridge window [mem pref disabl=
ed]
[=A0=A0=A0 1.427927] pci 0000:00:1e.0: setting latency timer to 64
[=A0=A0=A0 1.427932] pci_bus 0000:00: resource 0 [io=A0 0x0000-0xffff]
[=A0=A0=A0 1.427936] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffff]
[=A0=A0=A0 1.427939] pci_bus 0000:01: resource 1 [mem 0xfd000000-0xfeafffff]
[=A0=A0=A0 1.427943] pci_bus 0000:01: resource 2 [mem 0xf0000000-0xf7ffffff=
 pref]
[=A0=A0=A0 1.427947] pci_bus 0000:02: resource 0 [io=A0 0xd000-0xdfff]
[=A0=A0=A0 1.427950] pci_bus 0000:02: resource 1 [mem 0xfcf00000-0xfcffffff]
[=A0=A0=A0 1.427953] pci_bus 0000:02: resource 4 [io=A0 0x0000-0xffff]
[=A0=A0=A0 1.427956] pci_bus 0000:02: resource 5 [mem 0x00000000-0xffffffff]
[=A0=A0=A0 1.428012] NET: Registered protocol family 2
[=A0=A0=A0 1.432513] IP route cache hash table entries: 32768 (order: 5, 13=
1072 bytes)
[=A0=A0=A0 1.440043] TCP established hash table entries: 131072 (order: 8, =
1048576 bytes)
[=A0=A0=A0 1.448026] TCP bind hash table entries: 65536 (order: 7, 524288 b=
ytes)
[=A0=A0=A0 1.454996] TCP: Hash tables configured (established 131072 bind 6=
5536)
[=A0=A0=A0 1.461666] TCP reno registered
[=A0=A0=A0 1.464857] UDP hash table entries: 512 (order: 2, 16384 bytes)
[=A0=A0=A0 1.470829] UDP-Lite hash table entries: 512 (order: 2, 16384 byte=
s)
[=A0=A0=A0 1.477410] NET: Registered protocol family 1
[=A0=A0=A0 1.481939] pci 0000:01:00.0: Boot video device
[=A0=A0=A0 1.481954] pci 0000:02:08.0: Firmware left e100 interrupts enable=
d; disabling
[=A0=A0=A0 1.489231] PCI: CLS 64 bytes, default 64
[=A0=A0=A0 1.489302] Trying to unpack rootfs image as initramfs...
[=A0=A0=A0 1.686889] Freeing initrd memory: 5752k freed
[=A0=A0=A0 1.695958] Simple Boot Flag value 0x87 read from CMOS RAM was inv=
alid
[=A0=A0=A0 1.702544] Simple Boot Flag at 0x7a set to 0x1
[=A0=A0=A0 1.707258] PM: Adding info for No Bus:mcelog
[=A0=A0=A0 1.707332] PM: Adding info for No Bus:msr0
[=A0=A0=A0 1.707372] PM: Adding info for No Bus:msr1
[=A0=A0=A0 1.707413] PM: Adding info for No Bus:cpu0
[=A0=A0=A0 1.707444] PM: Adding info for No Bus:cpu1
[=A0=A0=A0 1.707469] PM: Adding info for platform:microcode
[=A0=A0=A0 1.707486] microcode: CPU0 sig=3D0xf29, pf=3D0x4, revision=3D0x21
[=A0=A0=A0 1.713221] microcode: CPU1 sig=3D0xf29, pf=3D0x4, revision=3D0x21
[=A0=A0=A0 1.718940] PM: Adding info for No Bus:microcode
[=A0=A0=A0 1.718952] microcode: Microcode Update Driver: v2.00 <tigran@aiva=
zian.fsnet.co.uk>, Peter Oruba
[=A0=A0=A0 1.727861] PM: Adding info for No Bus:snapshot
[=A0=A0=A0 1.727919] audit: initializing netlink socket (disabled)
[=A0=A0=A0 1.733372] type=3D2000 audit(1311318596.733:1): initialized
[=A0=A0=A0 1.738956] PM: Adding info for event_source:cpu
[=A0=A0=A0 1.738978] PM: Adding info for event_source:breakpoint
[=A0=A0=A0 1.738996] PM: Adding info for event_source:tracepoint
[=A0=A0=A0 1.739015] PM: Adding info for event_source:software
[=A0=A0=A0 1.739211] HugeTLB registered 4 MB page size, pre-allocated 0 pag=
es
[=A0=A0=A0 1.749071] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[=A0=A0=A0 1.755159] NTFS driver 2.1.30 [Flags: R/W].
[=A0=A0=A0 1.759593] fuse init (API version 7.16)
[=A0=A0=A0 1.763695] PM: Adding info for No Bus:fuse
[=A0=A0=A0 1.763761] msgmni has been set to 2007
[=A0=A0=A0 1.767924] async_tx: api initialized (async)
[=A0=A0=A0 1.772410] Block layer SCSI generic (bsg) driver version 0.4 load=
ed (major 253)
[=A0=A0=A0 1.779900] io scheduler noop registered
[=A0=A0=A0 1.783869] io scheduler deadline registered
[=A0=A0=A0 1.788206] io scheduler cfq registered (default)
[=A0=A0=A0 1.793042] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[=A0=A0=A0 1.798656] acpiphp: ACPI Hot Plug PCI Controller Driver version: =
0.5
[=A0=A0=A0 1.805300] PM: Adding info for No Bus:fbcon
[=A0=A0=A0 1.805326] PM: Adding info for platform:vesafb.0
[=A0=A0=A0 1.805359] PM: Removing info for platform:vesafb.0
[=A0=A0=A0 1.805424] PM: Adding info for No Bus:input0
[=A0=A0=A0 1.805464] input: Power Button as /devices/LNXSYSTM:00/device:00/=
PNP0C0C:00/input/input0
[=A0=A0=A0 1.813706] ACPI: Power Button [VBTN]
[=A0=A0=A0 1.817462] PM: Adding info for No Bus:input1
[=A0=A0=A0 1.817499] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:0=
0/input/input1
[=A0=A0=A0 1.824947] ACPI: Power Button [PWRF]
[=A0=A0=A0 1.828762] ACPI: acpi_idle registered with cpuidle
[=A0=A0=A0 1.828816] PM: Adding info for No Bus:cooling_device0
[=A0=A0=A0 1.828858] PM: Adding info for No Bus:cooling_device1
[=A0=A0=A0 1.838952] ERST: Table is not found!
[=A0=A0=A0 1.842679] PM: Adding info for No Bus:pnp1
[=A0=A0=A0 1.842683] isapnp: Scanning for PnP cards...
[=A0=A0=A0 2.203558] isapnp: No Plug & Play device found
[=A0=A0=A0 2.208203] PM: Adding info for No Bus:ptmx
[=A0=A0=A0 2.208216] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[=A0=A0=A0 2.214542] PM: Adding info for platform:serial8250
[=A0=A0=A0 2.234980] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[=A0=A0=A0 2.241056] PM: Adding info for No Bus:ttyS0
[=A0=A0=A0 2.283383] PM: Adding info for No Bus:ttyS1
[=A0=A0=A0 2.336783] PM: Removing info for No Bus:ttyS0
[=A0=A0=A0 2.357256] 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[=A0=A0=A0 2.362897] PM: Adding info for No Bus:ttyS0
[=A0=A0=A0 2.410117] PM: Adding info for No Bus:ttyprintk
[=A0=A0=A0 2.410149] PM: Adding info for No Bus:hpet
[=A0=A0=A0 2.410204] PM: Adding info for No Bus:nvram
[=A0=A0=A0 2.410219] Non-volatile memory driver v1.3
[=A0=A0=A0 2.414447] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180=
 seconds, margin is 60 seconds).
[=A0=A0=A0 2.423452] Hangcheck: Using getrawmonotonic().
[=A0=A0=A0 2.428050] PM: Adding info for No Bus:isa
[=A0=A0=A0 2.428471] PM: Adding info for No Bus:1:0
[=A0=A0=A0 2.428520] PM: Adding info for No Bus:ram0
[=A0=A0=A0 2.428565] PM: Adding info for No Bus:1:1
[=A0=A0=A0 2.428600] PM: Adding info for No Bus:ram1
[=A0=A0=A0 2.428646] PM: Adding info for No Bus:1:2
[=A0=A0=A0 2.428681] PM: Adding info for No Bus:ram2
[=A0=A0=A0 2.428727] PM: Adding info for No Bus:1:3
[=A0=A0=A0 2.428762] PM: Adding info for No Bus:ram3
[=A0=A0=A0 2.428806] PM: Adding info for No Bus:1:4
[=A0=A0=A0 2.428844] PM: Adding info for No Bus:ram4
[=A0=A0=A0 2.428889] PM: Adding info for No Bus:1:5
[=A0=A0=A0 2.428924] PM: Adding info for No Bus:ram5
[=A0=A0=A0 2.428975] PM: Adding info for No Bus:1:6
[=A0=A0=A0 2.429011] PM: Adding info for No Bus:ram6
[=A0=A0=A0 2.429058] PM: Adding info for No Bus:1:7
[=A0=A0=A0 2.429099] PM: Adding info for No Bus:ram7
[=A0=A0=A0 2.429144] PM: Adding info for No Bus:1:8
[=A0=A0=A0 2.429184] PM: Adding info for No Bus:ram8
[=A0=A0=A0 2.429229] PM: Adding info for No Bus:1:9
[=A0=A0=A0 2.429266] PM: Adding info for No Bus:ram9
[=A0=A0=A0 2.429313] PM: Adding info for No Bus:1:10
[=A0=A0=A0 2.429355] PM: Adding info for No Bus:ram10
[=A0=A0=A0 2.429401] PM: Adding info for No Bus:1:11
[=A0=A0=A0 2.429440] PM: Adding info for No Bus:ram11
[=A0=A0=A0 2.429486] PM: Adding info for No Bus:1:12
[=A0=A0=A0 2.429524] PM: Adding info for No Bus:ram12
[=A0=A0=A0 2.429573] PM: Adding info for No Bus:1:13
[=A0=A0=A0 2.429610] PM: Adding info for No Bus:ram13
[=A0=A0=A0 2.429663] PM: Adding info for No Bus:1:14
[=A0=A0=A0 2.429701] PM: Adding info for No Bus:ram14
[=A0=A0=A0 2.429748] PM: Adding info for No Bus:1:15
[=A0=A0=A0 2.429786] PM: Adding info for No Bus:ram15
[=A0=A0=A0 2.429820] brd: module loaded
[=A0=A0=A0 2.433128] PM: Adding info for No Bus:7:0
[=A0=A0=A0 2.433167] PM: Adding info for No Bus:loop0
[=A0=A0=A0 2.433214] PM: Adding info for No Bus:7:1
[=A0=A0=A0 2.433250] PM: Adding info for No Bus:loop1
[=A0=A0=A0 2.433294] PM: Adding info for No Bus:7:2
[=A0=A0=A0 2.433345] PM: Adding info for No Bus:loop2
[=A0=A0=A0 2.433390] PM: Adding info for No Bus:7:3
[=A0=A0=A0 2.433425] PM: Adding info for No Bus:loop3
[=A0=A0=A0 2.433472] PM: Adding info for No Bus:7:4
[=A0=A0=A0 2.433511] PM: Adding info for No Bus:loop4
[=A0=A0=A0 2.433558] PM: Adding info for No Bus:7:5
[=A0=A0=A0 2.433594] PM: Adding info for No Bus:loop5
[=A0=A0=A0 2.433639] PM: Adding info for No Bus:7:6
[=A0=A0=A0 2.433676] PM: Adding info for No Bus:loop6
[=A0=A0=A0 2.433722] PM: Adding info for No Bus:7:7
[=A0=A0=A0 2.433758] PM: Adding info for No Bus:loop7
[=A0=A0=A0 2.433794] loop: module loaded
[=A0=A0=A0 2.437037] PM: Adding info for No Bus:pktcdvd
[=A0=A0=A0 2.437128] ata_piix 0000:00:1f.1: version 2.13
[=A0=A0=A0 2.437150] ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low=
) -> IRQ 18
[=A0=A0=A0 2.444374] ata_piix 0000:00:1f.1: setting latency timer to 64
[=A0=A0=A0 2.444434] PM: Adding info for No Bus:ata1
[=A0=A0=A0 2.444449] PM: Adding info for No Bus:ata1
[=A0=A0=A0 2.444472] PM: Adding info for No Bus:link1
[=A0=A0=A0 2.444486] PM: Adding info for No Bus:link1
[=A0=A0=A0 2.444509] PM: Adding info for No Bus:dev1.0
[=A0=A0=A0 2.444526] PM: Adding info for No Bus:dev1.0
[=A0=A0=A0 2.444555] PM: Adding info for No Bus:dev1.1
[=A0=A0=A0 2.444570] PM: Adding info for No Bus:dev1.1
[=A0=A0=A0 2.444598] PM: Adding info for No Bus:ata2
[=A0=A0=A0 2.444613] PM: Adding info for No Bus:ata2
[=A0=A0=A0 2.444634] PM: Adding info for No Bus:link2
[=A0=A0=A0 2.444650] PM: Adding info for No Bus:link2
[=A0=A0=A0 2.444672] PM: Adding info for No Bus:dev2.0
[=A0=A0=A0 2.444687] PM: Adding info for No Bus:dev2.0
[=A0=A0=A0 2.444713] PM: Adding info for No Bus:dev2.1
[=A0=A0=A0 2.444728] PM: Adding info for No Bus:dev2.1
[=A0=A0=A0 2.444808] scsi0 : ata_piix
[=A0=A0=A0 2.447781] PM: Adding info for scsi:host0
[=A0=A0=A0 2.447821] PM: Adding info for No Bus:host0
[=A0=A0=A0 2.447873] scsi1 : ata_piix
[=A0=A0=A0 2.450810] PM: Adding info for scsi:host1
[=A0=A0=A0 2.450847] PM: Adding info for No Bus:host1
[=A0=A0=A0 2.450860] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff=
a0 irq 14
[=A0=A0=A0 2.457864] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff=
a8 irq 15
[=A0=A0=A0 2.464913] ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low=
) -> IRQ 18
[=A0=A0=A0 2.464995] scsi host1: rpm_resume flags 0x4
[=A0=A0=A0 2.464999] scsi host1: rpm_resume returns 1
[=A0=A0=A0 2.465132] scsi host0: rpm_resume flags 0x4
[=A0=A0=A0 2.465136] scsi host0: rpm_resume returns 1
[=A0=A0=A0 2.472102] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[=A0=A0=A0 2.477545] ata_piix 0000:00:1f.2: setting latency timer to 64
[=A0=A0=A0 2.477592] PM: Adding info for No Bus:ata3
[=A0=A0=A0 2.477609] PM: Adding info for No Bus:ata3
[=A0=A0=A0 2.477633] PM: Adding info for No Bus:link3
[=A0=A0=A0 2.477648] PM: Adding info for No Bus:link3
[=A0=A0=A0 2.477671] PM: Adding info for No Bus:dev3.0
[=A0=A0=A0 2.477687] PM: Adding info for No Bus:dev3.0
[=A0=A0=A0 2.477716] PM: Adding info for No Bus:ata4
[=A0=A0=A0 2.477732] PM: Adding info for No Bus:ata4
[=A0=A0=A0 2.477753] PM: Adding info for No Bus:link4
[=A0=A0=A0 2.477769] PM: Adding info for No Bus:link4
[=A0=A0=A0 2.477791] PM: Adding info for No Bus:dev4.0
[=A0=A0=A0 2.477807] PM: Adding info for No Bus:dev4.0
[=A0=A0=A0 2.477873] scsi2 : ata_piix
[=A0=A0=A0 2.480813] PM: Adding info for scsi:host2
[=A0=A0=A0 2.480858] PM: Adding info for No Bus:host2
[=A0=A0=A0 2.480912] scsi3 : ata_piix
[=A0=A0=A0 2.483853] PM: Adding info for scsi:host3
[=A0=A0=A0 2.483893] PM: Adding info for No Bus:host3
[=A0=A0=A0 2.483904] ata3: SATA max UDMA/133 cmd 0xfe00 ctl 0xfe10 bmdma 0x=
fea0 irq 18
[=A0=A0=A0 2.491081] ata4: SATA max UDMA/133 cmd 0xfe20 ctl 0xfe30 bmdma 0x=
fea8 irq 18
[=A0=A0=A0 2.498309] scsi host2: rpm_resume flags 0x4
[=A0=A0=A0 2.498315] scsi host2: rpm_resume returns 1
[=A0=A0=A0 2.498346] scsi host3: rpm_resume flags 0x4
[=A0=A0=A0 2.498350] scsi host3: rpm_resume returns 1
[=A0=A0=A0 2.498425] VMware vmxnet3 virtual NIC driver - version 1.0.25.0-k=
-NAPI
[=A0=A0=A0 2.505103] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[=A0=A0=A0 2.511236] e100: Copyright(c) 1999-2006 Intel Corporation
[=A0=A0=A0 2.516800] e100 0000:02:08.0: PCI INT A -> GSI 20 (level, low) ->=
 IRQ 20
[=A0=A0=A0 2.560015] e100 0000:02:08.0: PME# disabled
[=A0=A0=A0 2.560084] PM: Adding info for No Bus:eth0
[=A0=A0=A0 2.560309] e100 0000:02:08.0: eth0: addr 0xfcfff000, irq 20, MAC =
addr 00:07:e9:47:08:38
[=A0=A0=A0 2.568558] PM: Adding info for No Bus:usbmon0
[=A0=A0=A0 2.568570] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver
[=A0=A0=A0 2.575161] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low=
) -> IRQ 23
[=A0=A0=A0 2.582347] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[=A0=A0=A0 2.582352] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[=A0=A0=A0 2.587654] PM: Adding info for No Bus:usbmon1
[=A0=A0=A0 2.587666] ehci_hcd 0000:00:1d.7: new USB bus registered, assigne=
d bus number 1
[=A0=A0=A0 2.610040] ehci_hcd 0000:00:1d.7: debug port 1
[=A0=A0=A0 2.618497] ehci_hcd 0000:00:1d.7: cache line size of 64 is not su=
pported
[=A0=A0=A0 2.618519] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa80800
[=A0=A0=A0 2.625369] ata1.00: HPA detected: current 156250000, native 15630=
1488
[=A0=A0=A0 2.631959] ata1.00: ATA-5: WDC WD800BB-75CAA0, 16.06V16, max UDMA=
/100
[=A0=A0=A0 2.636693] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[=A0=A0=A0 2.636710] usb usb1: rpm_resume flags 0x0
[=A0=A0=A0 2.636714] usb usb1: rpm_resume returns 1
[=A0=A0=A0 2.636735] usb usb1: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002
[=A0=A0=A0 2.636740] usb usb1: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 2.636743] usb usb1: Product: EHCI Host Controller
[=A0=A0=A0 2.636746] usb usb1: Manufacturer: Linux 2.6.39.3-i686 ehci_hcd
[=A0=A0=A0 2.636749] usb usb1: SerialNumber: 0000:00:1d.7
[=A0=A0=A0 2.636866] PM: Adding info for usb:usb1
[=A0=A0=A0 2.636904] usb usb1: rpm_resume flags 0x4
[=A0=A0=A0 2.636907] usb usb1: rpm_resume returns 1
[=A0=A0=A0 2.636934] PM: Adding info for usb:1-0:1.0
[=A0=A0=A0 2.636957] usb usb1: rpm_resume flags 0x4
[=A0=A0=A0 2.636960] usb usb1: rpm_resume returns 1
[=A0=A0=A0 2.636964] hub 1-0:1.0: USB hub found
[=A0=A0=A0 2.636971] hub 1-0:1.0: 8 ports detected
[=A0=A0=A0 2.637032] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 2.637059] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 2.637064] usb usb1: rpm_suspend flags 0xc
[=A0=A0=A0 2.637067] usb usb1: rpm_suspend returns -16
[=A0=A0=A0 2.637122] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[=A0=A0=A0 2.637146] uhci_hcd: USB Universal Host Controller Interface driv=
er
[=A0=A0=A0 2.637207] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low=
) -> IRQ 16
[=A0=A0=A0 2.637220] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[=A0=A0=A0 2.637224] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[=A0=A0=A0 2.637293] PM: Adding info for No Bus:usbmon2
[=A0=A0=A0 2.637308] uhci_hcd 0000:00:1d.0: new USB bus registered, assigne=
d bus number 2
[=A0=A0=A0 2.714287] ata1.00: 156250000 sectors, multi 8: LBA =

[=A0=A0=A0 2.719731] Refined TSC clocksource calibration: 2792.999 MHz.
[=A0=A0=A0 2.719752] ata2.00: ATAPI: HL-DT-STDVD-ROM GDR8162B, 0015, max UD=
MA/33
[=A0=A0=A0 2.719765] ata2.01: ATAPI: TEAC DVD+RW DV-W58E, D.0N, max UDMA/33
[=A0=A0=A0 2.738480] Switching to clocksource tsc
[=A0=A0=A0 2.740405] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
[=A0=A0=A0 2.740445] usb usb2: rpm_resume flags 0x0
[=A0=A0=A0 2.740448] usb usb2: rpm_resume returns 1
[=A0=A0=A0 2.740471] usb usb2: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
[=A0=A0=A0 2.740475] usb usb2: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 2.740478] usb usb2: Product: UHCI Host Controller
[=A0=A0=A0 2.740481] usb usb2: Manufacturer: Linux 2.6.39.3-i686 uhci_hcd
[=A0=A0=A0 2.740484] usb usb2: SerialNumber: 0000:00:1d.0
[=A0=A0=A0 2.740594] PM: Adding info for usb:usb2
[=A0=A0=A0 2.740631] usb usb2: rpm_resume flags 0x4
[=A0=A0=A0 2.740634] usb usb2: rpm_resume returns 1
[=A0=A0=A0 2.740661] PM: Adding info for usb:2-0:1.0
[=A0=A0=A0 2.740686] usb usb2: rpm_resume flags 0x4
[=A0=A0=A0 2.740689] usb usb2: rpm_resume returns 1
[=A0=A0=A0 2.740693] hub 2-0:1.0: USB hub found
[=A0=A0=A0 2.740700] hub 2-0:1.0: 2 ports detected
[=A0=A0=A0 2.740734] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 2.740757] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 2.740762] usb usb2: rpm_suspend flags 0xc
[=A0=A0=A0 2.740765] usb usb2: rpm_suspend returns -16
[=A0=A0=A0 2.740821] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low=
) -> IRQ 19
[=A0=A0=A0 2.740833] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[=A0=A0=A0 2.740837] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[=A0=A0=A0 2.740902] PM: Adding info for No Bus:usbmon3
[=A0=A0=A0 2.740917] uhci_hcd 0000:00:1d.1: new USB bus registered, assigne=
d bus number 3
[=A0=A0=A0 2.805613] ata3.00: ATA-8: ST3500418AS, CC35, max UDMA/133
[=A0=A0=A0 2.811239] ata3.00: 976773168 sectors, multi 8: LBA48 NCQ (depth =
0/32)
[=A0=A0=A0 2.817995] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
[=A0=A0=A0 2.818149] ata4.00: ATA-8: ST3500418AS, CC38, max UDMA/133
[=A0=A0=A0 2.818154] ata4.00: 976773168 sectors, multi 8: LBA48 NCQ (depth =
0/32)
[=A0=A0=A0 2.824673] ata1.00: configured for UDMA/100
[=A0=A0=A0 2.824690] scsi host0: rpm_suspend flags 0x0
[=A0=A0=A0 2.824694] scsi host0: rpm_suspend returns 0
[=A0=A0=A0 2.824709] scsi target0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.824713] scsi target0:0:0: rpm_resume returns -11
[=A0=A0=A0 2.824716] scsi host0: rpm_resume flags 0x4
[=A0=A0=A0 2.824720] ata_piix 0000:00:1f.1: rpm_resume flags 0x0
[=A0=A0=A0 2.824723] ata_piix 0000:00:1f.1: rpm_resume returns 1
[=A0=A0=A0 2.824727] scsi host0: rpm_resume returns 0
[=A0=A0=A0 2.824881] scsi 0:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 WDC WD800BB-75CA 16.0 PQ: 0 ANSI: 5
[=A0=A0=A0 2.824903] PM: Adding info for scsi:target0:0:0
[=A0=A0=A0 2.824920] scsi target0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.824924] scsi target0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.824927] scsi 0:0:0:0: rpm_resume flags 0x0
[=A0=A0=A0 2.824930] scsi 0:0:0:0: rpm_resume returns -11
[=A0=A0=A0 2.824934] scsi 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.824937] scsi 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.824967] PM: Adding info for scsi:0:0:0:0
[=A0=A0=A0 2.825028] PM: Adding info for No Bus:0:0:0:0
[=A0=A0=A0 2.825066] PM: Adding info for No Bus:0:0:0:0
[=A0=A0=A0 2.825160] PM: Adding info for No Bus:0:0:0:0
[=A0=A0=A0 2.825245] sd 0:0:0:0: [sda] 156250000 512-byte logical blocks: (=
80.0 GB/74.5 GiB)
[=A0=A0=A0 2.825333] sd 0:0:0:0: [sda] Write Protect is off
[=A0=A0=A0 2.825338] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[=A0=A0=A0 2.825378] sd 0:0:0:0: [sda] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
[=A0=A0=A0 2.825410] PM: Adding info for No Bus:8:0
[=A0=A0=A0 2.825478] PM: Adding info for No Bus:sda
[=A0=A0=A0 2.825500] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.825503] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.830403] ata4.00: configured for UDMA/133
[=A0=A0=A0 2.830419] scsi host3: rpm_suspend flags 0x0
[=A0=A0=A0 2.830424] scsi host3: rpm_suspend returns 0
[=A0=A0=A0 2.874448] usb usb3: rpm_resume flags 0x0
[=A0=A0=A0 2.874453] usb usb3: rpm_resume returns 1
[=A0=A0=A0 2.874480] usb usb3: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
[=A0=A0=A0 2.874616] ata2.00: configured for UDMA/33
[=A0=A0=A0 2.874789] hub 1-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 2.874793] hub 1-0:1.0: rpm_resume returns 1
[=A0=A0=A0 2.885602] usb usb3: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 2.885997] ata2.01: configured for UDMA/33
[=A0=A0=A0 2.897138] usb usb3: Product: UHCI Host Controller
[=A0=A0=A0 2.897199] ata3.00: configured for UDMA/133
[=A0=A0=A0 2.897212] scsi host2: rpm_suspend flags 0x0
[=A0=A0=A0 2.897217] scsi host2: rpm_suspend returns 0
[=A0=A0=A0 2.906387] usb usb3: Manufacturer: Linux 2.6.39.3-i686 uhci_hcd
[=A0=A0=A0 2.912477] usb usb3: SerialNumber: 0000:00:1d.1
[=A0=A0=A0 2.917277] PM: Adding info for usb:usb3
[=A0=A0=A0 2.917312] usb usb3: rpm_resume flags 0x4
[=A0=A0=A0 2.917316] usb usb3: rpm_resume returns 1
[=A0=A0=A0 2.917356] scsi host1: rpm_suspend flags 0x0
[=A0=A0=A0 2.917360] scsi target1:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.917364] scsi target1:0:0: rpm_resume returns -11
[=A0=A0=A0 2.917369] scsi host1: rpm_suspend returns -11
[=A0=A0=A0 2.917373] scsi host1: rpm_resume flags 0x4
[=A0=A0=A0 2.917378] scsi host1: rpm_resume returns 1
[=A0=A0=A0 2.917491] PM: Adding info for usb:3-0:1.0
[=A0=A0=A0 2.917511] usb usb3: rpm_resume flags 0x4
[=A0=A0=A0 2.917515] usb usb3: rpm_resume returns 1
[=A0=A0=A0 2.917518] hub 3-0:1.0: USB hub found
[=A0=A0=A0 2.921315] hub 3-0:1.0: 2 ports detected
[=A0=A0=A0 2.925391] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 2.925415] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 2.925419] usb usb3: rpm_suspend flags 0xc
[=A0=A0=A0 2.925422] usb usb3: rpm_suspend returns -16
[=A0=A0=A0 2.925469] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low=
) -> IRQ 18
[=A0=A0=A0 2.932694]=A0 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
[=A0=A0=A0 2.932711] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[=A0=A0=A0 2.932720] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[=A0=A0=A0 2.932812] PM: Adding info for No Bus:usbmon4
[=A0=A0=A0 2.932831] uhci_hcd 0000:00:1d.2: new USB bus registered, assigne=
d bus number 4
[=A0=A0=A0 2.936557] scsi 1:0:0:0: CD-ROM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
HL-DT-ST DVD-ROM GDR8162B 0015 PQ: 0 ANSI: 5
[=A0=A0=A0 2.936586] PM: Adding info for scsi:target1:0:0
[=A0=A0=A0 2.936603] scsi target1:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.936607] scsi target1:0:0: rpm_resume returns 1
[=A0=A0=A0 2.936610] scsi 1:0:0:0: rpm_resume flags 0x0
[=A0=A0=A0 2.936613] scsi 1:0:0:0: rpm_resume returns -11
[=A0=A0=A0 2.936617] scsi 1:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.936620] scsi 1:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.936651] PM: Adding info for scsi:1:0:0:0
[=A0=A0=A0 2.936698] PM: Adding info for No Bus:1:0:0:0
[=A0=A0=A0 2.936759] PM: Adding info for No Bus:1:0:0:0
[=A0=A0=A0 2.936785] scsi target1:0:1: rpm_resume flags 0x4
[=A0=A0=A0 2.936789] scsi target1:0:1: rpm_resume returns -11
[=A0=A0=A0 2.936792] scsi host1: rpm_resume flags 0x4
[=A0=A0=A0 2.936795] scsi host1: rpm_resume returns 1
[=A0=A0=A0 2.938225] scsi 1:0:1:0: CD-ROM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
TEAC=A0=A0=A0=A0 DVD+RW DV-W58E=A0=A0 D.0N PQ: 0 ANSI: 5
[=A0=A0=A0 2.938252] PM: Adding info for scsi:target1:0:1
[=A0=A0=A0 2.938269] scsi target1:0:1: rpm_resume flags 0x4
[=A0=A0=A0 2.938273] scsi target1:0:1: rpm_resume returns 1
[=A0=A0=A0 2.938276] scsi 1:0:1:0: rpm_resume flags 0x0
[=A0=A0=A0 2.938279] scsi 1:0:1:0: rpm_resume returns -11
[=A0=A0=A0 2.938283] scsi 1:0:1:0: rpm_resume flags 0x4
[=A0=A0=A0 2.938286] scsi 1:0:1:0: rpm_resume returns 1
[=A0=A0=A0 2.938316] PM: Adding info for scsi:1:0:1:0
[=A0=A0=A0 2.938350] PM: Adding info for No Bus:1:0:1:0
[=A0=A0=A0 2.938406] PM: Adding info for No Bus:1:0:1:0
[=A0=A0=A0 2.938448] scsi target2:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.938452] scsi target2:0:0: rpm_resume returns -11
[=A0=A0=A0 2.938455] scsi host2: rpm_resume flags 0x4
[=A0=A0=A0 2.938459] ata_piix 0000:00:1f.2: rpm_resume flags 0x0
[=A0=A0=A0 2.938462] ata_piix 0000:00:1f.2: rpm_resume returns 1
[=A0=A0=A0 2.938466] scsi host2: rpm_resume returns 0
[=A0=A0=A0 2.938583] scsi 2:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 ST3500418AS=A0=A0=A0=A0=A0 CC35 PQ: 0 ANSI: 5
[=A0=A0=A0 2.938603] PM: Adding info for scsi:target2:0:0
[=A0=A0=A0 2.938617] scsi target2:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.938620] scsi target2:0:0: rpm_resume returns 1
[=A0=A0=A0 2.938624] scsi 2:0:0:0: rpm_resume flags 0x0
[=A0=A0=A0 2.938627] scsi 2:0:0:0: rpm_resume returns -11
[=A0=A0=A0 2.938630] scsi 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.938633] scsi 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.938667] PM: Adding info for scsi:2:0:0:0
[=A0=A0=A0 2.938723] PM: Adding info for No Bus:2:0:0:0
[=A0=A0=A0 2.938759] PM: Adding info for No Bus:2:0:0:0
[=A0=A0=A0 2.938819] PM: Adding info for No Bus:2:0:0:0
[=A0=A0=A0 2.938864] scsi target3:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.938868] scsi target3:0:0: rpm_resume returns -11
[=A0=A0=A0 2.938871] scsi host3: rpm_resume flags 0x4
[=A0=A0=A0 2.938874] ata_piix 0000:00:1f.2: rpm_resume flags 0x0
[=A0=A0=A0 2.938878] ata_piix 0000:00:1f.2: rpm_resume returns 1
[=A0=A0=A0 2.938881] scsi host3: rpm_resume returns 0
[=A0=A0=A0 2.938998] scsi 3:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 ST3500418AS=A0=A0=A0=A0=A0 CC38 PQ: 0 ANSI: 5
[=A0=A0=A0 2.939019] PM: Adding info for scsi:target3:0:0
[=A0=A0=A0 2.939033] scsi target3:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.939036] scsi target3:0:0: rpm_resume returns 1
[=A0=A0=A0 2.939039] scsi 3:0:0:0: rpm_resume flags 0x0
[=A0=A0=A0 2.939042] scsi 3:0:0:0: rpm_resume returns -11
[=A0=A0=A0 2.939046] scsi 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.939049] scsi 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.939082] PM: Adding info for scsi:3:0:0:0
[=A0=A0=A0 2.939136] PM: Adding info for No Bus:3:0:0:0
[=A0=A0=A0 2.939167] PM: Adding info for No Bus:3:0:0:0
[=A0=A0=A0 2.939223] PM: Adding info for No Bus:3:0:0:0
[=A0=A0=A0 2.939317] sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (=
500 GB/465 GiB)
[=A0=A0=A0 2.939346] sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks: (=
500 GB/465 GiB)
[=A0=A0=A0 2.939493] sd 3:0:0:0: [sdc] Write Protect is off
[=A0=A0=A0 2.939498] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[=A0=A0=A0 2.939519] sd 2:0:0:0: [sdb] Write Protect is off
[=A0=A0=A0 2.939523] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[=A0=A0=A0 2.939576] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
[=A0=A0=A0 2.939610] PM: Adding info for No Bus:8:32
[=A0=A0=A0 2.939682] PM: Adding info for No Bus:sdc
[=A0=A0=A0 2.939706] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.939710] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 2.939742] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
[=A0=A0=A0 2.939776] PM: Adding info for No Bus:8:16
[=A0=A0=A0 2.939834] PM: Adding info for No Bus:sdb
[=A0=A0=A0 2.939849] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 2.939853] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.029062] PM: Adding info for No Bus:sda1
[=A0=A0=A0 3.029109] PM: Adding info for No Bus:sda2
[=A0=A0=A0 3.029149] PM: Adding info for No Bus:sda5
[=A0=A0=A0 3.029186] PM: Adding info for No Bus:sda6
[=A0=A0=A0 3.029223] PM: Adding info for No Bus:sda7
[=A0=A0=A0 3.029258] PM: Adding info for No Bus:sda8
[=A0=A0=A0 3.029293] PM: Adding info for No Bus:sda9
[=A0=A0=A0 3.029643] sd 0:0:0:0: [sda] Attached SCSI disk
[=A0=A0=A0 3.039254]=A0 sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 >
[=A0=A0=A0 3.045190] PM: Adding info for No Bus:sdc1
[=A0=A0=A0 3.045227] PM: Adding info for No Bus:sdc2
[=A0=A0=A0 3.045265] PM: Adding info for No Bus:sdc5
[=A0=A0=A0 3.045300] PM: Adding info for No Bus:sdc6
[=A0=A0=A0 3.045338] PM: Adding info for No Bus:sdc7
[=A0=A0=A0 3.045374] PM: Adding info for No Bus:sdc8
[=A0=A0=A0 3.045414] PM: Adding info for No Bus:sdc9
[=A0=A0=A0 3.045450] PM: Adding info for No Bus:sdc10
[=A0=A0=A0 3.045750] sd 3:0:0:0: [sdc] Attached SCSI disk
[=A0=A0=A0 3.050463] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[=A0=A0=A0 3.056287] usb usb4: rpm_resume flags 0x0
[=A0=A0=A0 3.056291] usb usb4: rpm_resume returns 1
[=A0=A0=A0 3.056310] usb usb4: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
[=A0=A0=A0 3.056461]=A0 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb=
11 sdb12 sdb13 >
[=A0=A0=A0 3.056551] PM: Adding info for No Bus:sdb1
[=A0=A0=A0 3.056604] PM: Adding info for No Bus:sdb2
[=A0=A0=A0 3.056655] PM: Adding info for No Bus:sdb5
[=A0=A0=A0 3.056725] PM: Adding info for No Bus:sdb6
[=A0=A0=A0 3.056774] PM: Adding info for No Bus:sdb7
[=A0=A0=A0 3.056824] PM: Adding info for No Bus:sdb8
[=A0=A0=A0 3.056880] PM: Adding info for No Bus:sdb9
[=A0=A0=A0 3.056933] PM: Adding info for No Bus:sdb10
[=A0=A0=A0 3.056985] PM: Adding info for No Bus:sdb11
[=A0=A0=A0 3.057039] PM: Adding info for No Bus:sdb12
[=A0=A0=A0 3.057095] PM: Adding info for No Bus:sdb13
[=A0=A0=A0 3.070584] usb usb4: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 3.070991] sd 2:0:0:0: [sdb] Attached SCSI disk
[=A0=A0=A0 3.080041] hub 1-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 3.080045] hub 1-0:1.0: rpm_resume returns 1
[=A0=A0=A0 3.080053] hub 1-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 3.080060] hub 1-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 3.080064] hub 2-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 3.080067] hub 2-0:1.0: rpm_resume returns 1
[=A0=A0=A0 3.080087] usb usb1: rpm_suspend flags 0x8
[=A0=A0=A0 3.080092] usb usb1: rpm_suspend returns 0
[=A0=A0=A0 3.082511] usb usb4: Product: UHCI Host Controller
[=A0=A0=A0 3.087427] usb usb4: Manufacturer: Linux 2.6.39.3-i686 uhci_hcd
[=A0=A0=A0 3.093473] usb usb4: SerialNumber: 0000:00:1d.2
[=A0=A0=A0 3.098228] PM: Adding info for usb:usb4
[=A0=A0=A0 3.098260] usb usb4: rpm_resume flags 0x4
[=A0=A0=A0 3.098263] usb usb4: rpm_resume returns 1
[=A0=A0=A0 3.098284] PM: Adding info for usb:4-0:1.0
[=A0=A0=A0 3.098303] usb usb4: rpm_resume flags 0x4
[=A0=A0=A0 3.098306] usb usb4: rpm_resume returns 1
[=A0=A0=A0 3.098309] hub 4-0:1.0: USB hub found
[=A0=A0=A0 3.102102] hub 4-0:1.0: 2 ports detected
[=A0=A0=A0 3.106181] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 3.106200] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 3.106204] usb usb4: rpm_suspend flags 0xc
[=A0=A0=A0 3.106207] usb usb4: rpm_suspend returns -16
[=A0=A0=A0 3.106256] uhci_hcd 0000:00:1d.3: PCI INT A -> GSI 16 (level, low=
) -> IRQ 16
[=A0=A0=A0 3.113438] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[=A0=A0=A0 3.113443] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[=A0=A0=A0 3.118753] PM: Adding info for No Bus:usbmon5
[=A0=A0=A0 3.118769] uhci_hcd 0000:00:1d.3: new USB bus registered, assigne=
d bus number 5
[=A0=A0=A0 3.130033] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ff20
[=A0=A0=A0 3.135842] usb usb5: rpm_resume flags 0x0
[=A0=A0=A0 3.135845] usb usb5: rpm_resume returns 1
[=A0=A0=A0 3.135863] usb usb5: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
[=A0=A0=A0 3.142691] usb usb5: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 3.149961] usb usb5: Product: UHCI Host Controller
[=A0=A0=A0 3.154878] usb usb5: Manufacturer: Linux 2.6.39.3-i686 uhci_hcd
[=A0=A0=A0 3.160922] usb usb5: SerialNumber: 0000:00:1d.3
[=A0=A0=A0 3.165659] PM: Adding info for usb:usb5
[=A0=A0=A0 3.165687] usb usb5: rpm_resume flags 0x4
[=A0=A0=A0 3.165691] usb usb5: rpm_resume returns 1
[=A0=A0=A0 3.165710] PM: Adding info for usb:5-0:1.0
[=A0=A0=A0 3.165728] usb usb5: rpm_resume flags 0x4
[=A0=A0=A0 3.165731] usb usb5: rpm_resume returns 1
[=A0=A0=A0 3.165734] hub 5-0:1.0: USB hub found
[=A0=A0=A0 3.169531] hub 5-0:1.0: 2 ports detected
[=A0=A0=A0 3.173606] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 3.173625] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 3.173629] usb usb5: rpm_suspend flags 0xc
[=A0=A0=A0 3.173632] usb usb5: rpm_suspend returns -16
[=A0=A0=A0 3.173704] usbcore: registered new interface driver usblp
[=A0=A0=A0 3.179267] PM: Adding info for platform:dummy_hcd
[=A0=A0=A0 3.179281] dummy_hcd dummy_hcd: USB Host+Gadget Emulator, driver =
02 May 2005
[=A0=A0=A0 3.186455] dummy_hcd dummy_hcd: Dummy host controller
[=A0=A0=A0 3.191670] PM: Adding info for No Bus:usbmon6
[=A0=A0=A0 3.191682] dummy_hcd dummy_hcd: new USB bus registered, assigned =
bus number 6
[=A0=A0=A0 3.213347] usb usb6: rpm_resume flags 0x0
[=A0=A0=A0 3.213351] usb usb6: rpm_resume returns 1
[=A0=A0=A0 3.213368] usb usb6: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002
[=A0=A0=A0 3.220194] usb usb6: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 3.227462] usb usb6: Product: Dummy host controller
[=A0=A0=A0 3.232466] usb usb6: Manufacturer: Linux 2.6.39.3-i686 dummy_hcd
[=A0=A0=A0 3.238599] usb usb6: SerialNumber: dummy_hcd
[=A0=A0=A0 3.243067] PM: Adding info for usb:usb6
[=A0=A0=A0 3.243093] usb usb6: rpm_resume flags 0x4
[=A0=A0=A0 3.243096] usb usb6: rpm_resume returns 1
[=A0=A0=A0 3.243118] PM: Adding info for usb:6-0:1.0
[=A0=A0=A0 3.243135] usb usb6: rpm_resume flags 0x4
[=A0=A0=A0 3.243138] usb usb6: rpm_resume returns 1
[=A0=A0=A0 3.243142] hub 6-0:1.0: USB hub found
[=A0=A0=A0 3.246933] hub 6-0:1.0: 1 port detected
[=A0=A0=A0 3.250920] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 3.250938] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 3.250942] usb usb6: rpm_suspend flags 0xc
[=A0=A0=A0 3.250945] usb usb6: rpm_suspend returns -16
[=A0=A0=A0 3.250961] PM: Adding info for platform:dummy_udc
[=A0=A0=A0 3.250982] PM: Adding info for No Bus:gadget
[=A0=A0=A0 3.251046] i8042: PNP: No PS/2 controller found. Probing ports di=
rectly.
[=A0=A0=A0 3.257938] PM: Adding info for platform:i8042
[=A0=A0=A0 3.261087] serio: i8042 KBD port at 0x60,0x64 irq 1
[=A0=A0=A0 3.266099] serio: i8042 AUX port at 0x60,0x64 irq 12
[=A0=A0=A0 3.271211] PM: Adding info for serio:serio0
[=A0=A0=A0 3.271297] PM: Adding info for No Bus:mice
[=A0=A0=A0 3.271334] PM: Adding info for No Bus:psaux
[=A0=A0=A0 3.271343] mousedev: PS/2 mouse device common for all mice
[=A0=A0=A0 3.276979] PM: Adding info for serio:serio1
[=A0=A0=A0 3.277021] PM: Adding info for No Bus:event0
[=A0=A0=A0 3.277057] PM: Adding info for No Bus:event1
[=A0=A0=A0 3.277221] PM: Adding info for No Bus:uinput
[=A0=A0=A0 3.277254] rtc_cmos 00:05: RTC can wake from S4
[=A0=A0=A0 3.286750] PM: Adding info for No Bus:rtc0
[=A0=A0=A0 3.286771] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[=A0=A0=A0 3.292925] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[=A0=A0=A0 3.299157] i2c /dev entries driver
[=A0=A0=A0 3.302751] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, l=
ow) -> IRQ 17
[=A0=A0=A0 3.306692] usb 2-1: new full speed USB device number 2 using uhci=
_hcd
[=A0=A0=A0 3.316701] PM: Adding info for i2c:i2c-0
[=A0=A0=A0 3.316739] PM: Adding info for No Bus:i2c-0
[=A0=A0=A0 3.316793] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[=A0=A0=A0 3.322429] PM: Adding info for platform:iTCO_wdt
[=A0=A0=A0 3.322469] iTCO_wdt: Found a ICH5 or ICH5R TCO device (Version=3D=
1, TCOBASE=3D0x0860)
[=A0=A0=A0 3.330117] PM: Adding info for No Bus:watchdog
[=A0=A0=A0 3.330131] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D=
0)
[=A0=A0=A0 3.336178] md: linear personality registered for level -1
[=A0=A0=A0 3.341706] md: raid0 personality registered for level 0
[=A0=A0=A0 3.347074] md: raid1 personality registered for level 1
[=A0=A0=A0 3.352426] md: raid10 personality registered for level 10
[=A0=A0=A0 3.357950] md: raid6 personality registered for level 6
[=A0=A0=A0 3.363300] md: raid5 personality registered for level 5
[=A0=A0=A0 3.368652] md: raid4 personality registered for level 4
[=A0=A0=A0 3.374133] device-mapper: uevent: version 1.0.3
[=A0=A0=A0 3.378902] PM: Adding info for No Bus:device-mapper
[=A0=A0=A0 3.378914] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initia=
lised: dm-devel@redhat.com
[=A0=A0=A0 3.387486] device-mapper: multipath: version 1.3.0 loaded
[=A0=A0=A0 3.393012] device-mapper: multipath round-robin: version 1.0.0 lo=
aded
[=A0=A0=A0 3.399693] cpuidle: using governor ladder
[=A0=A0=A0 3.403831] cpuidle: using governor menu
[=A0=A0=A0 3.408313] usbcore: registered new interface driver usbhid
[=A0=A0=A0 3.413923] usbhid: USB HID core driver
[=A0=A0=A0 3.418220] TCP cubic registered
[=A0=A0=A0 3.421700] NET: Registered protocol family 10
[=A0=A0=A0 3.427384] NET: Registered protocol family 17
[=A0=A0=A0 3.431930] Bridge firewalling registered
[=A0=A0=A0 3.435980] Registering the dns_resolver key type
[=A0=A0=A0 3.439348] usb 2-1: rpm_resume flags 0x0
[=A0=A0=A0 3.439352] usb 2-1: rpm_resume returns 1
[=A0=A0=A0 3.440753] Using IPI No-Shortcut mode
[=A0=A0=A0 3.444606] PM: Adding info for No Bus:cpu_dma_latency
[=A0=A0=A0 3.444649] PM: Adding info for No Bus:network_latency
[=A0=A0=A0 3.444680] PM: Adding info for No Bus:network_throughput
[=A0=A0=A0 3.444691] PM: Checking hibernation image partition /dev/sdb13
[=A0=A0=A0 3.444717] PM: Hibernation image partition 8:29 present
[=A0=A0=A0 3.444719] PM: Looking for hibernation image.
[=A0=A0=A0 3.444740] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.444743] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.444979] PM: Image not found (code -22)
[=A0=A0=A0 3.444983] PM: Hibernation image not present or could not be load=
ed.
[=A0=A0=A0 3.445320] rtc_cmos 00:05: setting system clock to 2011-07-22 07:=
09:59 UTC (1311318599)
[=A0=A0=A0 3.453473] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[=A0=A0=A0 3.459522] EDD information not available.
[=A0=A0=A0 3.463780] Freeing unused kernel memory: 476k freed
[=A0=A0=A0 3.495348] usb 2-1: New USB device found, idVendor=3D054c, idProd=
uct=3D0155
[=A0=A0=A0 3.502150] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[=A0=A0=A0 3.506293] udev[66]: starting version 163
[=A0=A0=A0 3.513492] usb 2-1: Product: EyeToy USB camera Namtai
[=A0=A0=A0 3.518721] usb 2-1: Manufacturer: Sony corporation
[=A0=A0=A0 3.526907] PM: Adding info for usb:2-1
[=A0=A0=A0 3.526963] usb 2-1: rpm_resume flags 0x4
[=A0=A0=A0 3.526969] usb 2-1: rpm_resume returns 1
[=A0=A0=A0 3.528043] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.528049] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.529386] PM: Adding info for usb:2-1:1.0
[=A0=A0=A0 3.529459] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 3.529485] PM: Adding info for usb:2-1:1.1
[=A0=A0=A0 3.529545] PM: Adding info for usb:2-1:1.2
[=A0=A0=A0 3.529607] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 3.529618] hub 3-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 3.529622] hub 3-0:1.0: rpm_resume returns 1
[=A0=A0=A0 3.539422] PM: Adding info for No Bus:vcs2
[=A0=A0=A0 3.539478] PM: Adding info for No Bus:vcsa2
[=A0=A0=A0 3.550915] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.550924] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.555007] PM: Adding info for No Bus:vcs3
[=A0=A0=A0 3.555069] PM: Adding info for No Bus:vcsa3
[=A0=A0=A0 3.559276] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.559282] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.568090] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.568097] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.571826] PM: Adding info for No Bus:vcs4
[=A0=A0=A0 3.571882] PM: Adding info for No Bus:vcsa4
[=A0=A0=A0 3.581371] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.581379] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.584035] PM: Adding info for No Bus:vcs5
[=A0=A0=A0 3.584092] PM: Adding info for No Bus:vcsa5
[=A0=A0=A0 3.591452] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.591460] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.596125] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.596132] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.597310] PM: Adding info for No Bus:vcs6
[=A0=A0=A0 3.597365] PM: Adding info for No Bus:vcsa6
[=A0=A0=A0 3.597954] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.597961] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.617180] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.617186] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.655671] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.655678] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.673453] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.673459] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.703056] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.703062] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.729264] PM: Adding info for No Bus:vcs7
[=A0=A0=A0 3.729337] PM: Adding info for No Bus:vcsa7
[=A0=A0=A0 3.753411] usb 3-1: new low speed USB device number 2 using uhci_=
hcd
[=A0=A0=A0 3.762296] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.762301] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.764979] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.764986] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.769461] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.769468] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.781389] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.781397] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.781689] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.781697] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.782723] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.782729] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.785273] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.785281] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.792370] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.792378] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.812892] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.812899] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.814152] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.814159] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.815161] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.815168] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.816657] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.816665] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.820886] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.820893] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.823997] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.824004] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.830098] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.830104] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.832793] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.832803] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.832856] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.832865] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.833792] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.833801] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.835308] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.835314] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.835326] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.835333] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.836851] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.836858] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.838302] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.838310] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.841464] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.841471] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.842220] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.842229] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.845904] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.845910] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.846331] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.846337] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.858406] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.858412] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.861578] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.861585] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.877971] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.877978] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.892284] usb 3-1: rpm_resume flags 0x0
[=A0=A0=A0 3.892289] usb 3-1: rpm_resume returns 1
[=A0=A0=A0 3.912382] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.912387] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.928269] usb 3-1: New USB device found, idVendor=3D046d, idProd=
uct=3Dc517
[=A0=A0=A0 3.935157] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[=A0=A0=A0 3.942388] usb 3-1: Product: USB Receiver
[=A0=A0=A0 3.945627] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.945633] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.946805] usb 3-1: Manufacturer: Logitech
[=A0=A0=A0 3.951267] PM: Adding info for usb:3-1
[=A0=A0=A0 3.951489] usb 3-1: rpm_resume flags 0x4
[=A0=A0=A0 3.951495] usb 3-1: rpm_resume returns 1
[=A0=A0=A0 3.953788] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.953793] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.954312] PM: Adding info for usb:3-1:1.0
[=A0=A0=A0 3.954353] usb 3-1: rpm_resume flags 0x4
[=A0=A0=A0 3.954359] usb 3-1: rpm_resume returns 1
[=A0=A0=A0 3.954409] PM: Adding info for hid:0003:046D:C517.0001
[=A0=A0=A0 3.962278] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 3.962284] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 3.968482] usbhid 3-1:1.0: rpm_resume flags 0x5
[=A0=A0=A0 3.968487] usbhid 3-1:1.0: rpm_resume returns 1
[=A0=A0=A0 3.976787] PM: Adding info for No Bus:input2
[=A0=A0=A0 3.976854] input: Logitech USB Receiver as /devices/pci0000:00/00=
00:00:1d.1/usb3/3-1/3-1:1.0/input/input2
[=A0=A0=A0 3.987020] usbhid 3-1:1.0: rpm_resume flags 0x4
[=A0=A0=A0 3.987027] usbhid 3-1:1.0: rpm_resume returns 1
[=A0=A0=A0 3.987364] PM: Adding info for No Bus:event2
[=A0=A0=A0 3.987686] PM: Adding info for No Bus:hidraw0
[=A0=A0=A0 3.987722] logitech 0003:046D:C517.0001: input,hidraw0: USB HID v=
1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1d.1-1/input0
[=A0=A0=A0 3.999904] usbhid 3-1:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 3.999911] usbhid 3-1:1.0: rpm_suspend returns 0
[=A0=A0=A0 3.999947] PM: Adding info for No Bus:ep_81
[=A0=A0=A0 4.000055] PM: Adding info for usb:3-1:1.1
[=A0=A0=A0 4.000176] usb 3-1: rpm_resume flags 0x4
[=A0=A0=A0 4.000180] usb 3-1: rpm_resume returns 1
[=A0=A0=A0 4.000219] PM: Adding info for hid:0003:046D:C517.0002
[=A0=A0=A0 4.029260] logitech 0003:046D:C517.0002: fixing up Logitech keybo=
ard report descriptor
[=A0=A0=A0 4.037591] PM: Adding info for No Bus:9:4
[=A0=A0=A0 4.037681] PM: Adding info for No Bus:md4
[=A0=A0=A0 4.038128] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.038134] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.039039] PM: Adding info for No Bus:input3
[=A0=A0=A0 4.039049] md: bind<sdc9>
[=A0=A0=A0 4.039243] input: Logitech USB Receiver as /devices/pci0000:00/00=
00:00:1d.1/usb3/3-1/3-1:1.1/input/input3
[=A0=A0=A0 4.039256] usbhid 3-1:1.1: rpm_resume flags 0x4
[=A0=A0=A0 4.039259] usbhid 3-1:1.1: rpm_resume returns 1
[=A0=A0=A0 4.039342] PM: Adding info for No Bus:mouse0
[=A0=A0=A0 4.039480] PM: Adding info for No Bus:event3
[=A0=A0=A0 4.040327] PM: Adding info for No Bus:hiddev0
[=A0=A0=A0 4.040630] PM: Adding info for No Bus:hidraw1
[=A0=A0=A0 4.040725] logitech 0003:046D:C517.0002: input,hiddev0,hidraw1: U=
SB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-1/input1
[=A0=A0=A0 4.040738] usbhid 3-1:1.1: rpm_suspend flags 0x4
[=A0=A0=A0 4.040742] usbhid 3-1:1.1: rpm_suspend returns 0
[=A0=A0=A0 4.040772] PM: Adding info for No Bus:ep_82
[=A0=A0=A0 4.040804] PM: Adding info for No Bus:ep_00
[=A0=A0=A0 4.040810] hub 3-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 4.040814] hub 3-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 4.041882] hub 4-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 4.041887] hub 4-0:1.0: rpm_resume returns 1
[=A0=A0=A0 4.041891] hub 4-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 4.041901] hub 4-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 4.041909] usb usb4: rpm_suspend flags 0x8
[=A0=A0=A0 4.041915] usb usb4: rpm_suspend returns 0
[=A0=A0=A0 4.041921] hub 5-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 4.041924] hub 5-0:1.0: rpm_resume returns 1
[=A0=A0=A0 4.041928] hub 5-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 4.041934] hub 5-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 4.041939] usb usb5: rpm_suspend flags 0x8
[=A0=A0=A0 4.041943] usb usb5: rpm_suspend returns 0
[=A0=A0=A0 4.041948] hub 2-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 4.041951] hub 2-0:1.0: rpm_resume returns 1
[=A0=A0=A0 4.041967] hub 2-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 4.041971] hub 2-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 4.041975] hub 6-0:1.0: rpm_resume flags 0x4
[=A0=A0=A0 4.041977] hub 6-0:1.0: rpm_resume returns 1
[=A0=A0=A0 4.041981] hub 6-0:1.0: rpm_suspend flags 0x4
[=A0=A0=A0 4.041988] hub 6-0:1.0: rpm_suspend returns 0
[=A0=A0=A0 4.041993] usb usb6: rpm_suspend flags 0x8
[=A0=A0=A0 4.041997] usb usb6: rpm_suspend returns 0
[=A0=A0=A0 4.068524] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.068531] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.147903] PM: Adding info for No Bus:9:3
[=A0=A0=A0 4.148003] PM: Adding info for No Bus:md3
[=A0=A0=A0 4.148478] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.148485] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.177133] PM: Adding info for No Bus:9:2
[=A0=A0=A0 4.177241] PM: Adding info for No Bus:md2
[=A0=A0=A0 4.184082] PM: Adding info for No Bus:9:1
[=A0=A0=A0 4.184181] PM: Adding info for No Bus:md1
[=A0=A0=A0 4.470752] md: bind<sdb7>
[=A0=A0=A0 4.473824] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.473832] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.474298] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.474304] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.476856] md: bind<sdc6>
[=A0=A0=A0 4.481122] md: bind<sdc5>
[=A0=A0=A0 4.485067] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.485074] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.558927] md: bind<sdb11>
[=A0=A0=A0 4.564711] bio: create slab <bio-1> at 1
[=A0=A0=A0 4.568852] md/raid0:md4: looking at sdb11
[=A0=A0=A0 4.572960] md/raid0:md4:=A0=A0 comparing sdb11(94371712) with sdb=
11(94371712)
[=A0=A0=A0 4.579861] md/raid0:md4:=A0=A0 END
[=A0=A0=A0 4.583017] md/raid0:md4:=A0=A0 =3D=3D> UNIQUE
[=A0=A0=A0 4.586864] md/raid0:md4: 1 zones
[=A0=A0=A0 4.590265] md/raid0:md4: looking at sdc9
[=A0=A0=A0 4.594286] md/raid0:md4:=A0=A0 comparing sdc9(94367616) with sdb1=
1(94371712)
[=A0=A0=A0 4.601188] md/raid0:md4:=A0=A0 NOT EQUAL
[=A0=A0=A0 4.604950] md/raid0:md4:=A0=A0 comparing sdc9(94367616) with sdc9=
(94367616)
[=A0=A0=A0 4.611870] md/raid0:md4:=A0=A0 END
[=A0=A0=A0 4.615109] md/raid0:md4:=A0=A0 =3D=3D> UNIQUE
[=A0=A0=A0 4.618953] md/raid0:md4: 2 zones
[=A0=A0=A0 4.622363] md/raid0:md4: FINAL 2 zones
[=A0=A0=A0 4.626215] md/raid0:md4: zone 1
[=A0=A0=A0 4.629477] md/raid0:md4: checking sdb11 ... contained as device 0
[=A0=A0=A0 4.635673] md/raid0:md4:=A0 (94371712) is smallest!.
[=A0=A0=A0 4.640644] md/raid0:md4: checking sdc9 ... nope.
[=A0=A0=A0 4.645369] md/raid0:md4: zone->nb_dev: 1, sectors: 4096
[=A0=A0=A0 4.650695] md/raid0:md4: current zone start: 94371712
[=A0=A0=A0 4.655844] md/raid0:md4: done.
[=A0=A0=A0 4.658997] md/raid0:md4: md_size is 188739328 sectors.
[=A0=A0=A0 4.664317] ******* md4 configuration *********
[=A0=A0=A0 4.668939] zone0=3D[sdb11/sdc9/]
[=A0=A0=A0 4.672196]=A0=A0=A0=A0=A0=A0=A0=A0 zone offset=3D0kb device offse=
t=3D0kb size=3D94367616kb
[=A0=A0=A0 4.678646] zone1=3D[sdb11/]
[=A0=A0=A0 4.681386]=A0=A0=A0=A0=A0=A0=A0=A0 zone offset=3D94367616kb devic=
e offset=3D47183808kb size=3D2048kb
[=A0=A0=A0 4.688711] **********************************
[=A0=A0=A0 4.688712] =

[=A0=A0=A0 4.694749] md4: detected capacity change from 0 to 96634535936
[=A0=A0=A0 4.702316] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.702322] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.702587] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.702594] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.707009] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 4.707014] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 4.713550] md: bind<sdc7>
[=A0=A0=A0 4.728035] md: bind<sdb6>
[=A0=A0=A0 4.733894] md/raid0:md2: looking at sdb6
[=A0=A0=A0 4.737929] md/raid0:md2:=A0=A0 comparing sdb6(19534848) with sdb6=
(19534848)
[=A0=A0=A0 4.744655] md/raid0:md2:=A0=A0 END
[=A0=A0=A0 4.747806] md/raid0:md2:=A0=A0 =3D=3D> UNIQUE
[=A0=A0=A0 4.751563] md/raid0:md2: 1 zones
[=A0=A0=A0 4.754887] md/raid0:md2: looking at sdc6
[=A0=A0=A0 4.759016] md/raid0:md2:=A0=A0 comparing sdc6(19534848) with sdb6=
(19534848)
[=A0=A0=A0 4.765821] md/raid0:md2:=A0=A0 EQUAL
[=A0=A0=A0 4.769150] md/raid0:md2: FINAL 1 zones
[=A0=A0=A0 4.773008] md/raid0:md2: done.
[=A0=A0=A0 4.776172] md/raid0:md2: md_size is 39069696 sectors.
[=A0=A0=A0 4.781321] ******* md2 configuration *********
[=A0=A0=A0 4.785859] zone0=3D[sdb6/sdc6/
[=A0=A0=A0 4.788356]=A0 md4: unknown partition table
[=A0=A0=A0 4.792903] ]
[=A0=A0=A0 4.794520]=A0=A0=A0=A0=A0=A0=A0=A0 zone offset=3D0kb device offse=
t=3D0kb size=3D19534848kb
[=A0=A0=A0 4.800982] **********************************
[=A0=A0=A0 4.800985] =

[=A0=A0=A0 4.806975] md2: detected capacity change from 0 to 20003684352
[=A0=A0=A0 4.817924] md: bind<sdb5>
[=A0=A0=A0 4.823529] md/raid0:md1: looking at sdb5
[=A0=A0=A0 4.827709] md/raid0:md1:=A0=A0 comparing sdb5(29302272) with sdb5=
(29302272)
[=A0=A0=A0 4.834479] md/raid0:md1:=A0=A0 END
[=A0=A0=A0 4.837664] md/raid0:md1:=A0=A0 =3D=3D> UNIQUE
[=A0=A0=A0 4.841441] md/raid0:md1: 1 zones
[=A0=A0=A0 4.844785] md/raid0:md1: looking at sdc5
[=A0=A0=A0 4.848912] md/raid0:md1:=A0=A0 comparing sdc5(29302272) with sdb5=
(29302272)
[=A0=A0=A0 4.855827] md/raid0:md1:=A0=A0 EQUAL
[=A0=A0=A0 4.859246] md/raid0:md1: FINAL 1 zones
[=A0=A0=A0 4.863189] md/raid0:md1: done.
[=A0=A0=A0 4.866363] md/raid0:md1: md_size is 58604544 sectors.
[=A0=A0=A0 4.871525] ******* md1 configuration *********
[=A0=A0=A0 4.876070] zone0=3D[sdb5/sdc5/]
[=A0=A0=A0 4.879167]=A0=A0=A0=A0=A0=A0=A0=A0 zone offset=3D0kb device offse=
t=3D0kb size=3D29302272kb
[=A0=A0=A0 4.885626] **********************************
[=A0=A0=A0 4.885630] =

[=A0=A0=A0 4.891622] md1: detected capacity change from 0 to 30005526528
[=A0=A0=A0 4.897919]=A0 md2: unknown partition table
[=A0=A0=A0 4.898295] md/raid0:md3: looking at sdc7
[=A0=A0=A0 4.898300] md/raid0:md3:=A0=A0 comparing sdc7(9767296) with sdc7(=
9767296)
[=A0=A0=A0 4.898304] md/raid0:md3:=A0=A0 END
[=A0=A0=A0 4.898306] md/raid0:md3:=A0=A0 =3D=3D> UNIQUE
[=A0=A0=A0 4.898309] md/raid0:md3: 1 zones
[=A0=A0=A0 4.898312] md/raid0:md3: looking at sdb7
[=A0=A0=A0 4.898315] md/raid0:md3:=A0=A0 comparing sdb7(9767296) with sdc7(=
9767296)
[=A0=A0=A0 4.898319] md/raid0:md3:=A0=A0 EQUAL
[=A0=A0=A0 4.898322] md/raid0:md3: FINAL 1 zones
[=A0=A0=A0 4.898327] md/raid0:md3: done.
[=A0=A0=A0 4.898330] md/raid0:md3: md_size is 19534592 sectors.
[=A0=A0=A0 4.898333] ******* md3 configuration *********
[=A0=A0=A0 4.898336] zone0=3D[sdb7/sdc7/]
[=A0=A0=A0 4.898342]=A0=A0=A0=A0=A0=A0=A0=A0 zone offset=3D0kb device offse=
t=3D0kb size=3D9767296kb
[=A0=A0=A0 4.898344] **********************************
[=A0=A0=A0 4.898346] =

[=A0=A0=A0 4.898366] md3: detected capacity change from 0 to 10001711104
[=A0=A0=A0 5.015305]=A0 md1: unknown partition table
[=A0=A0=A0 5.020268]=A0 md3: unknown partition table
[=A0=A0=A0 5.161883] EXT4-fs (md1): mounted filesystem with ordered data mo=
de. Opts: (null)
[=A0=A0=A0 5.353345] usb usb1: rpm_suspend flags 0x9
[=A0=A0=A0 5.353352] usb usb1: rpm_suspend returns 0
[=A0=A0=A0 5.353364] usb usb1: rpm_suspend flags 0xa
[=A0=A0=A0 5.353399] usb usb1: rpm_suspend returns 0
[=A0=A0=A0 6.353346] usb usb4: rpm_suspend flags 0x9
[=A0=A0=A0 6.353352] usb usb4: rpm_suspend returns 0
[=A0=A0=A0 6.353356] usb usb5: rpm_suspend flags 0x9
[=A0=A0=A0 6.353359] usb usb5: rpm_suspend returns 0
[=A0=A0=A0 6.353363] usb usb6: rpm_suspend flags 0x9
[=A0=A0=A0 6.353366] usb usb6: rpm_suspend returns 0
[=A0=A0=A0 6.353375] usb usb4: rpm_suspend flags 0xa
[=A0=A0=A0 6.353397] usb usb4: rpm_suspend returns 0
[=A0=A0=A0 6.353401] usb usb5: rpm_suspend flags 0xa
[=A0=A0=A0 6.353416] usb usb5: rpm_suspend returns 0
[=A0=A0=A0 6.353419] usb usb6: rpm_suspend flags 0xa
[=A0=A0=A0 6.353427] usb usb6: rpm_suspend returns 0
[=A0=A0=A0 9.073532] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.073539] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.084598] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.084607] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.086370] Adding 2097148k swap on /dev/sdb13.=A0 Priority:1 exte=
nts:1 across:2097148k =

[=A0=A0=A0 9.113183] udev[357]: starting version 163
[=A0=A0=A0 9.259062] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.259069] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.318971] intel_rng: Firmware space is locked read-only. If you =
can't or
[=A0=A0=A0 9.318975] intel_rng: don't want to disable this in firmware setu=
p, and if
[=A0=A0=A0 9.318977] intel_rng: you are certain that your system has a func=
tional
[=A0=A0=A0 9.318980] intel_rng: RNG, try using the 'no_fwh_detect' option.
[=A0=A0=A0 9.353196] shpchp: Standard Hot Plug PCI Controller Driver versio=
n: 0.4
[=A0=A0=A0 9.406014] Linux media interface: v0.10
[=A0=A0=A0 9.410343] EDAC MC: Ver: 2.1.0 Jul 16 2011
[=A0=A0=A0 9.514267] Linux video capture interface: v2.00
[=A0=A0=A0 9.514702] EDAC i82875p: i82875p init one
[=A0=A0=A0 9.517483] EDAC MC0: Giving out device to 'i82875p_edac' 'i82875p=
': DEV 0000:00:00.0
[=A0=A0=A0 9.517650] EDAC PCI0: Giving out device to module 'i82875p_edac' =
controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[=A0=A0=A0 9.629029] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.629037] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.631977] gspca: v2.12.0 registered
[=A0=A0=A0 9.687135] usb 2-1: rpm_resume flags 0x4
[=A0=A0=A0 9.687141] usb 2-1: rpm_resume returns 1
[=A0=A0=A0 9.687147] gspca: probing 054c:0155
[=A0=A0=A0 9.688318] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.688325] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.698030] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.698037] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.702313] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.702319] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.707771] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.707777] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.713018] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.713025] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.749157] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.749163] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.762712] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.762719] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.764152] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.764160] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.791604] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.791610] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.805009] Linux agpgart interface v0.103
[=A0=A0=A0 9.819667] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.819674] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.833434] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.833439] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.833492] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.833496] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.836651] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.836659] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.845825] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.845832] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.881278] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.881286] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.894535] EXT4-fs (md1): re-mounted. Opts: errors=3Dremount-ro
[=A0=A0=A0 9.942802] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0=A0 9.942809] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0=A0 9.947418] ov519: I2C synced in 0 attempt(s)
[=A0=A0=A0 9.947424] ov519: starting OV7xx0 configuration
[=A0=A0=A0 9.983452] ov519: Sensor is an OV7648
[=A0=A0 10.068232] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.068238] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.098374] PM: Adding info for No Bus:input4
[=A0=A0 10.098449] input: ov519 as /devices/pci0000:00/0000:00:1d.0/usb2/2-=
1/input/input4
[=A0=A0 10.098547] PM: Adding info for No Bus:event4
[=A0=A0 10.098623] PM: Adding info for No Bus:video0
[=A0=A0 10.098649] gspca: video0 created
[=A0=A0 10.098669] usb 2-1: rpm_resume flags 0x4
[=A0=A0 10.098674] usb 2-1: rpm_resume returns 1
[=A0=A0 10.098693] usb 2-1: rpm_resume flags 0x4
[=A0=A0 10.098697] usb 2-1: rpm_resume returns 1
[=A0=A0 10.098742] usbcore: registered new interface driver ov519
[=A0=A0 10.169042] EXT4-fs (md3): mounted filesystem with ordered data mode=
. Opts: (null)
[=A0=A0 10.244420] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.244427] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.335480] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.335487] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.343196] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.343209] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.361486] type=3D1400 audit(1311333006.411:2): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/sbin/dhclient3" pid=3D563 comm=3D"appa=
rmor_parser"
[=A0=A0 10.361627] type=3D1400 audit(1311333006.411:3): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/NetworkManager/nm-dhcp-client.=
action" pid=3D563 comm=3D"apparmor_parser"
[=A0=A0 10.361733] type=3D1400 audit(1311333006.411:4): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/connman/scripts/dhclient-scrip=
t" pid=3D563 comm=3D"apparmor_parser"
[=A0=A0 10.431702] PM: Adding info for No Bus:timer
[=A0=A0 10.453091] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.453099] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.455259] scsi host0: rpm_resume flags 0x4
[=A0=A0 10.455267] scsi host0: rpm_resume returns 1
[=A0=A0 10.470300] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.470306] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.471624] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.471630] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.472924] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.472931] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.474271] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.474277] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.475503] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.475510] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.476801] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.476807] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.479454] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.479460] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.493386] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.493393] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.499200] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.499206] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.517993] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.518000] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.518626] scsi host3: rpm_resume flags 0x4
[=A0=A0 10.518631] scsi host3: rpm_resume returns 1
[=A0=A0 10.532723] type=3D1400 audit(1311333006.581:5): apparmor=3D"STATUS"=
 operation=3D"profile_replace" name=3D"/sbin/dhclient3" pid=3D646 comm=3D"a=
pparmor_parser"
[=A0=A0 10.532846] type=3D1400 audit(1311333006.581:6): apparmor=3D"STATUS"=
 operation=3D"profile_replace" name=3D"/usr/lib/NetworkManager/nm-dhcp-clie=
nt.action" pid=3D646 comm=3D"apparmor_parser"
[=A0=A0 10.532954] type=3D1400 audit(1311333006.581:7): apparmor=3D"STATUS"=
 operation=3D"profile_replace" name=3D"/usr/lib/connman/scripts/dhclient-sc=
ript" pid=3D646 comm=3D"apparmor_parser"
[=A0=A0 10.544847] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.544855] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.546598] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.546606] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.549706] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.549720] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.557843] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.557852] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.583120] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.583128] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.604292] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.604300] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.612461] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.612466] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.639734] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.639739] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.644730] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.644735] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.666554] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.666560] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.692443] PM: Adding info for No Bus:seq
[=A0=A0 10.760351] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.760359] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 10.768801] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.768809] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.852019] scsi host2: rpm_resume flags 0x4
[=A0=A0 10.852031] scsi host2: rpm_resume returns 1
[=A0=A0 10.852650] nvidia: module license 'NVIDIA' taints kernel.
[=A0=A0 10.905738] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.905744] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 10.940721] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.940727] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.943067] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.943074] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.949447] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.949453] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.971857] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.971864] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.993081] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.993087] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.997837] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.997843] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.998186] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.998191] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 10.998557] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 10.998563] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 11.015268] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.015275] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.021439] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.021445] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 11.025066] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.025072] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 11.042038] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.042044] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.128155] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.128161] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.143515] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.143522] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.302650] usb 2-1: rpm_resume flags 0x4
[=A0=A0 11.302656] usb 2-1: rpm_resume returns 1
[=A0=A0 11.308055] PM: Adding info for No Bus:ep_82
[=A0=A0 11.309022] PM: Removing info for No Bus:ep_82
[=A0=A0 11.309075] PM: Adding info for No Bus:card1
[=A0=A0 11.309302] PM: Adding info for No Bus:pcmC1D0c
[=A0=A0 11.309487] PM: Adding info for No Bus:controlC1
[=A0=A0 11.309629] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 11.309635] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 11.311493] usbcore: registered new interface driver snd-usb-audio
[=A0=A0 11.331396] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.331402] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 11.415226] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.415233] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 11.433567] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.433573] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 11.464148] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.464154] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.508831] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.508837] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 11.658861] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) ->=
 IRQ 16
[=A0=A0 11.658876] vgaarb: device changed decodes: PCI:0000:01:00.0,olddeco=
des=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[=A0=A0 11.659194] NVRM: loading NVIDIA UNIX x86 Kernel Module=A0 173.14.30=
=A0 Thu Apr 14 08:47:14 PDT 2011
[=A0=A0 11.756126] EXT4-fs (sdb1): mounted filesystem with ordered data mod=
e. Opts: (null)
[=A0=A0 11.801076] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 11.801084] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 11.837031] Intel ICH 0000:00:1f.5: PCI INT B -> GSI 17 (level, low)=
 -> IRQ 17
[=A0=A0 11.837080] Intel ICH 0000:00:1f.5: setting latency timer to 64
[=A0=A0 12.081699] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.081704] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.128144] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.128149] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.176131] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.176137] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.209085] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.209090] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.256689] intel8x0_measure_ac97_clock: measured 51650 usecs (2489 =
samples)
[=A0=A0 12.256694] intel8x0: clocking to 48000
[=A0=A0 12.256731] PM: Adding info for No Bus:card0
[=A0=A0 12.256916] PM: Adding info for No Bus:pcmC0D4p
[=A0=A0 12.256997] PM: Adding info for No Bus:pcmC0D3c
[=A0=A0 12.257064] PM: Adding info for No Bus:pcmC0D2c
[=A0=A0 12.257137] PM: Adding info for No Bus:pcmC0D1c
[=A0=A0 12.257220] PM: Adding info for No Bus:pcmC0D0p
[=A0=A0 12.257302] PM: Adding info for No Bus:pcmC0D0c
[=A0=A0 12.257353] PM: Adding info for ac97:0-0:AD1980
[=A0=A0 12.257419] PM: Adding info for No Bus:controlC0
[=A0=A0 12.303070] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.303081] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.334090] EXT4-fs (md2): mounted filesystem with ordered data mode=
. Opts: (null)
[=A0=A0 12.609615] EXT4-fs (sdb10): mounted filesystem with ordered data mo=
de. Opts: (null)
[=A0=A0 12.624222] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 12.624227] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 12.656366] EXT4-fs (md4): mounted filesystem with ordered data mode=
. Opts: (null)
[=A0=A0 12.884548] ADDRCONF(NETDEV_UP): eth0: link is not ready
[=A0=A0 12.886846] e100 0000:02:08.0: eth0: NIC Link is Up 100 Mbps Full Du=
plex
[=A0=A0 12.903962] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[=A0=A0 13.731510] type=3D1400 audit(1311333009.781:8): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/share/gdm/guest-session/Xsession" =
pid=3D1001 comm=3D"apparmor_parser"
[=A0=A0 13.758148] type=3D1400 audit(1311333009.808:9): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/lib/cups/backend/cups-pdf" pid=3D9=
74 comm=3D"apparmor_parser"
[=A0=A0 13.758447] type=3D1400 audit(1311333009.808:10): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/sbin/cupsd" pid=3D974 comm=3D"app=
armor_parser"
[=A0=A0 13.828206] type=3D1400 audit(1311333009.878:11): apparmor=3D"STATUS=
" operation=3D"profile_replace" name=3D"/sbin/dhclient3" pid=3D1002 comm=3D=
"apparmor_parser"
[=A0=A0 13.902262] PM: Adding info for i2c:i2c-1
[=A0=A0 13.902340] PM: Adding info for No Bus:i2c-1
[=A0=A0 13.902762] PM: Adding info for i2c:i2c-2
[=A0=A0 13.902845] PM: Adding info for No Bus:i2c-2
[=A0=A0 13.903243] PM: Adding info for i2c:i2c-3
[=A0=A0 13.903324] PM: Adding info for No Bus:i2c-3
[=A0=A0 18.435507] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 18.435515] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 18.455175] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 18.455181] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 18.481980] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 18.481987] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 18.793069] EXT4-fs (md1): re-mounted. Opts: errors=3Dremount-ro,com=
mit=3D0
[=A0=A0 19.402736] EXT4-fs (md3): re-mounted. Opts: commit=3D0
[=A0=A0 19.413552] EXT4-fs (sdb1): re-mounted. Opts: commit=3D0
[=A0=A0 19.420227] EXT4-fs (md2): re-mounted. Opts: commit=3D0
[=A0=A0 19.569355] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.569363] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.574467] EXT4-fs (sdb10): re-mounted. Opts: commit=3D0
[=A0=A0 19.577047] PM: Adding info for No Bus:ep_82
[=A0=A0 19.577685] PM: Removing info for No Bus:ep_82
[=A0=A0 19.577733] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.577741] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.578762] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.578770] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.578954] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.578963] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.579753] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.579761] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.579908] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.579914] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.582065] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.582073] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.582293] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.582300] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.583042] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.583049] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.590518] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.590526] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.590862] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.590869] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.590985] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.590991] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.591260] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.591266] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.591376] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.591382] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.591676] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.591682] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.591853] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.591860] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.592154] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.592161] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.592823] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.592830] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.595875] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.595883] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.596031] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.596038] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.603862] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.603871] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.604027] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.604034] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.605092] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.605100] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.605296] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.605302] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.606451] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.606458] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.608603] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.608613] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.609874] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.609883] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.610650] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.610658] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.612247] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.612255] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.612408] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.612415] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.620353] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.620365] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.620625] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.620632] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.622085] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.622093] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.622815] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 19.622822] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 19.626622] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 19.626632] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 19.628700] PM: Adding info for No Bus:ep_82
[=A0=A0 19.812516] EXT4-fs (md4): re-mounted. Opts: commit=3D0
[=A0=A0 23.510025] eth0: no IPv6 routers present
[=A0=A0 25.198732] PM: Removing info for No Bus:ep_82
[=A0=A0 25.198775] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 25.198782] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 26.270146] audit_printk_skb: 6 callbacks suppressed
[=A0=A0 26.270152] type=3D1400 audit(1311333022.321:14): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/bin/evince" pid=3D1079 comm=3D"ap=
parmor_parser"
[=A0=A0 26.271348] type=3D1400 audit(1311333022.321:15): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/bin/evince-previewer" pid=3D1079 =
comm=3D"apparmor_parser"
[=A0=A0 26.272519] type=3D1400 audit(1311333022.321:16): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/bin/evince-thumbnailer" pid=3D107=
9 comm=3D"apparmor_parser"
[=A0=A0 26.826331] type=3D1400 audit(1311333022.875:17): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/lib/libvirt/virt-aa-helper" pid=
=3D1083 comm=3D"apparmor_parser"
[=A0=A0 26.928585] type=3D1400 audit(1311333022.978:18): apparmor=3D"STATUS=
" operation=3D"profile_replace" name=3D"/usr/lib/cups/backend/cups-pdf" pid=
=3D1251 comm=3D"apparmor_parser"
[=A0=A0 26.928872] type=3D1400 audit(1311333022.978:19): apparmor=3D"STATUS=
" operation=3D"profile_replace" name=3D"/usr/sbin/cupsd" pid=3D1251 comm=3D=
"apparmor_parser"
[=A0=A0 27.131414] type=3D1400 audit(1311333023.181:20): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/sbin/mysqld-akonadi" pid=3D1253 c=
omm=3D"apparmor_parser"
[=A0=A0 27.335196] type=3D1400 audit(1311333023.385:21): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/sbin/tcpdump" pid=3D1254 comm=3D"=
apparmor_parser"
[=A0=A0 27.598969] type=3D1400 audit(1311333023.648:22): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/sbin/libvirtd" pid=3D1252 comm=3D=
"apparmor_parser"
[=A0=A0 27.712297] microcode: CPU0 updated to revision 0x2e, date =3D 2004-=
08-11
[=A0=A0 27.712899] microcode: CPU1 updated to revision 0x2e, date =3D 2004-=
08-11
[=A0=A0 42.514801] PM: Adding info for No Bus:0:20
[=A0=A0 42.845956] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.845963] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.846888] PM: Adding info for No Bus:ep_82
[=A0=A0 42.847415] PM: Removing info for No Bus:ep_82
[=A0=A0 42.847464] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.847472] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.848674] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.848683] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.849063] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.849071] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.850948] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.850957] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.851356] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.851365] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.852670] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.852678] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.853090] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.853099] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.854537] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.854545] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.855472] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.855482] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.855843] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.855851] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.856164] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.856172] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.856506] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.856513] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.857248] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.857257] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.857667] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.857675] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.858088] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.858096] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.858468] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.858476] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.859380] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.859388] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.861373] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.861384] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.861780] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.861788] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.863630] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.863639] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.864026] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.864036] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.865646] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.865655] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.866038] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.866046] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.868377] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.868386] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.869536] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.869545] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.871410] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.871418] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.871750] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.871759] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.873230] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.873237] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.873674] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.873684] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.875275] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.875291] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.875705] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.875714] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.877387] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.877395] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.878441] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 42.878449] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 42.881497] snd-usb-audio 2-1:1.1: rpm_resume flags 0x4
[=A0=A0 42.881505] snd-usb-audio 2-1:1.1: rpm_resume returns 0
[=A0=A0 42.883586] PM: Adding info for No Bus:ep_82
[=A0=A0 43.439625] usbhid 3-1:1.0: rpm_resume flags 0x5
[=A0=A0 43.439634] usbhid 3-1:1.0: rpm_resume returns 0
[=A0=A0 43.442935] usbhid 3-1:1.0: rpm_suspend flags 0x5
[=A0=A0 43.442942] usbhid 3-1:1.0: rpm_suspend returns 0
[=A0=A0 48.261710] PM: Removing info for No Bus:ep_82
[=A0=A0 48.261746] snd-usb-audio 2-1:1.1: rpm_suspend flags 0x4
[=A0=A0 48.261751] snd-usb-audio 2-1:1.1: rpm_suspend returns 0
[=A0=A0 73.969053] sd 0:0:0:0: rpm_resume flags 0x4
[=A0=A0 73.969060] sd 0:0:0:0: rpm_resume returns 1
[=A0=A0 73.974154] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 73.974160] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 73.986082] sd 3:0:0:0: rpm_resume flags 0x4
[=A0=A0 73.986089] sd 3:0:0:0: rpm_resume returns 1
[=A0=A0 95.568745] sd 2:0:0:0: rpm_resume flags 0x4
[=A0=A0 95.568752] sd 2:0:0:0: rpm_resume returns 1
[=A0=A0 95.617205] EXT4-fs (sdb9): warning: maximal mount count reached, ru=
nning e2fsck is recommended
[=A0=A0 95.619447] EXT4-fs (sdb9): mounted filesystem with ordered data mod=
e. Opts: (null)
[ 1844.046396] sd 3:0:0:0: rpm_resume flags 0x4
[ 1844.046403] sd 3:0:0:0: rpm_resume returns 1
[ 1844.047624] sd 0:0:0:0: rpm_resume flags 0x4
[ 1844.047632] sd 0:0:0:0: rpm_resume returns 1
[ 1844.049060] sd 2:0:0:0: rpm_resume flags 0x4
[ 1844.049067] sd 2:0:0:0: rpm_resume returns 1
[ 3644.031675] sd 0:0:0:0: rpm_resume flags 0x4
[ 3644.031682] sd 0:0:0:0: rpm_resume returns 1
[ 3644.034184] sd 3:0:0:0: rpm_resume flags 0x4
[ 3644.034192] sd 3:0:0:0: rpm_resume returns 1
[ 3644.035693] sd 2:0:0:0: rpm_resume flags 0x4
[ 3644.035701] sd 2:0:0:0: rpm_resume returns 1

Info from /proc/cpuinfo:

processor=A0=A0=A0 : 0
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 15
model=A0=A0=A0 =A0=A0=A0 : 2
model name=A0=A0=A0 : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping=A0=A0=A0 : 9
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2793.580
cache size=A0=A0=A0 : 512 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 2
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 1
apicid=A0=A0=A0 =A0=A0=A0 : 0
initial apicid=A0=A0=A0 : 0
fdiv_bug=A0=A0=A0 : no
hlt_bug=A0=A0=A0 =A0=A0=A0 : no
f00f_bug=A0=A0=A0 : no
coma_bug=A0=A0=A0 : no
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 2
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe peb=
s bts cid xtpr
bogomips=A0=A0=A0 : 5589.95
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 128
address sizes=A0=A0=A0 : 36 bits physical, 32 bits virtual
power management:

processor=A0=A0=A0 : 1
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 15
model=A0=A0=A0 =A0=A0=A0 : 2
model name=A0=A0=A0 : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping=A0=A0=A0 : 9
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2793.580
cache size=A0=A0=A0 : 512 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 2
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 1
apicid=A0=A0=A0 =A0=A0=A0 : 1
initial apicid=A0=A0=A0 : 1
fdiv_bug=A0=A0=A0 : no
hlt_bug=A0=A0=A0 =A0=A0=A0 : no
f00f_bug=A0=A0=A0 : no
coma_bug=A0=A0=A0 : no
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 2
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe peb=
s bts cid xtpr
bogomips=A0=A0=A0 : 5587.31
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 128
address sizes=A0=A0=A0 : 36 bits physical, 32 bits virtual
power management:

Info /proc/interrupts:

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0=A0=A0=A0=A0=A0=A0 CPU1=A0=A0=A0=A0=A0=
=A0 =

=A0 0:=A0=A0=A0=A0=A0=A0=A0=A0 84=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-API=
C-edge=A0=A0=A0=A0=A0 timer
=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-A=
PIC-edge=A0=A0=A0=A0=A0 i8042
=A0 4:=A0=A0=A0=A0=A0=A0=A0 104=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-=
edge=A0=A0=A0 =

=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-A=
PIC-edge=A0=A0=A0=A0=A0 rtc0
=A0 9:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-A=
PIC-fasteoi=A0=A0 acpi
=A012:=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-A=
PIC-edge=A0=A0=A0=A0=A0 i8042
=A014:=A0=A0=A0=A0=A0=A0=A0 428=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-=
edge=A0=A0=A0=A0=A0 ata_piix
=A015:=A0=A0=A0=A0=A0=A0=A0=A0 16=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-API=
C-edge=A0=A0=A0=A0=A0 ata_piix
=A016:=A0=A0=A0=A0 525872=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-fasteo=
i=A0=A0 uhci_hcd:usb2, uhci_hcd:usb5, nvidia
=A017:=A0=A0=A0=A0=A0=A0=A0 227=A0=A0=A0=A0=A0 12275=A0=A0 IO-APIC-fasteoi=
=A0=A0 Intel ICH5
=A018:=A0=A0=A0=A0=A0=A0 5412=A0=A0=A0=A0=A0 31022=A0=A0 IO-APIC-fasteoi=A0=
=A0 ata_piix, uhci_hcd:usb4
=A019:=A0=A0=A0=A0=A0=A0=A0=A0 57=A0=A0=A0=A0=A0 17605=A0=A0 IO-APIC-fasteo=
i=A0=A0 uhci_hcd:usb3
=A020:=A0=A0=A0=A0=A0=A0 9894=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-fa=
steoi=A0=A0 eth0
=A023:=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IO-A=
PIC-fasteoi=A0=A0 ehci_hcd:usb1
NMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Non-ma=
skable interrupts
LOC:=A0=A0=A0=A0 817807=A0=A0=A0 1037941=A0=A0 Local timer interrupts
SPU:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Spurio=
us interrupts
PMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Perfor=
mance monitoring interrupts
IWI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 IRQ wo=
rk interrupts
RES:=A0=A0=A0 1100881=A0=A0=A0 1058033=A0=A0 Rescheduling interrupts
CAL:=A0=A0=A0=A0=A0=A0 3328=A0=A0=A0=A0=A0=A0 3274=A0=A0 Function call inte=
rrupts
TLB:=A0=A0=A0=A0=A0 23337=A0=A0=A0=A0=A0 18220=A0=A0 TLB shootdowns
TRM:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Therma=
l event interrupts
THR:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Thresh=
old APIC interrupts
MCE:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0 Machin=
e check exceptions
MCP:=A0=A0=A0=A0=A0=A0=A0=A0 16=A0=A0=A0=A0=A0=A0=A0=A0 16=A0=A0 Machine ch=
eck polls
ERR:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
MIS:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0

Info from /proc/timers_list:

Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 4551094137590 nsecs

cpu: 0
=A0clock 0:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef002c84
=A0 .index:=A0=A0=A0=A0=A0 0
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get_real
=A0 .offset:=A0=A0=A0=A0 1311332996054684268 nsecs
active timers:
=A0clock 1:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef002cb0
=A0 .index:=A0=A0=A0=A0=A0 1
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get
=A0 .offset:=A0=A0=A0=A0 0 nsecs
active timers:
=A0#0: <ef002d40>, tick_sched_timer, S:01
=A0# expires at 4551096211557-4551096211557 nsecs [in 2073967 to 2073967 ns=
ecs]
=A0#1: <e5f01b94>, hrtimer_wakeup, S:01
=A0# expires at 4551101506798-4551101556798 nsecs [in 7369208 to 7419208 ns=
ecs]
=A0#2: <d577beb8>, hrtimer_wakeup, S:01
=A0# expires at 4551113306390-4551113356390 nsecs [in 19168800 to 19218800 =
nsecs]
=A0#3: <d5633b94>, hrtimer_wakeup, S:01
=A0# expires at 4551115894172-4551115994170 nsecs [in 21756582 to 21856580 =
nsecs]
=A0#4: <e5f23b94>, hrtimer_wakeup, S:01
=A0# expires at 4551123172772-4551123372771 nsecs [in 29035182 to 29235181 =
nsecs]
=A0#5: <edebdb94>, hrtimer_wakeup, S:01
=A0# expires at 4551467318671-4551468919670 nsecs [in 373181081 to 37478208=
0 nsecs]
=A0#6: <d85a5f60>, hrtimer_wakeup, S:01
=A0# expires at 4551479385868-4551479435868 nsecs [in 385248278 to 38529827=
8 nsecs]
=A0#7: <d87adb94>, hrtimer_wakeup, S:01
=A0# expires at 4551489953808-4551490953807 nsecs [in 395816218 to 39681621=
7 nsecs]
=A0#8: <edebfb94>, hrtimer_wakeup, S:01
=A0# expires at 4551559991971-4551560490970 nsecs [in 465854381 to 46635338=
0 nsecs]
=A0#9: <e51d5b1c>, hrtimer_wakeup, S:01
=A0# expires at 4551590728146-4551591227143 nsecs [in 496590556 to 49708955=
3 nsecs]
=A0#10: <d87afb94>, hrtimer_wakeup, S:01
=A0# expires at 4551675876062-4551676872061 nsecs [in 581738472 to 58273447=
1 nsecs]
=A0#11: <edef7b94>, hrtimer_wakeup, S:01
=A0# expires at 4551866071158-4551868366156 nsecs [in 771933568 to 77422856=
6 nsecs]
=A0#12: <e5d85b94>, hrtimer_wakeup, S:01
=A0# expires at 4552865704837-4552872360835 nsecs [in 1771567247 to 1778223=
245 nsecs]
=A0#13: <ec79db94>, hrtimer_wakeup, S:01
=A0# expires at 4553092642815-4553094642814 nsecs [in 1998505225 to 2000505=
224 nsecs]
=A0#14: <e5e81b1c>, hrtimer_wakeup, S:01
=A0# expires at 4554486236554-4554496236553 nsecs [in 3392098964 to 3402098=
963 nsecs]
=A0#15: <eda19b94>, hrtimer_wakeup, S:01
=A0# expires at 4554865923559-4554869697557 nsecs [in 3771785969 to 3775559=
967 nsecs]
=A0#16: <d5551b94>, hrtimer_wakeup, S:01
=A0# expires at 4554865736544-4554874391542 nsecs [in 3771598954 to 3780253=
952 nsecs]
=A0#17: <eb6a9b94>, hrtimer_wakeup, S:01
=A0# expires at 4552999618764-4555499618764 nsecs [in 1905481174 to 4405481=
174 nsecs]
=A0#18: <eb6abb94>, hrtimer_wakeup, S:01
=A0# expires at 4557999612873-4557999612873 nsecs [in 6905475283 to 6905475=
283 nsecs]
=A0#19: <d56cfeb8>, hrtimer_wakeup, S:01
=A0# expires at 4562785638395-4562785688395 nsecs [in 11691500805 to 116915=
50805 nsecs]
=A0#20: <d540fb94>, hrtimer_wakeup, S:01
=A0# expires at 4563946781905-4563964519904 nsecs [in 12852644315 to 128703=
82314 nsecs]
=A0#21: <edf27f60>, hrtimer_wakeup, S:01
=A0# expires at 4565064431181-4565064481181 nsecs [in 13970293591 to 139703=
43591 nsecs]
=A0#22: <eda25b94>, hrtimer_wakeup, S:01
=A0# expires at 4571866310844-4571890864842 nsecs [in 20772173254 to 207967=
27252 nsecs]
=A0#23: <ec799b1c>, hrtimer_wakeup, S:01
=A0# expires at 4590953964226-4591013964224 nsecs [in 39859826636 to 399198=
26634 nsecs]
=A0#24: <d549db94>, hrtimer_wakeup, S:01
=A0# expires at 4597866323649-4597917974647 nsecs [in 46772186059 to 468238=
37057 nsecs]
=A0#25: <edeffb94>, hrtimer_wakeup, S:01
=A0# expires at 4844865696222-4844965696222 nsecs [in 293771558632 to 29387=
1558632 nsecs]
=A0#26: <e5eb1f60>, hrtimer_wakeup, S:01
=A0# expires at 7227782069813-7227782119813 nsecs [in 2676687932223 to 2676=
687982223 nsecs]
=A0clock 2:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef002cdc
=A0 .index:=A0=A0=A0=A0=A0 7
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get_boottime
=A0 .offset:=A0=A0=A0=A0 0 nsecs
active timers:
=A0 .expires_next=A0=A0 : 4551096211557 nsecs
=A0 .hres_active=A0=A0=A0 : 1
=A0 .nr_events=A0=A0=A0=A0=A0 : 823531
=A0 .nr_retries=A0=A0=A0=A0 : 663
=A0 .nr_hangs=A0=A0=A0=A0=A0=A0 : 0
=A0 .max_hang_time=A0 : 0 nsecs
=A0 .nohz_mode=A0=A0=A0=A0=A0 : 2
=A0 .idle_tick=A0=A0=A0=A0=A0 : 4551092878224 nsecs
=A0 .tick_stopped=A0=A0 : 0
=A0 .idle_jiffies=A0=A0 : 1275327
=A0 .idle_calls=A0=A0=A0=A0 : 1865391
=A0 .idle_sleeps=A0=A0=A0 : 1613239
=A0 .idle_entrytime : 4551092719226 nsecs
=A0 .idle_waketime=A0 : 4551080517851 nsecs
=A0 .idle_exittime=A0 : 4551092719226 nsecs
=A0 .idle_sleeptime : 3527968796920 nsecs
=A0 .iowait_sleeptime: 13982097290 nsecs
=A0 .last_jiffies=A0=A0 : 1275327
=A0 .next_jiffies=A0=A0 : 1275371
=A0 .idle_expires=A0=A0 : 4551236211543 nsecs
jiffies: 1275328

cpu: 1
=A0clock 0:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef102c84
=A0 .index:=A0=A0=A0=A0=A0 0
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get_real
=A0 .offset:=A0=A0=A0=A0 1311332996054684268 nsecs
active timers:
=A0clock 1:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef102cb0
=A0 .index:=A0=A0=A0=A0=A0 1
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get
=A0 .offset:=A0=A0=A0=A0 0 nsecs
active timers:
=A0#0: <ef102d40>, tick_sched_timer, S:01
=A0# expires at 4551096211557-4551096211557 nsecs [in 2073967 to 2073967 ns=
ecs]
=A0#1: <df84deb8>, hrtimer_wakeup, S:01
=A0# expires at 4551099812342-4551099862342 nsecs [in 5674752 to 5724752 ns=
ecs]
=A0#2: <e5eedb80>, hrtimer_wakeup, S:01
=A0# expires at 4551196903883-4551196903883 nsecs [in 102766293 to 10276629=
3 nsecs]
=A0#3: <d8609b94>, hrtimer_wakeup, S:01
=A0# expires at 4551264581369-4551288946368 nsecs [in 170443779 to 19480877=
8 nsecs]
=A0#4: <e5c97b94>, hrtimer_wakeup, S:01
=A0# expires at 4551678301437-4551679301436 nsecs [in 584163847 to 58516384=
6 nsecs]
=A0#5: <e512fb80>, hrtimer_wakeup, S:01
=A0# expires at 4551977859864-4551982854261 nsecs [in 883722274 to 88871667=
1 nsecs]
=A0#6: <b06b8054>, sched_rt_period_timer, S:01
=A0# expires at 4552000000000-4552000000000 nsecs [in 905862410 to 90586241=
0 nsecs]
=A0#7: <edf25f60>, hrtimer_wakeup, S:01
=A0# expires at 4558945318490-4558945368490 nsecs [in 7851180900 to 7851230=
900 nsecs]
=A0#8: <e416bb94>, hrtimer_wakeup, S:01
=A0# expires at 4560928692128-4561028692128 nsecs [in 9834554538 to 9934554=
538 nsecs]
=A0#9: <df81beb8>, hrtimer_wakeup, S:01
=A0# expires at 4562125261331-4562125311331 nsecs [in 11031123741 to 110311=
73741 nsecs]
=A0#10: <e41f1b1c>, hrtimer_wakeup, S:01
=A0# expires at 4575451717605-4575481717603 nsecs [in 24357580015 to 243875=
80013 nsecs]
=A0#11: <d865fb94>, hrtimer_wakeup, S:01
=A0# expires at 4849012929504-4849112929504 nsecs [in 297918791914 to 29801=
8791914 nsecs]
=A0#12: <e5fa1b94>, hrtimer_wakeup, S:01
=A0# expires at 5443945795991-5444045795991 nsecs [in 892851658401 to 89295=
1658401 nsecs]
=A0#13: <d868bb94>, hrtimer_wakeup, S:01
=A0# expires at 7248865901250-7248965901250 nsecs [in 2697771763660 to 2697=
871763660 nsecs]
=A0clock 2:
=A0 .base:=A0=A0=A0=A0=A0=A0 ef102cdc
=A0 .index:=A0=A0=A0=A0=A0 7
=A0 .resolution: 1 nsecs
=A0 .get_time:=A0=A0 ktime_get_boottime
=A0 .offset:=A0=A0=A0=A0 0 nsecs
active timers:
=A0 .expires_next=A0=A0 : 4551096211557 nsecs
=A0 .hres_active=A0=A0=A0 : 1
=A0 .nr_events=A0=A0=A0=A0=A0 : 1043757
=A0 .nr_retries=A0=A0=A0=A0 : 2023
=A0 .nr_hangs=A0=A0=A0=A0=A0=A0 : 0
=A0 .max_hang_time=A0 : 0 nsecs
=A0 .nohz_mode=A0=A0=A0=A0=A0 : 2
=A0 .idle_tick=A0=A0=A0=A0=A0 : 4551092878224 nsecs
=A0 .tick_stopped=A0=A0 : 0
=A0 .idle_jiffies=A0=A0 : 1275327
=A0 .idle_calls=A0=A0=A0=A0 : 1716295
=A0 .idle_sleeps=A0=A0=A0 : 1516658
=A0 .idle_entrytime : 4551092900933 nsecs
=A0 .idle_waketime=A0 : 4551090651128 nsecs
=A0 .idle_exittime=A0 : 4551091266698 nsecs
=A0 .idle_sleeptime : 3638641266855 nsecs
=A0 .iowait_sleeptime: 32205960960 nsecs
=A0 .last_jiffies=A0=A0 : 1275328
=A0 .next_jiffies=A0=A0 : 1275329
=A0 .idle_expires=A0=A0 : 4551249544875 nsecs
jiffies: 1275328


Tick Device: mode:=A0=A0=A0=A0 1
Broadcast device
Clock Event Device: hpet
=A0max_delta_ns:=A0=A0 149983005959
=A0min_delta_ns:=A0=A0 13409
=A0mult:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 61496114
=A0shift:=A0=A0=A0=A0=A0=A0=A0=A0=A0 32
=A0mode:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0next_event:=A0=A0=A0=A0 9223372036854775807 nsecs
=A0set_next_event: hpet_legacy_next_event
=A0set_mode:=A0=A0=A0=A0=A0=A0 hpet_legacy_set_mode
=A0event_handler:=A0 tick_handle_oneshot_broadcast
=A0retries:=A0=A0=A0=A0=A0=A0=A0 0
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:=A0=A0=A0=A0 1
Per CPU device: 0
Clock Event Device: lapic
=A0max_delta_ns:=A0=A0 172228809760
=A0min_delta_ns:=A0=A0 1203
=A0mult:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 53553015
=A0shift:=A0=A0=A0=A0=A0=A0=A0=A0=A0 32
=A0mode:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0next_event:=A0=A0=A0=A0 4551096211557 nsecs
=A0set_next_event: lapic_next_event
=A0set_mode:=A0=A0=A0=A0=A0=A0 lapic_timer_setup
=A0event_handler:=A0 hrtimer_interrupt
=A0retries:=A0=A0=A0=A0=A0=A0=A0 1

Tick Device: mode:=A0=A0=A0=A0 1
Per CPU device: 1
Clock Event Device: lapic
=A0max_delta_ns:=A0=A0 172228809760
=A0min_delta_ns:=A0=A0 1203
=A0mult:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 53553015
=A0shift:=A0=A0=A0=A0=A0=A0=A0=A0=A0 32
=A0mode:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0next_event:=A0=A0=A0=A0 4551096211557 nsecs
=A0set_next_event: lapic_next_event
=A0set_mode:=A0=A0=A0=A0=A0=A0 lapic_timer_setup
=A0event_handler:=A0 hrtimer_interrupt
=A0retries:=A0=A0=A0=A0=A0=A0=A0 0

Unfortunately, I do not know C, so I have no idea what to do next.=A0 Any h=
elp is greatly appreciated.
Thank you.
Towheed Mohammed
