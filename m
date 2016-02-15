From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 19:41:21 +0100
Message-ID: <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
References: <20160215170527.GA24453@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35556 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbcBOSlX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 13:41:23 -0500
In-Reply-To: <20160215170527.GA24453@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, Feb 15, 2016 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Rafael,

Hi,

Thanks for the report!

> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
> timers with utilization update callbacks' with next-20160215. An example
> crash log and bisect results are attached below.
>
> Please let me know if there is anything I can do to help tracking down
> the problem.

It looks like we've uncovered some nastiness in the arch ARM code (see below).

[cut]

> [    1.340000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    1.340000] pgd = c0204000
> [    1.340000] [00000000] *pgd=00000000
> [    1.340000] Internal error: Oops: 80000005 [#1] SMP ARM
> [    1.340000] Modules linked in:
> [    1.340000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215 #1
> [    1.340000] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
> [    1.340000] task: cb060000 ti: cb05a000 task.ti: cb05a000
> [    1.340000] PC is at 0x0
> [    1.340000] LR is at arch_send_call_function_single_ipi+0x34/0x38

Since this is ARM, arch_send_call_function_single_ipi() looks like this:

void arch_send_call_function_single_ipi(int cpu)
{
         smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
}

so I'm not sure how the NULL pointer deref is possible even.

The only thing coming to mind would be that cpumask_of(cpu) triggers
this, but I'm not sure how exactly that can happen.

I need help from somebody who knows how this low-level stuff works on ARM.

> [    1.340000] pc : [<00000000>]    lr : [<c030de78>]    psr: 20000193
> [    1.340000] sp : cb05b7c0  ip : 00000000  fp : cb05b83c
> [    1.340000] r10: cfb8c0c0  r9 : 00000000  r8 : cb18a4c0
> [    1.340000] r7 : 00000005  r6 : 00000005  r5 : cb5c0334  r4 : 00000000
> [    1.340000] r3 : 00000000  r2 : c0c06a7c  r1 : 00000003  r0 : c0c06a7c
> [    1.340000] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.340000] Control: 10c5387d  Table: 80204059  DAC: 00000051
> [    1.340000] Process swapper/0 (pid: 1, stack limit = 0xcb05a220)
> [    1.340000] Stack: (0xcb05b7c0 to 0xcb05c000)
> [    1.340000] b7c0: 00000000 c03b3350 4fdec700 00000000 00000005 c0959a84 ffffffff 00000000
> [    1.340000] b7e0: ffffffff cb18a4c0 cfb8c0c0 c03732d8 4c4b4000 cb18a4c0 cfb8c0c0 cfb8c0c0
> [    1.340000] b800: 0e979000 cb18a4c0 cfb8c0c0 00000005 0e979000 c12130c0 00000000 cfb8c0c0
> [    1.340000] b820: cb05b83c c0360d28 00000000 cb18a4c0 cfb8c0c0 60000193 cb05b84c c0360fc0
> [    1.340000] b840: cb18a4c0 cb18a8b4 cb05b87c c0361b74 cfb8c100 00000141 cb05b934 cb1c1cc0
> [    1.340000] b860: 00000002 00000000 00000000 00000048 c1416d0c cb0096c0 00000001 c0381de0
> [    1.340000] b880: c1416080 cfb8c100 00000400 cb0096c0 cb009720 00000000 00000038 cb003000
> [    1.340000] b8a0: 00000000 cb05b9c4 00000a28 c0381ea4 cb0096c0 cb0096d0 00000000 c0385150
> [    1.340000] b8c0: c03850ac c1211518 00000000 c038168c 00000155 c0381788 c0932830 20000013
> [    1.340000] b8e0: ffffffff cb05b924 00000000 c030bad4 00000001 00000009 00000002 fa070024
> [    1.340000] b900: cb127c10 00009401 cb05b9b8 c1302100 00000000 00000000 cb05b9c4 00000a28
> [    1.340000] b920: 00000000 cb05b940 00009601 c0932830 20000013 ffffffff 00000051 c093261c
> [    1.340000] b940: 00000014 cb127c58 00000002 00000001 000f4240 cb127c10 1443fd00 00000001
> [    1.340000] b960: c1302100 cb127c58 cb05b9b8 00000002 c145d438 ffff16ac 00000001 c0928358
> [    1.340000] b980: cb127c74 cb127c58 00000002 cb05b9b8 cb05ba97 00000001 cb05ba97 00000001
> [    1.340000] b9a0: 00000001 c0928538 00000000 cb518000 cb513740 c07726c4 0000004b cfb80001
> [    1.340000] b9c0: cb513740 0001004b 017d0001 cb05ba97 00000000 c076dc30 00000001 00000000
> [    1.340000] b9e0: 00000004 000000b9 000000ba cb518000 000000ba 000000b9 00000001 c076dd70
> [    1.340000] ba00: 00000000 00000000 cfb8c100 cb518000 000000ba 00000001 00000001 cb05ba97
> [    1.340000] ba20: 00000001 000000b9 00000000 c076dfcc c099a208 cb59d048 00000001 c1336dd0
> [    1.340000] ba40: a0000113 00000000 00000001 cb05ba97 0000005e 00000004 00000001 00000000
> [    1.340000] ba60: 00000000 000ee098 000ee098 c077fd34 0000000d c09e51f0 c09e51d0 cb51f400
> [    1.340000] ba80: ffffffff 000ee098 000ee098 c068cb48 00000000 c09c157c cb019180 c067887c
> [    1.340000] baa0: cb51f400 c067a700 000ee098 c09c160c cb015780 00000000 3b9aca00 cb5bdcc0
> [    1.340000] bac0: cb51f400 00000000 00000000 00000000 000ee098 c067ab5c 000ee098 000ee098
> [    1.340000] bae0: cb5bdcc0 000ee098 000ee098 000ee098 cfb87050 00000000 000ee098 c067c614
> [    1.340000] bb00: cb5bdcc0 000ee098 000ee098 c0765ad4 1dcd6500 cb5bdc80 00000000 07735940
> [    1.340000] bb20: cb5bdc80 cfb87050 cb5bdcc0 00000000 000ee098 c076660c 000ee098 cb5c11d0
> [    1.340000] bb40: cb05bb90 00124f80 00124f80 00124f80 07735940 1dcd6500 ffffffff cb5c1100
> [    1.340000] bb60: 00000000 00000000 c145dc8c cb5c0280 00000000 00000001 cb05bb90 c0958e78
> [    1.340000] bb80: cb05bb8c c13cb404 00000000 00000000 00000010 0007a120 0001e848 00000021
> [    1.340000] bba0: ffffffff ee222d90 00000000 00000000 00000000 00000010 cfb8b598 c13cb310
> [    1.340000] bbc0: c1302578 c095ca58 c1302578 00000000 cb5c1100 00000000 000927c0 cb5bdfc0
> [    1.340000] bbe0: c120e300 00000000 ee32cf60 00000000 c13cb310 cb5c1100 00000000 cb5c0304
> [    1.340000] bc00: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c095cd04 c145dc8c 00000001
> [    1.340000] bc20: cb5c1100 cb5c1100 00000000 c145dc8c c1302578 00000003 cb5c1100 00000000
> [    1.340000] bc40: 00000010 c145dc8c c1302578 cb5c11b4 cb5c1108 c0959c5c cb5c1100 00000000
> [    1.340000] bc60: 00000000 c095a2dc c0c0df58 00000001 0000ffff 00000001 00000000 00000000
> [    1.340000] bc80: cb5bdc00 000927c0 0001e848 000493e0 0001e848 000927c0 0007a120 00000000
> [    1.340000] bca0: 00000000 00000000 00000000 c13cb310 00000000 00000000 00000000 00000000
> [    1.340000] bcc0: 00000000 00000000 ffffffe0 cb5c1160 cb5c1160 c095abf4 0001e848 000927c0
> [    1.340000] bce0: cb5c0280 c13cb0a8 c13cb0a8 cb5bdf00 cb5c1184 cb5c1184 cb11e600 00000000
> [    1.340000] bd00: c13cb128 cb5bf460 00000001 00000003 00000000 00000000 cb5c11ac cb5c11ac
> [    1.340000] bd20: ffff0001 cb5c11b8 cb5c11b8 00000000 00000000 cb060000 00000000 00000000
> [    1.340000] bd40: 00000000 cb5c11d8 cb5c11d8 00000000 cb5bdf80 cb5bdec0 cb5c1100 c095a5f0
> [    1.340000] bd60: 00000000 cb11e600 00000000 c1212594 60000013 00000001 00000000 c13cb110
> [    1.340000] bd80: c13acc68 c13cb0a8 c13cb440 c13cb440 00000000 00000000 00000000 c075674c
> [    1.340000] bda0: c13cb440 cb00cc5c cb169db4 00000000 c1334248 c13cb488 c145dc8c c0959764
> [    1.340000] bdc0: ffffffed cfb87050 cb5e2600 c095d670 ffffffed cb5e2610 fffffdfb c0758e48
> [    1.340000] bde0: c0758df8 cb5e2610 c1459090 c1459098 00000000 c07577b0 00000000 00000000
> [    1.340000] be00: cb05be30 c0757a68 00000001 c145906c 00000000 c0755d3c cb00cb70 cb5938b8
> [    1.340000] be20: cb5e2610 cb5e2644 c13aca58 c0757534 cb5e2610 00000001 00000000 cb5e2610
> [    1.340000] be40: cb5e2610 c13aca58 c13acaa8 c0756bc0 cb5e2610 00000000 cb5e2618 c07550c0
> [    1.340000] be60: 00000000 c0587884 cb05beb8 cb5e2600 00000000 cb5e2600 cb5e2610 c1419000
> [    1.340000] be80: c110362c c11a183c 00000000 c0758fdc 00000000 cb05beb8 cb5e2600 cb5bdb00
> [    1.340000] bea0: c1419000 c07597a8 c0ead2ac c1306788 c1306788 c1112510 00000000 00000000
> [    1.340000] bec0: c0ead2ac 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.340000] bee0: 00000000 00000000 00000000 c110f828 c110fabc c110fac4 c110fabc c1103648
> [    1.340000] bf00: c1306788 c0301d28 0000006f cb05bf28 c035a8bc c035a8cc 60000013 ffffffff
> [    1.340000] bf20: 00000051 c058b428 c0ff5b24 c0c1da88 0000011a c035ab48 c11a183c c0ea7034
> [    1.340000] bf40: c0ff451c 00000000 00000007 00000007 c1335704 cfb96300 c120de7c 00000007
> [    1.340000] bf60: c11a1834 c1419000 0000011a c11a183c c1100598 c1100dc4 00000007 00000007
> [    1.340000] bf80: 00000000 c1100598 00000000 c0b0bcfc 00000000 00000000 00000000 00000000
> [    1.340000] bfa0: 00000000 c0b0bd04 00000000 c0307e78 00000000 00000000 00000000 00000000
> [    1.340000] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.340000] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    1.340000] [<c030de78>] (arch_send_call_function_single_ipi) from [<c03b3350>] (irq_work_queue_on+0x90/0x100)
> [    1.340000] [<c03b3350>] (irq_work_queue_on) from [<c0959a84>] (cpufreq_update_util+0x40/0x4c)
> [    1.340000] [<c0959a84>] (cpufreq_update_util) from [<c03732d8>] (enqueue_task_rt+0x28/0x26c)
> [    1.340000] [<c03732d8>] (enqueue_task_rt) from [<c0360d28>] (activate_task+0x60/0x64)
> [    1.340000] [<c0360d28>] (activate_task) from [<c0360fc0>] (ttwu_do_activate.constprop.13+0x34/0x68)
> [    1.340000] [<c0360fc0>] (ttwu_do_activate.constprop.13) from [<c0361b74>] (try_to_wake_up+0x1a0/0x318)
> [    1.340000] [<c0361b74>] (try_to_wake_up) from [<c0381de0>] (handle_irq_event_percpu+0xdc/0x15c)
> [    1.340000] [<c0381de0>] (handle_irq_event_percpu) from [<c0381ea4>] (handle_irq_event+0x44/0x68)
> [    1.340000] [<c0381ea4>] (handle_irq_event) from [<c0385150>] (handle_level_irq+0xa4/0x13c)
> [    1.340000] [<c0385150>] (handle_level_irq) from [<c038168c>] (generic_handle_irq+0x18/0x28)
> [    1.340000] [<c038168c>] (generic_handle_irq) from [<c0381788>] (__handle_domain_irq+0x54/0xb0)
> [    1.340000] [<c0381788>] (__handle_domain_irq) from [<c030bad4>] (__irq_svc+0x54/0x70)
> [    1.340000] [<c030bad4>] (__irq_svc) from [<c0932830>] (omap_i2c_xfer+0x320/0x5a0)

