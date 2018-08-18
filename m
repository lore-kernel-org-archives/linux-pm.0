From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
Date: Sat, 18 Aug 2018 23:57:00 +0200
Message-ID: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan> <20180817141252.GA12426@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817141252.GA12426@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 17, 2018 at 4:12 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Fri, Aug 17, 2018 at 11:32:07AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, August 16, 2018 3:27:24 PM CEST Frederic Weisbecker wrote:
> > > On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > If the tick has been stopped already, but the governor has not asked to
> > > > stop it (which it can do sometimes), the idle loop should invoke
> > > > tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> > > > of this case properly.
> > > >
> > > > Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  kernel/sched/idle.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Index: linux-pm/kernel/sched/idle.c
> > > > ===================================================================
> > > > --- linux-pm.orig/kernel/sched/idle.c
> > > > +++ linux-pm/kernel/sched/idle.c
> > > > @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
> > > >            */
> > > >           next_state = cpuidle_select(drv, dev, &stop_tick);
> > > >
> > > > -         if (stop_tick)
> > > > +         if (stop_tick || tick_nohz_tick_stopped())
> > > >                   tick_nohz_idle_stop_tick();
> > > >           else
> > > >                   tick_nohz_idle_retain_tick();
> > >
> > > So what if tick_nohz_idle_stop_tick() sees no timer to schedule and
> > > cancels it, we may remain idle in a shallow state for a long while?
> >
> > Yes, but the governor is expected to avoid using shallow states when the
> > tick is stopped already.
>
> So what kind of sleep do we enter to when an idle tick fires and we go
> back to idle? Is it always deep?

No, it isn't.

The state to select must always fit the time till the closest timer
event and that may be shorter than the tick period.

If there's a non-tick timer to wake the CPU up, we don't need to worry
about restarting the tick, though. :-)

> I believe that ts->tick_stopped == 1 shouldn't be too relevant for the governor.
> We can definetly have scenarios where the idle tick is stopped for a long while,
> then it fires and schedules the next timer at NOW() + TICK_NSEC (as if the tick
> had been restarted). This can even repeat that way for some time, because
> ts->tick_stopped == 1 only implies that the tick has been stopped once since
> we entered the idle loop. After that we may well have a periodic tick behaviour.
> In that case we probably don't want deep idle state. Especially if we have:
>
>               idle_loop() {
>                   tick_stop (scheduled several seconds forward)
>                   deep_idle_sleep()
>                   //several seconds later
>                   tick()
>                   tick_stop (scheduled TICK_NSEC forward)
>                   deep_idle_sleep()
>                   tick() {
>                       set_need_resched()
>                   }
>                   exit idle loop
>               }
>
> Here the last deep idle state isn't necessary.

No, it isn't.

However, that is not relevant for the question of whether or not to
restart the tick before entering the idle state IMO (see the
considerations below).

> >
> > > Otherwise we can have something like this:
> > >
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index da9455a..408c985 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> > >  static void tick_nohz_retain_tick(struct tick_sched *ts)
> > >  {
> > >     ts->timer_expires_base = 0;
> > > +
> > > +   if (ts->tick_stopped)
> > > +           tick_nohz_restart(ts, ktime_get());
> > >  }
> > >
> > >  #ifdef CONFIG_NO_HZ_FULL
> > >
> >
> > We could do that, but my concern with that approach is that we may end up
> > stopping and starting the tick back and forth without exiting the loop
> > in do_idle() just because somebody uses a periodic timer behind our
> > back and the governor gets confused.
> >
> > Besides, that would be a change in behavior, while the $subject patch
> > simply fixes a mistake in the original design.
>
> Ok, let's take the safe approach for now as this is a fix and it should even be
> routed to stable.

Right.  I'll queue up this patch, then.

> But then in the longer term, perhaps cpuidle_select() should think that
> through.

So I have given more consideration to this and my conclusion is that
restarting the tick between cpuidle_select() and call_cpuidle() is a
bad idea.

First off, if need_resched() is "false", the primary reason for
running the tick on the given CPU is not there, so it only might be
useful as a "backup" timer to wake up the CPU from an inadequate idle
state.

Now, in general, there are two reasons for the idle governor (whatever
it is) to select an idle state with a target residency below the tick
period length.  The first reason is when the governor knows that the
closest timer event is going to occur in this time frame, but in that
case (as stated above), it is not necessary to worry about the tick,
because the other timer will trigger soon enough anyway.  The second
reason is when the governor predicts a wakeup which is not by a timer
in this time frame and it is quite arguable what the governor should
do then.  IMO it at least is not unreasonable to throw the prediction
away and still go for the closest timer event in that case (which is
the current approach).

There's more, though.  Restarting the tick between cpuidle_select()
and call_cpuidle() might introduce quite a bit of latency into that
point and that would mess up with the idle state selection (e.g.
selecting a very shallow idle state might not make a lot of sense if
that latency was high enough, because the expected wakeup might very
well take place when the tick was being restarted), so it should
rather be avoided IMO.

Cheers,
Rafael
