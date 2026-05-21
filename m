Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6473AC0C8;
	Thu, 21 May 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362781; cv=none; b=MN81spL/aGWr0V+d9LyM6KaIiKd7W2iwcoHUNH0on3VlbhWgxOv5oJFif3qyDX/sPTo1FoC4fjtRsTINkhiK1A376UbZZsBr7xra1RJEMgSUQsFI2HMkD7j6/vTExcd+AL5xIJZ1fSaiwzze+g/VfF0dtExgn6e2ggNFHyzc2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362781; c=relaxed/simple;
	bh=F5ivitdu47V9DyWNdoSTTCf3jN3VTdTfnMDIaXUH0T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZepIbVUr+knrnR5R8Wx2QHCQl+GymUETH0rM6P7lWA6FZgVAoSAR9RQYwAQx65NA4hICDeTZUAe5cwJ1CnRpB7Z9O3HsDeDtxM2WYGFSnYzUK0F+4Vh13M7ZdwNgZZp+dxcwtKqE2H6i6ZouavCTxm02JnsAzhfBrSN8fPT9IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=h36F7SPP; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="h36F7SPP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7so2JjBPlPLcoVynX8Q4bTyEOxbr1x14Iqk3wRz/s88=;
	b=h36F7SPPSwENps7O98JR1fPl3YacFK3OPZeWlm/vMZ2LuhP84KZiRemuRPq13U864fUepAzLC
	rzCAIVxwXELszUrbDzwoghiXqdx48ImDWFegRboKs1LK1jJSkR9Ed2JnsjtKwQB5z1jReAADbtq
	qPVxX4t/Ujsgb4c+QjqMHJ4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gLmB017qzzLlYW;
	Thu, 21 May 2026 19:18:32 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id BFD5140563;
	Thu, 21 May 2026 19:26:13 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 21 May
 2026 19:26:12 +0800
Message-ID: <05a5a8a3-7153-460d-86f8-d2be04062d6b@huawei.com>
Date: Thu, 21 May 2026 19:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260511135538.522653-5-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/11/2026 9:55 PM, Pierre Gondois wrote:
> Consider policy->min/max being set in the driver .init()
> callback as a QoS request. Impacted driver are:
> - gx-suspmod.c (min)
> - cppc-cpufreq.c (min)
> - longrun.c (min/max)
> 
> Update the documentation accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
>  drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
> index c5635ac3de547..ab4f3c0f3a89b 100644
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>  |policy->cur			    | The current operating frequency of   |
>  |				    | this CPU (if appropriate)		   |
>  +-----------------------------------+--------------------------------------+
> -|policy->min,			    |					   |
> -|policy->max,			    |					   |
> +|policy->min			    | If set by the driver in ->init(),    |
> +|				    | used as initial minimum frequency	   |
> +|				    | QoS request.			   |
> ++-----------------------------------+--------------------------------------+
> +|policy->max			    | If set by the driver in ->init(),    |
> +|				    | used as initial maximum frequency	   |
> +|				    | QoS request.			   |
> ++-----------------------------------+--------------------------------------+
>  |policy->policy and, if necessary,  |					   |
>  |policy->governor		    | must contain the "default policy" for|
>  |				    | this CPU. A few moments later,       |
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9e2d9d3fc5351..9a005367ed87b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1399,8 +1399,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  
>  static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>  {
> +	unsigned int min_freq, max_freq;
>  	int ret;
>  
> +	/* Use policy->min/max set by the driver as QoS requests. */
> +	min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +	if (policy->max)
> +		max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +	else
> +		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
> +

Can't see the point of this. Why not just use policy->max and policy->min
to init qos?

>  	/*
>  	 * If the driver didn't set policy->min/max, set them as
>  	 * they are used to clamp frequency requests.
> @@ -1418,12 +1426,12 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>  	}
>  
>  	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
> -				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
> +				   FREQ_QOS_MIN, min_freq);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
> -				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
> +				   FREQ_QOS_MAX, max_freq);
>  	if (ret < 0)
>  		return ret;
>  

