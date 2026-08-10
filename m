Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0A361DB1
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355660; cv=none; b=SRvYRUzdVc8hzJ7wA96h72xkq+IVRumHouVuOcpfJzUrMPthc018XlhUn/4/aVDkPnRb4OyoKX2uI3tXwcPxLrlF46SXkijlnDKDDAbf80otiQlme4mDyJMsz3bc+49F3qjLpoZGp3/NITLMVJfwNqzkL7AzkiHUJHW8Oooy93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355660; c=relaxed/simple;
	bh=cKOor2fNTKRGf+jPzcfQ4SSvtrlkntAd67pXDZl2Ock=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHxMmy6idO0pIre2hRqGI6Ih6L/yKTjzKLMVuyQde8b4HYbWx8a3lDqrqr21jmZ4vtwnXZSzRv/GQ88Alcxu7GfiY+S1567SOJFmw5TR1Q6fPmjxDG8IjIJ5US0gAzBf3pp8pKnoEddtrhSc2apiH3b0WCAQ2m65PTTdm6WjbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8vMUjRp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bo3UHqDE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8vMUjRp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bo3UHqDE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9SE3r446754
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 09:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E1yaupPD5ZYBbc+QOdbQUWR4btXhlOZTk84i+SjbBKU=; b=N8vMUjRpLTKymt1J
	MV99G/o+nFcMOhEUVjpTJyJYM2gjruCUIPdmZ6ubfR1pU29GJn78M2NjqHnLQXng
	luKXhXxWGQcYXkbSeRXnOeQLHGmpux5Bv9+llHS2fdprQ9kdzKfFezeS+UbotdZI
	zO3Bz+lnHMtkjiFEmt6UGZqXJ2qz4unGTiKWv/8plzV+BOGaruoKErP597SdbKMu
	wWBXyWhzUgvS5MBAMK+f1LBDSVmUVM/vOtRJ+lfIJhxB0I28TFoSJ4kfgKxdwYZ2
	PWjR9sr3x5fr78pKrc7fOEsBHgvtH6b1jgIgeTlfUT66mhpCDis/ybhjuWPWOWVG
	O191fA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v90v3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 09:54:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2caf4173b1cso37654075ad.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786355656; x=1786960456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1yaupPD5ZYBbc+QOdbQUWR4btXhlOZTk84i+SjbBKU=;
        b=bo3UHqDEozuCkfNBzcDoPc8IgeU0RjbSHu3RQzK+kn29vB0gjDRZ8HNTJJ2+k3IVST
         zy1nEemjmbcZHmY2xS02C/X6j0RlHZFboJMmf66lp3kCcLwZDj/yRdRNTQuE3++wRyzo
         aQe86mqwQialF7b3iUmygEZ0FUrRNwVLkEsLesShgW/74k/d6fIqskcOWOFzvLRXd3rk
         dMHjqhzdGQz+yNVmXfsR60XNE1j0Vfo1+SeIjnQy7KAyaC5gt+VBcjDo2SCaywbt/olk
         oWOh6Cd0/KVVxXXtXybHAke1Ip87Y3cgqdY3zYO0wEd+xdIIjLvkLytHImN7SMUhXSz5
         Jctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355656; x=1786960456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1yaupPD5ZYBbc+QOdbQUWR4btXhlOZTk84i+SjbBKU=;
        b=R/P4bXbGb1wac/OH1umglO/O6gbz3AwMQfXI6cOfNz03+vf0sOh39GAXPxu+mPnPew
         gaIZp31h8wDs5RhGuPFNTUX3erXqmNKCfCw6qG4VFhyBiVPYSuGAvhNOFMScyrqvGeu9
         oHnFOVjfBpiOtBxKzAWaQ2qCbCKzZMFVoKGnNda8o7EwNbqa2emQv8mhVY+x4B2OxpEC
         fPy3zcC3iC7KE0uKAtaP0lVwkdIFr1ggc2dMdLv/BpY04dAtvrWbnQEwpjd4dz+nGOL8
         jpVjyu+/mXWGEyOQj86b7i/e3NTWXPmLiSXAsfLdyrWw3y6Qi36s/9VU7ntFvNmlqcfI
         6IvA==
