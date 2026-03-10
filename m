Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA640DFD0;
	Tue, 10 Mar 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148411; cv=none; b=d8UvqdDjWT17FfvIH8dUBAOZLN6kBX2cvsvHaQgO+zcvFK1xy+z+Hb4Qy3d0a/+OJ32mhNpJ68agmMvvyLWDBP1vSxBgWcak3QiNxoXYlUqCsx8e+yYviLJZUf8pT+wZuZOvYyJ3BIFQOIbfTWhjnj46QH2wbKfhIuJCplii76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148411; c=relaxed/simple;
	bh=HCvg78CJB1QyYE4Rr3r/0Y4VOwSgZDPjHMs+gyPnAfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KV8R5xyMFEQPQLpvnhn08dW19TCTodnyXVn8F14AawPd1T7tj6lwQDQoAgaFFOi+7b/tQhVvIvTMe/VvWcYXS3abMbeWtp1sF+jQrqOiI7h43Btywstnig/V+n04zachabMWF1A4p9DpZaoUL4lHZfU4kPAx79R5byg2MwFSSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z08Dz3pk; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z08Dz3pk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=plJr4sh1ONuFNOZ9OrnnrllhPbh8zGxDexo0P4logiQ=;
	b=z08Dz3pk7Dfq0gCoQfJdrDhLGIKMbiERb6e8Vkf9AtA6JHjAGk79TRGfwRlTCRjle5c57UhFP
	G0vmjKwnm+Utf2bQ8TqndfixXE+f0CkPaFmfC5betnVytPj9mpwt7j5EkMYR8GCOZwtt8GioxzN
	64S3zOzaBFpaMgI0DPswP80=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fVZ284CtMz1cyNq;
	Tue, 10 Mar 2026 21:08:32 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE2E40562;
	Tue, 10 Mar 2026 21:13:27 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 21:13:26 +0800
Message-ID: <c99b362b-86a4-45cd-ad81-777a392abf9a@huawei.com>
Date: Tue, 10 Mar 2026 21:13:26 +0800
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Sure. I will test it in the next few days.

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

