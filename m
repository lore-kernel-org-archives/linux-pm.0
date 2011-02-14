From: Dirk Hohndel <hohndel@infradead.org>
Subject: Re: USB suspend issue with 2.6.38-rc2 -- still there in
	RC4-g795abaf
Date: Mon, 14 Feb 2011 11:18:47 -0800
Message-ID: <m31v3abf1k.fsf__23865.0699997836$1297894430$gmane$org@x201s.gr8dns.org>
References: <Pine.LNX.4.44L0.1101251021310.1867-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101251021310.1867-100000@iolanthe.rowland.org>
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
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Linux USB List <linux-usb@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=


Hi Alan,

(to the newly added mailing lists - this is a suspend issue with a
Thinkpad X201s. At times it won't suspend... so far USB has been
identified as the culprit... here's more information that Alan requested)

On Tue, 25 Jan 2011 10:24:53 -0500 (EST), Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 24 Jan 2011, Dirk Hohndel wrote:
> 
> > > Try building a kernel with CONFIG_USB_DEBUG enabled and see what shows
> > > up in the log.  Do you know what the 1-1 device is?  (It will show up 
> > > in the debug-enabled log, so don't worry if you don't know.)
> > 
> > Jan 24 17:51:27 x201s kernel: [  291.773727] Freezing user space processes ... (elapsed 0.01 seconds) done.
> > Jan 24 17:51:27 x201s kernel: [  291.785416] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> > Jan 24 17:51:27 x201s kernel: [  291.796593] Suspending console(s) (use no_console_suspend to debug)
> > Jan 24 17:51:27 x201s kernel: [  291.920386] hub 1-1:1.0: suspend error -16
> > Jan 24 17:51:27 x201s kernel: [  291.920396] pm_op(): usb_dev_suspend+0x0/0x15 returns -16
> > Jan 24 17:51:27 x201s kernel: [  291.920400] PM: Device 1-1 failed to suspend: error -16
> > Jan 24 17:51:27 x201s kernel: [  291.920403] PM: Some devices failed to suspend
> > Jan 24 17:51:27 x201s kernel: [  291.997903] PM: resume of devices complete after 77.528 msecs
> > Jan 24 17:51:27 x201s kernel: [  291.998062] Restarting tasks ... 
> 
> It might help to see the dmesg output rather than the system log file.  
> Include everything going back to the boot.

Here's the latest, with the latest kernel from Linus: 2.6.38-rc4-00178-g795abaf
which includes the commit that you mentioned bf3d7d40e42a85ca73a34e1385ff34f092a384eb

I did a successfull suspend / resume while the system was in the docking
station - that's around seconds 42-44 in the dmesg output.

Next I undock and do another suspend attempt - starts around second
57. This one failed again, but now we have much more information from
the dmesg output - attached all the way from reboot.

> > 1-1 appears to be my built-in root hub.
> 
> No, the root hub is usb1.  1-1 is the device plugged into port 1 of the
> root hub.  If you have a debugfs filesystem mounted, you can see the
> device list in /sys/kernel/debug/usb/devices.

I'm attaching that as well :-)

Let me know what else I should send / try.

/D


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=dmesg.txt
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.38-rc4-00178-g795abaf (hohndel@x201s.gr8dn=
s.org) (gcc version 4.5.1 20100924 (Red Hat 4.5.1-4) (GCC) ) #15 SMP Mon Fe=
b 14 09:59:06 PST 2011
[    0.000000] Command line: ro root=3DUUID=3Dc01e3070-03ef-4331-932f-fa23e=
59001b6 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=3Den_US.UTF-8 SYSFONT=
=3Dlatarcyrheb-sun16 KEYTABLE=3Dus rhgb quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bb27c000 (usable)
[    0.000000]  BIOS-e820: 00000000bb27c000 - 00000000bb282000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb282000 - 00000000bb363000 (usable)
[    0.000000]  BIOS-e820: 00000000bb363000 - 00000000bb375000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb375000 - 00000000bb3f6000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bb3f6000 - 00000000bb40f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb40f000 - 00000000bb470000 (usable)
[    0.000000]  BIOS-e820: 00000000bb470000 - 00000000bb668000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb668000 - 00000000bb6e8000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bb6e8000 - 00000000bb70f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb70f000 - 00000000bb717000 (usable)
[    0.000000]  BIOS-e820: 00000000bb717000 - 00000000bb71f000 (reserved)
[    0.000000]  BIOS-e820: 00000000bb71f000 - 00000000bb76c000 (usable)
[    0.000000]  BIOS-e820: 00000000bb76c000 - 00000000bb778000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bb778000 - 00000000bb77b000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bb77b000 - 00000000bb78b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bb78b000 - 00000000bb78c000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bb78c000 - 00000000bb79f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bb79f000 - 00000000bb7ff000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bb7ff000 - 00000000bb800000 (usable)
[    0.000000]  BIOS-e820: 00000000bb800000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000feaff000 - 00000000feb00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 00000001fc000000 (usable)
[    0.000000]  BIOS-e820: 0000000200000000 - 000000023c000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: 5129CTO/5129CTO, BIOS 6QET35WW (1.05 ) 01/26/2010
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usab=
le) =3D=3D> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usab=
le)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn =3D 0x23c000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 disabled
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 100000000 mask F00000000 write-back
[    0.000000]   4 base 200000000 mask FC0000000 write-back
[    0.000000]   5 base 23C000000 mask FFC000000 uncachable
[    0.000000]   6 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] original variable MTRRs
[    0.000000] reg 1, base: 0GB, range: 2GB, type WB
[    0.000000] reg 2, base: 2GB, range: 1GB, type WB
[    0.000000] reg 3, base: 4GB, range: 4GB, type WB
[    0.000000] reg 4, base: 8GB, range: 1GB, type WB
[    0.000000] reg 5, base: 9152MB, range: 64MB, type UC
[    0.000000] reg 6, base: 3008MB, range: 64MB, type UC
[    0.000000] total RAM covered: 8064M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 128M 	num_reg: 6  	lose cover R=
AM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3008MB, range: 64MB, type UC
[    0.000000] reg 3, base: 4GB, range: 4GB, type WB
[    0.000000] reg 4, base: 8GB, range: 1GB, type WB
[    0.000000] reg 5, base: 9152MB, range: 64MB, type UC
[    0.000000] e820 update range: 00000000bc000000 - 0000000100000000 (usab=
le) =3D=3D> (reserved)
[    0.000000] last_pfn =3D 0xbb800 max_arch_pfn =3D 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f6920] f6920
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000bb800000
[    0.000000]  0000000000 - 00bb800000 page 2M
[    0.000000] kernel direct mapping tables up to bb800000 @ 1fffc000-20000=
000
[    0.000000] init_memory_mapping: 0000000100000000-000000023c000000
[    0.000000]  0100000000 - 023c000000 page 2M
[    0.000000] kernel direct mapping tables up to 23c000000 @ bb762000-bb76=
c000
[    0.000000] RAMDISK: 37970000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000f68f0 00024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 00000000bb7f08fb 00094 (v01 LENOVO TP-6Q    00001=
050  LTP 00000000)
[    0.000000] ACPI: FACP 00000000bb7f0a00 000F4 (v04 LENOVO TP-6Q    00001=
050 LNVO 00000001)
[    0.000000] ACPI: DSDT 00000000bb7f0d6b 0DD9B (v01 LENOVO TP-6Q    00001=
050 MSFT 03000001)
[    0.000000] ACPI: FACS 00000000bb6e7000 00040
[    0.000000] ACPI: SSDT 00000000bb7f0bb4 001B7 (v01 LENOVO TP-6Q    00001=
050 MSFT 03000001)
[    0.000000] ACPI: ECDT 00000000bb7feb06 00052 (v01 LENOVO TP-6Q    00001=
050 LNVO 00000001)
[    0.000000] ACPI: APIC 00000000bb7feb58 00084 (v01 LENOVO TP-6Q    00001=
050 LNVO 00000001)
[    0.000000] ACPI: MCFG 00000000bb7fec14 0003C (v01 LENOVO TP-6Q    00001=
050 LNVO 00000001)
[    0.000000] ACPI: HPET 00000000bb7fec50 00038 (v01 LENOVO TP-6Q    00001=
050 LNVO 00000001)
[    0.000000] ACPI: ASF! 00000000bb7fedbe 000A4 (v16 LENOVO TP-6Q    00001=
050 PTL  00000001)
[    0.000000] ACPI: SLIC 00000000bb7fee62 00176 (v01 LENOVO TP-6Q    00001=
050  LTP 00000000)
[    0.000000] ACPI: BOOT 00000000bb7fefd8 00028 (v01 LENOVO TP-6Q    00001=
050  LTP 00000001)
[    0.000000] ACPI: SSDT 00000000bb6e590a 0085B (v01 LENOVO TP-6Q    00001=
050 INTL 20050513)
[    0.000000] ACPI: TCPA 00000000bb78b000 00032 (v02    PTL  CRESTLN 06040=
000      00005A52)
[    0.000000] ACPI: SSDT 00000000bb77a000 009F1 (v01  PmRef    CpuPm 00003=
000 INTL 20050513)
[    0.000000] ACPI: SSDT 00000000bb779000 00259 (v01  PmRef  Cpu0Tst 00003=
000 INTL 20050513)
[    0.000000] ACPI: SSDT 00000000bb778000 0049F (v01  PmRef    ApTst 00003=
000 INTL 20050513)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0007dfffff] PMD -> [ffff8800a800000=
0-ffff8800aeffffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0023c000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[9] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000bb27c
[    0.000000]     0: 0x000bb282 -> 0x000bb363
[    0.000000]     0: 0x000bb40f -> 0x000bb470
[    0.000000]     0: 0x000bb70f -> 0x000bb717
[    0.000000]     0: 0x000bb71f -> 0x000bb76c
[    0.000000]     0: 0x000bb7ff -> 0x000bb800
[    0.000000]     0: 0x00100000 -> 0x001fc000
[    0.000000]     0: 0x00200000 -> 0x0023c000
[    0.000000] On node 0 totalpages: 2044834
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 6 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 748620 pages, LIFO batch:31
[    0.000000]   Normal zone: 17696 pages used for memmap
[    0.000000]   Normal zone: 1260256 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000=
9f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000bb27c000 - 00000000bb2=
82000
[    0.000000] PM: Registered nosave memory: 00000000bb363000 - 00000000bb3=
75000
[    0.000000] PM: Registered nosave memory: 00000000bb375000 - 00000000bb3=
f6000
[    0.000000] PM: Registered nosave memory: 00000000bb3f6000 - 00000000bb4=
0f000
[    0.000000] PM: Registered nosave memory: 00000000bb470000 - 00000000bb6=
68000
[    0.000000] PM: Registered nosave memory: 00000000bb668000 - 00000000bb6=
e8000
[    0.000000] PM: Registered nosave memory: 00000000bb6e8000 - 00000000bb7=
0f000
[    0.000000] PM: Registered nosave memory: 00000000bb717000 - 00000000bb7=
1f000
[    0.000000] PM: Registered nosave memory: 00000000bb76c000 - 00000000bb7=
78000
[    0.000000] PM: Registered nosave memory: 00000000bb778000 - 00000000bb7=
7b000
[    0.000000] PM: Registered nosave memory: 00000000bb77b000 - 00000000bb7=
8b000
[    0.000000] PM: Registered nosave memory: 00000000bb78b000 - 00000000bb7=
8c000
[    0.000000] PM: Registered nosave memory: 00000000bb78c000 - 00000000bb7=
9f000
[    0.000000] PM: Registered nosave memory: 00000000bb79f000 - 00000000bb7=
ff000
[    0.000000] PM: Registered nosave memory: 00000000bb800000 - 00000000c00=
00000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000e00=
00000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f00=
00000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000fea=
ff000
[    0.000000] PM: Registered nosave memory: 00000000feaff000 - 00000000feb=
00000
[    0.000000] PM: Registered nosave memory: 00000000feb00000 - 00000000fec=
00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec=
10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fed=
00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed=
1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed=
90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee=
01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ff0=
00000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 00000001000=
00000
[    0.000000] PM: Registered nosave memory: 00000001fc000000 - 00000002000=
00000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000=
:20000000)
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff8800bb000000 s74048 r8192=
 d24256 u524288
