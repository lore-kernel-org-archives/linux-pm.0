Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920443C05F;
	Tue, 10 Mar 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133969; cv=none; b=psmdVXYgS3D4py9R/v+Bq7r/rZK1xQUQxMcYT+b6F+W3t+H7zeRgQElYuADGtavMwwg+fuNlTGERuRwrU9QBx4SLhSTsjHhYXyGQrlkQbSlbQscwmp8RkGOi5ic9mewNvLSCuAZC4K9/2zdgYceY5aO/mW+1eXnXTUIgF89CuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133969; c=relaxed/simple;
	bh=wqIlMKzHbeLa2OoNoGNRIVYy3H++sewT0B70UlNWsEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q6D/bFNpwnCIZBCcQyjxSXqzcDjXdFA5TpyzhuZsLc83XxnteZR0HsF7GVJAhezCTFXTu9quVbu1YATInTzy4nB5pg4mTHzFjPjK/xRiLvG3tqmMx0BrSnyM5VWxSd+VO99IBUxlmS5TNBGoO/ApOyyk+07z3PgE+PVuQvzNRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fVShG6mvTzLlsC;
	Tue, 10 Mar 2026 17:07:42 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 8990840565;
	Tue, 10 Mar 2026 17:12:37 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Mar
 2026 17:12:36 +0800
Message-ID: <ab94db5d-fbe0-4095-9a28-24055edcfdfa@hisilicon.com>
Date: Tue, 10 Mar 2026 17:12:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>, Pierre Gondois
	<pierre.gondois@arm.com>
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <cd08cee4-7923-459e-ad75-164c258a189e@hisilicon.com>
 <bdf22931-ec91-48e5-8050-ab4c899b5860@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <bdf22931-ec91-48e5-8050-ab4c899b5860@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 3/9/2026 9:16 PM, zhangpengjie (A) wrote:
> Hi Jie,
> 
> On 3/5/2026 9:49 PM, Jie Zhan wrote:
>>
>> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>>> linear performance scaling. Performance levels below this threshold
>>> are typically inefficient and should not be used by default.
>>>
>>> Currently, the QoS minimum request is initialized to 0. This defaults
>> I'm more curious on the original commit that overrides the policy->min set
>> by driver, which is:
>> 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS requests")
>>
>> The changelog says:
>> "The min and max frequency QoS requests in the cpufreq core are initialized
>> to whatever the current min and max frequency values are at the init time,
>> but if any of these values change later (for example, cpuinfo.max_freq is
>> updated by the driver), these initial request values will be limiting the
>> CPU frequency unnecessarily unless they are changed by user space via
>> sysfs."
>>
>> So, instead of doing what the patch did, what about calling
>> freq_qos_update_request(policy->max_freq_req, xxx) when cpuinfo.max_freq is
>> updated?
>>
>> Jie
> 
> Thanks for pointing this out.
> 
> I think commit 521223d8b3ec intentionally changed the semantics of the
> core min/max QoS requests so that they no longer reflect the initial
> policy limits set by the driver. Instead, they stay at the default
> "no constraint" values until user space (or another QoS client) updates
> them. That makes sense for the problem described in that changelog.
> 
> What my patch is trying to address is a slightly different issue in
> cppc_cpufreq: the driver currently treats `lowest_nonlinear_perf` as
> the default minimum policy floor, but with the current core semantics
> that floor is not represented explicitly and gets lost during policy
> initialization.
Yeah, the current status:
Setting 'policy->min' in driver->init() is pointless at the moment, while
some drivers are still doing it.  The effective place to set 'policy->min'
became driver->verify(), but a minor side effect by doing so is
'policy->min' can't be preserved on switching governors.
> 
> So I agree that calling freq_qos_update_request() when
> cpuinfo.min_freq/max_freq changes is the right approach for stale
> request updates, but I am not sure it addresses the question
> for `lowest_nonlinear_perf` itself:
I was talking about calling freq_qos_update_request() in commit
521223d8b3ec.
> 
> Should it be modeled as a hard driver constraint, or only as the
> default minimum policy value that user space may still lower explicitly?
> 
> My patch assumes the latter, although I agree the current implementation
> is not the cleanest way to express it.
> 
> Thanks,
>         Pengjie
> 
> 
Does [1] also solve this issue by chance? especially Patch 5.
If so, I think we may follow that up and get the framework to a sensible
shape.
[1] https://lore.kernel.org/linux-pm/20260225084930.1692228-1-pierre.gondois@arm.com/
>>> the performance floor to the absolute "Lowest Performance" state
>>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>>> an inefficient range unnecessarily.
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> ---
>>> Changes in v2:
>>>    - Renamed the patch subject to better reflect the logic change.
>>>    - Updated the commit log to clarify ACPI spec details.
>>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 7e8042efedd1..4a3031d9fcf4 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>       return target_freq;
>>>   }
>>>   -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>>   {
>>> -    cpufreq_verify_within_cpu_limits(policy);
>>> +    if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>> +        struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>> +                          cpufreq_cpu_get(policy_data->cpu);
>>> +        struct cppc_cpudata *cpu_data;
>>> +
>>> +        if (!policy)
>>> +            return -EINVAL;
>>> +
>>> +        cpu_data = policy->driver_data;
>>> +        policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>>> +            cpu_data->perf_caps.lowest_nonlinear_perf);
>>> +    }
>>> +
>>> +    cpufreq_verify_within_cpu_limits(policy_data);
>>> +
>>>       return 0;
>>>   }
>>>   
