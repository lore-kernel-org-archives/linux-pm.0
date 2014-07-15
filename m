From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: PM freeze does not work on AT91
Date: Tue, 15 Jul 2014 19:35:55 +0800
Message-ID: <1405424155.28592.43.camel@rzhang1-toshiba>
References: <3082229.H5zoEYePBM@ws-stein>
	 <1405416682.28592.40.camel@rzhang1-toshiba> <2272604.GR04jGpG1f@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34284 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758654AbaGOLgj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Jul 2014 07:36:39 -0400
In-Reply-To: <2272604.GR04jGpG1f@ws-stein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Tue, 2014-07-15 at 12:00 +0200, Alexander Stein wrote:
> On Tuesday 15 July 2014 17:31:22, Zhang Rui wrote:
> > On Tue, 2014-07-15 at 10:07 +0200, Alexander Stein wrote:
> > > Hi,
> > > 
> > > I tried using the PM features in linux on my at91sam9263 custom board. Using 'echo mem > state' and 'echo standby > mem' works in general. But when using 'echo freeze > state' I get the following oops.
> > > 
> > > sh-3.2:/sys/power# echo freeze > state
> > > [   22.559000] PM: Syncing filesystems ... done.
> > > [   23.073000] Freezing user space processes ... (elapsed 0.001 seconds) done.
> > > [   23.092000] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > > [   23.101000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > > [   23.109000] pgd = c283c000
> > > [   23.112000] [00000000] *pgd=23384831, *pte=00000000, *ppte=00000000
> > > [   23.118000] Internal error: Oops: 17 [#1] PREEMPT ARM
> > > [   23.118000] Modules linked in:
> > > [   23.118000] CPU: 0 PID: 106 Comm: sh Not tainted 3.16.0-rc5+ #3
> > > [   23.118000] task: c3369c00 ti: c33e0000 task.ti: c33e0000
> > > [   23.118000] PC is at suspend_devices_and_enter+0x6c/0x32c
> > > [   23.118000] LR is at pm_suspend+0x160/0x27c
> > > [   23.118000] pc : [<c004111c>]    lr : [<c004153c>]    psr: 60000013
> > > [   23.118000] sp : c33e1eb8  ip : 000008e0  fp : 00000000
> > > [   23.118000] r10: c280480c  r9 : c2804800  r8 : 00000007
> > > [   23.118000] r7 : c05527f8  r6 : 00000001  r5 : 00000001  r4 : c056ca00
> > > [   23.118000] r3 : 00000000  r2 : 01ffff3f  r1 : 60000013  r0 : 00000001
> > > [   23.118000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > > [   23.118000] Control: 0005317f  Table: 2283c000  DAC: 00000015
> > > [   23.118000] Process sh (pid: 106, stack limit = 0xc33e01c0)
> > > [   23.118000] Stack: (0xc33e1eb8 to 0xc33e2000)
> > > [   23.118000] 1ea0:                                                       00000000 c0391454
> > > [   23.118000] 1ec0: c049e549 c33e1edc 60000013 c33e1edc 00000000 c056ca00 00000000 00000001
> > > [   23.118000] 1ee0: c05527f8 00000007 c2804800 c004153c c055e2bc c3064000 00000007 c282a0c0
> > > [   23.118000] 1f00: c33e1f80 c0040304 c3064000 c282a0c0 c282a0c0 c01abd94 00000007 c00f0e54
> > > [   23.118000] 1f20: c00f0e18 00000000 00000000 c00f0050 00000000 00000000 c33c93c0 b6fa6000
> > > [   23.118000] 1f40: c33e1f80 00000007 00000007 b6fa6000 00000000 c009a19c c33c93c0 b6fa6000
> > > [   23.118000] 1f60: 00000007 00000000 00000000 c33c93c0 c33c93c0 00000007 b6fa6000 c009a70c
> > > [   23.118000] 1f80: 00000000 00000000 00000007 00000007 b6fa6000 b6f76b38 00000004 c0009764
> > > [   23.118000] 1fa0: c33e0000 c0009600 00000007 b6fa6000 00000001 b6fa6000 00000007 00000000
> > > [   23.118000] 1fc0: 00000007 b6fa6000 b6f76b38 00000004 00000007 b6fa6000 00000007 00000000
> > > [   23.118000] 1fe0: 00000000 be83ba9c b6eaeadc b6f0317c 60000010 00000001 00000000 00000000
> > > [   23.118000] [<c004111c>] (suspend_devices_and_enter) from [<c004153c>] (pm_suspend+0x160/0x27c)
> > > [   23.118000] [<c004153c>] (pm_suspend) from [<c0040304>] (state_store+0x40/0x68)
> > > [   23.118000] [<c0040304>] (state_store) from [<c01abd94>] (kobj_attr_store+0x14/0x20)
> > > [   23.118000] [<c01abd94>] (kobj_attr_store) from [<c00f0e54>] (sysfs_kf_write+0x3c/0x48)
> > > [   23.118000] [<c00f0e54>] (sysfs_kf_write) from [<c00f0050>] (kernfs_fop_write+0x100/0x158)
> > > [   23.118000] [<c00f0050>] (kernfs_fop_write) from [<c009a19c>] (vfs_write+0xb4/0x188)
> > > [   23.118000] [<c009a19c>] (vfs_write) from [<c009a70c>] (SyS_write+0x3c/0x7c)
> > > [   23.118000] [<c009a70c>] (SyS_write) from [<c0009600>] (ret_fast_syscall+0x0/0x2c)
> > > [   23.118000] Code: eafffff3 1afffff2 e59f32ac e5933008 (e5933000)
> > > [   23.358000] ---[ end trace 9206ef60cdd758d9 ]---
> > > 
> > > The systems hangs here now.
> > 
> > can you please check if the patch below fixes the problem for you?
> > 
> > thanks,
> > rui
> > 
> > From 0617bbe7890aec961828904659cf207fd817a5cf Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Tue, 15 Jul 2014 17:20:16 +0800
> > Subject: [PATCH] PM: fix a NULL pointer dereference issue
> > 
> > This patch fixes a NULL pointer dereference issue introduced by
> > commit 1f0b63866fc1be700260547be8edf8e6f0af37f2.
> > 
> > Reference: http://marc.info/?l=linux-pm&m=140541182017443&w=2
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  kernel/power/suspend.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 4dd8822..ed35a47 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -306,7 +306,7 @@ int suspend_devices_and_enter(suspend_state_t state)
> >  		error = suspend_ops->begin(state);
> >  		if (error)
> >  			goto Close;
> > -	} else if (state == PM_SUSPEND_FREEZE && freeze_ops->begin) {
> > +	} else if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->begin) {
> >  		error = freeze_ops->begin();
> >  		if (error)
> >  			goto Close;
> > @@ -335,7 +335,7 @@ int suspend_devices_and_enter(suspend_state_t state)
> >   Close:
> >  	if (need_suspend_ops(state) && suspend_ops->end)
> >  		suspend_ops->end();
> > -	else if (state == PM_SUSPEND_FREEZE && freeze_ops->end)
> > +	else if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->end)
> >  		freeze_ops->end();
> >  
> >  	return error;
> > 
> 
> Oh, I forgot to add my testing patch which is the same as yours. Nevertheless I've taken your patch and tried again:
> $ echo freeze > /sys/power/state
> [   20.920000] PM: Syncing filesystems ... done.
> [   21.391000] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   21.405000] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   21.414000] Suspending console(s) (use no_console_suspend to debug)
> 
> The baord is freezed now here. It doesn't wakeup by GPIO keys, etc.
> 
This is another problem. In order to be able to wakeup the system from
freeze state, you need to set IRQF_NO_SUSPEND for the interrupt used by
the GPIO keys, something like this patch does
https://lkml.org/lkml/2014/6/18/784

thanks,
rui

> Regards,
> Alexander
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


