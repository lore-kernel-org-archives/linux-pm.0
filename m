From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv4 PATCH 11/34] sched: Remove blocked load and utilization
 contributions of dying tasks
Date: Tue, 19 May 2015 15:22:00 +0100
Message-ID: <20150519142200.GD26396@e105550-lin.cambridge.arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <1431459549-18343-12-git-send-email-morten.rasmussen@arm.com>
 <55529BD2.7020107@nvidia.com>
 <20150513134957.GB26396@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35029 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702AbbESOUY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 May 2015 10:20:24 -0400
Content-Disposition: inline
In-Reply-To: <20150513134957.GB26396@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Boonstoppel <pboonstoppel@nvidia.com>

On Wed, May 13, 2015 at 02:49:57PM +0100, Morten Rasmussen wrote:
> On Wed, May 13, 2015 at 01:33:22AM +0100, Sai Gurrappadi wrote:
> > On 05/12/2015 12:38 PM, Morten Rasmussen wrote:
> > > Task being dequeued for the last time (state == TASK_DEAD) are dequeued
> > > with the DEQUEUE_SLEEP flag which causes their load and utilization
> > > contributions to be added to the runqueue blocked load and utilization.
> > > Hence they will contain load or utilization that is gone away. The issue
> > > only exists for the root cfs_rq as cgroup_exit() doesn't set
> > > DEQUEUE_SLEEP for task group exits.
> > > 
> > > If runnable+blocked load is to be used as a better estimate for cpu
> > > load the dead task contributions need to be removed to prevent
> > > load_balance() (idle_balance() in particular) from over-estimating the
> > > cpu load.
> > > 
> > > cc: Ingo Molnar <mingo@redhat.com>
> > > cc: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e40cd88..d045404 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3202,6 +3202,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >  	 * Update run-time statistics of the 'current'.
> > >  	 */
> > >  	update_curr(cfs_rq);
> > > +	if (entity_is_task(se) && task_of(se)->state == TASK_DEAD)
> > > +		flags &= !DEQUEUE_SLEEP;
> > >  	dequeue_entity_load_avg(cfs_rq, se, flags & DEQUEUE_SLEEP);
> > >  
> > >  	update_stats_dequeue(cfs_rq, se);
> > > 
> > 
> > Maybe you could use the sched_class->task_dead() callback instead? I
> > remember seeing a patch from Yuyang that did that.
> 
> Now that you mention it, I remember that thread I think. I will have a
> look again and see if there are any good reasons not to use task_dead().

After having looked at it again I think using task_dead() is another
option, but it isn't the most elegant one. task_dead() is called very
late in the game, after the task has been dequeued and the rq lock has
been released. Doing it there would require re-taking the rq lock to
remove the task contribution from the rq blocked load that was just
added as part of the dequeue operation.

The above patch ensures that the task contribution isn't added to the rq
blocked load at dequeue when we know the task is dead instead of having
to fix it later. The problem seems to arise due schedule() not really
caring if the previous task is going to die or just sleep. It passed
DEQUEUE_SLEEP to the sched_class in both cases and we therefore have
to do the distinction of the two cases in fair.c.

Morten