[    0.000000] pcpu-alloc: s74048 r8192 d24256 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 2012796
[    0.000000] Kernel command line: ro root=3DUUID=3Dc01e3070-03ef-4331-932=
f-fa23e59001b6 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=3Den_US.UTF-8 SY=
SFONT=3Dlatarcyrheb-sun16 KEYTABLE=3Dus rhgb quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 7966276k/9371648k available (4556k kernel code, 1192=
312k absent, 213060k reserved, 6238k data, 688k init)
[    0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D4, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:4352 nr_irqs:712 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 83886080 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.001000] Detected 2127.729 MHz processor.
[    0.000004] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4255.45 BogoMIPS (lpj=3D2127729)
[    0.000008] pid_max: default: 32768 minimum: 301
[    0.000043] Security Framework initialized
[    0.000099] Mount-cache hash table entries: 256
[    0.000216] Initializing cgroup subsys ns
[    0.000220] ns_cgroup deprecated: consider using the 'clone_children' fl=
ag without the ns_cgroup.
[    0.000222] Initializing cgroup subsys cpuacct
[    0.000227] Initializing cgroup subsys memory
[    0.000234] Initializing cgroup subsys devices
[    0.000237] Initializing cgroup subsys freezer
[    0.000238] Initializing cgroup subsys net_cls
[    0.000240] Initializing cgroup subsys blkio
[    0.000263] CPU: Physical Processor ID: 0
[    0.000264] CPU: Processor Core ID: 0
[    0.000268] using mwait in idle threads.
[    0.000322] ACPI: Core revision 20110112
[    0.024241] ftrace: allocating 23205 entries in 92 pages
[    0.031028] Setting APIC routing to flat
[    0.031429] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.041426] CPU0: Intel(R) Core(TM) i7 CPU       L 640  @ 2.13GHz steppi=
ng 02
[    0.142665] Performance Events: PEBS fmt1+, Westmere events, Intel PMU d=
river.
[    0.142671] ... version:                3
[    0.142673] ... bit width:              48
[    0.142674] ... generic registers:      4
[    0.142675] ... value mask:             0000ffffffffffff
[    0.142676] ... max period:             000000007fffffff
[    0.142678] ... fixed-purpose events:   3
[    0.142679] ... event mask:             000000070000000f
[    0.143046] NMI watchdog enabled, takes one hw-pmu counter.
[    0.143133] Booting Node   0, Processors  #1
[    0.233744] NMI watchdog enabled, takes one hw-pmu counter.
[    0.233857]  #2
[    0.324693] NMI watchdog enabled, takes one hw-pmu counter.
[    0.324799]  #3 Ok.
[    0.415632] NMI watchdog enabled, takes one hw-pmu counter.
[    0.415680] Brought up 4 CPUs
[    0.415682] Total of 4 processors activated (17022.77 BogoMIPS).
[    0.417088] devtmpfs: initialized
[    0.417971] atomic64 test passed for x86-64 platform with CX8 and with S=
SE
[    0.417995] Time: 18:51:41  Date: 02/14/11
[    0.418028] NET: Registered protocol family 16
[    0.418180] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.418183] ACPI: bus type pci registered
[    0.418267] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.418271] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.472039] PCI: Using configuration type 1 for base access
[    0.472782] bio: create slab <bio-0> at 0
[    0.474342] ACPI: EC: EC description table is found, configuring boot EC
[    0.479618] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.561003] ACPI: SSDT 00000000bb71a918 003EB (v01  PmRef  Cpu0Ist 00003=
000 INTL 20050513)
[    0.561342] ACPI: Dynamic OEM Table Load:
[    0.561345] ACPI: SSDT           (null) 003EB (v01  PmRef  Cpu0Ist 00003=
000 INTL 20050513)
[    0.561490] ACPI: SSDT 00000000bb718718 006B2 (v01  PmRef  Cpu0Cst 00003=
001 INTL 20050513)
[    0.561850] ACPI: Dynamic OEM Table Load:
[    0.561853] ACPI: SSDT           (null) 006B2 (v01  PmRef  Cpu0Cst 00003=
001 INTL 20050513)
[    0.568838] ACPI: SSDT 00000000bb719a98 00303 (v01  PmRef    ApIst 00003=
000 INTL 20050513)
[    0.569240] ACPI: Dynamic OEM Table Load:
[    0.569242] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003=
000 INTL 20050513)
[    0.571674] ACPI: SSDT 00000000bb717d98 00119 (v01  PmRef    ApCst 00003=
000 INTL 20050513)
[    0.572025] ACPI: Dynamic OEM Table Load:
[    0.572027] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003=
000 INTL 20050513)
[    0.576211] ACPI: Interpreter enabled
[    0.576214] ACPI: (supports S0 S3 S4 S5)
[    0.576234] ACPI: Using IOAPIC for interrupt routing
[    0.580124] ACPI: Power Resource [PUBS] (on)
[    0.583671] ACPI: EC: GPE =3D 0x11, I/O: command/status =3D 0x66, data =
=3D 0x62
[    0.590723] ACPI: ACPI Dock Station Driver: 3 docks/bays found
[    0.590725] HEST: Table not found.
[    0.590728] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.590742] ACPI: PCI Root Bridge [UNCR] (domain 0000 [bus ff])
[    0.590788] pci 0000:ff:00.0: [8086:2c62] type 0 class 0x000600
[    0.590809] pci 0000:ff:00.1: [8086:2d01] type 0 class 0x000600
[    0.590828] pci 0000:ff:02.0: [8086:2d10] type 0 class 0x000600
[    0.590844] pci 0000:ff:02.1: [8086:2d11] type 0 class 0x000600
[    0.590860] pci 0000:ff:02.2: [8086:2d12] type 0 class 0x000600
[    0.590875] pci 0000:ff:02.3: [8086:2d13] type 0 class 0x000600
[    0.590901] pci_bus 0000:ff: on NUMA node 0
[    0.591225] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.591279] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.591281] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.591284] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x00=
0bffff]
[    0.591286] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x00=
0d3fff]
[    0.591288] pci_root PNP0A08:00: host bridge window [mem 0x000d4000-0x00=
0d7fff]
[    0.591290] pci_root PNP0A08:00: host bridge window [mem 0x000d8000-0x00=
0dbfff]
[    0.591292] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xfe=
bfffff]
[    0.591302] pci 0000:00:00.0: [8086:0044] type 0 class 0x000600
[    0.591317] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for =
graphics
[    0.591333] pci 0000:00:02.0: [8086:0046] type 0 class 0x000300
[    0.591343] pci 0000:00:02.0: reg 10: [mem 0xf2000000-0xf23fffff 64bit]
[    0.591350] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit p=
ref]
[    0.591354] pci 0000:00:02.0: reg 20: [io  0x1800-0x1807]
[    0.591414] pci 0000:00:16.0: [8086:3b64] type 0 class 0x000780
[    0.591442] pci 0000:00:16.0: reg 10: [mem 0xf2727800-0xf272780f 64bit]
[    0.591517] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.591522] pci 0000:00:16.0: PME# disabled
[    0.591566] pci 0000:00:19.0: [8086:10ea] type 0 class 0x000200
[    0.591591] pci 0000:00:19.0: reg 10: [mem 0xf2500000-0xf251ffff]
[    0.591602] pci 0000:00:19.0: reg 14: [mem 0xf2525000-0xf2525fff]
[    0.591613] pci 0000:00:19.0: reg 18: [io  0x1820-0x183f]
[    0.591680] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.591686] pci 0000:00:19.0: PME# disabled
[    0.591717] pci 0000:00:1a.0: [8086:3b3c] type 0 class 0x000c03
[    0.591742] pci 0000:00:1a.0: reg 10: [mem 0xf2728000-0xf27283ff]
[    0.591830] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.591835] pci 0000:00:1a.0: PME# disabled
[    0.591865] pci 0000:00:1b.0: [8086:3b56] type 0 class 0x000403
[    0.591886] pci 0000:00:1b.0: reg 10: [mem 0xf2520000-0xf2523fff 64bit]
[    0.591960] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.591965] pci 0000:00:1b.0: PME# disabled
[    0.591992] pci 0000:00:1c.0: [8086:3b42] type 1 class 0x000604
[    0.592070] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.592074] pci 0000:00:1c.0: PME# disabled
[    0.592103] pci 0000:00:1c.3: [8086:3b48] type 1 class 0x000604
[    0.592179] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.592184] pci 0000:00:1c.3: PME# disabled
[    0.592211] pci 0000:00:1c.4: [8086:3b4a] type 1 class 0x000604
[    0.592288] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.592293] pci 0000:00:1c.4: PME# disabled
[    0.592329] pci 0000:00:1d.0: [8086:3b34] type 0 class 0x000c03
[    0.592354] pci 0000:00:1d.0: reg 10: [mem 0xf2728400-0xf27287ff]
[    0.592444] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.592448] pci 0000:00:1d.0: PME# disabled
[    0.592472] pci 0000:00:1e.0: [8086:2448] type 1 class 0x000604
[    0.592551] pci 0000:00:1f.0: [8086:3b07] type 0 class 0x000601
[    0.592670] pci 0000:00:1f.2: [8086:3b2f] type 0 class 0x000106
[    0.592696] pci 0000:00:1f.2: reg 10: [io  0x1860-0x1867]
[    0.592707] pci 0000:00:1f.2: reg 14: [io  0x1814-0x1817]
[    0.592718] pci 0000:00:1f.2: reg 18: [io  0x1818-0x181f]
[    0.592729] pci 0000:00:1f.2: reg 1c: [io  0x1810-0x1813]
[    0.592740] pci 0000:00:1f.2: reg 20: [io  0x1840-0x185f]
[    0.592751] pci 0000:00:1f.2: reg 24: [mem 0xf2727000-0xf27277ff]
[    0.592797] pci 0000:00:1f.2: PME# supported from D3hot
[    0.592802] pci 0000:00:1f.2: PME# disabled
[    0.592824] pci 0000:00:1f.3: [8086:3b30] type 0 class 0x000c05
[    0.592845] pci 0000:00:1f.3: reg 10: [mem 0xf2728800-0xf27288ff 64bit]
[    0.592875] pci 0000:00:1f.3: reg 20: [io  0x1880-0x189f]
[    0.592922] pci 0000:00:1f.6: [8086:3b32] type 0 class 0x001180
[    0.592949] pci 0000:00:1f.6: reg 10: [mem 0xf2526000-0xf2526fff 64bit]
[    0.593083] pci 0000:00:1c.0: PCI bridge to [bus 0d-0d]
[    0.593088] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disab=
led)
[    0.593093] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff=
] (disabled)
[    0.593100] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff=
 pref] (disabled)
[    0.593156] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.593160] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.593165] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]
[    0.593173] pci 0000:00:1c.3:   bridge window [mem 0xf2800000-0xf28fffff=
 64bit pref]
[    0.593321] pci 0000:02:00.0: [8086:4238] type 0 class 0x000280
[    0.593385] pci 0000:02:00.0: reg 10: [mem 0xf2400000-0xf2401fff 64bit]
[    0.593602] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.593629] pci 0000:02:00.0: PME# disabled
[    0.593729] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.593733] pci 0000:00:1c.4:   bridge window [io  0xf000-0x0000] (disab=
led)
[    0.593738] pci 0000:00:1c.4:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.593746] pci 0000:00:1c.4:   bridge window [mem 0xfff00000-0x000fffff=
 pref] (disabled)
[    0.593820] pci 0000:00:1e.0: PCI bridge to [bus 0e-0e] (subtractive dec=
ode)
[    0.593825] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disab=
led)
[    0.593829] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff=
] (disabled)
[    0.593837] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff=
 pref] (disabled)
