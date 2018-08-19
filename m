From: leo.yan@linaro.org
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Date: Sun, 19 Aug 2018 08:36:32 +0800
Message-ID: <20180819003632.GA11280@leoy-ThinkPad-X240s>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
 <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:

[...]

> > > > Otherwise we can have something like this:
> > > >
> > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > index da9455a..408c985 100644
> > > > --- a/kernel/time/tick-sched.c
> > > > +++ b/kernel/time/tick-sched.c
> > > > @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> > > >  static void tick_nohz_retain_tick(struct tick_sched *ts)
> > > >  {
> > > >     ts->timer_expires_base = 0;
> > > > +
> > > > +   if (ts->tick_stopped)
> > > > +           tick_nohz_restart(ts, ktime_get());
> > > >  }
> > > >
> > > >  #ifdef CONFIG_NO_HZ_FULL
> > > >
> > >
> > > We could do that, but my concern with that approach is that we may end up
> > > stopping and starting the tick back and forth without exiting the loop
> > > in do_idle() just because somebody uses a periodic timer behind our
> > > back and the governor gets confused.
> > >
> > > Besides, that would be a change in behavior, while the $subject patch
> > > simply fixes a mistake in the original design.
> >
> > Ok, let's take the safe approach for now as this is a fix and it should even be
> > routed to stable.
> 
> Right.  I'll queue up this patch, then.
> 
> > But then in the longer term, perhaps cpuidle_select() should think that
> > through.
> 
> So I have given more consideration to this and my conclusion is that
> restarting the tick between cpuidle_select() and call_cpuidle() is a
> bad idea.
> 
> First off, if need_resched() is "false", the primary reason for
> running the tick on the given CPU is not there, so it only might be
> useful as a "backup" timer to wake up the CPU from an inadequate idle
> state.
> 
> Now, in general, there are two reasons for the idle governor (whatever
> it is) to select an idle state with a target residency below the tick
> period length.  The first reason is when the governor knows that the
> closest timer event is going to occur in this time frame, but in that
> case (as stated above), it is not necessary to worry about the tick,
> because the other timer will trigger soon enough anyway.  The second
> reason is when the governor predicts a wakeup which is not by a timer
> in this time frame and it is quite arguable what the governor should
> do then.  IMO it at least is not unreasonable to throw the prediction
> away and still go for the closest timer event in that case (which is
> the current approach).
> 
> There's more, though.  Restarting the tick between cpuidle_select()
> and call_cpuidle() might introduce quite a bit of latency into that
> point and that would mess up with the idle state selection (e.g.
> selecting a very shallow idle state might not make a lot of sense if
> that latency was high enough, because the expected wakeup might very
> well take place when the tick was being restarted), so it should
> rather be avoided IMO.

I expect the idle governor doesn't introduce many restarting tick
operations, the reason is if there have a close timer event than idle
governor can trust it to wake up CPU so in this case the idle governor
will not restart tick;  if the the timer event is long delta and the
shallow state selection is caused by factors (e.g. typical pattern),
then we need restart tick to avoid powernightmares, for this case we
can restart tick only once at the beginning for the typical pattern
interrupt events; after the typical pattern interrupt doesn't continue
then we can rely on the tick to rescue the idle state to deep one.

Thanks,
Leo Yan
