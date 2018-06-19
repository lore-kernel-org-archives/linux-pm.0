From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation
 helper function
Date: Tue, 19 Jun 2018 10:53:40 +0100
Message-ID: <20180619095340.GS17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-8-quentin.perret@arm.com>
 <20180619095140.GE9208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619095140.GE9208@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 15:21:40 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:02PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
> >  
> > +/*
> > + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> > + */
> > +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> > +{
> > +	unsigned long util, util_est;
> > +	struct cfs_rq *cfs_rq;
> > +
> > +	/* Task is where it should be, or has no impact on cpu */
> > +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> > +		return cpu_util(cpu);
> > +
> > +	cfs_rq = &cpu_rq(cpu)->cfs;
> > +	util = READ_ONCE(cfs_rq->avg.util_avg);
> > +
> > +	if (dst_cpu == cpu)
> > +		util += task_util(p);
> > +	else
> > +		util = max_t(long, util - task_util(p), 0);
> > +
> > +	if (sched_feat(UTIL_EST)) {
> > +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +		if (dst_cpu == cpu)
> > +			util_est += _task_util_est(p);
> > +		else
> > +			util_est = max_t(long, util_est - _task_util_est(p), 0);
> 
> For UTIL_EST case, the waking task will not have any contribution in the
> previous CPU's util_est. So we can just use the previous CPU util_est as is.

Right, good catch, I actually spotted that one as well and already fixed it
for v4 ;-)