[    0.593839] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtr=
active decode)
[    0.593841] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtr=
active decode)
[    0.593844] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff=
] (subtractive decode)
[    0.593846] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000d3fff=
] (subtractive decode)
[    0.593848] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d7fff=
] (subtractive decode)
[    0.593850] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000dbfff=
] (subtractive decode)
[    0.593853] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff=
] (subtractive decode)
[    0.593877] pci_bus 0000:00: on NUMA node 0
[    0.593880] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.594008] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.594042] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
[    0.594076] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
[    0.597335] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.597400] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[    0.597452] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.597516] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.597588] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.597640] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.597692] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.597755] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.597839] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.597846] vgaarb: loaded
[    0.597921] SCSI subsystem initialized
[    0.597935] libata version 3.00 loaded.
[    0.597975] usbcore: registered new interface driver usbfs
[    0.597987] usbcore: registered new interface driver hub
[    0.598022] usbcore: registered new device driver usb
[    0.598056] PCI: Using ACPI for IRQ routing
[    0.598058] PCI: pci_cache_line_size set to 64 bytes
[    0.598138] reserve RAM buffer: 000000000009e800 - 000000000009ffff=20
[    0.598141] reserve RAM buffer: 00000000bb27c000 - 00000000bbffffff=20
[    0.598146] reserve RAM buffer: 00000000bb363000 - 00000000bbffffff=20
[    0.598151] reserve RAM buffer: 00000000bb470000 - 00000000bbffffff=20
[    0.598155] reserve RAM buffer: 00000000bb717000 - 00000000bbffffff=20
[    0.598158] reserve RAM buffer: 00000000bb76c000 - 00000000bbffffff=20
[    0.598161] reserve RAM buffer: 00000000bb800000 - 00000000bbffffff=20
[    0.598249] NetLabel: Initializing
[    0.598251] NetLabel:  domain hash size =3D 128
[    0.598252] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.598263] NetLabel:  unlabeled traffic allowed by default
[    0.598278] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.598282] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.600306] Switching to clocksource hpet
[    0.600456] Switched to NOHz mode on CPU #0
[    0.600529] Switched to NOHz mode on CPU #3
[    0.600543] Switched to NOHz mode on CPU #2
[    0.600552] Switched to NOHz mode on CPU #1
[    0.606585] pnp: PnP ACPI init
[    0.606606] ACPI: bus type pnp registered
[    0.607893] pnp 00:00: [mem 0x00000000-0x0009ffff]
[    0.607896] pnp 00:00: [mem 0x000c0000-0x000c3fff]
[    0.607897] pnp 00:00: [mem 0x000c4000-0x000c7fff]
[    0.607899] pnp 00:00: [mem 0x000c8000-0x000cbfff]
[    0.607901] pnp 00:00: [mem 0x000cc000-0x000cffff]
[    0.607903] pnp 00:00: [mem 0x000d0000-0x000cffff disabled]
[    0.607905] pnp 00:00: [mem 0x000d4000-0x000d3fff disabled]
[    0.607906] pnp 00:00: [mem 0x000d8000-0x000d7fff disabled]
[    0.607908] pnp 00:00: [mem 0x000dc000-0x000dffff]
[    0.607910] pnp 00:00: [mem 0x000e0000-0x000e3fff]
[    0.607912] pnp 00:00: [mem 0x000e4000-0x000e7fff]
[    0.607913] pnp 00:00: [mem 0x000e8000-0x000ebfff]
[    0.607915] pnp 00:00: [mem 0x000ec000-0x000effff]
[    0.607917] pnp 00:00: [mem 0x000f0000-0x000fffff]
[    0.607918] pnp 00:00: [mem 0x00100000-0xbfffffff]
[    0.607920] pnp 00:00: [mem 0xfec00000-0xfed3ffff]
[    0.607922] pnp 00:00: [mem 0xfed4c000-0xffffffff]
[    0.607995] system 00:00: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.607998] system 00:00: [mem 0x000c0000-0x000c3fff] has been reserved
[    0.608000] system 00:00: [mem 0x000c4000-0x000c7fff] has been reserved
[    0.608002] system 00:00: [mem 0x000c8000-0x000cbfff] has been reserved
[    0.608004] system 00:00: [mem 0x000cc000-0x000cffff] has been reserved
[    0.608007] system 00:00: [mem 0x000dc000-0x000dffff] could not be reser=
ved
[    0.608010] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reser=
ved
[    0.608012] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reser=
ved
[    0.608015] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reser=
ved
[    0.608017] system 00:00: [mem 0x000ec000-0x000effff] could not be reser=
ved
[    0.608019] system 00:00: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.608022] system 00:00: [mem 0x00100000-0xbfffffff] could not be reser=
ved
[    0.608025] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.608027] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.608031] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.608045] pnp 00:01: [bus ff]
[    0.608108] pnp 00:01: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.608124] pnp 00:02: [bus 00-fe]
[    0.608126] pnp 00:02: [io  0x0cf8-0x0cff]
[    0.608128] pnp 00:02: [io  0x0000-0x0cf7 window]
[    0.608131] pnp 00:02: [io  0x0d00-0xffff window]
[    0.608133] pnp 00:02: [mem 0x000a0000-0x000bffff window]
[    0.608135] pnp 00:02: [mem 0x000c0000-0x000c3fff window]
[    0.608137] pnp 00:02: [mem 0x000c4000-0x000c7fff window]
[    0.608138] pnp 00:02: [mem 0x000c8000-0x000cbfff window]
[    0.608140] pnp 00:02: [mem 0x000cc000-0x000cffff window]
[    0.608142] pnp 00:02: [mem 0x000d0000-0x000d3fff window]
[    0.608144] pnp 00:02: [mem 0x000d4000-0x000d7fff window]
[    0.608145] pnp 00:02: [mem 0x000d8000-0x000dbfff window]
[    0.608147] pnp 00:02: [mem 0x000dc000-0x000dffff window]
[    0.608149] pnp 00:02: [mem 0x000e0000-0x000e3fff window]
[    0.608151] pnp 00:02: [mem 0x000e4000-0x000e7fff window]
[    0.608153] pnp 00:02: [mem 0x000e8000-0x000ebfff window]
[    0.608154] pnp 00:02: [mem 0x000ec000-0x000effff window]
[    0.608156] pnp 00:02: [mem 0xc0000000-0xfebfffff window]
[    0.608158] pnp 00:02: [mem 0xfed40000-0xfed4bfff window]
[    0.608195] pnp 00:02: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (a=
ctive)
[    0.608476] pnp 00:03: [io  0x0010-0x001f]
[    0.608478] pnp 00:03: [io  0x0090-0x009f]
[    0.608480] pnp 00:03: [io  0x0024-0x0025]
[    0.608482] pnp 00:03: [io  0x0028-0x0029]
[    0.608483] pnp 00:03: [io  0x002c-0x002d]
[    0.608485] pnp 00:03: [io  0x0030-0x0031]
[    0.608486] pnp 00:03: [io  0x0034-0x0035]
[    0.608488] pnp 00:03: [io  0x0038-0x0039]
[    0.608489] pnp 00:03: [io  0x003c-0x003d]
[    0.608491] pnp 00:03: [io  0x00a4-0x00a5]
[    0.608492] pnp 00:03: [io  0x00a8-0x00a9]
[    0.608494] pnp 00:03: [io  0x00ac-0x00ad]
[    0.608495] pnp 00:03: [io  0x00b0-0x00b5]
[    0.608497] pnp 00:03: [io  0x00b8-0x00b9]
[    0.608499] pnp 00:03: [io  0x00bc-0x00bd]
[    0.608500] pnp 00:03: [io  0x0050-0x0053]
[    0.608502] pnp 00:03: [io  0x0072-0x0077]
[    0.608503] pnp 00:03: [io  0x164e-0x164f]
[    0.608505] pnp 00:03: [io  0x002e-0x002f]
[    0.608506] pnp 00:03: [io  0x1000-0x107f]
[    0.608508] pnp 00:03: [io  0x1180-0x11ff]
[    0.608509] pnp 00:03: [io  0x0800-0x080f]
[    0.608511] pnp 00:03: [io  0x15e0-0x15ef]
[    0.608512] pnp 00:03: [io  0x1600-0x1641]
[    0.608514] pnp 00:03: [io  0x1644-0x167f]
[    0.608516] pnp 00:03: [mem 0xe0000000-0xefffffff]
[    0.608519] pnp 00:03: [mem 0xfed1c000-0xfed1ffff]
[    0.608521] pnp 00:03: [mem 0xfed10000-0xfed13fff]
[    0.608522] pnp 00:03: [mem 0xfed18000-0xfed18fff]
[    0.608524] pnp 00:03: [mem 0xfed19000-0xfed19fff]
[    0.608526] pnp 00:03: [mem 0xfed45000-0xfed4bfff]
[    0.608590] system 00:03: [io  0x164e-0x164f] has been reserved
[    0.608592] system 00:03: [io  0x1000-0x107f] has been reserved
[    0.608594] system 00:03: [io  0x1180-0x11ff] has been reserved
[    0.608598] system 00:03: [io  0x0800-0x080f] has been reserved
[    0.608600] system 00:03: [io  0x15e0-0x15ef] has been reserved
[    0.608602] system 00:03: [io  0x1600-0x1641] has been reserved
[    0.608605] system 00:03: [io  0x1644-0x167f] could not be reserved
[    0.608608] system 00:03: [mem 0xe0000000-0xefffffff] has been reserved
[    0.608610] system 00:03: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.608612] system 00:03: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.608615] system 00:03: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.608617] system 00:03: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.608620] system 00:03: [mem 0xfed45000-0xfed4bfff] has been reserved
[    0.608623] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.608652] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    0.608684] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.608693] pnp 00:05: [io  0x0000-0x000f]
[    0.608694] pnp 00:05: [io  0x0080-0x008f]
[    0.608696] pnp 00:05: [io  0x00c0-0x00df]
[    0.608698] pnp 00:05: [dma 4]
[    0.608727] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.608734] pnp 00:06: [io  0x0061]
[    0.608761] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.608769] pnp 00:07: [io  0x00f0]
[    0.608781] pnp 00:07: [irq 13]
[    0.608810] pnp 00:07: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.608818] pnp 00:08: [io  0x0070-0x0071]
[    0.608823] pnp 00:08: [irq 8]
[    0.608851] pnp 00:08: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.608859] pnp 00:09: [io  0x0060]
[    0.608861] pnp 00:09: [io  0x0064]
[    0.608866] pnp 00:09: [irq 1]
[    0.608895] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.608906] pnp 00:0a: [irq 12]
[    0.608935] pnp 00:0a: Plug and Play ACPI device, IDs IBM3780 PNP0f13 (a=
ctive)
[    0.609196] pnp 00:0b: [mem 0xfed40000-0xfed44fff]
[    0.609230] pnp 00:0b: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (a=
ctive)
[    0.609712] pnp 00:0c: [mem 0xfeaff000-0xfeafffff]
[    0.609774] system 00:0c: [mem 0xfeaff000-0xfeafffff] has been reserved
[    0.609777] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.609857] pnp: PnP ACPI: found 13 devices
[    0.609858] ACPI: ACPI bus type pnp unregistered
[    0.616202] pci 0000:00:1c.0: PCI bridge to [bus 0d-0d]
[    0.616204] pci 0000:00:1c.0:   bridge window [io  disabled]
[    0.616210] pci 0000:00:1c.0:   bridge window [mem disabled]
[    0.616214] pci 0000:00:1c.0:   bridge window [mem pref disabled]
[    0.616222] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.616225] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.616232] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]
[    0.616237] pci 0000:00:1c.3:   bridge window [mem 0xf2800000-0xf28fffff=
 64bit pref]
[    0.616245] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.616247] pci 0000:00:1c.4:   bridge window [io  disabled]
[    0.616253] pci 0000:00:1c.4:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.616257] pci 0000:00:1c.4:   bridge window [mem pref disabled]
[    0.616265] pci 0000:00:1e.0: PCI bridge to [bus 0e-0e]
[    0.616267] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.616273] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.616277] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.616298] pci 0000:00:1c.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.616304] pci 0000:00:1c.0: setting latency timer to 64
[    0.616315] pci 0000:00:1c.3: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[    0.616320] pci 0000:00:1c.3: setting latency timer to 64
[    0.616327] pci 0000:00:1c.4: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.616331] pci 0000:00:1c.4: setting latency timer to 64
[    0.616339] pci 0000:00:1e.0: setting latency timer to 64
[    0.616344] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.616345] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.616347] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.616349] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.616351] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.616353] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.616363] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfebfffff]
[    0.616365] pci_bus 0000:05: resource 0 [io  0x2000-0x2fff]
[    0.616367] pci_bus 0000:05: resource 1 [mem 0xf0000000-0xf1ffffff]
[    0.616369] pci_bus 0000:05: resource 2 [mem 0xf2800000-0xf28fffff 64bit=
 pref]
[    0.616371] pci_bus 0000:02: resource 1 [mem 0xf2400000-0xf24fffff]
[    0.616373] pci_bus 0000:0e: resource 4 [io  0x0000-0x0cf7]
[    0.616375] pci_bus 0000:0e: resource 5 [io  0x0d00-0xffff]
[    0.616377] pci_bus 0000:0e: resource 6 [mem 0x000a0000-0x000bffff]
[    0.616379] pci_bus 0000:0e: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.616381] pci_bus 0000:0e: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.616382] pci_bus 0000:0e: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.616384] pci_bus 0000:0e: resource 10 [mem 0xc0000000-0xfebfffff]
[    0.616411] NET: Registered protocol family 2
[    0.616454] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    0.616865] TCP established hash table entries: 262144 (order: 10, 41943=
04 bytes)
[    0.618042] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.618328] TCP: Hash tables configured (established 262144 bind 65536)
[    0.618330] TCP reno registered
[    0.618333] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.618398] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.618539] NET: Registered protocol family 1
[    0.618567] pci 0000:00:02.0: Boot video device
[    0.618678] PCI: CLS 64 bytes, default 64
[    0.618730] Trying to unpack rootfs image as initramfs...
[    0.740368] Freeing initrd memory: 6656k freed
[    0.741863] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.741869] Placing 64MB software IO TLB between ffff8800b6278000 - ffff=
8800ba278000
[    0.741871] software IO TLB at phys 0xb6278000 - 0xba278000
[    0.741921] Simple Boot Flag at 0x35 set to 0x1
[    0.754591] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.757869] Btrfs loaded
[    0.757874] msgmni has been set to 15572
[    0.758116] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    0.758119] io scheduler noop registered
[    0.758121] io scheduler deadline registered
[    0.758153] io scheduler cfq registered (default)
[    0.758441] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.758463] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.758464] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.758666] acpiphp: Slot [1] registered
[    0.758765] intel_idle: MWAIT substates: 0x1120
[    0.758767] intel_idle: v0.4 model 0x25
[    0.758768] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.758991] ACPI: Deprecated procfs I/F for AC is loaded, please retry w=
ith CONFIG_ACPI_PROCFS_POWER cleared
[    0.759196] ACPI: AC Adapter [AC] (on-line)
[    0.759286] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:=
00/input/input0
[    0.775317] ACPI: Lid Switch [LID]
[    0.775412] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0=
E:00/input/input1
[    0.783330] ACPI: Sleep Button [SLPB]
[    0.783421] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.783424] ACPI: Power Button [PWRF]
[    0.783543] ACPI: acpi_idle yielding to intel_idle
[    0.790074] thermal LNXTHERM:00: registered as thermal_zone0
[    0.790076] ACPI: Thermal Zone [THM0] (67 C)
[    0.790089] ERST: Table is not found!
[    0.790183] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.806877] ACPI: Deprecated procfs I/F for battery is loaded, please re=
try with CONFIG_ACPI_PROCFS_POWER cleared
[    0.806883] ACPI: Battery Slot [BAT0] (battery present)
[    0.808688] Non-volatile memory driver v1.3
[    0.808691] Linux agpgart interface v0.103
[    0.808745] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
[    0.808885] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K tota=
l, 262144K mappable
[    0.810085] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
[    0.810213] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.810359] tpm_tis 00:0b: 1.2 TPM (device-id 0x0, rev-id 78)
[    0.840359] [drm] Initialized drm 1.1.0 20060810
[    0.840409] i915 0000:00:02.0: power state changed by ACPI to D0
[    0.840412] i915 0000:00:02.0: power state changed by ACPI to D0
[    0.840428] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.840432] i915 0000:00:02.0: setting latency timer to 64
[    0.905603] i915 0000:00:02.0: irq 40 for MSI/MSI-X
[    0.905610] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    0.905612] [drm] Driver supports precise vblank timestamp query.
[    1.057306] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.184262] fbcon: inteldrmfb (fb0) is primary device
[    1.300221] Console: switching to colour frame buffer device 180x56
[    1.303167] fb0: inteldrmfb frame buffer device
[    1.303168] drm: registered panic notifier
[    1.303187] No ACPI video bus found
[    1.303311] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on mi=
nor 0
[    1.304449] brd: module loaded
[    1.305003] loop: module loaded
[    1.305094] ahci 0000:00:1f.2: version 3.0
[    1.305108] ahci 0000:00:1f.2: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    1.305159] ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
[    1.305195] ahci: SSS flag set, parallel bus scan disabled
[    1.305244] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x=
33 impl SATA mode
[    1.305248] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led cl=
o pmp pio slum part ems sxs apst=20
[    1.305254] ahci 0000:00:1f.2: setting latency timer to 64
[    1.311712] scsi0 : ahci
[    1.311807] scsi1 : ahci
[    1.311876] scsi2 : ahci
[    1.311943] scsi3 : ahci
[    1.312012] scsi4 : ahci
[    1.312106] scsi5 : ahci
[    1.312505] ata1: SATA max UDMA/133 abar m2048@0xf2727000 port 0xf272710=
0 irq 41
[    1.312509] ata2: SATA max UDMA/133 abar m2048@0xf2727000 port 0xf272718=
0 irq 41
[    1.312511] ata3: DUMMY
[    1.312512] ata4: DUMMY
[    1.312514] ata5: SATA max UDMA/133 abar m2048@0xf2727000 port 0xf272730=
0 irq 41
[    1.312518] ata6: SATA max UDMA/133 abar m2048@0xf2727000 port 0xf272738=
0 irq 41
[    1.312655] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.316112] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.316118] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.316212] mousedev: PS/2 mouse device common for all mice
[    1.316333] rtc_cmos 00:08: RTC can wake from S4
[    1.316410] rtc_cmos 00:08: rtc core: registered rtc_cmos as rtc0
[    1.316442] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.316526] device-mapper: uevent: version 1.0.3
[    1.316605] device-mapper: ioctl: 4.19.1-ioctl (2011-01-07) initialised:=
 dm-devel@redhat.com
