From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Alternative approach to solve the deferred probe
Date: Thu, 22 Oct 2015 18:12:34 +0300
Message-ID: <5628FCE2.1070409@ti.com>
References: <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk> <56270D5B.5010902@gmail.com>
 <20151021081847.GB32532@n2100.arm.linux.org.uk> <5627B0F7.7010600@gmail.com>
 <5627C381.60602@ti.com> <20151021172042.GJ32532@n2100.arm.linux.org.uk>
 <5627D5DC.1040708@ti.com> <20151021182817.GM32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151021182817.GM32532@n2100.arm.linux.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: frowand.list@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=c3=b6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Russell,

On 10/21/2015 09:28 PM, Russell King - ARM Linux wrote:
> On Wed, Oct 21, 2015 at 09:13:48PM +0300, Grygorii Strashko wrote:
>> But I worry a bit (and that my main point) about these few additional
>> rounds of deferred device probing which I have right now and which allows
>> some of drivers to finish, finally, their probes successfully.
>> With proposed change I'll get more messages in boot log, but some of
>> them will belong to drivers which have been probed successfully and so,
>> they will be not really useful.
> 
> Then you haven't properly understood my proposal.
> 
> I want to get rid of all the "X deferred its probing" messages up until
> the point that we set the "please report deferred probes" flag.
> 
> That _should_ mean that all the deferred probing that goes on becomes
> _totally_ silent and becomes hidden (unless you really want to see it,
> in which case we can make a debug option which turns it on) up until
> we're at the point where we want to enter userspace.
> 
> At that point, we then report into the kernel log which devices are
> still deferring and, via appropriately placed dev_warn_deferred(),
> the reasons why the devices are being deferred.
> 
> So, gone will be all the messages earlier in the log about device X
> not having a GPIO/clock/whatever because the device providing the
> GPIO/clock/whatever hasn't been probed.
> 
> If everything is satisfied by the time we run this last round (again,
> I'm not using a three line sentence to describe exactly what I mean,
> I'm sure you know by now... oops, I just did) then the kernel will
> report nothing about any deferrals.  That's _got_ to be an improvement.

Sorry Master, but you really don't need to spend so much time typing the
same things three times  - I understand what are you trying to do :(

I did my comments with assumption that it's not officially prohibited/deprecated
to register drivers (and execute probes) from late_initcall() layer
(just recommended) and there are still bunch of drivers which are doing this.
Now I see that it's not a recommendation any more, and deferred_probe_initcall()
might be a good place to activate driver_deferred_probe_report if goal is to
identify and fix such drivers.

Sorry for your time.

> 
>>
>> As result, I think, the most important thing is to identify (or create)
>> some point during kernel boot when it will be possible to say that all
>> built-in drivers (at least) finish their probes 100% (done or defer).
>>
>> Might be do_initcalls() can be updated (smth like this):
>> static void __init do_initcalls(void)
>> {
>> 	int level;
>>
>> 	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++)
>> 		do_initcall_level(level);
>>
>> +	wait_for_device_probe();
>> +	/* Now one final round, reporting any devices that remain deferred */
>> +	driver_deferred_probe_report = true;
>> +	driver_deferred_probe_trigger();
>> +	wait_for_device_probe();
>> }
>>
>> Also, in my opinion, it will be useful if this debugging feature will be
>> optional.
> 
> I wonder why you want it optional... so I'm going to guess and cover
> both cases I can think of below to head off another round of reply on
> this point (sorry if this sucks eggs.)
> 
> I don't see it as being optional, because it's going to be cheap to run
> in the case of a system which has very few or no errors - which is what
> you should have for production systems, right?
> 

Also, I've spend some time today testing your proposal - hope you'll find results
useful.

I've applied truncated version of your patch (diff below) on TI's 4.1 kernel and
run few tests (log is below) on dra7-evm/am43xx-gpevm - K4.1 is not far away from LKML,
so I assume this test is valid. Overall boot process consists from two stages:
kernel boot and modules loading. 

My Changes:
 - only really_probe() modified to show deferred device/drivers 

>From the log I can see additional messages in log when modules are loading,
because driver_deferred_probe_report is still true - dwc3 probes were deferred,
but then finally succeeded.

So, as you've mentioned, it seems a good thing to deactivate driver_deferred_probe_report and
provide user with ability to turn it on again (and probably re-trigger deferred
device probing).

I've found no issues during Kernel boot (built-in) time, new messages are displayed only
if probe is failed for some drivers:
[    3.219700] ====================================== deferred_probe_initcalll
[    3.226820] platform omapdrm.0: Driver omapdrm requests probe deferral
[    3.233378] platform omapdrm.0: deferring probe: ==== Driver omapdrm requests probe deferral
[    3.242084] dra7evm-tpd12s015 encoder@1: failed to parse CT CP HPD gpio
[    3.248737] platform encoder@1: Driver dra7evm-tpd12s015 requests probe deferral
[    3.256168] platform encoder@1: deferring probe: ==== Driver dra7evm-tpd12s015 requests probe deferral
[    3.265763] connector-hdmi connector@1: failed to find video source
[    3.272067] platform connector@1: Driver connector-hdmi requests probe deferral
[    3.279410] platform connector@1: deferring probe: ==== Driver connector-hdmi requests probe deferral 
^^ above drivers will be deferred forever

Thanks.
-- 
regards,
-grygorii
S/ILKP

*************** [TEST CODE] ***********
---
 drivers/base/dd.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e7d2545..d61fa47 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -129,6 +129,27 @@ void driver_deferred_probe_del(struct device *dev)
 	mutex_unlock(&deferred_probe_mutex);
 }
 
