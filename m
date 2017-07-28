From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 03/10] cpufreq: arm_big_little: invoke
 frequency-invariance setter function
Date: Fri, 28 Jul 2017 13:55:09 +0530
Message-ID: <20170728082509.GA352@vireshk-i7>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-4-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727193312.9849-4-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 27-07-17, 20:33, Dietmar Eggemann wrote:
> Call the frequency-invariance setter function arch_set_freq_scale()
> if the new frequency has been successfully set which is indicated by
> bL_cpufreq_set_rate() returning 0.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index ea6d62547b10..8880f8d9d09d 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -213,6 +213,7 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
>  {
>  	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
>  	unsigned int freqs_new;
> +	int ret;
>  
>  	cur_cluster = cpu_to_cluster(cpu);
>  	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
> @@ -229,7 +230,14 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
>  		}
>  	}
>  
> -	return bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
> +	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
> +
> +	if (!ret) {
> +		arch_set_freq_scale(policy->related_cpus, freqs_new,
> +				    policy->cpuinfo.max_freq);
> +	}
> +
> +	return ret;
>  }
>  
>  static inline u32 get_table_count(struct cpufreq_frequency_table *table)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
