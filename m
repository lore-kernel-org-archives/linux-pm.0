Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610729405
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483768; cv=none; b=fY6SCbgunh7q7em0jwlT1znyW4MgFPoenJtRzMLoCd1bp5LruvUpbtG79TTkJ9bkvJaBRBlYDF32PCbeoBB6Au0bOzvb9MMAPxwJ8ksIuRtR/HTsIxEiMtN2klqP+BT3CcGquJxtbFhBM95iqxfcwSvU3YsW+uOZVCrAe3AJTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483768; c=relaxed/simple;
	bh=/LjjQJ4BzkgVjQ7+KifdZKOiSQNQlZ5NeNM6EVn8QFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsKGoqYvjy7pmQXFG56onCZHpainaJtY2yYizpyzZfBvnIa3pOIFolhILb4PbEtTMIdMFxeUNKRtJE4CObTnitz+U283K5hwOpZvwEtUqAXnVmDiJmekvulqXGCV5xVzo+DBcFD0iWp0Nurdh/IyrH37gdRz2zucXaa1pnRNI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHI+KQ00; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P8boPYwv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hHI+KQ00";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P8boPYwv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842amg1667899
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 04:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	atvv08bzEknQaF8X8Hs/xDQQdngZQM/4t7AanLQzlVQ=; b=hHI+KQ00teeV02aU
	WBxC+YwInVP/ACTQP3NeLAY0+3MMXmjJhOr3AOPQcCaMNFtT5CHIvBd6wHIhktST
	ZxL1oxDN8eajbz8NkPiLFMzNBrdfB0ZauuWcWf3oitjox1aBt2/3tl1pAKWd7qc9
	NbCRIhW0F6xn/jxY6IzlDGi7NvhpwHBmHru00DIU6CYKuyWQHEME/oXpBgrPJDZK
	cNuflQYlK2tHl2bUzWQ3fAPwchbbRvYesWxEl9ZisiLmzxAer01L/cs6yApqi0Gh
	8wGj+3FNHBcjXnT+1nLZoip6ECUu9XqI9FR+AVLxfrshL+U8AyNrwlEujmW59jia
	w0KHtQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5th28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:09:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb687f82eso6723535ad.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783483765; x=1784088565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atvv08bzEknQaF8X8Hs/xDQQdngZQM/4t7AanLQzlVQ=;
        b=P8boPYwvoh7DHrp/pLhNoh2TnhxemsDPHzsowCqeOlC+zIyv3UGbndaF7YYn3H+7Ru
         +0yykGOYihMhE1TGfVr5zkKANdz9As/9uu6V8cMoi0k3NwPbV3+fcwSDjIUbtwKx8znr
         tsH8UZZueqJRHhSRwgkKOHTpuldKVjMB2E1JB7qIbvap8C4mP3AoGkrmGwzjA8kVMWcK
         94Y5eFIAcL0gHo5ISCIhfroEfbdQ7WyxS4SWnv2lgWSizTHLTzOxioOpVNJ7NZoXOb9e
         chQGNGB4ebx5nx6WXLvDG0JR8HvbR5sipax85kvkia1GGlUHL7/v/xT2R96VnmYprO6D
         n/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783483765; x=1784088565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atvv08bzEknQaF8X8Hs/xDQQdngZQM/4t7AanLQzlVQ=;
        b=TZBp8G6QEEYNE7EE/ctYKLszXMLaH74uAzqTT2Y5A7MRp02t4kNmvP8eZNKER3KO36
         FGsado7/1rEIYgvg8yNYR5MVaPGToePGKu7zl1d7l2CWqp1YcRa+GrzKZSnlZTsxqGx2
         wQ5CJ+kEhqSul+4ovnSSvKgR8zaHRwvwVy8hMrH5riuL+aeG5V+BLshw82lupPMe5/CM
         r+xr+SVAU+4Wmza96OSkJ94v+licLM4MeFxtdZOf6+MUd4bXMlW2pbY7S0tXjbQZuba0
         Q48sCtiRm8zhM2ni7/wBflDfqEA+JCE19bmcT/jkDvSArqf5bxoJpb0YgP1NV+q7DGog
         yYEQ==
X-Gm-Message-State: AOJu0YxZhy/sUHXmMrt0D6GPwKW5HXyHt64Xqdce6xD8QLx6amkRCRzP
	8KxI73cO5FPZPtE2WaScTmM4GD4zZzSABKiKTZNdFEZO7ywY1xrul6g/J80QFR5Ahmn+ytRfOcU
	hmkhNh9psaQgGLi8+SA9YJKaAKNdo8P6HjWx9s5DN2yWi8rBgMLfRX5SbSilCSQ==
X-Gm-Gg: AfdE7cn66x5Lft3EQZWmGw6CyWF0ZATMmTdL+ydJKIzwPjDJ+ZJQP/y0YvT4B8H6Wch
	X5KFJA1J8VIKcmAzNdW11ZOXFo720TxhhD+L4JFAMd5jYXuW7FSs9jliDzqhYmuEGP5sq2R+qCd
	MCuZ5IH+JL431OwKdmVFBj7EDTLzZvVjJdU8hMfMyB4M2XW3uqfTeY4PDEk0X0TNIEa5zq1OJz5
	m5EajvWo4EPmwfi4WcRTq0Vb9Vyrjm1uftuGAqng61Cowft/P+3V071iSsRdY52adpNChM8I6tC
	aZx+cHXrMPRS2hQVUu8G/nr8tZk9UCzzuBo/D7VabWFxpygVrEiEgBoJeBRF/rXUYRUv6rAANWh
	eaSAYtmEyKCkS5zh+QnxIkTTly0EDikwf7edTCvlZrLxjeZg1ERuyFxj55ck3mf8JqMeJERlTtb
	5QmLCqTFQ=
