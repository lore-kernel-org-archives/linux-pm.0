Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF44FDE58
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793680; cv=none; b=UrfX8YFLy2IRdSiCDCp8HdsCAlTWIJYs4fs4mGIl6ENdxidALukD5mffVkdZNrb2YvrZgJXRSjBAR5sD3+s3fCgs7CcNVWHU6ztz+r8/x9VEfkF5dvnfS/j20KxF8xgyje5wyUOj5s05aMe3DKO39C+B5qUxdqbjCfMUZpzP4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793680; c=relaxed/simple;
	bh=/niUvrQSjMY6hyizwdjXYSe3+sCnv2fNEzngp3i/4/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrR/ZPYhdLFzM7TdKuair+5z8Og5+3jtfJl+FK+uEFxX7IKZq7pf3VCISxyc5Jw8S6cZ+4fiitemg1RZewCo5XfqD/PeFMHiZ/ZzuXFeHsQ2ksFIQc8eS11kI/vrk0N2nZKCSBmthhQxmLZWG1OUqrb7yTUngTuHNwRbLMI7+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bS0820qs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCu6KZ0y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bS0820qs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCu6KZ0y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdLQu3025777
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 15:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBkx28e6CDDYOeoLfBIRnbyY+M3hR/zkH2OesylczpA=; b=bS0820qsyPdugoc9
	L38EbLRzTj3Xumz/dviJsbxnHpJLzHeKiOemD6ASoMi0GSGOjhWDMlgL/u0JuzFm
	yc95+EQgV8FRUr0idzYZOTUq5z3UTR1t+0/Avni45bSC1RK2V0FAlWcRSSb3lMD8
	Byf4J9Jih0emxWmdPf8rB4Rbhnt5/5wfEe8NZiEc7lBN+fcdKrmpkvSrOuuUb1ha
	rtAmczc2p/jqMJpaX7Zrd8XjzoQR+Cq64yil1VFTEwQDyPHG9duHF0/0jur2cxDg
	kelLZGNW0HfoTq6jnGysRLFgXDaPfZWzuwcpsWU7ufoV+tlUoRX8JNkBybCsicIw
	tkYs3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty173q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 15:07:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2044569a91.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788793676; x=1789398476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBkx28e6CDDYOeoLfBIRnbyY+M3hR/zkH2OesylczpA=;
        b=ZCu6KZ0yYK21QBR2qfGO/P2L3vKeKRHoJboP/JDSSdVG4jyp+u6MS0STKgJqwPx5tc
         B8Q2ApyZ8gDsMnOmizvR10bGr0VHGxgkO9EgCuxNirjibhIDzRue0HG018xYZK8q8g7u
         UBFrMs7kw/1dlBes6XZPGMOwdOQqK5cR4LPl/g5XG0FEkqCKo7xeqvek2BRQk02yvpsh
         AFsaFcPn6N9wvQOTOPlEDifpZqHIZPmS6UXyZKpk118ShZXBeN1nzHdgjOROtsMbJdG6
         3e6Rkh30HtV/VSbc+hUhgavTlFcllzP/YNU+zyZhSfT4mITzSDEdOwwbdVUB4YJ39oir
         Y/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793676; x=1789398476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBkx28e6CDDYOeoLfBIRnbyY+M3hR/zkH2OesylczpA=;
        b=rsafNVNtuohQrayT3NwZfrolNgtsJiYkDHwV9eP6YeDmcUnn/1uZMKGeVSJ/VGFH5x
         6ZDaJFHfrY3bHelwe31xn7DRFOrRXYdD/9CnS65uDA6VxcNdEt/Pcqq4TJHXTVHOwID4
         vtd7dfKKMF/EkiBa9Zy6aSuzHd3eS4V2tEhUHrca+CgQhJY98cUMINIEvn3Ituzyr5uN
         g68YwaclbVQPmEK7xOsoJ21phvaPKtE6ZV35dHR6D0vIAcmZySscQsJ0HEnviqKFzEcM
         4NmLEOsU2Jtj8HfCem691a5htM185Y1vUg3Aqb+Skj3PL0O+6WCMlInzYE/8wccD4Cri
         aBlA==
