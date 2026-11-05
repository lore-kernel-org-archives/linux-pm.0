Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885230;
	b=Q4qKT0GrNRm1jMFdyXA/T9o4RU923YqN33ucX17ZSRibdlIV1tDkHme0POei/z9qiSLF
	 30jPJNdpM3cnyUuI3YIw3+d+YRRSfUtY9LkdSE+UM0JvaP2y/LO7wYFkFcJmMUxqvPm8n
	 b56YFomRHj09A6oCIxaovoG8k0D06T/VZNr62NiNWpSYxSp95StnbE6It4cnaU+RKxKlV
	 r+nckOcx/r99DyvsQCzqnOXLUfAhf/SJ+xFN4YCJOh/x4jxEPMgK7JIYj28b+UzyyViWx
	 llm/5AF0ExR/gT5HNwHN8rDnywNiCQ6uwTiibZt9hiw43pNjmhjEfpUFmNXMAOwGVug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885230;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=98OiPx49EcvXitIDKDeOXoaiDqN6ZgRkA3EyVm4UFHM=;
	b=tIlPsMuudXmd+j65LguLUCrbKCwIRJ3cLJ+1ZCcezrery+8B5LUokO/Tcc/PYBrtN8oD
	 cRUbi+bQPRxSbavWVzUilVPZYOwEShYuHWHddF8TuOucP+qlv7TNpo7qpFKWzIy7msfRA
	 sScifTlUHBXQPBikX2mnBqQ3CsC9cmUoMsHwrEBC6HfnlCaGf8ikrKcKl+RZ0d9M0Mte+
	 CW0SokosUB6zPrO/+p6WzbWDRR0JX/0MI4zfG1kdIxSg5aznDBS29xghz+LBA6CDcuVcU
	 UEN1878vgjOVlm/z6kJcOmRkVd1guTfUhfPgF5WBA31JVKHdNn3NuPSUtlianXCJM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p2BeMQ+A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7Dfg9dm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D5606A326
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 13:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p2BeMQ+A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7Dfg9dm
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A1QaV1416462
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 13:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	98OiPx49EcvXitIDKDeOXoaiDqN6ZgRkA3EyVm4UFHM=; b=p2BeMQ+A398c3DNO
	AVoR2dD4KtpBQZ4IGRhFqrGfZAQefhRlw1cVGd9iVMFEnu2FmN7e9EZzST0daoPJ
	1faocORnAv3Ln9YrJL9uiPwMhAceS7b05ZffwQEWhENJ4skbuBTMyXYfmMvOpZdF
	wPAIHnGXWQD0xv3O5prcLR7MObqysQegDQqf6HYsZuSwrDERV4W92GpyFl9qCt7+
	34wy36no9Sr7m+Y0G7qjL4HePVYhtBfIX9n2egeXrolyFsPM1bXGXRhZmh29ZjNJ
	+PtqQ1JORZhykeTBYp0zmqCWOZEOp6EWuNfQlGA8yxPJdYEudQjGm3ZRJmcMeIPK
	dNYbCw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd0u7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 13:27:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso1059930a12.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 05:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885228; x=1794490028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98OiPx49EcvXitIDKDeOXoaiDqN6ZgRkA3EyVm4UFHM=;
        b=i7Dfg9dma5tADAzF+ffvAvJewuKKYsigi523d5j+U6H7Fgyjhnpg0hp59wMobO5H/T
         1QeYr8s8rZUREHxwfuKLOPT2SLcmXA+N3yIs6ft3Vr9L8MgtFkWLvY3kgrvq7zk2DFqE
         7Y7mFVRaJbrMJfvW5gm3r8WDMbiJ2MygUewkhkJJNv2MZGyx/l42x+HmTtwBi0JKL49q
         3pPUgPvh9bULH4fLOOFqQ5DIkWESZMs5wh11HBv/4GgwlYYs402L3g84svgYZQhpfGzp
         WXXq9W9wNebhzAXygb8I7H+/c379NqklE5ZDCP5KJM83Q3lr04KVdXarPXF7+EmZ6pNA
         8YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885228; x=1794490028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98OiPx49EcvXitIDKDeOXoaiDqN6ZgRkA3EyVm4UFHM=;
        b=RfZp+Bm3iX1SHfVLce6NRVA4kWdT2EZnmVDo8AvhQfcb2uheqHtGx1eGtujMECaVfb
         xl0uYDOsdcsRuOhhamXj5knEoon/lXl0aEZSvill2q/ToD1ilcEtQNyxR+iVCcXmxI3k
         foCsDSbvVncK6RTuEjJPc/8F9UrBjNARZ9tOkAfX+2xQpfAT7ebGXoXbfXGkMZcHc5IU
         PgojnaGPbOP/mYtt1j0d/JxJRDI2P1yGUQY68jgiY6zQavHHjvb7k/GVCqiuEYa/rLme
         LYs2vQ9KRwGHjiLWM8BAWsm6a/UHbQyhVhTeu4ZkuBWxXqD3JPFa82z8LWNz2Oi0u66E
         RDHg==
