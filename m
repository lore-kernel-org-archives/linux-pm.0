From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 2/9] cpufreq: conservative: remove 'enable' field
Date: Tue, 08 Sep 2015 02:17:31 +0200
Message-ID: <2910194.KRcaApdNFO@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <91abed4ff8fe68f26fe0bdc840982bb972dba6dc.1437999691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49967 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751184AbbIGXtn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 19:49:43 -0400
In-Reply-To: <91abed4ff8fe68f26fe0bdc840982bb972dba6dc.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Monday, July 27, 2015 05:58:07 PM Viresh Kumar wrote:
> Conservative governor has its own 'enable' field to check if
> conservative governor is used for a CPU or not
> 
> This can be checked by policy->governor with 'cpufreq_gov_conservative'
> and so this field can be dropped.
> 
> Because its not guaranteed that dbs_info->cdbs.shared will a valid
> pointer for all CPUs (will be NULL for CPUs that don't use
> ondemand/conservative governors), we can't use it anymore. Lets get
> policy with cpufreq_cpu_get() instead.

But previously, if the enable bit was set, we actually new that the
pointer was valid, right?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 34 +++++++++++++++++++++-------------
>  drivers/cpufreq/cpufreq_governor.c     | 12 +-----------
>  drivers/cpufreq/cpufreq_governor.h     |  1 -
>  3 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 84a1506950a7..18bfbc313e48 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -23,6 +23,19 @@
>  
>  static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
>  
> +static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> +				   unsigned int event);
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
> +static
> +#endif
> +struct cpufreq_governor cpufreq_gov_conservative = {
> +	.name			= "conservative",
> +	.governor		= cs_cpufreq_governor_dbs,
> +	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
> +	.owner			= THIS_MODULE,
> +};
> +
>  static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
>  					   struct cpufreq_policy *policy)
>  {
> @@ -119,12 +132,14 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_freqs *freq = data;
>  	struct cs_cpu_dbs_info_s *dbs_info =
>  					&per_cpu(cs_cpu_dbs_info, freq->cpu);
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
>  
> -	if (!dbs_info->enable)
> +	if (!policy)
>  		return 0;
>  
> -	policy = dbs_info->cdbs.shared->policy;

So here we could get to the policy directly.  After the change we have to:

- acquire cpufreq_rwsem
- acquire cpufreq_driver_lock
- go the kobject_get on policy->kobj

and then finally drop the reference to the kobject when we're done.

So may I ask where exactly is the improvement?

> +	/* policy isn't governed by conservative governor */
> +	if (policy->governor != &cpufreq_gov_conservative)
> +		goto policy_put;
>  
>  	/*
>  	 * we only care if our internally tracked freq moves outside the 'valid'

Thanks,
Rafael

