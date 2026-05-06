Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16E43DA30
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071561; cv=none; b=WX70cEy8ARl3GDB8JDbwAGkKz5FLQ0mu0dia5k13i/oEjpLsMshTzOMH5VWaoH0+c/DcTqLvwJBogNKON8WkzkdQb9UMJFPbwhGPBNyTQSqDQR23fG3jtDDMht0mb/+KmI3B7b5z4nmQWh6cjQuU9Gy3r5Iekt9HBuPAnG0tz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071561; c=relaxed/simple;
	bh=6d/ZaU+FxZCDzKWhdAgPhyWotSVnGTsCNE9vyMzsexU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t59enrwVBCBb00PrWGeTdmJnOHmIXstHzhMeceoeZ8kAq6oJe8ZDBbARvwnSfEiRjlp2i/KjDQivSwWuqqFgS/0Dt9y/1TH+5bmVeq3uLx+Hezni22r1QH+nJujWEADDZ1JwhoTJ2kr2EyRcVZhR4M+ap57dSYj37SxAyl7M+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Am49DwT2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vn+LaxbV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Am49DwT2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vn+LaxbV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6467uGhh2428667
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 12:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MoFl3Q+kqy5WgoE+4s222cxNsYqnO6BqwGWVNuszBKI=; b=Am49DwT2jeUXp3Iv
	qdek4zWG7cA4hU63ufGbClUNuSsHBFQAHgATyV0ZBHfLoK2SFgZOJ4Su4jMg5EYh
	buOWPWqj3bEDk4m5wjOha3hJEW72jvKVJ2J2MaBgXARlEwIFneHDDcG1e5ng5kb0
	h8yHfWKaGb5Sd3bP7pDdiXjxESHuzPmxPoae2lnZKMiJSitl1P+b6yVx97paYFHe
	KHMKNe2eCYWshp6KOZxq6W+NVFZyDaGmkgV6b6iwTBTRnbni3sT9v+0fE/wgHaEm
	9HflP9k3ZjT/y8MCBNlLWDCFnJU6PgPgzxXs6zJJN5yb6TcmGWsyMGfdcyImGm8w
	yEJQGQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph129s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 12:45:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9f5ac4e36so36048765ad.2
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778071553; x=1778676353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoFl3Q+kqy5WgoE+4s222cxNsYqnO6BqwGWVNuszBKI=;
        b=Vn+LaxbV/77bICDbuWsxfW1MQoKE573VjpGZsuiK+mGHgm1lyuvb1v2T0Ivi3712ce
         +ieeHk6Frp2Nl4tuNJveiUGBjyrm5qe+7Y1zvK5lyiwoVbozdj+mpB6J+8M75QC9VmNS
         6TQv18XD5O42umhyYR0KZuJp+6HISgx2Hbdkb9y7vReITDzmEZnC2ASwHwPqlaLQ8HOK
         p7kVYIK/Lg6DlM//EabnEEE3pBAVzlzXOzrPw7JxesQO3kLOQ3HbxEOmh10vEE/ObTBK
         Wr2IeSEtmvT86VjfQtHt0eIkwuRXTcLEtRIkZEN2XfFoAa9PzCLODIo7hdCKFjgPHvVV
         aiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071553; x=1778676353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoFl3Q+kqy5WgoE+4s222cxNsYqnO6BqwGWVNuszBKI=;
        b=c1P4TTFDHO0mWgKUnff7TAY0/EOc1H8MQA41AZ4LnaIkUaabJ1MySQ8UAyWdWPijmE
         j8QV+fH5U5sTEfxkj7eM/JrjZUpANmUmlMSWV2fEZB0639A3XaNYMZlXnDmWBpoC3yH2
         IWugt+S8pOlPMagRV7lQmoHDbhPZ8IO9GfdeW4N9MdqQyaQnUm72qMw/1wzVkzoqudif
         grJvkzMKP8RvamQk4KL+OTd0ylpgMAMvtpj2aFEyRcUl96DkMOrwsTgUUMZdQa91VmuO
         l5K9XqYHq5Qb/RnTI8nWOtdEh4ltf1MHSudaZYexqmUYn0sJecFsVxOYOJ3pMY+xWI8f
         p8JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K4KxahTTy8W4M2mv2alVyzB0VfsG5XlY9VByhbloa5FEbco+mzkl39ayzr1az/gE6pBdXlTfNow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDhqvcyScr8Vg5Qk5NNPpew5pooyGcLTEd4+yUIXExDRhnJK6
	9glg3NcKuG5BBoZvWRAp9t+bn+gf4mErpHismDE692LPT26PiLah1YwO7b+vuViBAjhHW2vSTBs
	VAVpqVB3PugCmyttWOj7jGy/R6luzi4RROJp+lSlaqT3VtAatTm56UqrFyXDJmw==
