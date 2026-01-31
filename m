Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7729A9E9;
	Sat, 31 Jan 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832709; cv=none; b=P/hD+40F3I/BtiM4LT0eTbbHJu/8IOp32mIor46TQhviYp+/QahWgo+rPGPkbYBvN3BRsZkINjFw/qY73GaTM/KIxHrVQSxQIB+T/c1sZ5Zmy4MtKqmJfOUZKccUf9bH8VRnXbeBD73JpRzHdg8jlFAnKjNCy7VC6wXhqJV5FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832709; c=relaxed/simple;
	bh=3QmaHGUpK/5Dr1vNhGToNvgUZHe0dhfqTqjTABS0XYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SmLpS8vUHzxroL+5svJCDrcdkQ3ADXa8zocEKPOXd8RQO7QB0TFNwn3JaWq3yc106a8LK73rYWwPxyA5JzDDtYXwqjn8dSbDZQyuICEV6lTlAUN1a2JI6d8TroslruIynTO6+qnQFAqTL5KWmBbdS4zLncZzq+6jJBxHovpS4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JL3Kzodp; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JL3Kzodp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N9fsJKZpl6Me1Z2L51A8qsdRCMOK7XGaWywH4OLHeNQ=;
	b=JL3KzodpgpiqHyUY9gppAc8/O6WmDMIImSVOuCkDE3RKmQ+3SoNQZPA1EDuzgok9fhhUhaEJe
	iGHboAygyF0emve3kw9Xlxchm2hlVSTH79SUYEiJsFU/A/Gm08s4KdTr+qBp2m/tnHLDOab0W+2
	0w3AzsHWOlY3dLrPsIYrIxw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2zqk4XgWznTV8;
	Sat, 31 Jan 2026 12:07:46 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E5EB54048B;
	Sat, 31 Jan 2026 12:11:38 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Jan
 2026 12:11:38 +0800
Message-ID: <5cbc4987-f2b5-4dc4-8b90-c7aca60e6574@huawei.com>
Date: Sat, 31 Jan 2026 12:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] cpufreq: Centralize boost freq QoS requests
To: Pierre Gondois <pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, Christian Loehle <christian.loehle@arm.com>,
	<sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, <linux-pm@vger.kernel.org>
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-4-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260126101826.94030-4-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/26 18:18, Pierre Gondois wrote:
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c8fb4c6656e94..505da5b00e575 100644
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
> +		cpufreq_driver->set_boost(policy, !policy->boost_enabled);

!policy->boost_enabled twice.

> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,

