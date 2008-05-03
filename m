From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 21:05:29 -0500
Message-ID: <20080502210529.56b11328@osprey.hogchain.net>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805021941.08003.rjw@sisk.pl>
	<20080502131003.15f45b82@osprey.hogchain.net>
	<200805030149.45144.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/5.f4zMxN1hMmWxWPVnrJTDg"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805030149.45144.rjw@sisk.pl>
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

--MP_/5.f4zMxN1hMmWxWPVnrJTDg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 3 May 2008 01:49:44 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 2 of May 2008, Jay Cliburn wrote:
[...]
> > I poked around in BIOS and changed the behavior somewhat.  There's a
> > BIOS setting called "Suspend Mode" with three options:
> > 
> > 	S1 (POS) only
> > 	S3 only
> > 	Auto
> > 
> > When set to "S3 only" or "Auto," the machine spontaneously resumes
> > following a suspend.  When set to "S1 (POS) only" the machine stays
> > asleep.
> > 
> > What is "POS" an acronym for?
> 
> No idea.

Wikipedia to the rescue.  http://en.wikipedia.org/wiki/Acpi

S1 == POS == Power On Standby

I don't think I want to use this mode.  The cpu fan runs continuously at
max while suspended and the system won't resume; I have to whack it
with the reset button to get it going again (with a reboot).

> 
> > Does it make sense to leave the thing set to "S1 only?"
> 
> I guess it does.  Still, can you please post a boot log with it set
> this way?

Okay, it's attached.

BTW, I'm still using the modified version of acpi_pm_enter().

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 71183ee..ccc760a 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -129,7 +129,9 @@ static int acpi_pm_enter(suspend_state_t pm_state)
        }
 
        local_irq_save(flags);
+/*
        acpi_enable_wakeup_device(acpi_state);
+*/
        switch (acpi_state) {
        case ACPI_STATE_S1:
                barrier();



--MP_/5.f4zMxN1hMmWxWPVnrJTDg
Content-Type: text/plain; name=cons-log-s1.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=cons-log-s1.txt

Linux version 2.6.25.1 (jcliburn@osprey.hogchain.net) (gcc version 4.1.2 20=
070925 (Red Hat8
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
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259984
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   259984
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
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f800000:c0380000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 256684
Kernel command line: ro root=3DLABEL=3D/1 console=3DttyS0,38400 console=3Dt=
ty0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc0792000 soft=3Dc0772000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2133.274 MHz processor.
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
Memory: 1016984k/1039936k available (2117k kernel code, 22308k reserved, 11=
37k data, 244k init, 122432k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc54000 - 0xfffff000   (3756 kB)
    pkmap   : 0xff400000 - 0xff800000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0732000 - 0xc076f000   ( 244 kB)
      .data : 0xc061161b - 0xc072dbc0   (1137 kB)
      .text : 0xc0400000 - 0xc061161b   (2117 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=3D12, HWalign=3D64, Order=3D0-1, MinObjects=3D4, CPUs=3D2, N=
odes=3D1
Calibrating delay using timer specific routine.. 4269.37 BogoMIPS (lpj=3D21=
34688)
Security Framework initialized
SELinux:  Initializing.
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
CPU 1 irqstacks, hard=3Dc0793000 soft=3Dc0773000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4266.54 BogoMIPS (lpj=3D21=
33272)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
Total of 2 processors activated (8535.92 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
net_namespace: 608 bytes
Time:  1:55:32  Date: 05/03/08
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub wit=
hout MMCONFIG support.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  7C, shou=
ld be 6F [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 19 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
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
system 00:0d: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0d: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:10: iomem range 0xffc00000-0xfff7ffff could not be reserved
system 00:11: iomem range 0xf0000000-0xf3ffffff has been reserved
system 00:12: iomem range 0x0-0x9ffff could not be reserved
system 00:12: iomem range 0xc0000-0xdffff could not be reserved
system 00:12: iomem range 0xe0000-0xfffff could not be reserved
system 00:12: iomem range 0x100000-0x3f7fffff could not be reserved
system 00:12: iomem range 0x0-0x0 could not be reserved
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
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs...<7>Switched to high resolution mode on CPU=
 1
 it is
debug: unmapping init memory f7d05000..f7ff0000
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
type=3D2000 audit(1209779731.296:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: SSDT 3F79E0B0, 01C6 (r1    AMI   CPU1PM        1 INTL 20060113)
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: SSDT 3F79E280, 013A (r1    AMI   CPU2PM        1 INTL 20060113)
ACPI: ACPI0007:01 is registered as cooling_device1
ACPI: Processor [CPU2] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
=EF=BF=BDserial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0e: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
brd: module loaded
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
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
registered taskstats version 1
  Magic number: 8:211:912
debug: unmapping init memory c0732000..c076f000
Write protecting the kernel read-only data: 908k
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xdfeffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00009000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x00009400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000a000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ata1.00: ATAPI: _NEC DVD_RW ND-3520A, 1.04, max UDMA/33
ata1.00: configured for UDMA/33
scsi 0:0:0:0: CD-ROM            _NEC     DVD_RW ND-3520A  1.04 PQ: 0 ANSI: 5
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xb800 ctl 0xb400 bmdma 0xa400 irq 23
ata4: SATA max UDMA/133 cmd 0xb000 ctl 0xa800 bmdma 0xa408 irq 23
ata3.00: ATA-7: SAMSUNG HD160JJ, ZM100-41, max UDMA7
ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4.00: ATA-7: WDC WD2500KS-00MJB0, 02.01C03, max UDMA/133
ata4.00: 488397168 sectors, multi 16: LBA48=20
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD160JJ  ZM10 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 2:0:0:0: [sda] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdb: sdb1 sdb2
sd 3:0:0:0: [sdb] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
type=3D1404 audit(1209779738.574:2): selinux=3D0 auid=3D4294967295 ses=3D42=
94967295

Fedora release 8 (Werewolf)
Kernel 2.6.25.1 on an i686

osprey.hogchain.net login: PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.07 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
Suspending console(s)

 CTRL-A Z for help | 38400 8N1 | NOR | Minicom 2.2    | VT102 |      Offlin=
e                                                                          =
                            =20



--MP_/5.f4zMxN1hMmWxWPVnrJTDg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/5.f4zMxN1hMmWxWPVnrJTDg--
