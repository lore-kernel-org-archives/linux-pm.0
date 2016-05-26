From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/3] cpufreq: add resolve_freq driver callback
Date: Thu, 26 May 2016 11:55:14 +0530
Message-ID: <20160526062514.GU17585@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-2-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464231181-30741-2-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 25-05-16, 19:52, Steve Muckle wrote:
> Cpufreq governors may need to know what a particular target frequency
> maps to in the driver without necessarily wanting to set the frequency.
> Support this operation via a new cpufreq API,
> cpufreq_driver_resolve_freq().
> 
> The above API will call a new cpufreq driver callback, resolve_freq(),
> if it has been registered by the driver. If that callback has not been
> registered and a frequency table is available then the frequency table
> is walked using cpufreq_frequency_table_target().
> 
> UINT_MAX is returned if no driver callback or frequency table is
> available.

Why should we return UINT_MAX here? We should return target_freq, no ?

> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 25 +++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 11 +++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 77d77a4e3b74..3b44f4bdc071 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1849,6 +1849,31 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>  
> +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> +					 unsigned int target_freq)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	int index, retval;
> +
> +	clamp_val(target_freq, policy->min, policy->max);
> +
> +	if (cpufreq_driver->resolve_freq)
> +		return cpufreq_driver->resolve_freq(policy, target_freq);
> +
> +	freq_table = cpufreq_frequency_get_table(policy->cpu);

I have sent a separate patch to provide a light weight alternative to
this. If that gets accepted, we can switch over to using it.

> +	if (!freq_table)
> +		return UINT_MAX;
> +
> +	retval = cpufreq_frequency_table_target(policy, freq_table,
> +						target_freq, CPUFREQ_RELATION_L,
> +						&index);
> +	if (retval)
> +		return UINT_MAX;
> +
> +	return freq_table[index].frequency;
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> +
>  /* Must set freqs->new to intermediate frequency */
>  static int __target_intermediate(struct cpufreq_policy *policy,
>  				 struct cpufreq_freqs *freqs, int index)
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4e81e08db752..675f17f98e75 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -271,6 +271,13 @@ struct cpufreq_driver {
>  	int		(*target_intermediate)(struct cpufreq_policy *policy,
>  					       unsigned int index);
>  
> +	/*
> +	 * Return the driver-supported frequency that a particular target
> +	 * frequency maps to (does not set the new frequency).
> +	 */
> +	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
> +					unsigned int target_freq);

We have 3 categories of cpufreq-drivers today:
1. setpolicy drivers: They don't use the cpufreq governors we are
   working on.
2. non-setpolicy drivers:
  A. with ->target_index() callback, these will always provide a
     freq-table.
  B. with ->target() callback, ONLY these should be allowed to provide
     the ->resolve_freq() callback and no one else.

And so I would suggest adding an additional check in
cpufreq_register_driver() to catch incorrect usage of this callback.

-- 
viresh
