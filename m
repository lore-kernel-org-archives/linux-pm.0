Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23382D8793;
	Thu, 12 Mar 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314002; cv=none; b=l/2MkA1lr9dMpNvi5YrOvqmweGFRhQ/wlgRh6+YF0IeBeXPAhz+QkFbek1SQOnDTBBjhKUXIC3RpZk2wyh9dR9ulzMOtxswfR/EARwDgmtvLaG/YUpxa7mbVtBnJRuESAySI58XqkX3R19MG5zkTr6Nd8UfcApzqrPsw0Dcr1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314002; c=relaxed/simple;
	bh=2KUE7EsG+WRvUC9MLvugYCiGW72Sle7TBQI++GRtb6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s9PkO8sz6RNN7MRcSa3wtJyy2oXpsUNY4w+w3W8IbSI8T8//KsXJ07SNYj6OxH/VpgmAdUjy6FTQ/EBnQBwfDmLomOorukIq9e520ouDdo+neeflZEcN026/Aef2Tm2juAguuHENfkdtITeU/tioRLGicRb3cW/dMtbSKTjeXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KhJCS7rj; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KhJCS7rj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vYXmomo0ZKZHtLIaHpBOrUsfsxn0npDVGnzLe8GKiIg=;
	b=KhJCS7rju3eddBQf+QSALq0qwN5kgzAwrDSTRocrU7F/9aa5C9wyt0tgG5lNnKCFHhcXHQpIh
	qIEXJtF/a8hPRuYg0KcI2O+L5AD0r//ZhOOt99bEahB8W+5p6ZMWQKqfzgsj5GL2bGF+4nsYP3h
	nR3UVwx4FRK68WbN+w/kuNw=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fWlFn6fCmznTVr;
	Thu, 12 Mar 2026 19:07:41 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 1592740561;
	Thu, 12 Mar 2026 19:13:17 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 19:13:16 +0800
Message-ID: <2edc5f50-896d-410b-95a1-04a55cd3e12f@huawei.com>
Date: Thu, 12 Mar 2026 19:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/10/2026 2:34 PM, Viresh Kumar wrote:
> A recently reported issue highlighted that the cached requested_freq
> is not guaranteed to stay in sync with policy->cur. If the platform
> changes the actual CPU frequency after the governor sets one (e.g.
> due to platform-specific frequency scaling) and a re-sync occurs
> later, policy->cur may diverge from requested_freq.
> 
> This can lead to incorrect behavior in the conservative governor.
> For example, the governor may assume the CPU is already running at
> the maximum frequency and skip further increases even though there
> is still headroom.
> 
> Avoid this by dropping the cached requested_freq and using
> policy->cur directly.
> 
> Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Lifeng Zheng, can you please give this a try and provide your Tested-by as well
> ?

I tested it on our platform, and the behavior is as expected.

Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>

> 
>  drivers/cpufreq/cpufreq_conservative.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index e0e847764511..c69577e4f941 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -14,7 +14,6 @@
>  struct cs_policy_dbs_info {
>  	struct policy_dbs_info policy_dbs;
>  	unsigned int down_skip;
> -	unsigned int requested_freq;
>  };
>  
>  static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
> @@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  {
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
> -	unsigned int requested_freq = dbs_info->requested_freq;
>  	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int load = dbs_update(policy);
> +	unsigned int requested_freq = policy->cur;
>  	unsigned int freq_step;
>  
>  	/*
> @@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  	if (cs_tuners->freq_step == 0)
>  		goto out;
>  
> -	/*
> -	 * If requested_freq is out of range, it is likely that the limits
> -	 * changed in the meantime, so fall back to current frequency in that
> -	 * case.
> -	 */
> -	if (requested_freq > policy->max || requested_freq < policy->min) {
> -		requested_freq = policy->cur;
> -		dbs_info->requested_freq = requested_freq;
> -	}
> -
>  	freq_step = get_freq_step(cs_tuners, policy);
>  
>  	/*
> @@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  
>  		__cpufreq_driver_target(policy, requested_freq,
>  					CPUFREQ_RELATION_HE);
> -		dbs_info->requested_freq = requested_freq;
>  		goto out;
>  	}
>  
> @@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  
>  		__cpufreq_driver_target(policy, requested_freq,
>  					CPUFREQ_RELATION_LE);
> -		dbs_info->requested_freq = requested_freq;
>  	}
>  
>   out:
> @@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
>  	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
>  
>  	dbs_info->down_skip = 0;
> -	dbs_info->requested_freq = policy->cur;
>  }
>  
>  static struct dbs_governor cs_governor = {

