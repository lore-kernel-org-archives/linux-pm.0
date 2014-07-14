From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle/idle: move idle traces to cpuidle_enter_state
Date: Mon, 14 Jul 2014 21:47:46 +0200
Message-ID: <1602555.3nqafCzk86@vostro.rjw.lan>
References: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org> <53B81D94.6000404@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64369 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754870AbaGNT3e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 15:29:34 -0400
In-Reply-To: <53B81D94.6000404@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Sandeep Tripathy <sandeep.tripathy@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: rostedt@goodmis.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Saturday, July 05, 2014 05:45:24 PM Daniel Lezcano wrote:
> On 07/02/2014 11:30 AM, Sandeep Tripathy wrote:
> >   idle_exit event is the first event after a core exits
> > idle state. So this should be traced before local irq
> > is ebabled. Likewise idle_entry is the last event before
> > a core enters idle state. This will ease visualising the
> > cpu idle state from kernel traces.
> >
> > Signed-off-by: Sandeep Tripathy <sandeep.tripathy@linaro.org>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I'm going to take this for 3.17.

Peter, will there be any problems with it if I take it?

Rafael


> > ---
> >   drivers/cpuidle/cpuidle.c | 3 +++
> >   kernel/sched/idle.c       | 4 ----
> >   2 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 8236746..97680d0 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -99,12 +99,15 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> >   	ktime_t time_start, time_end;
> >   	s64 diff;
> >
> > +	trace_cpu_idle_rcuidle(index, dev->cpu);
> >   	time_start = ktime_get();
> >
> >   	entered_state = target_state->enter(dev, drv, index);
> >
> >   	time_end = ktime_get();
> >
> > +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> > +
> >   	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
> >   		local_irq_enable();
> >
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 8f4390a..07c446a 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -141,7 +141,6 @@ static int cpuidle_idle_call(void)
> >   					&dev->cpu);
> >
> >   			if (!ret) {
> > -				trace_cpu_idle_rcuidle(next_state, dev->cpu);
> >
> >   				/*
> >   				 * Enter the idle state previously
> > @@ -154,9 +153,6 @@ static int cpuidle_idle_call(void)
> >   				entered_state = cpuidle_enter(drv, dev,
> >   							      next_state);
> >
> > -				trace_cpu_idle_rcuidle(PWR_EVENT_EXIT,
> > -						       dev->cpu);
> > -
> >   				if (broadcast)
> >   					clockevents_notify(
> >   						CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> >
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