[    1.316757] cpuidle: using governor ladder
[    1.316927] cpuidle: using governor menu
[    1.317046] usbcore: registered new interface driver usbhid
[    1.317047] usbhid: USB HID core driver
[    1.317106] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    1.317362] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.317388] TCP cubic registered
[    1.317390] Initializing XFRM netlink socket
[    1.317410] NET: Registered protocol family 17
[    1.317438] Registering the dns_resolver key type
[    1.317638] PM: Hibernation image not present or could not be loaded.
[    1.319802] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[    1.324157] IMA: No TPM chip found, activating TPM-bypass!
[    1.324570]   Magic number: 15:275:898
[    1.324766] rtc_cmos 00:08: setting system clock to 2011-02-14 18:51:41 =
UTC (1297709501)
[    1.324913] Initalizing network drop monitor service
[    1.742072] Refined TSC clocksource calibration: 2127.999 MHz.
[    1.742078] Switching to clocksource tsc
[    1.772002] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.772577] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[    1.772585] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[    1.772591] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    1.773017] ata1.00: ATA-9: C300-CTFDDAC256MAG, 0002, max UDMA/100
[    1.773023] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32=
), AA
[    1.773664] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[    1.773671] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[    1.773678] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    1.774105] ata1.00: configured for UDMA/100
[    1.774290] scsi 0:0:0:0: Direct-Access     ATA      C300-CTFDDAC256M 00=
02 PQ: 0 ANSI: 5
[    1.774501] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.774577] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB=
/238 GiB)
[    1.774723] sd 0:0:0:0: [sda] Write Protect is off
[    1.774728] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.774764] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.775361]  sda: sda1 sda2 sda3 sda4
[    1.775980] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.078839] ata2: SATA link down (SStatus 0 SControl 300)
[    2.383713] ata5: SATA link down (SStatus 0 SControl 300)
[    2.688582] ata6: SATA link down (SStatus 0 SControl 300)
[    2.691881] Freeing unused kernel memory: 688k freed
[    2.692027] Write protecting the kernel read-only data: 10240k
[    2.704478] Freeing unused kernel memory: 1568k freed
[    2.719289] Freeing unused kernel memory: 1880k freed
[    2.741348] dracut: dracut-006-6.fc14
[    2.749541] dracut: rd_NO_LUKS: removing cryptoluks activation
[    2.755208] udev[83]: starting version 161
[    2.831174] dracut: Starting plymouth daemon
[    3.782934] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.782939] ehci_hcd: block sizes: qh 104 qtd 96 itd 192 sitd 96
[    3.782979] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[    3.782985] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[    3.782997] ehci_hcd 0000:00:1a.0: PCI INT D -> GSI 23 (level, low) -> I=
RQ 23
[    3.783054] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.783060] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.783084] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'devices'
[    3.783089] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'001'
[    3.783173] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[    3.789121] ehci_hcd 0000:00:1a.0: reset hcs_params 0x200003 dbg=3D2 cc=
=3D0 pcc=3D0 ordered !ppc ports=3D3
[    3.789133] ehci_hcd 0000:00:1a.0: reset hcc_params 36881 caching frame =
1024 64 bit addr
[    3.789181] ehci_hcd 0000:00:1a.0: support lpm
[    3.789196] ehci_hcd 0000:00:1a.0: debug port 2
[    3.789202] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[    3.793093] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.793097] ehci_hcd 0000:00:1a.0: supports USB remote wakeup
[    3.793127] ehci_hcd 0000:00:1a.0: irq 23, io mem 0xf2728000
[    3.793134] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[    3.797025] ehci_hcd 0000:00:1a.0: init command 0010001 (park)=3D0 ithre=
sh=3D1 period=3D1024 RUN
[    3.804045] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.804086] usb usb1: default language 0x0409
[    3.804096] usb usb1: udev 1, busnum 1, minor =3D 0
[    3.804099] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.804102] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.804105] usb usb1: Product: EHCI Host Controller
[    3.804107] usb usb1: Manufacturer: Linux 2.6.38-rc4-00178-g795abaf ehci=
_hcd
[    3.804110] usb usb1: SerialNumber: 0000:00:1a.0
[    3.804264] usb usb1: usb_probe_device
[    3.804268] usb usb1: configuration #1 chosen from 1 choice
[    3.804280] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.804329] hub 1-0:1.0: usb_probe_interface
[    3.804331] hub 1-0:1.0: usb_probe_interface - got id
[    3.804335] hub 1-0:1.0: USB hub found
[    3.804341] hub 1-0:1.0: 3 ports detected
[    3.804343] hub 1-0:1.0: standalone hub
[    3.804345] hub 1-0:1.0: no power switching (usb 1.0)
[    3.804347] hub 1-0:1.0: individual port over-current protection
[    3.804350] hub 1-0:1.0: power on to power good time: 20ms
[    3.804357] hub 1-0:1.0: local power source is good
[    3.804360] hub 1-0:1.0: trying to enable port power on non-switchable h=
ub
[    3.804410] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'001'
[    3.804525] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[    3.804532] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[    3.804557] ehci_hcd 0000:00:1d.0: PCI INT D -> GSI 19 (level, low) -> I=
RQ 19
[    3.804598] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.804602] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.804611] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'002'
[    3.804671] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[    3.807064] ehci_hcd 0000:00:1d.0: reset hcs_params 0x200003 dbg=3D2 cc=
=3D0 pcc=3D0 ordered !ppc ports=3D3
[    3.807070] ehci_hcd 0000:00:1d.0: reset hcc_params 36881 caching frame =
1024 64 bit addr
[    3.807101] ehci_hcd 0000:00:1d.0: support lpm
[    3.807116] ehci_hcd 0000:00:1d.0: debug port 2
[    3.807122] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[    3.811035] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.811038] ehci_hcd 0000:00:1d.0: supports USB remote wakeup
[    3.811093] ehci_hcd 0000:00:1d.0: irq 19, io mem 0xf2728400
[    3.811099] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=3D0 ithr=
esh=3D8 period=3D1024 Reset HALT
[    3.814986] ehci_hcd 0000:00:1d.0: init command 0010001 (park)=3D0 ithre=
sh=3D1 period=3D1024 RUN
[    3.820021] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.820075] usb usb2: default language 0x0409
[    3.820085] usb usb2: udev 1, busnum 2, minor =3D 128
[    3.820088] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    3.820090] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.820094] usb usb2: Product: EHCI Host Controller
[    3.820095] usb usb2: Manufacturer: Linux 2.6.38-rc4-00178-g795abaf ehci=
_hcd
[    3.820098] usb usb2: SerialNumber: 0000:00:1d.0
[    3.820222] usb usb2: usb_probe_device
[    3.820226] usb usb2: configuration #1 chosen from 1 choice
[    3.820237] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[    3.820280] hub 2-0:1.0: usb_probe_interface
[    3.820283] hub 2-0:1.0: usb_probe_interface - got id
[    3.820286] hub 2-0:1.0: USB hub found
[    3.820292] hub 2-0:1.0: 3 ports detected
[    3.820294] hub 2-0:1.0: standalone hub
[    3.820297] hub 2-0:1.0: no power switching (usb 1.0)
[    3.820299] hub 2-0:1.0: individual port over-current protection
[    3.820302] hub 2-0:1.0: power on to power good time: 20ms
[    3.820307] hub 2-0:1.0: local power source is good
[    3.820310] hub 2-0:1.0: trying to enable port power on non-switchable h=
ub
[    3.820352] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'001'
[    3.885588] device fsid 3143ef0370301ec0-b60190e523fa2f93 devid 1 transi=
d 771295 /dev/sda4
[    3.904003] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001803 0  ACK=
 POWER sig=3Dj CSC CONNECT
[    3.904016] hub 1-0:1.0: port 1: status 0501 change 0001
[    3.919978] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK=
 POWER sig=3Dj CSC CONNECT
[    3.919984] hub 2-0:1.0: port 1: status 0501 change 0001
[    3.976801] Btrfs detected SSD devices, enabling SSD mode
[    3.981403] dracut: Mounted root filesystem /dev/sda4
[    4.003400] dracut: Loading SELinux policy
[    4.003966] hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
[    4.003986] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    4.055195] ehci_hcd 0000:00:1a.0: port 1 high speed
[    4.055201] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[    4.077132] dracut: /sbin/load_policy: Can't load policy: No such device
[    4.105957] usb 1-1: new high speed USB device using ehci_hcd and addres=
s 2
[    4.155304] dracut: Switching root
[    4.157153] ehci_hcd 0000:00:1a.0: port 1 high speed
[    4.157168] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[    4.220013] ehci_hcd 0000:00:1a.0: set dev address 2 for port 1
[    4.220020] ehci_hcd 0000:00:1a.0: LPM: no device attached
[    4.220262] usb 1-1: udev 2, busnum 1, minor =3D 1
[    4.220266] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0020
[    4.220269] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    4.220393] usb 1-1: usb_probe_device
[    4.220397] usb 1-1: configuration #1 chosen from 1 choice
[    4.220513] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[    4.220553] hub 1-1:1.0: usb_probe_interface
[    4.220556] hub 1-1:1.0: usb_probe_interface - got id
[    4.220560] hub 1-1:1.0: USB hub found
[    4.220633] hub 1-1:1.0: 6 ports detected
[    4.220636] hub 1-1:1.0: standalone hub
[    4.220638] hub 1-1:1.0: individual port power switching
[    4.220640] hub 1-1:1.0: individual port over-current protection
[    4.220643] hub 1-1:1.0: Single TT
[    4.220645] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    4.220648] hub 1-1:1.0: Port indicators are supported
[    4.220651] hub 1-1:1.0: power on to power good time: 100ms
[    4.220884] hub 1-1:1.0: local power source is good
[    4.220887] hub 1-1:1.0: enabling power on all ports
[    4.221662] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'002'
[    4.221698] hub 2-0:1.0: state 7 ports 3 chg 0002 evt 0000
[    4.221708] hub 2-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    4.245354] readahead-collector: starting
[    4.272104] ehci_hcd 0000:00:1d.0: port 1 high speed
[    4.272116] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[    4.279248] readahead-collector: sorting
[    4.321351] hub 1-1:1.0: port 4: status 0101 change 0001
[    4.321600] hub 1-1:1.0: port 5: status 0101 change 0001
[    4.322818] usb 2-1: new high speed USB device using ehci_hcd and addres=
s 2
[    4.361249] udev[292]: starting version 161
[    4.374058] ehci_hcd 0000:00:1d.0: port 1 high speed
[    4.374065] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[    4.422111] usb 1-1: link qh256-0001/ffff880230a65480 start 1 [1/0 us]
[    4.440926] ehci_hcd 0000:00:1d.0: set dev address 2 for port 1
[    4.440933] ehci_hcd 0000:00:1d.0: LPM: no device attached
[    4.441170] usb 2-1: udev 2, busnum 2, minor =3D 129
[    4.441174] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0020
[    4.441177] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    4.441293] usb 2-1: usb_probe_device
[    4.441298] usb 2-1: configuration #1 chosen from 1 choice
[    4.441422] usb 2-1: adding 2-1:1.0 (config #1, interface 0)
[    4.441463] hub 2-1:1.0: usb_probe_interface
[    4.441465] hub 2-1:1.0: usb_probe_interface - got id
[    4.441469] hub 2-1:1.0: USB hub found
[    4.441540] hub 2-1:1.0: 8 ports detected
[    4.441543] hub 2-1:1.0: standalone hub
[    4.441545] hub 2-1:1.0: individual port power switching
[    4.441547] hub 2-1:1.0: individual port over-current protection
[    4.441549] hub 2-1:1.0: Single TT
[    4.441551] hub 2-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    4.441554] hub 2-1:1.0: Port indicators are supported
[    4.441556] hub 2-1:1.0: power on to power good time: 100ms
[    4.441791] hub 2-1:1.0: local power source is good
[    4.441795] hub 2-1:1.0: enabling power on all ports
[    4.442827] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'002'
[    4.442867] hub 1-1:1.0: state 7 ports 6 chg 0030 evt 0000
[    4.442921] hub 1-1:1.0: port 4, status 0101, change 0000, 12 Mb/s
[    4.448072] iTCO_vendor_support: vendor-support=3D0
[    4.448321] i801_smbus 0000:00:1f.3: PCI INT A -> GSI 23 (level, low) ->=
 IRQ 23
