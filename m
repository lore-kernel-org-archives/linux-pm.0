From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Mar 2018 12:39:21 +0000
Message-ID: <20180321123921.GB13951@e110439-lin>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-5-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 20-Mar 09:43, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>

[...]

> +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, fdom_max_util;
> +	struct capacity_state *cs;
> +	unsigned long energy = 0;
> +	struct freq_domain *fdom;
> +	int cpu;
> +
> +	for_each_freq_domain(fdom) {
> +		fdom_max_util = 0;
> +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);

Would be nice to find a way to cache all these util and reuse them
below... even just to ensure data consistency between the "cs"
computation and its usage...

> +			fdom_max_util = max(util, fdom_max_util);
> +		}
> +
> +		/*
> +		 * Here we assume that the capacity states of CPUs belonging to
> +		 * the same frequency domains are shared. Hence, we look at the
> +		 * capacity state of the first CPU and re-use it for all.
> +		 */
> +		cpu = cpumask_first(&(fdom->span));
> +		cs = find_cap_state(cpu, fdom_max_util);
                ^^^^

The above code could theoretically return NULL, although likely EAS is
completely disabled if em->nb_cap_states == 0, right?

If that's the case then, in the previous function, you can certainly
avoid the initialization of *cs and maybe also add an explicit:

    BUG_ON(em->nb_cap_states == 0);

which helps even just as "in code documentation".

But, I'm not sure if maintainers like BUG_ON in scheduler code :)


> +
> +		/*
> +		 * The energy consumed by each CPU is derived from the power
                      ^

Should we make more explicit that this is just the "active" energy
consumed?

> +		 * it dissipates at the expected OPP and its percentage of
> +		 * busy time.
> +		 */
> +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			energy += cs->power * util / cs->cap;
> +		}
> +	}

nit-pick: empty line before return?

> +	return energy;
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> -- 
> 2.11.0
> 

-- 
#include <best/regards.h>

Patrick Bellasi