X-Forwarded-Encrypted: i=1; AKwUvBxCSEW+f3fvaKrsssvTP7QMYpGSh6Sh0BLuG4iPGMda3RQ09/mHUaQJx9yM4F1zOqWN+FzM5dGnng==@vger.kernel.org
X-Gm-Message-State: AFuF++nTUo1dzwM6sTdGCd7YJ/GIpg7GYPSnt4zcWu8iF2X8OdSpuaBe
	3Ec9TmBCM4bXttQl0oLPgR4a4+mDO8rXrRkweRUYAHvLwuywFquDfPiWbIp8gungM2vpX+f5jKB
	sbrvvGoWDYRzSfTjEBXyhsj7Irytagv4cNS/W+IxEtyGOa14wdMRigWMpdeJhBA==
X-Gm-Gg: AYBFou2fDGjX5vI8DXuNEtzl1orjZB0Qhp7ZTl4xBszUh8PTvXZXzNAlAUb+0m/6u9M
	m0HJboklRF3WpnEVizBPIrtZ0aScSbw+0CcnYsahqpqV7o8AjruvDCAVm4yr0kmS3cKnh0nHIG9
	qfBUBLcn2PPagS552j5KJ3gh497d70w/UrMa/E4wyP+UKGTnmpCRrKTEMTU4poJYdayiNjpBNGR
	6CYLvdd6qtI4bsZSht+FePJkXuBpWnzUbhrj/1sMGflCAESoGYr1vuiQes733q0XBbH74iMx5gU
	JNVjxv3+uUdfX8plHK5iChu2RFIKOj5sj1CHUxYdJ6A3Euyf9qceGIHSOiY59LISHrUjBlNez/q
	IscNv/lcJCxYSkEvGgCpsrZ47KEc0KH/rBmwK5QwoT2GZM3ZuIrarJ0bj5JpHodLW+bxjdp4=
X-Received: by 2002:a17:90b:264c:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-39b2612f7dbmr35531391a91.10.1788793675414;
        Mon, 07 Sep 2026 08:07:55 -0700 (PDT)
X-Received: by 2002:a17:90b:264c:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-39b2612f7dbmr35531287a91.10.1788793674723;
        Mon, 07 Sep 2026 08:07:54 -0700 (PDT)
Received: from [10.133.33.48] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f8d2c5sm21727174a91.2.2026.09.07.08.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:07:54 -0700 (PDT)
Message-ID: <3c7be2f1-b1be-4f6e-948d-e1991d8afa6b@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 23:07:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Ignore idle periods when a policy
 CPU is busy
To: hu.shengming@zte.com.cn
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, luo.haiyang@zte.com.cn,
        zhang.run@zte.com.cn, zhongqiu.han@oss.qualcomm.com
References: <20260907185517424rOcCTgNPmgf1i0mLqlxWN@zte.com.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260907185517424rOcCTgNPmgf1i0mLqlxWN@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9ed34c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=xReM8kcvFljezQIKS3QA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: -e0m0z7HnYlhgGByNbwUrqoQ8lKCOGbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2OCBTYWx0ZWRfX42hUt/pFCMED
 EwhAe1QY532PR+vXGihbH1lMeeMLyBu9972ic9NvcuyvJumyIfCX0vKtQqkmWVq27F+Vx6+wn5r
 /qMkH/ue58RnrHshM93tZMttoqEwatY=
