From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5, 01/46] arm: Frequency invariant scheduler load-tracking
 support
Date: Tue, 21 Jul 2015 23:41:45 +0800
Message-ID: <20150721154145.GA23852@leoy-linaro>
References: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33238 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbbGUPl4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 11:41:56 -0400
Received: by padck2 with SMTP id ck2so121728697pad.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2015 08:41:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: morten.rasmussen@arm.com
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

Hi Morten,

On Tue, Jul 07, 2015 at 07:23:44PM +0100, Morten Rasmussen wrote:
> From: Morten Rasmussen <Morten.Rasmussen@arm.com>
> 
> Implements arch-specific function to provide the scheduler with a
> frequency scaling correction factor for more accurate load-tracking.
> The factor is:
> 
> 	current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)
> 
> This implementation only provides frequency invariance. No cpu
> invariance yet.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> ---
> arch/arm/include/asm/topology.h |  7 +++++
>  arch/arm/kernel/smp.c           | 57 +++++++++++++++++++++++++++++++++++++++--
>  arch/arm/kernel/topology.c      | 17 ++++++++++++
>  3 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 370f7a7..c31096f 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,13 @@ void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  
> +#define arch_scale_freq_capacity arm_arch_scale_freq_capacity
> +struct sched_domain;
> +extern
> +unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu);
> +
> +DECLARE_PER_CPU(atomic_long_t, cpu_freq_capacity);
> +
>  #else
>  
>  static inline void init_cpu_topology(void) { }
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index cca5b87..a32539c 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -677,12 +677,34 @@ static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
>  static DEFINE_PER_CPU(unsigned long, l_p_j_ref_freq);
>  static unsigned long global_l_p_j_ref;
>  static unsigned long global_l_p_j_ref_freq;
> +static DEFINE_PER_CPU(atomic_long_t, cpu_max_freq);
> +DEFINE_PER_CPU(atomic_long_t, cpu_freq_capacity);
> +
> +/*
> + * Scheduler load-tracking scale-invariance
> + *
> + * Provides the scheduler with a scale-invariance correction factor that
> + * compensates for frequency scaling through arch_scale_freq_capacity()
> + * (implemented in topology.c).
> + */
> +static inline
> +void scale_freq_capacity(int cpu, unsigned long curr, unsigned long max)
> +{
> +	unsigned long capacity;
> +
> +	if (!max)
> +		return;
> +
> +	capacity = (curr << SCHED_CAPACITY_SHIFT) / max;
> +	atomic_long_set(&per_cpu(cpu_freq_capacity, cpu), capacity);
> +}
>  
>  static int cpufreq_callback(struct notifier_block *nb,
>  					unsigned long val, void *data)
>  {
>  	struct cpufreq_freqs *freq = data;
>  	int cpu = freq->cpu;
> +	unsigned long max = atomic_long_read(&per_cpu(cpu_max_freq, cpu));
>  
>  	if (freq->flags & CPUFREQ_CONST_LOOPS)
>  		return NOTIFY_OK;
> @@ -707,6 +729,10 @@ static int cpufreq_callback(struct notifier_block *nb,
>  					per_cpu(l_p_j_ref_freq, cpu),
>  					freq->new);
>  	}
> +
> +	if (val == CPUFREQ_PRECHANGE)
> +		scale_freq_capacity(cpu, freq->new, max);
> +
>  	return NOTIFY_OK;
>  }
>  
> @@ -714,11 +740,38 @@ static struct notifier_block cpufreq_notifier = {
>  	.notifier_call  = cpufreq_callback,
>  };
>  
> +static int cpufreq_policy_callback(struct notifier_block *nb,
> +						unsigned long val, void *data)
> +{
> +	struct cpufreq_policy *policy = data;
> +	int i;
> +
> +	if (val != CPUFREQ_NOTIFY)
> +		return NOTIFY_OK;
> +
> +	for_each_cpu(i, policy->cpus) {
> +		scale_freq_capacity(i, policy->cur, policy->max);
> +		atomic_long_set(&per_cpu(cpu_max_freq, i), policy->max);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block cpufreq_policy_notifier = {
> +	.notifier_call	= cpufreq_policy_callback,
> +};
> +
>  static int __init register_cpufreq_notifier(void)
>  {
> -	return cpufreq_register_notifier(&cpufreq_notifier,
> +	int ret;
> +
> +	ret = cpufreq_register_notifier(&cpufreq_notifier,
>  						CPUFREQ_TRANSITION_NOTIFIER);
> +	if (ret)
> +		return ret;
> +
> +	return cpufreq_register_notifier(&cpufreq_policy_notifier,
> +						CPUFREQ_POLICY_NOTIFIER);
>  }
>  core_initcall(register_cpufreq_notifier);

For "cpu_freq_capacity" structure, could move it into driver/cpufreq
so that it can be shared by all architectures? Otherwise, every
architecture's smp.c need register notifier for themselves.

Thanks,
Leo Yan

> -
>  #endif
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 08b7847..9c09e6e 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -169,6 +169,23 @@ static void update_cpu_capacity(unsigned int cpu)
>  		cpu, arch_scale_cpu_capacity(NULL, cpu));
>  }
>  
> +/*
> + * Scheduler load-tracking scale-invariance
> + *
> + * Provides the scheduler with a scale-invariance correction factor that
> + * compensates for frequency scaling (arch_scale_freq_capacity()). The scaling
> + * factor is updated in smp.c
> + */
> +unsigned long arm_arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
> +{
> +	unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));
> +
> +	if (!curr)
> +		return SCHED_CAPACITY_SCALE;
> +
> +	return curr;
> +}
> +
>  #else
>  static inline void parse_dt_topology(void) {}
>  static inline void update_cpu_capacity(unsigned int cpuid) {}
