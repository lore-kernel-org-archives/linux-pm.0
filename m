From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 11/14] sched/fair: Introduce an energy estimation
 helper function
Date: Thu, 4 Oct 2018 10:34:57 +0200
Message-ID: <20181004083457.GC19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-12-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-12-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:06AM +0100, Quentin Perret wrote:
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> +	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
> +
> +	/*
> +	 * If @p migrates from @cpu to another, remove its contribution. Or,
> +	 * if @p migrates from another CPU to @cpu, add its contribution. In
> +	 * the other cases, @cpu is not impacted by the migration, so the
> +	 * util_avg should already be correct.
> +	 */
> +	if (task_cpu(p) == cpu && dst_cpu != cpu)
> +		util = max_t(long, util - task_util(p), 0);

That's not quite right; what you want to check for is underflow, but the
above also results in 0 if util - task_util() > LONG_MAX without an
underflow.

You could write: sub_positive(&util, task_util(p));

> +	else if (task_cpu(p) != cpu && dst_cpu == cpu)
> +		util += task_util(p);
> +
> +	if (sched_feat(UTIL_EST)) {
> +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +
> +		/*
> +		 * During wake-up, the task isn't enqueued yet and doesn't
> +		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
> +		 * so just add it (if needed) to "simulate" what will be
> +		 * cpu_util() after the task has been enqueued.
> +		 */
> +		if (dst_cpu == cpu)
> +			util_est += _task_util_est(p);
> +
> +		util = max(util, util_est);
> +	}
> +
> +	return min_t(unsigned long, util, capacity_orig_of(cpu));

AFAICT both @util and capacity_orig_of() have 'unsigned long' as type.

> +}
> +
> +/*
> + * compute_energy(): Estimates the energy that would be consumed if @p was
> + * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
> + * landscape of the * CPUs after the task migration, and uses the Energy Model
> + * to compute what would be the energy if we decided to actually migrate that
> + * task.
> + */
> +static long compute_energy(struct task_struct *p, int dst_cpu,
> +							struct perf_domain *pd)

static long
compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)

> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	while (pd) {
> +		max_util = sum_util = 0;
> +		/*
> +		 * The capacity state of CPUs of the current rd can be driven by
> +		 * CPUs of another rd if they belong to the same performance
> +		 * domain. So, account for the utilization of these CPUs too
> +		 * by masking pd with cpu_online_mask instead of the rd span.
> +		 *
> +		 * If an entire performance domain is outside of the current rd,
> +		 * it will not appear in its pd list and will not be accounted
> +		 * by compute_energy().
> +		 */
> +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util = schedutil_freq_util(cpu, util, ENERGY_UTIL);
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_pd_energy(pd->obj, max_util, sum_util);
> +		pd = pd->next;
> +	}

No real strong preference, but you could write that like:

	for (; pd; pd = pd->next) {
	}


> +
> +	return energy;
> +}