X-Gm-Gg: AeBDietHS0e+AvYx2MZWZGgbdIuhfPvvmVrrnenrmjFxnDdCF2J4otwVsQSw2y5sYM1
	GmaUyDTk4JB2nQJpz93BybcNQ82AMmwWQyy71yDVAZAmLXY9nAgU3FtvuF5tMhQ3578nIfBbKKv
	YA/H0+K0ynUJy+u0JtzXAOcX2oU0pCvkxa8kgbhNXeoTNV+iuZH1E/Ju9llxdWsgHzxhwi0986N
	IvRLi/aRXchbR4+dEhH/daf7Ee6h18Xyjf6RRb7rRrZvpMekrScSX6O37/Kuy1vW7mJ0X+yMyBi
	PlVdTuQkiFMK9zZvdPjwJnH/KoQdbR3J+EUGdzPkXosG82nt+QQ9Wlp0grgVJOTKk/cISgdYI5j
	/UWR0rv2jFmwTV9MbDVBSsf3t9A61X7Q5a57Zz3Fu6nASKgF05ctB39Tnhjqvl6w3axfJjDkIYD
	/HhiQ8oQx0DZtvpU16Wc7agHGBVyge
X-Received: by 2002:a17:903:3d4a:b0:2ba:6bd7:8efc with SMTP id d9443c01a7336-2ba7a37724bmr22954005ad.40.1778071553368;
        Wed, 06 May 2026 05:45:53 -0700 (PDT)
X-Received: by 2002:a17:903:3d4a:b0:2ba:6bd7:8efc with SMTP id d9443c01a7336-2ba7a37724bmr22953515ad.40.1778071552807;
        Wed, 06 May 2026 05:45:52 -0700 (PDT)
Received: from [10.133.33.189] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca29f9dsm23945715ad.78.2026.05.06.05.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:45:52 -0700 (PDT)
Message-ID: <e5a98d8b-607f-42d6-8e96-15d8b8f11d25@oss.qualcomm.com>
Date: Wed, 6 May 2026 20:45:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <73fac9ca-451d-49f0-b9c7-5ef6bc0119bf@oss.qualcomm.com>
 <3efe318a-52bf-4c92-8b86-03e0bb6a9a93@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <3efe318a-52bf-4c92-8b86-03e0bb6a9a93@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEyNSBTYWx0ZWRfX2Clzw3emEydP
 WHqC+PSBvmDamaQrJrcsZNw4UMPqYpvOwSoZHfDv4ldHn52wpP7ejrTZQAQeMUIhk8kZaOif6qP
 +39r6436xDEj1xaxQhOBbO/3DWIWMrDNLpn/PQGhb4MQAv8cAOKbS4AJmKY0pXMbUTaHjk7YT5/
 Dp4fE8tRU8+FcMfyvSrm1dZw1D/o42hocX3HO9U065hFGCuLLb/NNdy6jZqfkfEfF99KkBC/Uef
 o6zoZLbLfmuhPYr64x0ggthXoDT40YKg/1QpUQGOZUK8LBreSkN/v+OLp0ViZxAHUMvjszQG7tg
 y0bE3zrM0W+c6StnDvuQTGIGYD59+gJvWADWhuGIBPRqFz8c/XNE3B0V/az5UTJl8vxtIlTMMOn
 7qczuFnbwcrQSwm1m7lkcRIEq0eT3x65hSA7wsJ4aAPZp66s4wMhGnjZZVRssNwtlKPng+iu2Aq
 dP0RXbXc7usT4vdS35g==