X-Forwarded-Encrypted: i=1; AKwUvBz4Bzet4lm4Yg7CLzfzvN9qavXQU+0SWVrxiXz/nqXN4gwVFCZfHBaQYlKmrC3Hm12aPE55d6outg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+iw/1rq9d+hpudcc10GevtMfZpW7i05rS2zbSonCuGvEnDdBE
	ARpYyrq/jPb9ToeusxMBjW7tZFNS53NJRiz5CUiJMogF0JiDssfvfCsx2bfnj0fOv5n45S9kznv
	vOyqLz3T8yr5dfa5rLzKLwmuFmA/dJC04tz2/cq5ZeTUqvECfCf1RbWuCCRdc3rgA0vwy4Q==
X-Gm-Gg: AYBFou1vcQcbKC8nVEqc1WIb4j8v/Fvyy6wPGFdGnnqJUOkvaWdL7iZ6DofLluLN9On
	DwuP59CHgku4c2Wo2Xie5Na3AJGiKYQFl5rFHPMaajN8V1KqjPVXJMhRSfyw/Hq9kGlDSswKBXp
	S0K2h2+lnTVAxtt/BqCKjv9xQmhOTHhExyu1TGVdsFzNIzyN4BeOgkyJb5TsrkmqR7BSSiyxL7M
	t6+cYiVXhOs6WEgigQWv5Kmr3aQEIxnz1Nhekx2jTSAZhVMDlQp19UqlhfPoZX+eDrvw02nQ5B3
	Ww2LhDWKy48SmCR6FZnrWCa+e32/K1n9brHOWUlivltTTnNw2q1alY3gHagjX4m6QuvOgiN9X20
	B/XdKTpRPuyt6+XXCoSa5D9Fo6peRpSD1fSlcqiwfIFqA3ottURVw160No4r97CoWomJgiu5zn/
	cdDgf6ZndV6TwKr2Om2hok50BYnSAUoqincVyGAfImUx8a
X-Received: by 2002:a17:90b:574e:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3ae897c94f6mr15087454a91.20.1793885227907;
        Thu, 05 Nov 2026 05:27:07 -0800 (PST)
X-Received: by 2002:a17:90b:574e:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3ae897c94f6mr15087422a91.20.1793885227366;
        Thu, 05 Nov 2026 05:27:07 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3163383sm3932545a91.7.2026.11.05.05.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:27:06 -0800 (PST)
Message-ID: <a4b320d9-ade6-4f39-9e9a-e9a82b13152e@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 21:27:03 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Only cache resolved frequency in
 cpufreq_driver_resolve_freq()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, vincent.donnefort@arm.com,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20261104153042.3987338-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0gAXT+gEF7_dpJuDZDxB1hu7+Tq5dacZZhGz=X+VKDNwQ@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gAXT+gEF7_dpJuDZDxB1hu7+Tq5dacZZhGz=X+VKDNwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfX7RfOAcOpWBUP
 ceAgCtN0wtkd/dfoXHEy7GUu97zaYOBAxrQIlBum+HCowUirn1zZRtvxBS/8nGmD+G2UME5gA0d
 0tosZLmoPlmHmIL3CBnbukayUr3OG/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfX8btbMI+KUcpi
 sZW8cooebXsDCPBLWXjP/BylFqWVgOb/LULknF6Uq7de8IVpRGcBV1u7E9UUkIpFb+O3SKv5lZ+
 oIHqJhFPBZ2v0yHywBYMUj6WeY6bUrsplNAxtg8EXljLAiRLUrYsuQx2l/pvsGn2tl7hvM9WGqI
 zq6ir4+lwe1DcVNe1Wz2hNquOc6bK2cjWRdDv8F8UqgH1U0E+bjVADE2CNwRGfXO9LhnwB2JSOS
 wOetVlr5+iHiZz5WXaM88zTFc4e7cR9vrQBWP1NDL52KijEz0MtBEW/vHqQ0yaxGQWiEsoUvC4y
 7Wz1F4I/idi2BbH/rh3DQCK+stRGOFi95WUxYACqKcz4FXlhQ7eDOgJgA9NGiekgpQYzVHuhWLo
 2VolTh4PRYlxmoAEGspdjRnkZwWbHVbE+z3aIVAy+Wd/ergxb3nRUE0CMrfUgCJBVfq9PxJTHoM
 ij9N789YGIFgLxK2JNQ==
