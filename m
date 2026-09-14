Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F52F28FC
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373641; cv=none; b=R1BtLKsJSMy193JB1XRoVj2q7Vzuwh3L7NN/tboicixHonLAO0cJbIvt5nIJJG9y6u8Rq9cAkz4avq/wow2aegGL52C1kQce7LJ0U/Azfq8M9H5UnxiM3bVgL+8IQfa/O3OpHcloYJuaW214fQ9akQu1Khl2S/jkA7oXId30J14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373641; c=relaxed/simple;
	bh=Jb3U0HZH3PFikVWAOk1WwKiv1FxSg1cSRfqWRtymoOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSh6A31nnzP2AoFzU14xkocfmEtf6qOc7HfRSrNtaPT3KSbk6Bj8RadVuxUj47hPt1rgNpdBpDrVWSxA+8ONtSpe3UESobWIJU7IZar8A7cbegeB5xvanMatlNZvx+1s6Ln6Ytn291a5zf/WXNfCeMJUCktV8DNJJasEDq+J7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVLX90Oo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=It35xBfp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVLX90Oo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="It35xBfp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jY5O237713
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9HUT3ahUB7cfJ6PEdaYT4akYWy8N4hwwid2YOgZs8WI=; b=MVLX90OowmthEeCP
	gZyK1IXJGofhVb9jbnMDS3t/OrK1W5EHc6xi/tDr02q1tbKoQVvKdEIS6nG/jX46
	JWkUy1iiuBkIJkrCAu74mg0wD3GhRbYOLH5oXuaq0svZLsCLqdYVMsvkH634kMgc
	jP4MkDPOSlcnBjf8yrsWzbs920yCtCpQQiiyYIXB6BLLy2Ys/RrrjqfI4/LLoD6E
	LsNT7/EqsOK8tJB9onjjqPHSC+VVZlyaWIuZgU1WD3WSx9BglAUHM4TI14iXjiRT
	Vjbc/UpfVE2TyK4xq/l2BQx7XMJiPqk7/mRLdWrm0+JZ3sCxdBNJZIzZSxMgDj5f
	YEaUvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnq0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:13:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dcfed75f77so43849405ad.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789373637; x=1789978437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HUT3ahUB7cfJ6PEdaYT4akYWy8N4hwwid2YOgZs8WI=;
        b=It35xBfpYQa54SH1S3HI7m7SXdvztnRZynlVrzp68BGYv0sQ03NkFlKJYYsG2w3zDZ
         IVBqoScKNWOTx6pvflSyjZ0u0ALnb9vBg3WUFb1wVJ6QxIb8QI7j7eRKg6ohrg18CtGV
         d2kQMite+1TTiXVTl2nWhFUEDbtT/E6Il1rp5kLeh1e7XfDddzJfjHqd5Y8PPgdUlAOh
         YTP9kW4uW6v1AP3xRZQTPEGOg1J/DibXETAVhqrS2+Sk5/Py+5p9HhSHiXtamxI7iadg
         ah2Bab9KcNNNvlKGKUWVFS8Vgo+duAll8gIiZAV5r0znoir+FaZJyR1Kr25Q0vJn8byP
         3Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373637; x=1789978437;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HUT3ahUB7cfJ6PEdaYT4akYWy8N4hwwid2YOgZs8WI=;
        b=eQ3RU+zVQ49yIGyObcynDIDNvvQSeq9eTtXc4KZUMUAFt5Mfk/Ttp498wqa/5gdGKf
         tP9YukUTRKql5ZjwHqY0ri1jjkvtNuR+EYrl6fAAPmdHnR+OByCY8+biPWUCBTVfRmyL
         e5Qyq58F0pHXthXrJ426npW7Pd6bzn3sX/NWc+Apuftnf7rsRpKuh3U95umegP05/3E8
         ptiHaC58k8xTmA2EO+3wx0Tt+i6v2E/hPl0gsWwjsIUUuHl0oXmH3ZSfw4oWEzwDOlK1
         JzyOtWyeJLfJQkZSUgX0m8IpnnraBbm5xg2OtOetdt31g26jPXOp3JfW/fqusT9RqY52
         Xa7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6E7ADgxwGclukPYxORcaXGGwZRgMcQ+P3AzN125cgssWTyItsiqguKMyJBrqNYM1w93YW15gH0Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mUxSLFsPZmBHURZ7nHJJwlgo9cGmdQnzd1OGG4DFxJmOPVkEy+
	PCvXhNnP/nCkux4ptFDhBult+/WFQ9zaMnwYX6WFcwNA5vnnrm0v40AGAQwX8U7WQ2Irz18LAEZ
	m/ckJlgMXZgZY4bhqefvjFkbZsocWrNuZa+QxpnWrcQElM2dsv9ceNlI/maol+w==
