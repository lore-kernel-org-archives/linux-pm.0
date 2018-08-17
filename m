From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
Date: Fri, 17 Aug 2018 11:32:07 +0200
Message-ID: <10817203.8q7neLTJVD@aspire.rjw.lan>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816132723.GA6010@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 16, 2018 3:27:24 PM CEST Frederic Weisbecker wrote:
> On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the tick has been stopped already, but the governor has not asked to
> > stop it (which it can do sometimes), the idle loop should invoke
> > tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> > of this case properly.
> > 
> > Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/idle.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
> >  		 */
> >  		next_state = cpuidle_select(drv, dev, &stop_tick);
> >  
> > -		if (stop_tick)
> > +		if (stop_tick || tick_nohz_tick_stopped())
> >  			tick_nohz_idle_stop_tick();
> >  		else
> >  			tick_nohz_idle_retain_tick();
> 
> So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> cancels it, we may remain idle in a shallow state for a long while?

Yes, but the governor is expected to avoid using shallow states when the
tick is stopped already.

> Otherwise we can have something like this:
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index da9455a..408c985 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  static void tick_nohz_retain_tick(struct tick_sched *ts)
>  {
>  	ts->timer_expires_base = 0;
> +
> +	if (ts->tick_stopped)
> +		tick_nohz_restart(ts, ktime_get());
>  }
>  
>  #ifdef CONFIG_NO_HZ_FULL
> 

We could do that, but my concern with that approach is that we may end up
stopping and starting the tick back and forth without exiting the loop
in do_idle() just because somebody uses a periodic timer behind our
back and the governor gets confused.

Besides, that would be a change in behavior, while the $subject patch
simply fixes a mistake in the original design.

Cheers,
Rafael
