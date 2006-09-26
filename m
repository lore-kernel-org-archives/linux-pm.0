From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: suspending to disk on FC6 not working
Date: Tue, 26 Sep 2006 17:47:34 -0400
Message-ID: <1159307254.2780.4.camel@soncomputer>
References: <1159138520.19021.11.camel@soncomputer>
	<200609252215.19257.rjw@sisk.pl> <1159225475.3014.6.camel@soncomputer>
	<200609261200.28635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FB02cYDkCThZAolQmYAH"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200609261200.28635.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--=-FB02cYDkCThZAolQmYAH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-09-26 at 12:00 +0200, Rafael J. Wysocki wrote:
> On Tuesday, 26 September 2006 01:04, Louis Garcia wrote:
> > On Mon, 2006-09-25 at 22:15 +0200, Rafael J. Wysocki wrote:
> > > On Monday, 25 September 2006 21:34, Louis Garcia wrote:
> > > > On Mon, 2006-09-25 at 20:43 +0200, Rafael J. Wysocki wrote:
> > > > > On Monday, 25 September 2006 19:10, Louis Garcia wrote:
> > > > > > On Mon, 2006-09-25 at 09:16 +0200, Rafael J. Wysocki wrote:
> > > > > > > On Monday, 25 September 2006 00:55, Louis Garcia wrote:
> > > > > > > > When I first installed FC6 test 2 suspend to disk worked on my box which
> > > > > > > > is a Dell dimension 8200 (P4). During the kernel-2.6.17-xxx updates this
> > > > > > > > has stopped working. Now kernel-2.6.18 has come out and I'm having the
> > > > > > > > same problems. I have tried to get this resolved on there mailing list
> > > > > > > > but it's not high on there things todo. I would like to debug suspend to
> > > > > > > > see what is happening. What is the proper way to do this? Has this been
> > > > > > > > discussed before? Is there a separate mailing-list for suspend?
> > > > > > > 
> > > > > > > Generally you're not giving enough information to trace the problem.
> > > > > > > 
> > > > > > > First, what doesn't work, the suspend to disk or the resume?
> > > > > > > 
> > > > > > > Rafael
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Suspend to disk does not work. When trying to suspend, from gnome, it
> > > > > > goes normally. The power button blinks and then restarts. I'm back to
> > > > > > the screensaver lock screen but the mouse and keyboard are dead.
> > > > > 
> > > > > Can you please try booting the kernel with init=/bin/bash, mount /proc,
> > > > > mount /sys, do "/sbin/swapon -a" and "echo disk > /sys/power/state"?
> > > > > 
> > > > > Rafael
> > > > > 
> > > > > 
> > > > After the echo command the box turned off. The power button was not
> > > > blinking. I restarted it and went into grub,
> > > 
> > > Did you append init=/bin/bash to the kernel command line after it had gone
> > > into GRUB?
> > 
> > No, first I booted with init=/bin/bash. Then I did the things you said,
> > When the box was off I booted normally. You saying I should append
> > init=/bin/bash before and after trying to suspend.
> 
> Well, it shouldn't matter if you append init=/bin/bash after trying to
> suspend, but if the shell appears without it, this means the system actually
> suspended and resumed.
> 
> > > > linux booted into bash.
> > > 
> > > Had it been displaying a progress meter before the bash came up?
> > 
> > Never saw a meter before.
> > 
> > > > When suspend was working the power button flashed and when I pressed it
> > > > the box booted right into linux and the screensaver lock screen
> > > > bypassing grub altogether.
> > > 
> > > That's because if you suspend "normally", some scripts run before the suspend
> > > that change your GRUB configuration and use the "platform" suspend method.
> > > However, the problem seems to be on much lower level and to debug it we need
> > > to bypass these things.
> > 
> > Yes, something in the kernel I assume. How do I debug this further? 
> 
> Please boot the kernel with "2" appended to the command line, so the system
> goes to the 2nd runlevel (ie. without network servers and X).  Then log in
> as root, do "echo 8 > /proc/sys/kernel/printk" and
> "echo disk > /sys/power/state".  The system should suspend to disk and power
> off the machine.  If it doesn't do that (ie. if it returns to the shell
> immediately), please do "dmesg > dmesg.log" and send the dmesg.log file
> to me.

The system didn't power off, it returned to the shell. I attached dmesg.

> Greetings,
> Rafael

-Louis