[    4.453926] hub 1-1:1.0: port 4 not reset yet, waiting 10ms
[    4.461642] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    4.461792] iTCO_wdt: Found a QM57 TCO device (Version=3D2, TCOBASE=3D0x=
1060)
[    4.461878] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    4.486552] intel ips 0000:00:1f.6: CPU TDP doesn't match expected value=
 (found 18, expected 21)
[    4.486572] intel ips 0000:00:1f.6: PCI INT D -> GSI 19 (level, low) -> =
IRQ 19
[    4.489798] intel ips 0000:00:1f.6: IPS driver initialized, MCP temp lim=
it 90
[    4.502598] microcode: CPU0 sig=3D0x20652, pf=3D0x10, revision=3D0x9
[    4.504139] e1000e: Intel(R) PRO/1000 Network Driver - 1.2.20-k2
[    4.504143] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    4.504182] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ=
 20
[    4.504199] e1000e 0000:00:19.0: setting latency timer to 64
[    4.504369] e1000e 0000:00:19.0: irq 42 for MSI/MSI-X
[    4.509988] thinkpad_acpi: ThinkPad ACPI Extras v0.24
[    4.509991] thinkpad_acpi: http://ibm-acpi.sf.net/
[    4.509993] thinkpad_acpi: ThinkPad BIOS 6QET35WW (1.05 ), EC 6QHT24WW-1=
.05
[    4.509995] thinkpad_acpi: Lenovo ThinkPad X201s, model 5129CTO
[    4.515966] usb 1-1.4: new full speed USB device using ehci_hcd and addr=
ess 3
[    4.520246] thinkpad_acpi: detected a 8-level brightness capable ThinkPad
[    4.521827] thinkpad_acpi: radio switch found; radios are enabled
[    4.522332] thinkpad_acpi: possible tablet mode switch found; ThinkPad i=
n laptop mode
[    4.526893] hub 1-1:1.0: port 4 not reset yet, waiting 10ms
[    4.543763] usb 2-1: link qh256-0001/ffff880230be8600 start 1 [1/0 us]
[    4.547060] cfg80211: Calling CRDA to update world regulatory domain
[    4.548020] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    4.548381] microcode: CPU1 sig=3D0x20652, pf=3D0x10, revision=3D0x9
[    4.553007] Registered led device: tpacpi::thinklight
[    4.553306] Registered led device: tpacpi::power
[    4.553591] Registered led device: tpacpi::standby
[    4.553872] Registered led device: tpacpi::thinkvantage
[    4.557234] microcode: CPU2 sig=3D0x20652, pf=3D0x10, revision=3D0x9
[    4.560104] microcode: CPU3 sig=3D0x20652, pf=3D0x10, revision=3D0x9
[    4.579335] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    4.585428] thinkpad_acpi: Console audio control enabled, mode: monitor =
(read only)
[    4.595312] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input4
[    4.609698] usb 1-1.4: skipped 1 descriptor after interface
[    4.610023] usb 1-1.4: default language 0x0409
[    4.610954] microcode: CPU0 updated to revision 0xc, date =3D 2010-06-10
[    4.611403] microcode: CPU1 updated to revision 0xc, date =3D 2010-06-10
[    4.611423] usb 1-1.4: udev 3, busnum 1, minor =3D 2
[    4.611427] usb 1-1.4: New USB device found, idVendor=3D0a5c, idProduct=
=3D217f
[    4.611430] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    4.611433] usb 1-1.4: Product: Broadcom Bluetooth Device
[    4.611436] usb 1-1.4: Manufacturer: Broadcom Corp
[    4.611438] usb 1-1.4: SerialNumber: 00271396AABE
[    4.611573] usb 1-1.4: usb_probe_device
[    4.611578] usb 1-1.4: configuration #1 chosen from 1 choice
[    4.611824] usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
[    4.611947] usb 1-1.4: adding 1-1.4:1.1 (config #1, interface 1)
[    4.612052] usb 1-1.4: adding 1-1.4:1.2 (config #1, interface 2)
[    4.612141] usb 1-1.4: adding 1-1.4:1.3 (config #1, interface 3)
[    4.612180] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'003'
[    4.612437] hub 1-1:1.0: port 5, status 0101, change 0000, 12 Mb/s
[    4.613119] microcode: CPU2 updated to revision 0xc, date =3D 2010-06-10
[    4.613592] microcode: CPU3 updated to revision 0xc, date =3D 2010-06-10
[    4.615103] cfg80211: World regulatory domain updated:
[    4.615106] cfg80211:     (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[    4.615110] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.615130] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 =
mBi, 2000 mBm)
[    4.615133] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 =
mBi, 2000 mBm)
[    4.615136] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.615138] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.623844] hub 1-1:1.0: port 5 not reset yet, waiting 10ms
[    4.686830] usb 1-1.5: new high speed USB device using ehci_hcd and addr=
ess 4
[    4.695378] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00=
:26:2d:fd:13:45
[    4.695383] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connect=
ion
[    4.695460] e1000e 0000:00:19.0: eth0: MAC: 9, PHY: 10, PBA No: A002FF-0=
FF
[    4.707799] Bluetooth: Core ver 2.15
[    4.707830] NET: Registered protocol family 31
[    4.707833] Bluetooth: HCI device and connection manager initialized
[    4.707836] Bluetooth: HCI socket layer initialized
[    4.743570] Bluetooth: Generic Bluetooth USB driver ver 0.6
[    4.743595] btusb 1-1.4:1.0: usb_probe_interface
[    4.743599] btusb 1-1.4:1.0: usb_probe_interface - got id
[    4.745172] btusb 1-1.4:1.2: usb_probe_interface
[    4.745175] btusb 1-1.4:1.2: usb_probe_interface - got id
[    4.745187] btusb 1-1.4:1.3: usb_probe_interface
[    4.745189] btusb 1-1.4:1.3: usb_probe_interface - got id
[    4.745404] usbcore: registered new interface driver btusb
[    4.758702] readahead-collector: finished
[    4.762001] HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> =
IRQ 17
[    4.762139] HDA Intel 0000:00:1b.0: irq 43 for MSI/MSI-X
[    4.762173] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    4.768055] usb 1-1.5: udev 4, busnum 1, minor =3D 3
[    4.768058] usb 1-1.5: New USB device found, idVendor=3D17ef, idProduct=
=3D1005
[    4.768061] usb 1-1.5: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    4.768169] usb 1-1.5: usb_probe_device
[    4.768174] usb 1-1.5: configuration #1 chosen from 1 choice
[    4.768285] usb 1-1.5: adding 1-1.5:1.0 (config #1, interface 0)
[    4.768330] hub 1-1.5:1.0: usb_probe_interface
[    4.768333] hub 1-1.5:1.0: usb_probe_interface - got id
[    4.768336] hub 1-1.5:1.0: USB hub found
[    4.768399] hub 1-1.5:1.0: 4 ports detected
[    4.768401] hub 1-1.5:1.0: standalone hub
[    4.768403] hub 1-1.5:1.0: individual port power switching
[    4.768405] hub 1-1.5:1.0: individual port over-current protection
[    4.768694] hub 1-1.5:1.0: TT per port
[    4.768696] hub 1-1.5:1.0: TT requires at most 8 FS bit times (666 ns)
[    4.768699] hub 1-1.5:1.0: power on to power good time: 100ms
[    4.768900] hub 1-1.5:1.0: local power source is good
[    4.768902] hub 1-1.5:1.0: enabling power on all ports
[    4.769402] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'004'
[    4.769429] hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0000
[    4.769435] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0010
[    4.848578] iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, in=
-tree:d
[    4.848581] iwlagn: Copyright(c) 2003-2010 Intel Corporation
[    4.848655] iwlagn 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ=
 16
[    4.848665] iwlagn 0000:02:00.0: setting latency timer to 64
[    4.848723] iwlagn 0000:02:00.0: Detected Intel(R) Centrino(R) Ultimate-=
N 6300 AGN, REV=3D0x74
[    4.865407] iwlagn 0000:02:00.0: device EEPROM VER=3D0x436, CALIB=3D0x6
[    4.865413] iwlagn 0000:02:00.0: Device SKU: 0Xb
[    4.865417] iwlagn 0000:02:00.0: Valid Tx ant: 0X7, Valid Rx ant: 0X7
[    4.865458] iwlagn 0000:02:00.0: Tunable channels: 13 802.11bg, 24 802.1=
1a channels
[    4.865555] iwlagn 0000:02:00.0: irq 44 for MSI/MSI-X
[    4.869025] hub 1-1.5:1.0: port 3: status 0301 change 0001
[    4.872655] iwlagn 0000:02:00.0: loaded firmware version 9.221.4.1 build=
 25532
[    4.886907] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    4.892411] cfg80211: Calling CRDA for country: US
[    4.894589] cfg80211: Regulatory domain changed to country: US
[    4.894592] cfg80211:     (start_freq - end_freq @ bandwidth), (max_ante=
nna_gain, max_eirp)
[    4.894594] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 =
mBi, 2700 mBm)
[    4.894597] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 =
mBi, 1700 mBm)
[    4.894599] cfg80211:     (5250000 KHz - 5330000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.894601] cfg80211:     (5490000 KHz - 5600000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.894603] cfg80211:     (5650000 KHz - 5710000 KHz @ 40000 KHz), (300 =
mBi, 2000 mBm)
[    4.894605] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 =
mBi, 3000 mBm)
[    4.968599] usb 1-1.5: link qh256-0001/ffff8802329aa100 start 2 [1/0 us]
[    4.968627] hub 1-1.5:1.0: state 7 ports 4 chg 0008 evt 0000
[    4.968784] hub 1-1.5:1.0: port 3, status 0301, change 0000, 1.5 Mb/s
[    4.979766] hub 1-1.5:1.0: port 3 not reset yet, waiting 10ms
[    5.041767] usb 1-1.5.3: new low speed USB device using ehci_hcd and add=
ress 5
[    5.053776] hub 1-1.5:1.0: port 3 not reset yet, waiting 10ms
[    5.072998] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    5.091231] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/seri=
o1/input/input5
[    5.130671] usb 1-1.5.3: skipped 1 descriptor after interface
[    5.130678] usb 1-1.5.3: skipped 1 descriptor after interface
[    5.131170] usb 1-1.5.3: default language 0x0409
[    5.133171] usb 1-1.5.3: udev 5, busnum 1, minor =3D 4
[    5.133176] usb 1-1.5.3: New USB device found, idVendor=3D046d, idProduc=
t=3Dc517
[    5.133181] usb 1-1.5.3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    5.133185] usb 1-1.5.3: Product: USB Receiver
[    5.133189] usb 1-1.5.3: Manufacturer: Logitech
[    5.133340] usb 1-1.5.3: usb_probe_device
[    5.133344] usb 1-1.5.3: configuration #1 chosen from 1 choice
[    5.133902] usb 1-1.5.3: adding 1-1.5.3:1.0 (config #1, interface 0)
[    5.133968] usbhid 1-1.5.3:1.0: usb_probe_interface
[    5.133971] usbhid 1-1.5.3:1.0: usb_probe_interface - got id
[    5.146652] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
1a.0/usb1/1-1/1-1.5/1-1.5.3/1-1.5.3:1.0/input/input6
[    5.146711] usb 1-1.5.3: link qh8-0e01/ffff880231d1a700 start 3 [1/2 us]
[    5.146903] logitech 0003:046D:C517.0001: input,hidraw0: USB HID v1.10 K=
eyboard [Logitech USB Receiver] on usb-0000:00:1a.0-1.5.3/input0
[    5.146964] usb 1-1.5.3: adding 1-1.5.3:1.1 (config #1, interface 1)
[    5.147032] usbhid 1-1.5.3:1.1: usb_probe_interface
[    5.147038] usbhid 1-1.5.3:1.1: usb_probe_interface - got id
[    5.151916] logitech 0003:046D:C517.0002: fixing up Logitech keyboard re=
port descriptor
[    5.152679] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
1a.0/usb1/1-1/1-1.5/1-1.5.3/1-1.5.3:1.1/input/input7
[    5.152714] usb 1-1.5.3: link qh8-0e01/ffff8802329aaf00 start 4 [1/2 us]
[    5.152869] usbhid 1-1.5.3:1.1: looking for a minor, starting at 96
[    5.152950] logitech 0003:046D:C517.0002: input,hiddev0,hidraw1: USB HID=
 v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1a.0-1.5.3/input1
[    5.152971] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'005'
[    5.153018] hub 1-1.5:1.0: state 7 ports 4 chg 0000 evt 000c
[    5.153247] hub 1-1.5:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
[    5.256651] hub 1-1.5:1.0: debounce: port 2: total 100ms stable 100ms st=
atus 0x301
[    5.267647] hub 1-1.5:1.0: port 2 not reset yet, waiting 10ms
[    5.329643] usb 1-1.5.2: new low speed USB device using ehci_hcd and add=
ress 6
[    5.342635] hub 1-1.5:1.0: port 2 not reset yet, waiting 10ms
[    5.423714] usb 1-1.5.2: skipped 1 descriptor after interface
[    5.425960] usb 1-1.5.2: default language 0x0409
[    5.432233] usb 1-1.5.2: udev 6, busnum 1, minor =3D 5
[    5.432238] usb 1-1.5.2: New USB device found, idVendor=3D045e, idProduc=
t=3D0024
[    5.432242] usb 1-1.5.2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    5.432246] usb 1-1.5.2: Product: Microsoft Trackball Explorer=C2=AE
[    5.432249] usb 1-1.5.2: Manufacturer: Microsoft
[    5.432439] usb 1-1.5.2: usb_probe_device
[    5.432445] usb 1-1.5.2: configuration #1 chosen from 1 choice
[    5.433151] usb 1-1.5.2: adding 1-1.5.2:1.0 (config #1, interface 0)
[    5.433247] usbhid 1-1.5.2:1.0: usb_probe_interface
[    5.433252] usbhid 1-1.5.2:1.0: usb_probe_interface - got id
[    5.439479] input: Microsoft Microsoft Trackball Explorer=C2=AE as /devi=
ces/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5.2/1-1.5.2:1.0/input/input8
[    5.439737] generic-usb 0003:045E:0024.0003: input,hidraw2: USB HID v1.0=
0 Mouse [Microsoft Microsoft Trackball Explorer=C2=AE] on usb-0000:00:1a.0-=
1.5.2/input0
[    5.439798] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'006'
[    6.943804] hub 2-1:1.0: hub_suspend
[    6.943819] usb 2-1: unlink qh256-0001/ffff880230be8600 start 1 [1/0 us]
[    6.944062] usb 2-1: usb auto-suspend
[    6.951941] usb 1-1.4: usb auto-suspend
[    8.953849] hub 2-0:1.0: hub_suspend
[    8.953862] usb usb2: bus auto-suspend
[    8.953867] ehci_hcd 0000:00:1d.0: suspend root hub
[   10.326435] padlock_aes: VIA PadLock not detected.
[   10.651064] EXT4-fs (sda1): mounted filesystem with ordered data mode. O=
pts: (null)
[   10.651640] device fsid bd472ced4ab38dca-60668af8a13a3288 devid 1 transi=
d 577 /dev/mapper/luks-52a5d32c-b034-4aaa-9fbc-242c46b4c9a0
[   11.174456] Adding 6143996k swap on /dev/sda3.  Priority:-1 extents:1 ac=
ross:6143996k SS
[   11.392409] NET: Registered protocol family 10
[   11.406804] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   12.176823] e1000e 0000:00:19.0: irq 42 for MSI/MSI-X
[   12.227543] e1000e 0000:00:19.0: irq 42 for MSI/MSI-X
[   12.229461] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   12.260319] RPC: Registered udp transport module.
[   12.260322] RPC: Registered tcp transport module.
[   12.260323] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   12.544607] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   12.703700] usb 1-1.5.2: link qh8-0e01/ffff88022b189f80 start 5 [1/2 us]
[   12.703757] usb 1-1.5.2: unlink qh8-0e01/ffff88022b189f80 start 5 [1/2 u=
s]
[   13.452415] Bluetooth: L2CAP ver 2.15
[   13.452419] Bluetooth: L2CAP socket layer initialized
[   13.463615] Bluetooth: SCO (Voice Link) ver 0.6
[   13.463618] Bluetooth: SCO socket layer initialized
[   13.464491] usb 1-1.4: usb auto-resume
[   13.472690] sshd (1380): /proc/1380/oom_adj is deprecated, please use /p=
roc/1380/oom_score_adj instead.
[   13.501151] usb 1-1.4: finish resume
[   13.501593] usb 1-1.4: link qh1-0e01/ffff880231d1a800 start 0 [1/2 us]
[   13.552702] Bluetooth: RFCOMM socket layer initialized
[   13.552706] Bluetooth: RFCOMM ver 1.11
[   13.802801] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Contr=
ol: None
[   13.802812] e1000e 0000:00:19.0: eth0: 10/100 speed: disabling TSO
[   13.807376] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.405258] ehci_hcd 0000:00:1a.0: reused qh ffff88022b189f80 schedule
[   15.405267] usb 1-1.5.2: link qh8-0e01/ffff88022b189f80 start 5 [1/2 us]
[   15.939910] usb 1-1.4: unlink qh1-0e01/ffff880231d1a800 start 0 [1/2 us]
[   15.940181] usb 1-1: clear tt buffer port 4, a3 ep2 t04048dc2
[   15.940442] usb 1-1.4: usb auto-suspend
[   24.090471] eth0: no IPv6 routers present
[   27.715160] fuse init (API version 7.16)
[   42.437868] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0010
[   42.438172] hub 1-1:1.0: port 4, status 0100, change 0001, 12 Mb/s
[   42.438270] usb 1-1.4: USB disconnect, address 3
[   42.438273] usb 1-1.4: unregistering device
[   42.438276] usb 1-1.4: unregistering interface 1-1.4:1.0
[   42.654990] PM: Syncing filesystems ... done.
[   42.665477] PM: Preparing system for mem sleep
[   42.678541] usb 1-1.5.2: unlink qh8-0e01/ffff88022b189f80 start 5 [1/2 u=
s]
[   42.688564] usb 1-1.4: unregistering interface 1-1.4:1.1
[   42.688622] usb 1-1.4: unregistering interface 1-1.4:1.2
[   42.688679] usb 1-1.4: unregistering interface 1-1.4:1.3
[   42.688708] usb 1-1.4: usb_disable_device nuking all URBs
[   42.783586] Freezing user space processes ...=20
[   42.792568] hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms stat=
us 0x100
[   42.795364] (elapsed 0.01 seconds) done.
[   42.795368] Freezing remaining freezable tasks ... (elapsed 0.01 seconds=
) done.
[   42.806398] PM: Entering mem sleep
[   42.806530] Suspending console(s) (use no_console_suspend to debug)
[   42.806937] usb 1-1.5.3: unlink qh8-0e01/ffff8802329aaf00 start 4 [1/2 u=
s]
[   42.806949] usb 1-1.5.3: unlink qh8-0e01/ffff880231d1a700 start 3 [1/2 u=
s]
[   42.806998] usb 1-1.5.2: usb suspend
[   42.807398] usb 1-1.5.3: usb suspend
[   42.807648] usb usb2: usb auto-resume
[   42.807656] ehci_hcd 0000:00:1d.0: resume root hub
[   42.807791] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   42.808662] sd 0:0:0:0: [sda] Stopping disk
[   42.818358] hub 1-1.5:1.0: hub_suspend
[   42.818372] usb 1-1.5: unlink qh256-0001/ffff8802329aa100 start 2 [1/0 u=
s]
[   42.818694] usb 1-1.5: usb suspend
[   42.827323] hub 2-0:1.0: hub_resume
[   42.827339] hub 2-0:1.0: port 1: status 0507 change 0000
[   42.827362] usb 2-1: usb auto-resume
[   42.829426] hub 1-1:1.0: hub_suspend
[   42.829435] usb 1-1: unlink qh256-0001/ffff880230a65480 start 1 [1/0 us]
[   42.829510] usb 1-1: usb suspend
[   42.840405] hub 1-0:1.0: hub_suspend
[   42.840415] usb usb1: bus suspend
[   42.840418] ehci_hcd 0000:00:1a.0: suspend root hub
[   42.853448] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   42.864384] usb 2-1: finish resume
[   42.864637] hub 2-1:1.0: hub_resume
[   42.865615] ehci_hcd 0000:00:1d.0: reused qh ffff880230be8600 schedule
[   42.865623] usb 2-1: link qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   42.865634] hub 2-1:1.0: hub_suspend
[   42.865642] usb 2-1: unlink qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   42.865715] usb 2-1: usb suspend
[   42.876450] hub 2-0:1.0: hub_suspend
[   42.876458] usb usb2: bus suspend
[   42.876461] ehci_hcd 0000:00:1d.0: suspend root hub
[   42.999528] ehci_hcd 0000:00:1d.0: PCI INT D disabled
[   42.999556] ehci_hcd 0000:00:1a.0: PCI INT D disabled
[   43.014233] i915 0000:00:02.0: power state changed by ACPI to D3
[   43.105681] e1000e 0000:00:19.0: PCI INT A disabled
[   43.105688] e1000e 0000:00:19.0: PME# enabled
[   43.105696] e1000e 0000:00:19.0: wake-up capability enabled by ACPI
[   44.201813] HDA Intel 0000:00:1b.0: PCI INT B disabled
[   44.212882] PM: suspend of devices complete after 1406.690 msecs
[   44.224007] ehci_hcd 0000:00:1d.0: wakeup: 0
[   44.234801] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D3
[   44.234807] ehci_hcd 0000:00:1d.0: --> PCI D3hot
[   44.234850] ehci_hcd 0000:00:1a.0: wakeup: 0
[   44.250735] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D3
[   44.250742] ehci_hcd 0000:00:1a.0: --> PCI D3hot
[   44.250879] PM: late suspend of devices complete after 38.009 msecs
[   44.251098] ACPI: Preparing to enter system sleep state S3
[   44.303802] PM: Saving platform NVS memory
[   44.308938] Disabling non-boot CPUs ...
[   44.310802] CPU 1 is now offline
[   44.324125] CPU 2 is now offline
[   44.331839] Broke affinity for irq 9
[   44.332886] CPU 3 is now offline
[   44.333950] Extended CMOS year: 2000
[   44.334292] Back to C!
[   44.334295] PM: Restoring platform NVS memory
[   44.334960] microcode: CPU0 updated to revision 0xc, date =3D 2010-06-10
[   44.335258] Extended CMOS year: 2000
[   44.335309] Enabling non-boot CPUs ...
[   44.335410] Booting Node 0 Processor 1 APIC 0x1
[   44.426948] Switched to NOHz mode on CPU #1
[   44.428117] NMI watchdog enabled, takes one hw-pmu counter.
[   44.428484] microcode: CPU1 updated to revision 0xc, date =3D 2010-06-10
[   44.436057] CPU1 is up
[   44.436144] Booting Node 0 Processor 2 APIC 0x4
[   44.527182] NMI watchdog enabled, takes one hw-pmu counter.
[   44.527558] microcode: CPU2 updated to revision 0xc, date =3D 2010-06-10
[   44.527869] Switched to NOHz mode on CPU #2
[   44.535025] CPU2 is up
[   44.535107] Booting Node 0 Processor 3 APIC 0x5
[   44.626102] NMI watchdog enabled, takes one hw-pmu counter.
[   44.626844] microcode: CPU3 updated to revision 0xc, date =3D 2010-06-10
[   44.626854] Switched to NOHz mode on CPU #3
[   44.635095] CPU3 is up
[   44.636672] ACPI: Waking up from system sleep state S3
[   44.683900] intel ips 0000:00:1f.6: MCP limit exceeded: Avg temp 20777, =
limit 9000
[   44.716003] agpgart-intel 0000:00:00.0: restoring config space at offset=
 0x1 (was 0x900006, writing 0x20900006)
