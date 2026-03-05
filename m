Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70282EC0B4;
	Thu,  5 Mar 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710456; cv=none; b=XvHX7I6hPS0IQQhBMpu1CHcgT0LZ+Ez6seYaSuJEIVqozfZfPIoIN0Wt36nYM+rJ4nqrtGTqTxsgFiiVYcUuVymS1N+Dls/nWipWAYeecTaCENwo5kWfMlj+MbNf7LFn7GpQ7NEcFjEfgVFT0bpB53Nxd/TnB1rKcSrfJSBPyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710456; c=relaxed/simple;
	bh=CtxP/WDi95HfQTpUk5jIw4UGNeO/T/JWy2nMZVx8AVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PQthk6Mg4HdrPSISjlVw4jVxmx9DoBEYT1D9sZac5ZbL6D8y1dDfsDnIFgYutcHd3EH5wVI94+w/mc4UzOotYmZ0X6/btWTRxM63GQG2u9AtoIhbGDU7lgQH8psvhqdehyPYzTgZ0xIBATCNatMDFBDvCRpZIYw1lc8QaOb0bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WZ9vSujy; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WZ9vSujy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PLGXUjQcjY7LoooqcaDiMb1VIB2EmPYPv4aBjs0Oz3o=;
	b=WZ9vSujyuHbl13DnHs+oza27Lqt7MGyKZwDJ9MLx6dUe8JG4WMQNgM+uv1Xfh60Cqm09loOjp
	PEcpeYb4xWs9Hnx7riSyrj5s8N/S5QikBXXH6D4qh+mxeMK5M8Apf0ZlnGg7oIZplE6HrjoMwUJ
	Sgwi4406WoEhTaqgeuerIwA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fRS3d0hDKz1T4Hg;
	Thu,  5 Mar 2026 19:29:01 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 40AF92022B;
	Thu,  5 Mar 2026 19:34:04 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 19:34:03 +0800
Message-ID: <e4026452-ac1f-4be5-9253-a51ee9e0d9e2@huawei.com>
Date: Thu, 5 Mar 2026 19:34:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Pengjie Zhang <zhangpengjie2@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260213100633.15413-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
> linear performance scaling. Performance levels below this threshold
> are typically inefficient and should not be used by default.
> 
> Currently, the QoS minimum request is initialized to 0. This defaults
> the performance floor to the absolute "Lowest Performance" state
> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
> an inefficient range unnecessarily.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
>   - Renamed the patch subject to better reflect the logic change.
>   - Updated the commit log to clarify ACPI spec details.
> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e8042efedd1..4a3031d9fcf4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  	return target_freq;
>  }
>  
> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>  {
> -	cpufreq_verify_within_cpu_limits(policy);
> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +					      cpufreq_cpu_get(policy_data->cpu);
> +		struct cppc_cpudata *cpu_data;
> +
> +		if (!policy)
> +			return -EINVAL;
> +
> +		cpu_data = policy->driver_data;
> +		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
> +			cpu_data->perf_caps.lowest_nonlinear_perf);
> +	}
> +
> +	cpufreq_verify_within_cpu_limits(policy_data);
> +
>  	return 0;
>  }
>  

