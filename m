From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 6 Jul 2017 16:10:27 +0530
Message-ID: <20170706104027.GB13048@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706094948.8779-3-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 06-07-17, 10:49, Dietmar Eggemann wrote:
> A frequency-invariant load-tracking solution based on cpufreq transition
> notifier will not work for future fast frequency switching policies.
> That is why a different solution is presented with this patch.
> 
> Let cpufreq call the function arch_set_freq_scale() to pass the current
> frequency, the max supported frequency and the cpumask of the related
> cpus to a consumer (an arch) which defines arch_set_freq_scale().
> 
> The consumer has to associate arch_set_freq_scale with the name of its
> own implementation foo_set_freq_scale() to overwrite the empty standard
> definition in drivers/cpufreq/cpufreq.c.
> An arch could do this in one of its arch-specific header files
> (e.g. arch/$ARCH/include/asm/topology.h) which gets included in
> drivers/cpufreq/cpufreq.c.
> 
> In case arch_set_freq_scale() is not defined (and because of the
> pr_debug() drivers/cpufreq/cpufreq.c is not compiled with -DDEBUG)

The line within () needs to be improved to convey a clear message.

> the
> function cpufreq_set_freq_scale() gets compiled out.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9bf97a366029..a04c5886a5ce 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -347,6 +347,28 @@ static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>  	}
>  }
>  
> +/*********************************************************************
> + *           FREQUENCY INVARIANT CPU CAPACITY SUPPORT                *
> + *********************************************************************/
> +
> +#ifndef arch_set_freq_scale
> +static void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> +				unsigned long max_freq)
> +{}
> +#endif
> +
> +static void cpufreq_set_freq_scale(struct cpufreq_policy *policy,
> +				   struct cpufreq_freqs *freqs)
> +{
> +	unsigned long cur_freq = freqs ? freqs->new : policy->cur;
> +	unsigned long max_freq = policy->cpuinfo.max_freq;
> +
> +	pr_debug("cpus %*pbl cur/cur max freq %lu/%lu kHz\n",
> +		 cpumask_pr_args(policy->related_cpus), cur_freq, max_freq);
> +
> +	arch_set_freq_scale(policy->related_cpus, cur_freq, max_freq);

I am not sure why all these are required to be sent here and will come back to
it later on after going through other patches.

> +}
> +
>  /**
>   * cpufreq_notify_transition - call notifier chain and adjust_jiffies
>   * on frequency transition.
> @@ -405,6 +427,8 @@ void cpufreq_freq_transition_begin(struct cpufreq_policy *policy,
>  
>  	spin_unlock(&policy->transition_lock);
>  
> +	cpufreq_set_freq_scale(policy, freqs);
> +

Why do this before even changing the frequency ? We may fail while changing it.

IMHO, you should call this routine whenever we update policy->cur and that
happens regularly in __cpufreq_notify_transition() and few other places..

>  	cpufreq_notify_transition(policy, freqs, CPUFREQ_PRECHANGE);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
> @@ -2203,6 +2227,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  			CPUFREQ_NOTIFY, new_policy);
>  
> +	cpufreq_set_freq_scale(new_policy, NULL);

Why added it here ? To get it initialized ? If yes, then we should do that in
cpufreq_online() where we first initialize policy->cur.

Apart from this, you also need to update this in the schedutil governor (if you
haven't done that in this series later) as that also updates policy->cur in the
fast path.

-- 
viresh