X-Proofpoint-GUID: -e0m0z7HnYlhgGByNbwUrqoQ8lKCOGbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2OCBTYWx0ZWRfX2+n8/0MWm/it
 qto3WF94p+3hVoTTEhBBRCSUnWB6ysFgJSrxFyTx+so01eMrfxkj6vVmum5n5EW/mDSFMZZn46g
 o29JEELfi3PmyFzm6gO87ezGQdS9Z7BJA7e2dfyx8weZDDLoq1yLAeGTbykpQ6odnkqXDwykXbe
 Nvid3rxna1peSFmLFVJoAlZH+C5F7siXEGk3He8jFVvXW7CCeO5UIl2iG7XbRZeZTSaRjNESHmj
 T4MSoaRhAduKQwCGTAcJ6q3vD+8ReflFdSnuDZlgpHLYjB6yPhlRGne/JX52zLmnbmt2HwljMrm
 OIRDkQ4vNmdrH2kuhnu+PVl8VZtYdDcTLSMJ18QsXXHsMoHK8MS5IWckQYwbaXgKpx5cQUoApmL
 gE964wo2Yb3ArrdQnK3oER9Aawqpx4IeI7TJ6SKrFZlt9/IdDsgdMAqqyhMoedkd3opPEWfC3ID
 l1bPCqk+zFE1SjfYs1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070168