[   44.716017] i915 0000:00:02.0: restoring config space at offset 0x1 (was=
 0x900007, writing 0x900407)
[   44.716098] e1000e 0000:00:19.0: restoring config space at offset 0x1 (w=
as 0x100103, writing 0x100107)
[   44.716128] ehci_hcd 0000:00:1a.0: restoring config space at offset 0xf =
(was 0x400, writing 0x40b)
[   44.716146] ehci_hcd 0000:00:1a.0: restoring config space at offset 0x4 =
(was 0x0, writing 0xf2728000)
[   44.716154] ehci_hcd 0000:00:1a.0: restoring config space at offset 0x1 =
(was 0x2900000, writing 0x2900102)
[   44.720851] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   44.720861] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   44.720965] pcieport 0000:00:1c.0: restoring config space at offset 0x7 =
(was 0xf0, writing 0x200000f0)
[   44.721070] pcieport 0000:00:1c.4: restoring config space at offset 0xf =
(was 0x100, writing 0x4010b)
[   44.721081] pcieport 0000:00:1c.4: restoring config space at offset 0x9 =
(was 0x10001, writing 0x1fff1)
[   44.721086] pcieport 0000:00:1c.4: restoring config space at offset 0x8 =
(was 0x0, writing 0xf240f240)
[   44.721091] pcieport 0000:00:1c.4: restoring config space at offset 0x7 =
(was 0x0, writing 0x200000f0)
[   44.721099] pcieport 0000:00:1c.4: restoring config space at offset 0x3 =
(was 0x810000, writing 0x810010)
[   44.721105] pcieport 0000:00:1c.4: restoring config space at offset 0x1 =
(was 0x100000, writing 0x100107)
[   44.721139] ehci_hcd 0000:00:1d.0: restoring config space at offset 0xf =
(was 0x400, writing 0x40b)
[   44.721157] ehci_hcd 0000:00:1d.0: restoring config space at offset 0x4 =
(was 0x0, writing 0xf2728400)
[   44.721165] ehci_hcd 0000:00:1d.0: restoring config space at offset 0x1 =
(was 0x2900000, writing 0x2900102)
[   44.721183] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   44.721186] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   44.721290] ahci 0000:00:1f.2: restoring config space at offset 0x1 (was=
 0x2b00007, writing 0x2b00407)
[   44.721356] intel ips 0000:00:1f.6: restoring config space at offset 0xf=
 (was 0x400, writing 0x40b)
[   44.721378] intel ips 0000:00:1f.6: restoring config space at offset 0x1=
 (was 0x100000, writing 0x100002)
