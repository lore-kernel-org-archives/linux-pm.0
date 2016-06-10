From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Linux panics when suspend cannot offline the secondary cores
Date: Fri, 10 Jun 2016 23:35:01 +0200
Message-ID: <2026483.61HqCp9Eli@vostro.rjw.lan>
References: <575ADFAC.4090009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63330 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753286AbcFJVa7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 17:30:59 -0400
In-Reply-To: <575ADFAC.4090009@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Frias <sf84@laposte.net>

On Friday, June 10, 2016 05:41:32 PM Mason wrote:
> Hello,
> 
> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
> unhappy when the suspend framework fails to offline secondary cores.
> 
> Is this expected/by design, or could it fail more gracefully?
> (It could also be something missing in my platform's code.)

This looks like a CPU offline bug to me which is more general than just
system suspend.


> # echo mem > /sys/power/state 
> [   30.722352] PM: Syncing filesystems ... done.
> [   30.727146] PM: Preparing system for sleep (mem)
> [   30.736927] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   30.745519] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   30.754098] PM: Suspending system (mem)
> [   30.760934] PM: suspend of devices complete after 2.104 msecs
> [   30.767638] PM: late suspend of devices complete after 0.883 msecs
> [   30.774529] PM: noirq suspend of devices complete after 0.653 msecs
> [   30.780846] Disabling non-boot CPUs ...
> [   30.795697] CPU1: shutdown
> [   30.795701] IN tango_cpu_die
> [   30.795709] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
> [   30.795730] BUG: scheduling while atomic: swapper/1/0/0x00000002
> [   30.795735] Modules linked in:
> [   30.795756] Preemption disabled at:[<c04a5898>] schedule_preempt_disabled+0x20/0x24
> [   30.795757] 
> [   30.795766] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
> [   30.795768] Hardware name: Sigma Tango DT
> [   30.795773] Backtrace: 
> [   30.795790] [<c010b974>] (dump_backtrace) from [<c010bb70>] (show_stack+0x18/0x1c)
> [   30.795797]  r7:60000013 r6:c080eb04 r5:00000000 r4:c080eb04
> [   30.795811] [<c010bb58>] (show_stack) from [<c02eb084>] (dump_stack+0x80/0x94)
> [   30.795820] [<c02eb004>] (dump_stack) from [<c013cb34>] (__schedule_bug+0x6c/0xb8)
> [   30.795827]  r7:c0802638 r6:e745f6c0 r5:e7ae8ec0 r4:e7460000
> [   30.795833] [<c013cac8>] (__schedule_bug) from [<c04a522c>] (__schedule+0x434/0x530)
> [   30.795837]  r5:e7ae8ec0 r4:c0736ec0
> [   30.795842] [<c04a4df8>] (__schedule) from [<c04a5378>] (schedule+0x50/0xb0)
> [   30.795852]  r10:00000000 r9:c08024f8 r8:c05b8b6c r7:c081e2d6 r6:c05ce0b8 r5:c0802494
> [   30.795855]  r4:e7460000
> [   30.795861] [<c04a5328>] (schedule) from [<c04a5890>] (schedule_preempt_disabled+0x18/0x24)
> [   30.795865]  r5:c0802494 r4:e7460000
> [   30.795876] [<c04a5878>] (schedule_preempt_disabled) from [<c0155f0c>] (cpu_startup_entry+0x10c/0x18c)
> [   30.795884] [<c0155e00>] (cpu_startup_entry) from [<c010dc14>] (secondary_start_kernel+0x158/0x164)
> [   30.795888]  r7:c081e2d6 r4:c080b530
> [   30.795898] [<c010dabc>] (secondary_start_kernel) from [<c04a9208>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
> [   30.795902]  r5:c0802494 r4:00000001
> [   30.952513] IN tango_cpu_kill
> [   30.955537] Unable to handle kernel NULL pointer dereference at virtual address 00000010
> [   30.963668] pgd = c0004000
> [   30.966382] [00000010] *pgd=00000000
> [   30.969976] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [   30.975312] Modules linked in:
> [   30.978379] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
> [   30.989478] Hardware name: Sigma Tango DT
> [   30.993503] task: e745f6c0 ti: e7460000 task.ti: e7460000
> [   30.998933] PC is at __tick_nohz_idle_enter+0x2d8/0x444
> [   31.004188] LR is at debug_smp_processor_id+0x20/0x24
> [   31.009262] pc : [<c0184d1c>]    lr : [<c030305c>]    psr: 60000093
> [   31.009262] sp : e7461f50  ip : e7461f20  fp : e7461fac
> [   31.020800] r10: 00000000  r9 : 00000000  r8 : 00000000
> [   31.026047] r7 : 00000000  r6 : 0032dcd5  r5 : 00000001  r4 : e7ae6e38
> [   31.032605] r3 : 00000000  r2 : 0032dcd5  r1 : 00000000  r0 : 0032dcd5
> [   31.039164] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   31.046420] Control: 10c5387d  Table: 8000404a  DAC: 00000051
> [   31.052192] Process swapper/1 (pid: 0, stack limit = 0xe7460210)
> [   31.058226] Stack: (0xe7461f50 to 0xe7462000)
> [   31.062602] 1f40:                                     c04a4fcc c013c8b0 00000001 00000000
> [   31.070821] 1f60: 35293313 00000007 34faa6c3 00000007 34f6563e 00000007 34faa6c3 00000007
> [   31.079041] 1f80: ffffffff 7fffffff c0734e38 c0802494 c05ce0b8 c081e2d6 c05b8b6c c08024f8
> [   31.087261] 1fa0: e7461fc4 e7461fb0 c0185294 c0184a50 e7460000 c0802494 e7461fdc e7461fc8
> [   31.095480] 1fc0: c0155e58 c0185258 c080b530 c081e2d6 e7461ff4 e7461fe0 c010dc14 c0155e0c
> [   31.103700] 1fe0: 00000001 c0802494 00000000 e7461ff8 c04a9208 c010dac8 454115f5 56b2e41b
> [   31.111916] Backtrace: 
> [   31.114376] [<c0184a44>] (__tick_nohz_idle_enter) from [<c0185294>] (tick_nohz_idle_enter+0x48/0x80)
> [   31.123553]  r9:c08024f8 r8:c05b8b6c r7:c081e2d6 r6:c05ce0b8 r5:c0802494 r4:c0734e38
> [   31.131353] [<c018524c>] (tick_nohz_idle_enter) from [<c0155e58>] (cpu_startup_entry+0x58/0x18c)
> [   31.140181]  r5:c0802494 r4:e7460000
> [   31.143778] [<c0155e00>] (cpu_startup_entry) from [<c010dc14>] (secondary_start_kernel+0x158/0x164)
> [   31.152868]  r7:c081e2d6 r4:c080b530
> [   31.156464] [<c010dabc>] (secondary_start_kernel) from [<c04a9208>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
> [   31.166253]  r5:c0802494 r4:00000001
> [   31.169848] Code: e89dabf0 e14b24d4 e1a00004 ebffff22 (e1c821d0) 
> [   31.175972] ---[ end trace 5e1e78cb2505c930 ]---
> [   31.180611] Kernel panic - not syncing: Attempted to kill the idle task!
> [   31.187346] CPU0: stopping
> [   31.190064] CPU: 0 PID: 10 Comm: migration/0 Tainted: G      D W       4.7.0-rc1-next-20160530-00002-g6c94ca0b0db1-dirty #117
> [   31.201426] Hardware name: Sigma Tango DT
> [   31.205449] Backtrace: 
> [   31.207911] [<c010b974>] (dump_backtrace) from [<c010bb70>] (show_stack+0x18/0x1c)
> [   31.215516]  r7:20000193 r6:c080eb04 r5:00000000 r4:c080eb04
> [   31.221218] [<c010bb58>] (show_stack) from [<c02eb084>] (dump_stack+0x80/0x94)
> [   31.228478] [<c02eb004>] (dump_stack) from [<c010e034>] (handle_IPI+0x1a0/0x1b4)
> [   31.235909]  r7:00000000 r6:00000004 r5:00000000 r4:c0735428
> [   31.241607] [<c010de94>] (handle_IPI) from [<c01014ec>] (gic_handle_irq+0x90/0x94)
> [   31.249212]  r9:e8803100 r8:e8802100 r7:e745de78 r6:e880210c r5:c080277c r4:c080ed20
> [   31.257008] [<c010145c>] (gic_handle_irq) from [<c010c694>] (__irq_svc+0x54/0x90)
> [   31.264527] Exception stack(0xe745de78 to 0xe745dec0)
> [   31.269600] de60:                                                       00000000 c05bfe50
> [   31.277820] de80: 00000000 00000001 e6e49cfc 00000001 e6e49ce8 20000013 00000000 e7ad9eec
> [   31.286039] dea0: e6e49c90 e745deec e745deb8 e745dec8 c030305c c01910b8 60000013 ffffffff
> [   31.294255]  r9:e7ad9eec r8:00000000 r7:e745deac r6:ffffffff r5:60000013 r4:c01910b8
> [   31.302057] [<c0191008>] (multi_cpu_stop) from [<c0191304>] (cpu_stopper_thread+0xa8/0x120)
> [   31.310448]  r9:e7ad9eec r8:e745c000 r7:e6e49ce8 r6:c0191008 r5:e7ad9ee4 r4:e7ad9ee0
> [   31.318245] [<c019125c>] (cpu_stopper_thread) from [<c013b500>] (smpboot_thread_fn+0x164/0x288)
> [   31.326985]  r10:ffffe000 r9:c080a9bc r8:00000000 r7:00000001 r6:00000000 r5:e7418680
> [   31.334866]  r4:e745c000
> [   31.337412] [<c013b39c>] (smpboot_thread_fn) from [<c0138434>] (kthread+0xe4/0xfc)
> [   31.345017]  r10:00000000 r9:00000000 r8:00000000 r7:c013b39c r6:e7418680 r5:e7418500
> [   31.352898]  r4:00000000 r3:e7452080
> [   31.356493] [<c0138350>] (kthread) from [<c0107c18>] (ret_from_fork+0x14/0x3c)
> [   31.363749]  r7:00000000 r6:00000000 r5:c0138350 r4:e7418500
> [   31.369447] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> --