--=-FB02cYDkCThZAolQmYAH
Content-Disposition: attachment; filename=dmesg.log
Content-Type: text/x-log; name=dmesg.log; charset=utf-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-1.2693.fc6 (brewbuilder@hs20-bc1-6.build.redhat.com) (gcc version 4.1.1 20060920 (Red Hat 4.1.1-24)) #1 SMP Fri Sep 22 18:03:54 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff77000 (usable)
 BIOS-e820: 000000002ff77000 - 000000002ff79000 (ACPI NVS)
 BIOS-e820: 000000002ff79000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
767MB LOWMEM available.
found SMP MP-table at 000fe710
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 196471
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 192375 pages, LIFO batch:31
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 DELL                                  ) @ 0x000fd550
ACPI: RSDT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 0x000fd564
ACPI: FADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 0x000fd598
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffe5d92
ACPI: MADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 0x000fd60c
ACPI: BOOT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 0x000fd678
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 1993.997 MHz processor.
Built 1 zonelists.  Total pages: 196471
Kernel command line: ro root=LABEL=/1 2
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0820000 soft=c0800000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 770196k/785884k available (2141k kernel code, 14948k reserved, 1128k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3993.42 BogoMIPS (lpj=7986854)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: 3febf3ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Total of 1 processors activated (3993.42 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=568 bytes
sizeof(dentry)=160 bytes
sizeof(ext3inode)=804 bytes
sizeof(buffer_head)=52 bytes
sizeof(skbuff)=172 bytes
checking if image is initramfs... it is
Freeing initrd memory: 1360k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbe9e, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.4
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:00.1
PM: Adding info for pci:0000:02:08.0
PM: Adding info for pci:0000:02:09.0
PM: Adding info for pci:0000:02:09.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
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
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0b: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: ff800000-ff9fffff
  PREFETCH window: e8000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: ff600000-ff7fffff
  PREFETCH window: 40000000-400fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x7a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1159303729.944:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key E4C973ACF8B7482
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x2
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i850 Chipset.
agpgart: AGP aperture is 128M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-110D, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 512KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Time: tsc clocksource has been installed.
PM: Adding info for serio:serio1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 400k
input: AT Translated Set 2 keyboard as /class/input/input0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 169, io base 0x0000ff80
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 177, io base 0x0000ff60
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
usb 1-1: new full speed USB device using uhci_hcd and address 2
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
PM: Adding info for usb:1-1
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-1:1.0
PM: Adding info for No Bus:usbdev1.2_ep87
PM: Adding info for usb:1-1:1.1
PM: Adding info for usb:1-1:1.2
PM: Adding info for usb:1-1:1.3
audit(1159303736.576:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1542 types, 162 bools, 1 sens, 1024 cats
security:  58 classes, 47701 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda3, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1159303736.884:3): policy loaded auid=4294967295
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 17 (level, low) -> IRQ 185
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:08.0: 3Com PCI 3c905C Tornado at f0836c00.
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
gameport: EMU10K1 is pci0000:02:09.1/gameport0, io 0xdc58, speed 917kHz
PM: Adding info for gameport:gameport0
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 185
PM: Adding info for No Bus:i2c-0
input: PC Speaker as /class/input/input2
PM: Adding info for No Bus:usbdev1.2_ep86
cannot find the slot for index 0 (range 0-0)
EMU10K1_Audigy: probe of 0000:02:09.0 failed with error -12
2:3:1: cannot set freq 0 to ep 0x86
PM: Removing info for No Bus:usbdev1.2_ep86
PM: Adding info for No Bus:usbdev1.2_ep86
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
Intel 82802 RNG detected
2:3:2: cannot set freq 0 to ep 0x86
PM: Removing info for No Bus:usbdev1.2_ep86
PM: Adding info for No Bus:usbdev1.2_ep86
PM: Removing info for No Bus:usbdev1.2_ep86
usbcore: registered new driver snd-usb-audio
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.4 loaded
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda6, type ext3), uses xattr
Adding 1020088k swap on /dev/hda5.  Priority:-1 extents:1 across:1020088k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (6139 buckets, 49112 max) - 228 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
eth0:  setting full-duplex.
Bluetooth: Core ver 2.10
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: no IPv6 routers present
Disabling non-boot CPUs ...
Stopping tasks: ====================================|
Shrinking memory...  -done (0 pages freed)
platform bluetooth: freeze
platform floppy.0: freeze
snd-usb-audio 1-1:1.3: freeze
snd-usb-audio 1-1:1.3: no suspend for driver snd-usb-audio?
snd-usb-audio 1-1:1.2: freeze
snd-usb-audio 1-1:1.2: no suspend for driver snd-usb-audio?
usb 1-1:1.1: PM: suspend 1-->1
 usbdev1.2_ep87: PM: suspend 0->1, parent 1-1:1.0 already 1
usb 1-1:1.0: PM: suspend 1-->1
usb 1-1: freeze
hub 2-0:1.0: freeze
usb usb2: freeze
hub 1-0:1.0: freeze
usb usb1: freeze
i8042 i8042: freeze
ide-cdrom 1.0: freeze
ide-disk 0.0: freeze
serial8250 serial8250: freeze
platform vesafb.0: freeze
pcspkr pcspkr: freeze
system 00:0b: freeze
parport_pc 00:0a: freeze
pnp: Device 00:0a disabled.
serial 00:09: freeze
pnp: Device 00:09 disabled.
i8042 aux 00:08: freeze
i8042 kbd 00:07: freeze
pnp 00:06: freeze
pnp 00:05: freeze
pnp 00:04: freeze
pnp 00:03: freeze
pnp 00:02: freeze
pnp 00:01: freeze
system 00:00: freeze
Emu10k1_gameport 0000:02:09.1: freeze
pci 0000:02:09.0: freeze
3c59x 0000:02:08.0: freeze
ACPI: PCI interrupt for device 0000:02:08.0 disabled
pci 0000:01:00.1: freeze
pci 0000:01:00.0: freeze
uhci_hcd 0000:00:1f.4: freeze
ACPI: PCI interrupt for device 0000:00:1f.4 disabled
i801_smbus 0000:00:1f.3: freeze
uhci_hcd 0000:00:1f.2: freeze
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
PIIX_IDE 0000:00:1f.1: freeze
pci 0000:00:1f.0: freeze
pci 0000:00:1e.0: freeze
pci 0000:00:01.0: freeze
agpgart-intel 0000:00:00.0: freeze
acpi acpi: freeze
PM: snapshotting memory.
Class driver suspend failed for cpu0
Could not power down device &q->lock: error -22
Some devices failed to power down, aborting suspend
acpi acpi: resuming
agpgart-intel 0000:00:00.0: resuming
pci 0000:00:01.0: resuming
pci 0000:00:1e.0: resuming
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
uhci_hcd 0000:00:1f.2: resuming
PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1f.2 to 64
i801_smbus 0000:00:1f.3: resuming
uhci_hcd 0000:00:1f.4: resuming
PCI: Enabling device 0000:00:1f.4 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.4 to 64
usb usb2: root hub lost power or was reset
pci 0000:01:00.0: resuming
pci 0000:01:00.1: resuming
3c59x 0000:02:08.0: resuming
PM: Writing back config space on device 0000:02:08.0 at offset f (was a0a0100, writing a0a010a)
PM: Writing back config space on device 0000:02:08.0 at offset c (was 0, writing ff700000)
PM: Writing back config space on device 0000:02:08.0 at offset 5 (was 0, writing ff6ffc00)
PM: Writing back config space on device 0000:02:08.0 at offset 4 (was 1, writing dc81)
PM: Writing back config space on device 0000:02:08.0 at offset 3 (was 0, writing 4010)
PM: Writing back config space on device 0000:02:08.0 at offset 1 (was 2100000, writing 2100117)
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 17 (level, low) -> IRQ 185
eth0:  setting full-duplex.
pci 0000:02:09.0: resuming
Emu10k1_gameport 0000:02:09.1: resuming
system 00:00: resuming
pnp 00:01: resuming
pnp 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
i8042 kbd 00:07: resuming
pnp: Failed to activate device 00:07.
i8042 aux 00:08: resuming
pnp: Failed to activate device 00:08.
serial 00:09: resuming
pnp: Device 00:09 activated.
parport_pc 00:0a: resuming
pnp: Device 00:0a activated.
system 00:0b: resuming
pcspkr pcspkr: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
ide-disk 0.0: resuming
ide-cdrom 1.0: resuming
i8042 i8042: resuming
psmouse serio0: resuming
atkbd serio1: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb 1-1: resuming
 usbdev1.2_ep87: PM: resume from 0, parent 1-1:1.0 still 1
snd-usb-audio 1-1:1.2: resuming
snd-usb-audio 1-1:1.2: no resume for driver snd-usb-audio?
snd-usb-audio 1-1:1.3: resuming
snd-usb-audio 1-1:1.3: no resume for driver snd-usb-audio?
platform floppy.0: resuming
platform bluetooth: resuming
Restarting tasks... done
Enabling non-boot CPUs ...

--=-FB02cYDkCThZAolQmYAH
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--=-FB02cYDkCThZAolQmYAH--
