Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63271DED5B;
	Fri, 24 Jul 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863518; cv=none; b=JtNvsYkc/sf9hu9B3XGjD4Dn/4lI9hRSzVh1kjqjVLkw/I4g7W60oB7Ptooqi70b+CxnOZaCExjqnFJ1PB7rjM8AmJVhF3SnoBH4Ux3o+W9YEldTWeJ74mHZXe+ab7TgoZBwb18RNz6dzTmmzoRuohVTc0CNdGvNfiNDcG8MooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863518; c=relaxed/simple;
	bh=8peOft9LPzaGLPBwSDoASiCKr0iRtmHAqi5DFDYf3Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHsKGfcHiXOeOPgycMe+7nPI8QCg4ykXo8jaPNb1r27qhf1IPfVp/KnnlhwPE3tMX9nvBXLaZ7Kd6FiRhGrPUZl7FOCax4CQaqM5DC/u+EQmYscMk/pSFyRPJwogw61OQRmBQAj1qDjzIgGEseDClTeHE8M/RriuWUzS44ws5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 441e0fbe870f11f1aa26b74ffac11d73-20260724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:34bac3b0-d428-48e4-ac62-7cc71e8a1555,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:552b9652fbf6123546a338d75d16fc38,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 441e0fbe870f11f1aa26b74ffac11d73-20260724
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1322349044; Fri, 24 Jul 2026 11:25:06 +0800
Message-ID: <12003c54-469b-43be-b818-6aeb87f2f04d@kylinos.cn>
Date: Fri, 24 Jul 2026 11:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cpuidle: cache aggregated governor latency QoS
 constraint
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org, lenb@kernel.org, pavel@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260721092324.17508-1-tianyaxiong@kylinos.cn>
 <20260721092559.18921-1-tianyaxiong@kylinos.cn>
 <cfea177c-b618-4cac-9a74-1a442353849a@arm.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <cfea177c-b618-4cac-9a74-1a442353849a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/23 20:44, Christian Loehle 写道:
> On 7/21/26 10:25, Yaxiong Tian wrote:
>> cpuidle_governor_latency_req() runs on every idle-state selection and
>> aggregates per-CPU resume latency with the global CPU latency and
>> wakeup latency QoS limits.  That path repeatedly walks get_cpu_device()
>> and pm_qos_read_value(), which shows up hot under menu_select().
>>
>> Cache the aggregated constraint per CPU and refresh it only when the
>> corresponding per-CPU generation changes.  The generation is already
>> bumped by the global and per-CPU resume latency QoS notifiers added
>> earlier in this series.
>>
>> On a menu governor profile, cpuidle_governor_latency_req() drops from
>> about 19.9% of menu_select time to about 4.2%, roughly a 6x reduction
>> in cost per call (~1.9 us down to ~0.3 us).
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   drivers/cpuidle/governor.c | 37 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
>> index d286ccf19a69..67909470c14b 100644
>> --- a/drivers/cpuidle/governor.c
>> +++ b/drivers/cpuidle/governor.c
>> @@ -32,11 +32,17 @@ struct cpuidle_governor *cpuidle_prev_governor;
>>    */
>>   static DEFINE_PER_CPU(atomic_t, latency_req_gen);
>>   
>> +struct cpuidle_latency_req_cache {
>> +	unsigned int gen;
>> +	s64 latency_ns;
>> +};
>> +
>>   struct cpuidle_cpu_qos_nb {
>>   	struct notifier_block nb;
>>   	unsigned int cpu;
>>   };
>>   
>> +static DEFINE_PER_CPU(struct cpuidle_latency_req_cache, latency_req_cache);
> So this will initialize with latency_req_cache.gen = 0 and latency.req_cache.latency_ns = 0...
> Come to think of it maybe a no-req run is also good as the first and last selftest case.

Yes, there is a  bug here that will cause the system to stay in the 
shallowest idle state when there is no QoS requirement. My system does 
have QoS requirements, which is why I didn't discover it. I will fix it 
in the next release.

Yes, adding this test case is necessary. However, a 'no-req run' does 
not mean that the system must enter the deepest idle state all the time. 
there are other factors that may restrict it. Let me explain in detail 
how to proceed."
>
>>   static DEFINE_PER_CPU(struct cpuidle_cpu_qos_nb, cpuidle_cpu_qos_nb);
>>   
>>   static void cpuidle_latency_req_invalidate_cpu(unsigned int cpu)
>> @@ -212,10 +218,22 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>>    */
>>   s64 cpuidle_governor_latency_req(unsigned int cpu)
>>   {
>> -	struct device *device = get_cpu_device(cpu);
>> -	int device_req = dev_pm_qos_raw_resume_latency(device);
>> -	int global_req = cpu_latency_qos_limit();
>> -	int global_wake_req = cpu_wakeup_latency_qos_limit();
>> +	struct cpuidle_latency_req_cache *cache;
>> +	unsigned int gen;
>> +	struct device *device;
>> +	int device_req, global_req, global_wake_req;
>> +	s64 latency_ns;
>> +
>> +	cache = per_cpu_ptr(&latency_req_cache, cpu);
>> +	gen = atomic_read(per_cpu_ptr(&latency_req_gen, cpu));
>> +
>> +	if (likely(READ_ONCE(cache->gen) == gen))
>> +		return READ_ONCE(cache->latency_ns);
>> +
>> +	device = get_cpu_device(cpu);
>> +	device_req = dev_pm_qos_raw_resume_latency(device);
>> +	global_req = cpu_latency_qos_limit();
>> +	global_wake_req = cpu_wakeup_latency_qos_limit();
>>   
>>   	if (global_req > global_wake_req)
>>   		global_req = global_wake_req;
>> @@ -223,5 +241,14 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>>   	if (device_req > global_req)
>>   		device_req = global_req;
>>   
>> -	return (s64)device_req * NSEC_PER_USEC;
>> +	latency_ns = (s64)device_req * NSEC_PER_USEC;
>> +
>> +	WRITE_ONCE(cache->latency_ns, latency_ns);
>> +	/*
>> +	 * Store gen last so a concurrent invalidate cannot leave a stale
>> +	 * latency_ns marked as current.
>> +	 */
> This doesn't guarantee the ordering.

Yes, the order is not guaranteed here. My comment was wrong.

However, in the current code, the call path of 
cpuidle_governor_latency_req() is per-CPU, so there is no cross-CPU 
cache access. If we consider multi-core access to this function, there 
would be a penalty on the fast path. I'll optimize the comment.

>
>> +	WRITE_ONCE(cache->gen, gen);
>> +
>> +	return latency_ns;
>>   }
