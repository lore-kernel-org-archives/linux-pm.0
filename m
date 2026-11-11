Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404830;
	b=mSILXQjjrYRVkUZ4PMbMT8nEzoEgI4zoLcbgA25SQ16SFRiwxKAFxk2z3Dj1M55KOdbk
	 uIJltAfFsSL9kTmFog26DEhxgcYgs1L6uXJUDnFu9xEDqfq3utrBTnC6t66f6Y099W+sJ
	 y0LAiuGCgppDQGA/UfS4wJSqrTpp8DQeo75qHSzBGGyXfzurSBaxO/lQXtlxehXZXIcFD
	 lA6Xttb0NWblTEaAOqYAFLiUaAPjTA0iZ+pyNdU+Hf041Um3NSYnkJEO1YsPzhNws7Zea
	 u0PZoXHC5Jgq6T/pDEVIDFVltm4dPmLB5zznOdmRR2trGnhsEoFhgYLzk+va26NLgvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404830;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=B0t7gR4bEucbc8jZShMdnCoiT4kfG+r/AXQtiP9TGNo=;
	b=4y6eWh2YJe+m27Uh4Ps0PKeh8fwMR3NlLSHavVPauYkmd9y+WIhPn24NvyBDDQDf/24O
	 m33e9LT7iORognbz7nbNLxPEbQDLN07pg1SEpFSjlnC2eCZj7rIyQZcnvlZiWf8uEUL6Q
	 5vDCMpV5lUMMBr/Uu5EamdMhnpU9y+B2xGFaS3PJKLeeryFR8QL9R1RdKnHn57UMPyLfV
	 8y8WENCR5p7m5GE0KPezCAIKnEeRBI0914QxC5D0wjOQOQC4xEpVJI0GSpaTqs/7cZdya
	 WhN3KmatoEYx/J80/1JPKM5eZD6KRrqgsu0ApJFI8BDo8GPBaZuLOF+4YsIHej7y1eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1NI9ZXK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gmvtSrqX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16F606A324
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 13:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A16F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1NI9ZXK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gmvtSrqX
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ26S3292079
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 13:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0t7gR4bEucbc8jZShMdnCoiT4kfG+r/AXQtiP9TGNo=; b=P1NI9ZXKpPpLefpB
	T3jRSQKTdCHlEJxCBLZcI8vT3iWGPPydxpLKXAaJhtexVFFrEoWcIMwtEIjJFan3
	FngfDNeafJTexxx7+8fS+CyhF+fidjkTM04SWz9+37XWiMHELmIS0dNjyy3RMv1f
	fyJKo7B2LRVEAcTfr4EwnLyb/0Dglh2Octj0XY6HB1zpipBui9yPL+jYU2paRntD
	gSiwZFC37NRpTAHhcaIB0Rtt/s0zrYvd7FfmVd05fxrOZxAZjSwCmxzxnNzzrVej
	BpHRpbhJPqBQ6cnWyfdaMqrrGKjyIUOSIg+tysqWd0H8NUaG0nTJgbWLoeXmz/Y9
	CdGaXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2qk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 13:47:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so2534692a91.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794404829; x=1795009629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0t7gR4bEucbc8jZShMdnCoiT4kfG+r/AXQtiP9TGNo=;
        b=gmvtSrqX4mRvMroqfG5OzQo75GbOUuARbiiGbCbb9X+JRuXVxg4ebyHJ/2W/qb7c1w
         EQrH7Th+pidgu0q0fC8o6rWQRUsNlc83sTMngHXKkk9SPj0fNRFOOCoUlThuDvdI5OXI
         Z5n+dTEgIHQ2kX/DbyxulVU63GpCL/EBocjJPFF0Ya9IhBfaWBUZrogan9fX+YgES1BK
         80nwjCI045HAgiB5yRsTT7NEfsAftkqBv4m8YlUaM/r0vO6is3MpS7UvxWI3KxFSVnE0
         yXrX4qRQmCOUQQI0IKI6gZmOsdRdCiqvyEVQ+RWj5kjQBQs9N4qfveigreqvmBvhr4CZ
         sqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404829; x=1795009629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0t7gR4bEucbc8jZShMdnCoiT4kfG+r/AXQtiP9TGNo=;
        b=DUFLz1azq/z49XkHU/CfomyXxXVofv9z3/UU7HsCwM3K+QAXLgjLmGugpapnJ10j2k
         DkXyrejZrVnxWUb+qAy3T4C6RDaNEEN4GVRqOe8Nu5JqT2qVQPH/OJYav+C1oWLVTl9v
         VFG5Kak9K+LLwgirt3OMMM6m2mmYHUxyVCiSFk2At/dIc2fFPeVHYVdGg3n7iZ7ERdpJ
         t5/j6NU+qQweJZ09ZQk8cFsh2kQdzBMSJda3zdkfrKLrrIlVglOtxW/mMG2ssZl55Arx
         8RZvqvDxyfEK1rfRhlux4dwTLkWPOGxYOtUTb+UDKPogzqUxKz3J4iwQT6rLsT63W5JB
         q15Q==
