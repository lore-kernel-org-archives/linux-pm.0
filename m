From: Mason <slash.tmp@free.fr>
Subject: Re: Linux panics when suspend cannot offline the secondary cores
Date: Mon, 13 Jun 2016 14:06:14 +0200
Message-ID: <575EA1B6.8030405@free.fr>
References: <575ADFAC.4090009@free.fr> <2026483.61HqCp9Eli@vostro.rjw.lan>
 <575B3326.1050500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:15157 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161071AbcFMMGi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 08:06:38 -0400
In-Reply-To: <575B3326.1050500@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Frias <sf84@laposte.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>

On 10/06/2016 23:37, Mason wrote:

> On 10/06/2016 23:35, Rafael J. Wysocki wrote:
> 
>> On Friday, June 10, 2016 05:41:32 PM Mason wrote:
>>
>>> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
>>> unhappy when the suspend framework fails to offline secondary cores.
>>>
>>> Is this expected/by design, or could it fail more gracefully?
>>> (It could also be something missing in my platform's code.)
>>
>> This looks like a CPU offline bug to me which is more general than just
>> system suspend.
> 
> You may be right, I will try just off-lining cpu1.
> Suspend may be a red herring.
> 
> By the way, I know my implementation of tango_cpu_die
> is incorrect, I was testing the failure mode.

Hello Rafael,

Suspend was indeed a red herring. Manually requesting cpu1 off-lining
also makes Linux panic when cpu_die() unexpectedly returns.

The subject should perhaps have been:

  Linux panics when secondary core off-lining fails

Could it be made to fail more gracefully?
Or is this borkage inherent to the failed operation?
Or is it a bug in my platform code?
(A bug other than tango_cpu_die() failing to kill the core.)


#ifdef CONFIG_HOTPLUG_CPU
static int tango_cpu_kill(unsigned int cpu)
{
	printk("IN %s\n", __func__);
	return 1;
}

static void tango_cpu_die(unsigned int cpu)
{
	printk("IN %s\n", __func__);
}
#endif


Regards.


# echo 0 > /sys/devices/system/cpu/cpu1/online
[   60.619026] CPU1: shutdown
[   60.619031] IN tango_cpu_die
[   60.619041] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
[   60.619063] BUG: scheduling while atomic: swapper/1/0/0x00000002
[   60.619069] Modules linked in:
[   60.619088] Preemption disabled at:[<c04a5898>] schedule_preempt_disabled+0x20/0x24
[   60.619089] 
[   60.619098] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
[   60.619099] Hardware name: Sigma Tango DT
[   60.619104] Backtrace: 
[   60.619121] [<c010b974>] (dump_backtrace) from [<c010bb70>] (show_stack+0x18/0x1c)
[   60.619129]  r7:60000013 r6:c080eb04 r5:00000000 r4:c080eb04
[   60.619141] [<c010bb58>] (show_stack) from [<c02eb084>] (dump_stack+0x80/0x94)
[   60.619150] [<c02eb004>] (dump_stack) from [<c013cb34>] (__schedule_bug+0x6c/0xb8)
[   60.619157]  r7:c0802638 r6:df45b6c0 r5:dfbeaec0 r4:df45c000
[   60.619162] [<c013cac8>] (__schedule_bug) from [<c04a522c>] (__schedule+0x434/0x530)
[   60.619167]  r5:dfbeaec0 r4:c0736ec0
[   60.619172] [<c04a4df8>] (__schedule) from [<c04a5378>] (schedule+0x50/0xb0)
[   60.619182]  r10:00000000 r9:c08024f8 r8:c05b8b6c r7:c081e2d6 r6:c05ce0b8 r5:c0802494
[   60.619184]  r4:df45c000
[   60.619190] [<c04a5328>] (schedule) from [<c04a5890>] (schedule_preempt_disabled+0x18/0x24)
[   60.619195]  r5:c0802494 r4:df45c000
[   60.619206] [<c04a5878>] (schedule_preempt_disabled) from [<c0155f0c>] (cpu_startup_entry+0x10c/0x18c)
[   60.619213] [<c0155e00>] (cpu_startup_entry) from [<c010dc14>] (secondary_start_kernel+0x158/0x164)
[   60.619218]  r7:c081e2d6 r4:c080b530
[   60.619226] [<c010dabc>] (secondary_start_kernel) from [<c04a9208>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
[   60.619231]  r5:c0802494 r4:00000001
[   60.775838] IN tango_cpu_kill
[   60.779453] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[   60.787593] pgd = c0004000
[   60.790307] [00000010] *pgd=00000000
[   60.793901] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   60.799324] Modules linked in:
[   60.802393] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
[   60.813493] Hardware name: Sigma Tango DT
[   60.817518] task: df45b6c0 ti: df45c000 task.ti: df45c000
[   60.822948] PC is at __tick_nohz_idle_enter+0x2d8/0x444
[   60.828204] LR is at debug_smp_processor_id+0x20/0x24
[   60.833278] pc : [<c0184d1c>]    lr : [<c030305c>]    psr: 60000093
[   60.833278] sp : df45df50  ip : df45df20  fp : df45dfac
[   60.844815] r10: 00000000  r9 : 00000000  r8 : 00000000
[   60.850063] r7 : 00000000  r6 : 0032dcd5  r5 : 00000001  r4 : dfbe8e38
[   60.856620] r3 : 00000000  r2 : 0032dcd5  r1 : 00000000  r0 : 0032dcd5
[   60.863179] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   60.870435] Control: 10c5387d  Table: 9ed8804a  DAC: 00000051
[   60.876206] Process swapper/1 (pid: 0, stack limit = 0xdf45c210)
[   60.882240] Stack: (0xdf45df50 to 0xdf45e000)
[   60.886616] df40:                                     c04a4fcc c013c8b0 00000001 00000000
[   60.894836] df60: 26c51b42 0000000e 269f8229 0000000e 26923e6d 0000000e 269f8229 0000000e
[   60.903057] df80: ffffffff 7fffffff c0734e38 c0802494 c05ce0b8 c081e2d6 c05b8b6c c08024f8
[   60.911276] dfa0: df45dfc4 df45dfb0 c0185294 c0184a50 df45c000 c0802494 df45dfdc df45dfc8
[   60.919495] dfc0: c0155e58 c0185258 c080b530 c081e2d6 df45dff4 df45dfe0 c010dc14 c0155e0c
[   60.927716] dfe0: 00000001 c0802494 00000000 df45dff8 c04a9208 c010dac8 c1640288 22a54aa8
[   60.935932] Backtrace: 
[   60.938391] [<c0184a44>] (__tick_nohz_idle_enter) from [<c0185294>] (tick_nohz_idle_enter+0x48/0x80)
[   60.947569]  r9:c08024f8 r8:c05b8b6c r7:c081e2d6 r6:c05ce0b8 r5:c0802494 r4:c0734e38
[   60.955370] [<c018524c>] (tick_nohz_idle_enter) from [<c0155e58>] (cpu_startup_entry+0x58/0x18c)
[   60.964198]  r5:c0802494 r4:df45c000
[   60.967796] [<c0155e00>] (cpu_startup_entry) from [<c010dc14>] (secondary_start_kernel+0x158/0x164)
[   60.976885]  r7:c081e2d6 r4:c080b530
[   60.980485] [<c010dabc>] (secondary_start_kernel) from [<c04a9208>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
[   60.990273]  r5:c0802494 r4:00000001
[   60.993867] Code: e89dabf0 e14b24d4 e1a00004 ebffff22 (e1c821d0) 
[   60.999991] ---[ end trace b2639488439a8390 ]---
[   61.004631] Kernel panic - not syncing: Attempted to kill the idle task!
[   61.011368] CPU0: stopping
[   61.014087] CPU: 0 PID: 10 Comm: migration/0 Tainted: G      D W       4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
[   61.025448] Hardware name: Sigma Tango DT
[   61.029471] Backtrace: 
[   61.031936] [<c010b974>] (dump_backtrace) from [<c010bb70>] (show_stack+0x18/0x1c)
[   61.039542]  r7:20000193 r6:c080eb04 r5:00000000 r4:c080eb04
[   61.045246] [<c010bb58>] (show_stack) from [<c02eb084>] (dump_stack+0x80/0x94)
[   61.052507] [<c02eb004>] (dump_stack) from [<c010e034>] (handle_IPI+0x1a0/0x1b4)
[   61.059936]  r7:00000000 r6:00000004 r5:00000000 r4:c0735428
[   61.065635] [<c010de94>] (handle_IPI) from [<c01014ec>] (gic_handle_irq+0x90/0x94)
[   61.073240]  r9:e0803100 r8:e0802100 r7:df459e78 r6:e080210c r5:c080277c r4:c080ed20
[   61.081038] [<c010145c>] (gic_handle_irq) from [<c010c694>] (__irq_svc+0x54/0x90)
[   61.088556] Exception stack(0xdf459e78 to 0xdf459ec0)
[   61.093629] 9e60:                                                       00000000 c05bfe50
[   61.101849] 9e80: 00000000 00000001 dee37d54 00000001 dee37d40 20000013 00000000 dfbdbeec
[   61.110069] 9ea0: dee37ce8 df459eec df459eb8 df459ec8 c030305c c01910b8 60000013 ffffffff
[   61.118285]  r9:dfbdbeec r8:00000000 r7:df459eac r6:ffffffff r5:60000013 r4:c01910b8
[   61.126086] [<c0191008>] (multi_cpu_stop) from [<c0191304>] (cpu_stopper_thread+0xa8/0x120)
[   61.134477]  r9:dfbdbeec r8:df458000 r7:dee37d40 r6:c0191008 r5:dfbdbee4 r4:dfbdbee0
[   61.142274] [<c019125c>] (cpu_stopper_thread) from [<c013b500>] (smpboot_thread_fn+0x164/0x288)
[   61.151014]  r10:ffffe000 r9:c080a9bc r8:00000000 r7:00000001 r6:00000000 r5:df41a680
[   61.158894]  r4:df458000
[   61.161440] [<c013b39c>] (smpboot_thread_fn) from [<c0138434>] (kthread+0xe4/0xfc)
[   61.169045]  r10:00000000 r9:00000000 r8:00000000 r7:c013b39c r6:df41a680 r5:df41a500
[   61.176927]  r4:00000000 r3:df44e080
[   61.180523] [<c0138350>] (kthread) from [<c0107c18>] (ret_from_fork+0x14/0x3c)
[   61.187778]  r7:00000000 r6:00000000 r5:c0138350 r4:df41a500
[   61.193475] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!