X-Proofpoint-GUID: YHKFFHSTJW3o8D6sX2uEuPdBLmKDf3bf
X-Proofpoint-ORIG-GUID: YHKFFHSTJW3o8D6sX2uEuPdBLmKDf3bf
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb3802 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=PzqmGsHs9K19ghWT0pMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060125

On 4/30/2026 9:41 PM, Pierre Gondois wrote:
> Hello Zhongqiu,
> 
> On 4/29/26 15:00, Zhongqiu Han wrote:
>> On 4/23/2026 4:47 PM, Pierre Gondois wrote:
>>> cpufreq_set_policy() will ultimately override the policy min/max
>>> values written in the .init() callback through:
>>> cpufreq_policy_online()
>>> \-cpufreq_init_policy()
>>>    \-cpufreq_set_policy()
>>>      \-/* Set policy->min/max */
>>> Thus the policy min/max values provided are only temporary.
>>>
>>> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
>>> cpufreq_policy_online()
>>> \-cpufreq_init_policy()
>>>    \-__cpufreq_driver_target()
>>>      \-cpufreq_driver->target()
>>> is called. To avoid any regression, set policy->min/max in cpufreq.c
>>> if the values were not initialized.
>>>
>>> In this patch:
>>> - Setting policy->min or max value in driver .init() cb is
>>>    interpreted as setting a QoS constraint.
>>> - Remove policy->min/max initialization in drivers if the values
>>>    are similar to policy->cpuinfo.min_freq/max_freq.
>>>    The only drivers where these values are different are:
>>>    - gx-suspmod.c
>>>    - cppc-cpufreq.c
>>>    - longrun.c
>>> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>>>    used as a min QoS constraint as suggested at:
>>> https://lore.kernel.org/lkml/20260213100633.15413-1- 
>>> zhangpengjie2@huawei.com/
>>>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>
>>
>> Hi Pierre,
>> Thanks for the patch. I have a few additional inline comments/questions
>> below.
>>
>>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>>>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>>>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>>>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>>>   drivers/cpufreq/freq_table.c      |  7 +++----
>>>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>>>   drivers/cpufreq/intel_pstate.c    |  3 ---
>>>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>>>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>>>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>>>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>>>   11 files changed, 51 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 453084c67327f..1ed4bcdcc957f 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>         perf = READ_ONCE(cpudata->perf);
>>>   -    policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>>> -                                  cpudata->nominal_freq,
>>> -                                  perf.lowest_perf);
>>> -    policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>>> +    policy->cpuinfo.min_freq = perf_to_freq(perf,
>>> +                        cpudata->nominal_freq,
>>> +                        perf.lowest_perf);
>>> +    policy->cpuinfo.max_freq = cpudata->max_freq;
>>
>>
>> It is better to update doc as well to avoid new dirver developmenter set
>> policy->min / policy->max again?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/ 
>> tree/Documentation/cpu-freq/cpu-drivers.rst#n102
> 
> Yes sure, does the following works for you:
> (tabs might not be conserved in the mail)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu- 
> freq/cpu-drivers.rst
> index c5635ac3de547..12dc4dcbdd5a6 100644
> --- a/Documentation/cpu-freq/cpu-drivers.rst
> +++ b/Documentation/cpu-freq/cpu-drivers.rst
> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>   |policy->cur                       | The current operating frequency 
> of   |
>   |                                  | this CPU (if appropriate)         |
>   +----------------------------------- 
> +--------------------------------------+
> -|policy->min,                      |             |
> -|policy->max,                      |             |
> +|policy->min                       | Minimum frequency QoS constraint.  
>    |
> +|                                  | Can be overwritten by writing to  
>     |
> +|                                  | scaling_min sysfs file.         |
> ++----------------------------------- 
> +--------------------------------------+
> +|policy->max                       | Maximum frequency QoS constraint.  
>    |
> +|                                  | Can be overwritten by writing to  
>     |
> +|                                  | scaling_max sysfs file.         |
> ++----------------------------------- 
> +--------------------------------------+
>   |policy->policy and, if necessary,  |            |
>   |policy->governor                  | must contain the "default policy" 
> for|
>   |                                  | this CPU. A few moments later,    |
> 