X-Forwarded-Encrypted: i=1; AL+hErHdIRwa1bTwSGd+MlrjyH84Pkr8XgNwsgy/buXpVQtjOEM0dgAKbexrOTTpcxCr0lgTVbFCV34RuQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/h1sKs161+CMEXc+ZxdzszdB7HpkBPp++YRYExUKXLl6QTQCcB
	zqXlC8JPHRWoma9BVd+LoynTbRk7Lo2/kfsRiEUejXU2rL+gbIueOusqVfxdofF4pH29ti8uOeJ
	kge0LuZks2QxROqSrmkWm+bQv2l+ln0bkvuIGamrlLJjvsDzhS++8RhOLN/Dm8A==
X-Gm-Gg: AYBFou0XvYEdWrxls6TmLZodr4fUTMA5fsp/tMb4N6URjhB+kN3kyVwaMByp+/k1zNv
	FZFzdQLy3pTCTiL8MFOklwuFxUOUdBuDUPZuADtyLieCN+uwRHbPjGobqcTtxhV9BRJz0dBlxTq
	AbkJCITkr2zZuX83ZAG4yYqIMBBQAwMGL+/Eel6FvtKX0+jy92qmU5t+s13vBxLwujgPy4rEg68
	TqlGcRxYoirN24LXMvEJklB4cUcxsViKZMk0k+1OXoqE0qNaikeJjvjr29TLCgAjuR7orUZ5WvO
	KyfZ71gsm7IL9khs/8g3JXP/lvPX9Pp5WEq+Vm7ZWSiETsGNil2o7bdKb1eGRG1NitQjyizGfBt
	VEWN47Hn1DHkEKeVOzPEOmvU+DKlu0O2j6GtRzC1G8E5AEwMxuO2B9nz3hfRO5dhZI9KWYsgP8P
	vWnhXj60QqcMCNZZOCkA460Ne4s6IG1cbk
X-Received: by 2002:a17:90b:3886:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3b182f2570fmr1699709a91.23.1794404828635;
        Wed, 11 Nov 2026 05:47:08 -0800 (PST)
X-Received: by 2002:a17:90b:3886:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3b182f2570fmr1699688a91.23.1794404828126;
        Wed, 11 Nov 2026 05:47:08 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dfb9827sm4890431a91.1.2026.11.11.05.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 05:47:07 -0800 (PST)
Message-ID: <18db783d-afef-4cd7-8192-00f1970da7ae@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 21:47:01 +0800
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
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to non-boost
 freq on boost disable
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <41f328b2-0825-4023-b86c-48136ba6ecd2@oss.qualcomm.com>
 <avRd3YVDXs26hrow@hu-anancv-blr.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <avRd3YVDXs26hrow@hu-anancv-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX/AaaHbj/s2uW
 uUjpdNqMV5O+qSgO6v/bNbNXL8UAJLtbf8/ezhEQeYvHwk0AoRCqPPIIRNhKx/aocW7nKCCXQ3N
 TtXCTybaLRbRDIfzEUFW61sHRTu8kokCNV5iipF9wx0TBBbQ9c9rp4uhclrxGw5x1avjppZ8T9C
 VGK/JWffkdOuqeNaezHAg9fn0lS0P3PLMSGT3zlbaZGJKiLmvj0wgc8WIPvrdnFLpppdJUrVt7z
 10Tzk8BUmRQyHFrthpYX6dwJa7Z1jnCAgeUP20v1dLA+cdOdkK7QtyzPeydECHsSkxm6goUF4f3
 DZ0U4Nw3eTakQtLktaDef6pfAahS9CNIS1lbVAMUoGq+tsjBf12tzaVMe51usJu9VjEwI5uKEzv
 rPkNXYD8qaPOfOeBm4Qaw/Iph0kJIeTkBgtwvcRXyyXCGpuREV+uZJKq9XoYkq+sD3PTC1pNI/u
 0RkzpFVrlYzDiImvnww==