+static bool driver_deferred_probe_report;
+
+/**
+ * dev_warn_deferred() - report why a probe has been deferred
+ */
+void dev_warn_deferred(struct device *dev, const char *fmt, ...)
+{
+	if (driver_deferred_probe_report) {
+		struct va_format vaf;
+		va_list ap;
+
+		va_start(ap, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &ap;
+
+		dev_err(dev, "deferring probe: %pV", &vaf);
+		va_end(ap);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_warn_deferred);
+
 static bool driver_deferred_probe_enable = false;
 /**
  * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
@@ -188,6 +209,15 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_workqueue(deferred_wq);
+
+	pr_err("====================================== deferred_probe_initcalll\n");
+
+	/* Now one final round, reporting any devices that remain deferred */
+	driver_deferred_probe_report = true;
+	driver_deferred_probe_trigger();
+	/* Sort as many dependencies as possible before exiting initcalls */
+	flush_workqueue(deferred_wq);
+
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
@@ -342,7 +372,8 @@ probe_failed:
 	switch (ret) {
 	case -EPROBE_DEFER:
 		/* Driver requested deferred probing */
-		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
+		dev_err(dev, "Driver %s requests probe deferral\n", drv->name);
+		dev_warn_deferred(dev, "==== Driver %s requests probe deferral\n", drv->name);
 		driver_deferred_probe_add(dev);
 		/* Did a trigger occur while probing? Need to re-trigger if yes */
 		if (local_trigger_count != atomic_read(&deferred_trigger_count))
-- 
2.6.2


*************** [BOOT LOG] ***********
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.10-rt10-02639-gd63d0be-dirty (lcpdbld@dflsdit-build06.dal.design.ti.com) (gcc version 4.9.3 20150413 (prerelease) (Linaro GCC 4.9-2015.05) ) #1 SMP PREEMPT RT Thu Oct 22 05:11:58 CDT 2015
[    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: TI DRA742
[    0.000000] Reserved memory: created CMA memory pool at 0x95800000, size 56 MiB
[    0.000000] Reserved memory: initialized node ipu2_cma@95800000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x99000000, size 64 MiB
[    0.000000] Reserved memory: initialized node dsp1_cma@99000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9d000000, size 32 MiB
[    0.000000] Reserved memory: initialized node ipu1_cma@9d000000, compatible id shared-dma-pool
[    0.000000] Reserved memory: created CMA memory pool at 0x9f000000, size 8 MiB
[    0.000000] Reserved memory: initialized node dsp2_cma@9f000000, compatible id shared-dma-pool
[    0.000000] cma: Reserved 24 MiB at 0xde000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] DRA752 ES1.1
[    0.000000] PERCPU: Embedded 12 pages/cpu @ee9af000 s17792 r8192 d23168 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 390994
[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk rootwait  ip=:::::eth0:dhcp  root=/dev/nfs rw nfsroot=192.168.0.1:/home/tigtfarm07/NFS_exports/dra7xx-evm1/autofs/1d8e30535854dc371534f96e3c6d5488,nolock 
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1356664K/1570816K available (6271K kernel code, 508K rwdata, 2240K rodata, 372K init, 266K bss, 25736K reserved, 188416K cma-reserved, 768000K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0858064   (8513 kB)
[    0.000000]       .init : 0xc0859000 - 0xc08b6000   ( 372 kB)
[    0.000000]       .data : 0xc08b6000 - 0xc09352c0   ( 509 kB)
[    0.000000]        .bss : 0xc0938000 - 0xc097ab78   ( 267 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-1.
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000427] Architected cp15 timer(s) running at 6.14MHz (virt).
[    0.000457] clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x16af5adb9, max_idle_ns: 440795202250 ns
[    0.000463] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 4398046511023ns
[    0.000470] Switching to timer-based delay loop, resolution 162ns
[    0.001360] Console: colour dummy device 80x30
[    0.001486] WARNING: Your 'console=ttyO0' has been replaced by 'ttyS0'
[    0.001488] This ensures that you still see kernel messages. Please
[    0.001489] update your kernel commandline.
[    0.001502] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=61475)
[    0.001506] pid_max: default: 32768 minimum: 301
[    0.001583] Security Framework initialized
[    0.001620] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001626] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002189] Initializing cgroup subsys blkio
[    0.002197] Initializing cgroup subsys memory
[    0.002221] Initializing cgroup subsys devices
[    0.002228] Initializing cgroup subsys freezer
[    0.002236] Initializing cgroup subsys perf_event
[    0.002278] CPU: Testing write buffer coherency: ok
[    0.002517] /cpus/cpu@0 missing clock-frequency property
[    0.002598] /cpus/cpu@1 missing clock-frequency property
[    0.002609] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002653] Setting up static identity map for 0x80008280 - 0x800082f0
[    0.120957] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.121040] Brought up 2 CPUs
[    0.121054] SMP: Total of 2 processors activated (24.59 BogoMIPS).
[    0.121061] CPU: All CPU(s) started in SVC mode.
[    0.121513] devtmpfs: initialized
[    0.149180] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.149968] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.164029] omap_hwmod: tptc0 using broken dt data from edma-controller
[    0.164509] omap_hwmod: tptc1 using broken dt data from edma-controller
[    0.338569] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.342242] pinctrl core: initialized pinctrl subsystem
[    0.343204] NET: Registered protocol family 16
[    0.345772] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.354459] OMAP GPIO hardware version 0.1
[    0.362174] irq: no irq domain found for /ocp/l4@4a000000/scm@2000/pinmux@1400 !
[    0.388931] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.388942] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.391765] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    0.391775] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    0.392434] OMAP DMA hardware revision 0.0
[    0.409403] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
[    0.412466] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver
[    0.413035] platform fixedregulator-sd: Driver reg-fixed-voltage requests probe deferral
[    0.418357] omap-iommu 40d01000.mmu: 40d01000.mmu registered
[    0.418619] omap-iommu 40d02000.mmu: 40d02000.mmu registered
[    0.418864] omap-iommu 58882000.mmu: 58882000.mmu registered
[    0.419116] omap-iommu 55082000.mmu: 55082000.mmu registered
[    0.419488] omap-iommu 41501000.mmu: 41501000.mmu registered
[    0.419750] omap-iommu 41502000.mmu: 41502000.mmu registered
[    0.420001] vgaarb: loaded
[    0.420424] SCSI subsystem initialized
[    0.421911] palmas 0-0058: IRQ missing: skipping irq request
[    0.441468] palmas 0-0058: Muxing GPIO 2e, PWM 0, LED 0
[    0.513681] pcf857x 0-0020: probed
[    0.514304] pcf857x 0-0021: probed
[    0.514450] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
[    0.531230] GPIO line 465 (vin6_sel_s0) hogged as output/low
[    0.531421] pcf857x 1-0026: probed
[    0.531580] omap_i2c 48072000.i2c: bus 1 rev0.12 at 400 kHz
[    0.532021] omap_i2c 48060000.i2c: bus 2 rev0.12 at 400 kHz
[    0.532308] pps_core: LinuxPPS API ver. 1 registered
[    0.532317] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.532346] PTP clock support registered
[    0.533009] omap-mailbox 48840000.mailbox: omap mailbox rev 0x400
[    0.533319] omap-mailbox 48842000.mailbox: omap mailbox rev 0x400
[    0.533623] Advanced Linux Sound Architecture Driver Initialized.
[    0.534366] Switched to clocksource arch_sys_counter
[    0.544551] NET: Registered protocol family 2
[    0.545253] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.545334] TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
[    0.545623] TCP: Hash tables configured (established 8192 bind 8192)
[    0.545685] UDP hash table entries: 512 (order: 3, 32768 bytes)
[    0.545741] UDP-Lite hash table entries: 512 (order: 3, 32768 bytes)
[    0.545949] NET: Registered protocol family 1
[    0.546240] RPC: Registered named UNIX socket transport module.
[    0.546249] RPC: Registered udp transport module.
[    0.546256] RPC: Registered tcp transport module.
[    0.546263] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.547419] CPU PMU: Failed to parse /pmu/interrupt-affinity[0]
[    0.547454] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    0.549458] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.549541] audit: initializing netlink subsys (disabled)
[    0.549576] audit: type=2000 audit(0.530:1): initialized
[    0.556198] VFS: Disk quotas dquot_6.6.0
[    0.556369] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.558508] NFS: Registering the id_resolver key type
[    0.558542] Key type id_resolver registered
[    0.558550] Key type id_legacy registered
[    0.558610] jffs2: version 2.2. (NAND) (SUMMARY)   2001-2006 Red Hat, Inc.
[    0.560591] NET: Registered protocol family 38
[    0.560698] bounce: pool size: 64 pages
[    0.560713] io scheduler noop registered
[    0.560727] io scheduler deadline registered
[    0.560879] io scheduler cfq registered (default)
[    0.564728] pinctrl-single 4a003400.pinmux: 281 pins at pa fc003400 size 1124
[    0.574576] dra7-pcie 51000000.pcie: PCI host bridge to bus 0000:00
[    0.574590] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.574600] pci_bus 0000:00: root bus resource [mem 0x20013000-0x2fffffff]
[    0.574612] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.574765] pci 0000:00:00.0: IOMMU is currently not supported for PCI
[    0.575026] PCI: bus0: Fast back to back transfers disabled
[    0.575470] pci 0000:01:00.0: IOMMU is currently not supported for PCI
[    0.575814] PCI: bus1: Fast back to back transfers disabled
[    0.575950] pci 0000:00:00.0: BAR 0: assigned [mem 0x20100000-0x201fffff]
[    0.575966] pci 0000:00:00.0: BAR 8: assigned [mem 0x20200000-0x202fffff]
[    0.575978] pci 0000:00:00.0: BAR 9: assigned [mem 0x20300000-0x203fffff pref]
[    0.575989] pci 0000:00:00.0: BAR 1: assigned [mem 0x20020000-0x2002ffff]
[    0.576002] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.576017] pci 0000:01:00.0: BAR 1: assigned [mem 0x20200000-0x2027ffff]
[    0.576037] pci 0000:01:00.0: BAR 6: assigned [mem 0x20300000-0x2033ffff pref]
[    0.576048] pci 0000:01:00.0: BAR 0: assigned [mem 0x20280000-0x2029ffff]
[    0.576067] pci 0000:01:00.0: BAR 3: assigned [mem 0x202a0000-0x202a3fff]
[    0.576086] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    0.576106] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.576116] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.576128] pci 0000:00:00.0:   bridge window [mem 0x20200000-0x202fffff]
[    0.576138] pci 0000:00:00.0:   bridge window [mem 0x20300000-0x203fffff pref]
[    0.579925] OMAP DSS rev 6.1
[    0.580244] omapdss_dss 58000000.dss: bound 58001000.dispc (ops dispc_component_ops)
[    0.580839] omapdss_dss 58000000.dss: bound 58040000.encoder (ops hdmi5_component_ops)
[    0.581749] platform encoder@1: Driver dra7evm-tpd12s015 requests probe deferral
[    0.582201] connector-hdmi connector@1: failed to find video source
[    0.582219] platform connector@1: Driver connector-hdmi requests probe deferral
[    0.585743] Serial: 8250/16550 driver, 10 ports, IRQ sharing enabled
[    0.588508] 4806a000.serial: ttyS0 at MMIO 0x4806a000 (irq = 299, base_baud = 3000000) is a 8250
[    1.662547] console [ttyS0] enabled
[    1.666661] 4806c000.serial: ttyS1 at MMIO 0x4806c000 (irq = 300, base_baud = 3000000) is a 8250
[    1.676287] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 301, base_baud = 3000000) is a 8250
[    1.686280] [drm] Initialized drm 1.1.0 20060810
[    1.700726] brd: module loaded
[    1.708417] loop: module loaded
[    1.712651] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.723546] mousedev: PS/2 mouse device common for all mice
[    1.729154] i2c /dev entries driver
[    1.734581] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    1.739413] omap_hsmmc 4809c000.mmc: no pinctrl state for hs200_1_8v mode
[    1.746235] omap_hsmmc 4809c000.mmc: no pinctrl state for ddr_1_8v mode
[    1.753335] platform 4809c000.mmc: Driver omap_hsmmc requests probe deferral
[    1.760862] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr104 mode
[    1.767334] omap_hsmmc 480b4000.mmc: no pinctrl state for hs200_1_8v mode
[    1.774151] omap_hsmmc 480b4000.mmc: no pinctrl state for ddr50 mode
[    1.780537] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr50 mode
[    1.786920] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr25 mode
[    1.793302] omap_hsmmc 480b4000.mmc: no pinctrl state for sdr12 mode
[    1.800000] evm_3v3_sw: supplied by sysen1
[    1.845119] omap_hsmmc 480d1000.mmc: no pinctrl state for sdr104 mode
[    1.851589] omap_hsmmc 480d1000.mmc: no pinctrl state for hs200_1_8v mode
[    1.858426] omap_hsmmc 480d1000.mmc: no pinctrl state for ddr50 mode
[    1.864810] omap_hsmmc 480d1000.mmc: no pinctrl state for sdr50 mode
[    1.871192] omap_hsmmc 480d1000.mmc: no pinctrl state for ddr_1_8v mode
[    1.888212] mmc0: MAN_BKOPS_EN bit is not set
[    1.896106] mmc0: new DDR MMC card at address 0001
[    1.901266] mmcblk0: mmc0:0001 MMC08G 7.25 GiB 
[    1.905933] mmcblk0boot0: mmc0:0001 MMC08G partition 1 8.00 MiB
[    1.911994] mmcblk0boot1: mmc0:0001 MMC08G partition 2 8.00 MiB
[    1.918716]  mmcblk0: p1 p2 p3
[    1.995125] omap-aes 4b500000.aes: OMAP AES hw accel rev: 3.3
[    2.001694] omap-aes 4b700000.aes: OMAP AES hw accel rev: 3.3
[    2.009016] omap-des 480a5000.des: OMAP DES hw accel rev: 2.2
[    2.015924] omap-sham 4b101000.sham: hw accel on OMAP rev 4.3
[    2.026077] davinci-mcasp 48468000.mcasp: ERRATA i868 workaround is enabled
[    2.035132] davinci-mcasp 4847c000.mcasp: ERRATA i868 workaround is enabled
[    2.042544] Initializing XFRM netlink socket
[    2.046882] NET: Registered protocol family 17
[    2.051375] NET: Registered protocol family 15
[    2.055925] Key type dns_resolver registered
[    2.060338] omap_voltage_late_init: Voltage driver support not added
[    2.066734] sr_dev_init: Unable to get voltage domain pointer for VDD core
[    2.073638] sr_dev_init: Unable to get voltage domain pointer for VDD mpu
[    2.080738] Power Management for TI OMAP4+ devices.
[    2.085863] ThumbEE CPU extension supported.
[    2.090164] Registering SWP/SWPB emulation handler
[    2.094984] SmartReflex Class3 initialized
[    2.100743] dmm 4e000000.dmm: workaround for errata i878 in use
[    2.108418] dmm 4e000000.dmm: initialized all PAT entries
[    2.114210] platform omapdrm.0: Driver omapdrm requests probe deferral
[    2.123162] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    2.128009] omap_hsmmc 4809c000.mmc: no pinctrl state for hs200_1_8v mode
[    2.134830] omap_hsmmc 4809c000.mmc: no pinctrl state for ddr_1_8v mode
[    2.196401] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.203044] [drm] No driver support for vblank timestamp query.
[    2.209023] omapdrm omapdrm.0: No connectors reported connected with modes
[    2.215933] [drm] Cannot find any crtc or sizes - going 1024x768
[    2.227640] [drm] Enabling DMM ywrap scrolling
[    2.239535] Console: switching to colour frame buffer device 128x48
[    2.251305] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
[    2.257253] omapdrm omapdrm.0: registered panic notifier
[    2.274429] [drm] Initialized omapdrm 1.0.0 20110917 on minor 0
[    2.280400] ====================================== deferred_probe_initcalll
[    2.334387] davinci_mdio 48485000.mdio: davinci mdio revision 1.6
[    2.340513] davinci_mdio 48485000.mdio: detected phy mask fffffff3
[    2.344381] mmc2: host does not support reading read-only switch, assuming write-enable
[    2.349716] mmc2: new high speed SDHC card at address e624
[    2.354396] mmcblk1: mmc2:e624 SU04G 3.69 GiB 
[    2.362506]  mmcblk1: p1 p2 p3
[    2.372593] libphy: 48485000.mdio: probed
[    2.376626] davinci_mdio 48485000.mdio: phy[2]: device 48485000.mdio:02, driver unknown
[    2.384668] davinci_mdio 48485000.mdio: phy[3]: device 48485000.mdio:03, driver unknown
[    2.393389] cpsw 48484000.ethernet: Detected MACID = b4:99:4c:0b:e4:e6
[    2.400896] cpsw 48484000.ethernet: cpsw: Detected MACID = b4:99:4c:0b:e4:e7
[    2.408583] hctosys: unable to open rtc device (rtc0)
[    2.413661] sr_init: No PMIC hook to init smartreflex
[    2.418903] sr_init: platform driver register failed for SR
[    2.441783] net eth0: initializing cpsw version 1.15 (0)
[    2.528312] net eth0: phy found : id is : 0x20005c7a
[    6.531286] cpsw 48484000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    6.554382] Sending DHCP requests ., OK
[    6.624439] IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.192
[    6.632426] IP-Config: Complete:
[    6.635674]      device=eth0, hwaddr=b4:99:4c:0b:e4:e6, ipaddr=192.168.0.192, mask=255.255.255.0, gw=192.168.0.1
[    6.645895]      host=192.168.0.192, domain=ti.com, nis-domain=(none)
[    6.652364]      bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
[    6.659095]      nameserver0=192.0.2.2, nameserver1=192.0.2.3
[    6.665282] ldousb: disabling
[    6.668549] vmmcwl_fixed: disabling
[    6.672054] aic_dvdd: disabling
[    6.675417] ALSA device list:
[    6.678397]   No soundcards found.
[    6.687614] VFS: Mounted root (nfs filesystem) on device 0:15.
[    6.693779] devtmpfs: mounted
[    6.697044] Freeing unused kernel memory: 372K (c0859000 - c08b6000)

