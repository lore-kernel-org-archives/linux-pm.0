From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Suspend, followed by immediate resume
Date: Thu, 1 May 2008 21:44:37 -0500
Message-ID: <20080501214437.0ae618c5@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/QtgDrJVXBjpg3KV77xqhbP_"
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--MP_/QtgDrJVXBjpg3KV77xqhbP_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm trying to get wake-on-lan working on the network driver I maintain
(atl1), but I can't get my system to suspend to memory long enough to
test it.  Seems that my system suspends and immediately wakes up again
without any intervention on my part.  This is with kernel 2.6.25.1, but
I've always encountered this phenomenon, going back to 2.6.21 when the
driver was merged into mainline.  I've finally resolved to get to the
bottom of it, and I'm hoping linux-pm can help.

To suspend, I execute

echo mem > /sys/power/state

and the system actually suspends (as far as I can tell), but within a
few seconds it wakes up without any intervention on my part.  I've
included dmesg that shows the event, my kernel config (that has
CONFIG_DEBUG_PM=y), and lspci -vvxxx.

I'd appreciate any help.  Please cc me in your response, since I'm not
subscribed to linux-pm.

Thanks a lot.

Jay
--MP_/QtgDrJVXBjpg3KV77xqhbP_
Content-Type: text/plain; name=suspend-dmesg.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=suspend-dmesg.txt

Linux version 2.6.25.1 (jcliburn@osprey.hogchain.net) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #2 SMP Thu May 1 20:34:36 CDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f790000 (usable)
 BIOS-e820: 000000003f790000 - 000000003f79e000 (ACPI data)
 BIOS-e820: 000000003f79e000 - 000000003f7e0000 (ACPI NVS)
 BIOS-e820: 000000003f7e0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at [c00ff780] 000ff780
Entering add_active_range(0, 0, 259984) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259984
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   259984
On node 0 totalpages: 259984
  DMA zone: 52 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4044 pages, LIFO batch:0
  Normal zone: 2860 pages used for memmap
  Normal zone: 222420 pages, LIFO batch:31
  HighMem zone: 388 pages used for memmap
  HighMem zone: 30220 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP 000FAFB0, 0014 (r0 ACPIAM)
ACPI: RSDT 3F790000, 0038 (r1 A_M_I_ OEMRSDT   4000713 MSFT       97)
ACPI: FACP 3F790200, 0081 (r1 A_M_I_ OEMFACP   4000713 MSFT       97)
ACPI: DSDT 3F790410, 5623 (r1  A0605 A0605000        0 INTL 20060113)
ACPI: FACS 3F79E000, 0040
ACPI: APIC 3F790390, 0080 (r1 A_M_I_ OEMAPIC   4000713 MSFT       97)
ACPI: OEMB 3F79E040, 0066 (r1 A_M_I_ AMI_OEM   4000713 MSFT       97)
ACPI: HPET 3F795A40, 0038 (r1 A_M_I_ OEMHPET   4000713 MSFT       97)
ACPI: MCFG 3F795A80, 003C (r1 A_M_I_ OEMMCFG   4000713 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f800000:c0380000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 256684
Kernel command line: ro root=LABEL=/1 console=ttyS0,38400 console=tty0
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0793000 soft=c0773000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2133.303 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 992 kB
 per task-struct memory footprint: 1920 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1016980k/1039936k available (2117k kernel code, 22312k reserved, 1141k data, 244k init, 122432k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc54000 - 0xfffff000   (3756 kB)
    pkmap   : 0xff400000 - 0xff800000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0733000 - 0xc0770000   ( 244 kB)
      .data : 0xc061161b - 0xc072ebc0   (1141 kB)
      .text : 0xc0400000 - 0xc061161b   (2117 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 16 of 16 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 4269.34 BogoMIPS (lpj=2134674)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
using mwait in idle threads.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
CPU0: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
lockdep: fixing up alternatives.
Booting processor 1/1 ip 4000
CPU 1 irqstacks, hard=c0794000 soft=c0774000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4266.55 BogoMIPS (lpj=2133277)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
Total of 2 processors activated (8535.90 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000001 00000002
CPU1 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000002 00000001
PM: Adding info for No Bus:platform
net_namespace: 608 bytes
Time:  2:11:06  Date: 05/02/08
NET: Registered protocol family 16
No dock devices found.
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PM: Adding info for No Bus:id
PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub without MMCONFIG support.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:LNXSYSTM:00
PM: Adding info for acpi:LNXPWRBN:00
PM: Adding info for acpi:ACPI0007:00
PM: Adding info for acpi:ACPI0007:01
PM: Adding info for acpi:ACPI0007:02
PM: Adding info for acpi:ACPI0007:03
PM: Adding info for acpi:device:00
PM: Adding info for acpi:PNP0A08:00
PM: Adding info for acpi:PNP0C01:00
PM: Adding info for acpi:device:01
PM: Adding info for acpi:device:02
PM: Adding info for acpi:device:03
PM: Adding info for acpi:device:04
PM: Adding info for acpi:device:05
PM: Adding info for acpi:device:06
PM: Adding info for acpi:device:07
PM: Adding info for acpi:device:08
PM: Adding info for acpi:device:09
PM: Adding info for acpi:PNP0000:00
PM: Adding info for acpi:PNP0200:00
PM: Adding info for acpi:PNP0100:00
PM: Adding info for acpi:PNP0B00:00
PM: Adding info for acpi:PNP0800:00
PM: Adding info for acpi:PNP0C04:00
PM: Adding info for acpi:PNP0700:00
PM: Adding info for acpi:PNP0401:00
PM: Adding info for acpi:PNP0C02:00
PM: Adding info for acpi:PNP0C02:01
PM: Adding info for acpi:PNP0103:00
PM: Adding info for acpi:ATK0110:00
PM: Adding info for acpi:PNP0303:00
PM: Adding info for acpi:PNP0C02:02
PM: Adding info for acpi:PNP0501:00
PM: Adding info for acpi:INT0800:00
PM: Adding info for acpi:PNP0C02:03
PM: Adding info for acpi:PNP0C02:04
PM: Adding info for acpi:device:0a
PM: Adding info for acpi:device:0b
PM: Adding info for acpi:device:0c
PM: Adding info for acpi:device:0d
PM: Adding info for acpi:device:0e
PM: Adding info for acpi:device:0f
PM: Adding info for acpi:device:10
PM: Adding info for acpi:device:11
PM: Adding info for acpi:device:12
PM: Adding info for acpi:device:13
PM: Adding info for acpi:device:14
PM: Adding info for acpi:device:15
PM: Adding info for acpi:device:16
PM: Adding info for acpi:device:17
PM: Adding info for acpi:PNP0C01:01
PM: Adding info for acpi:PNP0C0C:00
PM: Adding info for acpi:PNP0C0F:00
PM: Adding info for acpi:PNP0C0F:01
PM: Adding info for acpi:PNP0C0F:02
PM: Adding info for acpi:PNP0C0F:03
PM: Adding info for acpi:PNP0C0F:04
PM: Adding info for acpi:PNP0C0F:05
PM: Adding info for acpi:PNP0C0F:06
PM: Adding info for acpi:PNP0C0F:07
PM: Adding info for acpi:LNXTHERM:00
ACPI: PCI Root Bridge [PCI0] (0000:00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for No Bus:0000:00
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/2770] 000600 00
pci 0000:00:00.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:02.0 [8086/2772] 000300 00
pci 0000:00:02.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1b.0 [8086/27d8] 000403 00
pci 0000:00:1b.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1c.0 [8086/27d0] 000604 01
pci 0000:00:1c.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1c.1 [8086/27d2] 000604 01
pci 0000:00:1c.1: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1d.0 [8086/27c8] 000c03 00
pci 0000:00:1d.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1d.1 [8086/27c9] 000c03 00
pci 0000:00:1d.1: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1d.2 [8086/27ca] 000c03 00
pci 0000:00:1d.2: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1d.3 [8086/27cb] 000c03 00
pci 0000:00:1d.3: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1d.7 [8086/27cc] 000c03 00
pci 0000:00:1d.7: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1e.0 [8086/244e] 000604 01
pci 0000:00:1e.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1f.0 [8086/27b8] 000601 00
pci 0000:00:1f.0: calling quirk 0xc0408053: ich_force_enable_hpet+0x0/0x15e()
pci 0000:00:1f.0: calling quirk 0xc0602f5a: quirk_ich6_lpc_acpi+0x0/0x65()
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
pci 0000:00:1f.0: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1f.1 [8086/27df] 000101 00
pci 0000:00:1f.1: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1f.2 [8086/27c0] 000101 00
pci 0000:00:1f.2: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Found 0000:00:1f.3 [8086/27da] 000c05 00
pci 0000:00:1f.3: calling quirk 0xc060569f: pci_fixup_transparent_bridge+0x0/0x2b()
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 030300, pass 0
PCI: Scanning bus 0000:03
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:00.0 [1969/1048] 000200 00
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Fixups for bus 0000:01
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 030300, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 010100, pass 1
PCI: Bus scan for 0000:00 returning with max=03
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:1b.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1c.1
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for No Bus:0000:03
PM: Adding info for pci:0000:02:00.0
PM: Adding info for No Bus:0000:02
PM: Adding info for No Bus:0000:01
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  88, should be 7B [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
ACPI: bus type pnp registered
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:11
pnp: PnP ACPI: found 18 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
system 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
system 00:08: ioport range 0x290-0x297 has been reserved
system 00:09: ioport range 0x4d0-0x4d1 has been reserved
system 00:09: ioport range 0x800-0x87f has been reserved
system 00:09: ioport range 0x480-0x4bf has been reserved
system 00:09: ioport range 0x900-0x91f has been reserved
system 00:09: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:09: iomem range 0xfed20000-0xfed8ffff has been reserved
system 00:09: iomem range 0xffb00000-0xffbfffff could not be reserved
system 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
system 00:0c: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0f: iomem range 0xffc00000-0xfff7ffff could not be reserved
system 00:10: iomem range 0xf0000000-0xf3ffffff has been reserved
system 00:11: iomem range 0x0-0x9ffff could not be reserved
system 00:11: iomem range 0xc0000-0xdffff could not be reserved
system 00:11: iomem range 0xe0000-0xfffff could not be reserved
system 00:11: iomem range 0x100000-0x3f7fffff could not be reserved
system 00:11: iomem range 0x0-0x0 could not be reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PM: Adding info for No Bus:oldmem
PM: Adding info for No Bus:lo
PCI: Bridge: 0000:00:1c.0
  IO window: e000-efff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: d000-dfff
  MEM window: 0xdff00000-0xdfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs...<7>Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
 it is
debug: unmapping init memory f7d05000..f7ff0000
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
type=2000 audit(1209694265.297:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:00.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:00.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:00.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:00.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:02.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:02.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:02.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:02.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:02.0: Boot video device
pci 0000:00:1b.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1b.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1b.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1b.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1c.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1c.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1c.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1c.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1c.1: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1c.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1c.1: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1c.1: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1d.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1d.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1d.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1d.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1d.1: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1d.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1d.1: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1d.1: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1d.2: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1d.2: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1d.2: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1d.2: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1d.3: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1d.3: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1d.3: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1d.3: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1d.7: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1d.7: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1d.7: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1d.7: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1e.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1e.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1e.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1e.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1f.0: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1f.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1f.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1f.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1f.1: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1f.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1f.1: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1f.1: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1f.2: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1f.2: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1f.2: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1f.2: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:00:1f.3: calling quirk 0xc0602b00: quirk_e100_interrupt+0x0/0x167()
pci 0000:00:1f.3: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1f.3: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:00:1f.3: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
pci 0000:02:00.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:02:00.0: calling quirk 0xc0604a6b: quirk_usb_early_handoff+0x0/0x3ac()
pci 0000:02:00.0: calling quirk 0xc0605996: pci_fixup_video+0x0/0x93()
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
PM: Adding info for pci_express:0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
PM: Adding info for pci_express:0000:00:1c.0:pcie02
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
PM: Adding info for pci_express:0000:00:1c.1:pcie00
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for No Bus:fbcon
PM: Adding info for platform:vesafb.0
ACPI: SSDT 3F79E0B0, 01C6 (r1    AMI   CPU1PM        1 INTL 20060113)
PM: Adding info for No Bus:cooling_device0
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: SSDT 3F79E280, 013A (r1    AMI   CPU2PM        1 INTL 20060113)
PM: Adding info for No Bus:cooling_device1
ACPI: ACPI0007:01 is registered as cooling_device1
ACPI: Processor [CPU2] (supports 8 throttling states)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
hpet_resources: 0xfed00000 is busy
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:ttyS2
PM: Adding info for No Bus:ttyS3
PM: Removing info for No Bus:ttyS0
00:0d: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:isa
PM: Adding info for No Bus:ram0
PM: Adding info for No Bus:ram1
PM: Adding info for No Bus:ram2
PM: Adding info for No Bus:ram3
PM: Adding info for No Bus:ram4
PM: Adding info for No Bus:ram5
PM: Adding info for No Bus:ram6
PM: Adding info for No Bus:ram7
PM: Adding info for No Bus:ram8
PM: Adding info for No Bus:ram9
PM: Adding info for No Bus:ram10
PM: Adding info for No Bus:ram11
PM: Adding info for No Bus:ram12
PM: Adding info for No Bus:ram13
PM: Adding info for No Bus:ram14
PM: Adding info for No Bus:ram15
brd: module loaded
PM: Adding info for No Bus:usbmon0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for No Bus:mice
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
PM: Adding info for No Bus:input0
input: AT Translated Set 2 keyboard as /class/input/input0
PM: Adding info for No Bus:event0
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
PM: Adding info for No Bus:cpu_dma_latency
PM: Adding info for No Bus:network_latency
PM: Adding info for No Bus:network_throughput
registered taskstats version 1
  Magic number: 8:965:155
debug: unmapping init memory c0733000..c0770000
Write protecting the kernel read-only data: 912k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PM: Adding info for No Bus:usb_host1
PM: Adding info for No Bus:usbmon1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xdfeffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PM: Adding info for No Bus:usb_host2
PM: Adding info for No Bus:usbmon2
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00009000
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: unable to enumerate USB device on port 4
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PM: Adding info for No Bus:usb_host3
PM: Adding info for No Bus:usbmon3
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x00009400
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PM: Adding info for No Bus:usb_host4
PM: Adding info for No Bus:usbmon4
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009800
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
usb 3-2: new low speed USB device using uhci_hcd and address 2
PM: Adding info for No Bus:usb_host5
PM: Adding info for No Bus:usbmon5
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000a000
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev5.1_ep81
PM: Adding info for usb:3-2
PM: Adding info for No Bus:usbdev3.2_ep00
usb 3-2: configuration #1 chosen from 1 choice
SCSI subsystem initialized
PM: Adding info for usb:3-2:1.0
Driver 'sd' needs updating - please use bus_type methods
libata version 3.00 loaded.
ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.1 to 64
PM: Adding info for No Bus:input1
input: HID 1241:1177 as /class/input/input1
scsi0 : ata_piix
PM: Adding info for No Bus:host0
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
PM: Adding info for No Bus:mouse0
PM: Adding info for No Bus:event1
input: USB HID v1.00 Mouse [HID 1241:1177] on usb-0000:00:1d.1-2
PM: Adding info for No Bus:usbdev3.2_ep81
ata1.00: ATAPI: _NEC DVD_RW ND-3520A, 1.04, max UDMA/33
ata1.00: configured for UDMA/33
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: CD-ROM            _NEC     DVD_RW ND-3520A  1.04 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
PM: Adding info for No Bus:host2
scsi3 : ata_piix
PM: Adding info for No Bus:host3
ata3: SATA max UDMA/133 cmd 0xb800 ctl 0xb400 bmdma 0xa400 irq 23
ata4: SATA max UDMA/133 cmd 0xb000 ctl 0xa800 bmdma 0xa408 irq 23
ata3.00: ATA-7: SAMSUNG HD160JJ, ZM100-41, max UDMA7
ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4.00: ATA-7: WDC WD2500KS-00MJB0, 02.01C03, max UDMA/133
ata4.00: 488397168 sectors, multi 16: LBA48 
ata4.00: configured for UDMA/133
PM: Adding info for No Bus:target2:0:0
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD160JJ  ZM10 PQ: 0 ANSI: 5
PM: Adding info for scsi:2:0:0:0
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
PM: Adding info for No Bus:sda
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 >
PM: Adding info for No Bus:sda1
PM: Adding info for No Bus:sda2
PM: Adding info for No Bus:sda3
PM: Adding info for No Bus:sda4
PM: Adding info for No Bus:sda5
sd 2:0:0:0: [sda] Attached SCSI disk
PM: Adding info for No Bus:target3:0:0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
PM: Adding info for scsi:3:0:0:0
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
PM: Adding info for No Bus:sdb
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2
PM: Adding info for No Bus:sdb1
PM: Adding info for No Bus:sdb2
sd 3:0:0:0: [sdb] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
type=1404 audit(1209694272.620:2): selinux=0 auid=4294967295 ses=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
PM: Adding info for No Bus:sr0
sr 0:0:0:0: Attached scsi CD-ROM sr0
sr 0:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 3:0:0:0: Attached scsi generic sg2 type 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
PM: Adding info for No Bus:fd0
PM: Adding info for No Bus:input2
input: PC Speaker as /class/input/input2
PM: Adding info for No Bus:event2
intel_rng: FWH not detected
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
PM: Adding info for platform:iTCO_wdt
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0860)
PM: Adding info for No Bus:watchdog
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
atl1 0000:02:00.0: version 2.0.7
PM: Adding info for No Bus:eth0
udev: renamed network interface eth0 to eth1
PM: Adding info for No Bus:timer
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
PM: Adding info for No Bus:input3
input: Power Button (FF) as /class/input/input3
PM: Adding info for No Bus:event3
ACPI: Power Button (FF) [PWRF]
PM: Adding info for No Bus:input4
input: Power Button (CM) as /class/input/input4
PM: Adding info for platform:parport_pc.956
PM: Removing info for platform:parport_pc.956
PM: Adding info for platform:parport_pc.888
PM: Removing info for platform:parport_pc.888
PM: Adding info for platform:parport_pc.632
PM: Removing info for platform:parport_pc.632
PM: Adding info for No Bus:event4
ACPI: Power Button (CM) [PWRB]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
PM: Adding info for No Bus:i2c-0
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
PM: Adding info for No Bus:pcmC0D1p
PM: Adding info for No Bus:adsp
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:hwC0D0
PM: Adding info for No Bus:controlC0
PM: Adding info for No Bus:mixer
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1 across:2048276k
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:microcode
PM: Adding info for platform:microcode
PM: Adding info for No Bus:microcode
PM: Removing info for No Bus:microcode
PM: Adding info for No Bus:microcode
PM: Removing info for No Bus:microcode
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
PM: Removing info for No Bus:microcode
PM: Removing info for platform:microcode
warning: process `kudzu' used the deprecated sysctl system call with 1.23.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
atl1 0000:02:00.0: eth0 link is up 100 Mbps full duplex
atl1 0000:02:00.0: eth0 link is up 1000 Mbps full duplex
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
fuse init (API version 7.9)
PM: Adding info for No Bus:fuse
warning: `dbus-daemon' uses 32-bit capabilities (legacy support in use)
eth0: no IPv6 routers present
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized drm 1.1.0 20060810
PCI: Setting latency timer of device 0000:00:02.0 to 64
PM: Adding info for No Bus:card0
[drm] Initialized i915 1.6.0 20060119 on minor 0
IPv6 over IPv4 tunneling driver
PM: Adding info for No Bus:sit0
sit0: Disabled Privacy Extensions
PM: Removing info for No Bus:eth0
ACPI: PCI interrupt for device 0000:02:00.0 disabled
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Enabling bus mastering for device 0000:02:00.0
PCI: Setting latency timer of device 0000:02:00.0 to 64
atl1 0000:02:00.0: version 2.1.1-TEST-20080501-1
atl1 0000:02:00.0: atl1_reset_hw
atl1 0000:02:00.0: atl1_setup_link
atl1 0000:02:00.0: atl1_phy_reset
PM: Adding info for No Bus:eth0
atl1 0000:02:00.0: atl1_via_workaround
udev: renamed network interface eth0 to eth1
atl1 0000:02:00.0: atl1_open
atl1 0000:02:00.0: atl1_setup_ring_resources
atl1 0000:02:00.0: atl1_up
atl1 0000:02:00.0: atl1_init_ring_ptrs
atl1 0000:02:00.0: atl1_configure
atl1 0000:02:00.0: atlx_irq_enable
atl1 0000:02:00.0: atl1_check_link
atl1 0000:02:00.0: atlx_clear_phy_int
atl1 0000:02:00.0: atl1_setup_mac_ctrl
atl1 0000:02:00.0: eth0 link is up 1000 Mbps full duplex
atl1 0000:02:00.0: atl1_check_link
eth0: no IPv6 routers present
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.06 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
Suspending console(s)
drm card0: class suspend
drm_sysfs_suspend
iTCO_wdt iTCO_wdt: suspend
platform floppy.0: suspend
sd 3:0:0:0: suspend
sd 3:0:0:0: [sdb] Synchronizing SCSI cache
sd 3:0:0:0: [sdb] Stopping disk
sd 2:0:0:0: suspend
sd 2:0:0:0: [sda] Synchronizing SCSI cache
sd 2:0:0:0: [sda] Stopping disk
sr 0:0:0:0: suspend
usbhid 3-2:1.0: suspend
usb 3-2: suspend, may wakeup
hub 5-0:1.0: PM: suspend 2-->2
hub 5-0:1.0: suspend
usb usb5: PM: suspend 2-->2
usb usb5: suspend, may wakeup
hub 4-0:1.0: PM: suspend 2-->2
hub 4-0:1.0: suspend
usb usb4: PM: suspend 2-->2
usb usb4: suspend, may wakeup
hub 3-0:1.0: suspend
usb usb3: suspend, may wakeup
hub 2-0:1.0: PM: suspend 2-->2
hub 2-0:1.0: suspend
usb usb2: PM: suspend 2-->2
usb usb2: suspend, may wakeup
hub 1-0:1.0: PM: suspend 2-->2
hub 1-0:1.0: suspend
usb usb1: PM: suspend 2-->2
usb usb1: suspend, may wakeup
atkbd serio0: suspend
i8042 i8042: suspend
serial8250 serial8250: suspend
platform vesafb.0: suspend
pci_express 0000:00:1c.1:pcie00: suspend
pci_express 0000:00:1c.0:pcie02: suspend
pci_express 0000:00:1c.0:pcie00: suspend
pcspkr pcspkr: suspend
system 00:11: suspend
system 00:10: suspend
ACPI handle has no context!
system 00:0f: suspend
pnp 00:0e: suspend
serial 00:0d: suspend
serial 00:0d: disabled
system 00:0c: suspend
i8042 kbd 00:0b: suspend
pnp 00:0a: suspend
system 00:09: suspend
system 00:08: suspend
parport_pc 00:07: suspend
parport_pc 00:07: disabled
pnp 00:06: suspend
pnp 00:05: suspend
pnp 00:04: suspend
pnp 00:03: suspend
pnp 00:02: suspend
system 00:01: suspend
pnp 00:00: suspend
atl1 0000:02:00.0: suspend
atl1 0000:02:00.0: atl1_suspend
atl1 0000:02:00.0: atl1_down
atl1 0000:02:00.0: atl1_reset_hw
atl1 0000:02:00.0: atlx_irq_disable
atl1 0000:02:00.0: atl1_clean_tx_ring
atl1 0000:02:00.0: atl1_clean_rx_ring
atl1 0000:02:00.0: WOL=0xc
atl1 0000:02:00.0: MAC=0x4201c22
ACPI handle has no context!
ACPI: PCI interrupt for device 0000:02:00.0 disabled
ACPI handle has no context!
i801_smbus 0000:00:1f.3: suspend
ata_piix 0000:00:1f.2: suspend
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ata_piix 0000:00:1f.1: suspend
ACPI: PCI interrupt for device 0000:00:1f.1 disabled
pci 0000:00:1f.0: suspend
pci 0000:00:1e.0: suspend
ehci_hcd 0000:00:1d.7: suspend, may wakeup
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
uhci_hcd 0000:00:1d.3: suspend
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
uhci_hcd 0000:00:1d.2: suspend
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
uhci_hcd 0000:00:1d.1: suspend
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
uhci_hcd 0000:00:1d.0: suspend
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
pcieport-driver 0000:00:1c.1: suspend
pcieport-driver 0000:00:1c.0: suspend
HDA Intel 0000:00:1b.0: suspend
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
ACPI handle has no context!
pci 0000:00:02.0: suspend
agpgart-intel 0000:00:00.0: suspend
acpi LNXTHERM:00: suspend
pci_link PNP0C0F:07: suspend
pci_link PNP0C0F:06: suspend
pci_link PNP0C0F:05: suspend
pci_link PNP0C0F:04: suspend
pci_link PNP0C0F:03: suspend
pci_link PNP0C0F:02: suspend
pci_link PNP0C0F:01: suspend
pci_link PNP0C0F:00: suspend
button PNP0C0C:00: suspend
acpi PNP0C01:01: suspend
acpi device:17: suspend
acpi device:16: suspend
acpi device:15: suspend
acpi device:14: suspend
acpi device:13: suspend
acpi device:12: suspend
acpi device:11: suspend
acpi device:10: suspend
acpi device:0f: suspend
acpi device:0e: suspend
acpi device:0d: suspend
acpi device:0c: suspend
acpi device:0b: suspend
acpi device:0a: suspend
acpi PNP0C02:04: suspend
acpi PNP0C02:03: suspend
acpi INT0800:00: suspend
acpi PNP0501:00: suspend
acpi PNP0C02:02: suspend
acpi PNP0303:00: suspend
acpi ATK0110:00: suspend
acpi PNP0103:00: suspend
acpi PNP0C02:01: suspend
acpi PNP0C02:00: suspend
acpi PNP0401:00: suspend
acpi PNP0700:00: suspend
acpi PNP0C04:00: suspend
acpi PNP0800:00: suspend
acpi PNP0B00:00: suspend
acpi PNP0100:00: suspend
acpi PNP0200:00: suspend
acpi PNP0000:00: suspend
acpi device:09: suspend
acpi device:08: suspend
acpi device:07: suspend
acpi device:06: suspend
acpi device:05: suspend
acpi device:04: suspend
acpi device:03: suspend
acpi device:02: suspend
acpi device:01: suspend
acpi PNP0C01:00: suspend
pci_root PNP0A08:00: suspend
acpi device:00: suspend
processor ACPI0007:03: suspend
processor ACPI0007:02: suspend
processor ACPI0007:01: suspend
processor ACPI0007:00: suspend
button LNXPWRBN:00: suspend
acpi LNXSYSTM:00: suspend
ACPI: Preparing to enter system sleep state S3
Disabling non-boot CPUs ...
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
Breaking affinity for irq 1
Breaking affinity for irq 14
Breaking affinity for irq 17
Breaking affinity for irq 19
Breaking affinity for irq 23
Breaking affinity for irq 221
CPU 1 is now offline
lockdep: fixing up alternatives.
SMP alternatives: switching to UP code
CPU0 attaching sched-domain:
 domain 0: span 00000001
  groups: 00000001
CPU1 is down
iTCO_wdt iTCO_wdt: LATE suspend
platform floppy.0: LATE suspend
i8042 i8042: LATE suspend
serial8250 serial8250: LATE suspend
platform vesafb.0: LATE suspend
pcspkr pcspkr: LATE suspend
atl1 0000:02:00.0: LATE suspend
i801_smbus 0000:00:1f.3: LATE suspend
ata_piix 0000:00:1f.2: LATE suspend
ata_piix 0000:00:1f.1: LATE suspend
pci 0000:00:1f.0: LATE suspend
pci 0000:00:1e.0: LATE suspend
ehci_hcd 0000:00:1d.7: LATE suspend, may wakeup
uhci_hcd 0000:00:1d.3: LATE suspend
uhci_hcd 0000:00:1d.2: LATE suspend
uhci_hcd 0000:00:1d.1: LATE suspend
uhci_hcd 0000:00:1d.0: LATE suspend
pcieport-driver 0000:00:1c.1: LATE suspend
pcieport-driver 0000:00:1c.0: LATE suspend
HDA Intel 0000:00:1b.0: LATE suspend
pci 0000:00:02.0: LATE suspend
agpgart-intel 0000:00:00.0: LATE suspend
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
agpgart-intel 0000:00:00.0: EARLY resume
agpgart-intel 0000:00:00.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:02.0: EARLY resume
pci 0000:00:02.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
HDA Intel 0000:00:1b.0: EARLY resume
HDA Intel 0000:00:1b.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pcieport-driver 0000:00:1c.0: EARLY resume
pcieport-driver 0000:00:1c.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pcieport-driver 0000:00:1c.1: EARLY resume
pcieport-driver 0000:00:1c.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
uhci_hcd 0000:00:1d.0: EARLY resume
uhci_hcd 0000:00:1d.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
uhci_hcd 0000:00:1d.1: EARLY resume
uhci_hcd 0000:00:1d.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
uhci_hcd 0000:00:1d.2: EARLY resume
uhci_hcd 0000:00:1d.2: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
uhci_hcd 0000:00:1d.3: EARLY resume
uhci_hcd 0000:00:1d.3: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
ehci_hcd 0000:00:1d.7: EARLY resume
ehci_hcd 0000:00:1d.7: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1e.0: EARLY resume
pci 0000:00:1e.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pci 0000:00:1f.0: EARLY resume
pci 0000:00:1f.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
ata_piix 0000:00:1f.1: EARLY resume
ata_piix 0000:00:1f.1: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
ata_piix 0000:00:1f.2: EARLY resume
ata_piix 0000:00:1f.2: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
i801_smbus 0000:00:1f.3: EARLY resume
i801_smbus 0000:00:1f.3: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
atl1 0000:02:00.0: EARLY resume
atl1 0000:02:00.0: calling quirk 0xc04f29a4: quirk_cardbus_legacy+0x0/0x21()
pcspkr pcspkr: EARLY resume
platform vesafb.0: EARLY resume
serial8250 serial8250: EARLY resume
i8042 i8042: EARLY resume
platform floppy.0: EARLY resume
iTCO_wdt iTCO_wdt: EARLY resume
Enabling non-boot CPUs ...
CPU0 attaching NULL sched-domain.
lockdep: fixing up alternatives.
SMP alternatives: switching to SMP code
Booting processor 1/1 ip 4000
CPU 1 irqstacks, hard=c0794000 soft=c0774000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4266.55 BogoMIPS (lpj=2133275)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
CPU0 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000001 00000002
CPU1 attaching sched-domain:
 domain 0: span 00000003
  groups: 00000002 00000001
CPU1 is up
Switched to high resolution mode on CPU 1
acpi LNXSYSTM:00: resuming
button LNXPWRBN:00: resuming
processor ACPI0007:00: resuming
processor ACPI0007:01: resuming
processor ACPI0007:02: resuming
processor ACPI0007:03: resuming
acpi device:00: resuming
pci_root PNP0A08:00: resuming
acpi PNP0C01:00: resuming
acpi device:01: resuming
acpi device:02: resuming
acpi device:03: resuming
acpi device:04: resuming
acpi device:05: resuming
acpi device:06: resuming
acpi device:07: resuming
acpi device:08: resuming
acpi device:09: resuming
acpi PNP0000:00: resuming
acpi PNP0200:00: resuming
acpi PNP0100:00: resuming
acpi PNP0B00:00: resuming
acpi PNP0800:00: resuming
acpi PNP0C04:00: resuming
acpi PNP0700:00: resuming
acpi PNP0401:00: resuming
acpi PNP0C02:00: resuming
acpi PNP0C02:01: resuming
acpi PNP0103:00: resuming
acpi ATK0110:00: resuming
acpi PNP0303:00: resuming
acpi PNP0C02:02: resuming
acpi PNP0501:00: resuming
acpi INT0800:00: resuming
acpi PNP0C02:03: resuming
acpi PNP0C02:04: resuming
acpi device:0a: resuming
acpi device:0b: resuming
acpi device:0c: resuming
acpi device:0d: resuming
acpi device:0e: resuming
acpi device:0f: resuming
acpi device:10: resuming
acpi device:11: resuming
acpi device:12: resuming
acpi device:13: resuming
acpi device:14: resuming
acpi device:15: resuming
acpi device:16: resuming
acpi device:17: resuming
acpi PNP0C01:01: resuming
button PNP0C0C:00: resuming
pci_link PNP0C0F:00: resuming
pci_link PNP0C0F:01: resuming
pci_link PNP0C0F:02: resuming
pci_link PNP0C0F:03: resuming
pci_link PNP0C0F:04: resuming
pci_link PNP0C0F:05: resuming
pci_link PNP0C0F:06: resuming
pci_link PNP0C0F:07: resuming
acpi LNXTHERM:00: resuming
agpgart-intel 0000:00:00.0: resuming
pci 0000:00:02.0: resuming
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
HDA Intel 0000:00:1b.0: resuming
PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100006, writing 100002)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Enabling bus mastering for device 0000:00:1b.0
PCI: Setting latency timer of device 0000:00:1b.0 to 64
pcieport-driver 0000:00:1c.0: resuming
PM: Writing back config space on device 0000:00:1c.0 at offset f (was 60100, writing 6010b)
PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pcieport-driver 0000:00:1c.1: resuming
PM: Writing back config space on device 0000:00:1c.1 at offset f (was 60200, writing 6020a)
PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100107, writing 100507)
PCI: Setting latency timer of device 0000:00:1c.1 to 64
uhci_hcd 0000:00:1d.0: resuming
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb4: root hub lost power or was reset
uhci_hcd 0000:00:1d.3: resuming
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb5: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
pci 0000:00:1e.0: resuming
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
ata_piix 0000:00:1f.1: resuming
PM: Writing back config space on device 0000:00:1f.1 at offset 1 (was 2800005, writing 2880005)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata_piix 0000:00:1f.2: resuming
ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node f7847200), AE_AML_OPERAND_VALUE
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node f7846dc0), AE_AML_OPERAND_VALUE
ata2.00: _GTF evaluation failed (AE 0x3006)
ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node f7847200), AE_AML_OPERAND_VALUE
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node f7846e80), AE_AML_OPERAND_VALUE
ata2.01: _GTF evaluation failed (AE 0x3006)
ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node f7847200), AE_AML_OPERAND_VALUE
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV1._GTF] (Node f7846c00), AE_AML_OPERAND_VALUE
ata1.01: _GTF evaluation failed (AE 0x3006)
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1f.2 to 64
i801_smbus 0000:00:1f.3: resuming
atl1 0000:02:00.0: resuming
atl1 0000:02:00.0: atl1_resume
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
atl1 0000:02:00.0: atl1_reset
atl1 0000:02:00.0: atl1_reset_hw
atl1 0000:02:00.0: atl1_up
atl1 0000:02:00.0: atl1_init_ring_ptrs
atl1 0000:02:00.0: atl1_configure
atl1 0000:02:00.0: atlx_irq_enable
atl1 0000:02:00.0: atl1_check_link
atl1 0000:02:00.0: atl1_setup_mac_ctrl
atl1 0000:02:00.0: eth0 link is up 1000 Mbps full duplex
atl1 0000:02:00.0: atl1_via_workaround
pnp 00:00: resuming
system 00:01: resuming
pnp 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
parport_pc 00:07: resuming
parport_pc 00:07: activated
system 00:08: resuming
system 00:09: resuming
pnp 00:0a: resuming
i8042 kbd 00:0b: resuming
system 00:0c: resuming
serial 00:0d: resuming
serial 00:0d: activated
pnp 00:0e: resuming
system 00:0f: resuming
system 00:10: resuming
system 00:11: resuming
pcspkr pcspkr: resuming
pci_express 0000:00:1c.0:pcie00: resuming
pci_express 0000:00:1c.0:pcie02: resuming
pci_express 0000:00:1c.1:pcie00: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
i8042 i8042: resuming
atkbd serio0: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
usb usb4: resuming
hub 4-0:1.0: resuming
usb usb5: resuming
hub 5-0:1.0: resuming
usb 3-2: resuming
usbhid 3-2:1.0: resuming
sr 0:0:0:0: resuming
sd 2:0:0:0: resuming
sd 2:0:0:0: [sda] Starting disk
ata1.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
ata1.00: configured for UDMA/33
ata3.00: configured for UDMA/133
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: resuming
sd 3:0:0:0: [sdb] Starting disk
ata4.00: configured for UDMA/133
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
platform floppy.0: resuming
iTCO_wdt iTCO_wdt: resuming
drm card0: class resume
PM: Finishing wakeup.
Restarting tasks ... <6>usb 3-2: USB disconnect, address 2
PM: Removing info for No Bus:usbdev3.2_ep81
PM: Removing info for usb:3-2:1.0
done.
PM: Removing info for No Bus:mouse0
PM: Removing info for No Bus:event1
PM: Removing info for No Bus:input1
PM: Removing info for usb:3-2
PM: Removing info for No Bus:usbdev3.2_ep00
hub 1-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 2
hub 1-0:1.0: over-current change on port 3
hub 1-0:1.0: over-current change on port 4
hub 1-0:1.0: unable to enumerate USB device on port 4
hub 1-0:1.0: over-current change on port 5
hub 1-0:1.0: over-current change on port 6
hub 1-0:1.0: over-current change on port 7
hub 1-0:1.0: over-current change on port 8
usb 3-2: new low speed USB device using uhci_hcd and address 3
PM: Adding info for usb:3-2
PM: Adding info for No Bus:usbdev3.3_ep00
usb 3-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-2:1.0
PM: Adding info for No Bus:input5
input: HID 1241:1177 as /class/input/input5
PM: Adding info for No Bus:mouse0
PM: Adding info for No Bus:event1
input: USB HID v1.00 Mouse [HID 1241:1177] on usb-0000:00:1d.1-2
PM: Adding info for No Bus:usbdev3.3_ep81

