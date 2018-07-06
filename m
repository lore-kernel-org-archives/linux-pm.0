From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 6 Jul 2018 15:24:28 +0200
Message-ID: <20180706132428.GY2476@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706113208.GS2458@hirez.programming.kicks-ass.net>
 <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 06, 2018 at 02:20:57PM +0100, Quentin Perret wrote:
> On Friday 06 Jul 2018 at 13:32:08 (+0200), Peter Zijlstra wrote:
> > On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
> > > @@ -5384,6 +5402,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  {
> > >  	struct cfs_rq *cfs_rq;
> > >  	struct sched_entity *se = &p->se;
> > > +	int task_new = !(flags & ENQUEUE_WAKEUP);
> > >  
> > >  	/*
> > >  	 * The code below (indirectly) updates schedutil which looks at
> > > @@ -5431,8 +5450,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > -	if (!se)
> > > +	if (!se) {
> > >  		add_nr_running(rq, 1);
> > > +		if (!task_new)
> > > +			update_overutilized_status(rq);
> > 
> > I'm confused... why only for !ENQUEUE_WAKEUP
> 
> So, what we try to do here is to _not_ set the overutilized flag based
> on the utilization of a new task, because its utilization is 'wrong'.
> That should help avoiding spurious transitions above the overutilized
> threshold.

That most certainly deserves a comment, also didn't util_est fix some of
that wrong-ness?
