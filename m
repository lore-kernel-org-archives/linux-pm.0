From: Eduardo Valentin <eduval@amazon.com>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Date: Mon, 30 Jul 2018 09:44:17 -0700
Message-ID: <20180730164417.GE15414@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180726155656.14873-1-eduval@amazon.com>
 <CAJZ5v0gFQebGMpS0jzJOi7Ft+C7JTTKyiKgDhNj39BrCuQdH1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gFQebGMpS0jzJOi7Ft+C7JTTKyiKgDhNj39BrCuQdH1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Eduardo Valentin <eduval@amazon.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Rajvi Jingar <rajvi.jingar@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 30, 2018 at 09:15:48AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 26, 2018 at 5:56 PM, Eduardo Valentin <eduval@amazon.com> wrote:
> > System instability are seen during resume from hibernation when system
> > is under heavy CPU load. This is due to the lack of update of sched
> > clock data,
> 
> Isn't that the actual bug?
> 
> > and the scheduler would then think that heavy CPU hog
> > tasks need more time in CPU, causing the system to freeze
> > during the unfreezing of tasks. For example, threaded irqs,
> > and kernel processes servicing network interface may be delayed
> > for several tens of seconds, causing the system to be unreachable.
> >
> > Situation like this can be reported by using lockup detectors
> > such as workqueue lockup detectors:
> >
> > [root@ip-172-31-67-114 ec2-user]# echo disk > /sys/power/state
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
> >  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!
> >
> > The fix for this situation is to mark the sched clock as unstable
> > as early as possible in the resume path, leaving it unstable
> > for the duration of the resume process.
> 
> I would rather call it a workaround.

ok.

> 
> > This will force the
> > scheduler to attempt to align the sched clock across CPUs using
> > the delta with time of day, updating sched clock data. In a post
> > hibernation event, we can then mark the sched clock as stable
> > again, avoiding unnecessary syncs with time of day on systems
> > in which TSC is reliable.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Eduardo Valentin <eduval@amazon.com>
> > Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> > Cc: Rajvi Jingar <rajvi.jingar@intel.com>
> > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >
> > Hey,
> >
> > No changes from first attempt, no pressure on resending. The RESEND
> > tag is just because I missed linux-pm in the first attempt.
> >
> > BR,
> >
> >  arch/x86/kernel/tsc.c       | 29 +++++++++++++++++++++++++++++
> >  include/linux/sched/clock.h |  5 +++++
> >  kernel/sched/clock.c        |  4 ++--
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 8ea117f8142e..f197c9742fef 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/timex.h>
> >  #include <linux/static_key.h>
> > +#include <linux/suspend.h>
> >
> >  #include <asm/hpet.h>
> >  #include <asm/timer.h>
> > @@ -1377,3 +1378,31 @@ unsigned long calibrate_delay_is_known(void)
> >         return 0;
> >  }
> >  #endif
> > +
> > +static int tsc_pm_notifier(struct notifier_block *notifier,
> > +                          unsigned long pm_event, void *unused)
> > +{
> > +       switch (pm_event) {
> > +       case PM_HIBERNATION_PREPARE:
> > +               clear_sched_clock_stable();
> > +               break;
> 
> This is too early IMO.  This happens before hibernation starts, even
> before the image is created.

Yeah, I think, as long as it is marked, it should be fine.

> 
> > +       case PM_POST_HIBERNATION:
> > +               /* Set back to the default */
> > +               if (!check_tsc_unstable())
> > +                       set_sched_clock_stable();
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +};
> 
> If anything like this is the way to go, which honestly I doubt, I
> would prefer it to be done in hibernate() in the !in_suspend case.
> 

The problem is more in the unfreeze of tasks..

> But why does it only affect hibernation?  Do we do something extra for
> system-wide suspend/resume that is not done for hibernation?

I don't think we do anything special in hibernation per si. 
Only thing is the unfreezing of tasks seams to get confused when 
CPU hog tasks are present. 
> 

-- 
All the best,
Eduardo Valentin
