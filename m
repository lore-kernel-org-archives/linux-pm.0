From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4 00/13] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Mon, 01 Feb 2016 08:53:27 +0000
Message-ID: <56AF1D07.3000604@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com> <7hvb6chv5e.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46688 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcBAIyl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Feb 2016 03:54:41 -0500
In-Reply-To: <7hvb6chv5e.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Marc Zyngier <marc.zyngier@arm.com>

Hi Kevin,

On 29/01/16 22:34, Kevin Hilman wrote:
> James Morse <james.morse@arm.com> writes:
> I'd like to help in testing this so I'm just curious which platforms
> you've been testing this on.  I'm assuming a Juno (r2?), anything else?

That would be great - thanks!

I've done most of the testing on a Juno r1, but also gave it a spin on a
stray Seattle.


> Are you testing the resume from cold boot, or just from kexec?

>From cold boot. I haven't tried with kexec, but I doubt that's a use-case anyone
wants as you would resume immediately. (might be interesting for testing though)


> For cold boot on Juno, I'm assuming there would be some
> booloader/firmware changes needed to find and boot from the hibernation
> image?

Not at all! Your firmware only needs to support some mechanism to
turning CPUs off.

If you add 'resume=/dev/sda2' (or wherever your swap partition is located), the
kernel will check this partition for the hibernate-image signature, if found, it
will resume from that partition. Otherwise booting is as normal. (there is one
hoop to jump through to ensure your rootfs hasn't been mounted before the kernel
starts resume, as you could corrupt it - an initramfs in the kernel is the best
fix for this).

No firmware changes needed.

> Is that being worked on?  If not Juno, are you aware of any
> other platforms that could be tested with resume from cold boot?

Any arm64 platform with persistent storage should work. I've been using a swap
partition on a usb drive.


> Not knowing the answers to the above, I tested your branch using arm64
> defconfig + CONFIG_HIBERNATION=y on my Juno and noticed that it didn't
> stay suspended (full suspend log below) so I'm looking for
> ideas/recommenations on how to test this.

That trace looks quite normal, (one of mine below[0] for comparison). Any
failure would have happened after the point you stopped ... did you have a swap
partition 'on'?

'syscore' will freeze all processes and stop all devices, then create a
copy of the minimum amount of memory it needs to save. Then it starts
all the devices again, as it needs to write this image out to swap. This is what
you are seeing.

Once it has done this it calls poweroff or reboot.


Thanks,

James



[0] kernel output for hibernate/resume on Juno-r1:
root@localhost:/sys/power# swapon /dev/sda2
Adding 236540k swap on /dev/sda2.  Priority:-1 extents:1 across:236540k
root@localhost:/sys/power# ls
disk        pm_async           reserved_size  state
image_size  pm_freeze_timeout  resume         wakeup_count
root@localhost:/sys/power# cat disk
[shutdown] reboot suspend
root@localhost:/sys/power# echo disk > state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
PM: Preallocating image memory... done (allocated 93967 pages)
PM: Allocated 375868 kbytes in 3.74 seconds (100.49 MB/s)
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: freeze of devices complete after 17.794 msecs
PM: late freeze of devices complete after 1.358 msecs
PM: noirq freeze of devices complete after 1.771 msecs
Disabling non-boot CPUs ...
PM: Creating hibernation image:
PM: Need to copy 93868 pages
PM: Hibernation image created (93868 pages copied)
PM: noirq thaw of devices complete after 1.319 msecs
PM: early thaw of devices complete after 0.890 msecs
serio serio0: device_attach() failed for 1c060000.kmi (1c060000.kmi), error: -51
7
serio serio1: device_attach() failed for 1c070000.kmi (1c070000.kmi), error: -51
7
PM: thaw of devices complete after 92.523 msecs
PM: Using 1 thread(s) for compression.
PM: Compressing and saving image data (94052 pages)...
PM: Image saving progress:   0%
atkbd serio0: keyboard reset failed on 1c060000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
PM: Image saving progress:  10%
PM: Image saving progress:  20%
PM: Image saving progress:  30%
PM: Image saving progress:  40%
PM: Image saving progress:  50%
PM: Image saving progress:  60%
PM: Image saving progress:  70%
PM: Image saving progress:  80%
PM: Image saving progress:  90%
PM: Image saving progress: 100%
PM: Image saving done.
PM: Wrote 376208 kbytes in 21.76 seconds (17.28 MB/s)
PM: S|
kvm: exiting hardware virtualization
reboot: Power down

Board powered down, use REBOOT to restart.

Cmd>

ARM V2M-Juno Boot loader v1.0.0
HBI0262 build 1635

ARM V2M_Juno r1 Firmware v1.3.3
Build Date: Mar 31 2015