--MP_/QtgDrJVXBjpg3KV77xqhbP_
Content-Type: application/octet-stream; name=.config
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=.config

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yNQojIFN1biBBcHIgMjcgMTk6MzE6MDIgMjAwOAojCiMg
Q09ORklHXzY0QklUIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl8zMj15CiMgQ09ORklHX1g4Nl82NCBp
cyBub3Qgc2V0CkNPTkZJR19YODY9eQojIENPTkZJR19HRU5FUklDX0xPQ0tCUkVBSyBpcyBub3Qg
c2V0CkNPTkZJR19HRU5FUklDX1RJTUU9eQpDT05GSUdfR0VORVJJQ19DTU9TX1VQREFURT15CkNP
TkZJR19DTE9DS1NPVVJDRV9XQVRDSERPRz15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkK
Q09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09ORklHX0xPQ0tERVBfU1VQ
UE9SVD15CkNPTkZJR19TVEFDS1RSQUNFX1NVUFBPUlQ9eQpDT05GSUdfSEFWRV9MQVRFTkNZVE9Q
X1NVUFBPUlQ9eQpDT05GSUdfU0VNQVBIT1JFX1NMRUVQRVJTPXkKQ09ORklHX0ZBU1RfQ01QWENI
R19MT0NBTD15CkNPTkZJR19NTVU9eQpDT05GSUdfWk9ORV9ETUE9eQpDT05GSUdfR0VORVJJQ19J
U0FfRE1BPXkKQ09ORklHX0dFTkVSSUNfSU9NQVA9eQpDT05GSUdfR0VORVJJQ19CVUc9eQpDT05G
SUdfR0VORVJJQ19IV0VJR0hUPXkKIyBDT05GSUdfR0VORVJJQ19HUElPIGlzIG5vdCBzZXQKQ09O
RklHX0FSQ0hfTUFZX0hBVkVfUENfRkRDPXkKQ09ORklHX0RNST15CiMgQ09ORklHX1JXU0VNX0dF
TkVSSUNfU1BJTkxPQ0sgaXMgbm90IHNldApDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09
eQojIENPTkZJR19BUkNIX0hBU19JTE9HMl9VMzIgaXMgbm90IHNldAojIENPTkZJR19BUkNIX0hB
U19JTE9HMl9VNjQgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfQ1BVX0lETEVfV0FJVD15CkNP
TkZJR19HRU5FUklDX0NBTElCUkFURV9ERUxBWT15CiMgQ09ORklHX0dFTkVSSUNfVElNRV9WU1lT
Q0FMTCBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19DUFVfUkVMQVg9eQojIENPTkZJR19IQVZF
X1NFVFVQX1BFUl9DUFVfQVJFQSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hJQkVSTkFUSU9OX1BP
U1NJQkxFPXkKQ09ORklHX0FSQ0hfU1VTUEVORF9QT1NTSUJMRT15CiMgQ09ORklHX1pPTkVfRE1B
MzIgaXMgbm90IHNldApDT05GSUdfQVJDSF9QT1BVTEFURVNfTk9ERV9NQVA9eQojIENPTkZJR19B
VURJVF9BUkNIIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfU1VQUE9SVFNfQU9VVD15CkNPTkZJR19H
RU5FUklDX0hBUkRJUlFTPXkKQ09ORklHX0dFTkVSSUNfSVJRX1BST0JFPXkKQ09ORklHX0dFTkVS
SUNfUEVORElOR19JUlE9eQpDT05GSUdfWDg2X1NNUD15CkNPTkZJR19YODZfMzJfU01QPXkKQ09O
RklHX1g4Nl9IVD15CkNPTkZJR19YODZfQklPU19SRUJPT1Q9eQpDT05GSUdfWDg2X1RSQU1QT0xJ
TkU9eQpDT05GSUdfS1RJTUVfU0NBTEFSPXkKQ09ORklHX0RFRkNPTkZJR19MSVNUPSIvbGliL21v
ZHVsZXMvJFVOQU1FX1JFTEVBU0UvLmNvbmZpZyIKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklH
X0VYUEVSSU1FTlRBTD15CkNPTkZJR19MT0NLX0tFUk5FTD15CkNPTkZJR19JTklUX0VOVl9BUkdf
TElNSVQ9MzIKQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgojIENPTkZJR19MT0NBTFZFUlNJT05fQVVU
TyBpcyBub3Qgc2V0CkNPTkZJR19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9eQpDT05GSUdfU1lTVklQ
Q19TWVNDVEw9eQpDT05GSUdfUE9TSVhfTVFVRVVFPXkKQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1Q9
eQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUX1YzIGlzIG5vdCBzZXQKQ09ORklHX1RBU0tTVEFU
Uz15CkNPTkZJR19UQVNLX0RFTEFZX0FDQ1Q9eQpDT05GSUdfVEFTS19YQUNDVD15CkNPTkZJR19U
QVNLX0lPX0FDQ09VTlRJTkc9eQpDT05GSUdfQVVESVQ9eQpDT05GSUdfQVVESVRTWVNDQUxMPXkK
Q09ORklHX0FVRElUX1RSRUU9eQpDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJP
Qz15CkNPTkZJR19MT0dfQlVGX1NISUZUPTE3CiMgQ09ORklHX0NHUk9VUFMgaXMgbm90IHNldApD
T05GSUdfR1JPVVBfU0NIRUQ9eQpDT05GSUdfRkFJUl9HUk9VUF9TQ0hFRD15CiMgQ09ORklHX1JU
X0dST1VQX1NDSEVEIGlzIG5vdCBzZXQKQ09ORklHX1VTRVJfU0NIRUQ9eQojIENPTkZJR19DR1JP
VVBfU0NIRUQgaXMgbm90IHNldApDT05GSUdfU1lTRlNfREVQUkVDQVRFRD15CkNPTkZJR19TWVNG
U19ERVBSRUNBVEVEX1YyPXkKQ09ORklHX1JFTEFZPXkKQ09ORklHX05BTUVTUEFDRVM9eQojIENP
TkZJR19VVFNfTlMgaXMgbm90IHNldAojIENPTkZJR19JUENfTlMgaXMgbm90IHNldApDT05GSUdf
VVNFUl9OUz15CiMgQ09ORklHX1BJRF9OUyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lOSVRS
RD15CkNPTkZJR19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0la
RT15CkNPTkZJR19TWVNDVEw9eQojIENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19V
SUQxNj15CkNPTkZJR19TWVNDVExfU1lTQ0FMTD15CkNPTkZJR19LQUxMU1lNUz15CkNPTkZJR19L
QUxMU1lNU19BTEw9eQpDT05GSUdfS0FMTFNZTVNfRVhUUkFfUEFTUz15CkNPTkZJR19IT1RQTFVH
PXkKQ09ORklHX1BSSU5USz15CkNPTkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQpDT05GSUdf
Q09NUEFUX0JSSz15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05GSUdfQU5P
Tl9JTk9ERVM9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05GSUdfVElNRVJG
RD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX1ZNX0VWRU5UX0NPVU5U
RVJTPXkKQ09ORklHX1NMVUJfREVCVUc9eQojIENPTkZJR19TTEFCIGlzIG5vdCBzZXQKQ09ORklH
X1NMVUI9eQojIENPTkZJR19TTE9CIGlzIG5vdCBzZXQKQ09ORklHX1BST0ZJTElORz15CiMgQ09O
RklHX01BUktFUlMgaXMgbm90IHNldApDT05GSUdfT1BST0ZJTEU9bQpDT05GSUdfSEFWRV9PUFJP
RklMRT15CkNPTkZJR19LUFJPQkVTPXkKQ09ORklHX0tSRVRQUk9CRVM9eQpDT05GSUdfSEFWRV9L
UFJPQkVTPXkKQ09ORklHX0hBVkVfS1JFVFBST0JFUz15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRP
Uj15CkNPTkZJR19TTEFCSU5GTz15CkNPTkZJR19SVF9NVVRFWEVTPXkKIyBDT05GSUdfVElOWV9T
SE1FTSBpcyBub3Qgc2V0CkNPTkZJR19CQVNFX1NNQUxMPTAKQ09ORklHX01PRFVMRVM9eQpDT05G
SUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEPXkKIyBDT05GSUdf
TU9EVkVSU0lPTlMgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfU1JDVkVSU0lPTl9BTEwgaXMg
bm90IHNldApDT05GSUdfS01PRD15CkNPTkZJR19TVE9QX01BQ0hJTkU9eQpDT05GSUdfQkxPQ0s9
eQpDT05GSUdfTEJEPXkKQ09ORklHX0JMS19ERVZfSU9fVFJBQ0U9eQpDT05GSUdfTFNGPXkKQ09O
RklHX0JMS19ERVZfQlNHPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURfTk9P
UD15CkNPTkZJR19JT1NDSEVEX0FTPXkKQ09ORklHX0lPU0NIRURfREVBRExJTkU9eQpDT05GSUdf
SU9TQ0hFRF9DRlE9eQojIENPTkZJR19ERUZBVUxUX0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVG
QVVMVF9ERUFETElORSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0NGUT15CiMgQ09ORklHX0RF
RkFVTFRfTk9PUCBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lPU0NIRUQ9ImNmcSIKQ09ORklH
X0NMQVNTSUNfUkNVPXkKCiMKIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMKIwpDT05GSUdf
VElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haPXkKQ09ORklHX0hJR0hfUkVTX1RJTUVSUz15CkNP
TkZJR19HRU5FUklDX0NMT0NLRVZFTlRTX0JVSUxEPXkKQ09ORklHX1NNUD15CiMgQ09ORklHX1g4
Nl9QQyBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9FTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2
X1ZPWUFHRVIgaXMgbm90IHNldAojIENPTkZJR19YODZfTlVNQVEgaXMgbm90IHNldAojIENPTkZJ
R19YODZfU1VNTUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0JJR1NNUCBpcyBub3Qgc2V0CiMg
Q09ORklHX1g4Nl9WSVNXUyBpcyBub3Qgc2V0CkNPTkZJR19YODZfR0VORVJJQ0FSQ0g9eQojIENP
TkZJR19YODZfRVM3MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1JEQzMyMVggaXMgbm90IHNl
dAojIENPTkZJR19YODZfVlNNUCBpcyBub3Qgc2V0CkNPTkZJR19TQ0hFRF9OT19OT19PTUlUX0ZS
QU1FX1BPSU5URVI9eQojIENPTkZJR19QQVJBVklSVF9HVUVTVCBpcyBub3Qgc2V0CkNPTkZJR19Y
ODZfQ1lDTE9ORV9USU1FUj15CiMgQ09ORklHX00zODYgaXMgbm90IHNldAojIENPTkZJR19NNDg2
IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZUU0MgaXMg
bm90IHNldAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKQ09ORklHX002ODY9eQojIENPTkZJ
R19NUEVOVElVTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1JSUkgaXMgbm90IHNldAoj
IENPTkZJR19NUEVOVElVTU0gaXMgbm90IHNldAojIENPTkZJR19NUEVOVElVTTQgaXMgbm90IHNl
dAojIENPTkZJR19NSzYgaXMgbm90IHNldAojIENPTkZJR19NSzcgaXMgbm90IHNldAojIENPTkZJ
R19NSzggaXMgbm90IHNldAojIENPTkZJR19NQ1JVU09FIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVG
RklDRU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVBDNiBpcyBub3Qgc2V0CiMgQ09ORklH
X01XSU5DSElQMiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0QgaXMgbm90IHNldAojIENP
TkZJR19NR0VPREVHWDEgaXMgbm90IHNldAojIENPTkZJR19NR0VPREVfTFggaXMgbm90IHNldAoj
IENPTkZJR19NQ1lSSVhJSUkgaXMgbm90IHNldAojIENPTkZJR19NVklBQzNfMiBpcyBub3Qgc2V0
CiMgQ09ORklHX01WSUFDNyBpcyBub3Qgc2V0CiMgQ09ORklHX01QU0MgaXMgbm90IHNldAojIENP
TkZJR19NQ09SRTIgaXMgbm90IHNldAojIENPTkZJR19HRU5FUklDX0NQVSBpcyBub3Qgc2V0CkNP
TkZJR19YODZfR0VORVJJQz15CkNPTkZJR19YODZfQ01QWENIRz15CkNPTkZJR19YODZfTDFfQ0FD
SEVfU0hJRlQ9NwpDT05GSUdfWDg2X1hBREQ9eQpDT05GSUdfWDg2X1BQUk9fRkVOQ0U9eQpDT05G
SUdfWDg2X1dQX1dPUktTX09LPXkKQ09ORklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0JTV0FQ
PXkKQ09ORklHX1g4Nl9QT1BBRF9PSz15CkNPTkZJR19YODZfR09PRF9BUElDPXkKQ09ORklHX1g4
Nl9JTlRFTF9VU0VSQ09QWT15CkNPTkZJR19YODZfVVNFX1BQUk9fQ0hFQ0tTVU09eQpDT05GSUdf
WDg2X1RTQz15CkNPTkZJR19YODZfQ01PVj15CkNPTkZJR19YODZfTUlOSU1VTV9DUFVfRkFNSUxZ
PTQKQ09ORklHX1g4Nl9ERUJVR0NUTE1TUj15CkNPTkZJR19IUEVUX1RJTUVSPXkKQ09ORklHX0hQ
RVRfRU1VTEFURV9SVEM9eQojIENPTkZJR19JT01NVV9IRUxQRVIgaXMgbm90IHNldApDT05GSUdf
TlJfQ1BVUz0zMgpDT05GSUdfU0NIRURfU01UPXkKQ09ORklHX1NDSEVEX01DPXkKIyBDT05GSUdf
UFJFRU1QVF9OT05FIGlzIG5vdCBzZXQKQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXkKIyBDT05G
SUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZf
SU9fQVBJQz15CkNPTkZJR19YODZfTUNFPXkKIyBDT05GSUdfWDg2X01DRV9OT05GQVRBTCBpcyBu
b3Qgc2V0CkNPTkZJR19YODZfTUNFX1A0VEhFUk1BTD15CkNPTkZJR19WTTg2PXkKQ09ORklHX1RP
U0hJQkE9bQpDT05GSUdfSThLPW0KIyBDT05GSUdfWDg2X1JFQk9PVEZJWFVQUyBpcyBub3Qgc2V0
CkNPTkZJR19NSUNST0NPREU9bQpDT05GSUdfTUlDUk9DT0RFX09MRF9JTlRFUkZBQ0U9eQpDT05G
SUdfWDg2X01TUj1tCkNPTkZJR19YODZfQ1BVSUQ9bQojIENPTkZJR19OT0hJR0hNRU0gaXMgbm90
IHNldApDT05GSUdfSElHSE1FTTRHPXkKIyBDT05GSUdfSElHSE1FTTY0RyBpcyBub3Qgc2V0CkNP
TkZJR19QQUdFX09GRlNFVD0weEMwMDAwMDAwCkNPTkZJR19ISUdITUVNPXkKQ09ORklHX1NFTEVD
VF9NRU1PUllfTU9ERUw9eQpDT05GSUdfRkxBVE1FTV9NQU5VQUw9eQojIENPTkZJR19ESVNDT05U
SUdNRU1fTUFOVUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BBUlNFTUVNX01BTlVBTCBpcyBub3Qg
c2V0CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX0ZMQVRfTk9ERV9NRU1fTUFQPXkKIyBDT05GSUdf
U1BBUlNFTUVNX1NUQVRJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQX0VO
QUJMRSBpcyBub3Qgc2V0CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz00CkNPTkZJR19SRVNPVVJD
RVNfNjRCSVQ9eQpDT05GSUdfWk9ORV9ETUFfRkxBRz0xCkNPTkZJR19CT1VOQ0U9eQpDT05GSUdf
VklSVF9UT19CVVM9eQpDT05GSUdfSElHSFBURT15CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlz
IG5vdCBzZXQKQ09ORklHX01UUlI9eQpDT05GSUdfRUZJPXkKIyBDT05GSUdfSVJRQkFMQU5DRSBp
cyBub3Qgc2V0CkNPTkZJR19TRUNDT01QPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFpfMjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQKQ09ORklH
X0haXzEwMDA9eQpDT05GSUdfSFo9MTAwMApDT05GSUdfU0NIRURfSFJUSUNLPXkKQ09ORklHX0tF
WEVDPXkKQ09ORklHX0NSQVNIX0RVTVA9eQpDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgxMDAwMDAw
CkNPTkZJR19SRUxPQ0FUQUJMRT15CkNPTkZJR19QSFlTSUNBTF9BTElHTj0weDQwMDAwMApDT05G
SUdfSE9UUExVR19DUFU9eQojIENPTkZJR19DT01QQVRfVkRTTyBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX0VOQUJMRV9NRU1PUllfSE9UUExVRz15CgojCiMgUG93ZXIgbWFuYWdlbWVudCBvcHRpb25z
CiMKQ09ORklHX1BNPXkKQ09ORklHX1BNX0xFR0FDWT15CkNPTkZJR19QTV9ERUJVRz15CkNPTkZJ
R19QTV9WRVJCT1NFPXkKQ09ORklHX0NBTl9QTV9UUkFDRT15CkNPTkZJR19QTV9UUkFDRT15CkNP
TkZJR19QTV9UUkFDRV9SVEM9eQpDT05GSUdfUE1fU0xFRVBfU01QPXkKQ09ORklHX1BNX1NMRUVQ
PXkKQ09ORklHX1NVU1BFTkQ9eQpDT05GSUdfU1VTUEVORF9GUkVFWkVSPXkKQ09ORklHX0hJQkVS
TkFUSU9OPXkKQ09ORklHX1BNX1NURF9QQVJUSVRJT049IiIKQ09ORklHX0FDUEk9eQpDT05GSUdf
QUNQSV9TTEVFUD15CkNPTkZJR19BQ1BJX1BST0NGUz15CkNPTkZJR19BQ1BJX1BST0NGU19QT1dF
Uj15CkNPTkZJR19BQ1BJX1NZU0ZTX1BPV0VSPXkKQ09ORklHX0FDUElfUFJPQ19FVkVOVD15CkNP
TkZJR19BQ1BJX0FDPW0KQ09ORklHX0FDUElfQkFUVEVSWT1tCkNPTkZJR19BQ1BJX0JVVFRPTj1t
CkNPTkZJR19BQ1BJX1ZJREVPPW0KQ09ORklHX0FDUElfRkFOPXkKQ09ORklHX0FDUElfRE9DSz15
CkNPTkZJR19BQ1BJX0JBWT1tCkNPTkZJR19BQ1BJX1BST0NFU1NPUj15CkNPTkZJR19BQ1BJX0hP
VFBMVUdfQ1BVPXkKQ09ORklHX0FDUElfVEhFUk1BTD15CiMgQ09ORklHX0FDUElfV01JIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUNQSV9BU1VTIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfVE9TSElCQT1t
CiMgQ09ORklHX0FDUElfQ1VTVE9NX0RTRFQgaXMgbm90IHNldApDT05GSUdfQUNQSV9CTEFDS0xJ
U1RfWUVBUj0xOTk5CiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQSV9F
Qz15CkNPTkZJR19BQ1BJX1BPV0VSPXkKQ09ORklHX0FDUElfU1lTVEVNPXkKQ09ORklHX1g4Nl9Q
TV9USU1FUj15CkNPTkZJR19BQ1BJX0NPTlRBSU5FUj15CkNPTkZJR19BQ1BJX1NCUz1tCkNPTkZJ
R19YODZfQVBNX0JPT1Q9eQpDT05GSUdfQVBNPXkKIyBDT05GSUdfQVBNX0lHTk9SRV9VU0VSX1NV
U1BFTkQgaXMgbm90IHNldAojIENPTkZJR19BUE1fRE9fRU5BQkxFIGlzIG5vdCBzZXQKQ09ORklH
X0FQTV9DUFVfSURMRT15CiMgQ09ORklHX0FQTV9ESVNQTEFZX0JMQU5LIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVBNX0FMTE9XX0lOVFMgaXMgbm90IHNldAojIENPTkZJR19BUE1fUkVBTF9NT0RFX1BP
V0VSX09GRiBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKQ09ORklHX0NQ
VV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX1RBQkxFPXkKQ09ORklHX0NQVV9GUkVRX0RFQlVHPXkK
Q09ORklHX0NQVV9GUkVRX1NUQVQ9bQpDT05GSUdfQ1BVX0ZSRVFfU1RBVF9ERVRBSUxTPXkKIyBD
T05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfUEVSRk9STUFOQ0UgaXMgbm90IHNldApDT05GSUdf
Q1BVX0ZSRVFfREVGQVVMVF9HT1ZfVVNFUlNQQUNFPXkKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVM
VF9HT1ZfT05ERU1BTkQgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUV9ERUZBVUxUX0dPVl9D
T05TRVJWQVRJVkUgaXMgbm90IHNldApDT05GSUdfQ1BVX0ZSRVFfR09WX1BFUkZPUk1BTkNFPXkK
Q09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkU9bQpDT05GSUdfQ1BVX0ZSRVFfR09WX1VTRVJT
UEFDRT15CkNPTkZJR19DUFVfRlJFUV9HT1ZfT05ERU1BTkQ9bQpDT05GSUdfQ1BVX0ZSRVFfR09W
X0NPTlNFUlZBVElWRT1tCgojCiMgQ1BVRnJlcSBwcm9jZXNzb3IgZHJpdmVycwojCkNPTkZJR19Y
ODZfQUNQSV9DUFVGUkVRPW0KIyBDT05GSUdfWDg2X1BPV0VSTk9XX0s2IGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X1BPV0VSTk9XX0s3IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1BPV0VSTk9XX0s4
IGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X0dYX1NVU1BNT0QgaXMgbm90IHNldAojIENPTkZJR19Y
ODZfU1BFRURTVEVQX0NFTlRSSU5PIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9TUEVFRFNURVBfSUNI
PXkKQ09ORklHX1g4Nl9TUEVFRFNURVBfU01JPXkKQ09ORklHX1g4Nl9QNF9DTE9DS01PRD1tCiMg
Q09ORklHX1g4Nl9DUFVGUkVRX05GT1JDRTIgaXMgbm90IHNldAojIENPTkZJR19YODZfTE9OR1JV
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9MT05HSEFVTCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4
Nl9FX1BPV0VSU0FWRVIgaXMgbm90IHNldAoKIwojIHNoYXJlZCBvcHRpb25zCiMKIyBDT05GSUdf
WDg2X0FDUElfQ1BVRlJFUV9QUk9DX0lOVEYgaXMgbm90IHNldApDT05GSUdfWDg2X1NQRUVEU1RF
UF9MSUI9eQojIENPTkZJR19YODZfU1BFRURTVEVQX1JFTEFYRURfQ0FQX0NIRUNLIGlzIG5vdCBz
ZXQKQ09ORklHX0NQVV9JRExFPXkKQ09ORklHX0NQVV9JRExFX0dPVl9MQURERVI9eQpDT05GSUdf
Q1BVX0lETEVfR09WX01FTlU9eQoKIwojIEJ1cyBvcHRpb25zIChQQ0kgZXRjLikKIwpDT05GSUdf
UENJPXkKIyBDT05GSUdfUENJX0dPQklPUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9HT01NQ09O
RklHIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPRElSRUNUIGlzIG5vdCBzZXQKQ09ORklHX1BD
SV9HT0FOWT15CkNPTkZJR19QQ0lfQklPUz15CkNPTkZJR19QQ0lfRElSRUNUPXkKQ09ORklHX1BD
SV9NTUNPTkZJRz15CkNPTkZJR19QQ0lfRE9NQUlOUz15CkNPTkZJR19QQ0lFUE9SVEJVUz15CkNP
TkZJR19IT1RQTFVHX1BDSV9QQ0lFPW0KQ09ORklHX1BDSUVBRVI9eQpDT05GSUdfQVJDSF9TVVBQ
T1JUU19NU0k9eQpDT05GSUdfUENJX01TST15CkNPTkZJR19QQ0lfTEVHQUNZPXkKQ09ORklHX1BD
SV9ERUJVRz15CkNPTkZJR19IVF9JUlE9eQpDT05GSUdfSVNBX0RNQV9BUEk9eQpDT05GSUdfSVNB
PXkKIyBDT05GSUdfRUlTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDeDIwMCBpcyBub3Qgc2V0CkNPTkZJR19LOF9OQj15CiMgQ09ORklHX1BDQ0FSRCBpcyBu
b3Qgc2V0CkNPTkZJR19IT1RQTFVHX1BDST15CkNPTkZJR19IT1RQTFVHX1BDSV9GQUtFPW0KQ09O
RklHX0hPVFBMVUdfUENJX0NPTVBBUT1tCiMgQ09ORklHX0hPVFBMVUdfUENJX0NPTVBBUV9OVlJB
TSBpcyBub3Qgc2V0CkNPTkZJR19IT1RQTFVHX1BDSV9JQk09bQpDT05GSUdfSE9UUExVR19QQ0lf
QUNQST1tCkNPTkZJR19IT1RQTFVHX1BDSV9BQ1BJX0lCTT1tCiMgQ09ORklHX0hPVFBMVUdfUENJ
X0NQQ0kgaXMgbm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSV9TSFBDIGlzIG5vdCBzZXQKCiMK
IyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cyAvIEVtdWxhdGlvbnMKIwpDT05GSUdfQklORk1UX0VM
Rj15CiMgQ09ORklHX0JJTkZNVF9BT1VUIGlzIG5vdCBzZXQKQ09ORklHX0JJTkZNVF9NSVNDPXkK
CiMKIyBOZXR3b3JraW5nCiMKQ09ORklHX05FVD15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMK
Q09ORklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19VTklYPXkKQ09ORklH
X1hGUk09eQpDT05GSUdfWEZSTV9VU0VSPXkKQ09ORklHX1hGUk1fU1VCX1BPTElDWT15CkNPTkZJ
R19YRlJNX01JR1JBVEU9eQojIENPTkZJR19YRlJNX1NUQVRJU1RJQ1MgaXMgbm90IHNldApDT05G
SUdfTkVUX0tFWT1tCkNPTkZJR19ORVRfS0VZX01JR1JBVEU9eQpDT05GSUdfSU5FVD15CkNPTkZJ
R19JUF9NVUxUSUNBU1Q9eQpDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSPXkKQ09ORklHX0FTS19J
UF9GSUJfSEFTSD15CiMgQ09ORklHX0lQX0ZJQl9UUklFIGlzIG5vdCBzZXQKQ09ORklHX0lQX0ZJ
Ql9IQVNIPXkKQ09ORklHX0lQX01VTFRJUExFX1RBQkxFUz15CkNPTkZJR19JUF9ST1VURV9NVUxU
SVBBVEg9eQpDT05GSUdfSVBfUk9VVEVfVkVSQk9TRT15CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qg
c2V0CkNPTkZJR19ORVRfSVBJUD1tCkNPTkZJR19ORVRfSVBHUkU9bQpDT05GSUdfTkVUX0lQR1JF
X0JST0FEQ0FTVD15CkNPTkZJR19JUF9NUk9VVEU9eQpDT05GSUdfSVBfUElNU01fVjE9eQpDT05G
SUdfSVBfUElNU01fVjI9eQojIENPTkZJR19BUlBEIGlzIG5vdCBzZXQKQ09ORklHX1NZTl9DT09L
SUVTPXkKQ09ORklHX0lORVRfQUg9bQpDT05GSUdfSU5FVF9FU1A9bQpDT05GSUdfSU5FVF9JUENP
TVA9bQpDT05GSUdfSU5FVF9YRlJNX1RVTk5FTD1tCkNPTkZJR19JTkVUX1RVTk5FTD1tCkNPTkZJ
R19JTkVUX1hGUk1fTU9ERV9UUkFOU1BPUlQ9bQpDT05GSUdfSU5FVF9YRlJNX01PREVfVFVOTkVM
PW0KQ09ORklHX0lORVRfWEZSTV9NT0RFX0JFRVQ9bQojIENPTkZJR19JTkVUX0xSTyBpcyBub3Qg
c2V0CkNPTkZJR19JTkVUX0RJQUc9bQpDT05GSUdfSU5FVF9UQ1BfRElBRz1tCkNPTkZJR19UQ1Bf
Q09OR19BRFZBTkNFRD15CkNPTkZJR19UQ1BfQ09OR19CSUM9bQpDT05GSUdfVENQX0NPTkdfQ1VC
SUM9eQpDT05GSUdfVENQX0NPTkdfV0VTVFdPT0Q9bQpDT05GSUdfVENQX0NPTkdfSFRDUD1tCkNP
TkZJR19UQ1BfQ09OR19IU1RDUD1tCkNPTkZJR19UQ1BfQ09OR19IWUJMQT1tCkNPTkZJR19UQ1Bf
Q09OR19WRUdBUz1tCkNPTkZJR19UQ1BfQ09OR19TQ0FMQUJMRT1tCkNPTkZJR19UQ1BfQ09OR19M
UD1tCkNPTkZJR19UQ1BfQ09OR19WRU5PPW0KQ09ORklHX1RDUF9DT05HX1lFQUg9bQpDT05GSUdf
VENQX0NPTkdfSUxMSU5PSVM9bQojIENPTkZJR19ERUZBVUxUX0JJQyBpcyBub3Qgc2V0CkNPTkZJ
R19ERUZBVUxUX0NVQklDPXkKIyBDT05GSUdfREVGQVVMVF9IVENQIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVGQVVMVF9WRUdBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFRkFVTFRfV0VTVFdPT0QgaXMg
bm90IHNldAojIENPTkZJR19ERUZBVUxUX1JFTk8gaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9U
Q1BfQ09ORz0iY3ViaWMiCkNPTkZJR19UQ1BfTUQ1U0lHPXkKQ09ORklHX0lQX1ZTPW0KIyBDT05G
SUdfSVBfVlNfREVCVUcgaXMgbm90IHNldApDT05GSUdfSVBfVlNfVEFCX0JJVFM9MTIKCiMKIyBJ
UFZTIHRyYW5zcG9ydCBwcm90b2NvbCBsb2FkIGJhbGFuY2luZyBzdXBwb3J0CiMKQ09ORklHX0lQ
X1ZTX1BST1RPX1RDUD15CkNPTkZJR19JUF9WU19QUk9UT19VRFA9eQpDT05GSUdfSVBfVlNfUFJP
VE9fRVNQPXkKQ09ORklHX0lQX1ZTX1BST1RPX0FIPXkKCiMKIyBJUFZTIHNjaGVkdWxlcgojCkNP
TkZJR19JUF9WU19SUj1tCkNPTkZJR19JUF9WU19XUlI9bQpDT05GSUdfSVBfVlNfTEM9bQpDT05G
SUdfSVBfVlNfV0xDPW0KQ09ORklHX0lQX1ZTX0xCTEM9bQpDT05GSUdfSVBfVlNfTEJMQ1I9bQpD
T05GSUdfSVBfVlNfREg9bQpDT05GSUdfSVBfVlNfU0g9bQpDT05GSUdfSVBfVlNfU0VEPW0KQ09O
RklHX0lQX1ZTX05RPW0KCiMKIyBJUFZTIGFwcGxpY2F0aW9uIGhlbHBlcgojCkNPTkZJR19JUF9W
U19GVFA9bQpDT05GSUdfSVBWNj1tCkNPTkZJR19JUFY2X1BSSVZBQ1k9eQpDT05GSUdfSVBWNl9S
T1VURVJfUFJFRj15CkNPTkZJR19JUFY2X1JPVVRFX0lORk89eQpDT05GSUdfSVBWNl9PUFRJTUlT
VElDX0RBRD15CkNPTkZJR19JTkVUNl9BSD1tCkNPTkZJR19JTkVUNl9FU1A9bQpDT05GSUdfSU5F
VDZfSVBDT01QPW0KQ09ORklHX0lQVjZfTUlQNj1tCkNPTkZJR19JTkVUNl9YRlJNX1RVTk5FTD1t
CkNPTkZJR19JTkVUNl9UVU5ORUw9bQpDT05GSUdfSU5FVDZfWEZSTV9NT0RFX1RSQU5TUE9SVD1t
CkNPTkZJR19JTkVUNl9YRlJNX01PREVfVFVOTkVMPW0KQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9C
RUVUPW0KQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9ST1VURU9QVElNSVpBVElPTj1tCkNPTkZJR19J
UFY2X1NJVD1tCkNPTkZJR19JUFY2X1RVTk5FTD1tCkNPTkZJR19JUFY2X01VTFRJUExFX1RBQkxF
Uz15CkNPTkZJR19JUFY2X1NVQlRSRUVTPXkKQ09ORklHX05FVExBQkVMPXkKQ09ORklHX05FVFdP
UktfU0VDTUFSSz15CkNPTkZJR19ORVRGSUxURVI9eQojIENPTkZJR19ORVRGSUxURVJfREVCVUcg
aXMgbm90IHNldApDT05GSUdfTkVURklMVEVSX0FEVkFOQ0VEPXkKQ09ORklHX0JSSURHRV9ORVRG
SUxURVI9eQoKIwojIENvcmUgTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfTkVURklM
VEVSX05FVExJTks9bQpDT05GSUdfTkVURklMVEVSX05FVExJTktfUVVFVUU9bQpDT05GSUdfTkVU
RklMVEVSX05FVExJTktfTE9HPW0KQ09ORklHX05GX0NPTk5UUkFDSz1tCkNPTkZJR19ORl9DVF9B
Q0NUPXkKQ09ORklHX05GX0NPTk5UUkFDS19NQVJLPXkKQ09ORklHX05GX0NPTk5UUkFDS19TRUNN
QVJLPXkKQ09ORklHX05GX0NPTk5UUkFDS19FVkVOVFM9eQpDT05GSUdfTkZfQ1RfUFJPVE9fR1JF
PW0KQ09ORklHX05GX0NUX1BST1RPX1NDVFA9bQpDT05GSUdfTkZfQ1RfUFJPVE9fVURQTElURT1t
CkNPTkZJR19ORl9DT05OVFJBQ0tfQU1BTkRBPW0KQ09ORklHX05GX0NPTk5UUkFDS19GVFA9bQpD
T05GSUdfTkZfQ09OTlRSQUNLX0gzMjM9bQpDT05GSUdfTkZfQ09OTlRSQUNLX0lSQz1tCkNPTkZJ
R19ORl9DT05OVFJBQ0tfTkVUQklPU19OUz1tCkNPTkZJR19ORl9DT05OVFJBQ0tfUFBUUD1tCkNP
TkZJR19ORl9DT05OVFJBQ0tfU0FORT1tCkNPTkZJR19ORl9DT05OVFJBQ0tfU0lQPW0KQ09ORklH
X05GX0NPTk5UUkFDS19URlRQPW0KQ09ORklHX05GX0NUX05FVExJTks9bQpDT05GSUdfTkVURklM
VEVSX1hUQUJMRVM9bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9DTEFTU0lGWT1tCkNPTkZJ
R19ORVRGSUxURVJfWFRfVEFSR0VUX0NPTk5NQVJLPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJH
RVRfRFNDUD1tCkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX01BUks9bQpDT05GSUdfTkVURklM
VEVSX1hUX1RBUkdFVF9ORlFVRVVFPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkZMT0c9
bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9OT1RSQUNLPW0KIyBDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9SQVRFRVNUIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRf
VFJBQ0U9bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9TRUNNQVJLPW0KQ09ORklHX05FVEZJ
TFRFUl9YVF9UQVJHRVRfQ09OTlNFQ01BUks9bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9U
Q1BNU1M9bQojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1RDUE9QVFNUUklQIGlzIG5vdCBz
ZXQKQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9DT01NRU5UPW0KQ09ORklHX05FVEZJTFRFUl9Y
VF9NQVRDSF9DT05OQllURVM9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0NPTk5MSU1JVD1t
CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTk1BUks9bQpDT05GSUdfTkVURklMVEVSX1hU
X01BVENIX0NPTk5UUkFDSz1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfRENDUD1tCkNPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfRFNDUD1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfRVNQ
PW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9IRUxQRVI9bQojIENPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfSVBSQU5HRSBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTEVO
R1RIPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9MSU1JVD1tCkNPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfTUFDPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9NQVJLPW0KIyBDT05GSUdf
TkVURklMVEVSX1hUX01BVENIX09XTkVSIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9YVF9N
QVRDSF9QT0xJQ1k9bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX01VTFRJUE9SVD1tCkNPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfUEhZU0RFVj1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
UEtUVFlQRT1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUVVPVEE9bQojIENPTkZJR19ORVRG
SUxURVJfWFRfTUFUQ0hfUkFURUVTVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfTUFU
Q0hfUkVBTE09bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NDVFA9bQpDT05GSUdfTkVURklM
VEVSX1hUX01BVENIX1NUQVRFPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9TVEFUSVNUSUM9
bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NUUklORz1tCkNPTkZJR19ORVRGSUxURVJfWFRf
TUFUQ0hfVENQTVNTPW0KIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1RJTUUgaXMgbm90IHNl
dApDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1UzMj1tCkNPTkZJR19ORVRGSUxURVJfWFRfTUFU
Q0hfSEFTSExJTUlUPW0KCiMKIyBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdf
TkZfQ09OTlRSQUNLX0lQVjQ9bQojIENPTkZJR19ORl9DT05OVFJBQ0tfUFJPQ19DT01QQVQgaXMg
bm90IHNldApDT05GSUdfSVBfTkZfUVVFVUU9bQpDT05GSUdfSVBfTkZfSVBUQUJMRVM9bQpDT05G
SUdfSVBfTkZfTUFUQ0hfUkVDRU5UPW0KQ09ORklHX0lQX05GX01BVENIX0VDTj1tCkNPTkZJR19J
UF9ORl9NQVRDSF9BSD1tCkNPTkZJR19JUF9ORl9NQVRDSF9UVEw9bQpDT05GSUdfSVBfTkZfTUFU
Q0hfQUREUlRZUEU9bQpDT05GSUdfSVBfTkZfRklMVEVSPW0KQ09ORklHX0lQX05GX1RBUkdFVF9S
RUpFQ1Q9bQpDT05GSUdfSVBfTkZfVEFSR0VUX0xPRz1tCkNPTkZJR19JUF9ORl9UQVJHRVRfVUxP
Rz1tCkNPTkZJR19ORl9OQVQ9bQpDT05GSUdfTkZfTkFUX05FRURFRD15CkNPTkZJR19JUF9ORl9U
QVJHRVRfTUFTUVVFUkFERT1tCkNPTkZJR19JUF9ORl9UQVJHRVRfUkVESVJFQ1Q9bQpDT05GSUdf
SVBfTkZfVEFSR0VUX05FVE1BUD1tCkNPTkZJR19ORl9OQVRfU05NUF9CQVNJQz1tCkNPTkZJR19O
Rl9OQVRfUFJPVE9fR1JFPW0KQ09ORklHX05GX05BVF9GVFA9bQpDT05GSUdfTkZfTkFUX0lSQz1t
CkNPTkZJR19ORl9OQVRfVEZUUD1tCkNPTkZJR19ORl9OQVRfQU1BTkRBPW0KQ09ORklHX05GX05B
VF9QUFRQPW0KQ09ORklHX05GX05BVF9IMzIzPW0KQ09ORklHX05GX05BVF9TSVA9bQpDT05GSUdf
SVBfTkZfTUFOR0xFPW0KQ09ORklHX0lQX05GX1RBUkdFVF9FQ049bQpDT05GSUdfSVBfTkZfVEFS
R0VUX1RUTD1tCkNPTkZJR19JUF9ORl9UQVJHRVRfQ0xVU1RFUklQPW0KQ09ORklHX0lQX05GX1JB
Vz1tCkNPTkZJR19JUF9ORl9BUlBUQUJMRVM9bQpDT05GSUdfSVBfTkZfQVJQRklMVEVSPW0KQ09O
RklHX0lQX05GX0FSUF9NQU5HTEU9bQoKIwojIElQdjY6IE5ldGZpbHRlciBDb25maWd1cmF0aW9u
CiMKQ09ORklHX05GX0NPTk5UUkFDS19JUFY2PW0KQ09ORklHX0lQNl9ORl9RVUVVRT1tCkNPTkZJ
R19JUDZfTkZfSVBUQUJMRVM9bQpDT05GSUdfSVA2X05GX01BVENIX1JUPW0KQ09ORklHX0lQNl9O
Rl9NQVRDSF9PUFRTPW0KQ09ORklHX0lQNl9ORl9NQVRDSF9GUkFHPW0KQ09ORklHX0lQNl9ORl9N
QVRDSF9ITD1tCkNPTkZJR19JUDZfTkZfTUFUQ0hfSVBWNkhFQURFUj1tCkNPTkZJR19JUDZfTkZf
TUFUQ0hfQUg9bQpDT05GSUdfSVA2X05GX01BVENIX01IPW0KQ09ORklHX0lQNl9ORl9NQVRDSF9F
VUk2ND1tCkNPTkZJR19JUDZfTkZfRklMVEVSPW0KQ09ORklHX0lQNl9ORl9UQVJHRVRfTE9HPW0K
Q09ORklHX0lQNl9ORl9UQVJHRVRfUkVKRUNUPW0KQ09ORklHX0lQNl9ORl9NQU5HTEU9bQpDT05G
SUdfSVA2X05GX1RBUkdFVF9ITD1tCkNPTkZJR19JUDZfTkZfUkFXPW0KCiMKIyBCcmlkZ2U6IE5l
dGZpbHRlciBDb25maWd1cmF0aW9uCiMKQ09ORklHX0JSSURHRV9ORl9FQlRBQkxFUz1tCkNPTkZJ
R19CUklER0VfRUJUX0JST1VURT1tCkNPTkZJR19CUklER0VfRUJUX1RfRklMVEVSPW0KQ09ORklH
X0JSSURHRV9FQlRfVF9OQVQ9bQpDT05GSUdfQlJJREdFX0VCVF84MDJfMz1tCkNPTkZJR19CUklE
R0VfRUJUX0FNT05HPW0KQ09ORklHX0JSSURHRV9FQlRfQVJQPW0KQ09ORklHX0JSSURHRV9FQlRf
SVA9bQpDT05GSUdfQlJJREdFX0VCVF9MSU1JVD1tCkNPTkZJR19CUklER0VfRUJUX01BUks9bQpD
T05GSUdfQlJJREdFX0VCVF9QS1RUWVBFPW0KQ09ORklHX0JSSURHRV9FQlRfU1RQPW0KQ09ORklH
X0JSSURHRV9FQlRfVkxBTj1tCkNPTkZJR19CUklER0VfRUJUX0FSUFJFUExZPW0KQ09ORklHX0JS
SURHRV9FQlRfRE5BVD1tCkNPTkZJR19CUklER0VfRUJUX01BUktfVD1tCkNPTkZJR19CUklER0Vf
RUJUX1JFRElSRUNUPW0KQ09ORklHX0JSSURHRV9FQlRfU05BVD1tCkNPTkZJR19CUklER0VfRUJU
X0xPRz1tCkNPTkZJR19CUklER0VfRUJUX1VMT0c9bQojIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBz
ZXQKQ09ORklHX0lQX1NDVFA9bQojIENPTkZJR19TQ1RQX0RCR19NU0cgaXMgbm90IHNldAojIENP
TkZJR19TQ1RQX0RCR19PQkpDTlQgaXMgbm90IHNldAojIENPTkZJR19TQ1RQX0hNQUNfTk9ORSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDVFBfSE1BQ19TSEExIGlzIG5vdCBzZXQKQ09ORklHX1NDVFBf
SE1BQ19NRDU9eQojIENPTkZJR19USVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBz
ZXQKQ09ORklHX0JSSURHRT1tCkNPTkZJR19WTEFOXzgwMjFRPW0KIyBDT05GSUdfREVDTkVUIGlz
IG5vdCBzZXQKQ09ORklHX0xMQz1tCiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19J
UFggaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19FQ09ORVQgaXMgbm90IHNl
dAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKQ09ORklHX05FVF9TQ0hFRD15CgojCiMg
UXVldWVpbmcvU2NoZWR1bGluZwojCkNPTkZJR19ORVRfU0NIX0NCUT1tCkNPTkZJR19ORVRfU0NI
X0hUQj1tCkNPTkZJR19ORVRfU0NIX0hGU0M9bQpDT05GSUdfTkVUX1NDSF9QUklPPW0KQ09ORklH
X05FVF9TQ0hfUlI9bQpDT05GSUdfTkVUX1NDSF9SRUQ9bQpDT05GSUdfTkVUX1NDSF9TRlE9bQpD
T05GSUdfTkVUX1NDSF9URVFMPW0KQ09ORklHX05FVF9TQ0hfVEJGPW0KQ09ORklHX05FVF9TQ0hf
R1JFRD1tCkNPTkZJR19ORVRfU0NIX0RTTUFSSz1tCkNPTkZJR19ORVRfU0NIX05FVEVNPW0KQ09O
RklHX05FVF9TQ0hfSU5HUkVTUz1tCgojCiMgQ2xhc3NpZmljYXRpb24KIwpDT05GSUdfTkVUX0NM
Uz15CkNPTkZJR19ORVRfQ0xTX0JBU0lDPW0KQ09ORklHX05FVF9DTFNfVENJTkRFWD1tCkNPTkZJ
R19ORVRfQ0xTX1JPVVRFND1tCkNPTkZJR19ORVRfQ0xTX1JPVVRFPXkKQ09ORklHX05FVF9DTFNf
Rlc9bQpDT05GSUdfTkVUX0NMU19VMzI9bQpDT05GSUdfQ0xTX1UzMl9QRVJGPXkKQ09ORklHX0NM
U19VMzJfTUFSSz15CkNPTkZJR19ORVRfQ0xTX1JTVlA9bQpDT05GSUdfTkVUX0NMU19SU1ZQNj1t
CiMgQ09ORklHX05FVF9DTFNfRkxPVyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfRU1BVENIPXkKQ09O
RklHX05FVF9FTUFUQ0hfU1RBQ0s9MzIKQ09ORklHX05FVF9FTUFUQ0hfQ01QPW0KQ09ORklHX05F
VF9FTUFUQ0hfTkJZVEU9bQpDT05GSUdfTkVUX0VNQVRDSF9VMzI9bQpDT05GSUdfTkVUX0VNQVRD
SF9NRVRBPW0KQ09ORklHX05FVF9FTUFUQ0hfVEVYVD1tCkNPTkZJR19ORVRfQ0xTX0FDVD15CkNP
TkZJR19ORVRfQUNUX1BPTElDRT15CkNPTkZJR19ORVRfQUNUX0dBQ1Q9bQpDT05GSUdfR0FDVF9Q
Uk9CPXkKQ09ORklHX05FVF9BQ1RfTUlSUkVEPW0KQ09ORklHX05FVF9BQ1RfSVBUPW0KIyBDT05G
SUdfTkVUX0FDVF9OQVQgaXMgbm90IHNldApDT05GSUdfTkVUX0FDVF9QRURJVD1tCkNPTkZJR19O
RVRfQUNUX1NJTVA9bQpDT05GSUdfTkVUX0NMU19JTkQ9eQpDT05GSUdfTkVUX1NDSF9GSUZPPXkK
CiMKIyBOZXR3b3JrIHRlc3RpbmcKIwpDT05GSUdfTkVUX1BLVEdFTj1tCiMgQ09ORklHX05FVF9U
Q1BQUk9CRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNldApDT05GSUdfRklCX1JVTEVTPXkKCiMK
IyBXaXJlbGVzcwojCiMgQ09ORklHX0NGRzgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lSRUxF
U1NfRVhUIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDODAyMTEgaXMgbm90IHNldAojIENPTkZJR19J
RUVFODAyMTEgaXMgbm90IHNldAojIENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19O
RVRfOVAgaXMgbm90IHNldAoKIwojIERldmljZSBEcml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZl
ciBPcHRpb25zCiMKQ09ORklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iL3NiaW4vaG90cGx1ZyIKQ09O
RklHX1NUQU5EQUxPTkU9eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CkNPTkZJR19G
V19MT0FERVI9eQojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldApDT05GSUdfREVCVUdf
REVWUkVTPXkKIyBDT05GSUdfU1lTX0hZUEVSVklTT1IgaXMgbm90IHNldApDT05GSUdfQ09OTkVD
VE9SPXkKQ09ORklHX1BST0NfRVZFTlRTPXkKQ09ORklHX01URD1tCiMgQ09ORklHX01URF9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19NVERfQ09OQ0FUPW0KQ09ORklHX01URF9QQVJUSVRJT05TPXkK
Q09ORklHX01URF9SRURCT09UX1BBUlRTPW0KQ09ORklHX01URF9SRURCT09UX0RJUkVDVE9SWV9C
TE9DSz0tMQojIENPTkZJR19NVERfUkVEQk9PVF9QQVJUU19VTkFMTE9DQVRFRCBpcyBub3Qgc2V0
CiMgQ09ORklHX01URF9SRURCT09UX1BBUlRTX1JFQURPTkxZIGlzIG5vdCBzZXQKCiMKIyBVc2Vy
IE1vZHVsZXMgQW5kIFRyYW5zbGF0aW9uIExheWVycwojCkNPTkZJR19NVERfQ0hBUj1tCkNPTkZJ
R19NVERfQkxLREVWUz1tCkNPTkZJR19NVERfQkxPQ0s9bQpDT05GSUdfTVREX0JMT0NLX1JPPW0K
Q09ORklHX0ZUTD1tCkNPTkZJR19ORlRMPW0KQ09ORklHX05GVExfUlc9eQpDT05GSUdfSU5GVEw9
bQpDT05GSUdfUkZEX0ZUTD1tCkNPTkZJR19TU0ZEQz1tCiMgQ09ORklHX01URF9PT1BTIGlzIG5v
dCBzZXQKCiMKIyBSQU0vUk9NL0ZsYXNoIGNoaXAgZHJpdmVycwojCkNPTkZJR19NVERfQ0ZJPW0K
Q09ORklHX01URF9KRURFQ1BST0JFPW0KQ09ORklHX01URF9HRU5fUFJPQkU9bQojIENPTkZJR19N
VERfQ0ZJX0FEVl9PUFRJT05TIGlzIG5vdCBzZXQKQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8x
PXkKQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8yPXkKQ09ORklHX01URF9NQVBfQkFOS19XSURU
SF80PXkKIyBDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzggaXMgbm90IHNldAojIENPTkZJR19N
VERfTUFQX0JBTktfV0lEVEhfMTYgaXMgbm90IHNldAojIENPTkZJR19NVERfTUFQX0JBTktfV0lE
VEhfMzIgaXMgbm90IHNldApDT05GSUdfTVREX0NGSV9JMT15CkNPTkZJR19NVERfQ0ZJX0kyPXkK
IyBDT05GSUdfTVREX0NGSV9JNCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9DRklfSTggaXMgbm90
IHNldApDT05GSUdfTVREX0NGSV9JTlRFTEVYVD1tCkNPTkZJR19NVERfQ0ZJX0FNRFNURD1tCkNP
TkZJR19NVERfQ0ZJX1NUQUE9bQpDT05GSUdfTVREX0NGSV9VVElMPW0KQ09ORklHX01URF9SQU09
bQpDT05GSUdfTVREX1JPTT1tCkNPTkZJR19NVERfQUJTRU5UPW0KCiMKIyBNYXBwaW5nIGRyaXZl
cnMgZm9yIGNoaXAgYWNjZXNzCiMKQ09ORklHX01URF9DT01QTEVYX01BUFBJTkdTPXkKIyBDT05G
SUdfTVREX1BIWVNNQVAgaXMgbm90IHNldApDT05GSUdfTVREX1NDNTIwQ0RQPW0KQ09ORklHX01U
RF9ORVRTQzUyMD1tCkNPTkZJR19NVERfVFM1NTAwPW0KIyBDT05GSUdfTVREX1NCQ19HWFggaXMg
bm90IHNldAojIENPTkZJR19NVERfQU1ENzZYUk9NIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0lD
SFhST00gaXMgbm90IHNldApDT05GSUdfTVREX0VTQjJST009bQpDT05GSUdfTVREX0NLODA0WFJP
TT1tCkNPTkZJR19NVERfU0NCMl9GTEFTSD1tCiMgQ09ORklHX01URF9ORVR0ZWwgaXMgbm90IHNl
dAojIENPTkZJR19NVERfRElMTkVUUEMgaXMgbm90IHNldAojIENPTkZJR19NVERfTDQ0MEdYIGlz
IG5vdCBzZXQKQ09ORklHX01URF9QQ0k9bQojIENPTkZJR19NVERfSU5URUxfVlJfTk9SIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREX1BMQVRSQU0gaXMgbm90IHNldAoKIwojIFNlbGYtY29udGFpbmVk
IE1URCBkZXZpY2UgZHJpdmVycwojCkNPTkZJR19NVERfUE1DNTUxPW0KIyBDT05GSUdfTVREX1BN
QzU1MV9CVUdGSVggaXMgbm90IHNldAojIENPTkZJR19NVERfUE1DNTUxX0RFQlVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVREX1NMUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BIUkFNIGlzIG5v
dCBzZXQKQ09ORklHX01URF9NVERSQU09bQpDT05GSUdfTVREUkFNX1RPVEFMX1NJWkU9NDA5NgpD
T05GSUdfTVREUkFNX0VSQVNFX1NJWkU9MTI4CkNPTkZJR19NVERfQkxPQ0syTVREPW0KCiMKIyBE
aXNrLU9uLUNoaXAgRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19NVERfRE9DMjAwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX01URF9ET0MyMDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0RPQzIwMDFQ
TFVTIGlzIG5vdCBzZXQKQ09ORklHX01URF9OQU5EPW0KIyBDT05GSUdfTVREX05BTkRfVkVSSUZZ
X1dSSVRFIGlzIG5vdCBzZXQKQ09ORklHX01URF9OQU5EX0VDQ19TTUM9eQojIENPTkZJR19NVERf
TkFORF9NVVNFVU1fSURTIGlzIG5vdCBzZXQKQ09ORklHX01URF9OQU5EX0lEUz1tCkNPTkZJR19N
VERfTkFORF9ESVNLT05DSElQPW0KIyBDT05GSUdfTVREX05BTkRfRElTS09OQ0hJUF9QUk9CRV9B
RFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19NVERfTkFORF9ESVNLT05DSElQX1BST0JFX0FERFJF
U1M9MAojIENPTkZJR19NVERfTkFORF9ESVNLT05DSElQX0JCVFdSSVRFIGlzIG5vdCBzZXQKQ09O
RklHX01URF9OQU5EX0NBRkU9bQpDT05GSUdfTVREX05BTkRfQ1M1NTNYPW0KQ09ORklHX01URF9O
QU5EX05BTkRTSU09bQojIENPTkZJR19NVERfTkFORF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09O
RklHX01URF9BTEFVREEgaXMgbm90IHNldAojIENPTkZJR19NVERfT05FTkFORCBpcyBub3Qgc2V0
CgojCiMgVUJJIC0gVW5zb3J0ZWQgYmxvY2sgaW1hZ2VzCiMKQ09ORklHX01URF9VQkk9bQpDT05G
SUdfTVREX1VCSV9XTF9USFJFU0hPTEQ9NDA5NgpDT05GSUdfTVREX1VCSV9CRUJfUkVTRVJWRT0x
CiMgQ09ORklHX01URF9VQklfR0xVRUJJIGlzIG5vdCBzZXQKCiMKIyBVQkkgZGVidWdnaW5nIG9w
dGlvbnMKIwojIENPTkZJR19NVERfVUJJX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlQ9
bQpDT05GSUdfUEFSUE9SVF9QQz1tCkNPTkZJR19QQVJQT1JUX1NFUklBTD1tCiMgQ09ORklHX1BB
UlBPUlRfUENfRklGTyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfUENfU1VQRVJJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfR1NDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9B
WDg4Nzk2IGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlRfMTI4ND15CkNPTkZJR19QQVJQT1JUX05P
VF9QQz15CkNPTkZJR19QTlA9eQojIENPTkZJR19QTlBfREVCVUcgaXMgbm90IHNldAoKIwojIFBy
b3RvY29scwojCkNPTkZJR19JU0FQTlA9eQojIENPTkZJR19QTlBCSU9TIGlzIG5vdCBzZXQKQ09O
RklHX1BOUEFDUEk9eQpDT05GSUdfQkxLX0RFVj15CkNPTkZJR19CTEtfREVWX0ZEPW0KIyBDT05G
SUdfQkxLX0RFVl9YRCBpcyBub3Qgc2V0CkNPTkZJR19QQVJJREU9bQoKIwojIFBhcmFsbGVsIElE
RSBoaWdoLWxldmVsIGRyaXZlcnMKIwpDT05GSUdfUEFSSURFX1BEPW0KQ09ORklHX1BBUklERV9Q
Q0Q9bQpDT05GSUdfUEFSSURFX1BGPW0KQ09ORklHX1BBUklERV9QVD1tCkNPTkZJR19QQVJJREVf
UEc9bQoKIwojIFBhcmFsbGVsIElERSBwcm90b2NvbCBtb2R1bGVzCiMKIyBDT05GSUdfUEFSSURF
X0FURU4gaXMgbm90IHNldAojIENPTkZJR19QQVJJREVfQlBDSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBUklERV9CUENLNiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERV9DT01NIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFSSURFX0RTVFIgaXMgbm90IHNldAojIENPTkZJR19QQVJJREVfRklUMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBUklERV9GSVQzIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0VQ
QVQgaXMgbm90IHNldAojIENPTkZJR19QQVJJREVfRVBJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BB
UklERV9GUklRIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSSURFX0ZSUFcgaXMgbm90IHNldAojIENP
TkZJR19QQVJJREVfS0JJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUklERV9LVFRJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFSSURFX09OMjAgaXMgbm90IHNldAojIENPTkZJR19QQVJJREVfT04yNiBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BR
X0NJU1NfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfVU1FTSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ09XX0NPTU1P
TiBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9bQpDT05GSUdfQkxLX0RFVl9DUllQVE9M
T09QPW0KQ09ORklHX0JMS19ERVZfTkJEPW0KIyBDT05GSUdfQkxLX0RFVl9TWDggaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX1VCIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfUkFNPXkKQ09O
RklHX0JMS19ERVZfUkFNX0NPVU5UPTE2CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTE2Mzg0CiMg
Q09ORklHX0JMS19ERVZfWElQIGlzIG5vdCBzZXQKQ09ORklHX0NEUk9NX1BLVENEVkQ9bQpDT05G
SUdfQ0RST01fUEtUQ0RWRF9CVUZGRVJTPTgKIyBDT05GSUdfQ0RST01fUEtUQ0RWRF9XQ0FDSEUg
aXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldApDT05GSUdfTUlTQ19E
RVZJQ0VTPXkKIyBDT05GSUdfSUJNX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1BIQU5UT00gaXMg
bm90IHNldAojIENPTkZJR19FRVBST01fOTNDWDYgaXMgbm90IHNldAojIENPTkZJR19TR0lfSU9D
NCBpcyBub3Qgc2V0CkNPTkZJR19USUZNX0NPUkU9bQojIENPTkZJR19USUZNXzdYWDEgaXMgbm90
IHNldAojIENPTkZJR19BQ0VSX1dNSSBpcyBub3Qgc2V0CkNPTkZJR19BU1VTX0xBUFRPUD1tCiMg
Q09ORklHX0ZVSklUU1VfTEFQVE9QIGlzIG5vdCBzZXQKIyBDT05GSUdfVEMxMTAwX1dNSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01TSV9MQVBUT1AgaXMgbm90IHNldAojIENPTkZJR19TT05ZX0xBUFRP
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1RISU5LUEFEX0FDUEkgaXMgbm90IHNldAojIENPTkZJR19J
TlRFTF9NRU5MT1cgaXMgbm90IHNldAojIENPTkZJR19FTkNMT1NVUkVfU0VSVklDRVMgaXMgbm90
IHNldApDT05GSUdfSEFWRV9JREU9eQojIENPTkZJR19JREUgaXMgbm90IHNldAoKIwojIFNDU0kg
ZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfUkFJRF9BVFRSUz1tCkNPTkZJR19TQ1NJPW0KQ09ORklH
X1NDU0lfRE1BPXkKQ09ORklHX1NDU0lfVEdUPW0KQ09ORklHX1NDU0lfTkVUTElOSz15CkNPTkZJ
R19TQ1NJX1BST0NfRlM9eQoKIwojIFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1S
T00pCiMKQ09ORklHX0JMS19ERVZfU0Q9bQpDT05GSUdfQ0hSX0RFVl9TVD1tCkNPTkZJR19DSFJf
REVWX09TU1Q9bQpDT05GSUdfQkxLX0RFVl9TUj1tCkNPTkZJR19CTEtfREVWX1NSX1ZFTkRPUj15
CkNPTkZJR19DSFJfREVWX1NHPW0KQ09ORklHX0NIUl9ERVZfU0NIPW0KCiMKIyBTb21lIFNDU0kg
ZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExVTnMKIwpDT05GSUdf
U0NTSV9NVUxUSV9MVU49eQpDT05GSUdfU0NTSV9DT05TVEFOVFM9eQpDT05GSUdfU0NTSV9MT0dH
SU5HPXkKQ09ORklHX1NDU0lfU0NBTl9BU1lOQz15CkNPTkZJR19TQ1NJX1dBSVRfU0NBTj1tCgoj
CiMgU0NTSSBUcmFuc3BvcnRzCiMKQ09ORklHX1NDU0lfU1BJX0FUVFJTPW0KQ09ORklHX1NDU0lf
RkNfQVRUUlM9bQojIENPTkZJR19TQ1NJX0ZDX1RHVF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19T
Q1NJX0lTQ1NJX0FUVFJTPW0KQ09ORklHX1NDU0lfU0FTX0FUVFJTPW0KQ09ORklHX1NDU0lfU0FT
X0xJQlNBUz1tCkNPTkZJR19TQ1NJX1NBU19BVEE9eQpDT05GSUdfU0NTSV9TQVNfSE9TVF9TTVA9
eQojIENPTkZJR19TQ1NJX1NBU19MSUJTQVNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1NSUF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0xPV0xFVkVMPXkKIyBDT05GSUdfSVND
U0lfVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl8zV19YWFhYX1JBSUQgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJXzNXXzlYWFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJXzcwMDBGQVNT
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUNBUkQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0FIQTE1MlggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FIQTE1NDIgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0FBQ1JBSUQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFggaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0FJQzdYWFhfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9B
SUM3OVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM5NFhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9EUFRfSTJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BRFZBTlNZUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfSU4yMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BUkNNU1Ig
aXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9ORVdHRU4gaXMgbm90IHNldAojIENPTkZJR19N
RUdBUkFJRF9MRUdBQ1kgaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9TQVMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0hQVElPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9HSUMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9EVEMzMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9GVVRVUkVfRE9NQUlOIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfR0RUSD1tCiMgQ09O
RklHX1NDU0lfR0VORVJJQ19OQ1I1MzgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9HRU5FUklD
X05DUjUzODBfTU1JTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1BQQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU1NIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9NVlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkNSNTND
NDA2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1RFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU1lNNTNDOFhYXzIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfUEFTMTYgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19GQVMgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9RTEFfRkMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQV9JU0NTSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfTFBGQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDNDE2IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9EQzM5NXggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzkw
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVDEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
VTE0XzM0RiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfVUxUUkFTVE9SIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9OU1AzMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1NSUCBpcyBub3Qgc2V0CkNPTkZJR19BVEE9bQojIENPTkZJR19BVEFf
Tk9OU1RBTkRBUkQgaXMgbm90IHNldApDT05GSUdfQVRBX0FDUEk9eQpDT05GSUdfU0FUQV9BSENJ
PW0KIyBDT05GSUdfU0FUQV9TVlcgaXMgbm90IHNldApDT05GSUdfQVRBX1BJSVg9bQojIENPTkZJ
R19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9OViBpcyBub3Qgc2V0CiMgQ09ORklH
X1BEQ19BRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9RU1RPUiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU1g0IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0FUQV9TSUwgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1VMSSBpcyBub3Qg
c2V0CkNPTkZJR19TQVRBX1ZJQT1tCiMgQ09ORklHX1NBVEFfVklURVNTRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0FDUEkgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NDBfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NTNTUyMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BBVEFfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DUzU1MzUgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX0NTNTUzNiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1lQUkVT
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfRUZBUiBpcyBub3Qgc2V0CkNPTkZJR19BVEFfR0VO
RVJJQz1tCiMgQ09ORklHX1BBVEFfSFBUMzY2IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQz
N1ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDNYMk4gaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX0hQVDNYMyBpcyBub3Qgc2V0CkNPTkZJR19QQVRBX0lTQVBOUD1tCiMgQ09ORklHX1BBVEFf
SVQ4MjFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9JVDgyMTMgaXMgbm90IHNldAojIENPTkZJ
R19QQVRBX0pNSUNST04gaXMgbm90IHNldAojIENPTkZJR19QQVRBX0xFR0FDWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfVFJJRkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTUFSVkVMTCBp
cyBub3Qgc2V0CkNPTkZJR19QQVRBX01QSUlYPW0KQ09ORklHX1BBVEFfT0xEUElJWD1tCiMgQ09O
RklHX1BBVEFfTkVUQ0VMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTklOSkEzMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfTlM4NzQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTlM4NzQx
NSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfT1BUSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFf
T1BUSURNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfUURJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SQURJU1lTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9SWjEwMDAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NDMTIwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfU0VSVkVSV09SS1MgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X1BEQzIwMjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX1NJUyBpcyBub3Qgc2V0CkNPTkZJR19QQVRBX1ZJQT1tCiMgQ09ORklHX1BBVEFf
V0lOQk9ORCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfV0lOQk9ORF9WTEIgaXMgbm90IHNldApD
T05GSUdfTUQ9eQpDT05GSUdfQkxLX0RFVl9NRD15CkNPTkZJR19NRF9MSU5FQVI9bQpDT05GSUdf
TURfUkFJRDA9bQpDT05GSUdfTURfUkFJRDE9bQpDT05GSUdfTURfUkFJRDEwPW0KQ09ORklHX01E
X1JBSUQ0NTY9bQpDT05GSUdfTURfUkFJRDVfUkVTSEFQRT15CkNPTkZJR19NRF9NVUxUSVBBVEg9
bQpDT05GSUdfTURfRkFVTFRZPW0KQ09ORklHX0JMS19ERVZfRE09bQpDT05GSUdfRE1fREVCVUc9
eQpDT05GSUdfRE1fQ1JZUFQ9bQpDT05GSUdfRE1fU05BUFNIT1Q9bQpDT05GSUdfRE1fTUlSUk9S
PW0KQ09ORklHX0RNX1pFUk89bQpDT05GSUdfRE1fTVVMVElQQVRIPW0KQ09ORklHX0RNX01VTFRJ
UEFUSF9FTUM9bQpDT05GSUdfRE1fTVVMVElQQVRIX1JEQUM9bQojIENPTkZJR19ETV9NVUxUSVBB
VEhfSFAgaXMgbm90IHNldAojIENPTkZJR19ETV9ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX0RN
X1VFVkVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qgc2V0CgojCiMgSUVFRSAx
Mzk0IChGaXJlV2lyZSkgc3VwcG9ydAojCiMgQ09ORklHX0ZJUkVXSVJFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSUVFRTEzOTQgaXMgbm90IHNldAojIENPTkZJR19JMk8gaXMgbm90IHNldAojIENPTkZJ
R19NQUNJTlRPU0hfRFJJVkVSUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKIyBDT05G
SUdfTkVUREVWSUNFU19NVUxUSVFVRVVFIGlzIG5vdCBzZXQKQ09ORklHX0lGQj1tCkNPTkZJR19E
VU1NWT1tCkNPTkZJR19CT05ESU5HPW0KQ09ORklHX01BQ1ZMQU49bQpDT05GSUdfRVFVQUxJWkVS
PW0KQ09ORklHX1RVTj1tCiMgQ09ORklHX1ZFVEggaXMgbm90IHNldAojIENPTkZJR19ORVRfU0Ix
MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElC
IGlzIG5vdCBzZXQKQ09ORklHX05FVF9FVEhFUk5FVD15CkNPTkZJR19NSUk9bQojIENPTkZJR19I
QVBQWU1FQUwgaXMgbm90IHNldAojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldAojIENPTkZJR19D
QVNTSU5JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBD
T05GSUdfTEFOQ0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldAojIENPTkZJR19ORVRfVFVMSVAg
aXMgbm90IHNldAojIENPTkZJR19BVDE3MDAgaXMgbm90IHNldAojIENPTkZJR19ERVBDQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hQMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lTQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19aTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05F
V19FTUFDX1JHTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05FV19FTUFDX1RBSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19FTUFDNCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9Q
Q0kgaXMgbm90IHNldAojIENPTkZJR19CNDQgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9DS0VU
IGlzIG5vdCBzZXQKQ09ORklHX05FVERFVl8xMDAwPXkKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREwySyBpcyBub3Qgc2V0CiMgQ09ORklHX0UxMDAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfRTEwMDBFIGlzIG5vdCBzZXQKIyBDT05GSUdfRTEwMDBFX0VOQUJMRUQgaXMgbm90IHNl
dAojIENPTkZJR19JUDEwMDAgaXMgbm90IHNldAojIENPTkZJR19JR0IgaXMgbm90IHNldAojIENP
TkZJR19OUzgzODIwIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFNQUNISSBpcyBub3Qgc2V0CiMgQ09O
RklHX1lFTExPV0ZJTiBpcyBub3Qgc2V0CkNPTkZJR19SODE2OT1tCkNPTkZJR19SODE2OV9OQVBJ
PXkKQ09ORklHX1I4MTY5X1ZMQU49eQojIENPTkZJR19TSVMxOTAgaXMgbm90IHNldAojIENPTkZJ
R19TS0dFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0tZMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NLOThM
SU4gaXMgbm90IHNldAojIENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNldAojIENPTkZJR19U
SUdPTjMgaXMgbm90IHNldAojIENPTkZJR19CTlgyIGlzIG5vdCBzZXQKIyBDT05GSUdfUUxBM1hY
WCBpcyBub3Qgc2V0CkNPTkZJR19BVEwxPW0KIyBDT05GSUdfTkVUREVWXzEwMDAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVFIgaXMgbm90IHNldAoKIwojIFdpcmVsZXNzIExBTgojCiMgQ09ORklHX1dM
QU5fUFJFODAyMTEgaXMgbm90IHNldAojIENPTkZJR19XTEFOXzgwMjExIGlzIG5vdCBzZXQKCiMK
IyBVU0IgTmV0d29yayBBZGFwdGVycwojCiMgQ09ORklHX1VTQl9DQVRDIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QRUdBU1VTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfVVNCTkVUIGlz
IG5vdCBzZXQKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKQ09ORklHX1BMSVA9bQpDT05GSUdfUFBQPW0KQ09O
RklHX1BQUF9NVUxUSUxJTks9eQpDT05GSUdfUFBQX0ZJTFRFUj15CkNPTkZJR19QUFBfQVNZTkM9
bQpDT05GSUdfUFBQX1NZTkNfVFRZPW0KQ09ORklHX1BQUF9ERUZMQVRFPW0KIyBDT05GSUdfUFBQ
X0JTRENPTVAgaXMgbm90IHNldApDT05GSUdfUFBQX01QUEU9bQpDT05GSUdfUFBQT0U9bQpDT05G
SUdfUFBQT0wyVFA9bQpDT05GSUdfU0xJUD1tCkNPTkZJR19TTElQX0NPTVBSRVNTRUQ9eQpDT05G
SUdfU0xIQz1tCkNPTkZJR19TTElQX1NNQVJUPXkKIyBDT05GSUdfU0xJUF9NT0RFX1NMSVA2IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKQ09ORklHX05FVENPTlNPTEU9bQpD
T05GSUdfTkVUQ09OU09MRV9EWU5BTUlDPXkKQ09ORklHX05FVFBPTEw9eQpDT05GSUdfTkVUUE9M
TF9UUkFQPXkKQ09ORklHX05FVF9QT0xMX0NPTlRST0xMRVI9eQojIENPTkZJR19JU0ROIGlzIG5v
dCBzZXQKIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBwb3J0
CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0ZGX01FTUxFU1M9eQpDT05GSUdfSU5QVVRf
UE9MTERFVj1tCgojCiMgVXNlcmxhbmQgaW50ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURF
Vj15CiMgQ09ORklHX0lOUFVUX01PVVNFREVWX1BTQVVYIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVU
X01PVVNFREVWX1NDUkVFTl9YPTEwMjQKQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9ZPTc2
OApDT05GSUdfSU5QVVRfSk9ZREVWPW0KQ09ORklHX0lOUFVUX0VWREVWPXkKIyBDT05GSUdfSU5Q
VVRfRVZCVUcgaXMgbm90IHNldAoKIwojIElucHV0IERldmljZSBEcml2ZXJzCiMKQ09ORklHX0lO
UFVUX0tFWUJPQVJEPXkKQ09ORklHX0tFWUJPQVJEX0FUS0JEPXkKIyBDT05GSUdfS0VZQk9BUkRf
U1VOS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTEtLQkQgaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9YVEtCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NUT1dBV0FZIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX01PVVNFPXkKQ09ORklHX01PVVNFX1BTMj15CkNPTkZJR19NT1VTRV9QUzJfQUxQUz15CkNP
TkZJR19NT1VTRV9QUzJfTE9HSVBTMlBQPXkKQ09ORklHX01PVVNFX1BTMl9TWU5BUFRJQ1M9eQpD
T05GSUdfTU9VU0VfUFMyX0xJRkVCT09LPXkKQ09ORklHX01PVVNFX1BTMl9UUkFDS1BPSU5UPXkK
IyBDT05GSUdfTU9VU0VfUFMyX1RPVUNIS0lUIGlzIG5vdCBzZXQKQ09ORklHX01PVVNFX1NFUklB
TD1tCiMgQ09ORklHX01PVVNFX0FQUExFVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9J
TlBPUlQgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9MT0dJQk0gaXMgbm90IHNldAojIENPTkZJ
R19NT1VTRV9QQzExMFBBRCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90
IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RB
QkxFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKQ09O
RklHX0lOUFVUX01JU0M9eQpDT05GSUdfSU5QVVRfUENTUEtSPW0KIyBDT05GSUdfSU5QVVRfQVBB
TkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfV0lTVFJPTl9CVE5TIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfQVRMQVNfQlROUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0FUSV9SRU1P
VEUgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9BVElfUkVNT1RFMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOUFVUX0tFWVNQQU5fUkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9XRVJN
QVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfWUVBTElOSyBpcyBub3Qgc2V0CkNPTkZJR19J
TlBVVF9VSU5QVVQ9bQoKIwojIEhhcmR3YXJlIEkvTyBwb3J0cwojCkNPTkZJR19TRVJJTz15CkNP
TkZJR19TRVJJT19JODA0Mj15CkNPTkZJR19TRVJJT19TRVJQT1JUPXkKIyBDT05GSUdfU0VSSU9f
Q1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQVJLQkQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldApDT05GSUdfU0VSSU9fTElCUFMyPXkKQ09ORklH
X1NFUklPX1JBVz1tCiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIg
ZGV2aWNlcwojCkNPTkZJR19WVD15CkNPTkZJR19WVF9DT05TT0xFPXkKQ09ORklHX0hXX0NPTlNP
TEU9eQpDT05GSUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HPXkKQ09ORklHX1NFUklBTF9OT05TVEFO
REFSRD15CiMgQ09ORklHX0NPTVBVVE9ORSBpcyBub3Qgc2V0CiMgQ09ORklHX1JPQ0tFVFBPUlQg
aXMgbm90IHNldAojIENPTkZJR19DWUNMQURFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RJR0lFUENB
IGlzIG5vdCBzZXQKIyBDT05GSUdfRVNQU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9YQV9J
TlRFTExJTyBpcyBub3Qgc2V0CiMgQ09ORklHX01PWEFfU01BUlRJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTkNMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1lOQ0xJTktNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTkNMSU5LX0dUIGlzIG5vdCBzZXQKIyBD
T05GSUdfTl9IRExDIGlzIG5vdCBzZXQKIyBDT05GSUdfUklTQ09NOCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NQRUNJQUxJWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NYIGlzIG5vdCBzZXQKIyBDT05GSUdf
UklPIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBTERSViBpcyBub3Qgc2V0CiMgQ09ORklHX05PWk9N
SSBpcyBub3Qgc2V0CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMXzgyNTA9eQpD
T05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15CkNPTkZJR19GSVhfRUFSTFlDT05fTUVNPXkKQ09O
RklHX1NFUklBTF84MjUwX1BDST15CkNPTkZJR19TRVJJQUxfODI1MF9QTlA9eQpDT05GSUdfU0VS
SUFMXzgyNTBfTlJfVUFSVFM9MzIKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJTUVfVUFSVFM9NApD
T05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQ9eQojIENPTkZJR19TRVJJQUxfODI1MF9NQU5ZX1BP
UlRTIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF84MjUwX1NIQVJFX0lSUT15CkNPTkZJR19TRVJJ
QUxfODI1MF9ERVRFQ1RfSVJRPXkKQ09ORklHX1NFUklBTF84MjUwX1JTQT15CgojCiMgTm9uLTgy
NTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJ
QUxfQ09SRV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNPTkZJR19V
TklYOThfUFRZUz15CiMgQ09ORklHX0xFR0FDWV9QVFlTIGlzIG5vdCBzZXQKQ09ORklHX1BSSU5U
RVI9bQpDT05GSUdfTFBfQ09OU09MRT15CkNPTkZJR19QUERFVj1tCkNPTkZJR19JUE1JX0hBTkRM
RVI9bQojIENPTkZJR19JUE1JX1BBTklDX0VWRU5UIGlzIG5vdCBzZXQKQ09ORklHX0lQTUlfREVW
SUNFX0lOVEVSRkFDRT1tCkNPTkZJR19JUE1JX1NJPW0KQ09ORklHX0lQTUlfV0FUQ0hET0c9bQpD
T05GSUdfSVBNSV9QT1dFUk9GRj1tCkNPTkZJR19IV19SQU5ET009eQpDT05GSUdfSFdfUkFORE9N
X0lOVEVMPW0KQ09ORklHX0hXX1JBTkRPTV9BTUQ9bQpDT05GSUdfSFdfUkFORE9NX0dFT0RFPW0K
Q09ORklHX0hXX1JBTkRPTV9WSUE9bQpDT05GSUdfTlZSQU09eQpDT05GSUdfUlRDPXkKIyBDT05G
SUdfRFRMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQ
TElDT00gaXMgbm90IHNldAojIENPTkZJR19TT05ZUEkgaXMgbm90IHNldApDT05GSUdfTVdBVkU9
bQojIENPTkZJR19QQzg3MzZ4X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19OU0NfR1BJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NTNTUzNV9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFXX0RSSVZF
UiBpcyBub3Qgc2V0CkNPTkZJR19IUEVUPXkKIyBDT05GSUdfSFBFVF9SVENfSVJRIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFBFVF9NTUFQIGlzIG5vdCBzZXQKQ09ORklHX0hBTkdDSEVDS19USU1FUj1t
CiMgQ09ORklHX1RDR19UUE0gaXMgbm90IHNldAojIENPTkZJR19URUxDTE9DSyBpcyBub3Qgc2V0
CkNPTkZJR19ERVZQT1JUPXkKQ09ORklHX0kyQz1tCkNPTkZJR19JMkNfQk9BUkRJTkZPPXkKQ09O
RklHX0kyQ19DSEFSREVWPW0KCiMKIyBJMkMgQWxnb3JpdGhtcwojCkNPTkZJR19JMkNfQUxHT0JJ
VD1tCiMgQ09ORklHX0kyQ19BTEdPUENGIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMR09QQ0Eg
aXMgbm90IHNldAoKIwojIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19B
TEkxNTM1IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJ
R19JMkNfQUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAoj
IENPTkZJR19JMkNfQU1EODExMSBpcyBub3Qgc2V0CkNPTkZJR19JMkNfSTgwMT1tCiMgQ09ORklH
X0kyQ19JODEwIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19QSUlYND1tCiMgQ09ORklHX0kyQ19ORk9S
Q0UyIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX09DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19QQVJQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElHSFQgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfUFJPU0FWQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NBVkFHRTQg
aXMgbm90IHNldAojIENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0N4MjAw
X0FDQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1NJUzYzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM5NlggaXMgbm90IHNldAojIENP
TkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNldAojIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19USU5ZX1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUEgaXMgbm90
IHNldAojIENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZPT0RPTzMg
aXMgbm90IHNldAojIENPTkZJR19JMkNfUENBX0lTQSBpcyBub3Qgc2V0CgojCiMgTWlzY2VsbGFu
ZW91cyBJMkMgQ2hpcCBzdXBwb3J0CiMKIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBzZXQKQ09ORklH
X1NFTlNPUlNfRUVQUk9NPW0KIyBDT05GSUdfU0VOU09SU19QQ0Y4NTc0IGlzIG5vdCBzZXQKIyBD
T05GSUdfUENGODU3NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENGODU5MSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RQUzY1MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVg2ODc1
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
Q0hJUCBpcyBub3Qgc2V0CgojCiMgU1BJIHN1cHBvcnQKIwojIENPTkZJR19TUEkgaXMgbm90IHNl
dAojIENPTkZJR19TUElfTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVzEgaXMgbm90IHNldApD
T05GSUdfUE9XRVJfU1VQUExZPXkKIyBDT05GSUdfUE9XRVJfU1VQUExZX0RFQlVHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUERBX1BPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3NjAg
aXMgbm90IHNldApDT05GSUdfSFdNT049eQojIENPTkZJR19IV01PTl9WSUQgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0FCSVRVR1VSVSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUJJ
VFVHVVJVMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUQ3NDE4IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19BRE0xMDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI1
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI2IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19BRE0xMDI5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDMxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE05MjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BRFQ3NDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDczIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19LOFRFTVAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQjEw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVRYUDEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0RTMTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSTVLX0FNQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfRjcxODA1RiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
RjcxODgyRkcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3NTM3NVMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0ZTQ0hFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlNDUE9T
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GU0NITUQgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0dMNTE4U00gaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00gaXMgbm90
IHNldApDT05GSUdfU0VOU09SU19DT1JFVEVNUD1tCiMgQ09ORklHX1NFTlNPUlNfSUJNUEVYIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JVDg3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19MTTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc1IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19MTTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MTTgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgz
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTg3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkzIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19NQVg2NjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3MzYwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19QQzg3NDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1
NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ETUUxNzM3IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19TTVNDNDdNMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTE5
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3QjM5NyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQURTNzgyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVEhNQzUwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19WSUE2ODZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19WVDEyMTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZUODIzMSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfVzgzNzgxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgz
NzkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzNzkyRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfVzgzNzkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4M0w3ODZORyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfVzgzNjI3SEYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1c4MzYyN0VIRiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSERBUFMgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FQUExFU01DIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdNT05fREVCVUdfQ0hJUCBpcyBub3Qg
c2V0CkNPTkZJR19USEVSTUFMPXkKQ09ORklHX1dBVENIRE9HPXkKIyBDT05GSUdfV0FUQ0hET0df
Tk9XQVlPVVQgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIERldmljZSBEcml2ZXJzCiMKQ09ORklH
X1NPRlRfV0FUQ0hET0c9bQojIENPTkZJR19BQ1FVSVJFX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0FEVkFOVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNMTUzNV9XRFQgaXMgbm90IHNl
dAojIENPTkZJR19BTElNNzEwMV9XRFQgaXMgbm90IHNldAojIENPTkZJR19TQzUyMF9XRFQgaXMg
bm90IHNldAojIENPTkZJR19FVVJPVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19JQjcwMF9X
RFQgaXMgbm90IHNldAojIENPTkZJR19JQk1BU1IgaXMgbm90IHNldAojIENPTkZJR19XQUZFUl9X
RFQgaXMgbm90IHNldApDT05GSUdfSTYzMDBFU0JfV0RUPW0KQ09ORklHX0lUQ09fV0RUPW0KQ09O
RklHX0lUQ09fVkVORE9SX1NVUFBPUlQ9eQojIENPTkZJR19JVDg3MTJGX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hQX1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfU0MxMjAwX1dEVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BDODc0MTNfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfNjBYWF9XRFQg
aXMgbm90IHNldAojIENPTkZJR19TQkM4MzYwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NCQzcy
NDBfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BVNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19T
TVNDMzdCNzg3X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4MzYyN0hGX1dEVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1c4MzY5N0hGX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4Mzg3N0ZfV0RUIGlz
IG5vdCBzZXQKIyBDT05GSUdfVzgzOTc3Rl9XRFQgaXMgbm90IHNldAojIENPTkZJR19NQUNIWl9X
RFQgaXMgbm90IHNldAojIENPTkZJR19TQkNfRVBYX0MzX1dBVENIRE9HIGlzIG5vdCBzZXQKCiMK
IyBJU0EtYmFzZWQgV2F0Y2hkb2cgQ2FyZHMKIwojIENPTkZJR19QQ1dBVENIRE9HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUlYQ09NV0QgaXMgbm90IHNldAojIENPTkZJR19XRFQgaXMgbm90IHNldAoK
IwojIFBDSS1iYXNlZCBXYXRjaGRvZyBDYXJkcwojCiMgQ09ORklHX1BDSVBDV0FUQ0hET0cgaXMg
bm90IHNldAojIENPTkZJR19XRFRQQ0kgaXMgbm90IHNldAoKIwojIFVTQi1iYXNlZCBXYXRjaGRv
ZyBDYXJkcwojCiMgQ09ORklHX1VTQlBDV0FUQ0hET0cgaXMgbm90IHNldAoKIwojIFNvbmljcyBT
aWxpY29uIEJhY2twbGFuZQojCkNPTkZJR19TU0JfUE9TU0lCTEU9eQojIENPTkZJR19TU0IgaXMg
bm90IHNldAoKIwojIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKIwojIENPTkZJR19NRkRf
U001MDEgaXMgbm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCkNPTkZJR19WSURFT19E
RVY9bQpDT05GSUdfVklERU9fVjRMMl9DT01NT049bQpDT05GSUdfVklERU9fVjRMMT15CkNPTkZJ
R19WSURFT19WNEwxX0NPTVBBVD15CkNPTkZJR19WSURFT19WNEwyPXkKIyBDT05GSUdfVklERU9f
Q0FQVFVSRV9EUklWRVJTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFESU9fQURBUFRFUlMgaXMgbm90
IHNldAojIENPTkZJR19EVkJfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RBQiBpcyBub3Qgc2V0
CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCkNPTkZJR19BR1A9eQpDT05GSUdfQUdQX0FMST15CkNP
TkZJR19BR1BfQVRJPXkKQ09ORklHX0FHUF9BTUQ9eQpDT05GSUdfQUdQX0FNRDY0PXkKQ09ORklH
X0FHUF9JTlRFTD15CkNPTkZJR19BR1BfTlZJRElBPXkKQ09ORklHX0FHUF9TSVM9eQpDT05GSUdf
QUdQX1NXT1JLUz15CkNPTkZJR19BR1BfVklBPXkKQ09ORklHX0FHUF9FRkZJQ0VPTj15CkNPTkZJ
R19EUk09bQpDT05GSUdfRFJNX1RERlg9bQpDT05GSUdfRFJNX1IxMjg9bQpDT05GSUdfRFJNX1JB
REVPTj1tCkNPTkZJR19EUk1fSTgxMD1tCkNPTkZJR19EUk1fSTgzMD1tCkNPTkZJR19EUk1fSTkx
NT1tCkNPTkZJR19EUk1fTUdBPW0KQ09ORklHX0RSTV9TSVM9bQpDT05GSUdfRFJNX1ZJQT1tCkNP
TkZJR19EUk1fU0FWQUdFPW0KQ09ORklHX1ZHQVNUQVRFPW0KQ09ORklHX1ZJREVPX09VVFBVVF9D
T05UUk9MPW0KQ09ORklHX0ZCPXkKIyBDT05GSUdfRklSTVdBUkVfRURJRCBpcyBub3Qgc2V0CkNP
TkZJR19GQl9EREM9bQpDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUPXkKQ09ORklHX0ZCX0NGQl9DT1BZ
QVJFQT15CkNPTkZJR19GQl9DRkJfSU1BR0VCTElUPXkKIyBDT05GSUdfRkJfQ0ZCX1JFVl9QSVhF
TFNfSU5fQllURSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NZU19GSUxMUkVDVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1NZU19DT1BZQVJFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NZU19JTUFH
RUJMSVQgaXMgbm90IHNldAojIENPTkZJR19GQl9TWVNfRk9QUyBpcyBub3Qgc2V0CkNPTkZJR19G
Ql9ERUZFUlJFRF9JTz15CiMgQ09ORklHX0ZCX1NWR0FMSUIgaXMgbm90IHNldAojIENPTkZJR19G
Ql9NQUNNT0RFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0JBQ0tMSUdIVCBpcyBub3Qgc2V0CkNP
TkZJR19GQl9NT0RFX0hFTFBFUlM9eQpDT05GSUdfRkJfVElMRUJMSVRUSU5HPXkKCiMKIyBGcmFt
ZSBidWZmZXIgaGFyZHdhcmUgZHJpdmVycwojCiMgQ09ORklHX0ZCX0NJUlJVUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1BNMiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NZQkVSMjAwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FTSUxJQU5UIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfSU1TVFQgaXMgbm90IHNldApDT05GSUdfRkJfVkdBMTY9bQojIENP
TkZJR19GQl9VVkVTQSBpcyBub3Qgc2V0CkNPTkZJR19GQl9WRVNBPXkKIyBDT05GSUdfRkJfRUZJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSU1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0hFQ1VC
QSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0hHQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MxRDEz
WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
UklWQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0k4MTAgaXMgbm90IHNldAojIENPTkZJR19GQl9M
RTgwNTc4IGlzIG5vdCBzZXQKQ09ORklHX0ZCX0lOVEVMPW0KIyBDT05GSUdfRkJfSU5URUxfREVC
VUcgaXMgbm90IHNldApDT05GSUdfRkJfSU5URUxfSTJDPXkKIyBDT05GSUdfRkJfTUFUUk9YIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVRZMTI4
IGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUzMgaXMg
bm90IHNldAojIENPTkZJR19GQl9TQVZBR0UgaXMgbm90IHNldAojIENPTkZJR19GQl9TSVMgaXMg
bm90IHNldAojIENPTkZJR19GQl9ORU9NQUdJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0tZUk8g
aXMgbm90IHNldAojIENPTkZJR19GQl8zREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVk9PRE9P
MSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZUODYyMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NZ
QkxBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X0FSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1BNMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0dF
T0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVklSVFVBTCBpcyBub3Qgc2V0CkNPTkZJR19CQUNL
TElHSFRfTENEX1NVUFBPUlQ9eQpDT05GSUdfTENEX0NMQVNTX0RFVklDRT1tCkNPTkZJR19CQUNL
TElHSFRfQ0xBU1NfREVWSUNFPXkKIyBDT05GSUdfQkFDS0xJR0hUX0NPUkdJIGlzIG5vdCBzZXQK
Q09ORklHX0JBQ0tMSUdIVF9QUk9HRUFSPW0KCiMKIyBEaXNwbGF5IGRldmljZSBzdXBwb3J0CiMK
Q09ORklHX0RJU1BMQVlfU1VQUE9SVD1tCgojCiMgRGlzcGxheSBoYXJkd2FyZSBkcml2ZXJzCiMK
CiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9
eQpDT05GSUdfVkdBQ09OX1NPRlRfU0NST0xMQkFDSz15CkNPTkZJR19WR0FDT05fU09GVF9TQ1JP
TExCQUNLX1NJWkU9NjQKQ09ORklHX1ZJREVPX1NFTEVDVD15CiMgQ09ORklHX01EQV9DT05TT0xF
IGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQpDT05GSUdfRlJBTUVCVUZGRVJfQ09O
U09MRT15CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFVEVDVF9QUklNQVJZPXkKQ09ORklH
X0ZSQU1FQlVGRkVSX0NPTlNPTEVfUk9UQVRJT049eQojIENPTkZJR19GT05UUyBpcyBub3Qgc2V0
CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05UXzh4MTY9eQpDT05GSUdfTE9HTz15CiMgQ09O
RklHX0xPR09fTElOVVhfTU9OTyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPR09fTElOVVhfVkdBMTYg
aXMgbm90IHNldApDT05GSUdfTE9HT19MSU5VWF9DTFVUMjI0PXkKCiMKIyBTb3VuZAojCkNPTkZJ
R19TT1VORD1tCgojCiMgQWR2YW5jZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlCiMKQ09ORklH
X1NORD1tCkNPTkZJR19TTkRfVElNRVI9bQpDT05GSUdfU05EX1BDTT1tCkNPTkZJR19TTkRfSFdE
RVA9bQpDT05GSUdfU05EX1JBV01JREk9bQpDT05GSUdfU05EX1NFUVVFTkNFUj1tCkNPTkZJR19T
TkRfU0VRX0RVTU1ZPW0KQ09ORklHX1NORF9PU1NFTVVMPXkKQ09ORklHX1NORF9NSVhFUl9PU1M9
bQpDT05GSUdfU05EX1BDTV9PU1M9bQpDT05GSUdfU05EX1BDTV9PU1NfUExVR0lOUz15CkNPTkZJ
R19TTkRfU0VRVUVOQ0VSX09TUz15CkNPTkZJR19TTkRfUlRDVElNRVI9bQpDT05GSUdfU05EX1NF
UV9SVENUSU1FUl9ERUZBVUxUPXkKQ09ORklHX1NORF9EWU5BTUlDX01JTk9SUz15CiMgQ09ORklH
X1NORF9TVVBQT1JUX09MRF9BUEkgaXMgbm90IHNldApDT05GSUdfU05EX1ZFUkJPU0VfUFJPQ0ZT
PXkKIyBDT05GSUdfU05EX1ZFUkJPU0VfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RF
QlVHIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIGRldmljZXMKIwpDT05GSUdfU05EX09QTDNfTElC
PW0KQ09ORklHX1NORF9BQzk3X0NPREVDPW0KQ09ORklHX1NORF9EVU1NWT1tCiMgQ09ORklHX1NO
RF9WSVJNSURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01UUEFWIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX01UUzY0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NFUklBTF9VMTY1NTAgaXMgbm90
IHNldAojIENPTkZJR19TTkRfTVBVNDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1BPUlRNQU4y
WDQgaXMgbm90IHNldAoKIwojIElTQSBkZXZpY2VzCiMKQ09ORklHX1NORF9BRExJQj1tCiMgQ09O
RklHX1NORF9BRDE4MTZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FEMTg0OCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9BTFMxMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVpUMjMyMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9DTUk4MzMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDIz
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQyMzIgaXMgbm90IHNldAojIENPTkZJR19TTkRf
Q1M0MjM2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RUMDE5WCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9FUzk2OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE2ODggaXMgbm90IHNldAojIENP
TkZJR19TTkRfRVMxOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NDNjAwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9HVVNDTEFTU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0dVU0VYVFJF
TUUgaXMgbm90IHNldAojIENPTkZJR19TTkRfR1VTTUFYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0lOVEVSV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFUldBVkVfU1RCIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX09QTDNTQTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfT1BUSTkyWF9B
RDE4NDggaXMgbm90IHNldAojIENPTkZJR19TTkRfT1BUSTkyWF9DUzQyMzEgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfT1BUSTkzWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NSVJPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1NCOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TQjE2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1NCQVdFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NHQUxBWFkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU1NDQVBFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1dBVkVG
Uk9OVCBpcyBub3Qgc2V0CgojCiMgUENJIGRldmljZXMKIwojIENPTkZJR19TTkRfQUQxODg5IGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0FMUzMwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BTFM0
MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMSTU0NTEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlYUF9NT0RFTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9BVTg4MTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODIwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0FVODgzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BWlQzMzI4
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0JUODdYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NB
MDEwNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DTUlQQ0kgaXMgbm90IHNldAojIENPTkZJR19T
TkRfT1hZR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDI4MSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9DUzQ2WFggaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M1NTMwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0NTNTUzNUFVRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RBUkxBMjAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0xB
WUxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfREFSTEEyNCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9HSU5BMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTEFZTEEyNCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9NT05BIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JQSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9FQ0hPM0cgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0lORElHT0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0RK
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEwSzEgaXMgbm90IHNldAojIENPTkZJR19TTkRf
RU1VMTBLMVggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5TMTM3MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9FTlMxMzcxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTkzOCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9FUzE5NjggaXMgbm90IHNldAojIENPTkZJR19TTkRfRk04MDEgaXMgbm90
IHNldApDT05GSUdfU05EX0hEQV9JTlRFTD1tCkNPTkZJR19TTkRfSERBX0hXREVQPXkKQ09ORklH
X1NORF9IREFfQ09ERUNfUkVBTFRFSz15CkNPTkZJR19TTkRfSERBX0NPREVDX0FOQUxPRz15CkNP
TkZJR19TTkRfSERBX0NPREVDX1NJR01BVEVMPXkKQ09ORklHX1NORF9IREFfQ09ERUNfVklBPXkK
Q09ORklHX1NORF9IREFfQ09ERUNfQVRJSERNST15CkNPTkZJR19TTkRfSERBX0NPREVDX0NPTkVY
QU5UPXkKQ09ORklHX1NORF9IREFfQ09ERUNfQ01FRElBPXkKQ09ORklHX1NORF9IREFfQ09ERUNf
U0kzMDU0PXkKQ09ORklHX1NORF9IREFfR0VORVJJQz15CkNPTkZJR19TTkRfSERBX1BPV0VSX1NB
VkU9eQpDT05GSUdfU05EX0hEQV9QT1dFUl9TQVZFX0RFRkFVTFQ9MAojIENPTkZJR19TTkRfSERT
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9I
SUZJRVIgaXMgbm90IHNldAojIENPTkZJR19TTkRfSUNFMTcxMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9JQ0UxNzI0IGlzIG5vdCBzZXQKQ09ORklHX1NORF9JTlRFTDhYMD1tCkNPTkZJR19TTkRf
SU5URUw4WDBNPW0KIyBDT05GSUdfU05EX0tPUkcxMjEyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X01BRVNUUk8zIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01JWEFSVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9OTTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9QQ1hIUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9SSVBUSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2NTIgaXMg
bm90IHNldAojIENPTkZJR19TTkRfU0lTNzAxOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TT05J
Q1ZJQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYX01PREVNIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1ZJUlRVT1NPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZYMjIy
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CkNPTkZJR19TTkRfQUM5
N19QT1dFUl9TQVZFPXkKQ09ORklHX1NORF9BQzk3X1BPV0VSX1NBVkVfREVGQVVMVD0wCgojCiMg
VVNCIGRldmljZXMKIwpDT05GSUdfU05EX1VTQl9BVURJTz1tCiMgQ09ORklHX1NORF9VU0JfVVNY
MlkgaXMgbm90IHNldAojIENPTkZJR19TTkRfVVNCX0NBSUFRIGlzIG5vdCBzZXQKCiMKIyBTeXN0
ZW0gb24gQ2hpcCBhdWRpbyBzdXBwb3J0CiMKIyBDT05GSUdfU05EX1NPQyBpcyBub3Qgc2V0Cgoj
CiMgU29DIEF1ZGlvIHN1cHBvcnQgZm9yIFN1cGVySAojCgojCiMgQUxTQSBTb0MgYXVkaW8gZm9y
IEZyZWVzY2FsZSBTT0NzCiMKCiMKIyBPcGVuIFNvdW5kIFN5c3RlbQojCiMgQ09ORklHX1NPVU5E
X1BSSU1FIGlzIG5vdCBzZXQKQ09ORklHX0FDOTdfQlVTPW0KQ09ORklHX0hJRF9TVVBQT1JUPXkK
Q09ORklHX0hJRD15CkNPTkZJR19ISURfREVCVUc9eQojIENPTkZJR19ISURSQVcgaXMgbm90IHNl
dAoKIwojIFVTQiBJbnB1dCBEZXZpY2VzCiMKQ09ORklHX1VTQl9ISUQ9eQpDT05GSUdfVVNCX0hJ
RElOUFVUX1BPV0VSQk9PSz15CkNPTkZJR19ISURfRkY9eQpDT05GSUdfSElEX1BJRD15CkNPTkZJ
R19MT0dJVEVDSF9GRj15CkNPTkZJR19QQU5USEVSTE9SRF9GRj15CkNPTkZJR19USFJVU1RNQVNU
RVJfRkY9eQpDT05GSUdfWkVST1BMVVNfRkY9eQpDT05GSUdfVVNCX0hJRERFVj15CkNPTkZJR19V
U0JfU1VQUE9SVD15CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkKQ09ORklHX1VTQl9BUkNIX0hB
U19PSENJPXkKQ09ORklHX1VTQl9BUkNIX0hBU19FSENJPXkKQ09ORklHX1VTQj15CiMgQ09ORklH
X1VTQl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BTk5PVU5DRV9ORVdfREVWSUNFUyBp
cyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVW
SUNFRlM9eQojIENPTkZJR19VU0JfREVWSUNFX0NMQVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TVVNQRU5EPXkKIyBDT05GSUdf
VVNCX1BFUlNJU1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfT1RHIGlzIG5vdCBzZXQKCiMKIyBV
U0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwpDT05GSUdfVVNCX0VIQ0lfSENEPW0KQ09ORklH
X1VTQl9FSENJX1JPT1RfSFVCX1RUPXkKQ09ORklHX1VTQl9FSENJX1RUX05FV1NDSEVEPXkKIyBD
T05GSUdfVVNCX0lTUDExNlhfSENEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9PSENJX0hDRD1tCiMg
Q09ORklHX1VTQl9PSENJX0JJR19FTkRJQU5fREVTQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9P
SENJX0JJR19FTkRJQU5fTU1JTyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5E
SUFOPXkKQ09ORklHX1VTQl9VSENJX0hDRD1tCiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfUjhBNjY1OTdfSENEIGlzIG5vdCBzZXQKCiMKIyBVU0IgRGV2aWNl
IENsYXNzIGRyaXZlcnMKIwpDT05GSUdfVVNCX0FDTT1tCkNPTkZJR19VU0JfUFJJTlRFUj1tCgoj
CiMgTk9URTogVVNCX1NUT1JBR0UgZW5hYmxlcyBTQ1NJLCBhbmQgJ1NDU0kgZGlzayBzdXBwb3J0
JwojCgojCiMgbWF5IGFsc28gYmUgbmVlZGVkOyBzZWUgVVNCX1NUT1JBR0UgSGVscCBmb3IgbW9y
ZSBpbmZvcm1hdGlvbgojCkNPTkZJR19VU0JfU1RPUkFHRT1tCiMgQ09ORklHX1VTQl9TVE9SQUdF
X0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUI9eQpDT05GSUdfVVNC
X1NUT1JBR0VfRlJFRUNPTT15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qgc2V0
CkNPTkZJR19VU0JfU1RPUkFHRV9EUENNPXkKQ09ORklHX1VTQl9TVE9SQUdFX1VTQkFUPXkKQ09O
RklHX1VTQl9TVE9SQUdFX1NERFIwOT15CkNPTkZJR19VU0JfU1RPUkFHRV9TRERSNTU9eQpDT05G
SUdfVVNCX1NUT1JBR0VfSlVNUFNIT1Q9eQpDT05GSUdfVVNCX1NUT1JBR0VfQUxBVURBPXkKQ09O
RklHX1VTQl9TVE9SQUdFX0tBUk1BPXkKIyBDT05GSUdfVVNCX0xJQlVTVUFMIGlzIG5vdCBzZXQK
CiMKIyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfTU9OPXkKCiMKIyBV
U0IgcG9ydCBkcml2ZXJzCiMKQ09ORklHX1VTQl9VU1M3MjA9bQpDT05GSUdfVVNCX1NFUklBTD1t
CkNPTkZJR19VU0JfRVpVU0I9eQpDT05GSUdfVVNCX1NFUklBTF9HRU5FUklDPXkKQ09ORklHX1VT
Ql9TRVJJQUxfQUlSQ0FCTEU9bQpDT05GSUdfVVNCX1NFUklBTF9BSVJQUklNRT1tCkNPTkZJR19V
U0JfU0VSSUFMX0FSSzMxMTY9bQpDT05GSUdfVVNCX1NFUklBTF9CRUxLSU49bQojIENPTkZJR19V
U0JfU0VSSUFMX0NIMzQxIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFUPW0K
Q09ORklHX1VTQl9TRVJJQUxfRElHSV9BQ0NFTEVQT1JUPW0KQ09ORklHX1VTQl9TRVJJQUxfQ1Ay
MTAxPW0KQ09ORklHX1VTQl9TRVJJQUxfQ1lQUkVTU19NOD1tCkNPTkZJR19VU0JfU0VSSUFMX0VN
UEVHPW0KQ09ORklHX1VTQl9TRVJJQUxfRlRESV9TSU89bQpDT05GSUdfVVNCX1NFUklBTF9GVU5T
T0ZUPW0KQ09ORklHX1VTQl9TRVJJQUxfVklTT1I9bQpDT05GSUdfVVNCX1NFUklBTF9JUEFRPW0K
Q09ORklHX1VTQl9TRVJJQUxfSVI9bQpDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVD1tCkNPTkZJ
R19VU0JfU0VSSUFMX0VER0VQT1JUX1RJPW0KQ09ORklHX1VTQl9TRVJJQUxfR0FSTUlOPW0KQ09O
RklHX1VTQl9TRVJJQUxfSVBXPW0KIyBDT05GSUdfVVNCX1NFUklBTF9JVVUgaXMgbm90IHNldApD
T05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1BEQT1tCkNPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU49
bQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX01QUj15CkNPTkZJR19VU0JfU0VSSUFMX0tFWVNQ
QU5fVVNBMjg9eQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WD15CkNPTkZJR19VU0Jf
U0VSSUFMX0tFWVNQQU5fVVNBMjhYQT15CkNPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMjhY
Qj15CkNPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMTk9eQpDT05GSUdfVVNCX1NFUklBTF9L
RVlTUEFOX1VTQTE4WD15CkNPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMTlXPXkKQ09ORklH
X1VTQl9TRVJJQUxfS0VZU1BBTl9VU0ExOVFXPXkKQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9V
U0ExOVFJPXkKQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0E0OVc9eQpDT05GSUdfVVNCX1NF
UklBTF9LRVlTUEFOX1VTQTQ5V0xDPXkKQ09ORklHX1VTQl9TRVJJQUxfS0xTST1tCkNPTkZJR19V
U0JfU0VSSUFMX0tPQklMX1NDVD1tCkNPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyPW0KQ09ORklH
X1VTQl9TRVJJQUxfTU9TNzcyMD1tCkNPTkZJR19VU0JfU0VSSUFMX01PUzc4NDA9bQpDT05GSUdf
VVNCX1NFUklBTF9OQVZNQU49bQpDT05GSUdfVVNCX1NFUklBTF9QTDIzMDM9bQpDT05GSUdfVVNC
X1NFUklBTF9PVEk2ODU4PW0KQ09ORklHX1VTQl9TRVJJQUxfSFA0WD1tCkNPTkZJR19VU0JfU0VS
SUFMX1NBRkU9bQpDT05GSUdfVVNCX1NFUklBTF9TQUZFX1BBRERFRD15CkNPTkZJR19VU0JfU0VS
SUFMX1NJRVJSQVdJUkVMRVNTPW0KQ09ORklHX1VTQl9TRVJJQUxfVEk9bQpDT05GSUdfVVNCX1NF
UklBTF9DWUJFUkpBQ0s9bQpDT05GSUdfVVNCX1NFUklBTF9YSVJDT009bQpDT05GSUdfVVNCX1NF
UklBTF9PUFRJT049bQpDT05GSUdfVVNCX1NFUklBTF9PTU5JTkVUPW0KQ09ORklHX1VTQl9TRVJJ
QUxfREVCVUc9bQoKIwojIFVTQiBNaXNjZWxsYW5lb3VzIGRyaXZlcnMKIwpDT05GSUdfVVNCX0VN
STYyPW0KQ09ORklHX1VTQl9FTUkyNj1tCiMgQ09ORklHX1VTQl9BRFVUVVggaXMgbm90IHNldAoj
IENPTkZJR19VU0JfQVVFUlNXQUxEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JJTzUwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9MRUdPVE9XRVIgaXMgbm90IHNldApDT05GSUdfVVNCX0xDRD1t
CkNPTkZJR19VU0JfQkVSUllfQ0hBUkdFPW0KQ09ORklHX1VTQl9MRUQ9bQojIENPTkZJR19VU0Jf
Q1lQUkVTU19DWTdDNjMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lUSEVSTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9QSElER0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lETU9VU0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfRlRESV9FTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FQ
UExFRElTUExBWSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0lTVVNCVkdBPW0KQ09ORklHX1VTQl9T
SVNVU0JWR0FfQ09OPXkKQ09ORklHX1VTQl9MRD1tCiMgQ09ORklHX1VTQl9UUkFOQ0VWSUJSQVRP
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JT1dBUlJJT1IgaXMgbm90IHNldAojIENPTkZJR19V
U0JfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90IHNldApDT05GSUdf
TU1DPW0KIyBDT05GSUdfTU1DX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1VOU0FGRV9S
RVNVTUUgaXMgbm90IHNldAoKIwojIE1NQy9TRCBDYXJkIERyaXZlcnMKIwpDT05GSUdfTU1DX0JM
T0NLPW0KQ09ORklHX01NQ19CTE9DS19CT1VOQ0U9eQojIENPTkZJR19TRElPX1VBUlQgaXMgbm90
IHNldAoKIwojIE1NQy9TRCBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCkNPTkZJR19NTUNfU0RI
Q0k9bQojIENPTkZJR19NTUNfUklDT0hfTU1DIGlzIG5vdCBzZXQKQ09ORklHX01NQ19XQlNEPW0K
Q09ORklHX01NQ19USUZNX1NEPW0KIyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldApDT05GSUdf
TkVXX0xFRFM9eQpDT05GSUdfTEVEU19DTEFTUz15CgojCiMgTEVEIGRyaXZlcnMKIwojIENPTkZJ
R19MRURTX0NMRVZPX01BSUwgaXMgbm90IHNldAoKIwojIExFRCBUcmlnZ2VycwojCkNPTkZJR19M
RURTX1RSSUdHRVJTPXkKQ09ORklHX0xFRFNfVFJJR0dFUl9USU1FUj1tCkNPTkZJR19MRURTX1RS
SUdHRVJfSEVBUlRCRUFUPW0KIyBDT05GSUdfSU5GSU5JQkFORCBpcyBub3Qgc2V0CkNPTkZJR19F
REFDPXkKCiMKIyBSZXBvcnRpbmcgc3Vic3lzdGVtcwojCiMgQ09ORklHX0VEQUNfREVCVUcgaXMg
bm90IHNldApDT05GSUdfRURBQ19NTV9FREFDPW0KQ09ORklHX0VEQUNfQU1ENzZYPW0KQ09ORklH
X0VEQUNfRTdYWFg9bQpDT05GSUdfRURBQ19FNzUyWD1tCkNPTkZJR19FREFDX0k4Mjg3NVA9bQpD
T05GSUdfRURBQ19JODI5NzVYPW0KQ09ORklHX0VEQUNfSTMwMDA9bQpDT05GSUdfRURBQ19JODI4
NjA9bQpDT05GSUdfRURBQ19SODI2MDA9bQpDT05GSUdfRURBQ19JNTAwMD1tCiMgQ09ORklHX1JU
Q19DTEFTUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQURFVklDRVMgaXMgbm90IHNldAojIENPTkZJ
R19BVVhESVNQTEFZIGlzIG5vdCBzZXQKCiMKIyBVc2Vyc3BhY2UgSS9PCiMKQ09ORklHX1VJTz1t
CkNPTkZJR19VSU9fQ0lGPW0KCiMKIyBGaXJtd2FyZSBEcml2ZXJzCiMKQ09ORklHX0VERD1tCkNP
TkZJR19FRklfVkFSUz15CkNPTkZJR19ERUxMX1JCVT1tCkNPTkZJR19EQ0RCQVM9bQpDT05GSUdf
RE1JSUQ9eQoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPW0KQ09ORklHX0VYVDJf
RlNfWEFUVFI9eQpDT05GSUdfRVhUMl9GU19QT1NJWF9BQ0w9eQpDT05GSUdfRVhUMl9GU19TRUNV
UklUWT15CkNPTkZJR19FWFQyX0ZTX1hJUD15CkNPTkZJR19GU19YSVA9eQpDT05GSUdfRVhUM19G
Uz1tCkNPTkZJR19FWFQzX0ZTX1hBVFRSPXkKQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMPXkKQ09O
RklHX0VYVDNfRlNfU0VDVVJJVFk9eQojIENPTkZJR19FWFQ0REVWX0ZTIGlzIG5vdCBzZXQKQ09O
RklHX0pCRD1tCiMgQ09ORklHX0pCRF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19GU19NQkNBQ0hF
PW0KIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRlNfRlMgaXMgbm90
IHNldApDT05GSUdfRlNfUE9TSVhfQUNMPXkKIyBDT05GSUdfWEZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlzIG5vdCBzZXQKQ09O
RklHX0ROT1RJRlk9eQpDT05GSUdfSU5PVElGWT15CkNPTkZJR19JTk9USUZZX1VTRVI9eQpDT05G
SUdfUVVPVEE9eQojIENPTkZJR19RVU9UQV9ORVRMSU5LX0lOVEVSRkFDRSBpcyBub3Qgc2V0CkNP
TkZJR19QUklOVF9RVU9UQV9XQVJOSU5HPXkKIyBDT05GSUdfUUZNVF9WMSBpcyBub3Qgc2V0CkNP
TkZJR19RRk1UX1YyPXkKQ09ORklHX1FVT1RBQ1RMPXkKQ09ORklHX0FVVE9GU19GUz1tCkNPTkZJ
R19BVVRPRlM0X0ZTPW0KQ09ORklHX0ZVU0VfRlM9bQpDT05GSUdfR0VORVJJQ19BQ0w9eQoKIwoj
IENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJ
RVQ9eQpDT05GSUdfWklTT0ZTPXkKQ09ORklHX1VERl9GUz1tCkNPTkZJR19VREZfTkxTPXkKCiMK
IyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZBVF9GUz1tCkNPTkZJR19NU0RPU19G
Uz1tCkNPTkZJR19WRkFUX0ZTPW0KQ09ORklHX0ZBVF9ERUZBVUxUX0NPREVQQUdFPTQzNwpDT05G
SUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJhc2NpaSIKIyBDT05GSUdfTlRGU19GUyBpcyBub3Qg
c2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJP
Q19LQ09SRT15CkNPTkZJR19QUk9DX1ZNQ09SRT15CkNPTkZJR19QUk9DX1NZU0NUTD15CkNPTkZJ
R19TWVNGUz15CkNPTkZJR19UTVBGUz15CkNPTkZJR19UTVBGU19QT1NJWF9BQ0w9eQpDT05GSUdf
SFVHRVRMQkZTPXkKQ09ORklHX0hVR0VUTEJfUEFHRT15CkNPTkZJR19DT05GSUdGU19GUz1tCgoj
CiMgTWlzY2VsbGFuZW91cyBmaWxlc3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19BRkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNSWVBUX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRkZTMl9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSQU1GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldApDT05GSUdfUk9NRlNfRlM9bQojIENPTkZJR19T
WVNWX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX05FVFdP
UktfRklMRVNZU1RFTVM9eQpDT05GSUdfTkZTX0ZTPW0KQ09ORklHX05GU19WMz15CkNPTkZJR19O
RlNfVjNfQUNMPXkKQ09ORklHX05GU19WND15CiMgQ09ORklHX05GU19ESVJFQ1RJTyBpcyBub3Qg
c2V0CkNPTkZJR19ORlNEPW0KQ09ORklHX05GU0RfVjJfQUNMPXkKQ09ORklHX05GU0RfVjM9eQpD
T05GSUdfTkZTRF9WM19BQ0w9eQpDT05GSUdfTkZTRF9WND15CkNPTkZJR19ORlNEX1RDUD15CkNP
TkZJR19MT0NLRD1tCkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19FWFBPUlRGUz1tCkNPTkZJR19O
RlNfQUNMX1NVUFBPUlQ9bQpDT05GSUdfTkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9bQpDT05G
SUdfU1VOUlBDX0dTUz1tCkNPTkZJR19TVU5SUENfQklORDM0PXkKQ09ORklHX1JQQ1NFQ19HU1Nf
S1JCNT1tCkNPTkZJR19SUENTRUNfR1NTX1NQS00zPW0KIyBDT05GSUdfU01CX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0NJRlM9bQojIENPTkZJR19DSUZTX1NUQVRTIGlzIG5vdCBzZXQKQ09ORklHX0NJ
RlNfV0VBS19QV19IQVNIPXkKQ09ORklHX0NJRlNfWEFUVFI9eQpDT05GSUdfQ0lGU19QT1NJWD15
CiMgQ09ORklHX0NJRlNfREVCVUcyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGU19FWFBFUklNRU5U
QUwgaXMgbm90IHNldApDT05GSUdfTkNQX0ZTPW0KQ09ORklHX05DUEZTX1BBQ0tFVF9TSUdOSU5H
PXkKQ09ORklHX05DUEZTX0lPQ1RMX0xPQ0tJTkc9eQpDT05GSUdfTkNQRlNfU1RST05HPXkKQ09O
RklHX05DUEZTX05GU19OUz15CkNPTkZJR19OQ1BGU19PUzJfTlM9eQpDT05GSUdfTkNQRlNfU01B
TExET1M9eQpDT05GSUdfTkNQRlNfTkxTPXkKQ09ORklHX05DUEZTX0VYVFJBUz15CkNPTkZJR19D
T0RBX0ZTPW0KIyBDT05GSUdfQ09EQV9GU19PTERfQVBJIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZT
X0ZTIGlzIG5vdCBzZXQKCiMKIyBQYXJ0aXRpb24gVHlwZXMKIwpDT05GSUdfUEFSVElUSU9OX0FE
VkFOQ0VEPXkKIyBDT05GSUdfQUNPUk5fUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX09TRl9Q
QVJUSVRJT049eQpDT05GSUdfQU1JR0FfUEFSVElUSU9OPXkKIyBDT05GSUdfQVRBUklfUEFSVElU
SU9OIGlzIG5vdCBzZXQKQ09ORklHX01BQ19QQVJUSVRJT049eQpDT05GSUdfTVNET1NfUEFSVElU
SU9OPXkKQ09ORklHX0JTRF9ESVNLTEFCRUw9eQpDT05GSUdfTUlOSVhfU1VCUEFSVElUSU9OPXkK
Q09ORklHX1NPTEFSSVNfWDg2X1BBUlRJVElPTj15CkNPTkZJR19VTklYV0FSRV9ESVNLTEFCRUw9
eQojIENPTkZJR19MRE1fUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1NHSV9QQVJUSVRJT049
eQojIENPTkZJR19VTFRSSVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1NVTl9QQVJUSVRJ
T049eQpDT05GSUdfS0FSTUFfUEFSVElUSU9OPXkKQ09ORklHX0VGSV9QQVJUSVRJT049eQojIENP
TkZJR19TWVNWNjhfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX05MUz15CkNPTkZJR19OTFNf
REVGQVVMVD0idXRmOCIKQ09ORklHX05MU19DT0RFUEFHRV80Mzc9eQpDT05GSUdfTkxTX0NPREVQ
QUdFXzczNz1tCkNPTkZJR19OTFNfQ09ERVBBR0VfNzc1PW0KQ09ORklHX05MU19DT0RFUEFHRV84
NTA9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg1Mj1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODU1PW0K
Q09ORklHX05MU19DT0RFUEFHRV84NTc9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2MD1tCkNPTkZJ
R19OTFNfQ09ERVBBR0VfODYxPW0KQ09ORklHX05MU19DT0RFUEFHRV84NjI9bQpDT05GSUdfTkxT
X0NPREVQQUdFXzg2Mz1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODY0PW0KQ09ORklHX05MU19DT0RF
UEFHRV84NjU9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2Nj1tCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODY5PW0KQ09ORklHX05MU19DT0RFUEFHRV85MzY9bQpDT05GSUdfTkxTX0NPREVQQUdFXzk1MD1t
CkNPTkZJR19OTFNfQ09ERVBBR0VfOTMyPW0KQ09ORklHX05MU19DT0RFUEFHRV85NDk9bQpDT05G
SUdfTkxTX0NPREVQQUdFXzg3ND1tCkNPTkZJR19OTFNfSVNPODg1OV84PW0KQ09ORklHX05MU19D
T0RFUEFHRV8xMjUwPW0KQ09ORklHX05MU19DT0RFUEFHRV8xMjUxPW0KQ09ORklHX05MU19BU0NJ
ST15CkNPTkZJR19OTFNfSVNPODg1OV8xPW0KQ09ORklHX05MU19JU084ODU5XzI9bQpDT05GSUdf
TkxTX0lTTzg4NTlfMz1tCkNPTkZJR19OTFNfSVNPODg1OV80PW0KQ09ORklHX05MU19JU084ODU5
XzU9bQpDT05GSUdfTkxTX0lTTzg4NTlfNj1tCkNPTkZJR19OTFNfSVNPODg1OV83PW0KQ09ORklH
X05MU19JU084ODU5Xzk9bQpDT05GSUdfTkxTX0lTTzg4NTlfMTM9bQpDT05GSUdfTkxTX0lTTzg4
NTlfMTQ9bQpDT05GSUdfTkxTX0lTTzg4NTlfMTU9bQpDT05GSUdfTkxTX0tPSThfUj1tCkNPTkZJ
R19OTFNfS09JOF9VPW0KQ09ORklHX05MU19VVEY4PW0KQ09ORklHX0RMTT1tCkNPTkZJR19ETE1f
REVCVUc9eQoKIwojIEtlcm5lbCBoYWNraW5nCiMKQ09ORklHX1RSQUNFX0lSUUZMQUdTX1NVUFBP
UlQ9eQojIENPTkZJR19QUklOVEtfVElNRSBpcyBub3Qgc2V0CkNPTkZJR19FTkFCTEVfV0FSTl9E
RVBSRUNBVEVEPXkKQ09ORklHX0VOQUJMRV9NVVNUX0NIRUNLPXkKQ09ORklHX01BR0lDX1NZU1JR
PXkKIyBDT05GSUdfVU5VU0VEX1NZTUJPTFMgaXMgbm90IHNldApDT05GSUdfREVCVUdfRlM9eQpD
T05GSUdfSEVBREVSU19DSEVDSz15CkNPTkZJR19ERUJVR19LRVJORUw9eQpDT05GSUdfREVCVUdf
U0hJUlE9eQpDT05GSUdfREVURUNUX1NPRlRMT0NLVVA9eQpDT05GSUdfU0NIRURfREVCVUc9eQpD
T05GSUdfU0NIRURTVEFUUz15CkNPTkZJR19USU1FUl9TVEFUUz15CkNPTkZJR19TTFVCX0RFQlVH
X09OPXkKIyBDT05GSUdfU0xVQl9TVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JUX01V
VEVYRVMgaXMgbm90IHNldAojIENPTkZJR19SVF9NVVRFWF9URVNURVIgaXMgbm90IHNldApDT05G
SUdfREVCVUdfU1BJTkxPQ0s9eQpDT05GSUdfREVCVUdfTVVURVhFUz15CkNPTkZJR19ERUJVR19M
T0NLX0FMTE9DPXkKIyBDT05GSUdfUFJPVkVfTE9DS0lORyBpcyBub3Qgc2V0CkNPTkZJR19MT0NL
REVQPXkKIyBDT05GSUdfTE9DS19TVEFUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0RF
UCBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUD15CiMgQ09ORklHX0RFQlVH
X0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CkNPTkZJR19TVEFDS1RSQUNFPXkKIyBD
T05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19ISUdITUVNPXkKQ09O
RklHX0RFQlVHX0JVR1ZFUkJPU0U9eQpDT05GSUdfREVCVUdfSU5GTz15CiMgQ09ORklHX0RFQlVH
X1ZNIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0xJU1Q9eQojIENPTkZJR19ERUJVR19TRyBpcyBu
b3Qgc2V0CkNPTkZJR19GUkFNRV9QT0lOVEVSPXkKIyBDT05GSUdfQk9PVF9QUklOVEtfREVMQVkg
aXMgbm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
S1BST0JFU19TQU5JVFlfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tUUkFDRV9TRUxGX1RF
U1QgaXMgbm90IHNldAojIENPTkZJR19MS0RUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lO
SkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0xBVEVOQ1lUT1AgaXMgbm90IHNldAojIENPTkZJ
R19QUk9WSURFX09IQ0kxMzk0X0RNQV9JTklUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNUExFUyBp
cyBub3Qgc2V0CkNPTkZJR19FQVJMWV9QUklOVEs9eQojIENPTkZJR19ERUJVR19TVEFDS09WRVJG
TE9XIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1RBQ0tfVVNBR0UgaXMgbm90IHNldApDT05G
SUdfREVCVUdfUEFHRUFMTE9DPXkKQ09ORklHX0RFQlVHX1JPREFUQT15CiMgQ09ORklHX0RFQlVH
X1JPREFUQV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTlhfVEVTVCBpcyBub3Qgc2V0
CkNPTkZJR180S1NUQUNLUz15CkNPTkZJR19YODZfRklORF9TTVBfQ09ORklHPXkKQ09ORklHX1g4
Nl9NUFBBUlNFPXkKQ09ORklHX0RPVUJMRUZBVUxUPXkKQ09ORklHX0lPX0RFTEFZX1RZUEVfMFg4
MD0wCkNPTkZJR19JT19ERUxBWV9UWVBFXzBYRUQ9MQpDT05GSUdfSU9fREVMQVlfVFlQRV9VREVM
QVk9MgpDT05GSUdfSU9fREVMQVlfVFlQRV9OT05FPTMKIyBDT05GSUdfSU9fREVMQVlfMFg4MCBp
cyBub3Qgc2V0CkNPTkZJR19JT19ERUxBWV8wWEVEPXkKIyBDT05GSUdfSU9fREVMQVlfVURFTEFZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU9fREVMQVlfTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19ERUZB
VUxUX0lPX0RFTEFZX1RZUEU9MQpDT05GSUdfREVCVUdfQk9PVF9QQVJBTVM9eQojIENPTkZJR19D
UEFfREVCVUcgaXMgbm90IHNldAoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15
CkNPTkZJR19LRVlTX0RFQlVHX1BST0NfS0VZUz15CkNPTkZJR19TRUNVUklUWT15CkNPTkZJR19T
RUNVUklUWV9ORVRXT1JLPXkKQ09ORklHX1NFQ1VSSVRZX05FVFdPUktfWEZSTT15CkNPTkZJR19T
RUNVUklUWV9DQVBBQklMSVRJRVM9eQojIENPTkZJR19TRUNVUklUWV9GSUxFX0NBUEFCSUxJVElF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1JPT1RQTFVHIGlzIG5vdCBzZXQKQ09ORklH
X1NFQ1VSSVRZX0RFRkFVTFRfTU1BUF9NSU5fQUREUj0wCkNPTkZJR19TRUNVUklUWV9TRUxJTlVY
PXkKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfQk9PVFBBUkFNPXkKQ09ORklHX1NFQ1VSSVRZX1NF
TElOVVhfQk9PVFBBUkFNX1ZBTFVFPTEKQ09ORklHX1NFQ1VSSVRZX1NFTElOVVhfRElTQUJMRT15
CkNPTkZJR19TRUNVUklUWV9TRUxJTlVYX0RFVkVMT1A9eQpDT05GSUdfU0VDVVJJVFlfU0VMSU5V
WF9BVkNfU1RBVFM9eQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9DSEVDS1JFUVBST1RfVkFMVUU9
MQpDT05GSUdfU0VDVVJJVFlfU0VMSU5VWF9FTkFCTEVfU0VDTUFSS19ERUZBVUxUPXkKIyBDT05G
SUdfU0VDVVJJVFlfU0VMSU5VWF9QT0xJQ1lEQl9WRVJTSU9OX01BWCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFQ1VSSVRZX1NNQUNLIGlzIG5vdCBzZXQKQ09ORklHX1hPUl9CTE9DS1M9bQpDT05GSUdf
QVNZTkNfQ09SRT1tCkNPTkZJR19BU1lOQ19NRU1DUFk9bQpDT05GSUdfQVNZTkNfWE9SPW0KQ09O
RklHX0NSWVBUTz15CkNPTkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BRUFEPW0K
Q09ORklHX0NSWVBUT19CTEtDSVBIRVI9bQojIENPTkZJR19DUllQVE9fU0VRSVYgaXMgbm90IHNl
dApDT05GSUdfQ1JZUFRPX0hBU0g9eQpDT05GSUdfQ1JZUFRPX01BTkFHRVI9eQpDT05GSUdfQ1JZ
UFRPX0hNQUM9eQpDT05GSUdfQ1JZUFRPX1hDQkM9bQpDT05GSUdfQ1JZUFRPX05VTEw9bQpDT05G
SUdfQ1JZUFRPX01END1tCkNPTkZJR19DUllQVE9fTUQ1PXkKQ09ORklHX0NSWVBUT19TSEExPXkK
Q09ORklHX0NSWVBUT19TSEEyNTY9bQpDT05GSUdfQ1JZUFRPX1NIQTUxMj1tCkNPTkZJR19DUllQ
VE9fV1A1MTI9bQpDT05GSUdfQ1JZUFRPX1RHUjE5Mj1tCkNPTkZJR19DUllQVE9fR0YxMjhNVUw9
bQpDT05GSUdfQ1JZUFRPX0VDQj1tCkNPTkZJR19DUllQVE9fQ0JDPW0KQ09ORklHX0NSWVBUT19Q
Q0JDPW0KQ09ORklHX0NSWVBUT19MUlc9bQojIENPTkZJR19DUllQVE9fWFRTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0NUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19HQ00gaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fQ0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSWVBU
RCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPW0KQ09ORklHX0NSWVBUT19GQ1JZUFQ9bQpD
T05GSUdfQ1JZUFRPX0JMT1dGSVNIPW0KQ09ORklHX0NSWVBUT19UV09GSVNIPW0KQ09ORklHX0NS
WVBUT19UV09GSVNIX0NPTU1PTj1tCkNPTkZJR19DUllQVE9fVFdPRklTSF81ODY9bQpDT05GSUdf
Q1JZUFRPX1NFUlBFTlQ9bQpDT05GSUdfQ1JZUFRPX0FFUz1tCkNPTkZJR19DUllQVE9fQUVTXzU4
Nj1tCkNPTkZJR19DUllQVE9fQ0FTVDU9bQpDT05GSUdfQ1JZUFRPX0NBU1Q2PW0KQ09ORklHX0NS
WVBUT19URUE9bQpDT05GSUdfQ1JZUFRPX0FSQzQ9bQpDT05GSUdfQ1JZUFRPX0tIQVpBRD1tCkNP
TkZJR19DUllQVE9fQU5VQklTPW0KIyBDT05GSUdfQ1JZUFRPX1NFRUQgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fU0FMU0EyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TQUxTQTIwXzU4
NiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVGTEFURT1tCkNPTkZJR19DUllQVE9fTUlDSEFF
TF9NSUM9bQpDT05GSUdfQ1JZUFRPX0NSQzMyQz15CkNPTkZJR19DUllQVE9fQ0FNRUxMSUE9bQpD
T05GSUdfQ1JZUFRPX1RFU1Q9bQpDT05GSUdfQ1JZUFRPX0FVVEhFTkM9bQojIENPTkZJR19DUllQ
VE9fTFpPIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19IVz15CkNPTkZJR19DUllQVE9fREVWX1BB
RExPQ0s9bQpDT05GSUdfQ1JZUFRPX0RFVl9QQURMT0NLX0FFUz1tCkNPTkZJR19DUllQVE9fREVW
X1BBRExPQ0tfU0hBPW0KQ09ORklHX0NSWVBUT19ERVZfR0VPREU9bQojIENPTkZJR19DUllQVE9f
REVWX0hJRk5fNzk1WCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tWTT15CiMgQ09ORklHX1ZJUlRV
QUxJWkFUSU9OIGlzIG5vdCBzZXQKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0JJVFJF
VkVSU0U9eQpDT05GSUdfQ1JDX0NDSVRUPW0KQ09ORklHX0NSQzE2PW0KQ09ORklHX0NSQ19JVFVf
VD1tCkNPTkZJR19DUkMzMj15CiMgQ09ORklHX0NSQzcgaXMgbm90IHNldApDT05GSUdfTElCQ1JD
MzJDPXkKQ09ORklHX0FVRElUX0dFTkVSSUM9eQpDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklH
X1pMSUJfREVGTEFURT1tCkNPTkZJR19SRUVEX1NPTE9NT049bQpDT05GSUdfUkVFRF9TT0xPTU9O
X0RFQzE2PXkKQ09ORklHX1RFWFRTRUFSQ0g9eQpDT05GSUdfVEVYVFNFQVJDSF9LTVA9bQpDT05G
SUdfVEVYVFNFQVJDSF9CTT1tCkNPTkZJR19URVhUU0VBUkNIX0ZTTT1tCkNPTkZJR19QTElTVD15
CkNPTkZJR19IQVNfSU9NRU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19IQVNfRE1BPXkK

