From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v2 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Thu, 6 Oct 2016 20:05:35 +0200
Message-ID: <57F6926F.1070707@math.uni-bielefeld.de>
References: <CGME20160919105545eucas1p1026e435bbaeb1f5c866a9abcdd051464@eucas1p1.samsung.com>
 <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:57932 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752269AbcJFSFn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 14:05:43 -0400
In-Reply-To: <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello Marek,

I'm using the patches from the v4.8-clocks-pm-v2 branch plus the ones
from the v4.8-clocks-pm-v2 branch on top of 4.8.0.

I see some warnings on boot coming from driver core. It appears that the
warnings are actually meaningful, since IOMMUs stop working completly.
E.g. if I modprobe s5p-mfc later, firmware loading fails because
apparantly the IOMMU domain isn't online.

> WARNING: CPU: 0 PID: 1 at drivers/base/core.c:356 device_links_driver_bound+0x124/0x12c

I added some debug printk() to device_links_driver_bound(), to show the
link status. Apparantly it is always DEVICE_LINK_AVAILABLE.

Here's the (semi) full log:
> [    0.000000] Booting Linux on physical CPU 0xa00
> [    0.000000] Linux version 4.8.0-vanilla+ (liquid@chidori) (gcc version 4.9.3 (Gentoo 4.9.3 p1.5, pie-0.6.4) ) #3 SMP PREEMPT Thu Oct 6 19:14:15 CEST 2016
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt:Machine model: Hardkernel ODROID-X2 board based on Exynos4412
> [    0.000000] Reserved memory: created DMA memory pool at 0xbf700000, size 8 MiB
> [    0.000000] OF: reserved mem: initialized node region_mfc_right, compatible id shared-dma-pool
> [    0.000000] Reserved memory: created DMA memory pool at 0xbe700000, size 16 MiB
> [    0.000000] OF: reserved mem: initialized node region_mfc_left, compatible id shared-dma-pool
> [    0.000000] cma: Reserved 128 MiB at 0xb6400000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] Samsung CPU ID: 0xe4412220
> [    0.000000] Running under secure firmware.
> [    0.000000] percpu: Embedded 14 pages/cpu @eefb3000 s26176 r8192 d22976 u57344
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516352
> [    0.000000] Kernel command line: video=HDMI-A-1:1280x720M@60 console=ttySAC1,115200n8 root=PARTUUID=8c900d97-367f-47a9-bd66-6eced1a29836 rootfstype=f2fs rootwait ro earlyprintk console=tty1 console=ttySAC1,115200
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 1913244K/2071552K available (6144K kernel code, 223K rwdata, 1432K rodata, 1024K init, 246K bss, 27236K reserved, 131072K cma-reserved, 1154048K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0700000   (7136 kB)
> [    0.000000]       .init : 0xc0900000 - 0xc0a00000   (1024 kB)
> [    0.000000]       .data : 0xc0a00000 - 0xc0a37fc0   ( 224 kB)
> [    0.000000]        .bss : 0xc0a39000 - 0xc0a76a08   ( 247 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 32.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> [    0.000000] L2C: platform provided aux values permit register corruption.
> [    0.000000] L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 8 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
> [    0.000000] L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
> [    0.000000] Exynos4x12 clocks: sclk_apll = 1000000000, sclk_mpll = 800000000
> [    0.000000]  sclk_epll = 96000000, sclk_vpll = 350000000, arm_clk = 1000000000
> [    0.000000] Switching to timer-based delay loop, resolution 41ns
> [    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.000004] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> [    0.000263] Console: colour dummy device 80x30
> [    0.000978] console [tty1] enabled
> [    0.001003] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=120000)
> [    0.001039] pid_max: default: 32768 minimum: 301
> [    0.001118] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.001142] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.001577] CPU: Testing write buffer coherency: ok
> [    0.001875] CPU0: thread -1, cpu 0, socket 10, mpidr 80000a00
> [    0.002240] Setting up static identity map for 0x40100000 - 0x40100058
> [    0.055360] CPU1: thread -1, cpu 1, socket 10, mpidr 80000a01
> [    0.075335] CPU2: thread -1, cpu 2, socket 10, mpidr 80000a02
> [    0.095316] CPU3: thread -1, cpu 3, socket 10, mpidr 80000a03
> [    0.095374] Brought up 4 CPUs
> [    0.095445] SMP: Total of 4 processors activated (192.00 BogoMIPS).
> [    0.095464] CPU: All CPU(s) started in SVC mode.
> [    0.096280] devtmpfs: initialized
> [    0.110373] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
> [    0.110612] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
> [    0.114190] pinctrl core: initialized pinctrl subsystem
> [    0.114738] lcd0-power-domain@10023C80 has as child subdomain: tv-power-domain@10023C20.
> [    0.115573] NET: Registered protocol family 16
> [    0.117150] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.134991] cpuidle: using governor ladder
> [    0.154989] cpuidle: using governor menu
> [    0.155398] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
> [    0.155434] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.197368] SCSI subsystem initialized
> [    0.197498] usbcore: registered new interface driver usbfs
> [    0.197568] usbcore: registered new interface driver hub
> [    0.197664] usbcore: registered new device driver usb
> [    0.198081] s3c-i2c 13860000.i2c: slave address 0x10
> [    0.198111] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
> [    0.198570] s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
> [    0.198763] s3c-i2c 13870000.i2c: slave address 0x10
> [    0.198791] s3c-i2c 13870000.i2c: bus frequency set to 390 KHz
> [    0.199046] s3c-i2c 13870000.i2c: i2c-1: S3C I2C adapter
> [    0.199192] s3c-i2c 13880000.i2c: slave address 0x00
> [    0.199218] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
> [    0.199375] s3c-i2c 13880000.i2c: i2c-2: S3C I2C adapter
> [    0.199481] s3c-i2c 138e0000.i2c: slave address 0x00
> [    0.199506] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
> [    0.199758] s3c-i2c 138e0000.i2c: i2c-8: S3C I2C adapter
> [    0.200052] Linux video capture interface: v2.00
> [    0.205439] Advanced Linux Sound Architecture Driver Initialized.
> [    0.205901] Bluetooth: Core ver 2.21
> [    0.205947] NET: Registered protocol family 31
> [    0.205966] Bluetooth: HCI device and connection manager initialized
> [    0.205992] Bluetooth: HCI socket layer initialized
> [    0.206014] Bluetooth: L2CAP socket layer initialized
> [    0.206036] Bluetooth: SCO socket layer initialized
> [    0.206567] clocksource: Switched to clocksource mct-frc
> [    0.214799] NET: Registered protocol family 2
> [    0.215264] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.215352] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.215463] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.215531] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.215573] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.215717] NET: Registered protocol family 1
> [    0.216073] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
> [    0.217474] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.217587] audit: initializing netlink subsys (disabled)
> [    0.217641] audit: type=2000 audit(0.215:1): initialized
> [    0.218191] workingset: timestamp_bits=30 max_order=19 bucket_order=0
> [    0.230957] bounce: pool size: 64 pages
> [    0.231124] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    0.231157] io scheduler noop registered
> [    0.231175] io scheduler deadline registered
> [    0.231306] io scheduler cfq registered (default)
> [    0.231963] 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
> [    0.235681] dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-141330
> [    0.235717] dma-pl330 12680000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
> [    0.238256] dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-141330
> [    0.238291] dma-pl330 12690000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
> [    0.239110] dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-141330
> [    0.239141] dma-pl330 12850000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
> [    0.239800] 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 53, base_baud = 0) is a S3C6400/10
> [    0.240144] 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 54, base_baud = 0) is a S3C6400/10
> [    1.015731] console [ttySAC1] enabled
> [    1.019770] 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq = 55, base_baud = 0) is a S3C6400/10
> [    1.028570] 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq = 56, base_baud = 0) is a S3C6400/10
> [    1.038157] [drm] Initialized drm 1.1.0 20060810
> [    1.042093] exynos-mixer 12c10000.mixer: Linked as a consumer to 12e20000.sysmmu
> [    1.049118] iommu: Adding device 12c10000.mixer to group 0
> [    1.055403] DEBUG: device_links_driver_bound(): 1
> [    1.059238] ------------[ cut here ]------------
> [    1.063826] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:356 device_links_driver_bound+0x124/0x12c
> [    1.072851] Modules linked in:
> [    1.075859] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-vanilla+ #3
> [    1.082458] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    1.088533] Backtrace: 
> [    1.090970] [<c010bb84>] (dump_backtrace) from [<c010bd80>] (show_stack+0x18/0x1c)
> [    1.098524]  r6:60000053 r5:c0a1ff00 r4:00000000 r3:00040800
> [    1.104161] [<c010bd68>] (show_stack) from [<c0353640>] (dump_stack+0x9c/0xb0)
> [    1.111376] [<c03535a4>] (dump_stack) from [<c011fa74>] (__warn+0xec/0x104)
> [    1.118306]  r6:c08038b0 r5:00000000 r4:00000000 r3:00040800
> [    1.123946] [<c011f988>] (__warn) from [<c011fb44>] (warn_slowpath_null+0x28/0x30)
> [    1.131506]  r9:00000000 r8:c0a258d8 r7:ee3114e4 r6:eeafa874 r5:00000000 r4:ee3114c0
> [    1.139231] [<c011fb1c>] (warn_slowpath_null) from [<c0404114>] (device_links_driver_bound+0x124/0x12c)
> [    1.148615] [<c0403ff0>] (device_links_driver_bound) from [<c0407950>] (driver_bound+0x68/0xb8)
> [    1.157287]  r9:00000000 r8:c0a258d8 r7:00000001 r6:c0a6d79c r5:c0a6d794 r4:eeafa810
> [    1.165011] [<c04078e8>] (driver_bound) from [<c0407e4c>] (driver_probe_device+0x280/0x2e4)
> [    1.173345]  r4:eeafa810 r3:600000d3
> [    1.176894] [<c0407bcc>] (driver_probe_device) from [<c0407f64>] (__driver_attach+0xb4/0xb8)
> [    1.185323]  r10:00000000 r9:c03f1178 r8:ffffffff r7:00000000 r6:eeafa844 r5:c0a258d8
> [    1.193128]  r4:eeafa810 r3:00000000
> [    1.196685] [<c0407eb0>] (__driver_attach) from [<c0405f1c>] (bus_for_each_dev+0x74/0xa8)
> [    1.204853]  r6:c0407eb0 r5:c0a258d8 r4:00000000 r3:c0407eb0
> [    1.210485] [<c0405ea8>] (bus_for_each_dev) from [<c0407760>] (driver_attach+0x24/0x28)
> [    1.218480]  r6:c0a26758 r5:ee27f780 r4:c0a258d8
> [    1.223072] [<c040773c>] (driver_attach) from [<c0407320>] (bus_add_driver+0x1a8/0x220)
> [    1.231072] [<c0407178>] (bus_add_driver) from [<c0408894>] (driver_register+0x80/0x100)
> [    1.239139]  r7:c0744e38 r6:c0744dc0 r5:00000000 r4:c0a258d8
> [    1.244773] [<c0408814>] (driver_register) from [<c0409920>] (__platform_driver_register+0x48/0x50)
> [    1.253809]  r5:00000000 r4:00000004
> [    1.257364] [<c04098d8>] (__platform_driver_register) from [<c03f1240>] (exynos_drm_init+0xc8/0xfc)
> [    1.266402] [<c03f1178>] (exynos_drm_init) from [<c01017c4>] (do_one_initcall+0x58/0x19c)
> [    1.274554]  r8:c0a02448 r7:c0a39000 r6:c0a39000 r5:00000006 r4:c093a520
> [    1.281232] [<c010176c>] (do_one_initcall) from [<c0900edc>] (kernel_init_freeable+0x1e4/0x288)
> [    1.289917]  r10:c0926834 r9:c090060c r8:0000008e r7:c0a39000 r6:c0a39000 r5:00000006
> [    1.297722]  r4:c093a520
> [    1.300243] [<c0900cf8>] (kernel_init_freeable) from [<c06dc2dc>] (kernel_init+0x10/0x11c)
> [    1.308493]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c06dc2cc
> [    1.316297]  r4:00000000
> [    1.318815] [<c06dc2cc>] (kernel_init) from [<c0107dd8>] (ret_from_fork+0x14/0x3c)
> [    1.326373]  r4:00000000 r3:ee880000
> [    1.329952] ---[ end trace 402e0b75dfe2947b ]---
> [    1.336115] exynos-hdmi 12d00000.hdmi: Failed to get supply 'vdd': -517
> [    1.341761] s5p-g2d 10800000.g2d: Linked as a consumer to 10a40000.sysmmu
> [    1.347960] iommu: Adding device 10800000.g2d to group 1
> [    1.353512] s5p-g2d 10800000.g2d: The Exynos G2D (ver 4.1) successfully probed.
> [    1.360510] DEBUG: device_links_driver_bound(): 1
> [    1.365183] ------------[ cut here ]------------
> [    1.369786] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:356 device_links_driver_bound+0x124/0x12c
> [    1.378819] Modules linked in:
> [    1.381829] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-vanilla+ #3
> [    1.389651] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    1.395718] Backtrace: 
> [    1.398154] [<c010bb84>] (dump_backtrace) from [<c010bd80>] (show_stack+0x18/0x1c)
> [    1.405709]  r6:60000053 r5:c0a1ff00 r4:00000000 r3:00040800
> [    1.411344] [<c010bd68>] (show_stack) from [<c0353640>] (dump_stack+0x9c/0xb0)
> [    1.418560] [<c03535a4>] (dump_stack) from [<c011fa74>] (__warn+0xec/0x104)
> [    1.425491]  r6:c08038b0 r5:00000000 r4:00000000 r3:00040800
> [    1.431132] [<c011f988>] (__warn) from [<c011fb44>] (warn_slowpath_null+0x28/0x30)
> [    1.438691]  r9:00000000 r8:c0a2621c r7:ee910ae4 r6:eeac4a74 r5:00000000 r4:ee910ac0
> [    1.446416] [<c011fb1c>] (warn_slowpath_null) from [<c0404114>] (device_links_driver_bound+0x124/0x12c)
> [    1.455800] [<c0403ff0>] (device_links_driver_bound) from [<c0407950>] (driver_bound+0x68/0xb8)
> [    1.464472]  r9:00000000 r8:c0a2621c r7:00000001 r6:c0a6d79c r5:c0a6d794 r4:eeac4a10
> [    1.472196] [<c04078e8>] (driver_bound) from [<c0407e4c>] (driver_probe_device+0x280/0x2e4)
> [    1.480530]  r4:eeac4a10 r3:00000000
> [    1.484080] [<c0407bcc>] (driver_probe_device) from [<c0407f64>] (__driver_attach+0xb4/0xb8)
> [    1.492508]  r10:00000000 r9:c03f1178 r8:ffffffff r7:00000000 r6:eeac4a44 r5:c0a2621c
> [    1.500313]  r4:eeac4a10 r3:00000000
> [    1.503870] [<c0407eb0>] (__driver_attach) from [<c0405f1c>] (bus_for_each_dev+0x74/0xa8)
> [    1.512038]  r6:c0407eb0 r5:c0a2621c r4:00000000 r3:c0407eb0
> [    1.517671] [<c0405ea8>] (bus_for_each_dev) from [<c0407760>] (driver_attach+0x24/0x28)
> [    1.525665]  r6:c0a26758 r5:ee932b80 r4:c0a2621c
> [    1.530257] [<c040773c>] (driver_attach) from [<c0407320>] (bus_add_driver+0x1a8/0x220)
> [    1.538257] [<c0407178>] (bus_add_driver) from [<c0408894>] (driver_register+0x80/0x100)
> [    1.546324]  r7:c0744e38 r6:c0744dc0 r5:00000000 r4:c0a2621c
> [    1.551959] [<c0408814>] (driver_register) from [<c0409920>] (__platform_driver_register+0x48/0x50)
> [    1.560994]  r5:00000000 r4:0000000a
> [    1.564548] [<c04098d8>] (__platform_driver_register) from [<c03f1240>] (exynos_drm_init+0xc8/0xfc)
> [    1.573587] [<c03f1178>] (exynos_drm_init) from [<c01017c4>] (do_one_initcall+0x58/0x19c)
> [    1.581739]  r8:c0a02448 r7:c0a39000 r6:c0a39000 r5:00000006 r4:c093a520
> [    1.588415] [<c010176c>] (do_one_initcall) from [<c0900edc>] (kernel_init_freeable+0x1e4/0x288)
> [    1.597103]  r10:c0926834 r9:c090060c r8:0000008e r7:c0a39000 r6:c0a39000 r5:00000006
> [    1.604907]  r4:c093a520
> [    1.607427] [<c0900cf8>] (kernel_init_freeable) from [<c06dc2dc>] (kernel_init+0x10/0x11c)
> [    1.615678]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c06dc2cc
> [    1.623482]  r4:00000000
> [    1.625999] [<c06dc2cc>] (kernel_init) from [<c0107dd8>] (ret_from_fork+0x14/0x3c)
> [    1.633558]  r4:00000000 r3:ee880000
> [    1.637133] ---[ end trace 402e0b75dfe2947c ]---
> [    1.642227] exynos-drm-fimc 11800000.fimc: Linked as a consumer to 11a20000.sysmmu
> [    1.649335] iommu: Adding device 11800000.fimc to group 2
> [    1.655529] exynos-drm-fimc 11810000.fimc: Linked as a consumer to 11a30000.sysmmu
> [    1.662263] iommu: Adding device 11810000.fimc to group 3
> [    1.668447] exynos-drm-fimc 11820000.fimc: Linked as a consumer to 11a40000.sysmmu
> [    1.675196] iommu: Adding device 11820000.fimc to group 4
> [    1.681278] exynos-drm-fimc 11820000.fimc: drm fimc registered successfully.
> [    1.687589] DEBUG: device_links_driver_bound(): 1
> [    1.692264] ------------[ cut here ]------------
> [    1.696852] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:356 device_links_driver_bound+0x124/0x12c
> [    1.705880] Modules linked in:
> [    1.708891] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-vanilla+ #3
> [    1.716713] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    1.722780] Backtrace: 
> [    1.725216] [<c010bb84>] (dump_backtrace) from [<c010bd80>] (show_stack+0x18/0x1c)
> [    1.732771]  r6:60000053 r5:c0a1ff00 r4:00000000 r3:00040800
> [    1.738407] [<c010bd68>] (show_stack) from [<c0353640>] (dump_stack+0x9c/0xb0)
> [    1.745624] [<c03535a4>] (dump_stack) from [<c011fa74>] (__warn+0xec/0x104)
> [    1.752553]  r6:c08038b0 r5:00000000 r4:00000000 r3:00040800
> [    1.758194] [<c011f988>] (__warn) from [<c011fb44>] (warn_slowpath_null+0x28/0x30)
> [    1.765754]  r9:00000000 r8:c0a26330 r7:ee311d24 r6:eea83074 r5:00000000 r4:ee311d00
> [    1.773479] [<c011fb1c>] (warn_slowpath_null) from [<c0404114>] (device_links_driver_bound+0x124/0x12c)
> [    1.782862] [<c0403ff0>] (device_links_driver_bound) from [<c0407950>] (driver_bound+0x68/0xb8)
> [    1.791534]  r9:00000000 r8:c0a26330 r7:00000001 r6:c0a6d79c r5:c0a6d794 r4:eea83010
> [    1.799258] [<c04078e8>] (driver_bound) from [<c0407e4c>] (driver_probe_device+0x280/0x2e4)
> [    1.807592]  r4:eea83010 r3:600000d3
> [    1.811142] [<c0407bcc>] (driver_probe_device) from [<c0407f64>] (__driver_attach+0xb4/0xb8)
> [    1.819571]  r10:00000000 r9:c03f1178 r8:ffffffff r7:00000000 r6:eea83044 r5:c0a26330
> [    1.827376]  r4:eea83010 r3:00000000
> [    1.830932] [<c0407eb0>] (__driver_attach) from [<c0405f1c>] (bus_for_each_dev+0x74/0xa8)
> [    1.839100]  r6:c0407eb0 r5:c0a26330 r4:00000000 r3:c0407eb0
> [    1.844733] [<c0405ea8>] (bus_for_each_dev) from [<c0407760>] (driver_attach+0x24/0x28)
> [    1.852728]  r6:c0a26758 r5:ee27fa00 r4:c0a26330
> [    1.857319] [<c040773c>] (driver_attach) from [<c0407320>] (bus_add_driver+0x1a8/0x220)
> [    1.865320] [<c0407178>] (bus_add_driver) from [<c0408894>] (driver_register+0x80/0x100)
> [    1.873386]  r7:c0744e38 r6:c0744dc0 r5:00000000 r4:c0a26330
> [    1.879021] [<c0408814>] (driver_register) from [<c0409920>] (__platform_driver_register+0x48/0x50)
> [    1.888057]  r5:00000000 r4:0000000b
> [    1.891610] [<c04098d8>] (__platform_driver_register) from [<c03f1240>] (exynos_drm_init+0xc8/0xfc)
> [    1.900649] [<c03f1178>] (exynos_drm_init) from [<c01017c4>] (do_one_initcall+0x58/0x19c)
> [    1.908801]  r8:c0a02448 r7:c0a39000 r6:c0a39000 r5:00000006 r4:c093a520
> [    1.915478] [<c010176c>] (do_one_initcall) from [<c0900edc>] (kernel_init_freeable+0x1e4/0x288)
> [    1.924165]  r10:c0926834 r9:c090060c r8:0000008e r7:c0a39000 r6:c0a39000 r5:00000006
> [    1.931969]  r4:c093a520
> [    1.934489] [<c0900cf8>] (kernel_init_freeable) from [<c06dc2dc>] (kernel_init+0x10/0x11c)
> [    1.942740]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c06dc2cc
> [    1.950545]  r4:00000000
> [    1.953062] [<c06dc2cc>] (kernel_init) from [<c0107dd8>] (ret_from_fork+0x14/0x3c)
> [    1.960620]  r4:00000000 r3:ee880000
> [    1.964193] ---[ end trace 402e0b75dfe2947d ]---
> [    1.969039] exynos-drm-fimc 11830000.fimc: Linked as a consumer to 11a50000.sysmmu
> [    1.976392] iommu: Adding device 11830000.fimc to group 5
> [    1.982437] exynos-drm-fimc 11830000.fimc: drm fimc registered successfully.
> [    1.988799] DEBUG: device_links_driver_bound(): 1
> [    1.993464] ------------[ cut here ]------------
> [    1.998056] WARNING: CPU: 2 PID: 1 at drivers/base/core.c:356 device_links_driver_bound+0x124/0x12c
> [    2.007076] Modules linked in:
> [    2.010087] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-vanilla+ #3
> [    2.017909] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    2.023975] Backtrace: 
> [    2.026412] [<c010bb84>] (dump_backtrace) from [<c010bd80>] (show_stack+0x18/0x1c)
> [    2.033967]  r6:60000053 r5:c0a1ff00 r4:00000000 r3:00040800
> [    2.039603] [<c010bd68>] (show_stack) from [<c0353640>] (dump_stack+0x9c/0xb0)
> [    2.046819] [<c03535a4>] (dump_stack) from [<c011fa74>] (__warn+0xec/0x104)
> [    2.053750]  r6:c08038b0 r5:00000000 r4:00000000 r3:00040800
> [    2.059390] [<c011f988>] (__warn) from [<c011fb44>] (warn_slowpath_null+0x28/0x30)
> [    2.066950]  r9:00000000 r8:c0a26330 r7:ee313264 r6:eea83274 r5:00000000 r4:ee313240
> [    2.074675] [<c011fb1c>] (warn_slowpath_null) from [<c0404114>] (device_links_driver_bound+0x124/0x12c)
> [    2.084058] [<c0403ff0>] (device_links_driver_bound) from [<c0407950>] (driver_bound+0x68/0xb8)
> [    2.092731]  r9:00000000 r8:c0a26330 r7:00000001 r6:c0a6d79c r5:c0a6d794 r4:eea83210
> [    2.100454] [<c04078e8>] (driver_bound) from [<c0407e4c>] (driver_probe_device+0x280/0x2e4)
> [    2.108788]  r4:eea83210 r3:600000d3
> [    2.112338] [<c0407bcc>] (driver_probe_device) from [<c0407f64>] (__driver_attach+0xb4/0xb8)
> [    2.120767]  r10:00000000 r9:c03f1178 r8:ffffffff r7:00000000 r6:eea83244 r5:c0a26330
> [    2.128571]  r4:eea83210 r3:00000000
> [    2.132128] [<c0407eb0>] (__driver_attach) from [<c0405f1c>] (bus_for_each_dev+0x74/0xa8)
> [    2.140296]  r6:c0407eb0 r5:c0a26330 r4:00000000 r3:c0407eb0
> [    2.145929] [<c0405ea8>] (bus_for_each_dev) from [<c0407760>] (driver_attach+0x24/0x28)
> [    2.153924]  r6:c0a26758 r5:ee27fa00 r4:c0a26330
> [    2.158516] [<c040773c>] (driver_attach) from [<c0407320>] (bus_add_driver+0x1a8/0x220)
> [    2.166516] [<c0407178>] (bus_add_driver) from [<c0408894>] (driver_register+0x80/0x100)
> [    2.174582]  r7:c0744e38 r6:c0744dc0 r5:00000000 r4:c0a26330
> [    2.180217] [<c0408814>] (driver_register) from [<c0409920>] (__platform_driver_register+0x48/0x50)
> [    2.189252]  r5:00000000 r4:0000000b
> [    2.192806] [<c04098d8>] (__platform_driver_register) from [<c03f1240>] (exynos_drm_init+0xc8/0xfc)
> [    2.201845] [<c03f1178>] (exynos_drm_init) from [<c01017c4>] (do_one_initcall+0x58/0x19c)
> [    2.209997]  r8:c0a02448 r7:c0a39000 r6:c0a39000 r5:00000006 r4:c093a520
> [    2.216674] [<c010176c>] (do_one_initcall) from [<c0900edc>] (kernel_init_freeable+0x1e4/0x288)
> [    2.225361]  r10:c0926834 r9:c090060c r8:0000008e r7:c0a39000 r6:c0a39000 r5:00000006
> [    2.233165]  r4:c093a520
> [    2.235685] [<c0900cf8>] (kernel_init_freeable) from [<c06dc2dc>] (kernel_init+0x10/0x11c)
> [    2.243936]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c06dc2cc
> [    2.251740]  r4:00000000
> [    2.254258] [<c06dc2cc>] (kernel_init) from [<c0107dd8>] (ret_from_fork+0x14/0x3c)
> [    2.261816]  r4:00000000 r3:ee880000
> [    2.265388] ---[ end trace 402e0b75dfe2947e ]---
> [    2.270457] exynos-drm-ipp exynos-drm-ipp: drm ipp registered successfully.
> [    2.280368] loop: module loaded
> [    2.293185] random: fast init done
> [    2.303857] usbcore: registered new interface driver smsc95xx
> [    2.491598] dwc2 12480000.hsotg: Specified GNPTXFDEP=1024 > 768
> [    2.491906] dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808 entries in SPRAM
> [    2.499801] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.505798] ehci-exynos: EHCI EXYNOS driver
> [    2.510438] exynos-ehci 12580000.ehci: EHCI Host Controller
> [    2.515535] exynos-ehci 12580000.ehci: new USB bus registered, assigned bus number 1
> [    2.523434] exynos-ehci 12580000.ehci: irq 51, io mem 0x12580000
> [    2.541596] exynos-ehci 12580000.ehci: USB 2.0 started, EHCI 1.00
> <snip>

