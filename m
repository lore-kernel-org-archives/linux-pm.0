From: Guenter Roeck <linux@roeck-us.net>
Subject: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 09:05:27 -0800
Message-ID: <20160215170527.GA24453@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael,

I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
timers with utilization update callbacks' with next-20160215. An example
crash log and bisect results are attached below.

Please let me know if there is anything I can do to help tracking down
the problem.

Thanks,
Guenter

---

Building arm:beagle:multi_v7_defconfig:omap3-beagle ... running ..... failed (crashed)
------------
qemu log:

(process:26225): GLib-WARNING **: /build/glib2.0-ajuDY6/glib2.0-2.46.1/./glib/gmem.c:482: custom memory allocation vtable not supported
SMC cmd 0x1 val 0x3
SMC cmd 0x3 val 0x2
SMC cmd 0x3 val 0x32
SMC cmd 0x2 val 0x8000000

U-Boot SPL 2011.12 (Mar 01 2012 - 19:25:06)
Texas Instruments Revision detection unimplemented
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.bin
reading u-boot.bin
SMC cmd 0x1 val 0x3
SMC cmd 0x3 val 0x2
SMC cmd 0x3 val 0x32
SMC cmd 0x2 val 0x8000000


U-Boot 2011.12 (Mar 01 2012 - 19:25:06)

OMAP35XX-GP ES3.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
OMAP3 Beagle board + LPDDR/NAND
I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
NAND:  256 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - bad CRC, using default environment

ERROR : Unsupport USB mode
Check that mini-B USB cable is attached to the device
In:    serial
Out:   serial
Err:   serial
Beagle Rev C4
No EEPROM on expansion board
Die ID #51454d5551454d555400000051454d55
Net:   No ethernet found.
checking for preEnv.txt
reading preEnv.txt

** Unable to read "preEnv.txt" from mmc 0:1 **
Hit any key to stop autoboot:  2  1  0 
The user button is currently NOT pressed.
SD/MMC found on device 0
reading uEnv.txt

** Unable to read "uEnv.txt" from mmc 0:1 **
reading boot.scr

393 bytes read
Loaded script from boot.scr
Running bootscript from mmc0 ...
## Executing script at 80200000
reading uImage

6804376 bytes read
reading devicetree.dtb

63421 bytes read
Booting from boot.scr
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-4.5.0-rc4-next-20160215
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    6804312 Bytes = 6.5 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 84000000
   Booting using the fdt blob at 0x84000000
   Loading Kernel Image ... OK
OK
   Using Device Tree in place at 84000000, end 840127bc

Starting kernel ...