On 9/7/2026 6:55 PM, hu.shengming@zte.com.cn wrote:
> Zhongqiu wrote:
>> Hi Shengming,
>> Thanks for the patch.
> 
> Hi Zhongqiu,
> Thanks for the review!
> 
>> On 9/2/2026 3:47 PM, hu.shengming@zte.com.cn wrote:
>>> From: Shengming Hu <hu.shengming@zte.com.cn>
>>>
>>> For a shared cpufreq policy, dbs_update() derives the load from the
>>> highest utilization among its CPUs, but it also records deferred idle
>>> periods from any CPU whose idle time exceeds two sampling intervals.
>>>
>>> This lets a single update report both a high load (from a busy CPU)
>>> and several deferred idle periods (from an idle sibling). Since
>>> conservative applies the deferred down steps before the up step
>>> triggered by the high load, the down steps can outweigh the single
>>> up step.
>>>
>>> The issue reproduces on a policy shared by CPUs 2 and 3: a CPU-bound
>>> SCHED_EXT task keeps CPU 2 at 100% utilization while CPU 3 stays
>>> idle. On this system SCHED_EXT generates update-util callbacks less
>>> frequently than CFS, so DBS updates are sparse, tracing shows:
>>>
>>>    load=100 idle_periods=7 interval=59 ms
>>>    load=100 idle_periods=4 interval=39 ms
>>>    load=100 idle_periods=2 interval=19 ms
>>>    load=100 idle_periods=7 interval=59 ms
>>>
>>> With the default 5% step and a 2.6 GHz ceiling, conservative first
>>> removes seven 130 MHz steps and then adds only one. Repeating this
>>> sequence keeps the policy near 530 MHz despite CPU 2 being fully busy.
>>>
>>> Only retain deferred idle periods when every CPU in the policy meets
>>> the long-idle condition. This keeps the existing behavior for
>>> single-CPU and fully idle shared policies, while preventing an idle
>>> sibling from downscaling a policy that contains a busy CPU.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
>>> Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
>>> Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
>>> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
>>> ---
>>>    drivers/cpufreq/cpufreq_governor.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>>> index 710d93ec89b5..64eb6b5f08a4 100644
>>> --- a/drivers/cpufreq/cpufreq_governor.c
>>> +++ b/drivers/cpufreq/cpufreq_governor.c
>>> @@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>        unsigned int ignore_nice = dbs_data->ignore_nice_load;
>>>        unsigned int max_load = 0, idle_periods = UINT_MAX;
>>>        unsigned int sampling_rate, io_busy, j;
>>> +    bool all_cpus_idle = true;
>>>        u64 cur_nice;
>>>
>>>        /*
>>> @@ -233,13 +234,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>
>>>                if (periods < idle_periods)
>>>                    idle_periods = periods;
>>> +        } else {
>>> +            all_cpus_idle = false;
>>
>> The problem is real, but I don't think this condition is the right one.
>> idle_time > 2 * sampling_rate tells us how many sampling periods were
>> deferred for that CPU, so its negation means "this CPU was sampled on
>> time", not "this CPU is busy".
>>
>> Since all_cpus_idle is per-policy, one such CPU is enough to discard the
>> deferred periods for the whole policy, and in a shared policy it is
>> possible. That effectively disables the optimization from 00bfe05889e9
>> for shared policies, which is the opposite of what we want for power.
> 
> Agreed that not meeting the long-idle condition does not necessarily
> mean that the CPU was busy. The condition is based on accumulated idle
> time, so it is not a reliable indication of whether that CPU should
> prevent deferred downscaling.
> 
>> What matters is whether the CPU was busy over the sample, that is,
>> whether the skipped sampling periods would have led to a frequency
>> reduction at all. It seems more appropriate to key that off the load
>> measured over the sample (kept separate from the possibly inherited one)
>> against up_threshold, so an idle-but-punctually-sampled sibling does not
> 
> Thanks for the suggestion. I agree that the load actually measured over
> the current sample should be kept separate from the load that may inherit
> prev_load. However, I don't think up_threshold is the appropriate
> boundary for deciding whether deferred down steps should be applied.
> 
> For example, suppose CPU A has been idle for several sampling periods
> while CPU B has a sustained load of 75%, with up_threshold at 80 and
> down_threshold at 20. The policy is then in conservative's hold region,
> so the load itself would trigger neither an increase nor a decrease.
> If deferred downscaling is gated only by up_threshold, CPU B would
> not block it, so CPU A's deferred idle periods could still reduce
> the policy frequency.

It seems not, in func cs_dbs_update(), idle_periods only affects the
local variable requested_freq, and that variable is never actually
applied to change the CPU frequency while the policy remains in the hold
region.

> 
> I think deferred down steps should instead be applied only when the
> maximum load actually measured across the policy is below
> down_threshold. To keep this independent of the load returned by

The two gates only differ when the measured load lands between
down_threshold and up_threshold and the load used for the decision (the
inherited prev_load in that case) triggers one of the branches - if no
CPU took the reuse path the two values are equal and the outcome is the
same.

If we use up_threshold --> the deferred downscale is only given up when
the CPU is genuinely busy enough to warrant a frequency increase; in all
other cases it still scales down as much as possible. This stays closer
to the design of 00bfe05889e9 ("cpufreq: conservative: Decrease
frequency faster for deferred updates"). When the measured load is above
up_threshold, we skip the deferred downscaling; when it falls between
down_threshold and up_threshold and the load used for the decision is in
that band as well, the frequency is left unchanged either way. This
fixes the bug you described while avoiding any significant power
regression.

If we use down_threshold --> the deferred downscale is skipped whenever
the load is not in the lowest (downscale) region. it can cause power
regression.


> dbs_update(), which may inherit prev_load, we could record the maximum
> measured load separately in struct policy_dbs_info, for example as
> max_sample_load.
> 
> The conservative governor could then gate the deferred reductions with
> something like:
> 
>      if (policy_dbs->max_sample_load < cs_tuners->down_threshold &&
>          policy_dbs->idle_periods < UINT_MAX) {
>          ...
>      }
> 
> This preserves deferred downscaling when the measured policy load is
> below down_threshold, while avoiding deferred reductions when any CPU
> is in either the hold or upscale region.
> 
>> May I know could you comment and try this patch on your scenario?  Once
>> everyone agrees I can send this formally:
> 
> I'll rework the patch along these lines, keeping the measured load
> separate from the inherited load and using down_threshold for the
> deferred-downscale condition.
> 
> I'll send a v2, with a Suggested-by tag for your suggestion.
> 
> --
> With Best Regards,
> Shengming


-- 
Thx and BRs,
Zhongqiu Han
