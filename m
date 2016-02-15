From: Tony Lindgren <tony@atomide.com>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 11:42:27 -0800
Message-ID: <20160215194227.GY19432@atomide.com>
References: <20160215170527.GA24453@roeck-us.net>
 <56C22105.6050900@arm.com>
 <CAJZ5v0gXGzzJ7CcbgNNO-ULrtd9Z2hbqHeuXRYJLFLrh+BWVWA@mail.gmail.com>
 <1508162.Id3YElPxB2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:34905 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbcBOTme (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 14:42:34 -0500
Content-Disposition: inline
In-Reply-To: <1508162.Id3YElPxB2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

* Rafael J. Wysocki <rjw@rjwysocki.net> [160215 11:28]:
> 
> Guenter, Tony,
> 
> Below is a patch to try, on top of linux-next.

Fixes the issue on UP for me:

Tested-by: Tony Lindgren <tony@atomide.com>

> Please let me know if the problem is still around with that patch applied.

It seems we still have another issue with SMP systems, see below.

Regards,

Tony

8< ------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000030
pgd = c0204000
[00000030] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215-00002-g08cd608 #895
Hardware name: Generic OMAP4 (Flattened Device Tree)
task: ee870000 ti: ee85e000 task.ti: ee85e000
PC is at regulator_set_voltage+0x10/0x54
LR is at _set_opp_voltage+0x30/0x98
pc : [<c0684270>]    lr : [<c0774900>]    psr: 00000113
sp : ee85fb20  ip : 00000001  fp : 000fa3e8
r10: 000fa3e8  r9 : 000fa3e8  r8 : 00000000
r7 : ef7ab050  r6 : 000fa3e8  r5 : 000fa3e8  r4 : 00000000
r3 : 000fa3e8  r2 : 000fa3e8  r1 : 000fa3e8  r0 : 00000000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8020404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xee85e220)
Stack: (0xee85fb20 to 0xee860000)
fb20: 00000000 000fa3e8 000fa3e8 c0774900 eedc8500 11e1a300 00000000 11e1a300
fb40: ef7ab050 eedc8500 00000000 ef7ab050 eedc8540 c0775488 000fa3e8 00000000
fb60: 00000000 00124f80 00124f80 00124f80 11e1a300 23c34600 00000000 00000000
fb80: eea82e00 c144e250 eedc86c0 00000000 00000000 00000000 00000000 c096d8ec
fba0: ee85fbac ee85fbf8 00000001 00000000 00000010 000927c0 000493e0 00000021
fbc0: 00000010 00000000 c13bc9c4 c1302574 ef7bc598 0000001e eea82e00 c0971684
fbe0: 000927c0 eedc87c0 c1211598 00000000 c120d300 c1302670 001ef19f 00000000
fc00: c1302574 00000000 eea82e00 00000003 eedcbe04 c144e250 00000010 eea82eb4
fc20: c1302574 c0971ab0 c144e250 eea82e00 eea82e00 00000001 00000000 c144e250
fc40: 00000010 eea82e00 00000000 00000003 c13bc750 c144e250 00000010 eea82eb4
fc60: c1302574 c096eb20 eea82e00 00000000 eea82e08 c096f344 eedcca00 00000003
fc80: 0000ffff 00000003 00000000 00000000 eedc8440 000f6180 000493e0 000493e0
fca0: 000493e0 000f6180 000927c0 00000000 00000000 00000000 00000000 c13bc9c4
fcc0: 00000000 00000000 00000000 00000000 00000000 00000000 ffffffe0 eea82e60
fce0: eea82e60 c096f188 000493e0 000f6180 eedc86c0 c13bc750 c13bc750 eedc8700
fd00: eea82e84 eea82e84 ee9357c0 00000000 c13bc7d0 eedcc4b0 00000001 00000003
fd20: 00000000 00000000 eea82eac eea82eac ffff0001 eea82eb8 eea82eb8 00000000
fd40: 00000000 ee870000 00000000 00000000 00000000 eea82ed8 eea82ed8 00000000
fd60: eedc8780 eedc8680 eea82e00 c096fa00 00000001 60000113 eea82e04 00000000
fd80: ee85fdac c13bc7a4 c139e468 c13bc750 fffffdfb 00000000 00000000 00000000
fda0: 00000000 c0764dd0 c144e904 ee82fc5c ee99e4b4 00000000 c1334208 c13bcb30
fdc0: c144e250 c096e690 eedc8440 ef7ab050 eee32200 c0972368 eee32210 eee32210
fde0: c13bcae8 c0767e5c eee32210 c1449eac c1449eb4 c13bcae8 00000000 c07666c0
fe00: 00000000 ee85fe38 c07667fc 00000001 c1449e88 00000000 00000000 c0764ab4
fe20: ee82fb70 eedf3338 eee32210 eee32244 c139e3e8 c07663cc eee32210 00000001
fe40: eee32218 eee32218 eee32210 c139e3e8 00000000 c07658ac eee32218 eee32210
fe60: c139e260 c0763bfc c120ce1c c058e688 ee85fec0 eee32200 00000000 eee32200
fe80: eee32210 c1103670 00000000 c120ce1c 0000011a c0767bbc ee85fec0 eee32200
fea0: eedc8340 c1103670 00000000 c07685a8 c144e908 c1306810 eedc8340 c11122e0
fec0: 00000000 00000000 c0ec230c 00000000 00000000 00000000 00000000 00000000
fee0: 00000000 00000000 00000000 00000000 c1306810 c110f738 c1306810 c110fc30
ff00: c1306810 c1103690 c1306810 c0301d5c 00000000 c0463578 00000000 ee842b80
ff20: 00000000 c13356dc efffc0bf 0000011a c0c1d73c c035aac0 00000000 c0ebc080
ff40: c10095f8 00000000 00000007 00000007 c13356c4 00000007 c140a000 c140a000
ff60: 00000007 c140a000 c140a000 c11a1838 c11a183c c1100e14 00000007 00000007
ff80: 00000000 c1100594 00000000 c0b26878 00000000 00000000 00000000 00000000
ffa0: 00000000 c0b26880 00000000 c0307d78 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 a1718b7d a59ff7d9
[<c0684270>] (regulator_set_voltage) from [<c0774900>] (_set_opp_voltage+0x30/0x98)
[<c0774900>] (_set_opp_voltage) from [<c0775488>] (dev_pm_opp_set_rate+0x170/0x28c)
[<c0775488>] (dev_pm_opp_set_rate) from [<c096d8ec>] (__cpufreq_driver_target+0x180/0x2b4)
[<c096d8ec>] (__cpufreq_driver_target) from [<c0971684>] (dbs_check_cpu+0x19c/0x1d0)
[<c0971684>] (dbs_check_cpu) from [<c0971ab0>] (cpufreq_governor_dbs+0x274/0x620)
[<c0971ab0>] (cpufreq_governor_dbs) from [<c096eb20>] (__cpufreq_governor+0xf0/0x1a4)
[<c096eb20>] (__cpufreq_governor) from [<c096f344>] (cpufreq_init_policy+0x64/0x8c)
[<c096f344>] (cpufreq_init_policy) from [<c096fa00>] (cpufreq_online+0x2f8/0x714)
[<c096fa00>] (cpufreq_online) from [<c0764dd0>] (subsys_interface_register+0x94/0xd8)
[<c0764dd0>] (subsys_interface_register) from [<c096e690>] (cpufreq_register_driver+0x14c/0x19c)
[<c096e690>] (cpufreq_register_driver) from [<c0972368>] (dt_cpufreq_probe+0x70/0xec)
[<c0972368>] (dt_cpufreq_probe) from [<c0767e5c>] (platform_drv_probe+0x4c/0xb0)
[<c0767e5c>] (platform_drv_probe) from [<c07666c0>] (driver_probe_device+0x214/0x2c0)
[<c07666c0>] (driver_probe_device) from [<c0764ab4>] (bus_for_each_drv+0x60/0x94)
[<c0764ab4>] (bus_for_each_drv) from [<c07663cc>] (__device_attach+0xb0/0x114)
[<c07663cc>] (__device_attach) from [<c07658ac>] (bus_probe_device+0x84/0x8c)
[<c07658ac>] (bus_probe_device) from [<c0763bfc>] (device_add+0x370/0x56c)
[<c0763bfc>] (device_add) from [<c0767bbc>] (platform_device_add+0xfc/0x224)
[<c0767bbc>] (platform_device_add) from [<c07685a8>] (platform_device_register_full+0xf8/0x120)
[<c07685a8>] (platform_device_register_full) from [<c11122e0>] (omap2_common_pm_late_init+0x108/0x114)
[<c11122e0>] (omap2_common_pm_late_init) from [<c110f738>] (omap_common_late_init+0xc/0x14)
[<c110f738>] (omap_common_late_init) from [<c110fc30>] (dra7xx_init_late+0x8/0x14)
[<c110fc30>] (dra7xx_init_late) from [<c1103690>] (init_machine_late+0x20/0x98)
[<c1103690>] (init_machine_late) from [<c0301d5c>] (do_one_initcall+0x90/0x1d8)
[<c0301d5c>] (do_one_initcall) from [<c1100e14>] (kernel_init_freeable+0x15c/0x1fc)
[<c1100e14>] (kernel_init_freeable) from [<c0b26880>] (kernel_init+0x8/0xf0)
[<c0b26880>] (kernel_init) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
Code: e92d4070 e1a04000 e1a05001 e1a06002 (e5900030) 
---[ end trace d0b8b8949b1b4202 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.5.0-rc4-next-20160215-00002-g08cd608 #895
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0310290>] (unwind_backtrace) from [<c030b98c>] (show_stack+0x10/0x14)
[<c030b98c>] (show_stack) from [<c058c174>] (dump_stack+0x90/0xa4)
[<c058c174>] (dump_stack) from [<c030ea58>] (handle_IPI+0x174/0x194)
[<c030ea58>] (handle_IPI) from [<c030175c>] (gic_handle_irq+0x90/0x94)
[<c030175c>] (gic_handle_irq) from [<c030c4d4>] (__irq_svc+0x54/0x70)
Exception stack(0xee895eb0 to 0xee895ef8)
5ea0:                                     00200040 c140cb80 00000001 00000000
5ec0: 00000082 00000000 ee894000 00000001 c1302080 fa241100 ee895fe0 c1302504
5ee0: 00000001 ee895f00 c0344a8c c0344668 60000113 ffffffff
[<c030c4d4>] (__irq_svc) from [<c0344668>] (__do_softirq+0x90/0x214)
[<c0344668>] (__do_softirq) from [<c0344a8c>] (irq_exit+0xb0/0x118)
[<c0344a8c>] (irq_exit) from [<c0382f88>] (__handle_domain_irq+0x60/0xb4)
[<c0382f88>] (__handle_domain_irq) from [<c0301720>] (gic_handle_irq+0x54/0x94)
[<c0301720>] (gic_handle_irq) from [<c030c4d4>] (__irq_svc+0x54/0x70)
Exception stack(0xee895f88 to 0xee895fd0)
5f80:                   00000001 00000000 00000000 c031af20 ee894000 c13024a4
5fa0: 00000000 00000000 c120d3a8 c12115d8 ee895fe0 c1302504 00000000 ee895fd8
5fc0: c030878c c0308790 60000113 ffffffff
[<c030c4d4>] (__irq_svc) from [<c0308790>] (arch_cpu_idle+0x38/0x3c)
[<c0308790>] (arch_cpu_idle) from [<c0377808>] (cpu_startup_entry+0x1e4/0x240)
[<c0377808>] (cpu_startup_entry) from [<80301b6c>] (0x80301b6c)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