INIT: version 2.88 booting

Starting udev
[    7.129889] udevd[175]: starting version 182
[    7.329630] omap-rproc 58820000.ipu: assigned reserved memory node ipu1_cma@9d000000
[    7.349436]  remoteproc0: 58820000.ipu is available
[    7.358961]  remoteproc0: Note: remoteproc is still under development and considered experimental.
[    7.431205]  remoteproc0: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility isn't yet guaranteed.
[    7.452181]  remoteproc0: Direct firmware load for dra7-ipu1-fw.xem4 failed with error -2
[    7.456683] omap-rproc 55020000.ipu: assigned reserved memory node ipu2_cma@95800000
[    7.471645]  remoteproc1: 55020000.ipu is available
[    7.471649]  remoteproc1: Note: remoteproc is still under development and considered experimental.
[    7.471653]  remoteproc1: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility isn't yet guaranteed.
[    7.480262] omap-rproc 40800000.dsp: assigned reserved memory node dsp1_cma@99000000
[    7.510612]  remoteproc2: 40800000.dsp is available
[    7.510618]  remoteproc2: Note: remoteproc is still under development and considered experimental.
[    7.510622]  remoteproc2: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility isn't yet guaranteed.
[    7.514543] omap-rproc 41000000.dsp: assigned reserved memory node dsp2_cma@9f000000
[    7.523301]  remoteproc3: 41000000.dsp is available
[    7.523306]  remoteproc3: Note: remoteproc is still under development and considered experimental.
[    7.523309]  remoteproc3: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility isn't yet guaranteed.
[    7.614060]  remoteproc0: Falling back to user helper
[    7.672048] aic_dvdd: supplied by evm_3v3_sw
[    7.736112] omap_rng 48090000.rng: OMAP Random Number Generator ver. 20
[    8.067185] media: Linux media interface: v0.10
[    8.216475] omap_rtc 48838000.rtc: rtc core: registered 48838000.rtc as rtc0
[    8.217206] Linux video capture interface: v2.00
[    8.276707] random: nonblocking pool is initialized
[    8.394957] platform 48880000.omap_dwc3_1: Driver omap-dwc3 requests probe deferral
[    8.420281] platform 48880000.omap_dwc3_1: deferring probe: ==== Driver omap-dwc3 requests probe deferral
[    8.423788] ov1063x 1-0037: Failed writing register 0x0103!
[    8.423807] ov1063x: probe of 1-0037 failed with error -121
[    8.488870]  remoteproc0: failed to load dra7-ipu1-fw.xem4
[    8.729862] platform 488c0000.omap_dwc3_2: Driver omap-dwc3 requests probe deferral
[    8.733069] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    8.733072] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    8.733178] e1000e 0000:01:00.0: enabling device (0140 -> 0142)
[    8.733435] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    8.750383] omap_hwmod: usb_otg_ss1: _wait_target_disable failed
[    8.750685] platform 48880000.omap_dwc3_1: Driver omap-dwc3 requests probe deferral
[    8.750692] platform 48880000.omap_dwc3_1: deferring probe: ==== Driver omap-dwc3 requests probe deferral
[    8.779935] omap_hwmod: usb_otg_ss1: _wait_target_disable failed
[    8.780067] platform 48880000.omap_dwc3_1: Driver omap-dwc3 requests probe deferral
[    8.780073] platform 48880000.omap_dwc3_1: deferring probe: ==== Driver omap-dwc3 requests probe deferral
[    8.951061] CAN device driver interface
[    8.963296] e1000e 0000:01:00.0 eth2: registered PHC clock
[    8.963304] e1000e 0000:01:00.0 eth2: (PCI Express:2.5GT/s:Width x1) 68:05:ca:36:2b:25
[    8.963311] e1000e 0000:01:00.0 eth2: Intel(R) PRO/1000 Network Connection
[    8.966445] e1000e 0000:01:00.0 eth2: MAC: 3, PHY: 8, PBA No: E46981-008
[    9.024825] omap_hwmod: usb_otg_ss1: _wait_target_disable failed
[    9.027031] platform 48880000.omap_dwc3_1: Driver omap-dwc3 requests probe deferral
[    9.027039] platform 48880000.omap_dwc3_1: deferring probe: ==== Driver omap-dwc3 requests probe deferral
[    9.287323]  remoteproc2: Direct firmware load for dra7-dsp1-fw.xe66 failed with error -2
[    9.287327]  remoteproc2: Falling back to user helper
[    9.308265] omap-dwc3 48880000.omap_dwc3_1: **** dwc3_omap_probe done
[    9.341969] platform 488c0000.omap_dwc3_2: deferring probe: ==== Driver omap-dwc3 requests probe deferral
[    9.357153] vpe 489d0000.vpe: loading firmware vpdma-1b8.bin
[    9.363840]  remoteproc1: registered virtio0 (type 7)
[    9.390936] omap-dwc3 488c0000.omap_dwc3_2: **** dwc3_omap_probe done
[    9.411821] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    9.487056] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    9.530380] asoc-simple-card sound@0: tlv320aic3x-hifi <-> 48468000.mcasp mapping ok
[    9.572735] c_can_platform 4ae3c000.can: c_can_platform device registered (regs=fce3c000, irq=349)
[    9.585025] vip 48970000.vip: loading firmware vpdma-1b8.bin
[    9.592896] ahci 4a140000.sata: SSS flag set, parallel bus scan disabled
[    9.599650] ahci 4a140000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    9.608289] ahci 4a140000.sata: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part ccc apst 
[    9.703388] scsi host0: ahci
[    9.763672] omap-hdmi-audio omap-hdmi-audio.0.auto: snd-soc-dummy-dai <-> 58040000.encoder mapping ok
[    9.803153] ata1: SATA max UDMA/133 mmio [mem 0x4a140000-0x4a1410ff] port 0x100 irq 336
[   10.164442] ata1: SATA link down (SStatus 0 SControl 300)
[   10.642315]  remoteproc2: failed to load dra7-dsp1-fw.xe66
[   10.659698]  remoteproc3: Direct firmware load for dra7-dsp2-fw.xe66 failed with error -2
[   10.671669]  remoteproc3: Falling back to user helper
[   10.811525]  remoteproc1: powering up 55020000.ipu
[   10.820600] m25p80 spi32766.0: s25fl256s1 (32768 Kbytes)
[   10.820686] 10 ofpart partitions found on MTD device spi32766.0
[   10.820693] Creating 10 MTD partitions on "spi32766.0":
[   10.820702] 0x000000000000-0x000000010000 : "QSPI.SPL"
[   10.886395] 0x000000010000-0x000000020000 : "QSPI.SPL.backup1"
[   10.895608]  remoteproc3: failed to load dra7-dsp2-fw.xe66
[   10.909877] 0x000000020000-0x000000030000 : "QSPI.SPL.backup2"
[   10.912583] 0x000000030000-0x000000040000 : "QSPI.SPL.backup3"
[   10.913546] 0x000000040000-0x000000140000 : "QSPI.u-boot"
[   10.914433] vip 48970000.vip: VPDMA firmware loaded
[   10.914670] vpe 489d0000.vpe: Device registered as /dev/video0
[   10.938439] 0x000000140000-0x0000001c0000 : "QSPI.u-boot-spl-os"
[   10.962444] 0x0000001c0000-0x0000001d0000 : "QSPI.u-boot-env"
[   11.011549] 0x0000001d0000-0x0000001e0000 : "QSPI.u-boot-env.backup1"
[   11.071277] 0x0000001e0000-0x0000009e0000 : "QSPI.kernel"
[   11.080616] 0x0000009e0000-0x000002000000 : "QSPI.file-system"
[   11.415621] EXT4-fs (mmcblk0p3): mounted filesystem without journal. Opts: (null)
[   11.439508] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   11.476702]  remoteproc1: Booting fw image dra7-ipu2-fw.xem4, size 3480916
[   11.491518] EXT4-fs (mmcblk1p3): mounted filesystem without journal. Opts: (null)
[   11.495115] EXT4-fs (mmcblk1p2): warning: maximal mount count reached, running e2fsck is recommended
[   11.505950] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
[   11.536011] FAT-fs (mmcblk0p2): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   11.641063] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   11.690531] omap-iommu 55082000.mmu: 55082000.mmu: version 2.1
[   11.894821] dwc3 48890000.usb: **** dwc3_probe done
[   11.972740]  remoteproc1: remote processor 55020000.ipu is now up
[   11.999719] virtio_rpmsg_bus virtio0: rpmsg host is online
[   12.003008] virtio_rpmsg_bus virtio0: creating channel rpmsg-rpc addr 0x3b
[   12.085055] rpmsg_rpc rpmsg0: probing service rpmsg-dce with src 1024 dst 59
[   12.092778] rpmsg_rpc rpmsg0: published functions = 8
[   12.387531] dwc3 488d0000.usb: **** dwc3_probe done
[   12.555405] usbcore: registered new interface driver usbfs
[   12.561001] usbcore: registered new interface driver hub
[   12.566496] usbcore: registered new device driver usb
[   12.619632] dwc3 48890000.usb: otg: primary host xhci-hcd.1.auto registered
[   12.626635] dwc3 48890000.usb: otg: shared host xhci-hcd.1.auto registered
[   12.633543] dwc3 48890000.usb: otg: can't start till gadget registers
[   12.640118] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[   12.645652] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 1
[   12.653905] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[   12.662779] xhci-hcd xhci-hcd.2.auto: irq 463, io mem 0x488d0000
[   12.668985] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   12.681600] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.688857] usb usb1: Product: xHCI Host Controller
[   12.693757] usb usb1: Manufacturer: Linux 4.1.10-rt10-02639-gd63d0be-dirty xhci-hcd
[   12.701448] usb usb1: SerialNumber: xhci-hcd.2.auto
[   12.707274] hub 1-0:1.0: USB hub found
[   12.711077] hub 1-0:1.0: 1 port detected
[   12.715501] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[   12.721021] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 2
[   12.728804] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   12.737061] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   12.743880] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.751136] usb usb2: Product: xHCI Host Controller
[   12.756039] usb usb2: Manufacturer: Linux 4.1.10-rt10-02639-gd63d0be-dirty xhci-hcd
[   12.763727] usb usb2: SerialNumber: xhci-hcd.2.auto
[   12.769500] hub 2-0:1.0: USB hub found
[   12.773298] hub 2-0:1.0: 1 port detected
bootlogd: cannot allocate pseudo tty: No such file or directory
Starting random number generator daemon.
[   13.034435] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[   13.176262] usb 1-1: New USB device found, idVendor=154b, idProduct=007a
[   13.183002] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   13.190859] usb 1-1: Product: USB 2.0 FD
[   13.194810] usb 1-1: Manufacturer: PNY Technologies
[   13.199717] usb 1-1: SerialNumber: AEC12H25YE11003156
[   13.209498] usb 1-1: ep 0x81 - rounding interval to 128 microframes, ep desc says 255 microframes
[   13.218598] usb 1-1: ep 0x2 - rounding interval to 128 microframes, ep desc says 255 microframes
[   13.280307] usb-storage 1-1:1.0: USB Mass Storage device detected
[   13.287194] scsi host1: usb-storage 1-1:1.0
[   13.293029] usbcore: registered new interface driver usb-storage


