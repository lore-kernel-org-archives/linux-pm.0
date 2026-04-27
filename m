Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0566351C31;
	Mon, 27 Apr 2026 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259339; cv=none; b=Z+lVpzDEEKNYUgnLfiQ+VwCk3xW1vpOP5j9A9Rb1us1UnUxnqiimUxFe19nYTDb54F0hAZS5qc5Fd20UO9gCU8I3OZEIQZbGwkVBz4Csi/LlBkzM37dLBS92AJuTI7gFREmSQirSeVEh1qBQiNcPcXOESRnPzBhBoijKb0ml1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259339; c=relaxed/simple;
	bh=zHbLmcD6jrQy+JfmXg22dxdVixNFfUvyr3eTnOt6LHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YPS5L/OTSz1igMYXMFZwgWx9h2w9oezjoKMqXPQcspd3uGNdMVAS+ADgeZskCm+GIcJuQbG+YMuKcW+RC4+b1kQuzsBDiCi6gbqXqOP6oMcW+N4wEZ3UM4Uszs43kDeGQ/UllQuCHG2ASIfZNrC+AA/4EkhrxhnrEybHJdVtDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g3pJg62TnzRhR4;
	Mon, 27 Apr 2026 11:02:27 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FFA340561;
	Mon, 27 Apr 2026 11:08:53 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Apr
 2026 11:08:52 +0800
Message-ID: <454ad628-b8c8-4a91-b678-f3338992a1a9@hisilicon.com>
Date: Mon, 27 Apr 2026 11:08:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Huang Rui
	<ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Perry
 Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260423084731.1090384-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200017.china.huawei.com (7.202.181.10)


Hi Pierre,

Thanks for updating this.
A few questions inline.

Regards,
Jie

On 4/23/2026 4:47 PM, Pierre Gondois wrote:
> cpufreq_set_policy() will ultimately override the policy min/max
> values written in the .init() callback through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
> 
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
Just a check, you mean this is the only place that policy->min/max set by
driver->init() may ever be actually used, right?
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-__cpufreq_driver_target()
>     \-cpufreq_driver->target()
cpufreq_init_policy() doesn't seem to be involved here?
It's supposed to be:
cpufreq_policy_online()
\-__cpufreq_driver_target() /* CPUFREQ_NEED_INITIAL_FREQ_CHECK branch */
  \-cpufreq_driver->target()
> is called. To avoid any regression, set policy->min/max in cpufreq.c
> if the values were not initialized.
> 
> In this patch:
> - Setting policy->min or max value in driver .init() cb is
>   interpreted as setting a QoS constraint.
> - Remove policy->min/max initialization in drivers if the values
>   are similar to policy->cpuinfo.min_freq/max_freq.
Why is this necessary?
Doing this will touch many drivers.
Is this mainly for cleaning up? or is there any bugs if we directly take
the existing policy->min/max initialized by drivers (mostly equal to
cpufreq_min/max_freq) as QoS constraints?
>   The only drivers where these values are different are:
>   - gx-suspmod.c
>   - cppc-cpufreq.c
>   - longrun.c
> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>   used as a min QoS constraint as suggested at:
>   https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>  drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>  drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>  drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>  drivers/cpufreq/freq_table.c      |  7 +++----
>  drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>  drivers/cpufreq/intel_pstate.c    |  3 ---
>  drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>  drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>  drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>  drivers/cpufreq/virtual-cpufreq.c |  5 +----
>  11 files changed, 51 insertions(+), 39 deletions(-)
> 
[...]
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>  
>  	if (new_policy) {
> +		unsigned int min, max;
> +
> +		/* Use policy->min/max set by the driver as QoS requests. */
> +		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +		if (policy->max)
> +			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +		else
> +			max = FREQ_QOS_MAX_DEFAULT_VALUE;
Is it practical (free of bugs) to set the default policy->min/max to
FREQ_QOS_MIN/MAX_DEFAULT_VALUE in cpufreq_policy_alloc(), and keep drivers
initializing policy->min/max?

Such that we may only need to change the following two lines of
FREQ_QOS_MIN/MAX_DEFAULT_VALUE to policy->min/max in this function, without
adding the other two trunks.
>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
>  			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		ret = freq_qos_add_request(&policy->constraints,
>  					   &policy->min_freq_req, FREQ_QOS_MIN,
> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
> +					   min);
>  		if (ret < 0)
>  			goto out_destroy_policy;
>  
>  		ret = freq_qos_add_request(&policy->constraints,
>  					   &policy->max_freq_req, FREQ_QOS_MAX,
> -					   FREQ_QOS_MAX_DEFAULT_VALUE);
> +					   max);
>  		if (ret < 0)
>  			goto out_destroy_policy;
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> +
> +		/*
> +		 * If the driver didn't set QoS constraints, policy->min/max still
> +		 * need to be set as they are used to clamp frequency requests.
> +		 */
> +		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
> +		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {
[...]