X-Gm-Gg: AYBFou1Zop8nFmARaFn2xP9X3tP+Drya4WCyWsI8YeK2Q3jMG5qsXOZNpMAvV5oCL8O
	XpKAgD6ibkuiRLNrycN/0vGBBQdi/PIh4pMvJlZvlLhjPONG0mJA6keK+Z1K1gg26D9ehxpUcem
	CXVEsHw4iqRCyQ+LOgNKpdqUlbqj8RMGgBa9xmm9d0fj6K3xWQy9AAdDA9aq2xXvcIQNoedEbuN
	0oY1M/5+p9CAXbnQekL2Kqjgdz+eghECmNMLjShs8CrZ897etF+vX9MVlxS6gq9117/CKPYNbMl
	PEet9htYYol9hL+EfhAHl7qy4lgEZsY1jXraejLCMscKX2XbmsThEI27n4qeNSEFWOFNLj5NdTj
	aHTLGGXQF65xuqGBKV7cfVfbktrrPVQ/FcR92pyeBm5M1ZaTeSjTwBF1UcLSsm5CKBFa/7xI=
X-Received: by 2002:a17:903:22d0:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2dd6c70ac50mr32887515ad.17.1789373636863;
        Mon, 14 Sep 2026 01:13:56 -0700 (PDT)
X-Received: by 2002:a17:903:22d0:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2dd6c70ac50mr32886885ad.17.1789373636346;
        Mon, 14 Sep 2026 01:13:56 -0700 (PDT)
Received: from [10.133.33.31] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3e2dab98sm37415425ad.28.2026.09.14.01.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 01:13:56 -0700 (PDT)
Message-ID: <fafa1b19-8ae4-4f9b-b285-03cbb07f1127@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 16:13:51 +0800
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
References: <20260908233024442fFZQVoW9iOSFVh0a4lezw@zte.com.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260908233024442fFZQVoW9iOSFVh0a4lezw@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qAkz_9fDrV5e2wfYOXa2KHMYmR53j_Y_
X-Proofpoint-ORIG-GUID: qAkz_9fDrV5e2wfYOXa2KHMYmR53j_Y_
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa7acc6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=sWaoAfqMSZA8zoLs6G4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExNSBTYWx0ZWRfX7/Pf8e5HTWjS
 hgJLJfvazELrA4NbRAp9dp/szQmqJWnZmAw2YfDdhMw7+NtniEi3JeTDZzQV8bG5LuJ2eGuMycS
 T6FZ1RfXlfpCIon8w6FAYiNViyS3eJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExNSBTYWx0ZWRfX79osV5knJgFh
 eRO6P1TDEUQOpgp5XJQtIwegpGSJyfrfsteXL6ZMouprdEnXQt0cxWDw9inVkmeP2OTiMsYzEXI
 WR3st8pjv4HmxrU3uRFbFTJDWek/jqENnKw2Mk+KBSyEmtci0+90ddDjhwi/KFk0zmcwYPNJL7X
 fLh59gATp413nAybll/NHnVp+Deb7uxHMo2YvuKX6pCa+yKKWLUkvxf2M38gpEHYGPC04PrQ94Y
 4JHkpiXdGgoKfdYyg/wrhyB1Yv6kfC8b5HPm1cftycZtyI+i8qVLRjI24/eMtk1dhcnR4ktDT5V
 CLnNz0WbnvR5qohVn7osyNPuQQBo5b4mpD6T7NdzN2zwroK+HMbCCbhm0NLjvRC6eykloxDXtp9
 7UnjDnfGdDo7hUrrPskigdvdTnIfOoa9bJ6aL+5kaj4hoBILTf6BnrsP8MBFyWlHCLO0ioZdnpZ
 Mmb0aP/KksBzqXCMJiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140115

