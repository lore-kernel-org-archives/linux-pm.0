From: watanabe takanobu <tknv_watanabe@iiga.co.jp>
Subject: linux-pm 2.6.36-rc1 is wating root device then no more.
Date: Mon, 30 Aug 2010 14:07:02 +0900
Message-ID: <20100830135808.4963.B9FA9725@iiga.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

I try linux-pm kernel2.6.36-rc1 on Gumstix Overo MMC.
But after "Waiting for root device /dev/mmcblk0p2...",never more.
Should I test PM-kernel on NAND ?
Please suggest me some solution. 

This is log.
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-2.6.36-rc1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2116792 Bytes =  2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36-rc1 (tknv@Lenny55G) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #2 PREEMPT Mon Aug 30 12:52:44 JST 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Gumstix Overo
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 97536
Kernel command line: console=ttyS2,115200n8 mpurate=500 vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256MB 128MB = 384MB total
Memory: 385216k/385216k available, 8000k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xd8800000 - 0xf8000000   ( 504 MB)
    lowmem  : 0xc0000000 - 0xd8000000   ( 384 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0036000   ( 184 kB)
      .text : 0xc0036000 - 0xc0401000   (3884 kB)
      .data : 0xc0402000 - 0xc0448840   ( 283 kB)
SLUB: Genslabs=9, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/224/500 MHz
omap_hwmod: sr1_fck: missing clockdomain for sr1_fck.
omap_hwmod: sr2_fck: missing clockdomain for sr2_fck.
omap_hwmod: sr1_hwmod: cannot be enabled (3)
omap_hwmod: sr2_hwmod: cannot be enabled (3)
Reprogramming SDRC clock to 224791666 Hz
dpll3_m2_clk rate change failed: -22
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
Could not get gpios_ick
Could not get gpios_fck
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
omap_device_init:
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
Switched to new clocking rate (Crystal/Core/MPU): 26.0/500/224 MHz
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
get_curr_voltage: Available freq 166000000 != dpll freq 112395833.
get_curr_voltage: Available freq 166000000 != dpll freq 112395833.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 752
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
mtdoops: mtd device (mtddev=name/number) must be supplied
OneNAND driver initializing
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:01, irq=-1)
net eth0: MAC Address: 00:15:c9:28:c3:c7
smsc911x: Driver version 2008-10-21.
i2c /dev entries driver
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Registering the dns_resolver key type
omap_hwmod: Initialize debugfs support
Power Management for TI OMAP3.
smartreflex smartreflex.0: omap_smartreflex_probe: SmartReflex driver initialized
smartreflex smartreflex.1: omap_smartreflex_probe: SmartReflex driver initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VMMC1 on
regulator_init_complete: incomplete constraints, leaving VUSB3V1 on
regulator_init_complete: incomplete constraints, leaving VUSB1V8 on
regulator_init_complete: incomplete constraints, leaving VUSB1V5 on
Waiting for root device /dev/mmcblk0p2...

--
watanabe takanobu@iiga/
