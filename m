From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Date: Fri, 14 Sep 2018 10:46:35 +0200
Message-ID: <1831106.CYv9dyYV15@aspire.rjw.lan>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan> <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Friday, September 14, 2018 10:28:44 AM CEST Mika Penttilä wrote:
> Hi!
> 
> 
> On 09/14/2018 09:59 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There is a difference in behavior between suspend-to-idle and
> > suspend-to-RAM in the timekeeping handling that leads to functional
> > issues.  Namely, every iteration of the loop in s2idle_loop()
> > increases the monotinic clock somewhat, even if timekeeping_suspend()
> > and timekeeping_resume() are invoked from s2idle_enter(), and if
> > many of them are carried out in a row, the monotonic clock can grow
> > significantly while the system is regarded as suspended, which
> > doesn't happen during suspend-to-RAM and so it is unexpected and
> > leads to confusion and misbehavior in user space (similar to what
> > ensued when we tried to combine the boottime and monotonic clocks).
> > 
> > To avoid that, count all iterations of the loop in s2idle_loop()
> > as "sleep time" and adjust the clock for that on exit from
> > suspend-to-idle.
> > 
> > [That also covers systems on which timekeeping is not suspended
> >  by by s2idle_enter().]
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > This is a replacement for https://patchwork.kernel.org/patch/10599209/
> > 
> > I decided to count the entire loop in s2idle_loop() as "sleep time" as the
> > patch is then simpler and it also covers systems where timekeeping is not
> > suspended in the final step of suspend-to-idle.
> > 
> > I dropped the "Fixes:" tag, because the monotonic clock delta problem
> > has been present on the latter since the very introduction of "freeze"
> > (as suspend-to-idle was referred to previously) and so this doesn't fix
> > any particular later commits.
> > 
> > ---
> >  kernel/power/suspend.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > Index: linux-pm/kernel/power/suspend.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/suspend.c
> > +++ linux-pm/kernel/power/suspend.c
> > @@ -109,8 +109,12 @@ static void s2idle_enter(void)
> >  
> >  static void s2idle_loop(void)
> >  {
> > +	ktime_t start, delta;
> > +
> >  	pm_pr_dbg("suspend-to-idle\n");
> >  
> > +	start = ktime_get();
> > +
> >  	for (;;) {
> >  		int error;
> >  
> > @@ -150,6 +154,20 @@ static void s2idle_loop(void)
> >  		pm_wakeup_clear(false);
> >  	}
> >  
> > +	/*
> > +	 * If the monotonic clock difference between the start of the loop and
> > +	 * this point is too large, user space may get confused about whether or
> > +	 * not the system has been suspended and tasks may get killed by
> > +	 * watchdogs etc., so count the loop as "sleep time" to compensate for
> > +	 * that.
> > +	 */
> > +	delta = ktime_sub(ktime_get(), start);
> > +	if (ktime_to_ns(delta) > 0) {
> > +		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> > +
> > +		timekeeping_inject_sleeptime64(&timespec64_delta);
> > +	}
> 
> But doesn't injecting sleep time here make monotonic clock too large by the amount of sleeptime? 
> tick_freeze() / tick_unfreeze() already injects the sleeptime (otherwise delta would be 0).

No, it doesn't.

The delta here is the extra time taken by the loop which hasn't been counted
as sleep time yet.

Thanks,
Rafael