It looks like we got an interrupt in the middle of an i2c transaction
changing the CPU OPP.  The handler of that tried to enqueue an RT task
and that led to a cpufreq update that in turn triggered the crash.

That's during cpufreq_online(), so it looks like something might not
be set up entirely somewhere.

> [    1.340000] [<c0932830>] (omap_i2c_xfer) from [<c0928358>] (__i2c_transfer+0x140/0x29c)
> [    1.340000] [<c0928358>] (__i2c_transfer) from [<c0928538>] (i2c_transfer+0x84/0xd4)
> [    1.340000] [<c0928538>] (i2c_transfer) from [<c07726c4>] (regmap_i2c_read+0x48/0x64)
> [    1.340000] [<c07726c4>] (regmap_i2c_read) from [<c076dc30>] (_regmap_raw_read+0xa4/0x110)
> [    1.340000] [<c076dc30>] (_regmap_raw_read) from [<c076dd70>] (regmap_raw_read+0xd4/0x170)
> [    1.340000] [<c076dd70>] (regmap_raw_read) from [<c076dfcc>] (regmap_bulk_read+0x1c0/0x2b0)
> [    1.340000] [<c076dfcc>] (regmap_bulk_read) from [<c077fd34>] (twl_i2c_read+0x48/0x8c)
> [    1.340000] [<c077fd34>] (twl_i2c_read) from [<c068cb48>] (twl4030smps_get_voltage+0x44/0x60)
> [    1.340000] [<c068cb48>] (twl4030smps_get_voltage) from [<c067887c>] (_regulator_get_voltage+0x68/0xb8)
> [    1.340000] [<c067887c>] (_regulator_get_voltage) from [<c067a700>] (_regulator_do_set_voltage+0x48/0x320)
> [    1.340000] [<c067a700>] (_regulator_do_set_voltage) from [<c067ab5c>] (regulator_set_voltage_unlocked+0xcc/0x220)
> [    1.340000] [<c067ab5c>] (regulator_set_voltage_unlocked) from [<c067c614>] (regulator_set_voltage+0x28/0x54)
> [    1.340000] [<c067c614>] (regulator_set_voltage) from [<c0765ad4>] (_set_opp_voltage+0x34/0x90)
> [    1.340000] [<c0765ad4>] (_set_opp_voltage) from [<c076660c>] (dev_pm_opp_set_rate+0x19c/0x288)
> [    1.340000] [<c076660c>] (dev_pm_opp_set_rate) from [<c0958e78>] (__cpufreq_driver_target+0x180/0x2a0)
> [    1.340000] [<c0958e78>] (__cpufreq_driver_target) from [<c095ca58>] (dbs_check_cpu+0x1ac/0x1e8)
> [    1.340000] [<c095ca58>] (dbs_check_cpu) from [<c095cd04>] (cpufreq_governor_dbs+0x1fc/0x608)
> [    1.340000] [<c095cd04>] (cpufreq_governor_dbs) from [<c0959c5c>] (__cpufreq_governor+0x1a8/0x204)
> [    1.340000] [<c0959c5c>] (__cpufreq_governor) from [<c095a2dc>] (cpufreq_init_policy+0x60/0x8c)
> [    1.340000] [<c095a2dc>] (cpufreq_init_policy) from [<c095a5f0>] (cpufreq_online+0x2e8/0x708)
> [    1.340000] [<c095a5f0>] (cpufreq_online) from [<c075674c>] (subsys_interface_register+0x80/0xc4)
> [    1.340000] [<c075674c>] (subsys_interface_register) from [<c0959764>] (cpufreq_register_driver+0x144/0x1a0)