On 9/8/2026 11:30 PM, hu.shengming@zte.com.cn wrote:
> Zhongqiu wrote:
> 
>> On 9/7/2026 6:55 PM, hu.shengming@zte.com.cn wrote:
>>> Zhongqiu wrote:
>>>> Hi Shengming,
>>>> Thanks for the patch.
>>>
>>> Hi Zhongqiu,
>>> Thanks for the review!
>>>
>>>> On 9/2/2026 3:47 PM, hu.shengming@zte.com.cn wrote:
>>>>> From: Shengming Hu <hu.shengming@zte.com.cn>
>>>>>
>>>>> For a shared cpufreq policy, dbs_update() derives the load from the
>>>>> highest utilization among its CPUs, but it also records deferred idle
>>>>> periods from any CPU whose idle time exceeds two sampling intervals.
>>>>>
>>>>> This lets a single update report both a high load (from a busy CPU)
>>>>> and several deferred idle periods (from an idle sibling). Since
>>>>> conservative applies the deferred down steps before the up step
>>>>> triggered by the high load, the down steps can outweigh the single
>>>>> up step.
>>>>>
>>>>> The issue reproduces on a policy shared by CPUs 2 and 3: a CPU-bound
>>>>> SCHED_EXT task keeps CPU 2 at 100% utilization while CPU 3 stays
>>>>> idle. On this system SCHED_EXT generates update-util callbacks less
>>>>> frequently than CFS, so DBS updates are sparse, tracing shows:
>>>>>
>>>>>     load=100 idle_periods=7 interval=59 ms
>>>>>     load=100 idle_periods=4 interval=39 ms
>>>>>     load=100 idle_periods=2 interval=19 ms
>>>>>     load=100 idle_periods=7 interval=59 ms
>>>>>
>>>>> With the default 5% step and a 2.6 GHz ceiling, conservative first
>>>>> removes seven 130 MHz steps and then adds only one. Repeating this
>>>>> sequence keeps the policy near 530 MHz despite CPU 2 being fully busy.
>>>>>
>>>>> Only retain deferred idle periods when every CPU in the policy meets
>>>>> the long-idle condition. This keeps the existing behavior for
>>>>> single-CPU and fully idle shared policies, while preventing an idle
>>>>> sibling from downscaling a policy that contains a busy CPU.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
>>>>> Reviewed-by: Luo Haiyang <luo.haiyang@zte.com.cn>
>>>>> Reviewed-by: Run Zhang <zhang.run@zte.com.cn>
>>>>> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
>>>>> ---
>>>>>     drivers/cpufreq/cpufreq_governor.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>>>>> index 710d93ec89b5..64eb6b5f08a4 100644
>>>>> --- a/drivers/cpufreq/cpufreq_governor.c
>>>>> +++ b/drivers/cpufreq/cpufreq_governor.c
>>>>> @@ -126,6 +126,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>>>         unsigned int ignore_nice = dbs_data->ignore_nice_load;
>>>>>         unsigned int max_load = 0, idle_periods = UINT_MAX;
>>>>>         unsigned int sampling_rate, io_busy, j;
>>>>> +    bool all_cpus_idle = true;
>>>>>         u64 cur_nice;
>>>>>
>>>>>         /*
>>>>> @@ -233,13 +234,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>>>>>
>>>>>                 if (periods < idle_periods)
>>>>>                     idle_periods = periods;
>>>>> +        } else {
>>>>> +            all_cpus_idle = false;
>>>>
>>>> The problem is real, but I don't think this condition is the right one.
>>>> idle_time > 2 * sampling_rate tells us how many sampling periods were
>>>> deferred for that CPU, so its negation means "this CPU was sampled on
>>>> time", not "this CPU is busy".
>>>>
>>>> Since all_cpus_idle is per-policy, one such CPU is enough to discard the
>>>> deferred periods for the whole policy, and in a shared policy it is
>>>> possible. That effectively disables the optimization from 00bfe05889e9
>>>> for shared policies, which is the opposite of what we want for power.
>>>
>>> Agreed that not meeting the long-idle condition does not necessarily
>>> mean that the CPU was busy. The condition is based on accumulated idle
>>> time, so it is not a reliable indication of whether that CPU should
>>> prevent deferred downscaling.
>>>
>>>> What matters is whether the CPU was busy over the sample, that is,
>>>> whether the skipped sampling periods would have led to a frequency
>>>> reduction at all. It seems more appropriate to key that off the load
>>>> measured over the sample (kept separate from the possibly inherited one)
>>>> against up_threshold, so an idle-but-punctually-sampled sibling does not
>>>
>>> Thanks for the suggestion. I agree that the load actually measured over
>>> the current sample should be kept separate from the load that may inherit
>>> prev_load. However, I don't think up_threshold is the appropriate
>>> boundary for deciding whether deferred down steps should be applied.
>>>
>>> For example, suppose CPU A has been idle for several sampling periods
>>> while CPU B has a sustained load of 75%, with up_threshold at 80 and
>>> down_threshold at 20. The policy is then in conservative's hold region,
>>> so the load itself would trigger neither an increase nor a decrease.
>>> If deferred downscaling is gated only by up_threshold, CPU B would
>>> not block it, so CPU A's deferred idle periods could still reduce
>>> the policy frequency.
>>
>> It seems not, in func cs_dbs_update(), idle_periods only affects the
>> local variable requested_freq, and that variable is never actually
>> applied to change the CPU frequency while the policy remains in the hold
>> region.
> 
> You are right if both the measured load and the load returned by
> dbs_update() remain at 75%. In that case neither frequency branch is
> entered, so the idle-adjusted local requested_freq is not passed to
> __cpufreq_driver_target().
> 
> My example was incomplete. I was referring to a case where the measured
> policy load is 75%, but the load returned by dbs_update() is above
> up_threshold because another CPU reuses a high prev_load.
> 
> For example, consider a policy shared by CPUs A and B, with
> up_threshold=80 and down_threshold=20:
> 
> CPU A:
>          current sample load = 0
>          prev_load           = 100
>          idle_periods        = 7
> 
> CPU B:
>          current sample load = 75
>          no prev_load reuse
> 
> For CPU A, the long-idle branch uses:
> 
> load = j_cdbs->prev_load;
> j_cdbs->prev_load = 0;
> 
> If the load calculated from the current counters is retained separately
> before that substitution, the policy-level values are:
> 
> max_sample_load = max(0, 75)   = 75
> returned load   = max(100, 75) = 100
> idle_periods                   = 7
> 
> With an up_threshold gate, max_sample_load=75 does not suppress the
> deferred adjustment. cs_dbs_update() therefore first subtracts seven
> steps and then, because the returned load is 100, enters the increase
> branch, adds one step, and passes the result to
> __cpufreq_driver_target().
> 
> With a down_threshold gate, max_sample_load=75 is not in the decrease
> region, so the seven deferred steps are skipped. The returned load of
> 100 then executes only the normal increase step, subject to policy->max,
> so it cannot lower the previous request.
> 
>>> I think deferred down steps should instead be applied only when the
>>> maximum load actually measured across the policy is below
>>> down_threshold. To keep this independent of the load returned by
>>
>> The two gates only differ when the measured load lands between
>> down_threshold and up_threshold and the load used for the decision (the
>> inherited prev_load in that case) triggers one of the branches - if no
>> CPU took the reuse path the two values are equal and the outcome is the
>> same.
> 
> Agreed that the gates can differ when the measured and returned loads diverge.
> The example above illustrates the high-prev_load reuse case I am concerned about.
> 
>> If we use up_threshold --> the deferred downscale is only given up when
>> the CPU is genuinely busy enough to warrant a frequency increase; in all
>> other cases it still scales down as much as possible. This stays closer
>> to the design of 00bfe05889e9 ("cpufreq: conservative: Decrease
>> frequency faster for deferred updates"). When the measured load is above
>> up_threshold, we skip the deferred downscaling; when it falls between
>> down_threshold and up_threshold and the load used for the decision is in
>> that band as well, the frequency is left unchanged either way. This
>> fixes the bug you described while avoiding any significant power
>> regression.
> 
> In the scenario above, the difference between the two choices is how the
> deferred down steps are handled when the measured policy load is in the
> hold region but the load returned by dbs_update() exceeds up_threshold
> due to prev_load reuse. With an up_threshold gate, the deferred down
> steps are still applied before the increase step, which may result in
> a net frequency reduction. With a down_threshold gate, those deferred
> down steps are skipped because the measured load is not in the governor's
> downscaling region.
> 
> Although an up_threshold gate preserves more of the existing behavior,
> 00bfe05889e9 addressed the case where the workload had finished and the
> CPU was idle. In that case max_sample_load is below down_threshold, so
> both gates preserve the original deferred-downscale optimization.
> 
>> If we use down_threshold --> the deferred downscale is skipped whenever
>> the load is not in the lowest (downscale) region. it can cause power
>> regression.
> 
> I agree that using down_threshold can result in a higher requested frequency
> in this case, so I cannot rule out a power regression without measurements.
> My concern is whether deferred idle periods from one CPU should reduce the
> shared policy frequency when another CPU's measured load is in the hold region.
> Do you consider that reduction intentional?

 From the perspective that frequency should not be reduced while the load
is in the hold region, using down_threshold is more consistent with the
conservative governor's policy. As for the potential power impact, this
only occurs when prev_load is reused. I think it would be useful to
evaluate the real-world impact of the prev_load reuse path.

> 
>>> dbs_update(), which may inherit prev_load, we could record the maximum
>>> measured load separately in struct policy_dbs_info, for example as
>>> max_sample_load.
>>>
>>> The conservative governor could then gate the deferred reductions with
>>> something like:
>>>
>>>       if (policy_dbs->max_sample_load < cs_tuners->down_threshold &&
>>>           policy_dbs->idle_periods < UINT_MAX) {
>>>           ...
>>>       }
>>>
>>> This preserves deferred downscaling when the measured policy load is
>>> below down_threshold, while avoiding deferred reductions when any CPU
>>> is in either the hold or upscale region.
>>>
>>>> May I know could you comment and try this patch on your scenario?  Once
>>>> everyone agrees I can send this formally:
>>>
>>> I'll rework the patch along these lines, keeping the measured load
>>> separate from the inherited load and using down_threshold for the
>>> deferred-downscale condition.
>>>
>>> I'll send a v2, with a Suggested-by tag for your suggestion.

Yes, please send a v2 with detailed comments so that Viresh and Rafael
can quickly understand the rationale, especially the reasoning behind
the potential power trade-off.

> 
> --
> With Best Regards,
> Shengming


-- 
Thx and BRs,
Zhongqiu Han