X-Proofpoint-GUID: FfGvaAE7xJUA8U-lUXXdXjuxm-v31fRv
X-Proofpoint-ORIG-GUID: FfGvaAE7xJUA8U-lUXXdXjuxm-v31fRv
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af471dd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=qZlHrcwyowrLkl4W26AA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX6DkJmRPtTlsR
 QoIPD2M0UnXje2XIaFPaIVGHgbbxnMO0vZnDOC/SzBq4yBeQyBU+C6MS0vGFiLWIHJX5JTKuas6
 ljwQYggw1dgxlNeV9bctJ3xEpCxb52E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110054

On 11/11/2026 8:21 PM, Ananthu C V wrote:
> Hi Zhongqiu,
> 
> On Sun, Oct 11, 2026 at 10:17:14PM +0800, Zhongqiu Han wrote:
>> Patch 2/2 currently depends on a helper introduced by patch 1/2, which
>> prevents it from being backported independently. Since 2/2 is an
>> independent fix that should be backported to stable on its own, I think
>> it should be placed before patch 1/2 in the series and kept self
>> contained.
> 
> The idea was that currently patch 2/2 would serve no actual value without the
> fix in patch 1/2, and that is why it was the second one. But yes, we cannot
> fix 1/2 and leave 2/2 as is, which would turn the current benign issue to an
> actual problem, so the order should be probably reversed. I'll work on that.
> 

As I mentioned before, patch 2/2 addresses a separate issue that should
be fixed in its own right and backported to stable kernels, because with
policy->max stuck at the boost ceiling, scaling_max_freq keeps reporting
the boost frequency after boost is disabled (as shown in the cover
letter), and governors such as performance can still select boost
frequencies. Anyway, please go ahead.


>> To avoid introducing a new member that is only used by frequency-table
>> drivers, please consider the following implementation instead:
>>
>> If there are boost entries in the frequency table, the table is the only
>> source of cpuinfo.max_freq, so let cpufreq_frequency_table_cpuinfo() set
>> it unconditionally in that case.
>>
>>
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>> index ea99464..8c8bad2 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -33,14 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct
>> cpufreq_policy *policy)
>>   	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
>>   	unsigned int min_freq = ~0;
>>   	unsigned int max_freq = 0;
>> +	bool has_boost = false;
>>   	unsigned int freq, i;
>>
>>   	cpufreq_for_each_valid_entry_idx(pos, table, i) {
>>   		freq = pos->frequency;
>>
>> -		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>> -		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>> -			continue;
>> +		if (pos->flags & CPUFREQ_BOOST_FREQ) {
>> +			has_boost = true;
>> +			if (!cpufreq_boost_enabled() || !policy->boost_enabled)
>> +				continue;
>> +		}
>>
>>   		pr_debug("table entry %u: %u kHz\n", i, freq);
>>   		if (freq < min_freq)
>> @@ -50,17 +53,20 @@ int cpufreq_frequency_table_cpuinfo(struct
>> cpufreq_policy *policy)
>>   	}
>>
>>   	policy->cpuinfo.min_freq = min_freq;
>> +
>> +	if (min_freq == ~0)
>> +		return -EINVAL;
>> +
>>   	/*
>>   	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>> -	 * it as is.
>> +	 * it as is.  This does not apply to tables with boost entries, because
>> +	 * the table is the only source of cpuinfo.max_freq then and it needs
>> +	 * to go down again when boost is disabled.
>>   	 */
>> -	if (policy->cpuinfo.max_freq < max_freq)
>> +	if (has_boost || policy->cpuinfo.max_freq < max_freq)
>>   		policy->cpuinfo.max_freq = max_freq;
>>
>> -	if (min_freq == ~0)
>> -		return -EINVAL;
>> -	else
>> -		return 0;
>> +	return 0;
>>   }
>>
>>   int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
>>
>>
>>>    	/* in 10^(-9) s = nanoseconds */
>>>    	unsigned int		transition_latency;
>>> @@ -791,6 +792,8 @@ struct cpufreq_frequency_table {
>>>    int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
>>> +bool policy_has_boost_freq(struct cpufreq_policy *policy);
>>> +
>>>    int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
>>>    int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
> 
> I wanted more discussion on this part regarding finer implementation details
> and hence went with a working version, and I think I asked in the last revision
> thread regarding what are people's thoughts on this added field. I am also not
> keen on adding more fields, so this is useful suggestion. If we are to continue
> this implementation route, I'll keep this in mind, thanks.
> 
>> Thx and BRs,
>> Zhongqiu Han
> 
> Best,
> Ananthu


-- 
Thx and BRs,
Zhongqiu Han
