From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH RESEND 11/11] cpufreq: add new routine cpufreq_verify_within_cpu_limits()
Date: Wed, 02 Oct 2013 10:40:33 -0700
Message-ID: <524C5A91.6000005@gmail.com>
References: <cover.1380703248.git.viresh.kumar@linaro.org> <269a6a5bf55462c3e0aa0b96e6aba2f811ac9871.1380703248.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <269a6a5bf55462c3e0aa0b96e6aba2f811ac9871.1380703248.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

On 10/02/2013 01:43 AM, Viresh Kumar wrote:
> Most of the users of cpufreq_verify_within_limits() calls it for limiting with
> min/max from policy->cpuinfo. We can make that code simple by introducing
> another routine which will do this for them automatically.
>
> This patch adds another routine cpufreq_verify_within_cpu_limits() and updates
> others to use it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq-nforce2.c    | 4 +---
>   drivers/cpufreq/davinci-cpufreq.c    | 4 +---
>   drivers/cpufreq/freq_table.c         | 6 ++----
>   drivers/cpufreq/integrator-cpufreq.c | 9 ++-------
>   drivers/cpufreq/intel_pstate.c       | 4 +---
>   drivers/cpufreq/longrun.c            | 4 +---
>   drivers/cpufreq/pcc-cpufreq.c        | 3 +--
>   drivers/cpufreq/sh-cpufreq.c         | 7 ++-----
>   drivers/cpufreq/unicore2-cpufreq.c   | 4 +---
>   include/linux/cpufreq.h              | 7 +++++++
>   10 files changed, 19 insertions(+), 33 deletions(-)
>

For intel_pstate portion
Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index b83d45f6..56c964c 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -303,9 +303,7 @@ static int nforce2_verify(struct cpufreq_policy *policy)
>   	if (policy->min < (fsb_pol_max * fid * 100))
>   		policy->max = (fsb_pol_max + 1) * fid * 100;
>
> -	cpufreq_verify_within_limits(policy,
> -				     policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>   	return 0;
>   }
>
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> index f67196e..ba03e6f 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -50,9 +50,7 @@ static int davinci_verify_speed(struct cpufreq_policy *policy)
>   	if (policy->cpu)
>   		return -EINVAL;
>
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> -
> +	cpufreq_verify_within_cpu_limits(policy);
>   	policy->min = clk_round_rate(armclk, policy->min * 1000) / 1000;
>   	policy->max = clk_round_rate(armclk, policy->max * 1000) / 1000;
>   	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 10f3cfb..b9336ed 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -60,8 +60,7 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
>   	pr_debug("request for verification of policy (%u - %u kHz) for cpu %u\n",
>   					policy->min, policy->max, policy->cpu);
>
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>
>   	for (; freq = table[i].frequency, freq != CPUFREQ_TABLE_END; i++) {
>   		if (freq == CPUFREQ_ENTRY_INVALID)
> @@ -77,8 +76,7 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
>
>   	if (!found) {
>   		policy->max = next_larger;
> -		cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				policy->cpuinfo.max_freq);
> +		cpufreq_verify_within_cpu_limits(policy);
>   	}
>
>   	pr_debug("verification lead to (%u - %u kHz) for cpu %u\n",
> diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
> index f7c99df..8152a9b 100644
> --- a/drivers/cpufreq/integrator-cpufreq.c
> +++ b/drivers/cpufreq/integrator-cpufreq.c
> @@ -59,9 +59,7 @@ static int integrator_verify_policy(struct cpufreq_policy *policy)
>   {
>   	struct icst_vco vco;
>
> -	cpufreq_verify_within_limits(policy,
> -				     policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>
>   	vco = icst_hz_to_vco(&cclk_params, policy->max * 1000);
>   	policy->max = icst_hz(&cclk_params, vco) / 1000;
> @@ -69,10 +67,7 @@ static int integrator_verify_policy(struct cpufreq_policy *policy)
>   	vco = icst_hz_to_vco(&cclk_params, policy->min * 1000);
>   	policy->min = icst_hz(&cclk_params, vco) / 1000;
>
> -	cpufreq_verify_within_limits(policy,
> -				     policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> -
> +	cpufreq_verify_within_cpu_limits(policy);
>   	return 0;
>   }
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 32b3479..22b8d54 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -614,9 +614,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>
>   static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
>   {
> -	cpufreq_verify_within_limits(policy,
> -				policy->cpuinfo.min_freq,
> -				policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>
>   	if ((policy->policy != CPUFREQ_POLICY_POWERSAVE) &&
>   		(policy->policy != CPUFREQ_POLICY_PERFORMANCE))
> diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
> index 5aa0316..074971b 100644
> --- a/drivers/cpufreq/longrun.c
> +++ b/drivers/cpufreq/longrun.c
> @@ -129,9 +129,7 @@ static int longrun_verify_policy(struct cpufreq_policy *policy)
>   		return -EINVAL;
>
>   	policy->cpu = 0;
> -	cpufreq_verify_within_limits(policy,
> -		policy->cpuinfo.min_freq,
> -		policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>
>   	if ((policy->policy != CPUFREQ_POLICY_POWERSAVE) &&
>   	    (policy->policy != CPUFREQ_POLICY_PERFORMANCE))
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 70438de..160cc1e 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -111,8 +111,7 @@ static struct pcc_cpu __percpu *pcc_cpu_info;
>
>   static int pcc_cpufreq_verify(struct cpufreq_policy *policy)
>   {
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>   	return 0;
>   }
>
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 1362e88..f1fb944 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -87,15 +87,12 @@ static int sh_cpufreq_verify(struct cpufreq_policy *policy)
>   	if (freq_table)
>   		return cpufreq_frequency_table_verify(policy, freq_table);
>
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> +	cpufreq_verify_within_cpu_limits(policy);
>
>   	policy->min = (clk_round_rate(cpuclk, 1) + 500) / 1000;
>   	policy->max = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
>
> -	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     policy->cpuinfo.max_freq);
> -
> +	cpufreq_verify_within_cpu_limits(policy);
>   	return 0;
>   }
>
> diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
> index b225f04..14e6d31 100644
> --- a/drivers/cpufreq/unicore2-cpufreq.c
> +++ b/drivers/cpufreq/unicore2-cpufreq.c
> @@ -29,9 +29,7 @@ static int ucv2_verify_speed(struct cpufreq_policy *policy)
>   	if (policy->cpu)
>   		return -EINVAL;
>
> -	cpufreq_verify_within_limits(policy,
> -			policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> -
> +	cpufreq_verify_within_cpu_limits(policy);
>   	return 0;
>   }
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 6c9c365..ddc6332 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -256,6 +256,13 @@ static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
>   	return;
>   }
>
> +static inline void
> +cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> +{
> +	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> +			policy->cpuinfo.max_freq);
> +}
> +
>   /*********************************************************************
>    *                     CPUFREQ NOTIFIER INTERFACE                    *
>    *********************************************************************/
>