X-Proofpoint-ORIG-GUID: 0HHnlDdhVb5M6hU_xWh_zdeaZp56ZKQG
X-Proofpoint-GUID: 0HHnlDdhVb5M6hU_xWh_zdeaZp56ZKQG
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aec842c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KC6K3fDbvlfE3RyZnzgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050053

On 11/5/2026 3:04 AM, Rafael J. Wysocki (Intel) wrote:
> On Wed, Nov 4, 2026 at 4:30 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> Commit e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()") added
>> policy->cached_resolved_idx so that "a subsequent fast_switch operation
>> can avoid repeating the same lookup", and made cpufreq_set_policy()
>> invalidate the cache instead of filling it. That is, the cached index is
>> only meant to be used by the frequency switch immediately following the
>> resolution that has produced it.
>>
>> However, two other places now access the cache without synchronizing
>> with its other users:
>>
>>   * Since commit f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq()
>>     in __cpufreq_driver_target()"), __cpufreq_driver_target() reads the
>>     resolved index back from the cache before calling ->target_index().
>>     sugov_work() calls it without sg_policy->update_lock, so the scheduler
>>     path (a tick on the policy CPU or a remote update) can overwrite the
>>     index via cpufreq_driver_resolve_freq() meanwhile. This matters when
>>     sugov_hold_freq() discards the lower frequency resolved there, leaving
>>     the CPU below the frequency schedutil has kept for it.
>>
>>    CPU0 (sugov_work())                  CPU0 (tick interrupt)
>>    __cpufreq_driver_target(f_i)
>>      __resolve_freq()
>>        cached_resolved_idx = i
>>                                         sugov_update_single_freq()
>>                                           get_next_freq()
>>                                             cpufreq_driver_resolve_freq(f_k)
>>                                               cached_resolved_idx = k
>>      __target_index(cached_resolved_idx)
>>        ->target_index(policy, k)
>>
>>   * Since commit 151717690694 ("cpufreq: Make policy min/max hard
>>     requirements"), cpufreq_set_policy() updates the cache as a side effect
>>     of __resolve_freq(), which can race with governors switching frequencies
>>     without policy->rwsem (schedutil, ondemand, conservative), and a similar
>>     race was addressed by commit 7491cdf46b5c ("cpufreq: Avoid using
>>     inconsistent policy->min and policy->max"). qcom-cpufreq-hw and
>>     apple-soc-cpufreq ->fast_switch() read the cached index directly too.
>>
>>    CPU0 (sugov_work(), work_lock held)  CPU1 (handle_update(), rwsem held)
>>    __cpufreq_driver_target(f_i)
>>      __resolve_freq()
>>        cached_resolved_idx = i
>>                                         cpufreq_set_policy()
>>                                           __resolve_freq(min)
>>                                             cached_resolved_idx = j_min
>>      __target_index(cached_resolved_idx)
>>        ->target_index(policy, j_min)
>>
>> In both cases, schedutil does not call the driver again until its
>> selection changes, so the CPU can get stuck at a frequency it has not
>> selected. All drivers implementing ->target_index() are affected.
>>
>> The cache is only consumed by ->fast_switch() right after
>> cpufreq_driver_resolve_freq(), so only update it there and use a local
>> index in __cpufreq_driver_target().
>>
>> Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
>> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
>> Cc: stable@vger.kernel.org # 5.14+
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> 
> Please see Sashiko's feedback on this one:
> 
> https://sashiko.dev/#/patchset/20261104153042.3987338-1-zhongqiu.han%40oss.qualcomm.com
> 
> and let me know what you think about it.

Sashiko reported two issues here.

(1)The first is the build-time warning due to uninitialized idx, which I
will fix in v2.

(2)The other is the potential NULL pointer dereference and use of an
uninitialized idx due to a pre-existing race. However, it is worth
noting that once this race occurs, policy->freq_table will be NULL, and
__target_index() will dereference the NULL freq_table regardless of
whether idx is initialized. Initializing idx only affects the offset
used for the NULL pointer access. If idx is initialized to 0 as part of
the fix for (1), the NULL pointer access will be at a deterministic
offset rather than an unknown one. As the race is pre-existing and is
independent of the uninitialized idx warning, I will send a separate
patch to address it in the next few days.

> 
>> ---
>>   drivers/cpufreq/cpufreq.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 54dde8419bdc..ffde75dab91d 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -471,10 +471,17 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>>
>> +/*
>> + * Note that this does not update the cached frequency lookup in @policy,
>> + * because it may be running in parallel with a frequency switch carried out by
>> + * the governor that uses the cached index.  If @resolved_idx is not NULL, the
>> + * index of the resolved frequency in the frequency table is stored in the
>> + * location pointed to by it instead.
>> + */
>>   static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>                                     unsigned int target_freq,
>>                                     unsigned int min, unsigned int max,
>> -                                  unsigned int relation)
>> +                                  unsigned int relation, unsigned int *resolved_idx)
>>   {
>>          unsigned int idx;
>>
>> @@ -484,8 +491,8 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>>                  return target_freq;
>>
>>          idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>> -       policy->cached_resolved_idx = idx;
>> -       policy->cached_target_freq = target_freq;
>> +       if (resolved_idx)
>> +               *resolved_idx = idx;
>>          return policy->freq_table[idx].frequency;
>>   }
>>
>> @@ -505,6 +512,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>>   {
>>          unsigned int min = READ_ONCE(policy->min);
>>          unsigned int max = READ_ONCE(policy->max);
>> +       unsigned int freq, idx;
>>
>>          /*
>>           * If this function runs in parallel with cpufreq_set_policy(), it may
>> @@ -517,7 +525,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>>          if (unlikely(min > max))
>>                  min = max;
>>
>> -       return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
>> +       target_freq = clamp_val(target_freq, min, max);
>> +       freq = __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE,
>> +                             &idx);
>> +
>> +       /*
>> +        * Cache the lookup result for the subsequent ->fast_switch() call, which
>> +        * is the only user of it.
>> +        */
>> +       if (policy->freq_table) {
>> +               policy->cached_resolved_idx = idx;
>> +               policy->cached_target_freq = target_freq;
>> +       }
>> +
>> +       return freq;
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>>
>> @@ -2355,12 +2376,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>>                              unsigned int relation)
>>   {
>>          unsigned int old_target_freq = target_freq;
>> +       unsigned int idx;
>>
>>          if (cpufreq_disabled())
>>                  return -ENODEV;
>>
>>          target_freq = __resolve_freq(policy, target_freq, policy->min,
>> -                                    policy->max, relation);
>> +                                    policy->max, relation, &idx);
>>
>>          pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
>>                  policy->cpu, policy->cur, target_freq, old_target_freq, relation);
>> @@ -2393,7 +2415,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>>          if (!cpufreq_driver->target_index)
>>                  return -EINVAL;
>>
>> -       return __target_index(policy, policy->cached_resolved_idx);
>> +       return __target_index(policy, idx);
>>   }
>>   EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
>>
>> @@ -2666,14 +2688,14 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>           * concurrently by cpufreq_driver_resolve_freq() during the update.
>>           */
>>          freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
>> -                             CPUFREQ_RELATION_H);
>> +                             CPUFREQ_RELATION_H, NULL);
>>          if (freq != policy->max) {
>>                  WRITE_ONCE(policy->max, freq);
>>                  policy->update_limits = true;
>>          }
>>
>>          freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
>> -                             CPUFREQ_RELATION_L);
>> +                             CPUFREQ_RELATION_L, NULL);
>>          freq = min(freq, policy->max);
>>          if (freq != policy->min) {
>>                  WRITE_ONCE(policy->min, freq);
>> --
>> 2.43.0
>>
>>


-- 
Thx and BRs,
Zhongqiu Han