I'll try to do another test with just the 5 patches from this set
applied (without the IOMMU probe deferral).

With best wishes,
Tobias



Marek Szyprowski wrote:
> Dear All,
> 
> This patchset adds runtime PM support to common clock framework. This is an
> attempt to implement support for clock controllers, which belongs to a power
> domain. This approach works surprisingly well on Exynos 4412 and 5433 SoCs,
> what allowed us to solve various freeze/crash issues related to power
> management.
> 
> The main idea behind this patchset is to keep clock's controller power domain
> enabled every time when at least one of its clock is enabled or access to its
> registers is being made. Clock controller driver (clock provider) can
> supply a struct device pointer, which is the used by clock core for tracking and
> managing clock's controller runtime pm state. Each clk_prepare() operation will
> first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
> will do pm_runtime_put() at the end.
> 
> This runtime PM feature has been tested with Exynos4412 and Exynos5433 clocks
> drivers. Both have some clocks, which belongs to respective power domains and
> need special handling during power on/off procedures. Till now it wasn't handled
> at all, what caused various problems.
> 
> Patches for exynos 4412 and 5433 clocks drivers change the way the clock
> provider is initialized. Instead of CLK_OF_DECLARE based initialization, a
> complete platform device driver infrastructure is being used. This is needed to
> let driver to use runtime pm feature and integrate with generic power domains.
> The side-effect of this change is a delay in clock provider registeration
> during system boot, so early initialized drivers might get EPROBEDEFER error
> when requesting their clocks. This is an issue for IOMMU drivers, so
> this patchset will be fully functional once the deferred probe for IOMMU
> will be merged.
> 
> The side-effect of this patchset is the one can finally read
> /sys/kernel/debug/clk/clk_summary on all Exynos4412 boards without any freeze.
> 
> If one wants to test this patchset (on Exynos4412 Trats2 device with FIMC-IS
> driver), I've provided a branch with all needed patches (fixes for Exynos,
> FIMC-IS driver and IOMMU deferred probe):
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.8-clocks-pm-v2
> 
> Patches are based on vanilla v4.8-rc7 kernel.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> Changelog:
> v2:
> - Simplified clk_pm_runtime_get/put functions, removed workaround for devices
>   with disabled runtime pm. Such workaround is no longer needed since commit
>   4d23a5e84806b202d9231929c9507ef7cf7a0185 ("PM / Domains: Allow runtime PM
>   during system PM phases").
> - Added CLK_RUNTIME_PM flag to indicate clocks, for which clock core should
>   call runtime pm functions. This solves problem with clocks, for which struct
>   device is already registered, but no runtime pm is enabled.
> - Extended commit messages according to Ulf suggestions.
> - Fixed some style issues pointed by Barlomiej.
> 
> v1: http://www.spinics.net/lists/arm-kernel/msg528128.html
> - initial version
> 
> Marek Szyprowski (5):
>   clk: add support for runtime pm
>   clock: samsung: add support for runtime pm
>   clocks: exynos4x12: add runtime pm support for ISP clocks
>   ARM: dts: exynos: add support for ISP power domain to exynos4x12
>     clocks device
>   clocks: exynos5433: add runtime pm support
> 
>  .../devicetree/bindings/clock/exynos4-clock.txt    |  22 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   5 +
>  drivers/clk/clk.c                                  | 107 +++++-
>  drivers/clk/samsung/clk-exynos4.c                  | 227 ++++++++----
>  drivers/clk/samsung/clk-exynos5433.c               | 385 ++++++++++++++++-----
>  drivers/clk/samsung/clk-pll.c                      |   4 +-
>  drivers/clk/samsung/clk.c                          |  36 +-
>  drivers/clk/samsung/clk.h                          |   7 +
>  include/linux/clk-provider.h                       |   1 +
>  9 files changed, 632 insertions(+), 162 deletions(-)
> 