--MP_/QtgDrJVXBjpg3KV77xqhbP_
Content-Type: text/plain; name=suspend-lspci.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=suspend-lspci.txt

00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory Controller Hub (rev 02)
	Subsystem: ASUSTeK Computer Inc. Unknown device 817a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel driver in use: agpgart-intel
00: 86 80 70 27 06 00 90 20 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 7a 81
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 90 d1 fe 01 40 d1 fe 05 00 00 f0 01 80 d1 fe
50: 00 00 30 00 09 00 00 00 00 00 00 00 00 00 00 00
60: 00 30 d1 fe 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 11 01 00 00 33 33 00 ff 03 00 00 40 0a 38 00
a0: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 20 01 00 00
e0: 09 00 09 51 02 e1 9b 88 06 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 03 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corporation 82945G/GZ Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Unknown device 817a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dfe00000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at 8800 [size=8]
	Region 2: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 3: Memory at dfe80000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel modules: intelfb
00: 86 80 72 27 07 00 90 00 02 00 00 03 00 00 00 00
10: 00 00 e0 df 01 88 00 00 08 00 00 e0 00 00 e8 df
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 7a 81
30: 00 00 00 00 90 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 e0 00 00 00 09 00 09 51 02 e1 9b 88
50: 06 00 30 00 09 00 00 00 00 00 00 00 00 00 80 3f
60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 34 05 64 34 00 00 00 00 86 0f 03 00 00 00 00 00

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 817f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dfef8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel
00: 86 80 d8 27 06 00 10 00 01 00 03 04 04 00 00 00
10: 04 80 ef df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 7f 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 91 00 00 00 00 00 00 08 10 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 16 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  1, PowerLimit 10.000000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
		Address: fee0100c  Data: 41b9
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport-driver
00: 86 80 d0 27 07 05 10 00 01 00 04 06 04 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 e0 e0 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 06 00
40: 10 80 41 01 c0 0f 00 00 0f 00 10 00 11 2c 11 01
50: 40 00 01 10 60 05 08 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 0c 10 e0 fe b9 41 00 00 00 00 00 00
90: 0d a0 00 00 43 10 79 81 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 00 00 00 00 00
e0: 00 00 c7 00 06 07 08 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 16 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dff00000-dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
		Address: fee0100c  Data: 41c1
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport-driver
00: 86 80 d2 27 07 05 10 00 01 00 04 06 04 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 d0 d0 00 00
20: f0 df f0 df f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 06 00
40: 10 80 41 00 c0 0f 00 00 0f 00 10 00 11 2c 11 02
50: 40 00 11 30 60 05 10 00 00 00 48 01 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 0c 10 e0 fe c1 41 00 00 00 00 00 00
90: 0d a0 00 00 43 10 79 81 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 11 00 00 00 00 00
e0: 00 00 c7 00 06 07 08 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 9000 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd
00: 86 80 c8 27 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 90 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 9400 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd
00: 86 80 c9 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 94 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 9800 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd
00: 86 80 ca 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 98 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at a000 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd
00: 86 80 cb 27 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 01 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at dfeffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd
00: 86 80 cc 27 06 00 90 02 01 20 03 0c 00 00 00 00
10: 00 fc ef df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 00 a0 20 00 00 00 00
60: 20 20 ff 01 00 00 00 00 01 00 00 00 00 00 08 c0
70: 00 00 ef 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 ff 00 ff 00 20 00 00 88
e0: 00 00 00 00 db b6 6d 00 00 00 00 00 00 00 00 00
f0: 00 80 00 09 88 85 40 00 86 0f 01 00 06 17 02 20

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: ASUSTeK Computer Inc. Unknown device 8179
00: 86 80 4e 24 07 01 10 00 e1 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 06 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 00
50: 0d 00 00 00 43 10 79 81 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel modules: iTCO_wdt, intel-rng
00: 86 80 b8 27 07 00 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 80 00 00 00 81 04 00 00 10 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 0a 05 05 d0 00 00 00 03 80 80 0b 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 0f 14 00 00 00 00 91 02 04 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 28 02 00 00 29 00 00 00 13 00 00 00 00 03 00 00
b0: 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 c0 80 00 00 00 00 00 00
e0: 09 00 0c 10 a8 00 24 00 00 00 00 00 00 00 00 00
f0: 01 c0 d1 fe 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at ffa0 [size=16]
	Kernel driver in use: ata_piix
	Kernel modules: ata_piix
