From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Date: Wed, 21 Nov 2018 15:14:46 +0000
Message-ID: <20181121151444.t3zye5l5iycfni2s@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121130822.GE2113@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On Wednesday 21 Nov 2018 at 14:08:22 (+0100), Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 02:18:51PM +0000, Quentin Perret wrote:
> 
> > +static void sched_energy_start(int ndoms_new, cpumask_var_t doms_new[])
> > +{
> > +	/*
> > +	 * The conditions for EAS to start are checked during the creation of
> > +	 * root domains. If one of them meets all conditions, it will have a
> > +	 * non-null list of performance domains.
> > +	 */
> > +	while (ndoms_new) {
> > +		if (cpu_rq(cpumask_first(doms_new[ndoms_new - 1]))->rd->pd)
> > +			goto enable;
> > +		ndoms_new--;
> > +	}
> 
> That seems quite ugly; can't you simply return a bool from
> build_perf_domains() ?
> 
> Something like the below, but less fugly ;-)
> 
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -299,7 +299,7 @@ static void destroy_perf_domain_rcu(stru
>  #define EM_MAX_COMPLEXITY 2048
>  
>  extern struct cpufreq_governor schedutil_gov;
> -static void build_perf_domains(const struct cpumask *cpu_map)
> +static bool build_perf_domains(const struct cpumask *cpu_map)
>  {
>  	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
>  	struct perf_domain *pd = NULL, *tmp;
> @@ -365,7 +365,7 @@ static void build_perf_domains(const str
>  	if (tmp)
>  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
>  
> -	return;
> +	return !!pd;
>  
>  free:
>  	free_pd(pd);
> @@ -373,6 +373,8 @@ static void build_perf_domains(const str
>  	rcu_assign_pointer(rd->pd, NULL);
>  	if (tmp)
>  		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
> +
> +	return false;
>  }
>  #else
>  static void free_pd(struct perf_domain *pd) { }
> @@ -2173,6 +2175,9 @@ void partition_sched_domains(int ndoms_n
>  	}
>  
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> +	{
> +	bool has_eas = false;

That one wants to be declared '__maybe_unused' at the top of
partition_sched_domains() perhaps ? Just to avoid the { } section.
Hopefully the compiler will be smart enough to not use stack space for
it if not needed.

> +
>  	/* Build perf. domains: */
>  	for (i = 0; i < ndoms_new; i++) {
>  		for (j = 0; j < n && !sched_energy_update; j++) {
> @@ -2181,10 +2186,13 @@ void partition_sched_domains(int ndoms_n
>  				goto match3;

And we want to do 'has_eas = true' just before 'goto match3' here.
Otherwise we'll end up disabling EAS if we hit 'goto match3' for all
root domains.

>  		}
>  		/* No match - add perf. domains for a new rd */
> -		build_perf_domains(doms_new[i]);
> +		has_eas |= build_perf_domains(doms_new[i]);
>  match3:
>  		;
>  	}
> +
> +	sched_energy_set(has_eas);
> +	}
>  #endif
>  
>  	/* Remember the new sched domains: */

Other than that I guess that should work OK :-)

Thanks,
Quentin
