From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 16/46] sched: Allocate and initialize energy data
 structures
Date: Wed, 12 Aug 2015 12:17:21 +0200
Message-ID: <20150812101721.GV19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436293469-25707-17-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:23:59PM +0100, Morten Rasmussen wrote:
> @@ -6647,10 +6703,24 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>  		if (!sdd->sgc)
>  			return -ENOMEM;
>  
> +		sdd->sge = alloc_percpu(struct sched_group_energy *);
> +		if (!sdd->sge)
> +			return -ENOMEM;
> +
>  		for_each_cpu(j, cpu_map) {
>  			struct sched_domain *sd;
>  			struct sched_group *sg;
>  			struct sched_group_capacity *sgc;
> +			struct sched_group_energy *sge;
> +			sched_domain_energy_f fn = tl->energy;
> +			unsigned int nr_idle_states = 0;
> +			unsigned int nr_cap_states = 0;
> +
> +			if (fn && fn(j)) {
> +				nr_idle_states = fn(j)->nr_idle_states;
> +				nr_cap_states = fn(j)->nr_cap_states;
> +				BUG_ON(!nr_idle_states || !nr_cap_states);
> +			}
>  
>  		       	sd = kzalloc_node(sizeof(struct sched_domain) + cpumask_size(),
>  					GFP_KERNEL, cpu_to_node(j));
> @@ -6674,6 +6744,16 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>  				return -ENOMEM;
>  
>  			*per_cpu_ptr(sdd->sgc, j) = sgc;
> +
> +			sge = kzalloc_node(sizeof(struct sched_group_energy) +
> +				nr_idle_states*sizeof(struct idle_state) +
> +				nr_cap_states*sizeof(struct capacity_state),
> +				GFP_KERNEL, cpu_to_node(j));
> +
> +			if (!sge)
> +				return -ENOMEM;
> +
> +			*per_cpu_ptr(sdd->sge, j) = sge;
>  		}
>  	}
>  

One more question, if fn() returns a full structure, why are we
allocating and copying the thing? Its all const read only data, right?