[   44.721596] PM: early resume of devices complete after 5.721 msecs
[   44.721725] i915 0000:00:02.0: power state changed by ACPI to D0
[   44.721729] i915 0000:00:02.0: power state changed by ACPI to D0
[   44.721734] i915 0000:00:02.0: setting latency timer to 64
[   44.721837] e1000e 0000:00:19.0: wake-up capability disabled by ACPI
[   44.721846] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   44.721848] e1000e 0000:00:19.0: PME# disabled
[   44.721860] HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> =
IRQ 17
[   44.721872] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   44.721956] HDA Intel 0000:00:1b.0: irq 42 for MSI/MSI-X
[   44.722040] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[   44.722882] ehci_hcd 0000:00:1a.0: power state changed by ACPI to D0
[   44.722890] ehci_hcd 0000:00:1a.0: PCI INT D -> GSI 23 (level, low) -> I=
RQ 23
[   44.722897] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[   44.722928] usb usb1: usb resume
[   44.722932] ehci_hcd 0000:00:1a.0: resume root hub
[   44.722956] pci 0000:00:1e.0: setting latency timer to 64
[   44.722971] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   44.722990] ahci 0000:00:1f.2: setting latency timer to 64
[   44.723133] ehci_hcd 0000:00:1d.0: power state changed by ACPI to D0
[   44.723143] ehci_hcd 0000:00:1d.0: PCI INT D -> GSI 19 (level, low) -> I=
RQ 19
[   44.723156] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[   44.723192] sd 0:0:0:0: [sda] Starting disk
[   44.723200] usb usb2: usb resume
[   44.723204] ehci_hcd 0000:00:1d.0: resume root hub
[   44.742799] hub 1-0:1.0: hub_resume
[   44.742802] hub 2-0:1.0: hub_resume
[   44.742814] hub 2-0:1.0: port 1: status 0507 change 0000
[   44.742816] hub 1-0:1.0: port 1: status 0507 change 0000
[   44.742847] usb 2-1: usb resume
[   44.742857] usb 1-1: usb resume
[   44.758857] legacy_resume(): pnp_bus_resume+0x0/0x6c returns -19
[   44.758859] PM: Device 00:0c failed to resume: error -19
[   44.768822] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   44.768825] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   44.779791] usb 1-1: finish resume
[   44.779793] usb 2-1: finish resume
[   44.779970] hub 2-1:1.0: hub_resume
[   44.779981] hub 1-1:1.0: hub_resume
[   44.780607] hub 1-1:1.0: port 5: status 0507 change 0000
[   44.780712] ehci_hcd 0000:00:1a.0: reused qh ffff880230a65480 schedule
[   44.780715] usb 1-1: link qh256-0001/ffff880230a65480 start 1 [1/0 us]
[   44.780964] usb 1-1.5: usb resume
[   44.780975] ehci_hcd 0000:00:1d.0: reused qh ffff880230be8600 schedule
[   44.780978] usb 2-1: link qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   44.817951] usb 1-1.5: finish resume
[   44.818076] hub 1-1.5:1.0: hub_resume
[   44.818331] hub 1-1.5:1.0: port 2: status 0307 change 0000
[   44.818452] hub 1-1.5:1.0: port 3: status 0307 change 0000
[   44.818579] ehci_hcd 0000:00:1a.0: reused qh ffff8802329aa100 schedule
[   44.818582] usb 1-1.5: link qh256-0001/ffff8802329aa100 start 2 [1/0 us]
[   44.818826] usb 1-1.5.2: usb resume
[   44.818951] usb 1-1.5.3: usb resume
[   44.855935] usb 1-1.5.2: finish resume
[   44.855938] usb 1-1.5.3: finish resume
[   44.856830] ehci_hcd 0000:00:1a.0: reused qh ffff880231d1a700 schedule
[   44.856834] usb 1-1.5.3: link qh8-0e01/ffff880231d1a700 start 3 [1/2 us]
[   44.856850] ehci_hcd 0000:00:1a.0: reused qh ffff8802329aaf00 schedule
[   44.856852] usb 1-1.5.3: link qh8-0e01/ffff8802329aaf00 start 4 [1/2 us]
[   45.029759] ata2: SATA link down (SStatus 0 SControl 300)
[   45.031762] ata6: SATA link down (SStatus 0 SControl 300)
[   45.033757] ata5: SATA link down (SStatus 0 SControl 300)
[   45.094625] No ACPI video bus found
[   45.947359] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   46.174426] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[   46.174433] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[   46.174439] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[   46.904565] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[   46.904572] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[   46.904578] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[   47.228822] ata1.00: configured for UDMA/100
[   47.434268] PM: resume of devices complete after 2713.775 msecs
[   47.434475] PM: Finishing wakeup.
[   47.434477] Restarting tasks ...=20
[   47.434524] hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   47.434530] hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0000
[   47.434537] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   47.434541] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0000
[   47.434546] hub 1-1.5:1.0: state 7 ports 4 chg 0000 evt 0000
[   47.443448] done.
[   47.641377] ehci_hcd 0000:00:1a.0: reused qh ffff88022b189f80 schedule
[   47.641381] usb 1-1.5.2: link qh8-0e01/ffff88022b189f80 start 5 [1/2 us]
[   48.904301] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[   48.955124] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[   48.958418] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   49.063358] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   49.074202] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0010
[   49.074548] hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
[   49.179013] hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms stat=
us 0x101
[   49.241982] usb 1-1.4: new full speed USB device using ehci_hcd and addr=
ess 7
[   49.252987] hub 1-1:1.0: port 4 not reset yet, waiting 10ms
[   49.329854] usb 1-1.4: skipped 1 descriptor after interface
[   49.330195] usb 1-1.4: default language 0x0409
[   49.331320] usb 1-1.4: udev 7, busnum 1, minor =3D 6
[   49.331327] usb 1-1.4: New USB device found, idVendor=3D0a5c, idProduct=
=3D217f
[   49.331335] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[   49.331341] usb 1-1.4: Product: Broadcom Bluetooth Device
[   49.331347] usb 1-1.4: Manufacturer: Broadcom Corp
[   49.331351] usb 1-1.4: SerialNumber: 00271396AABE
[   49.331584] usb 1-1.4: usb_probe_device
[   49.331592] usb 1-1.4: configuration #1 chosen from 1 choice
[   49.331829] usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
[   49.331936] btusb 1-1.4:1.0: usb_probe_interface
[   49.331942] btusb 1-1.4:1.0: usb_probe_interface - got id
[   49.332461] usb 1-1.4: adding 1-1.4:1.1 (config #1, interface 1)
[   49.332637] usb 1-1.4: adding 1-1.4:1.2 (config #1, interface 2)
[   49.332720] btusb 1-1.4:1.2: usb_probe_interface
[   49.332726] btusb 1-1.4:1.2: usb_probe_interface - got id
[   49.332851] usb 1-1.4: adding 1-1.4:1.3 (config #1, interface 3)
[   49.332939] btusb 1-1.4:1.3: usb_probe_interface
[   49.332945] btusb 1-1.4:1.3: usb_probe_interface - got id
[   49.332961] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'007'
[   49.333431] usb 1-1.4: link qh1-0e01/ffff88020cebc480 start 0 [1/2 us]
[   49.934658] hub 2-1:1.0: hub_suspend
[   49.934671] usb 2-1: unlink qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   49.934922] usb 2-1: usb auto-suspend
[   50.543368] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Contr=
ol: None
[   50.543375] e1000e 0000:00:19.0: eth0: 10/100 speed: disabling TSO
[   50.546463] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   51.933834] usb 1-1.4: unlink qh1-0e01/ffff88020cebc480 start 0 [1/2 us]
[   51.934097] usb 1-1: clear tt buffer port 4, a7 ep2 t04048dc2
[   51.934464] usb 1-1.4: usb auto-suspend
[   51.944774] hub 2-0:1.0: hub_suspend
[   51.944785] usb usb2: bus auto-suspend
[   51.944790] ehci_hcd 0000:00:1d.0: suspend root hub
[   57.752704] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.753640] ehci_hcd 0000:00:1a.0: detected XactErr len 0/20 retry 1
[   57.754662] ehci_hcd 0000:00:1a.0: detected XactErr len 0/4 retry 1
[   57.760590] usb 1-1.5.3: unlink qh8-0e01/ffff880231d1a700 start 3 [1/2 u=
s]
[   57.760768] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.760911] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.761026] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.761152] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.761274] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.761385] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.761400] usb 1-1.5.3: unlink qh8-0e01/ffff8802329aaf00 start 4 [1/2 u=
s]
[   57.761490] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.761633] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.761762] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.761857] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.761977] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.762103] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.762261] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.762372] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.762388] usb 1-1.5.2: unlink qh8-0e01/ffff88022b189f80 start 5 [1/2 u=
s]
[   57.762483] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.762638] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.762643] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.762728] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.762733] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.762855] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.762860] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.762981] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.762985] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.763101] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.763106] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.763268] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.763272] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.763398] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.763403] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.763520] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.763525] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.763589] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.763593] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.763727] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.763732] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.763853] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.763858] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.763979] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.763983] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.764104] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.764108] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.764257] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.764263] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.764373] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.764378] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.764500] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.764505] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.764605] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.764609] ehci_hcd 0000:00:1a.0: devpath 1.5.3 ep0out 3strikes
[   57.764615] usb 1-1.5: clear tt buffer port 3, a5 ep0 t00080248
[   57.764666] ehci_hcd 0000:00:1a.0: reused qh ffff880231d1a700 schedule
[   57.764672] usb 1-1.5.3: link qh8-0e01/ffff880231d1a700 start 3 [1/2 us]
[   57.764680] logitech 0003:046D:C517.0001: can't reset device, 0000:00:1a=
.0-1.5.3/input0, status -71
[   57.764725] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.764730] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.764852] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.764857] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.764978] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.764983] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.765104] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.765109] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.765227] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.765231] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.765351] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.765356] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.765474] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.765478] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.765588] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.765593] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.765714] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.765719] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.765856] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.765860] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.765977] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.765981] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.766102] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.766107] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.766257] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.766262] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.766374] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.766379] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.766477] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.766481] ehci_hcd 0000:00:1a.0: devpath 1.5.2 ep0out 3strikes
[   57.766486] usb 1-1.5: clear tt buffer port 2, a6 ep0 t00080248
[   57.766534] ehci_hcd 0000:00:1a.0: reused qh ffff88022b189f80 schedule
[   57.766540] usb 1-1.5.2: link qh8-0e01/ffff88022b189f80 start 5 [1/2 us]
[   57.766548] generic-usb 0003:045E:0024.0003: can't reset device, 0000:00=
:1a.0-1.5.2/input0, status -71
[   57.766604] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.766728] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.766854] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.766980] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.767100] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.767228] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.767351] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.767463] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.767606] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.767726] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.767851] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.767977] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.768104] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.768258] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.768379] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.768476] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.768482] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.768602] ehci_hcd 0000:00:1a.0: devpath 1.5 ep0out 3strikes
[   57.768624] usb 1-1.5: clear tt 3 (0050) error -71
[   57.768730] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.768743] usb 1-1.5.3: unlink qh8-0e01/ffff880231d1a700 start 3 [1/2 u=
s]
[   57.768854] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.768859] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.768975] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.768980] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.769101] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.769106] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.769223] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.769228] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.769351] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.769355] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.769462] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.769467] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.769602] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.769607] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.769726] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.769731] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.769853] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.769857] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.769975] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.769979] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.770101] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.770105] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.770259] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.770265] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.770371] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.770376] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.770477] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.770481] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.770487] ehci_hcd 0000:00:1a.0: detected XactErr len 0/4 retry 1
[   57.770599] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.770604] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.770726] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.770730] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.770745] usb 1-1.5.2: unlink qh8-0e01/ffff88022b189f80 start 5 [1/2 u=
s]
[   57.770836] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.770841] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.770978] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.770983] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.771098] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.771102] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.771232] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.771236] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.771350] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.771355] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.771474] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.771478] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.771586] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.771591] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.771712] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.771717] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.771853] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.771858] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.771974] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.771979] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.772100] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.772105] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.772225] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.772229] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.772342] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.772347] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.772503] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.772509] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.772597] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.772602] ehci_hcd 0000:00:1a.0: devpath 1.5.3 ep0out 3strikes
[   57.772607] usb 1-1.5: clear tt buffer port 3, a5 ep0 t00080248
[   57.772654] ehci_hcd 0000:00:1a.0: reused qh ffff8802329aaf00 schedule
[   57.772660] usb 1-1.5.3: link qh8-0e01/ffff8802329aaf00 start 4 [1/2 us]
[   57.772668] logitech 0003:046D:C517.0002: can't reset device, 0000:00:1a=
.0-1.5.3/input1, status -71
[   57.772730] ehci_hcd 0000:00:1a.0: devpath 1.5 ep0out 3strikes
[   57.772748] usb 1-1.5: clear tt 2 (0060) error -71
[   57.772850] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.772975] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.772980] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.773101] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.773105] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.773229] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.773233] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.773346] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.773351] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.773462] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.773467] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.773600] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.773604] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.773724] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.773728] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.773850] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.773854] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.773976] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.773980] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.774102] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.774107] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.774230] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.774235] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.774335] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.774339] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.774365] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0020
[   57.774472] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.774477] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.774603] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.774608] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.774620] hub 1-1:1.0: port 5, status 0100, change 0001, 12 Mb/s
[   57.774728] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.774732] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.774743] usb 1-1.5: USB disconnect, address 4
[   57.774747] usb 1-1.5.2: USB disconnect, address 6
[   57.774750] usb 1-1.5.2: unregistering device
[   57.774754] usb 1-1.5.2: unregistering interface 1-1.5.2:1.0
[   57.774847] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.774852] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.774959] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.774964] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.775088] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.775095] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.775212] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.775217] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.775333] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.775338] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.775460] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.775464] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.775585] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.775590] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.775708] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.775712] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.775837] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.775845] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.775978] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.775983] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.776098] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.776103] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.776209] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.776214] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.776351] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.776356] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.776473] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.776477] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.776609] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.776614] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.776738] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.776742] ehci_hcd 0000:00:1a.0: devpath 1.5.2 ep0out 3strikes
[   57.776747] usb 1-1.5: clear tt buffer port 2, a6 ep0 t00080248
[   57.776770] generic-usb 0003:045E:0024.0003: can't reset device, 0000:00=
:1a.0-1.5.2/input0, status -71
[   57.776870] ehci_hcd 0000:00:1a.0: devpath 1.5 ep0out 3strikes
[   57.776886] usb 1-1.5: clear tt 3 (0050) error -71
[   57.776893] usb 1-1.5: clear tt 2 (0060) error -19
[   57.776988] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 1
[   57.777109] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 2
[   57.777209] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 3
[   57.777335] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 4
[   57.777459] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 5
[   57.777466] ehci_hcd 0000:00:1a.0: detected XactErr len 0/20 retry 1
[   57.777601] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 6
[   57.777722] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 7
[   57.777736] usb 1-1.5.3: unlink qh8-0e01/ffff8802329aaf00 start 4 [1/2 u=
s]
[   57.777848] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 8
[   57.777975] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 9
[   57.778095] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 10
[   57.778208] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 11
[   57.778364] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 12
[   57.778475] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 13
[   57.778596] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 14
[   57.778722] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 15
[   57.778849] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 16
[   57.778990] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 17
[   57.779112] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 18
[   57.779207] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 19
[   57.779366] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 20
[   57.779486] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 21
[   57.779609] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 22
[   57.779736] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 23
[   57.779862] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 24
[   57.779985] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 25
[   57.780108] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 26
[   57.780209] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 27
[   57.780332] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 28
[   57.780459] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 29
[   57.780581] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 30
[   57.780706] ehci_hcd 0000:00:1a.0: detected XactErr len 0/8 retry 31
[   57.780848] ehci_hcd 0000:00:1a.0: devpath 1.5.3 ep0out 3strikes
[   57.780856] usb 1-1.5: clear tt buffer port 3, a5 ep0 t00080248
[   57.781189] logitech 0003:046D:C517.0001: can't reset device, 0000:00:1a=
.0-1.5.3/input0, status -71
[   57.781200] usb 1-1.5: clear tt 3 (0050) error -19
[   57.787439] usb 1-1.5.2: usb_disable_device nuking all URBs
[   57.787634] usb 1-1.5.3: USB disconnect, address 5
[   57.787641] usb 1-1.5.3: unregistering device
[   57.787647] usb 1-1.5.3: unregistering interface 1-1.5.3:1.0
[   57.796461] usb 1-1.5.3: unregistering interface 1-1.5.3:1.1
[   57.815314] /home/hohndel/linux/drivers/usb/core/file.c: removing 96 min=
or
[   57.815586] usb 1-1.5.3: usb_disable_device nuking all URBs
[   57.816896] e1000e: eth0 NIC Link is Down
[   57.820330] usb 1-1.5: unregistering device
[   57.820335] usb 1-1.5: unregistering interface 1-1.5:1.0
[   57.820393] usb 1-1.5: unlink qh256-0001/ffff8802329aa100 start 2 [1/0 u=
s]
[   57.820464] ehci_hcd 0000:00:1a.0: shutdown urb ffff880232480600 ep1in-i=
ntr
[   57.820530] usb 1-1.5: usb_disable_device nuking all URBs
[   57.925363] hub 1-1:1.0: debounce: port 5: total 100ms stable 100ms stat=
us 0x100
[   58.403824] thinkpad_acpi: EC reports that Thermal Table has changed
[   58.404982] ACPI: \_SB_.GDCK - undocking
[   59.934306] hub 1-1:1.0: hub_suspend
[   59.934317] usb 1-1: unlink qh256-0001/ffff880230a65480 start 1 [1/0 us]
[   59.934442] usb 1-1: usb auto-suspend
[   61.107802] eth0: no IPv6 routers present
[   61.944458] hub 1-0:1.0: hub_suspend
[   61.944472] usb usb1: bus auto-suspend
[   61.944477] ehci_hcd 0000:00:1a.0: suspend root hub
[   63.620732] ehci_hcd 0000:00:1a.0: port 1 remote wakeup
[   63.620835] usb usb1: usb wakeup-resume
[   63.620843] usb usb1: usb auto-resume
[   63.620849] ehci_hcd 0000:00:1a.0: resume root hub
[   63.640660] hub 1-0:1.0: hub_resume
[   63.640679] hub 1-0:1.0: port 1: status 0507 change 0000
[   63.640705] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   63.785917] PM: Syncing filesystems ... done.
[   63.795661] PM: Preparing system for mem sleep
[   64.054632] Freezing user space processes ... (elapsed 0.01 seconds) don=
e.
[   64.066550] Freezing remaining freezable tasks ... (elapsed 0.01 seconds=
) done.
[   64.077574] PM: Entering mem sleep
[   64.077716] Suspending console(s) (use no_console_suspend to debug)
[   64.078069] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   64.078079] usb 1-1: finish resume
[   64.078337] hub 1-1:1.0: hub_resume
[   64.078563] usb usb2: usb auto-resume
[   64.078570] ehci_hcd 0000:00:1d.0: resume root hub
[   64.078615] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   64.078847] hub 1-1:1.0: port 4: status 0100 change 0001
[   64.079458] sd 0:0:0:0: [sda] Stopping disk
[   64.098468] hub 2-0:1.0: hub_resume
[   64.098482] hub 2-0:1.0: port 1: status 0507 change 0000
[   64.098504] usb 2-1: usb auto-resume
[   64.124549] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   64.135472] usb 2-1: finish resume
[   64.135720] hub 2-1:1.0: hub_resume
[   64.136726] ehci_hcd 0000:00:1d.0: reused qh ffff880230be8600 schedule
[   64.136733] usb 2-1: link qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   64.136745] hub 2-1:1.0: hub_suspend
[   64.136753] usb 2-1: unlink qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   64.136828] usb 2-1: usb suspend
[   64.147527] hub 2-0:1.0: hub_suspend
[   64.147536] usb usb2: bus suspend
[   64.147539] ehci_hcd 0000:00:1d.0: suspend root hub
[   64.179492] ehci_hcd 0000:00:1a.0: reused qh ffff880230a65480 schedule
[   64.179499] usb 1-1: link qh256-0001/ffff880230a65480 start 1 [1/0 us]
[   64.179709] hub 1-1:1.0: port 4 status 0000.0100 after resume, -19
[   64.179714] usb 1-1.4: can't resume, status -19
[   64.179717] hub 1-1:1.0: logical disconnect on port 4
[   64.179854] hub 1-1:1.0: port 4 nyet suspended
[   64.179858] hub 1-1:1.0: suspend error -16
[   64.179869] pm_op(): usb_dev_suspend+0x0/0x15 returns -16
[   64.179877] PM: Device 1-1 failed to suspend async: error -16
[   64.269480] PM: Some devices failed to suspend
[   64.269620] sd 0:0:0:0: [sda] Starting disk
[   64.269642] hub 1-0:1.0: hub_resume
[   64.269658] hub 1-0:1.0: port 1: status 0503 change 0000
[   64.269676] usb usb2: usb resume
[   64.269679] hub 1-0:1.0: activate --> -22
[   64.269682] ehci_hcd 0000:00:1d.0: resume root hub
[   64.269704] hub 1-1:1.0: hub_resume
[   64.270268] hub 1-1:1.0: port 4: status 0100 change 0000
[   64.270546] hub 1-1:1.0: activate --> -22
[   64.287481] legacy_resume(): pnp_bus_resume+0x0/0x6c returns -19
[   64.287486] PM: Device 00:0c failed to resume: error -19
[   64.289364] hub 2-0:1.0: hub_resume
[   64.289374] hub 2-0:1.0: port 1: status 0507 change 0000
[   64.289403] usb 2-1: usb resume
[   64.315469] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK=
 POWER sig=3Dse0 PE CONNECT
