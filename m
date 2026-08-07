Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320B379982
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113708; cv=none; b=rQNaJ8KWTbWmUynGz5nGcUHcVBJ55cyfPo0M7A3v8LWrqcyixmpIbq7l0qhNoNo2vaSAQmVL/euOei2nrC+/MocRpUQFNY5mLLkyDef02E+0uXQ6ZGfnenxn1mjIXE3UaDviYsycOu0T948RtA3/RkG5v8VE3q/iyRjBv7moKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113708; c=relaxed/simple;
	bh=Y/56oPVEffBjxjNx1h3W7hMYUb1prIOk5BYimmeMUXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeDY/oOPRVmWU0ul9pf7ttalfLotE8A7E9kTeDEhwRfEHug16rWoACTpCryOtudkDkTRJLPSLdNgZN8DLNnfz7zx36nSIG71nhx8kcPwnp+oz/+unZijL02JBrfwCSQTGeaa61irZuUtNTRTvIcD685YnIGQcXRXXtu5+FuJ2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inE+e8Zu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j5sOVe1Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inE+e8Zu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5sOVe1Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgGG1942900
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 14:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sjt0nLmUyvEX6y/ApHEY54VT/ZTHOS9hutf9WJJqwBU=; b=inE+e8Zu3U2Owgqb
	RRZyczQhWDCJuW0ZbaXjYA93JFyksduCDH78lpaiXp00n0Q5J0Pd0dZ8mVAvYrrr
	jEdOCjIE61mT1LXwtZbNUUQdHHQoC3zKjYoC+31+ZxuIlZrQp8U9qQ8JMPKh2F8e
	/VrxAOk5NHw8nuBrY0GGKu+pLBqn7Wd99kHpbh13jAWg9ISNKoajtDJbO6KzZHyc
	KwLau6KKiMGJbM1h09xfB1WpLz3/PdUhNg9biLATmoDX6rjffoTQnkfOK2LeNWq8
	lqf5HxqQYaflPkEJoLcwKS5ve3rwYgjPSPb0YuhwhO5FcCJvKTv4tWuZdRobLMHA
	ipYMOQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hceu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 14:41:29 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e735bcceaso52106887b3.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786113688; x=1786718488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjt0nLmUyvEX6y/ApHEY54VT/ZTHOS9hutf9WJJqwBU=;
        b=j5sOVe1QAExmwATaefwJJOFlrCVJz/ozXtPpjihlPuQBEDyn3rYFnSc6+JQgJbrpNp
         DbdIHPuR299DtByravIfueq5D38urqRAAFVlNmht6BFNgdNE0uApKqtoSZ57hFOB5ley
         oMPgM7vLtgrHQ9MAYCMffNMd2W8IOQ3kyMv8XKS/HAkU36nyUt2Wk0w+mZAoeDDZjzB2
         tHPJ+FTyIbFVik2mDh4kQyNBz9jMmvtyGhYAw0qISM69fV1vxBZJfiIcua1VL7kruv16
         mKeq3QymcryQrw364gZ6VXVH6Q842NMNf8/abruc3OluoTdTZmqBwDnSjE39KRogKbmz
         pOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113688; x=1786718488;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjt0nLmUyvEX6y/ApHEY54VT/ZTHOS9hutf9WJJqwBU=;
        b=RY/0F2Ebm9nfdnw8UD6T/WhH5RHx7J3kd5250C05WT97Dth+2Mf1zr2RqxAvCtt0ko
         XJLTPhIyuXOjM6g7K/cSHu8liD3ZWdUUX5tnxmTlJmxVT7jvnJbosIi+XFHOMCnjdmRQ
         KCbgeUA5ubR/OCaLJAtW2eKOCNwUpL0+admNDdpKo4umQAQ0xkW4qRxf3T4VP6YslXGv
         vKSxxgmAp/UhzBYwLeHblUEX+coFk/g2eZFuXVW55LzIc0moi08Io6ZPVXuMGcWudq2C
         xI7Zb00JzH9dAW1qg/Ub+nvVia8BnzWDGHCaEyZAl6iiDxQ2+t2tmIv8oZkFTTud2d/Z
         la1Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5/VI77Iuhgm4zxaLerYVpYIl6BUn6uU9iFwogTtcfFPGiAzCIWJc+GkE34H3EZGeMqy9WNLyJGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUKZb4Dcf48LnEVyB7w3Dbf7WC5gLn1jLfwLBd06ussSAze7w
	qeYuMZLU6SPKKT3WvDkSyjZ2tyMk8aK6Ip8/LrygxUpuudn9MeXOAeJYaNSgpIq+DdNV9J1Ghx0
	stKU/olAQY09ZUVL72UJ6fDhCnn31xcUThrhyaIlkf8PygfiVzbLdD6HFOd6x3w==
