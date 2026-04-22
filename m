Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0133AEF51;
	Wed, 22 Apr 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847016; cv=none; b=NLhW4YXTtz+NRwmcf8EMG7nT/w+XGdfKcDYqZAegXO1YpPrMuHs/jIRkRm7Zzdyprorf0EJCUXKhz+dfwvFrdloyDuulgnoTEz7ErlniqzntYWB00RNKcq/8j6PfGVtmOsuCoBI534u+qgbBkHt5bvntyieBQ4xNAqWYjASLa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847016; c=relaxed/simple;
	bh=dRkHk68ZCKngmM2GylkOU3Vv4VN7tYgqp/+niHyK0ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PRpxKdTOZs/LYIxFiHMRryCClTKkyFg8i/aKGGQtA8rHEMUrUOd+IuiZnFlLFu4fdiAuYoZBcM5bsIKcJ8UJHW72zPrc0jIcfEuwVe2OtwJB0eZU+JjdZEETCbvKdHcSbOTlQSN0UA73WJDbTm8q2+L4KGfHdgIfbS+ftcdRjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yxxdM6u7; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yxxdM6u7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fPE+6/hM3lX/jxeD4CjyTxCiSfM5AXuRjPKQzCDxdRA=;
	b=yxxdM6u7KPtmahxhs5cNcoXkeUYkQaU7X4V6rjWUc9jUxfo26eDXeaT8oe93Dh0Unq7K/70F6
	Ya7F3dUYDqRY7nRfiJJCWjys7kcoKGcqT8tIgZV/nSOCq5aw4MIlJh0Pusfi/NTmyP4gJ3za7lR
	DrWE6CyZxQ7qmdR6Tsh9Xho=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g0sqH5Rwrz1prNH;
	Wed, 22 Apr 2026 16:30:19 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 262B740538;
	Wed, 22 Apr 2026 16:36:45 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Apr
 2026 16:36:44 +0800
Message-ID: <fda670e5-30bd-4c82-9b86-2afbeeb7c8cb@huawei.com>
Date: Wed, 22 Apr 2026 16:36:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Stratos Karafotis <stratosk@semaphore.gr>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <2ca5b929-979e-4955-86a1-1987a9fee9c5@semaphore.gr>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <2ca5b929-979e-4955-86a1-1987a9fee9c5@semaphore.gr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 4/22/2026 4:06 PM, Stratos Karafotis wrote:
> Hi all!
> 
> I was struggling to see your point, but I think you are right.
> 
> The requested_freq could be equal to policy->min (due to idle periods)
> while the dbs_info->requested_freq could be greater than policy->min.
> So, in this case it breaks out early without the chance to further reduce the frequency, correct?

Yes. This is the case where problems arise.

> 
> Stratos Karafotis
> 
> On 4/21/26 15:35, Lifeng Zheng wrote:
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

