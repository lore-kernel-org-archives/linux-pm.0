From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 7/11] cpufreq: governor: Rework cpufreq_governor_dbs()
Date: Wed, 03 Feb 2016 18:03:20 -0800
Message-ID: <56B2B168.4000700@codeaurora.org>
References: <3705929.bslqXH980s@vostro.rjw.lan> <5491751.yYEN5nTL3A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5491751.yYEN5nTL3A@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 02/03/2016 03:33 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since it is possible to obtain a pointer to struct dbs_governor
> from a pointer to the struct governor embedded in it via
> container_of(), the second argument of cpufreq_governor_init()
> is not necessary.  Accordingly, cpufreq_governor_dbs() doesn't
> need its second argument either and the ->governor callbacks
> for both the ondemand and conservative governors may be set
> to cpufreq_governor_dbs() directly.  Make that happen.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c |   11 +----------
>   drivers/cpufreq/cpufreq_governor.c     |   10 +++++-----
>   drivers/cpufreq/cpufreq_governor.h     |    3 +--
>   drivers/cpufreq/cpufreq_ondemand.c     |   11 +----------
>   4 files changed, 8 insertions(+), 27 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> @@ -325,13 +325,10 @@ static void cs_exit(struct dbs_data *dbs
>
>   define_get_cpu_dbs_routines(cs_cpu_dbs_info);
>
> -static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -				   unsigned int event);
> -
>   static struct dbs_governor cs_dbs_gov = {
>   	.gov = {
>   		.name = "conservative",
> -		.governor = cs_cpufreq_governor_dbs,
> +		.governor = cpufreq_governor_dbs,
>   		.max_transition_latency = TRANSITION_LATENCY_LIMIT,
>   		.owner = THIS_MODULE,
>   	},
> @@ -348,12 +345,6 @@ static struct dbs_governor cs_dbs_gov =
>
>   #define CPU_FREQ_GOV_CONSERVATIVE	(&cs_dbs_gov.gov)
>
> -static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -				   unsigned int event)
> -{
> -	return cpufreq_governor_dbs(policy, &cs_dbs_gov, event);
> -}
> -
>   static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>   				void *data)
>   {
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -329,9 +329,9 @@ static void free_common_dbs_info(struct
>   	kfree(shared);
>   }
>
> -static int cpufreq_governor_init(struct cpufreq_policy *policy,
> -				 struct dbs_governor *gov)
> +static int cpufreq_governor_init(struct cpufreq_policy *policy)
>   {
> +	struct dbs_governor *gov;
>   	struct dbs_data *dbs_data;
>   	unsigned int latency;
>   	int ret;
> @@ -340,6 +340,7 @@ static int cpufreq_governor_init(struct
>   	if (policy->governor_data)
>   		return -EBUSY;
>
> +	gov = container_of(policy->governor, struct dbs_governor, gov);
>   	if (global_dbs_data) {
>   		if (WARN_ON(have_governor_per_policy()))
>   			return -EINVAL;
> @@ -538,8 +539,7 @@ static int cpufreq_governor_limits(struc
>   	return 0;
>   }
>
> -int cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -			 struct dbs_governor *gov, unsigned int event)
> +int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event)
>   {
>   	int ret = -EINVAL;
>
> @@ -547,7 +547,7 @@ int cpufreq_governor_dbs(struct cpufreq_
>   	mutex_lock(&dbs_data_mutex);
>
>   	if (event == CPUFREQ_GOV_POLICY_INIT) {
> -		ret = cpufreq_governor_init(policy, gov);
> +		ret = cpufreq_governor_init(policy);
>   	} else if (policy->governor_data) {
>   		switch (event) {
>   		case CPUFREQ_GOV_POLICY_EXIT:
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -273,8 +273,7 @@ void gov_set_update_util(struct cpu_comm
>   			 unsigned int delay_us);
>   void gov_cancel_work(struct cpu_common_dbs_info *shared);
>   void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
> -int cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -		struct dbs_governor *gov, unsigned int event);
> +int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
>   void od_register_powersave_bias_handler(unsigned int (*f)
>   		(struct cpufreq_policy *, unsigned int, unsigned int),
>   		unsigned int powersave_bias);
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -539,13 +539,10 @@ static struct od_ops od_ops = {
>   	.freq_increase = dbs_freq_increase,
>   };
>
> -static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -				   unsigned int event);
> -
>   static struct dbs_governor od_dbs_gov = {
>   	.gov = {
>   		.name = "ondemand",
> -		.governor = od_cpufreq_governor_dbs,
> +		.governor = cpufreq_governor_dbs,
>   		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
>   		.owner = THIS_MODULE,
>   	},
> @@ -563,12 +560,6 @@ static struct dbs_governor od_dbs_gov =
>
>   #define CPU_FREQ_GOV_ONDEMAND	(&od_dbs_gov.gov)
>
> -static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
> -		unsigned int event)
> -{
> -	return cpufreq_governor_dbs(policy, &od_dbs_gov, event);
> -}
> -
>   static void od_set_powersave_bias(unsigned int powersave_bias)
>   {
>   	struct cpufreq_policy *policy;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Nice!

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