X-Forwarded-Encrypted: i=1; AHgh+RpSN1wFoYAALUCvTR1Njnk4rvWGutljoT4+ykFk2K1I+14tCQOn+8t3QzmLcMNaGcV0OTQktk6+Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUSMyq9yUlfa8FosZlS5iC8LBrN/U90B4VbRBEmb3tCvbFhtC
	0sLqX//doKryHfUEfucvrB8PQKDr7ywBH7422yPrsRyhfS0ATQ0s+brxktVplFRbTtimAwidXEF
	y+H2JC/1i8UP9RKydGdxfjJDCMPxcbRMA2lAx/2p3HWnWn+NKx0joeLPQ6mSz8g==
X-Gm-Gg: AR+sD123CTZu1WgbqddugGBahFj/MO1Gh0ItAr+Q8+J+SMZAF8To6xv01myDibUk0NL
	KjanuXcIEYj6KBQN4pzy61TpEWkgjtIpksSwKc9gZSEGQKjbkQFsasZe3657ghsScjpRP8q+vBo
	pKwE0zxs9N4KsNDuxhWWiiqjnUY4zOZJWOWsi9TginxCm4vv1XPnL6EyA9+1KpRa6mgo+rFVhv+
	/uW1c8peZuynhXvR4cd+hMGtbra8ILZw0MnTKMoPl8I/a7eDPT1VXBwRuvM3K+gMCE/DhC2aWTa
	Ml1549d9R/PFtt2oOs7KDXN7SRGssNQ4KtsjYRXfRn0o9Cx6LqbcyD8PwQWQK0o+/4Fv2o7Tu6B
	QdpCUSKPIp63lfJoniBy8qRPfAYNj7vaVYowZ/RBgoy56kNHoiq2pUjEmGrFDg3u4LJE8hvM=
X-Received: by 2002:a05:6a00:2187:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-84f5e0c4b15mr23847264b3a.32.1786355655677;
        Mon, 10 Aug 2026 02:54:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:2187:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-84f5e0c4b15mr23847227b3a.32.1786355655243;
        Mon, 10 Aug 2026 02:54:15 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a596a10sm3708327b3a.60.2026.08.10.02.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 02:54:14 -0700 (PDT)
Message-ID: <3a20b69e-b072-4723-925f-514d8162e259@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-arm-msm@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
 <54e74486-12f2-4b09-916a-1a8806871b6c@oss.qualcomm.com>
 <18d763f0-d817-45d3-8c79-10639d5a5e47@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <18d763f0-d817-45d3-8c79-10639d5a5e47@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA4NCBTYWx0ZWRfX3it3i1ksMfyE
 C7dUo8J6NtqNrLSuGAyKYG1Xn49+sp6T+SKSw6z8JH3RPdFCDq6xzPawjA3tTYXGn9Jb7nAjVT6
 cK0yPu3dU0XonqbUQOra3a5rSKoM5ak=
X-Proofpoint-ORIG-GUID: -jwaa6D7d6D5C1OCzTK1wZIZyT7foKUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA4NCBTYWx0ZWRfX6KQRbhT+TXkh
 USLLQcW7G1LUjoHMBeedvx7Qyux3xz9O69v8P5oHeIn/m08m2uuD6KbtKej17Tdwmp7Hs2wgT0g
 8dwvPgplrmSRO8f4ZKe6pKFfmnyMU21ATpm9v3iYJoE41XDHRDO3+d/V4Ib8C2OJLRIEjzcDeA0
 XlE6Pz6LdxnS77LRzvxBGKcLMCOaCKlbj+WDzXEfFHtX1TT+GjjoT3qLj+M4yEvJafUAkWWu8Y6
 FDy9fbALWiUd4wEZDN8ZbGmGZf+BjQnhiGZ2GAcE1vOUYaYszkWgvq0tJBh9ZYCtD29dlkn9TUU
 NuokRbjzDTd8P74s2HYHIN1GKc0iBG+LIHv+m3haXOYgK9S749LDrlb4fD0BP5Ja5cG3sb6Hk5Q
 ZD0uK7pgTaTHgHlEiY+LHGxCk6RsUWPD61QIhI2625LxHYIH9ktYQXiOl5A2bD4AmBNT5t/auNL
 LqRi/XRkSaWV1DAbW9Q==
X-Authority-Analysis: v=2.4 cv=T5m8ifKQ c=1 sm=1 tr=0 ts=6a799fc8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=oDw6gA2hALo5y0joJwwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: -jwaa6D7d6D5C1OCzTK1wZIZyT7foKUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100084

