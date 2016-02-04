From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data pointer
Date: Wed, 03 Feb 2016 17:11:24 -0800
Message-ID: <56B2A53C.8080503@codeaurora.org>
References: <3705929.bslqXH980s@vostro.rjw.lan> <1876466.AY9fn15fDn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1876466.AY9fn15fDn@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 02/03/2016 03:22 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the ondemand and conservative governors cannot use per-policy
> tunables (CPUFREQ_HAVE_GOVERNOR_PER_POLICY is not set in the cpufreq
> driver), all policy objects point to the same single dbs_data object.
> Additionally, that object is pointed to by a global pointer hidden in
> the governor's data structures.
>
> There is no reason for that pointer to be buried in those
> data structures, though, so make it explicitly global.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/cpufreq_governor.c |   20 ++++++++++----------
>   drivers/cpufreq/cpufreq_governor.h |   20 ++++++++++----------
>   2 files changed, 20 insertions(+), 20 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -78,7 +78,7 @@ __ATTR(_name, 0644, show_##_name##_gov_p
>   static ssize_t show_##file_name##_gov_sys				\
>   (struct kobject *kobj, struct attribute *attr, char *buf)		\
>   {									\
> -	struct _gov##_dbs_tuners *tuners = _gov##_dbs_cdata.gdbs_data->tuners; \
> +	struct _gov##_dbs_tuners *tuners = global_dbs_data->tuners; \
>   	return sprintf(buf, "%u\n", tuners->file_name);			\
>   }									\
>   									\
> @@ -94,7 +94,7 @@ static ssize_t show_##file_name##_gov_po
>   static ssize_t store_##file_name##_gov_sys				\
>   (struct kobject *kobj, struct attribute *attr, const char *buf, size_t count) \
>   {									\
> -	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
> +	struct dbs_data *dbs_data = global_dbs_data;		\
>   	return store_##file_name(dbs_data, buf, count);			\
>   }									\
>   									\
> @@ -201,19 +201,14 @@ struct cs_dbs_tuners {
>   /* Common Governor data across policies */
>   struct dbs_data;
>   struct common_dbs_data {
> -	/* Common across governors */
> +	struct cpufreq_governor gov;
> +
>   	#define GOV_ONDEMAND		0
>   	#define GOV_CONSERVATIVE	1
>   	int governor;
>   	struct attribute_group *attr_group_gov_sys; /* one governor - system */
>   	struct attribute_group *attr_group_gov_pol; /* one governor - policy */
>
> -	/*
> -	 * Common data for platforms that don't set
> -	 * CPUFREQ_HAVE_GOVERNOR_PER_POLICY
> -	 */
> -	struct dbs_data *gdbs_data;
> -
>   	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
>   	void *(*get_cpu_dbs_info_s)(int cpu);
>   	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
> @@ -233,6 +228,11 @@ struct dbs_data {
>   	void *tuners;
>   };
>
> +/*
> + * Common governor data for platforms without CPUFREQ_HAVE_GOVERNOR_PER_POLICY.
> + */
> +extern struct dbs_data *global_dbs_data;
> +
>   /* Governor specific ops, will be passed to dbs_data->gov_ops */
>   struct od_ops {
>   	void (*powersave_bias_init_cpu)(int cpu);
> @@ -256,7 +256,7 @@ static inline int delay_for_sampling_rat
>   static ssize_t show_sampling_rate_min_gov_sys				\
>   (struct kobject *kobj, struct attribute *attr, char *buf)		\
>   {									\
> -	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
> +	struct dbs_data *dbs_data = global_dbs_data;			\
>   	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
>   }									\
>   									\
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,9 @@
>
>   #include "cpufreq_governor.h"
>
> +struct dbs_data *global_dbs_data;
> +EXPORT_SYMBOL_GPL(global_dbs_data);
> +
>   DEFINE_MUTEX(dbs_data_mutex);
>   EXPORT_SYMBOL_GPL(dbs_data_mutex);
>
> @@ -377,22 +380,19 @@ static int cpufreq_governor_init(struct
>   					latency * LATENCY_MULTIPLIER));
>
>   	if (!have_governor_per_policy())
> -		cdata->gdbs_data = dbs_data;
> +		global_dbs_data = dbs_data;
>
>   	policy->governor_data = dbs_data;
>
>   	ret = sysfs_create_group(get_governor_parent_kobj(policy),
>   				 get_sysfs_attr(dbs_data));
> -	if (ret)
> -		goto reset_gdbs_data;
> -
> -	return 0;
> +	if (!ret)
> +		return 0;

I think the previous method of a handling the error is easier to read 
and more in line with the typical kernel coding style. The successful 
path ends in an unconditional return statement and the error paths are 
handled with a goto.

This also doesn't seem relevant to what the patch is trying to do. So, 
I'd prefer that it be left as is.


> -reset_gdbs_data:
>   	policy->governor_data = NULL;
> -
>   	if (!have_governor_per_policy())
> -		cdata->gdbs_data = NULL;
> +		global_dbs_data = NULL;
> +
>   	cdata->exit(dbs_data, !policy->governor->initialized);
>   free_common_dbs_info:
>   	free_common_dbs_info(policy, cdata);
> @@ -418,7 +418,7 @@ static int cpufreq_governor_exit(struct
>   		policy->governor_data = NULL;
>
>   		if (!have_governor_per_policy())
> -			cdata->gdbs_data = NULL;
> +			global_dbs_data = NULL;
>
>   		cdata->exit(dbs_data, policy->governor->initialized == 1);
>   		kfree(dbs_data);
> @@ -550,7 +550,7 @@ int cpufreq_governor_dbs(struct cpufreq_
>   	if (have_governor_per_policy())
>   		dbs_data = policy->governor_data;
>   	else
> -		dbs_data = cdata->gdbs_data;
> +		dbs_data = global_dbs_data;
>
>   	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
>   		ret = -EINVAL;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

If the minor comment is addressed, this looks okay to me.

Cautiously Acked-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