[   64.326439] usb 2-1: finish resume
[   64.326663] hub 2-1:1.0: hub_resume
[   64.327629] ehci_hcd 0000:00:1d.0: reused qh ffff880230be8600 schedule
[   64.327636] usb 2-1: link qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   64.327673] PM: resume of devices complete after 58.212 msecs
[   64.327833] PM: Finishing wakeup.
[   64.327834] Restarting tasks ...=20
[   64.327865] hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   64.327872] hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0000
[   64.327880] hub 1-1:1.0: state 7 ports 6 chg 0010 evt 0000
[   64.328757] hub 1-1:1.0: port 4, status 0100, change 0000, 12 Mb/s
[   64.329015] usb 1-1.4: USB disconnect, address 7
[   64.329019] usb 1-1.4: unregistering device
[   64.329022] usb 1-1.4: unregistering interface 1-1.4:1.0
[   64.330542] done.
[   64.580920] usb 1-1.4: unregistering interface 1-1.4:1.1
[   64.580994] usb 1-1.4: unregistering interface 1-1.4:1.2
[   64.581054] usb 1-1.4: unregistering interface 1-1.4:1.3
[   64.581085] usb 1-1.4: usb_disable_device nuking all URBs
[   64.581237] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   64.633462] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[   64.684361] e1000e 0000:00:19.0: irq 43 for MSI/MSI-X
[   64.687986] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   64.808259] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   64.824781] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0010
[   64.827314] hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
[   64.931273] hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms stat=
us 0x101
[   64.942392] hub 1-1:1.0: port 4 not reset yet, waiting 10ms
[   65.004274] usb 1-1.4: new full speed USB device using ehci_hcd and addr=
ess 8
[   65.015208] hub 1-1:1.0: port 4 not reset yet, waiting 10ms
[   65.092248] usb 1-1.4: skipped 1 descriptor after interface
[   65.092572] usb 1-1.4: default language 0x0409
[   65.093696] usb 1-1.4: udev 8, busnum 1, minor =3D 7
[   65.093701] usb 1-1.4: New USB device found, idVendor=3D0a5c, idProduct=
=3D217f
[   65.093706] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[   65.093710] usb 1-1.4: Product: Broadcom Bluetooth Device
[   65.093714] usb 1-1.4: Manufacturer: Broadcom Corp
[   65.093717] usb 1-1.4: SerialNumber: 00271396AABE
[   65.093893] usb 1-1.4: usb_probe_device
[   65.093901] usb 1-1.4: configuration #1 chosen from 1 choice
[   65.094629] usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
[   65.094724] btusb 1-1.4:1.0: usb_probe_interface
[   65.094730] btusb 1-1.4:1.0: usb_probe_interface - got id
[   65.095211] usb 1-1.4: adding 1-1.4:1.1 (config #1, interface 1)
[   65.095385] usb 1-1.4: adding 1-1.4:1.2 (config #1, interface 2)
[   65.095465] btusb 1-1.4:1.2: usb_probe_interface
[   65.095471] btusb 1-1.4:1.2: usb_probe_interface - got id
[   65.095580] usb 1-1.4: adding 1-1.4:1.3 (config #1, interface 3)
[   65.095662] btusb 1-1.4:1.3: usb_probe_interface
[   65.095667] btusb 1-1.4:1.3: usb_probe_interface - got id
[   65.095680] /home/hohndel/linux/drivers/usb/core/inode.c: creating file =
'008'
[   65.096582] usb 1-1.4: link qh1-0e01/ffff8801f9ae1a80 start 0 [1/2 us]
[   65.834976] notification-da[2413] general protection ip:32acc33231 sp:7f=
ffe74e4d60 error:0 in libgobject-2.0.so.0.2600.0[32acc00000+4c000]
[   66.927358] hub 2-1:1.0: hub_suspend
[   66.927371] usb 2-1: unlink qh256-0001/ffff880230be8600 start 1 [1/0 us]
[   66.927522] usb 2-1: usb auto-suspend
[   67.168257] usb 1-1.4: unlink qh1-0e01/ffff8801f9ae1a80 start 0 [1/2 us]
[   67.168597] usb 1-1: clear tt buffer port 4, a8 ep2 t04048dc2
[   67.169088] usb 1-1.4: usb auto-suspend
[   68.937441] hub 2-0:1.0: hub_suspend
[   68.937453] usb usb2: bus auto-suspend
[   68.937457] ehci_hcd 0000:00:1d.0: suspend root hub
[   69.934065] hub 1-1:1.0: hub_suspend
[   69.934078] usb 1-1: unlink qh256-0001/ffff880230a65480 start 1 [1/0 us]
[   69.934302] usb 1-1: usb auto-suspend
[   71.944178] hub 1-0:1.0: hub_suspend
[   71.944191] usb usb1: bus auto-suspend
[   71.944195] ehci_hcd 0000:00:1a.0: suspend root hub

--=-=-=
Content-Disposition: inline; filename=devices.txt


T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 3
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 2.06
S:  Manufacturer=Linux 2.6.38-rc4-00178-g795abaf ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 8
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0020 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 3
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 2.06
S:  Manufacturer=Linux 2.6.38-rc4-00178-g795abaf ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1a.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 6
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0020 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  8 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=217f Rev= 3.60
S:  Manufacturer=Broadcom Corp
S:  Product=Broadcom Bluetooth Device
S:  SerialNumber=00271396AABE
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
