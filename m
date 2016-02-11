From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 12:24:29 +0000
Message-ID: <20160211122429.GM11415@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53717 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcBKMXn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Feb 2016 07:23:43 -0500
Content-Disposition: inline
In-Reply-To: <20160211115959.GI6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Peter,

On 11/02/16 12:59, Peter Zijlstra wrote:
> On Tue, Feb 09, 2016 at 05:02:33PM -0800, Steve Muckle wrote:
> > > Index: linux-pm/kernel/sched/deadline.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/deadline.c
> > > +++ linux-pm/kernel/sched/deadline.c
> > > @@ -1197,6 +1197,9 @@ static void task_tick_dl(struct rq *rq,
> > >  {
> > >  	update_curr_dl(rq);
> > >  
> > > +	/* Kick cpufreq to prevent it from stalling. */
> > > +	cpufreq_kick();
> > > +
> > >  	/*
> > >  	 * Even when we have runtime, update_curr_dl() might have resulted in us
> > >  	 * not being the leftmost task anymore. In that case NEED_RESCHED will
> > 
> > I think additional hooks such as enqueue/dequeue would be needed in
> > RT/DL. The task tick callbacks will only run if a task in that class is
> > executing at the time of the tick. There could be intermittent RT/DL
> > task activity in a frequency domain (the only task activity there, no
> > CFS tasks) that doesn't happen to overlap the tick. Worst case the task
> > activity could be periodic in such a way that it never overlaps the tick
> > and the update is never made.
> 
> No, for RT (RR/FIFO) we do not have enough information to do anything
> useful. Basically RR/FIFO should result in running 100% whenever we
> schedule such a task.
> 
> That means RR/FIFO want a hook in pick_next_task_rt() to bump the freq
> to 100% and leave it there until something else gets to run.
> 

Vincent is trying to play with rt_avg (in the last sched-freq thread) to
see if we can get some information about RT as well. I understand that
from a theoretical perspective that's not much we can say of such tasks,
and bumping to max can be the only sensible thing to do, but there are
users of RT (ehm, Android) that will probably see differences in energy
consumption if we do so. Yeah, maybe the should use a different policy,
yes.

> For DL it basically wants to set a minimum freq based on reserved
> utilization, so that is __setparam_dl() or somewhere around there.
> 

I think we could do better than this once Luca's reclaiming stuff gets
in. The reserved bw is usually somewhat pessimistic. But this is a
different discussion, maybe.

Best,

- Juri
