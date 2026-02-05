Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A339A7FA;
	Thu,  5 Feb 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292660; cv=none; b=EJlphBbgOZ4VWWvzmPqDrZ/IhHahafjzW+g4nq9KAEhCEjOj+z4TSjxhJHrjK5X5MF6c6gSTpcy8yUMjukLfRJjuf5dbQEXpiTkseTbQzEpTWRt81jopulTfZR7Hx9b+mdEtVttGVDXP1DhqeC8WqONe8sjKq7Udrrw4eQBGlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292660; c=relaxed/simple;
	bh=Q5C8A+Vo5/2JrMotwB/Ivj83eTy0b4+qoAX7GiI9lWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cDuHJnJkn+252UhgiS7zStgoy875rrKABwpMBDvhcQGnV2lGoTlxbBr2Q4z56MdmjqK+U9bEWnv9dDBRWjCtz+wAurh87FHLpP7n2VNjoH9+nqy4ns2bNiy//nqIbWRo32VpAdEvApTRGZCAEiRLN9nFIwCouYujXGDTkh5A1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vawMGDWn; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vawMGDWn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C2LhkuEc7FwuFvflLEQSEJ6R5VMb+AQsnN5+hiStT+A=;
	b=vawMGDWn6Bi32OsvY3DpAzrSwhPsfnWU02Nqd/Z/m797gYbLq0gnPT5I5QiGqf/2ZpqG6eHLm
	ZgUmSZWCKwsV0TgtX5TiWx1iqZssnuRU0rCOtdNHGS/mHd9im7iWFyV8j6fKFJjjQ2hQP/Fnuzg
	xaXY8iWMfTNPMOYgt/NPqag=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4f6FwF6zWhzRhRM;
	Thu,  5 Feb 2026 19:53:01 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 40D254056B;
	Thu,  5 Feb 2026 19:57:36 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 19:57:35 +0800
Message-ID: <770cdb73-9538-45cc-824a-d5939834b680@huawei.com>
Date: Thu, 5 Feb 2026 19:57:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: Use lowest_nonlinear_perf as a soft
 minimum limit
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260116094555.2978887-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20260116094555.2978887-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Gentle Ping.

Thanks!

On 1/16/2026 5:45 PM, Pengjie Zhang wrote:
> The ACPI 6.5 specification describes "Lowest Performance" as the absolute
> lowest performance level of the platform. It notes:
>
> "Selecting a performance level lower than the lowest nonlinear performance
> level may actually cause an efficiency penalty, but should reduce the
> instantaneous power consumption of the processor. In traditional terms,
> this represents the T-state range of performance levels."
>
> Currently, the cpufreq core initializes the minimum QoS request to 0.
> While this allows userspace to modify limits, it causes the CPU frequency
> to drop below lowest_nonlinear_perf by default. This hurts performance with
> negligible power savings.
>
> To fix this, implement a "soft" limit in cppc_verify_policy(). If the
> policy minimum is still the default (0), it is clamped to
> lowest_nonlinear_perf. However, if userspace has explicitly set a lower
> limit, that configuration takes precedence.
>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9eac77c4f294..59aa1721438b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -301,9 +301,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   	return target_freq;
>   }
>   
> -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>   {
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
>   	return 0;
>   }
>   