omap2_inth_read: Bad register 0x000020
omap2_inth_write: protection mode enable attempt
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc4-next-20160215 (groeck@mars) (gcc version 4.7.2 (GCC) ) #1 SMP Mon Feb 15 00:51:07 PST 2016
[    0.000000] CPU: ARMv7 Processor [410fc083] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine model: TI OMAP3 BeagleBoard
[    0.000000] cma: Reserved 64 MiB at 0x8b800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (iva sgx neon isp )
[    0.000000] PERCPU: Embedded 13 pages/cpu @cfb87000 s23296 r8192 d21760 u53248
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64512
[    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw rootwait earlyprintk fixrtc nocompcache vram=12M omapfb.mode=640x480MR-16@60 mpurate=auto doreboot
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 173888K/260096K available (9516K kernel code, 1115K rwdata, 4056K rodata, 2048K init, 341K bss, 20672K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc1041070   (14565 kB)
[    0.000000]       .init : 0xc1100000 - 0xc1300000   (2048 kB)
[    0.000000]       .data : 0xc1300000 - 0xc1416f40   (1116 kB)
[    0.000000]        .bss : 0xc1419000 - 0xc146e6e0   ( 342 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
[    0.000000] OMAP clockevent source: timer12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 200 Hz, resolution 5000000ns, wraps every 10737418237500000ns
[    0.000000] Console: colour dummy device 80x30
[    0.105000] Calibrating delay loop... 869.99 BogoMIPS (lpj=2174976)
[    0.105000] pid_max: default: 32768 minimum: 301
[    0.105000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.105000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.110000] CPU: Testing write buffer coherency: ok
[    0.115000] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.115000] Setting up static identity map for 0x80300000 - 0x80300098
[    0.130000] Brought up 1 CPUs
[    0.130000] SMP: Total of 1 processors activated (869.99 BogoMIPS).
[    0.130000] CPU: All CPU(s) started in SVC mode.
[    0.160000] devtmpfs: initialized
[    0.200000] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
[    0.210000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.215000] pinctrl core: initialized pinctrl subsystem
[    0.225000] NET: Registered protocol family 16
[    0.235000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.255000] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.255000] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.325000] omap_hdq1w_reset: hdq1w: softreset failed (waited 10000 usec)
[    0.340000] omap_hwmod: ssi: _wait_target_ready failed: -16
[    0.340000] omap_hwmod: ssi: cannot be enabled for reset (3)
[    0.340000] omap_hwmod: sham: _wait_target_ready failed: -16
[    0.340000] omap_hwmod: sham: cannot be enabled for reset (3)
[    0.345000] omap_hwmod: aes: _wait_target_ready failed: -16
[    0.345000] omap_hwmod: aes: cannot be enabled for reset (3)
[    0.450000] didn't get FRAMEDONE1/2/3 or TV interrupt
[    0.455000] cpuidle: using governor menu
[    0.455000] Reprogramming SDRC clock to 332000000 Hz
[    0.470000] omap_gpio 48310000.gpio: could not find pctldev for node /ocp/l4@48000000/scm@2000/pinmux@a00/pinmux_gpio1_pins, deferring probe
[    0.470000] OMAP GPIO hardware version 2.5
[    0.480000] irq: no irq domain found for /ocp/l4@48000000/scm@2000/pinmux@30 !
[    0.495000] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.495000] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.505000] of_amba_device_create(): amba_device_add() failed (-19) for /etb@540000000
[    0.505000] of_amba_device_create(): amba_device_add() failed (-19) for /etm@54010000
[    0.505000] No ATAGs?
[    0.505000] hw-breakpoint: debug architecture 0x0 unsupported.
[    0.510000] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.510000] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.510000] OMAP DMA hardware revision 4.0
[    0.520000] Serial: AMBA PL011 UART driver
[    0.555000] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
[    0.565000] vgaarb: loaded
[    0.570000] SCSI subsystem initialized
[    0.570000] usbcore: registered new interface driver usbfs
[    0.570000] usbcore: registered new interface driver hub
[    0.570000] usbcore: registered new device driver usb
[    0.575000] omap_i2c 48070000.i2c: bus 0 rev3.3 at 2600 kHz
[    0.580000] omap_i2c 48072000.i2c: bus 1 rev3.3 at 100 kHz
[    0.580000] omap_i2c 48060000.i2c: bus 2 rev3.3 at 100 kHz
[    0.580000] pps_core: LinuxPPS API ver. 1 registered
[    0.580000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.580000] PTP clock support registered
[    0.580000] EDAC MC: Ver: 3.0.0
[    0.610000] NET: Registered protocol family 2
[    0.615000] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.615000] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.615000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.615000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.615000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.615000] NET: Registered protocol family 1
[    0.620000] RPC: Registered named UNIX socket transport module.
[    0.620000] RPC: Registered udp transport module.
[    0.620000] RPC: Registered tcp transport module.
[    0.620000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.625000] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 1 counters available
[    0.630000] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.635000] workingset: timestamp_bits=28 max_order=16 bucket_order=0
[    0.650000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.655000] NFS: Registering the id_resolver key type
[    0.655000] Key type id_resolver registered
[    0.655000] Key type id_legacy registered
[    0.655000] ntfs: driver 2.1.32 [Flags: R/O].
[    0.660000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.660000] io scheduler noop registered
[    0.660000] io scheduler deadline registered
[    0.660000] io scheduler cfq registered (default)
[    0.675000] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
[    0.675000] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
[    0.675000] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size 36
[    0.810000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.815000] SuperH (H)SCI(F) driver initialized
[    0.815000] msm_serial: driver initialized
[    0.815000] omap_uart 4806a000.serial: no wakeirq for uart0
[    0.820000] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
[    0.820000] omap_uart 4806c000.serial: no wakeirq for uart1
[    0.820000] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
[    0.820000] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
[    0.845000] console [ttyO2] enabled
[    0.845000] STMicroelectronics ASC driver initialized
[    0.850000] [drm] Initialized drm 1.1.0 20060810
[    0.885000] brd: module loaded
[    0.895000] loop: module loaded
[    0.905000] twl 0-0048: PIH (irq 23) chaining IRQs 307..315
[    0.905000] twl 0-0048: power (irq 312) chaining IRQs 315..322
[    0.960000] twl4030_gpio twl4030-gpio: gpio (irq 307) chaining IRQs 323..340
[    0.985000] libphy: Fixed MDIO Bus: probed
[    0.990000] CAN device driver interface
[    0.995000] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    0.995000] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.000000] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    1.000000] usbcore: registered new interface driver pegasus
[    1.000000] usbcore: registered new interface driver asix
[    1.000000] usbcore: registered new interface driver ax88179_178a
[    1.005000] usbcore: registered new interface driver cdc_ether
[    1.005000] usbcore: registered new interface driver smsc75xx
[    1.005000] usbcore: registered new interface driver smsc95xx
[    1.005000] usbcore: registered new interface driver net1080
[    1.005000] usbcore: registered new interface driver cdc_subset
[    1.005000] usbcore: registered new interface driver zaurus
[    1.005000] usbcore: registered new interface driver cdc_ncm
[    1.010000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.010000] ehci-pci: EHCI PCI platform driver
[    1.010000] ehci-platform: EHCI generic platform driver
[    1.010000] ehci-omap: OMAP-EHCI Host Controller driver
[    1.010000] ehci-omap 48064800.ehci: Can't get PHY device for port 1: -517
[    1.010000] ehci-orion: EHCI orion driver
[    1.010000] SPEAr-ehci: EHCI SPEAr driver
[    1.015000] ehci-st: EHCI STMicroelectronics driver
[    1.015000] ehci-exynos: EHCI EXYNOS driver
[    1.015000] ehci-atmel: EHCI Atmel driver
[    1.015000] tegra-ehci: Tegra EHCI driver
[    1.015000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.015000] ohci-pci: OHCI PCI platform driver
[    1.015000] ohci-platform: OHCI generic platform driver
[    1.015000] ohci-omap3: OHCI OMAP3 driver
[    1.015000] ohci-omap3 48064400.ohci: OHCI Host Controller
[    1.015000] ohci-omap3 48064400.ohci: new USB bus registered, assigned bus number 1
[    1.020000] ohci-omap3 48064400.ohci: irq 92, io mem 0x48064400
[    1.080000] hub 1-0:1.0: USB hub found
[    1.080000] hub 1-0:1.0: 3 ports detected
[    1.085000] SPEAr-ohci: OHCI SPEAr driver
[    1.085000] ohci-st: OHCI STMicroelectronics driver
[    1.085000] ohci-atmel: OHCI Atmel driver
[    1.090000] usbcore: registered new interface driver usb-storage
[    1.095000] mousedev: PS/2 mouse device common for all mice
[    1.110000] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
[    1.115000] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    1.120000] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 48070000.i2c:twl@48 as rtc0
[    1.120000] i2c /dev entries driver
[    1.160000] sdhci: Secure Digital Host Controller Interface driver
[    1.160000] sdhci: Copyright(c) Pierre Ossman
[    1.215000] Synopsys Designware Multimedia Card Interface Driver
[    1.225000] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.260000] mmc0: host does not support reading read-only switch, assuming write-enable
[    1.260000] mmc0: new SD card at address 4567
[    1.270000] ledtrig-cpu: registered to indicate activity on CPUs
[    1.275000] usbcore: registered new interface driver usbhid
[    1.275000] usbhid: USB HID core driver
[    1.295000] NET: Registered protocol family 10
[    1.305000] mmcblk0: mmc0:4567 QEMU! 256 MiB 
[    1.315000]  mmcblk0: p1 p2
[    1.320000] sit: IPv6 over IPv4 tunneling driver
[    1.320000] NET: Registered protocol family 17
[    1.325000] can: controller area network core (rev 20120528 abi 9)
[    1.325000] NET: Registered protocol family 29
[    1.325000] can: raw protocol (rev 20120528)
[    1.325000] can: broadcast manager protocol (rev 20120528 t)
[    1.325000] can: netlink gateway (rev 20130117) max_hops=1
[    1.325000] Key type dns_resolver registered
[    1.330000] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
[    1.330000] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    1.330000] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
[    1.330000] omap2_set_init_voltage: unable to set vdd_core
[    1.340000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    1.340000] pgd = c0204000
[    1.340000] [00000000] *pgd=00000000
[    1.340000] Internal error: Oops: 80000005 [#1] SMP ARM
[    1.340000] Modules linked in:
[    1.340000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215 #1
[    1.340000] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[    1.340000] task: cb060000 ti: cb05a000 task.ti: cb05a000
[    1.340000] PC is at 0x0
[    1.340000] LR is at arch_send_call_function_single_ipi+0x34/0x38
[    1.340000] pc : [<00000000>]    lr : [<c030de78>]    psr: 20000193
[    1.340000] sp : cb05b7c0  ip : 00000000  fp : cb05b83c
[    1.340000] r10: cfb8c0c0  r9 : 00000000  r8 : cb18a4c0
[    1.340000] r7 : 00000005  r6 : 00000005  r5 : cb5c0334  r4 : 00000000
[    1.340000] r3 : 00000000  r2 : c0c06a7c  r1 : 00000003  r0 : c0c06a7c
[    1.340000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.340000] Control: 10c5387d  Table: 80204059  DAC: 00000051
[    1.340000] Process swapper/0 (pid: 1, stack limit = 0xcb05a220)
[    1.340000] Stack: (0xcb05b7c0 to 0xcb05c000)
[    1.340000] b7c0: 00000000 c03b3350 4fdec700 00000000 00000005 c0959a84 ffffffff 00000000
[    1.340000] b7e0: ffffffff cb18a4c0 cfb8c0c0 c03732d8 4c4b4000 cb18a4c0 cfb8c0c0 cfb8c0c0
[    1.340000] b800: 0e979000 cb18a4c0 cfb8c0c0 00000005 0e979000 c12130c0 00000000 cfb8c0c0
[    1.340000] b820: cb05b83c c0360d28 00000000 cb18a4c0 cfb8c0c0 60000193 cb05b84c c0360fc0
[    1.340000] b840: cb18a4c0 cb18a8b4 cb05b87c c0361b74 cfb8c100 00000141 cb05b934 cb1c1cc0
[    1.340000] b860: 00000002 00000000 00000000 00000048 c1416d0c cb0096c0 00000001 c0381de0
[    1.340000] b880: c1416080 cfb8c100 00000400 cb0096c0 cb009720 00000000 00000038 cb003000
[    1.340000] b8a0: 00000000 cb05b9c4 00000a28 c0381ea4 cb0096c0 cb0096d0 00000000 c0385150
[    1.340000] b8c0: c03850ac c1211518 00000000 c038168c 00000155 c0381788 c0932830 20000013
[    1.340000] b8e0: ffffffff cb05b924 00000000 c030bad4 00000001 00000009 00000002 fa070024
[    1.340000] b900: cb127c10 00009401 cb05b9b8 c1302100 00000000 00000000 cb05b9c4 00000a28
[    1.340000] b920: 00000000 cb05b940 00009601 c0932830 20000013 ffffffff 00000051 c093261c
[    1.340000] b940: 00000014 cb127c58 00000002 00000001 000f4240 cb127c10 1443fd00 00000001
[    1.340000] b960: c1302100 cb127c58 cb05b9b8 00000002 c145d438 ffff16ac 00000001 c0928358
[    1.340000] b980: cb127c74 cb127c58 00000002 cb05b9b8 cb05ba97 00000001 cb05ba97 00000001
[    1.340000] b9a0: 00000001 c0928538 00000000 cb518000 cb513740 c07726c4 0000004b cfb80001
[    1.340000] b9c0: cb513740 0001004b 017d0001 cb05ba97 00000000 c076dc30 00000001 00000000
[    1.340000] b9e0: 00000004 000000b9 000000ba cb518000 000000ba 000000b9 00000001 c076dd70
[    1.340000] ba00: 00000000 00000000 cfb8c100 cb518000 000000ba 00000001 00000001 cb05ba97
[    1.340000] ba20: 00000001 000000b9 00000000 c076dfcc c099a208 cb59d048 00000001 c1336dd0
[    1.340000] ba40: a0000113 00000000 00000001 cb05ba97 0000005e 00000004 00000001 00000000
[    1.340000] ba60: 00000000 000ee098 000ee098 c077fd34 0000000d c09e51f0 c09e51d0 cb51f400
[    1.340000] ba80: ffffffff 000ee098 000ee098 c068cb48 00000000 c09c157c cb019180 c067887c
[    1.340000] baa0: cb51f400 c067a700 000ee098 c09c160c cb015780 00000000 3b9aca00 cb5bdcc0
[    1.340000] bac0: cb51f400 00000000 00000000 00000000 000ee098 c067ab5c 000ee098 000ee098
[    1.340000] bae0: cb5bdcc0 000ee098 000ee098 000ee098 cfb87050 00000000 000ee098 c067c614
[    1.340000] bb00: cb5bdcc0 000ee098 000ee098 c0765ad4 1dcd6500 cb5bdc80 00000000 07735940
[    1.340000] bb20: cb5bdc80 cfb87050 cb5bdcc0 00000000 000ee098 c076660c 000ee098 cb5c11d0
[    1.340000] bb40: cb05bb90 00124f80 00124f80 00124f80 07735940 1dcd6500 ffffffff cb5c1100
[    1.340000] bb60: 00000000 00000000 c145dc8c cb5c0280 00000000 00000001 cb05bb90 c0958e78
[    1.340000] bb80: cb05bb8c c13cb404 00000000 00000000 00000010 0007a120 0001e848 00000021
[    1.340000] bba0: ffffffff ee222d90 00000000 00000000 00000000 00000010 cfb8b598 c13cb310
[    1.340000] bbc0: c1302578 c095ca58 c1302578 00000000 cb5c1100 00000000 000927c0 cb5bdfc0
[    1.340000] bbe0: c120e300 00000000 ee32cf60 00000000 c13cb310 cb5c1100 00000000 cb5c0304
[    1.340000] bc00: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c095cd04 c145dc8c 00000001
[    1.340000] bc20: cb5c1100 cb5c1100 00000000 c145dc8c c1302578 00000003 cb5c1100 00000000
[    1.340000] bc40: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c0959c5c cb5c1100 00000000
[    1.340000] bc60: 00000000 c095a2dc c0c0df58 00000001 0000ffff 00000001 00000000 00000000
[    1.340000] bc80: cb5bdc00 000927c0 0001e848 000493e0 0001e848 000927c0 0007a120 00000000
[    1.340000] bca0: 00000000 00000000 00000000 c13cb310 00000000 00000000 00000000 00000000
[    1.340000] bcc0: 00000000 00000000 ffffffe0 cb5c1160 cb5c1160 c095abf4 0001e848 000927c0
[    1.340000] bce0: cb5c0280 c13cb0a8 c13cb0a8 cb5bdf00 cb5c1184 cb5c1184 cb11e600 00000000
[    1.340000] bd00: c13cb128 cb5bf460 00000001 00000003 00000000 00000000 cb5c11ac cb5c11ac
[    1.340000] bd20: ffff0001 cb5c11b8 cb5c11b8 00000000 00000000 cb060000 00000000 00000000
[    1.340000] bd40: 00000000 cb5c11d8 cb5c11d8 00000000 cb5bdf80 cb5bdec0 cb5c1100 c095a5f0
[    1.340000] bd60: 00000000 cb11e600 00000000 c1212594 60000013 00000001 00000000 c13cb110
[    1.340000] bd80: c13acc68 c13cb0a8 c13cb440 c13cb440 00000000 00000000 00000000 c075674c
[    1.340000] bda0: c13cb440 cb00cc5c cb169db4 00000000 c1334248 c13cb488 c145dc8c c0959764
[    1.340000] bdc0: ffffffed cfb87050 cb5e2600 c095d670 ffffffed cb5e2610 fffffdfb c0758e48
[    1.340000] bde0: c0758df8 cb5e2610 c1459090 c1459098 00000000 c07577b0 00000000 00000000
[    1.340000] be00: cb05be30 c0757a68 00000001 c145906c 00000000 c0755d3c cb00cb70 cb5938b8
[    1.340000] be20: cb5e2610 cb5e2644 c13aca58 c0757534 cb5e2610 00000001 00000000 cb5e2610
[    1.340000] be40: cb5e2610 c13aca58 c13acaa8 c0756bc0 cb5e2610 00000000 cb5e2618 c07550c0
[    1.340000] be60: 00000000 c0587884 cb05beb8 cb5e2600 00000000 cb5e2600 cb5e2610 c1419000
[    1.340000] be80: c110362c c11a183c 00000000 c0758fdc 00000000 cb05beb8 cb5e2600 cb5bdb00
[    1.340000] bea0: c1419000 c07597a8 c0ead2ac c1306788 c1306788 c1112510 00000000 00000000
[    1.340000] bec0: c0ead2ac 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.340000] bee0: 00000000 00000000 00000000 c110f828 c110fabc c110fac4 c110fabc c1103648
[    1.340000] bf00: c1306788 c0301d28 0000006f cb05bf28 c035a8bc c035a8cc 60000013 ffffffff
[    1.340000] bf20: 00000051 c058b428 c0ff5b24 c0c1da88 0000011a c035ab48 c11a183c c0ea7034
[    1.340000] bf40: c0ff451c 00000000 00000007 00000007 c1335704 cfb96300 c120de7c 00000007
[    1.340000] bf60: c11a1834 c1419000 0000011a c11a183c c1100598 c1100dc4 00000007 00000007
[    1.340000] bf80: 00000000 c1100598 00000000 c0b0bcfc 00000000 00000000 00000000 00000000
[    1.340000] bfa0: 00000000 c0b0bd04 00000000 c0307e78 00000000 00000000 00000000 00000000
[    1.340000] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.340000] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.340000] [<c030de78>] (arch_send_call_function_single_ipi) from [<c03b3350>] (irq_work_queue_on+0x90/0x100)
[    1.340000] [<c03b3350>] (irq_work_queue_on) from [<c0959a84>] (cpufreq_update_util+0x40/0x4c)
[    1.340000] [<c0959a84>] (cpufreq_update_util) from [<c03732d8>] (enqueue_task_rt+0x28/0x26c)
[    1.340000] [<c03732d8>] (enqueue_task_rt) from [<c0360d28>] (activate_task+0x60/0x64)
[    1.340000] [<c0360d28>] (activate_task) from [<c0360fc0>] (ttwu_do_activate.constprop.13+0x34/0x68)
[    1.340000] [<c0360fc0>] (ttwu_do_activate.constprop.13) from [<c0361b74>] (try_to_wake_up+0x1a0/0x318)
[    1.340000] [<c0361b74>] (try_to_wake_up) from [<c0381de0>] (handle_irq_event_percpu+0xdc/0x15c)
[    1.340000] [<c0381de0>] (handle_irq_event_percpu) from [<c0381ea4>] (handle_irq_event+0x44/0x68)
[    1.340000] [<c0381ea4>] (handle_irq_event) from [<c0385150>] (handle_level_irq+0xa4/0x13c)
[    1.340000] [<c0385150>] (handle_level_irq) from [<c038168c>] (generic_handle_irq+0x18/0x28)
[    1.340000] [<c038168c>] (generic_handle_irq) from [<c0381788>] (__handle_domain_irq+0x54/0xb0)
[    1.340000] [<c0381788>] (__handle_domain_irq) from [<c030bad4>] (__irq_svc+0x54/0x70)
[    1.340000] [<c030bad4>] (__irq_svc) from [<c0932830>] (omap_i2c_xfer+0x320/0x5a0)
[    1.340000] [<c0932830>] (omap_i2c_xfer) from [<c0928358>] (__i2c_transfer+0x140/0x29c)
[    1.340000] [<c0928358>] (__i2c_transfer) from [<c0928538>] (i2c_transfer+0x84/0xd4)
[    1.340000] [<c0928538>] (i2c_transfer) from [<c07726c4>] (regmap_i2c_read+0x48/0x64)
[    1.340000] [<c07726c4>] (regmap_i2c_read) from [<c076dc30>] (_regmap_raw_read+0xa4/0x110)
[    1.340000] [<c076dc30>] (_regmap_raw_read) from [<c076dd70>] (regmap_raw_read+0xd4/0x170)
[    1.340000] [<c076dd70>] (regmap_raw_read) from [<c076dfcc>] (regmap_bulk_read+0x1c0/0x2b0)
[    1.340000] [<c076dfcc>] (regmap_bulk_read) from [<c077fd34>] (twl_i2c_read+0x48/0x8c)
[    1.340000] [<c077fd34>] (twl_i2c_read) from [<c068cb48>] (twl4030smps_get_voltage+0x44/0x60)
[    1.340000] [<c068cb48>] (twl4030smps_get_voltage) from [<c067887c>] (_regulator_get_voltage+0x68/0xb8)
[    1.340000] [<c067887c>] (_regulator_get_voltage) from [<c067a700>] (_regulator_do_set_voltage+0x48/0x320)
[    1.340000] [<c067a700>] (_regulator_do_set_voltage) from [<c067ab5c>] (regulator_set_voltage_unlocked+0xcc/0x220)
[    1.340000] [<c067ab5c>] (regulator_set_voltage_unlocked) from [<c067c614>] (regulator_set_voltage+0x28/0x54)
[    1.340000] [<c067c614>] (regulator_set_voltage) from [<c0765ad4>] (_set_opp_voltage+0x34/0x90)
[    1.340000] [<c0765ad4>] (_set_opp_voltage) from [<c076660c>] (dev_pm_opp_set_rate+0x19c/0x288)
[    1.340000] [<c076660c>] (dev_pm_opp_set_rate) from [<c0958e78>] (__cpufreq_driver_target+0x180/0x2a0)
[    1.340000] [<c0958e78>] (__cpufreq_driver_target) from [<c095ca58>] (dbs_check_cpu+0x1ac/0x1e8)
[    1.340000] [<c095ca58>] (dbs_check_cpu) from [<c095cd04>] (cpufreq_governor_dbs+0x1fc/0x608)
[    1.340000] [<c095cd04>] (cpufreq_governor_dbs) from [<c0959c5c>] (__cpufreq_governor+0x1a8/0x204)
[    1.340000] [<c0959c5c>] (__cpufreq_governor) from [<c095a2dc>] (cpufreq_init_policy+0x60/0x8c)
[    1.340000] [<c095a2dc>] (cpufreq_init_policy) from [<c095a5f0>] (cpufreq_online+0x2e8/0x708)
[    1.340000] [<c095a5f0>] (cpufreq_online) from [<c075674c>] (subsys_interface_register+0x80/0xc4)
[    1.340000] [<c075674c>] (subsys_interface_register) from [<c0959764>] (cpufreq_register_driver+0x144/0x1a0)
[    1.340000] [<c0959764>] (cpufreq_register_driver) from [<c095d670>] (dt_cpufreq_probe+0x64/0xe8)
[    1.340000] [<c095d670>] (dt_cpufreq_probe) from [<c0758e48>] (platform_drv_probe+0x50/0xb0)
[    1.340000] [<c0758e48>] (platform_drv_probe) from [<c07577b0>] (driver_probe_device+0x1f4/0x2b0)
[    1.340000] [<c07577b0>] (driver_probe_device) from [<c0755d3c>] (bus_for_each_drv+0x44/0x8c)
[    1.340000] [<c0755d3c>] (bus_for_each_drv) from [<c0757534>] (__device_attach+0x9c/0x100)
[    1.340000] [<c0757534>] (__device_attach) from [<c0756bc0>] (bus_probe_device+0x84/0x8c)
[    1.340000] [<c0756bc0>] (bus_probe_device) from [<c07550c0>] (device_add+0x33c/0x528)
[    1.340000] [<c07550c0>] (device_add) from [<c0758fdc>] (platform_device_add+0xa8/0x20c)
[    1.340000] [<c0758fdc>] (platform_device_add) from [<c07597a8>] (platform_device_register_full+0xe0/0x108)
[    1.340000] [<c07597a8>] (platform_device_register_full) from [<c1112510>] (omap2_common_pm_late_init+0xc8/0x10c)
[    1.340000] [<c1112510>] (omap2_common_pm_late_init) from [<c110f828>] (omap_common_late_init+0xc/0x14)
[    1.340000] [<c110f828>] (omap_common_late_init) from [<c110fac4>] (omap3_init_late+0x8/0x14)
[    1.340000] [<c110fac4>] (omap3_init_late) from [<c1103648>] (init_machine_late+0x1c/0x90)
[    1.340000] [<c1103648>] (init_machine_late) from [<c0301d28>] (do_one_initcall+0x84/0x1d4)
[    1.340000] [<c0301d28>] (do_one_initcall) from [<c1100dc4>] (kernel_init_freeable+0x120/0x1ec)
[    1.340000] [<c1100dc4>] (kernel_init_freeable) from [<c0b0bd04>] (kernel_init+0x8/0xec)
[    1.340000] [<c0b0bd04>] (kernel_init) from [<c0307e78>] (ret_from_fork+0x14/0x3c)
[    1.340000] Code: bad PC value
[    1.340000] ---[ end trace 384223760a5ee799 ]---
[    1.340000] Kernel panic - not syncing: Fatal exception in interrupt
[    1.340000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

---
bisect results:

# bad: [2625f908fc0cbd7e40483217772888529ecbdfd1] Add linux-next specific files for 20160215
# good: [18558cae0272f8fd9647e69d3fec1565a7949865] Linux 4.5-rc4
git bisect start 'HEAD' 'v4.5-rc4'
# bad: [1e384dbfcb9c2b5b3c12cf3d5acc35359014decb] Merge remote-tracking branch 'device-mapper/for-next'
git bisect bad 1e384dbfcb9c2b5b3c12cf3d5acc35359014decb
# good: [0e6f5b65ea4d3669333fd6bc8149563051128b77] Merge branch 'dmi/master'
git bisect good 0e6f5b65ea4d3669333fd6bc8149563051128b77
# bad: [1e07223f47ba25129fb76cabd65b7e0a96115fa4] Merge remote-tracking branch 'mtd/master'
git bisect bad 1e07223f47ba25129fb76cabd65b7e0a96115fa4
# good: [667f00630ebefc4d73aa105c6ab254e4aec867f8] Merge branch 'local-checksum-offload'
git bisect good 667f00630ebefc4d73aa105c6ab254e4aec867f8
# good: [13adf6dd7a6d92ddecae17435f9639b94221dbbb] Merge remote-tracking branch 'libata/for-next'
git bisect good 13adf6dd7a6d92ddecae17435f9639b94221dbbb
# good: [11e70824e75f2cfbad9ae066ca5b29e1c361f19e] mwifiex: firmware dump support for w8997 chipset
git bisect good 11e70824e75f2cfbad9ae066ca5b29e1c361f19e
# bad: [dbf2f2bc4eea54e5cd2b59b9785eca07903cad20] Merge remote-tracking branch 'pm/linux-next'
git bisect bad dbf2f2bc4eea54e5cd2b59b9785eca07903cad20
# good: [02063010fc4dbf3ce0c5e114ddb68386a5f2345d] Merge branch 'pm-sleep' into linux-next
git bisect good 02063010fc4dbf3ce0c5e114ddb68386a5f2345d
# bad: [bd3f1697ffaa48b124e7384a7a68923d8f9724d0] cpufreq: governor: Rename skip_work to work_count
git bisect bad bd3f1697ffaa48b124e7384a7a68923d8f9724d0
# bad: [d51563226a1dc641cfaf3bfeb330a00a37101bd0] cpufreq: governor: Rename some data types and variables
git bisect bad d51563226a1dc641cfaf3bfeb330a00a37101bd0
# bad: [302352f51398cfd732c99daa899e43100e0e0341] cpufreq: governor: Replace timers with utilization update callbacks
git bisect bad 302352f51398cfd732c99daa899e43100e0e0341
# good: [e3f08fbcc76864cebe04219c8b5a77acf5fa3fa8] cpufreq: intel_pstate: Replace timers with utilization update callbacks
git bisect good e3f08fbcc76864cebe04219c8b5a77acf5fa3fa8
# first bad commit: [302352f51398cfd732c99daa899e43100e0e0341] cpufreq: governor: Replace timers with utilization update callbacks
