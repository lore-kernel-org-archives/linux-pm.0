Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0C28F5;
	Mon, 30 Mar 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854987; cv=none; b=ZimcbLesZsigfMlk4SZSBmrQW8+LXo53lEMBqLfoquJLTbUyw39c6QfwdOtbITrf3cVGRE5PlSIXnthU406Wh598TxVTyNt+Bbug+N/WNVkkkTlW8157KBwIwFefnTjeCVi7y1Yy3FH78krx8qmuXmpBxINZRWuvQT15Yc2KOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854987; c=relaxed/simple;
	bh=Q0DWnnMr7ffrrRHodB3MY//iuO+n8UD07I1pRCyDpUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=riQcAh8OYzew6VxZCJXHVlqH1doOL3RWmIzJkfntLRq4SxQl0y0zkppBY0WrJDq2gNgoSr3R2Xw8tnhk3z2AVZIoFltqLJOh2H43Xx1+igyLnU/3RhlVHsbiMwrIctGUDnQn6MUjz/7mqWN1/RJthnq3DhwihP8dU2UVyMbAxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oOM/nEAJ; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oOM/nEAJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zwz3Ar4tKURMUCbHGclgud78g2XsJp5xsF60cvunYrc=;
	b=oOM/nEAJyqTxPbcNl4O7Rw3yi6n/T+dgKQ5vbqK2G5x1e8dyvyWZA0GJFrDsY+RUgDomvk5IT
	yGv1Q/L75RsNyjwTdQUTEz7tJFtwkvNtdveFlQOTx7NxMkrqcCtDPiDfEWCzeYC4Zy4SvCKv9N6
	ySdTpCGa/aMrxWzePbX59PQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fkj7L4Y1JzKmSw;
	Mon, 30 Mar 2026 15:10:06 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 09CB740561;
	Mon, 30 Mar 2026 15:16:17 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Mar
 2026 15:16:16 +0800
Message-ID: <6cd973e4-5df5-47b0-86d5-1552f8ba8d2e@huawei.com>
Date: Mon, 30 Mar 2026 15:16:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Pierre Gondois
	<pierre.gondois@arm.com>, <linux-kernel@vger.kernel.org>
CC: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
 <f61f81ff-7e42-414e-a196-d20f8717f5f7@huawei.com>
 <6eff4517-cc4b-4f2f-8e39-6cfe8b18c4dc@oss.qualcomm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <6eff4517-cc4b-4f2f-8e39-6cfe8b18c4dc@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/30/2026 12:00 PM, Zhongqiu Han wrote:
> On 3/30/2026 10:10 AM, zhenglifeng (A) wrote:
>> On 3/29/2026 5:00 PM, Zhongqiu Han wrote:
>>>> @@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>>        }
>>>>          freq_qos_remove_request(policy->min_freq_req);
>>>> +    freq_qos_remove_request(policy->boost_freq_req);
>>>>        kfree(policy->min_freq_req);
>>>>          cpufreq_policy_put_kobj(policy);
>>>> @@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>>        cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>>>          if (new_policy) {
>>>> +        unsigned int count;
>>>> +
>>>>            for_each_cpu(j, policy->related_cpus) {
>>>>                per_cpu(cpufreq_cpu_data, j) = policy;
>>>>                add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>>>            }
>>>>    -        policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>>>> +        count = policy->boost_supported ? 3 : 2;
>>>> +        policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>>>>                               GFP_KERNEL);
>>>>            if (!policy->min_freq_req) {
>>>>                ret = -ENOMEM;
>>>>                goto out_destroy_policy;
>>>>            }
>>>>    +        if (policy->boost_supported) {
>>>> +            policy->boost_freq_req = policy->min_freq_req + 2;
>>>> +
>>>> +            ret = freq_qos_add_request(&policy->constraints,
>>>> +                           policy->boost_freq_req,
>>>> +                           FREQ_QOS_MAX,
>>>> +                           policy->cpuinfo.max_freq);
>>>> +            if (ret < 0) {
>>>> +                policy->boost_freq_req = NULL;
>>>> +                goto out_destroy_policy;
>>>> +            }
>>>> +        }
>>>> +
>>>>            ret = freq_qos_add_request(&policy->constraints,
>>>>                           policy->min_freq_req, FREQ_QOS_MIN,
>>>>                           FREQ_QOS_MIN_DEFAULT_VALUE);
>>>>            if (ret < 0) {
>>>> -            /*
>>>> -             * So we don't call freq_qos_remove_request() for an
>>>> -             * uninitialized request.
>>>> -             */
>>>>                kfree(policy->min_freq_req);
>>>>                policy->min_freq_req = NULL;
>>>>                goto out_destroy_policy;
>>>
>>> Hi Pierre, Viresh,
>>>
>>> Sorry for the late follow-up on v8. While re-reading the patch, I
>>> noticed a potential UAF issue on an error path — I might be missing
>>> something, so I'd appreciate a double-check.
>>>
>>> min_freq_req, max_freq_req and boost_freq_req all point into the same
>>> contiguous kzalloc'd block:
>>>
>>> slot0 (min_freq_req + 0) -> min_freq_req
>>> slot1 (min_freq_req + 1) -> max_freq_req
>>> slot2 (min_freq_req + 2) -> boost_freq_req
>>>
>>> If boost_freq_req is successfully added to the QoS constraints list, but
>>> the subsequent freq_qos_add_request() for min_freq_req fails, the error
>>> path does:
>>>
>>> kfree(policy->min_freq_req); /* frees the entire block, including slot2
>>> */
>>> policy->min_freq_req = NULL;
>>> goto out_destroy_policy;
>>>
>>> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
>>> pointer into freed memory.
>>> cpufreq_policy_free() is then called from cpufreq_online() and does:
>>>
>>> freq_qos_remove_request(policy->boost_freq_req); /* UAF */
>>> or this boost qos req will leak.
>>>
>>
>> Good catch!
>>
>> How about remove the kfree() here and just leave it to
>> cpufreq_policy_free()?
>>
> 
> Thanks for the suggestion — this is another fix approach we can
> explore, but there seems to be a small caveat.
> 
> Some additional changes would still be needed; otherwise, removing the
> kfree() here and deferring it to cpufreq_policy_free() can lead to a
> warning.
> 
> The reason is that we neither free policy->min_freq_req nor set policy
> ->min_freq_req = NULL. As a result, when cpufreq_policy_free() later
> calls freq_qos_remove_request(policy->min_freq_req), it hits the
> following warning:
> 
> if (WARN(!freq_qos_request_active(req),
>     "%s() called for unknown object\n", __func__))
>     return -EINVAL;
> 

Therefore, it seems the only option is to allocate memory separately for
boost_freq_req.

