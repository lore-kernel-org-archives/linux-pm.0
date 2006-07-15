From: Jason Lunz <lunz@falooley.org>
Subject: amd74xx crashes when resuming from STR
Date: Sat, 15 Jul 2006 17:05:18 -0400
Message-ID: <20060715210518.GA3263@opus.vpn-dev.reflex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: vojtech@suse.cz
Cc: linux-pm@lists.osdl.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On my laptop, suspend-to-ram works for all drivers with the exception of
the amd74xx ide driver. And even then, it only has problems when
accessing a UDMA hard drive. I know this because the system can use STR
reliably when booted from a livecd, so long as nothing accesses the hard
disk.

I'm running amd64 2.6.17 untainted. The motherboard and ide chipset are
nvidia:

# lspci
00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
00:06.1 Modem: nVidia Corporation nForce3 Audio (rev a2)
00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
01:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
01:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
01:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading Function (rev 01)
0a:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)

I know that the amd74xx driver is definitely the problem, because STR
works reliably when using the ide-generic driver. But in that case
there's no DMA and the drive is painfully slow. And the crash is not
DMA-related, because the cdrom also uses DMA, yet it does trouble-free
suspend/resume under amd74xx.

Here's info from driver load, and /proc:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23DA-20, ATA DISK drive
isa bounce pool size: 16 pages
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4241N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3

# cat /proc/ide/amd74xx
----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.13
South Bridge:                       0000:00:08.0
Revision:                           IDE 0xa5
Highest DMA rate:                   UDMA133
BM-DMA base:                        0x2080
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:       30ns      90ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns     120ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  16.6MB/s   3.3MB/s

Here's the crash that occurs post-resume, as captured by netconsole. I
compiled drivers/ide/ide-io.c with DEBUG_PM #defined:

netconsole: network logging started
Stopping tasks: ============================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: complete_power_step(step: 0, stat: 50, err: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
pnp: Device 00:0b disabled.
ACPI: PCI interrupt for device 0000:01:04.1 disabled
ACPI: PCI interrupt for device 0000:01:04.0 disabled
ACPI: PCI interrupt for device 0000:01:02.0 disabled

PCI: Enabling device 0000:01:02.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNK3] -> GSI 17 (level, low) -> IRQ 21
PM: Writing back config space on device 0000:01:02.0 at offset f (was 100, writing 10b)
PM: Writing back config space on device 0000:01:02.0 at offset 4 (was 0, writing e0104000)
PM: Writing back config space on device 0000:01:02.0 at offset 3 (was 0, writing 4000)
PM: Writing back config space on device 0000:01:02.0 at offset 1 (was 2, writing 106)
PM: Writing back config space on device 0000:01:04.0 at offset f (was 34001ff, writing 5c0010b)
PM: Writing back config space on device 0000:01:04.0 at offset e (was 0, writing 34fc)
PM: Writing back config space on device 0000:01:04.0 at offset d (was 0, writing 3400)
PM: Writing back config space on device 0000:01:04.0 at offset c (was 0, writing 30fc)
PM: Writing back config space on device 0000:01:04.0 at offset b (was 0, writing 3000)
PM: Writing back config space on device 0000:01:04.0 at offset a (was 0, writing e07ff000)
PM: Writing back config space on device 0000:01:04.0 at offset 8 (was 0, writing 31fff000)
PM: Writing back config space on device 0000:01:04.0 at offset 6 (was 40000000, writing b0050201)
PM: Writing back config space on device 0000:01:04.0 at offset 3 (was 824008, writing 82a810)
PM: Writing back config space on device 0000:01:04.0 at offset 1 (was 2100107, writing 2100007)
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNK1] -> GSI 19 (level, low) -> IRQ 16
PM: Writing back config space on device 0000:01:04.1 at offset f (was 34002ff, writing 5c0020a)
PM: Writing back config space on device 0000:01:04.1 at offset e (was 0, writing 3cfc)
PM: Writing back config space on device 0000:01:04.1 at offset d (was 0, writing 3c00)
PM: Writing back config space on device 0000:01:04.1 at offset c (was 0, writing 38fc)
PM: Writing back config space on device 0000:01:04.1 at offset b (was 0, writing 3800)
PM: Writing back config space on device 0000:01:04.1 at offset a (was 0, writing e0fff000)
PM: Writing back config space on device 0000:01:04.1 at offset 8 (was 0, writing 33fff000)
PM: Writing back config space on device 0000:01:04.1 at offset 7 (was e1000000, writing 32000000)
PM: Writing back config space on device 0000:01:04.1 at offset 6 (was 40000000, writing b0090601)
PM: Writing back config space on device 0000:01:04.1 at offset 3 (was 824008, writing 82a810)
PM: Writing back config space on device 0000:01:04.1 at offset 1 (was 2100103, writing 2100007)
ACPI: PCI Interrupt 0000:01:04.1[B] -> Link [LNK2] -> GSI 18 (level, low) -> IRQ 17
PM: Writing back config space on device 0000:01:04.2 at offset 4 (was 1, writing 7401)
PM: Writing back config space on device 0000:01:04.2 at offset 3 (was 0, writing 4010)
PM: Writing back config space on device 0000:01:04.2 at offset 1 (was 2100000, writing 2100107)
PM: Writing back config space on device 0000:0a:00.0 at offset f (was 1050100, writing 105010b)
PM: Writing back config space on device 0000:0a:00.0 at offset 6 (was 8, writing f8000008)
PM: Writing back config space on device 0000:0a:00.0 at offset 5 (was 8, writing f0000008)
PM: Writing back config space on device 0000:0a:00.0 at offset 4 (was 0, writing e2000000)
PM: Writing back config space on device 0000:0a:00.0 at offset 3 (was 0, writing 4000)
PM: Writing back config space on device 0000:0a:00.0 at offset 1 (was 2b00000, writing 2b00007)
pnp: Res cnt 3
pnp: res cnt 3
pnp: Encode io
pnp: Encode io
pnp: Encode irq
pnp: Failed to activate device 00:08.
pnp: Res cnt 1
pnp: res cnt 1
pnp: Encode irq
pnp: Failed to activate device 00:09.
pnp: Res cnt 4
pnp: res cnt 4
pnp: Encode io
pnp: Encode io
pnp: Encode irq
pnp: Encode dma
pnp: Device 00:0b activated.
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: complete_power_step(step: 1000, stat: 50, err: 0)
hda: start_power_step(step: 1001)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...
 done
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error

HARDWARE ERROR
CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 1370e9bdb9
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Machine check

Does this driver need special handling? I notice one other driver in
drivers/ide/pci, sc1200, implements its own pci_driver->suspend() and
pci_driver->resume() hooks. Maybe similar methods are needed in this
case?

thanks,

Jason
