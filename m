Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F43CF670;
	Thu, 23 Apr 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928384; cv=none; b=H1i7vXhZf1UELfmW4YCda+zUnqaR4e05cOsItuhfaAr8DsUakLsRQNutGtChfxePKmU2brMZc8lCH7LgFQ9RRIN427hxLuD3iWcMB3mMPbUIEIG9DVDWg31hK9n3JWKgj8AiaoNFg8MY8bwCyvOIIXLwZkvycGGyrOnPIGdXggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928384; c=relaxed/simple;
	bh=48H9bJzKWEzHrVeI7vLzTJ7TOKuxphhSyyOmNJVICVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s0wQoM0v+svaR9BQj8Wu2U8xMRmUCt+7BVPRbR4YFZ94PIc265xYq4d8B1NEMUUDDk+ZNaEAr7fqCgxpTwGcFUHHYoNlCGKhflsBvqIuUBBywrmT1BkGYHPWEt+2pzTcEufdokbnC6DD0I8fGzmqjzqQNZtDnMS8ZeyFSNxXscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nG9gMGRK; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nG9gMGRK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zobzh/1xVAeLGdUYflkBc/b2ikGCXebRIw/Y0u0Tlfs=;
	b=nG9gMGRKTnnsbu9LiJIOFQxCRTuyWuLKreXCP+tRSWcNLzIzd5AzIg9/no6KHlkdu7UsdXcS2
	B+7gu18Xy27ujHEHmbuI5cFPpGYmgr8krMmmBu083eaMGvk/uzDo/WMdy4mWvpT4QaQBx8nbDoA
	+cAQyYLFvDbyYkfn3v5bdQE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g1Rw92KjCzKm4w;
	Thu, 23 Apr 2026 15:06:33 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8E240571;
	Thu, 23 Apr 2026 15:12:58 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Apr
 2026 15:12:57 +0800
Message-ID: <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
Date: Thu, 23 Apr 2026 15:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <stratosk@semaphore.gr>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 4/23/2026 1:39 PM, Zhongqiu Han wrote:
> On 4/21/2026 8:35 PM, Lifeng Zheng wrote:
>> In cs_dbs_update(), the requested frequency is decremented by one freq_step
>> for each idle period. However, this can cause divergence between
>> 'requested_freq' (target for current update) and 'dbs_info->requested_freq'
>> (target from previous update).
>>
>> When the load crosses up_threshold or down_threshold, the decision on
>> whether to increase or decrease frequency should be based on the *previous*
>> target (dbs_info->requested_freq), not the current one. Otherwise, the
>> update step may be skipped entirely if the current target has already hit a
>> boundary due to prior adjustments.
>>
>> Ensure that frequency scaling decisions are made using the correct
>> historical target, fixing cases where frequency fails to decrease despite
>> sustained idle periods.
>>
>> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> Hi Lifeng,
> Thanks for the patch.
> 
> May I know would this ignore conservative idle decay when the previous
> requested frequency was policy->max?
> 
> 
> Scenario: Increase path, previous target at max, with idle
> compensation; the original code does not have the same behavior as the
> current patch.
> 
> Initial state:
>   policy->max               = 2000 MHz
>   policy->min               = 200 MHz
>   dbs_info->requested_freq  = 2000 MHz  (= policy->max)
>   hardware frequency        = 2000 MHz
>   idle_periods              = 2
>   load                      = 90% (> up_threshold=80)
> 
> 1.Original code
> Step 1: requested_freq = dbs_info->requested_freq = 2000
> 
> Step 2: [idle_periods block]
>         freq_steps = 2 * 100 = 200
>         2000 > (200 + 200) = 400 ?  YES
>         requested_freq = 2000 - 200 = 1800
> Step 3: [increase path]
>         if (requested_freq == policy->max)
>           -> 1800 == 2000 ?  NO  -> fall through
> 
> Step 4: requested_freq += freq_step
>         requested_freq = 1800 + 100 = 1900
> 
> Step 5: __cpufreq_driver_target(policy, 1900, HE) -> hardware = 1900 MHz
> Step 6: dbs_info->requested_freq = 1900
> 
> Result: hardware 2000 -> *1900 MHz* (net 1-step decrease)
> 
> 
> 2.Current Patch
> Step 1: requested_freq = 2000
> Step 2: [idle_periods block] -> requested_freq = 1800
> Step 3: if (dbs_info->requested_freq == policy->max)
>           -> 2000 == 2000 ?  YES  -> goto out
> Step 4: hardware stays at 2000 MHz, dbs_info->requested_freq stays at 2000
> 
> Result: hardware stays at *2000 MHz* (no change)
> 
> 

Yes, I think you are right. The behaviors are not the same. I modified this
just in order to keep it consistent with the case exceeding down_threshold.
I'm not sure if this change of behavior is reasonable. Perhaps Rafael or
Viresh could give us some advice.

> 
> 
>> ---
>>   drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
>> index df01d33993d8..f3c3b54e4bf8 100644
>> --- a/drivers/cpufreq/cpufreq_conservative.c
>> +++ b/drivers/cpufreq/cpufreq_conservative.c
>> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>           dbs_info->down_skip = 0;
>>             /* if we are already at full speed then break out early */
>> -        if (requested_freq == policy->max)
>> +        if (dbs_info->requested_freq == policy->max)
>>               goto out;
>>             requested_freq += freq_step;
>> @@ -127,7 +127,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>>           /*
>>            * if we cannot reduce the frequency anymore, break out early
>>            */
>> -        if (requested_freq == policy->min)
>> +        if (dbs_info->requested_freq == policy->min)
>>               goto out;
>>             if (requested_freq > freq_step)
> 
> 