Thanks Pierre,

Just shared a minor nit and used 'If' to indicate that it's optional.
For example, if you think it makes sense, you may consider:

+|policy->min   | If set by the driver in ->init(), used as the       |
+|              | initial minimum frequency QoS request.              |
++-------------------------------------------------------------------+
+|policy->max   | If set by the driver in ->init(), used as the       |
+|              | initial maximum frequency QoS request.              |


>>
>>>         policy->driver_data = cpudata;
>>>       ret = amd_pstate_cppc_enable(policy);
>>> @@ -1907,10 +1907,10 @@ static int amd_pstate_epp_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>         perf = READ_ONCE(cpudata->perf);
>>>   -    policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>>> -                                  cpudata->nominal_freq,
>>> -                                  perf.lowest_perf);
>>> -    policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>>> +    policy->cpuinfo.min_freq = perf_to_freq(perf,
>>> +                        cpudata->nominal_freq,
>>> +                        perf.lowest_perf);
>>> +    policy->cpuinfo.max_freq = cpudata->max_freq;
>>>       policy->driver_data = cpudata;
>>>         ret = amd_pstate_cppc_enable(policy);
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/ 
>>> cppc_cpufreq.c
>>> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       unsigned int cpu = policy->cpu;
>>>       struct cppc_cpudata *cpu_data;
>>>       struct cppc_perf_caps *caps;
>>> +    unsigned int min, max;
>>>       int ret;
>>>         cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>>> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       caps = &cpu_data->perf_caps;
>>>       policy->driver_data = cpu_data;
>>>   +    min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>>> +    max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>> +                   caps->highest_perf : caps->nominal_perf);
>>> +
>>>       /*
>>>        * Set min to lowest nonlinear perf to avoid any efficiency 
>>> penalty (see
>>>        * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>>>        */
>>> -    policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>>> -    policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>> -                        caps->highest_perf : caps->nominal_perf);
>>> +    policy->min = min;
>>>         /*
>>>        * Set cpuinfo.min_freq to Lowest to make the full range of 
>>> performance
>>> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>        * nonlinear perf
>>>        */
>>>       policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps- 
>>> >lowest_perf);
>>> -    policy->cpuinfo.max_freq = policy->max;
>>> +    policy->cpuinfo.max_freq = max;
>>>         policy->transition_delay_us = 
>>> cppc_cpufreq_get_transition_delay_us(cpu);
>>>       policy->shared_type = cpu_data->shared_type;
>>> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/ 
>>> cpufreq-nforce2.c
>>> index fbbbe501cf2dc..831102522ad64 100644
>>> --- a/drivers/cpufreq/cpufreq-nforce2.c
>>> +++ b/drivers/cpufreq/cpufreq-nforce2.c
>>> @@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy 
>>> *policy)
>>>           min_fsb = NFORCE2_MIN_FSB;
>>>         /* cpuinfo and default policy values */
>>> -    policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
>>> -    policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
>>> +    policy->cpuinfo.min_freq = min_fsb * fid * 100;
>>> +    policy->cpuinfo.max_freq = max_fsb * fid * 100;
>>>         return 0;
>>>   }
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct 
>>> cpufreq_policy *policy,
>>>       cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>>         if (new_policy) {
>>> +        unsigned int min, max;
>>> +
>>> +        /* Use policy->min/max set by the driver as QoS requests. */
>>> +        min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>>> +        if (policy->max)
>>> +            max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>>> +        else
>>> +            max = FREQ_QOS_MAX_DEFAULT_VALUE;
>>
>>
>> Nit: Using local variables named min/max is confusing here since they
>> shadow the common min()/max() macros; renaming them (e.g. min_freq
>> / max_freq) would improve readability and maintainability.
>>
> Ok yes sure
>>
>>>           for_each_cpu(j, policy->related_cpus) {
>>>               per_cpu(cpufreq_cpu_data, j) = policy;
>>>               add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct 
>>> cpufreq_policy *policy,
>>>             ret = freq_qos_add_request(&policy->constraints,
>>>                          &policy->min_freq_req, FREQ_QOS_MIN,
>>> -                       FREQ_QOS_MIN_DEFAULT_VALUE);
>>> +                       min);
>>
>> It seems that the current patch is not merely a superficial cleanup; it
>> also changes the policy->min value in the GX driver, setting it to the
>> 5% value expected by the driver. If so, we should document it in the
>> commit message.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
>> tree/drivers/cpufreq/gx-suspmod.c#n137
>>
>> /* gx-suspmod.c constants:
>>  *   POLICY_MIN_DIV = 20
>>  *   max_duration   = 255
>>  *   maxfreq = e.g. 300000 kHz (300 MHz)
>>  */
>>
>> cpufreq_policy_online()
>>   cpufreq_driver->init(policy)      /* cpufreq_gx_cpu_init() */
>>     policy->min = maxfreq/20        /* 15000 kHz, 5% */
>>     cpuinfo.min_freq = maxfreq/255  /* 1176 kHz, 0.39% */
>>
>>   /* Before current patch: 0, not policy->min */
>>   freq_qos_add_request(..., FREQ_QOS_MIN, 0)
>>
>>   cpufreq_init_policy()
>>     cpufreq_set_policy()
>>       /* reads QoS=0, discards init()'s 15000 */
>>       new_data.min = freq_qos_read_value(FREQ_QOS_MIN)
>>       cpufreq_gx_verify()
>>         cpufreq_verify_within_cpu_limits()
>>           /* 0 < 1176: clamp to hw floor */
>>           new_data.min = cpuinfo.min_freq  /* 1176 kHz */
>>       WRITE_ONCE(policy->min, 1176)  /* 0.39%, not 5% */
>>
>> After current patch:
>> freq_qos_add_request(..., FREQ_QOS_MIN, policy->min)
>>   => new_data.min stays 15000, no clamping, policy->min = 15000
>>
> Prior to [1], the policy->min/max values were used as QoS constraint.
> This patch effectively set a min QoS constraint, but it should be no
> different from what the driver was setting initially.
> 
> I will add a reference to the patch + explanation in the commit
> message to avoid any ambiguities.
> 
> [1] 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency 
> QoS requests")
> 
> 

Thanks, that makes sense to me.

>>
>>>           if (ret < 0)
>>>               goto out_destroy_policy;
>>>             ret = freq_qos_add_request(&policy->constraints,
>>>                          &policy->max_freq_req, FREQ_QOS_MAX,
>>> -                       FREQ_QOS_MAX_DEFAULT_VALUE);
>>> +                       max);
>>>           if (ret < 0)
>>>               goto out_destroy_policy;
>>> blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                   CPUFREQ_CREATE_POLICY, policy);
>>> +
>>> +        /*
>>> +         * If the driver didn't set QoS constraints, policy->min/max 
>>> still
>>> +         * need to be set as they are used to clamp frequency requests.
>>> +         */
>>> +        policy->min = policy->min ? policy->min : policy- 
>>> >cpuinfo.min_freq;
>>> +        policy->max = policy->max ? policy->max : policy- 
>>> >cpuinfo.max_freq;
>>
>>
>> Does it make sense to set policy->min / policy->max before the
>> CPUFREQ_CREATE_POLICY notifier, since some drivers may use them in their
>> callbacks?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/ 
>> tree/Documentation/cpu-freq/core.rst#n58
>>
>>
> Yes right indeed, this would be better.
> 
> Thanks for the review
> 


-- 
Thx and BRs,
Zhongqiu Han