X-Gm-Gg: AR+sD12gr60/CVjESDnX69lsHgcQzNPEi86uzXjI0p18ONwVU1Ig9eAAzrywJKJYQPy
	zZMIN+MB6WBReUO3yCoqjkDZ7FU9QwpTvOJorEDMHbb3xU9jUPAaDeHnTkztkiBtfRMiLNa70mq
	/83nwHZrhMWki0Sn8N/ZTKpIE+CSpvAfD2j4q1R2+Yxe+NVSuVqPu1oC77+3BzTCTA7CizuNfGF
	o9beZydrGhm+gO3dYlg33UbuNAJax+sDV3mM17byfEs5xJa4dt5AUaCPm8+EYqv9exTH49UnUe0
	z0zUROCpGWbbzzAGWW6Zm/kbNwOm5Kgy8w4LMQdt3uD+tc34UTQOxyU0iGSJ90F2f90YLIFOBkJ
	bAeDImOS+Ov6ms58F4f3769Y6HV6qYfqy8Gn8OZQGDawHxFguRs0jwwuesC/U3cDDIH+b7v9mbz
	PgsyATZ5FA/LMe0qz5lQ==
X-Received: by 2002:a05:690c:111:b0:820:1251:d2c2 with SMTP id 00721157ae682-82445b54398mr18986137b3.28.1786113688550;
        Fri, 07 Aug 2026 07:41:28 -0700 (PDT)
X-Received: by 2002:a05:690c:111:b0:820:1251:d2c2 with SMTP id 00721157ae682-82445b54398mr18985777b3.28.1786113687954;
        Fri, 07 Aug 2026 07:41:27 -0700 (PDT)
Received: from [10.190.200.255] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f6a0f824sm10637287b3.42.2026.08.07.07.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:41:26 -0700 (PDT)
Message-ID: <5a0a9216-5dba-4b25-968a-353b30f642b5@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 20:11:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/cpufreq: Update schedutil's DVFS request to
 reach the boost frequencies
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org, Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
 <7a4be9a1-4b00-49c4-bdbf-649268e78c7a@arm.com>
 <CAKfTPtBoevmq8_Rens2Le=AGqMZRo56oD4eMGX2_2Pj_Vt9zCg@mail.gmail.com>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <CAKfTPtBoevmq8_Rens2Le=AGqMZRo56oD4eMGX2_2Pj_Vt9zCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MIrzVYm4qX4J5jOCikPc8UMg3dshSPhj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExNCBTYWx0ZWRfX2eeHBjR/w47D
 KWhpUo9O+TOY3q/YWUv4zJHmd/WzM4ncXUru2ezzUrYsu3XIOL3TauPwAFs4ZeWhn+XIG/QHa0D
 3c5aKEVm9wmhkiFqb0nEUrQQe8THNL0Z7CjxrKw4nvomBkHPfZRZRbd0HvbkehKH6xjrOcLytbN
 hUbvgwa+voQVju7Tx3B4WA8uTdwOk8lszhDq7O6EZCtkiy+whNHozxeiORWOM8kZHr7b+P3lV0H
 n4cEpF4v2kPbAgTC0vfRbChAY6IIE6dpfzjdLPglgyP29p63PwEWGUdm8m6m7TXX0hrYc5ut89Y
 DVVLJuFTPrrR0meTW04SPi4jsQjJHUv/ir9G8IWJPNCHXntJ1UHC87jCqAjzf/HyD3K7DlWLjlR
 cqoO03gz7OOKtktQSTNvcjGdflBTlw57/jpljvl9cojoq+Bbsqr9d9Nj1D6qPdtxk6jnzi5mjhA
 3yNdk+q3Cj3swKlwy/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExNCBTYWx0ZWRfX6TZKcE4OnLV7
 z+HyCBHPdABO5mBGaj6xlx2Th/7pPiYnM/ypj4xEwhGT2NDoZhgJP3xiCeJie+3lbjQr152c8zk
 yEYVKkQgG8Nqh18ruGh9jKQJADqeC9c=