Time :  08:25:55
Date :  01:02:2016

Press Enter to stop auto boot...
Powering up system...

Switching on ATXPSU...
PMIC RAM configuration (pms_v104.bin)...
MBtemp   : 28 degC

Configuring motherboard (rev C, var A)...
IOFPGA image \MB\HBI0262C\io_b117.bit
IOFPGA  config: PASSED
OSC CLK config: PASSED

Configuring SCC registers...
Writing SCC 0x00000054 with 0x0007FFFE
Writing SCC 0x0000005C with 0x00FE001E
Writing SCC 0x00000100 with 0x003F1000
Writing SCC 0x00000104 with 0x0001F300
Writing SCC 0x00000108 with 0x00331000
Writing SCC 0x0000010C with 0x00019300
Writing SCC 0x00000118 with 0x003F1000
Writing SCC 0x0000011C with 0x0001F100
Writing SCC 0x000000F4 with 0x00000018
Writing SCC 0x000000F8 with 0x0BEC0000
Writing SCC 0x000000FC with 0xABE40000
Writing SCC 0x00000A14 with 0x00000000
Writing SCC 0x0000000C with 0x000000C2
Writing SCC 0x00000010 with 0x000000C2

Peripheral ID0:0x000000AD
Peripheral ID1:0x000000B0
Peripheral ID2:0x0000001B
Peripheral ID3:0x00000000
Peripheral ID4:0x0000000D
Peripheral ID5:0x000000F0
Peripheral ID6:0x00000005
Peripheral ID7:0x000000B1

Programming NOR Flash
PCIE clock configured...

Testing motherboard interfaces (FPGA build 117)...
SRAM 32MB test: PASSED
LAN9118   test: PASSED
KMI1/2    test: PASSED
MMC       test: PASSED
PB/LEDs   test: PASSED
FPGA UART test: PASSED
PCIe init test: PASSED
MAC addrs test: PASSED

