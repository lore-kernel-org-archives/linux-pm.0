From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 11/46] sched: Remove blocked load and utilization
 contributions of dying tasks
Date: Tue, 11 Aug 2015 15:58:48 +0100
Message-ID: <20150811145847.GA20892@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
 <20150811113927.GT19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811113927.GT19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 11, 2015 at 01:39:27PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:23:54PM +0100, Morten Rasmussen wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 775b0c7..fa12ce5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3217,6 +3217,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  	 * Update run-time statistics of the 'current'.
> >  	 */
> >  	update_curr(cfs_rq);
> > +	if (entity_is_task(se) && task_of(se)->state == TASK_DEAD)
> > +		flags &= !DEQUEUE_SLEEP;
> >  	dequeue_entity_load_avg(cfs_rq, se, flags & DEQUEUE_SLEEP);
> >  
> >  	update_stats_dequeue(cfs_rq, se);
> 
> I know this is entirely redundant at this point (we took Yuyang's
> patches), but this is the wrong way to go about doing this.

Yes, I'm still working my way through Yuyang's changes.

> You add extra code the hot dequeue path for something that 'never'
> happens. We have the sched_class::task_dead call for that.

I don't mind using sched_class::task_dead() instead. The reason why I
didn't go that way is that we have to retake the rq->lock or mess with
cfs_rq::removed_load instead of just not adding the utilization in
the first place when we have the rq->lock.

Anyway, it is probably redundant by now. I will check Yuyang's code to
see if he already fixed this problem.
