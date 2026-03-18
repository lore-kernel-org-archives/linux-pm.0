Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F71DDE5;
	Wed, 18 Mar 2026 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802266; cv=none; b=MnQyeOjUx8tLxjF9+gMhPIbqiNig100Z3KyH7BcdmKwLKwj4AhB2gRhMgrhA1bQNqOEOXv27t9AmGRf9x9nZdYAa46yDHoQaRpgCbw3rsN0XKOBRnH+qTENVgzGAKqPeHVyxwd7tOJf3MMOU/R3KBjO4lfz2vwbioyW8laVJZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802266; c=relaxed/simple;
	bh=pIb+K73An4LsG9JTFlGZwRSQhIxc7mIv1f1eDglvCfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZMA8tLU2CfZ7M+SgnZSJnw8KqS/+tuRdbRLsVNJJwQsFYd/m50+h9mD5leRkVlVRgUcvnghrhWNqqbxnXrMLROIbUOOXkbDh99m6uFdlLLD7qpzxCGGLJ3sPj2zy+sohyBqXTjjfHJu2GbdAneTM9zF76c5jfABNQB90E16DeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=57J0hkYi; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="57J0hkYi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=veUMzvfyXewTFtoQg1MErc3XWf3soA8VT9aw2qpZtPA=;
	b=57J0hkYiMfhZN55jnfmuz2138d4TEETAvstIDAiYturtXS3iasd5XIGaoLYOwlulmbwvnITE+
	3jujp8+UtSs4oshPusGyqRFt26DbLYX/VD/7sp2n0iY8bKW7Xxi6xb9RYPCFWpckV9289O4cczg
	lCmocnsgOw77phISXE46abE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fbCr56s1Mz1prKb;
	Wed, 18 Mar 2026 10:45:57 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 92B7B4056B;
	Wed, 18 Mar 2026 10:50:59 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Mar
 2026 10:50:58 +0800
Message-ID: <ccc646b2-6af8-48e9-a2d5-9c9b55ae0848@huawei.com>
Date: Wed, 18 Mar 2026 10:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Huang Rui
	<ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-3-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260317101753.2284763-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/17/2026 6:17 PM, Pierre Gondois wrote:
> The Power Management Quality of Service (PM QoS) allows to
> aggregate constraints from multiple entities. It is currently
> used to manage the min/max frequency of a given policy.
> 
> Frequency constraints can come for instance from:
> - Thermal framework: acpi_thermal_cpufreq_init()
> - Firmware: _PPC objects: acpi_processor_ppc_init()
> - User: by setting policyX/scaling_[min|max]_freq
> The minimum of the max frequency constraints is used to compute
> the resulting maximum allowed frequency.
> 
> When enabling boost frequencies, the same frequency request object
> (policy->max_freq_req) as to handle requests from users is used.
> As a result, when setting:
> - scaling_max_freq
> - boost
> The last sysfs file used overwrites the request from the other
> sysfs file.
> 
> To avoid this, create a per-policy boost_freq_req to save the boost
> constraints instead of overwriting the last scaling_max_freq
> constraint.
> 
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> In the existing .set_boost() callbacks:
> - Don't update policy->max as this is done through the qos notifier
>   cpufreq_notifier_max() which calls cpufreq_set_policy().
> - Remove freq_qos_update_request() calls as the qos request is now
>   done in policy_set_boost() and updates the new boost_freq_req
> 
> $ ## Init state
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> $ echo 1 > ../boost
> scaling_max_freq:1200000
> cpuinfo_max_freq:1200000
> 
> $ echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> $ ## Final step:
> $ ## Without the patches:
> $ echo 0 > ../boost
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ ## With the patches:
> $ echo 0 > ../boost
> scaling_max_freq:800000
> cpuinfo_max_freq:1000000
> 
> Note:
> cpufreq_frequency_table_cpuinfo() updates policy->min
> and max from:
> A.
> cpufreq_boost_set_sw()
> \-cpufreq_frequency_table_cpuinfo()
> B.
> cpufreq_policy_online()
> \-cpufreq_table_validate_and_sort()
>   \-cpufreq_frequency_table_cpuinfo()
> Keep these updates as some drivers expect policy->min and
> max to be set through B.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/amd-pstate.c   |  2 --
>  drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
>  drivers/cpufreq/cpufreq.c      | 52 +++++++++++++++++++++++++++-------
>  include/linux/cpufreq.h        |  1 +
>  4 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c45bc98721d24..310d5938cbdf6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	else if (policy->cpuinfo.max_freq > nominal_freq)
>  		policy->cpuinfo.max_freq = nominal_freq;
>  
> -	policy->max = policy->cpuinfo.max_freq;
> -
>  	if (cppc_state == AMD_PSTATE_PASSIVE) {
>  		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>  		if (ret < 0)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9eac77c4f2944..4c46c7ea318eb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -	int ret;
>  
>  	if (state)
> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>  	else
> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index db414c052658b..e4f24754df164 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  	policy->boost_enabled = enable;
>  
>  	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>  		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	if (ret < 0) {
> +		policy->boost_enabled = !policy->boost_enabled;
> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,
> @@ -1370,6 +1379,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  		freq_qos_remove_request(policy->max_freq_req);
>  	}
>  
> +	if (policy->boost_freq_req)
> +		freq_qos_remove_request(policy->boost_freq_req);
> +
>  	freq_qos_remove_request(policy->min_freq_req);
>  	kfree(policy->min_freq_req);
>  
> @@ -1439,12 +1451,15 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>  
>  	if (new_policy) {
> +		unsigned int req_nr;
> +
>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
>  			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>  		}
>  
> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> +		req_nr = policy->boost_supported ? 3 : 2;
> +		policy->min_freq_req = kzalloc(req_nr * sizeof(*policy->min_freq_req),
>  					       GFP_KERNEL);
>  		if (!policy->min_freq_req) {
>  			ret = -ENOMEM;
> @@ -1479,6 +1494,27 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  			goto out_destroy_policy;
>  		}
>  
> +		if (policy->boost_supported) {
> +			policy->boost_freq_req = policy->max_freq_req + 1;
> +
> +			/*
> +			 * If boost is supported,
> +			 * init the constraint with cpuinfo.max_freq.
> +			 */
> +			ret = freq_qos_add_request(&policy->constraints,
> +						   policy->boost_freq_req,
> +						   FREQ_QOS_MAX,
> +						   policy->cpuinfo.max_freq);
> +			if (ret < 0) {
> +				/*
> +				 * So we don't call freq_qos_remove_request() for an
> +				 * uninitialized request.
> +				 */
> +				policy->boost_freq_req = NULL;
> +				goto out_destroy_policy;
> +			}
> +		}
> +

Something we discussed before has resurfaced here. CPUFREQ_REMOVE_POLICY
notification will be sent without sending CPUFREQ_CREATE_POLICY
notification before if adding boost_freq_req fails.

What about adding boost_freq_req before adding min_freq_req and removing it
after removing min_freq_req?

>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
>  	}
> @@ -2782,16 +2818,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>  		return -ENXIO;
>  
>  	ret = cpufreq_frequency_table_cpuinfo(policy);
> -	if (ret) {
> +	if (ret)
>  		pr_err("%s: Policy frequency update failed\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 0465d1e6f72ac..c292a6a19e4f5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>  	struct freq_constraints	constraints;
>  	struct freq_qos_request	*min_freq_req;
>  	struct freq_qos_request	*max_freq_req;
> +	struct freq_qos_request *boost_freq_req;
>  
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;