00: 86 80 df 27 05 00 80 02 01 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 03 e3 00 c0 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA IDE Controller (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 2601
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 23
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ata_piix
	Kernel modules: ata_piix
00: 86 80 c0 27 05 00 b0 02 01 8f 01 01 00 00 00 00
10: 01 b8 00 00 01 b4 00 00 01 b0 00 00 01 a8 00 00
20: 01 a4 00 00 00 00 00 00 00 00 00 00 43 10 01 26
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
40: 07 a3 07 a3 00 00 00 00 05 00 01 01 00 00 00 00
50: 00 00 00 00 f0 50 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 3f 00 80 01 00 40 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 23
	Region 4: I/O ports at 0400 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c-i801
00: 86 80 da 27 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 04 00 00 00 00 00 00 00 00 00 00 43 10 79 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 01 00 00 00 00 00

02:00.0 Ethernet controller: Attansic Technology Corp. L1 Gigabit Ethernet Adapter (rev b0)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8226
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 221
	Region 0: Memory at dffc0000 (64-bit, non-prefetchable) [size=256K]
	Expansion ROM at dffa0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
		Address: 00000000fee0100c  Data: 4142
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [6c] Vital Product Data <?>
	Kernel driver in use: atl1
	Kernel modules: atl1
00: 69 19 48 10 06 00 10 00 b0 00 00 02 04 00 00 00
10: 04 00 fc df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 26 82
30: 00 00 fa df 40 00 00 00 00 00 00 00 0a 01 00 00
40: 01 48 02 c0 00 00 00 00 05 58 81 00 0c 10 e0 fe
50: 00 00 00 00 42 41 00 00 10 6c 01 00 80 7f 28 00
60: 00 20 10 00 11 f4 03 00 40 00 11 10 03 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 69 19 48 10 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--MP_/QtgDrJVXBjpg3KV77xqhbP_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/QtgDrJVXBjpg3KV77xqhbP_--