X-Received: by 2002:a17:90b:1fd0:b0:37f:9ce2:348c with SMTP id 98e67ed59e1d1-389434633b8mr788343a91.29.1783483765315;
        Tue, 07 Jul 2026 21:09:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1fd0:b0:37f:9ce2:348c with SMTP id 98e67ed59e1d1-389434633b8mr788314a91.29.1783483764904;
        Tue, 07 Jul 2026 21:09:24 -0700 (PDT)
Received: from [10.133.33.212] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d2585f34sm2065812a91.17.2026.07.07.21.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 21:09:24 -0700 (PDT)
Message-ID: <4430befd-2d2c-422f-98b5-5947bb633937@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 12:09:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Make cpufreq_update_pressure() fall back to
 cpuinfo.max_freq
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        zhongqiu.han@oss.qualcomm.com
References: <5086499.GXAFRqVoOG@rafael.j.wysocki>
 <xdiwzy332y7inq4nnb2ht3xklm7acye4u3b3ar4psbak6rax3l@zsa6icmznqfx>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <xdiwzy332y7inq4nnb2ht3xklm7acye4u3b3ar4psbak6rax3l@zsa6icmznqfx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NiIq75bdKm66vFw_RWj8qMW7gngQUAC7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNiBTYWx0ZWRfX7epUlcR4lTqf
 wOBl3opUhX2noi0z765BFzqUDtfWiHe94pw9gRZHA9gGsfDdi5sTBCM9nT0xEElnrUtsRbK9f9n
 zbYGHCTm/0y3JMtzZaXfbHRcWYOVmuI=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4dcd76 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=w9sFvXK1ldvP2PC-LusA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NiIq75bdKm66vFw_RWj8qMW7gngQUAC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNiBTYWx0ZWRfXwWDe/bVAQbnQ
 vbZqFl2UP4JUcsSubgPgXz5PqxyHPZmi8bk6i1UJVhRZKdgvnsbhWGwEfiBhZM7OGfIESNg6sxH
 Vv792cWVjbEEql1pIeiI/qqgB07XbRsdCtpyERHulrkD9C7Ysp0MI4LU3scKmq/TKDRZG+OWM7e
 hn4N+5It0EVVJyvw9pTdhFDB67Rw3rtTHJyCHDgtOxIMb3qpeMazp4zs2GgcET6ckDY/htjlEiO
 JlDpZSbB1opsHzos66J3bYyXRZn0D7Z7kVLrPuDt/6rhnerADvevaCOG+WHkjhECBpWZWrIVMZM
 lQ+LfrFIc/083ftwWVA5btbiCeoCRITK4zpjGYu3v8MfI12tzo+WVr+IQtlUIo8z7azKyhvaSLO
 udn6nYiPjKUpF4os70H1bm9ZoyAe7vwurSZ6JLklEJVaknRAYgNyaY5nkF7oD6Kh36C/ZUJcsfT
 GdYQEzDwN5Vw2pH4OJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080036

On 7/8/2026 11:44 AM, Viresh Kumar wrote:
> On 07-07-26, 19:25, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If arch_scale_freq_ref() is not defined for a given arch (like x86, for
>> example), cpufreq_update_pressure() will always set cpufreq_pressure to
>> zero for all CPUs in the system, which is generally problematic on
>> systems with asymmetric capacity [1].
>>
>> However, in the absence of arch_scale_freq_ref(), it is reasonable
>> to assume that cpuinfo.max_freq is the maximum sustainable frequency
>> for the given cpufreq policy.  Moreover, there are cases in which
>> arch_scale_freq_ref() would need to be defined to return essentially
>> the cpuinfo.max_freq value anyway (for example, intel_pstate on
>> hybrid platforms).
>>
>> For the above reasons, update cpufreq_update_pressure() to fall back to
>> using cpuinfo.max_freq as the reference frequency if zero is returned by
>> arch_scale_freq_ref().
>>
>> Fixes: 75d659317bb1 ("cpufreq: Add a cpufreq pressure feedback for the scheduler")
>> Link: https://lore.kernel.org/lkml/CAKfTPtBuRLfYNnR4w--cFZYZy-R8gaPEgVwCcaMmbCcJ2H-muQ@mail.gmail.com/ [1]
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/cpufreq/cpufreq.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2590,6 +2590,9 @@ static void cpufreq_update_pressure(stru
>>   
>>   	cpu = cpumask_first(policy->related_cpus);
>>   	max_freq = arch_scale_freq_ref(cpu);
>> +	if (!max_freq)
>> +		max_freq = policy->cpuinfo.max_freq;
>> +
>>   	capped_freq = policy->max;
>>   
>>   	/*
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

-- 
Thx and BRs,
Zhongqiu Han