On 8/7/2026 10:23 PM, Sibi Sankar wrote:
> 
> On 8/6/2026 4:52 PM, Zhongqiu Han wrote:
>> Hi Sibi and Ananthu,
>>
>> On 8/6/2026 12:42 PM, Sibi Sankar wrote:
>>> From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>>
>>> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
>>> if max boost is known") guarded cpuinfo max updates to only allow
>>> increases, preserving values set directly by drivers above the freq
>>> table maximum. This prevents cpuinfo max from decreasing on boost
>>> disable, leaving policy max pinned at the boost ceiling.
>>>
>>> Remove the guard so cpuinfo max is always derived from the frequency
>>> table scan. Drivers that correctly flag boost entries are unaffected
>>> since the scan already excludes them when boost is off.
>>>
>>> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if 
>>> max boost is known")
>>> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>> ---
>>>   drivers/cpufreq/freq_table.c | 7 +------
>>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>>> index ea994647abc8..791118466ca4 100644
>>> --- a/drivers/cpufreq/freq_table.c
>>> +++ b/drivers/cpufreq/freq_table.c
>>> @@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct 
>>> cpufreq_policy *policy)
>>>       }
>>>         policy->cpuinfo.min_freq = min_freq;
>>> -    /*
>>> -     * If the driver has set its own cpuinfo.max_freq above 
>>> max_freq, leave
>>> -     * it as is.
>>> -     */
>>> -    if (policy->cpuinfo.max_freq < max_freq)
>>> -        policy->cpuinfo.max_freq = max_freq;
>>
>> As I understand it, the guard added by commit 538b0188da46 is
>> intended for drivers (e.g. acpi-cpufreq and AMD) that may set
>> cpuinfo.max_freq above the maximum frequency in the frequency table.
>> Removing it may cause those drivers to lose their boost maximum
>> frequency.
> 
> Yup, we did mention the same in the cover letter.
> 
>>
>> The regression should instead be related to commit db80ad776cd2
>> ("cpufreq: Remove driver default policy->min/max init"), which removed
>> the "policy->max = max_freq" initialization that previously allowed
>> policy->max to track the result of the boost-aware frequency scan.
>>
>> Please feel free to let me know what you think. Thanks
>>
> 
> The commit db80ad776cd2 is unrelated. The problem comes from the
> fact that policy_set_boost uses policy->cpuinfo.max_freq in it's
> freq_qos_update_request. If we modify it to use a frequency that
> adheres to the boost and per-policy boost flag instead might be
> the right thing to do here.
> 

Hi Sibi,

Please let me know if you see any issues with the analysis below:

[Background]
Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
max boost is known") made `cpuinfo.max_freq` hold the CPU's real
physical maximum independently of the frequency table — for drivers
whose max boost frequency is not in the table and added the
if (cpuinfo.max_freq < max_freq) guard so it can only be raised, never
lowered.


[Root cause]
Commit 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request") changed
the value fed to the boost QoS request from the boost-aware policy->max
computed by each driver's .set_boost() to cpuinfo.max_freq,
overloading one field with two conflicting roles: a boost ceiling that
must track boost state in both directions, and a constant physical
maximum. Only cppc_cpufreq_set_boost() and amd_pstate_cpu_boost_update()
were taught to update it in both directions; cpufreq_boost_set_sw() was
missed — it can only do so indirectly via
cpufreq_frequency_table_cpuinfo(), where the 538b0188da46 guard forbids
a decrease. So on boost-disable boost_freq_req can't be lowered and
policy->max stays pinned at the boost frequency.


[Trigger]
Before Commit db80ad776cd2 ("cpufreq: Remove driver default policy->min
max init") removed policy->max = max_freq, that write still pushed
policy->max down and masked the issue. Removing that write just made it
reproducible.


[Conclusion]
Removing the Commit 538b0188da46 guard maybe therefore not the right 
fix, the drivers that rely on it would lose their real boost maximum at 
init. The fix should belong in policy_set_boost() / 
cpufreq_boost_set_sw(): source boost_freq_req from the boost-aware table 
maximum instead of the sticky cpuinfo.max_freq. `Fixes:` should point at 
6e39ba4e5a82.


>>
>>> +    policy->cpuinfo.max_freq = max_freq;
>>>         if (min_freq == ~0)
>>>           return -EINVAL;
>>
>>


-- 
Thx and BRs,
Zhongqiu Han
