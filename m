From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 15:32:43 -0300
Message-ID: <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34595 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbcETSdD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 14:33:03 -0400
Received: by mail-io0-f181.google.com with SMTP id 190so155595128iow.1
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 11:33:02 -0700 (PDT)
In-Reply-To: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>

On Fri, May 20, 2016 at 3:05 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Rafael,
>
> Running the 'reboot' command works fine on a 4.5 kernel running on a
> mx6ul platform (ARM single core SoC), but it crashes on 4.6.
>
> Running bisect I got 9be4fd2c7723a3057b0b39676 ("cpufreq: governor:
> Replace timers with utilization update callbacks") as the first bad
> commit.
>
> Below is the output crash log.
>
> Not sure if this issue is related to the problem reported by Guenter here:
> http://lkml.iu.edu/hypermail/linux/kernel/1602.1/06075.html
>
> Any ideas?

If I rebuilt a kernel with SMP=n then the reboot command works as expected.

>
> Thanks,
>
> Fabio Estevam
>
>
> [ 3857.373588] INFO: rcu_sched detected stalls on CPUs/tasks:
> [ 3857.379155]  (detected by 0, t=2602 jiffies, g=1880, c=1879, q=29)
> [ 3857.385406] All QSes seen, last rcu_sched kthread activity 2602
> (355736-353134), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [ 3857.396562] init            R running      0   864      1 0x00000002
> [ 3857.402999] Backtrace:
> [ 3857.405532] [<c010b6e8>] (dump_backtrace) from [<c010b884>]
> (show_stack+0x18/0x1c)
> [ 3857.413125]  r6:c0d6c6d6 r5:00000001 r4:ddd9c800 r3:00000000
> [ 3857.418941] [<c010b86c>] (show_stack) from [<c014fc3c>]
> (sched_show_task+0x124/0x234)
> [ 3857.426820] [<c014fb18>] (sched_show_task) from [<c0185e24>]
> (rcu_check_callbacks+0x844/0x894)
> [ 3857.435452]  r6:c0c76b40 r5:c0d14b80 r4:debd0b40
> [ 3857.440189] [<c01855e0>] (rcu_check_callbacks) from [<c018884c>]
> (update_process_times+0x38/0x64)
> [ 3857.449081]  r10:c0d21e1c r9:debcdd10 r8:c019a230 r7:dde7bd50
> r6:debce048 r5:00000000
> [ 3857.457067]  r4:ddd9c800
> [ 3857.459665] [<c0188814>] (update_process_times) from [<c019a174>]
> (tick_sched_handle+0x50/0x54)
> [ 3857.468386]  r5:00000382 r4:1c92d15d
> [ 3857.472048] [<c019a124>] (tick_sched_handle) from [<c019a290>]
> (tick_sched_timer+0x60/0xa8)
> [ 3857.480443] [<c019a230>] (tick_sched_timer) from [<c018915c>]
> (__hrtimer_run_queues+0xc0/0x1c8)
> [ 3857.489162]  r7:debcdd80 r6:debcdd00 r5:debcdd8c r4:debce048
> [ 3857.494969] [<c018909c>] (__hrtimer_run_queues) from [<c018998c>]
> (hrtimer_interrupt+0xc8/0x22c)
> [ 3857.503774]  r10:debcddd8 r9:debcddb8 r8:debcddf8 r7:debcdd00
> r6:debcdd40 r5:00000003
> [ 3857.511758]  r4:ffffffff
> [ 3857.514354] [<c01898c4>] (hrtimer_interrupt) from [<c067d994>]
> (mxc_timer_interrupt+0x3c/0x44)
> [ 3857.522985]  r10:c0d6c710 r9:e0805000 r8:de41d000 r7:00000010
> r6:00000000 r5:00000000
> [ 3857.530969]  r4:de402440
> [ 3857.533568] [<c067d958>] (mxc_timer_interrupt) from [<c0177acc>]
> (handle_irq_event_percpu+0x64/0x168)
> [ 3857.542809]  r4:de402500 r3:c067d958
> [ 3857.546482] [<c0177a68>] (handle_irq_event_percpu) from
> [<c0177c10>] (handle_irq_event+0x40/0x64)
> [ 3857.555374]  r10:de406000 r9:e0805000 r8:00000001 r7:00000000
> r6:c0d10330 r5:de41d060
> [ 3857.563358]  r4:de41d000
> [ 3857.565956] [<c0177bd0>] (handle_irq_event) from [<c017b120>]
> (handle_fasteoi_irq+0xd4/0x1ac)
> [ 3857.574502]  r6:c0d10330 r5:de41d060 r4:de41d000 r3:00000000
> [ 3857.580305] [<c017b04c>] (handle_fasteoi_irq) from [<c017726c>]
> (generic_handle_irq+0x20/0x30)
> [ 3857.588937]  r7:00000000 r6:c0c746ec r5:c0d02b10 r4:00000010
> [ 3857.594743] [<c017724c>] (generic_handle_irq) from [<c01773b0>]
> (__handle_domain_irq+0x6c/0xe4)
> [ 3857.603485] [<c0177344>] (__handle_domain_irq) from [<c01015d8>]
> (gic_handle_irq+0x4c/0x9c)
> [ 3857.611857]  r10:000003eb r8:c0d22000 r7:c0d02c58 r6:dde7bd50
> r5:e080400c r4:e0804000
> [ 3857.619858] [<c010158c>] (gic_handle_irq) from [<c010c4b8>]
> (__irq_svc+0x58/0x78)
> [ 3857.627367] Exception stack(0xdde7bd50 to 0xdde7bd98)
> [ 3857.632450] bd40:                                     ddce911c
> 00000001 00000000 00000003
> [ 3857.640664] bd60: ddce911c c0d02a48 ddcea000 ddce90c0 c0108044
> dde7a000 00000000 dde7bdb4
> [ 3857.648875] bd80: dde7bdb8 dde7bda0 c064ad44 c01b247c 20000013 ffffffff
> [ 3857.655509]  r10:00000000 r9:dde7a000 r8:c0108044 r7:dde7bd84
> r6:ffffffff r5:20000013
> [ 3857.663494]  r4:c01b247c r3:ddd9c800
> [ 3857.667167] [<c01b2448>] (irq_work_sync) from [<c064ad44>]
> (cpufreq_governor_dbs+0x170/0x580)
> [ 3857.675713]  r4:00000004 r3:00000001
> [ 3857.679384] [<c064abd4>] (cpufreq_governor_dbs) from [<c06480e4>]
> (cpufreq_governor+0x64/0x120)
> [ 3857.688103]  r10:00000000 r9:dde7a000 r8:c0108044 r7:c1556f80
> r6:00000002 r5:ddcea000
> [ 3857.696088]  r4:c0d4c5dc
> [ 3857.698684] [<c0648080>] (cpufreq_governor) from [<c06493c4>]
> (cpufreq_suspend+0x70/0x128)
> [ 3857.706967]  r6:c0d4c328 r5:ddcea0dc r4:ddcea000 r3:ddd9c800
> [ 3857.712777] [<c0649354>] (cpufreq_suspend) from [<c04da71c>]
> (syscore_shutdown+0x4c/0x80)
> [ 3857.720976]  r8:c0108044 r7:00000000 r6:c0d6e020 r5:c0d315a8
> r4:c0d4c2fc r3:00000000
> [ 3857.728895] [<c04da6d0>] (syscore_shutdown) from [<c0147aa8>]
> (kernel_restart+0x1c/0x58)
> [ 3857.737007]  r6:c0d13074 r5:4321fedc r4:00000000 r3:de434900
> [ 3857.742805] [<c0147a8c>] (kernel_restart) from [<c0147cc4>]
> (SyS_reboot+0x18c/0x1e4)
> [ 3857.750569]  r4:01234567 r3:01234567
> [ 3857.754234] [<c0147b38>] (SyS_reboot) from [<c0107ea0>]
> (ret_fast_syscall+0x0/0x1c)
> [ 3857.761910]  r7:00000058 r6:00000000 r5:00000000 r4:00000000
> [ 3857.767707] rcu_sched kthread starved for 2602 jiffies! g1880 c1879
> f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
> [ 3857.777123] rcu_sched       R running      0     7      2 0x00000000
> [ 3857.783558] Backtrace:
> [ 3857.786076] [<c08f488c>] (__schedule) from [<c08f50d8>] (schedule+0x3c/0xa0)
> [ 3857.793148]  r10:00000001 r9:00000003 r8:c0d02100 r7:0005636f
> r6:debcd4c0 r5:debcd4c0
> [ 3857.801133]  r4:de487e9c
> [ 3857.803728] [<c08f509c>] (schedule) from [<c08f941c>]
> (schedule_timeout+0x138/0x1cc)
> [ 3857.811509] [<c08f92e4>] (schedule_timeout) from [<c0184bf0>]
> (rcu_gp_kthread+0x3b0/0x894)
> [ 3857.819794]  r8:00000000 r7:000002b8 r6:00000001 r5:c0d14e10 r4:c0d14b80
> [ 3857.826667] [<c0184840>] (rcu_gp_kthread) from [<c0144e7c>]
> (kthread+0xd8/0xf4)
> [ 3857.833997]  r7:c0184840
> [ 3857.836593] [<c0144da4>] (kthread) from [<c0107f30>]
> (ret_from_fork+0x14/0x24)
> [ 3857.843836]  r7:00000000 r6:00000000 r5:c0144da4 r4:de435040