This is the registration of the cpufreq driver (cpufreq-dt in this case).

It does cpufreq_online()->cpufreq_init_policy()->__cpufreq_governor()->cpufreq_governor_dbs()->dbs_check_cpu().

The only way that can happen is when cpufreq_set_policy() finds that
the "old" and the "new" policies use the same governor, so it goes and
calls __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS), but I'm not sure
how this is possible during the initialization ATM.

Viresh, any ideas?

> [    1.340000] [<c0959764>] (cpufreq_register_driver) from [<c095d670>] (dt_cpufreq_probe+0x64/0xe8)
> [    1.340000] [<c095d670>] (dt_cpufreq_probe) from [<c0758e48>] (platform_drv_probe+0x50/0xb0)
> [    1.340000] [<c0758e48>] (platform_drv_probe) from [<c07577b0>] (driver_probe_device+0x1f4/0x2b0)
> [    1.340000] [<c07577b0>] (driver_probe_device) from [<c0755d3c>] (bus_for_each_drv+0x44/0x8c)
> [    1.340000] [<c0755d3c>] (bus_for_each_drv) from [<c0757534>] (__device_attach+0x9c/0x100)
> [    1.340000] [<c0757534>] (__device_attach) from [<c0756bc0>] (bus_probe_device+0x84/0x8c)
> [    1.340000] [<c0756bc0>] (bus_probe_device) from [<c07550c0>] (device_add+0x33c/0x528)
> [    1.340000] [<c07550c0>] (device_add) from [<c0758fdc>] (platform_device_add+0xa8/0x20c)
> [    1.340000] [<c0758fdc>] (platform_device_add) from [<c07597a8>] (platform_device_register_full+0xe0/0x108)
> [    1.340000] [<c07597a8>] (platform_device_register_full) from [<c1112510>] (omap2_common_pm_late_init+0xc8/0x10c)
> [    1.340000] [<c1112510>] (omap2_common_pm_late_init) from [<c110f828>] (omap_common_late_init+0xc/0x14)
> [    1.340000] [<c110f828>] (omap_common_late_init) from [<c110fac4>] (omap3_init_late+0x8/0x14)
> [    1.340000] [<c110fac4>] (omap3_init_late) from [<c1103648>] (init_machine_late+0x1c/0x90)
> [    1.340000] [<c1103648>] (init_machine_late) from [<c0301d28>] (do_one_initcall+0x84/0x1d4)
> [    1.340000] [<c0301d28>] (do_one_initcall) from [<c1100dc4>] (kernel_init_freeable+0x120/0x1ec)
> [    1.340000] [<c1100dc4>] (kernel_init_freeable) from [<c0b0bd04>] (kernel_init+0x8/0xec)
> [    1.340000] [<c0b0bd04>] (kernel_init) from [<c0307e78>] (ret_from_fork+0x14/0x3c)
> [    1.340000] Code: bad PC value
> [    1.340000] ---[ end trace 384223760a5ee799 ]---
> [    1.340000] Kernel panic - not syncing: Fatal exception in interrupt
> [    1.340000] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