X-Proofpoint-ORIG-GUID: MIrzVYm4qX4J5jOCikPc8UMg3dshSPhj
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75ee99 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=bYoXCjE1SysOf1r2alEA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070114


On 8/6/2026 8:43 PM, Vincent Guittot wrote:
> On Thu, 6 Aug 2026 at 11:02, Christian Loehle <christian.loehle@arm.com> wrote:
>> On 8/6/26 05:42, Sibi Sankar wrote:
>>> capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
>>> was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
>>> arch_scale_freq_ref() method") as a fixed anchor that does not move at
>>> runtime. However, schedutil uses that same fixed anchor as the reference
>>> plugged into map_util_freq() which saturates exactly at capacity_freq_ref.
>>>
>>> As a result, a system with cpufreq boost enabled effectively never runs at
>>> boost frequencies under schedutil-governed load. Fix this by plugging in
>>> policy-max into the map_util_freq equation, so that the DVFS requests
>>> translates to the actual cpufreq driver ceiling.
>>>
>>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>> ---
>>>   kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>> index a1782755efcc..dcefbeaa0702 100644
>>> --- a/kernel/sched/cpufreq_schedutil.c
>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>> @@ -195,10 +195,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>>                                  unsigned long util, unsigned long max)
>>>   {
>>>        struct cpufreq_policy *policy = sg_policy->policy;
>>> -     unsigned int freq;
>>> +     unsigned int freq, ref;
>>>
>>> -     freq = get_capacity_ref_freq(policy);
>>> -     freq = map_util_freq(util, freq, max);
>>> +     ref = get_capacity_ref_freq(policy);
>>> +
>>> +     /*
>>> +      * That fixed anchor governs how utilization is interpreted, but
>>> +      * the DVFS request is free to target the current policy ceiling.
>>> +      * Using ref alone would saturate the util->freq map at ref so
>>> +      * use policy->max to reach boost frequencies.
>> I'm not sure those two statements are compatible with the implementation below?
>> util / max is expressed in the capacity scale established using ref, multiplying
>> that ratio by policy->max changes the interpretation of every util value.
>>
>>
>>> +      */
>>> +     freq = map_util_freq(util, max(ref, READ_ONCE(policy->max)), max);
>> Isn't the underlying problem that schedutil can't handle requests above capacity 1024?
>>
>> effective_cpu_util() caps util at max, and sugov_effective_cpu_perf() applies
>> the 25% headroom before clipping the result back to that same value.
>> Therefore the input here cannot exceed 1024, and mapping it against ref
>> can never request a frequency above ref.
>> Using policy->max makes boost reachable, but also stretches the complete frequency range.
>> For example, with ref = 4454400, policy->max = 4723200, and effective util 640, the request
>> changes from 2784000 to 2952000.
>>
>> Making 'boost frequencies' truly compatible with schedutil (or PELT/CAS for that matter)
>> is a discussion that is yet to be had?
>> See also
>> https://lore.kernel.org/lkml/20250626093018.106265-1-dietmar.eggemann@arm.com/
> cpufreq_pressure and freq_qos_update_request could handle the case
> where boost freq is used as the ref freq when setting capacity but
> disabled. I can't remember if everything was already in place when we
> discussed this last time

Christian/Vincent,
Thanks, will look at how acpi-cpufreq/ccp-cpufreq in the x86 world handle
this and try out some of the suggestions in the link and get back.

>