The default boot selection will start in   1 seconds
Downloading the file <Image> from the TFTP server
[=======================================>]    9656 Kb
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
Booting Linux on physical CPU 0x100
Linux version 4.5.0-rc1+ (morse@melchizedek) (gcc version 4.9.3 20141031 (prerel
ease) (Linaro GCC 2014.11) ) #1839 SMP PREEMPT Fri Jan 29 15:05:57 GMT 2016
Boot CPU: AArch64 Processor [410fd033]
earlycon: Early serial console at MMIO 0x7ff80000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
EFI v2.50 by ARM Juno EFI Nov 24 2015 12:36:35
efi:  ACPI=0xf95b0000  ACPI 2.0=0xf95b0014  PROP=0xfe8db4d8
cma: Reserved 16 MiB at 0x00000000fd800000
psci: probing for conduit method from DT.
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS migration not required
PERCPU: Embedded 20 pages/cpu @ffff80097ff4f000 s42240 r8192 d31488 u81920
Detected VIPT I-cache on CPU0
CPU features: enabling workaround for ARM erratum 845719
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2060048
Kernel command line: console=ttyAMA0,115200 earlycon=pl011,0x7ff80000 root=/dev/
nfs nfsroot=10.xx.xx.xx:xx/aarch64-current resume=/dev/sda2 no_console_s
uspend ip=dhcp rw init=/bin/bash crashkernel=256M maxcpus=1
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 20480 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 65536 bytes
early log buf free: 14304(87%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
software IO TLB [mem 0xf54a0000-0xf94a0000] (64MB) mapped at [ffff8000754a0000-f
fff80007949ffff]
Memory: 8130452K/8371264K available (6007K kernel code, 524K rwdata, 2524K rodat
a, 592K init, 229K bss, 224428K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
    vmalloc : 0xffff000000000000 - 0xffff7bffbfff0000   (126974 GB)
    vmemmap : 0xffff7bffc0000000 - 0xffff7fffc0000000   (  4096 GB maximum)
              0xffff7bffc2000000 - 0xffff7bffe8000000   (   608 MB actual)
    fixed   : 0xffff7ffffa7fd000 - 0xffff7ffffac00000   (  4108 KB)
    PCI I/O : 0xffff7ffffae00000 - 0xffff7ffffbe00000   (    16 MB)
    modules : 0xffff7ffffc000000 - 0xffff800000000000   (    64 MB)
    memory  : 0xffff800000000000 - 0xffff800980000000   ( 38912 MB)
      .init : 0xffff8000008d7000 - 0xffff80000096b000   (   592 KB)
      .text : 0xffff800000080000 - 0xffff8000008d6c64   (  8540 KB)
      .data : 0xffff80000096b000 - 0xffff8000009ee200   (   525 KB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
Preemptible hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 64.
        RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=6
NR_IRQS:64 nr_irqs:64 0
GIC: Using split EOI/Deactivate mode
GICv2m: range[mem 0x2c1c0000-0x2c1c0fff], SPI[224:255]
Architected cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, m
ax_idle_ns: 440795202655 ns
sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer frequency.. 100.0
0 BogoMIPS (lpj=200000)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
ASID allocator initialised with 65536 entries
Remapping and enabling EFI services.
 EFI remap 0x0000000008000000 => 0000000020000000
  EFI remap 0x000000001c170000 => 0000000024000000
  EFI remap 0x00000000f94a0000 => 0000000024010000
  EFI remap 0x00000000f9520000 => 0000000024020000
  EFI remap 0x00000000f9530000 => 0000000024030000
  EFI remap 0x00000000f9540000 => 0000000024040000
  EFI remap 0x00000000f9570000 => 0000000024070000
  EFI remap 0x00000000f9580000 => 0000000024080000
  EFI remap 0x00000000f95c0000 => 00000000240a0000
  EFI remap 0x00000000f9640000 => 0000000024120000
  EFI remap 0x00000000f9650000 => 0000000024130000
  EFI remap 0x00000000f9720000 => 0000000024200000
  EFI remap 0x00000000f9730000 => 0000000024210000
  EFI remap 0x00000000f9740000 => 0000000024220000
  EFI remap 0x00000000f9780000 => 0000000024260000
  EFI remap 0x00000000f9790000 => 0000000024270000
  EFI remap 0x00000000f9800000 => 00000000242e0000
  EFI remap 0x00000000f9810000 => 00000000242f0000
  EFI remap 0x00000000f9820000 => 0000000024300000
  EFI remap 0x00000000fe820000 => 0000000024330000
  EFI remap 0x00000000fe830000 => 0000000024340000
  EFI remap 0x00000000fe840000 => 0000000024350000
  EFI remap 0x00000000fe870000 => 0000000024370000
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started at EL2
alternatives: patching kernel code
devtmpfs: initialized
DMI not present or invalid.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645
041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffff800000972000, 1 data @ ffff800000971000)
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
Serial: AMBA PL011 UART driver
7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 25, base_baud = 0) is a PL011 r
ev3
console [ttyAMA0] enabled
console [ttyAMA0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
HugeTLB registered 2 MB page size, pre-allocated 0 pages
ACPI: Interpreter disabled.
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
dmi: Firmware registration failed.
clocksource: Switched to clocksource arch_sys_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI: disabled
NET: Registered protocol family 2
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
kvm [1]: interrupt-controller@2c04f000 IRQ14
kvm [1]: timer IRQ4
kvm [1]: 8-bit VMID
kvm [1]: Hyp mode initialized successfully
futex hash table entries: 2048 (order: 6, 262144 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(0.432:1): initialized
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
fuse init (API version 7.24)
9p: Installing v9fs 9p2000 file system support
io scheduler noop registered
io scheduler cfq registered (default)
PCI host bridge /pcie-controller@30000000 ranges:
   IO 0x5f800000..0x5fffffff -> 0x5f800000
  MEM 0x50000000..0x57ffffff -> 0x50000000
  MEM 0x4000000000..0x40ffffffff -> 0x4000000000
pci-host-generic 40000000.pcie-controller: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff] (bus address [0x5f80000
0-0x5fffffff])
pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40ffffffff pref]
pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid
pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with
 'pcie_aspm=force'
pci 0000:08:00.0: reg 0x18: initial BAR value 0x00000000 invalid
pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x501fffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x4000003fff 64bit pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x2fff]
pci 0000:01:00.0: BAR 8: assigned [mem 0x50000000-0x501fffff]
pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x2fff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
pci 0000:02:1f.0: BAR 8: assigned [mem 0x50100000-0x501fffff]
pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:02:1f.0: BAR 7: assigned [io  0x2000-0x2fff]
pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff pref]
pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff 64bit]
pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f 64bit]
pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:0c.0: PCI bridge to [bus 06]
pci 0000:02:10.0: PCI bridge to [bus 07]
pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff 64bit]
pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
pci 0000:02:1f.0: PCI bridge to [bus 08]
pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
pci 0000:01:00.0: PCI bridge to [bus 02-08]
pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
pci 0000:00:00.0: PCI bridge to [bus 01-08]
pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
pci 0000:02:01.0: Signaling PME through PCIe PME interrupt
pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
pci 0000:02:02.0: Signaling PME through PCIe PME interrupt
pci 0000:02:03.0: Signaling PME through PCIe PME interrupt
pci 0000:02:0c.0: Signaling PME through PCIe PME interrupt
pci 0000:02:10.0: Signaling PME through PCIe PME interrupt
pci 0000:02:1f.0: Signaling PME through PCIe PME interrupt
pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
xenfs: not registering filesystem on non-xen platform
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
msm_serial: driver initialized
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sky2: driver version 1.30
sky2 0000:08:00.0: enabling device (0000 -> 0003)
sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
sky2 0000:08:00.0 (unnamed net_device) (uninitialized): Invalid MAC address, def
aulting to random
sky2 0000:08:00.0 eth0: addr c6:94:53:3d:70:00
libphy: smsc911x-mdio: probed
Generic PHY 18000000.etherne:01: attached PHY driver [Generic PHY] (mii_bus:phy_
addr=18000000.etherne:01, irq=-1)
smsc911x 18000000.ethernet eth1: MAC Address: 00:02:f7:00:60:c5
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-platform 7ffc0000.ehci: EHCI Host Controller
ehci-platform 7ffc0000.ehci: new USB bus registered, assigned bus number 1
ehci-platform 7ffc0000.ehci: irq 28, io mem 0x7ffc0000
ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
ohci-platform 7ffb0000.ohci: Generic Platform OHCI controller
ohci-platform 7ffb0000.ohci: new USB bus registered, assigned bus number 2
ohci-platform 7ffb0000.ohci: irq 27, io mem 0x7ffb0000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 33,0 (pio)
mmci-pl18x 1c050000.mmci: DMA channels RX none, TX none
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
EFI Variables Facility v0.08 2004-May-17
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Key type dns_resolver registered
registered taskstats version 1
rtc-efi rtc-efi: setting system clock to 2016-02-01 08:26:43 UTC (1454315203)
sky2 0000:08:00.0 eth0: enabling interface
smsc911x 18000000.ethernet eth1: SMSC911x/921x identified at 0xffff000000120000,
 IRQ: 31
