Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF031F986;
	Tue,  3 Mar 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539424; cv=none; b=IfeLgut4hZ3iHxrWOa3044oKyoYCrPVX5OxfWVbyE65gNTkilthrRTAdHuqWXp0f+7Xk0IVIj76150f+N8y/TVC9+YpDi/nQwChphvMquciMeZIkDYsAjA8xGh1OGEiizzcSzIY4fOZnsPIbmO0O2K64OZuOeDAWTqhPEOAeGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539424; c=relaxed/simple;
	bh=TqatppKJ8/sSOqaB9V9U7v66SprShwvtMtSnJwrs7sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e5bqKU5hZ+UiRZ5QzK4WxJtJyPtHybuEwWqnub9W1qJf151TsBKi/OTjvmKFz9qTazV+8f904pfdRhFo8XysTh7hwDGH4VK9mEKkCqyjx+4iCo7kodVHQdrEISefrYOLWx2G5C75hOpHuZyZu0vAjQWrVwvwkwP4H+p3ocGe2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=k689BAgV; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="k689BAgV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T1z2JGVSris9ggGYp/iPgLJUtlSMEdRWvCGyzfP+AsA=;
	b=k689BAgVLs9sJv29hSwiJuvaJnZbjp5h76i2RVrl0drHggP6H3BUz+no7zijMwoF0BN4/M7zi
	5Gbgre3iHaRtL5muO+im4aitazEw0S6TSH357aMixgyVj+uIhIS/WXIcjNJ742pRd45sfCLjA8q
	7Cf3Ev6ugXrxgAHRVWkILIY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fQDpp243XzpStt;
	Tue,  3 Mar 2026 19:58:42 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2645F40569;
	Tue,  3 Mar 2026 20:03:40 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 20:03:39 +0800
Message-ID: <54f5795f-2c0b-49f2-a319-216c17657c0f@huawei.com>
Date: Tue, 3 Mar 2026 20:03:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20260213100633.15413-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Just a gentle ping on this patch.
Thanks, Pengjie

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
>    - Renamed the patch subject to better reflect the logic change.
>    - Updated the commit log to clarify ACPI spec details.
> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e8042efedd1..4a3031d9fcf4 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
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
