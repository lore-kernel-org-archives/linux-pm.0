From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 13/15] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Nov 2018 15:28:03 +0100
Message-ID: <20181121142803.GF2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-14-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-14-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 19, 2018 at 02:18:55PM +0000, Quentin Perret wrote:
> +static long
> +compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	for (; pd; pd = pd->next) {
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

Should that not be cpu_active_mask ?

> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util = schedutil_energy_util(cpu, util);
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
> +	}
> +
> +	return energy;
> +}