usb 1-1: new high-speed USB device number 2 using ehci-platform
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.2: new high-speed USB device number 3 using ehci-platform
usb-storage 1-1.2:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1.2:1.0
atkbd serio0: keyboard reset failed on 1c060000.kmi
scsi 0:0:0:0: Direct-Access     TOSHIBA  TransMemory      1.00 PQ: 0 ANSI: 4
sd 0:0:0:0: [sda] 15155200 512-byte logical blocks: (7.76 GB/7.23 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DP
O or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI removable disk
atkbd serio1: keyboard reset failed on 1c070000.kmi
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.xx.xx.xx, my address is 10.xx.xx.xx
sky2 0000:08:00.0 eth0: disabling interface
IP-Config: Complete:
     device=eth1, hwaddr=00:02:f7:xx:xx:xx, ipaddr=10.xx.xx.xx, mask=255.255.255
.0, gw=10.xx.xx.xx
     host=10.xx.xx.xx, domain=cambridge.arm.com, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=10.xx.xx.xx, rootpath=     nameserver0=10.xx
.xx.xx, nameserver1=10.xx.xx.xx
Freezing user space processes ... (elapsed 0.000 seconds) done.
PM: Using 1 thread(s) for decompression.
PM: Loading and decompressing image data (94052 pages)...
PM: Image loading progress:   0%
PM: Image loading progress:  10%
PM: Image loading progress:  20%
PM: Image loading progress:  30%
PM: Image loading progress:  40%
PM: Image loading progress:  50%
PM: Image loading progress:  60%
PM: Image loading progress:  70%
PM: Image loading progress:  80%
PM: Image loading progress:  90%
PM: Image loading progress: 100%
PM: Image loading done.
PM: Read 376208 kbytes in 7.09 seconds (53.06 MB/s)
PM: quiesce of devices complete after 16.499 msecs
PM: late quiesce of devices complete after 0.938 msecs
PM: noirq quiesce of devices complete after 11.044 msecs
Disabling non-boot CPUs ...
PM: noirq restore of devices complete after 2.397 msecs
PM: early restore of devices complete after 0.917 msecs
serio serio0: device_attach() failed for 1c060000.kmi (1c060000.kmi), error: -51
7
serio serio1: device_attach() failed for 1c070000.kmi (1c070000.kmi), error: -51
7
PM: restore of devices complete after 93.241 msecs
serio serio0: device_attach() failed for 1c060000.kmi (1c060000.kmi), error: -51
7
Restarting tasks ... done.
atkbd serio0: keyboard reset failed on 1c060000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
atkbd serio1: keyboard reset failed on 1c070000.kmi
root@localhost:/sys/power#
root@localhost:/sys/power# uptime
 08:27:00 up 2 days, 16:57,  2 users,  load average: 0.37, 0.14, 0.09
root@localhost:/sys/power#


