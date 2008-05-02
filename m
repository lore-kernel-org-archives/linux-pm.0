From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 12:29:10 -0500
Message-ID: <20080502122910.429312a7@osprey.hogchain.net>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805021849.14120.rjw@sisk.pl>
	<20080502115706.57d1adf9@osprey.hogchain.net>
	<200805021859.57457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/AOTwOM4UzflMdnmnx1HxarQ"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805021859.57457.rjw@sisk.pl>
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

--MP_/AOTwOM4UzflMdnmnx1HxarQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 2 May 2008 18:59:56 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 2 of May 2008, Jay Cliburn wrote:
> > On Fri, 2 May 2008 18:49:13 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Can you try to comment out acpi_enable_wakeup_device(acpi_state)
> > > in drivers/acpi/sleep/main.c:acpi_suspend_enter() and see if that
> > > helps?
> > 
> > I'm working with 2.6.25.1, which doesn't have acpi_suspend_enter(),
> > but I'll hop over to current git and give it a try.
> 
> This function is called acpi_pm_enter() in 2.6.25.1.

No change.  I rebooted the modified kernel, then executed this command
sequence.

jcliburn@osprey:~$ su -
Password: 
[root@osprey ~]# echo 8 > /proc/sys/kernel/printk
[root@osprey ~]# ethtool -s eth0 wol g
[root@osprey ~]# echo mem > /sys/power/state


[root@osprey ~]# 
[root@osprey ~]# 
[root@osprey ~]# 

It spontaneously resumed.  Serial console log attached.
--MP_/AOTwOM4UzflMdnmnx1HxarQ
Content-Type: text/plain; name=susp-cons-log.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=susp-cons-log.txt

[jcliburn@sparrow ~]$ minicom


Welcome to minicom 2.2

OPTIONS: I18n 
Compiled on Sep 25 2007, 06:13:56.
Port /dev/ttyS0

               Press CTRL-A Z for help on special keys                                                 
                                                                                                       
                                                                                                       
Fedora release 8 (Werewolf)                                                                            
Kernel 2.6.25.1 on an i686                                                                             

osprey.hogchain.net login: PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.07 seconds) done.
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
hub 5-0:1.0: PM: suspend 2-->2
hub 5-0:1.0: suspend
usb usb5: PM: suspend 2-->2
usb usb5: suspend, may wakeup
hub 4-0:1.0: PM: suspend 2-->2
hub 4-0:1.0: suspend
usb usb4: PM: suspend 2-->2
usb usb4: suspend, may wakeup
hub 3-0:1.0: PM: suspend 2-->2
hub 3-0:1.0: suspend
usb usb3: PM: suspend 2-->2
usb usb3: suspend, may wakeup
hub 2-0:1.0: PM: suspend 2-->2
hub 2-0:1.0: suspend
usb usb2: PM: suspend 2-->2
usb usb2: suspend, may wakeup
hub 1-0:1.0: PM: suspend 2-->2
hub 1-0:1.0: suspend
usb usb1: PM: suspend 2-->2
usb usb1: suspend, may wakeup
psmouse serio1: suspend
atkbd serio0: suspend
i8042 i8042: suspend
serial8250 serial8250: suspend
platform vesafb.0: suspend
pci_express 0000:00:1c.1:pcie00: suspend
pci_express 0000:00:1c.0:pcie02: suspend
pci_express 0000:00:1c.0:pcie00: suspend
pcspkr pcspkr: suspend
system 00:12: suspend
system 00:11: suspend
ACPI handle has no context!
system 00:10: suspend
pnp 00:0f: suspend
serial 00:0e: suspend
serial 00:0e: disabled
system 00:0d: suspend
i8042 aux 00:0c: suspend
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
ACPI: PCI interrupt for device 0000:02:00.0 disabled
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
acpi PNP0F03:00: suspend
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
Calibrating delay using timer specific routine.. 4266.64 BogoMIPS (lpj=2133324)
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
acpi PNP0F03:00: resuming
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
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
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
i8042 aux 00:0c: resuming
system 00:0d: resuming
serial 00:0e: resuming
serial 00:0e: activated
pnp 00:0f: resuming
system 00:10: resuming
system 00:11: resuming
system 00:12: resuming
pcspkr pcspkr: resuming
pci_express 0000:00:1c.0:pcie00: resuming
pci_express 0000:00:1c.0:pcie02: resuming
pci_express 0000:00:1c.1:pcie00: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
i8042 i8042: resuming
atkbd serio0: resuming
psmouse serio1: resuming
ata1.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
ata1.00: configured for UDMA/33
hub 2-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
usb usb4: resuming
hub 4-0:1.0: resuming
usb usb5: resuming
hub 5-0:1.0: resuming
sr 0:0:0:0: resuming
sd 2:0:0:0: resuming
sd 2:0:0:0: [sda] Starting disk
atl1 0000:02:00.0: eth0 link is up 1000 Mbps full duplex
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
Restarting tasks ... done.
hub 1-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 2
hub 1-0:1.0: over-current change on port 3
hub 1-0:1.0: over-current change on port 4
hub 1-0:1.0: over-current change on port 5
hub 1-0:1.0: over-current change on port 6
hub 1-0:1.0: over-current change on port 7
hub 1-0:1.0: over-current change on port 8
    
 CTRL-A Z for help | 38400 8N1 | NOR | Minicom 2.2    | VT102 |      Offline                                                                                                       



--MP_/AOTwOM4UzflMdnmnx1HxarQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/AOTwOM4UzflMdnmnx1HxarQ--
