From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] cpufreq: Support for fast frequency switching
Date: Thu, 3 Mar 2016 11:30:03 +0530
Message-ID: <20160303060003.GJ2891@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <26020775.9hJG2SHiH2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26020775.9hJG2SHiH2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 02-03-16, 03:12, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1772,6 +1772,39 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>   *                              GOVERNORS                            *
>   *********************************************************************/
>  
> +/**
> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
> + * @policy: cpufreq policy to switch the frequency for.
> + * @target_freq: New frequency to set (may be approximate).
> + * @relation: Relation to use for frequency selection.
> + *
> + * Carry out a fast frequency switch from interrupt context.
> + *
> + * This function must not be called if policy->fast_switch_possible is unset.
> + *
> + * Governors calling this function must guarantee that it will never be invoked
> + * twice in parallel for the same policy and that it will never be called in
> + * parallel with either ->target() or ->target_index() for the same policy.
> + *
> + * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
> + * callback, the hardware configuration must be preserved.
> + */
> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> +				unsigned int target_freq, unsigned int relation)
> +{
> +	unsigned int freq;
> +
> +	if (target_freq == policy->cur)

Maybe an unlikely() here ?

> +		return;
> +
> +	freq = cpufreq_driver->fast_switch(policy, target_freq, relation);
> +	if (freq != CPUFREQ_ENTRY_INVALID) {
> +		policy->cur = freq;

Hmm.. What will happen to the code relying on the cpufreq-notifiers
now ?

> +		trace_cpu_frequency(freq, smp_processor_id());
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);

-- 
viresh
