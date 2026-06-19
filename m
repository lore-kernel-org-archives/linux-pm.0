Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADF368974
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866228; cv=none; b=I1ggMi8ng5De1PVL5bxoZz3TZGRN5X7AMVx8z6U7BSx1u3AidIuyoRgGVPTTDH+CHnT4N9LJ+eCVfD2J/4a9KkDJ5y1LdIA8PVQHBwVG5WYH3DriKOSJzSnB9s+HpJhuwG0UkZgtlg9fIDiswjAd18KcYXQc2+3sfTD78PAZZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866228; c=relaxed/simple;
	bh=aXaJ2KA0ZXlmXHwCabUpyttnqN0Q87S3cz3deFTQOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNSAgn3oRJ71fFzzjI/OmTgj57/4iwemchZt0sQL3o79oqupsI2HFvk+HytGQVmsPi0kJiLGZyRlhGnVJqK2/ni3yIeMBipg6IRDces7Z4V/ZSs/ZhVLDxkKAuJTDYlNdAwJ2+b1xnDXE14OHc80yxeiTjD3W9w4HDypi28j+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fl2dq1Pv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pm98oGc6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fl2dq1Pv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pm98oGc6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7Q4kv4033732
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 10:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dyf9Y0mN0Kii4oP1x4MGlaqQbVYrCsX66J86g6nZm08=; b=Fl2dq1PvIYye9K3f
	Guo3YgdPLnqSgzKYCbT4UStSmUOyXdPeImEqSqqdt0grIQGspOwcKCmFezRsgBdq
	UFqDbsIEVXKakNPF/IY4pf5HsgArAb3Mlegc6+tBZPD4dMCMekEJwKTkR2UwEwbL
	k15P88S+GicZBZuGxqFXl4MGUHdjDL1zjV0fxfpE5mFiz0WK3Mhm5dAy4PucJ+A+
	d5u679tQxcclawra7H8b6pl+1cKc6gRbHG5pBdB8U0OC/O1CO2qmHQYyCMBNBKc6
	mOxQ6XoYqxSGz20R3cSzXXN20RAt9wBYJWN75OAsmJUiq9nQddW9DgKgTqqc1Pdm
	njSS6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sawtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 10:50:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37d125687b6so1160069a91.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781866225; x=1782471025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dyf9Y0mN0Kii4oP1x4MGlaqQbVYrCsX66J86g6nZm08=;
        b=Pm98oGc6Q3fD4Vrv/4p3BhTUeUeysopb3Egx3PpoyMH8QJ8MOGYvlf60TO1J0GdNAj
         CjdrhHu53Ac/MGzE93rg+Vy95zVVb84MqdbmoatqqSL7IRs3BVQHuscP8RJ9J1XXUxN0
         1JMEW/9m4AYgVhCku3GSncqo3E+PuasvewI5P9fIUbyk5E7RhRpS3CywP8E7Ydz3yUO8
         xneaQMkRCfFMM73k1RL9xS9sSR19yOGkrAiz1eKwCC624o5qWvy6g1q+hoMJFDXWuTkC
         DDmFV0fowKhYnq76eyF33mfG7Oua8O99KFG9QPtuiLOJVstEY1hYR517S/arlDxdPw1e
         5ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866225; x=1782471025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dyf9Y0mN0Kii4oP1x4MGlaqQbVYrCsX66J86g6nZm08=;
        b=OKMYysRRYBTxqU7JQGSNvTse+p9ulP5wtjMHl+UgIHkaLm8uTWEKSIqIwnwlxfR539
         oAbJ+Y5EKO7H01r9tFbmmzznjw5i1EbNjE9mJ+GVUq3B5UhJGDGd1tPiuyVQZGblIdER
         3uNwvJvrfPusOTXMBog5CC53Pg2TXAGZ2L9U1lP9GyiEOw2X2+zL8elDkepSdEvIZbz8
         SZy5v4mwkFXCkL83WTHL2fpj0qku8REBSnlz/KHKmGaFk8bIxB9cToS2tkRMmWZRhZxF
         7LIoJiXOb+RhygBueUelCoggwNs3DLt5zFmPskkzjxr2HMoSAZgX4tYdbbED4fa3QXH/
         yUnw==
X-Forwarded-Encrypted: i=1; AFNElJ+1Kc/6wXy67vwUhEPF/vS8wxdefZceMyXaWejFBArnge8E4mjgo0StlyzQu/rNedWeQYMzlptxdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyWxZgwkv1dgYWO76brNom/ExctvxczqgqE63bPKwpsn/KWGQ
	M2vSTfSX022YhoWc4V31qh3YgPyfM+B1q+p2LI1YNRQNTARnaI+s/zs7jPcpwvRbvUVA7Prh98o
	RR1WjFSFVtoTRAUMfnlf7abFRsT95q+u77BHUXwcxm8JN/rDWlhYsergzdB2U7Q==
X-Gm-Gg: AfdE7ck9kFYwxyJBHvo0gJtP/jhM+XtQ/nyhvxXiSaL4fPefOzX3DbBu1dbh4+1eILA
	85MygOAEAV+v4/KUpa25bTR3mt9q849y3GlrtsMymflmSHOrAdIUOa1wOiDNtvZe8Q+psA4t87f
	uJXlNgVGznp10bW8MNf/kRX+1dpaEszfuLD3azpkiKvgRagmYjX5RPp4z5jjG07vt3RcCLnaHcf
	nhQXL07FCEDl+9Jf9DjSKwqjNZdx2vNt8TMiWpoD6zeW/BB5qMGaArRGzc+lc1Y7vG22fL9yN3p
	X/s1eMFKOlm7oixJwMmlBvlPrFvaOcAsCO/wo78kyTDr5dX4iiZYF0sChOZxZWOaC3x7e9IRuyV
	Tb+6pDaoL5H4pkZx7/2OxoxBj68isNb/qXJUoDDAruXfZJff0FcHSb1GdNM3e+zRHpP+gJrEqk+
	NA3nS1di4=
X-Received: by 2002:a17:90b:2686:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-37d1ea6759bmr2285378a91.24.1781866224893;
        Fri, 19 Jun 2026 03:50:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2686:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-37d1ea6759bmr2285352a91.24.1781866224436;
        Fri, 19 Jun 2026 03:50:24 -0700 (PDT)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d153601c4sm2386774a91.3.2026.06.19.03.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 03:50:24 -0700 (PDT)
Message-ID: <2421ef06-e0d7-4380-a51b-c3f500ed4b97@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 18:50:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Adjust the .adjust_perf()
 driver callback
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        zhongqiu.han@oss.qualcomm.com
References: <14060154.uLZWGnKmhe@rafael.j.wysocki>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <14060154.uLZWGnKmhe@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3VRuCUxJm6ziHYkYTVHtkbzcBsy3n4Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMSBTYWx0ZWRfXwY0rlVpKRIpL
 Pi/fBRxlNuy2UNOQROyZPMs82z+FtgW0Q982xXC/yNJql70nnFm4ZB7LsmazyezpyH5aXFcpFfS
 X83682zD4UW98p+kAWk0iqdhKifePuPT5ue41QtLYzlh4ntexr/QVuPHWkDqdGHoxFkmnq7Yheo
 +ep9pmynRigqkspeQT+3gtTzVTzchBErpFnHJ9H9+rNJED3QXVhq0RgLxsIvQAy8wzIe2dOTDUF
 VErmgvaJ/yh6+CXDm0d/CDlV9VhyetLRy7++JeNaof7HxqABD2Fh7ZY0YMod7ntzSbM3EMF7j7k
 Lv4x7ydvXkJ/dQHrb3MvAeYROREchY1W+SdHhrAAX1hYUWmQcPt4+OcRoPBsbiTnPGhBjFnCQI9
 CMxWgVAFlGGQOB9FkqX+yMG9hoFMZCS3nLUbyWZjpf0P/+HFFHhclAwafRb8i3sov+TFirDILXw
 DF+2/efeWjJW3IuHBCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMSBTYWx0ZWRfX0WJl8erVBFwq
 +lBZzjkw2iIArYRvGKBGRbx1DiEHAo92HgLEz7wBij1w3cZCSv4mxg4KCVJphyQPd1Qz67xvUEI
 7WTvSKrme8vQllKrnAECooPPfXnFjWo=
X-Proofpoint-ORIG-GUID: 3VRuCUxJm6ziHYkYTVHtkbzcBsy3n4Z0
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a351ef1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=QyXUC8HyAAAA:8 a=1a0ZiCl4u1-ptICwYMEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190101

On 6/18/2026 12:14 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases, the processor may not actually stick to the "desired"
> performance level programmed through the driver's .adjust_perf()
> callback and may go above it, which may not be desirable (for instance,
> there may be a UCLAMP_MAX limit set for the task currently running on
> the given CPU which should be respected).
> 
> Address that by adjusting the .adjust_perf() callback to take an
> additional argument, max_perf, representing the maximum allowed
> performance level of the CPU and update the intel_pstate driver to
> take that argument into account as appropriate.
> 
> Accordingly, adjust cpufreq_driver_adjust_perf() and the other existing
> user of .adjust_perf(), which is the amd-pstate driver (but the behavior
> of that driver is not changed).
> 
> While at it, also update the cpufreq_driver_adjust_perf()
> documentation to reflect this change and some previous code
> changes that have not been taken into account in it.


Looks reasonable overall.


> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/amd-pstate.c     |    1 +
>   drivers/cpufreq/cpufreq.c        |   14 +++++++++-----
>   drivers/cpufreq/intel_pstate.c   |    9 ++++++++-
>   include/linux/cpufreq.h          |    2 ++
>   kernel/sched/cpufreq_schedutil.c |    4 +++-
>   5 files changed, 23 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -781,6 +781,7 @@ static unsigned int amd_pstate_fast_swit
>   static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>   				   unsigned long _min_perf,
>   				   unsigned long target_perf,
> +				   unsigned long _max_perf,
>   				   unsigned long capacity)
>   {
>   	u8 max_perf, min_perf, des_perf, cap_perf;
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2252,14 +2252,17 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_sw
>    * @policy: cpufreq policy object of the target CPU.
>    * @min_perf: Minimum (required) performance level (units of @capacity).
>    * @target_perf: Target (desired) performance level (units of @capacity).
> + * @max_perf: Maximum (allowed) performance level (units of @capacity).
>    * @capacity: Capacity of the target CPU.
>    *
> - * Carry out a fast performance level switch of @cpu without sleeping.
> + * Carry out a fast performance level adjustment for the CPU represeted by

represeted --> represented

> + * @policy without sleeping.
>    *
>    * The driver's ->adjust_perf() callback invoked by this function must be
> - * suitable for being called from within RCU-sched read-side critical sections
> - * and it is expected to select a suitable performance level equal to or above
> - * @min_perf and preferably equal to or below @target_perf.
> + * suitable for calling from within RCU-sched read-side critical sections and
> + * it is expected to program the proocessor to select suitable performance

proocessor --> processor

> + * levels betweem @min_perf and @max_perf inclusive and preferably close to

betweem --> between

> + * @target_perf going forward for the CPU represented by @policy.
>    *
>    * This function must not be called if policy->fast_switch_enabled is unset.
>    *
> @@ -2271,9 +2274,10 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_sw
>   void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				 unsigned long min_perf,
>   				 unsigned long target_perf,
> +				 unsigned long max_perf,
>   				 unsigned long capacity)
>   {
> -	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, max_perf, capacity);
>   }
>   
>   /**
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3241,6 +3241,7 @@ static unsigned int intel_cpufreq_fast_s
>   static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>   				      unsigned long min_perf,
>   				      unsigned long target_perf,
> +				      unsigned long max_perf,
>   				      unsigned long capacity)
>   {
>   	struct cpudata *cpu = all_cpu_data[policy->cpu];
> @@ -3271,7 +3272,13 @@ static void intel_cpufreq_adjust_perf(st
>   	if (min_pstate > cpu->max_perf_ratio)
>   		min_pstate = cpu->max_perf_ratio;
>   
> -	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
> +	max_pstate = cap_pstate;
> +	if (max_perf < capacity)
> +		max_pstate = DIV_ROUND_UP(cap_pstate * max_perf, capacity);
> +
> +	if (max_pstate > cpu->max_perf_ratio)
> +		max_pstate = cpu->max_perf_ratio;
> +
>   	if (max_pstate < min_pstate)
>   		max_pstate = min_pstate;
>   
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -379,6 +379,7 @@ struct cpufreq_driver {
>   	void		(*adjust_perf)(struct cpufreq_policy *policy,
>   				       unsigned long min_perf,
>   				       unsigned long target_perf,
> +				       unsigned long max_perf,
>   				       unsigned long capacity);


Sashiko also pointed out a potential Rust binding mismatch, which might
be worth checking (the callback signature change may not be reflected
in rust/kernel/cpufreq.rs):

https://sashiko.dev/#/patchset/14060154.uLZWGnKmhe%40rafael.j.wysocki


>   
>   	/*
> @@ -624,6 +625,7 @@ unsigned int cpufreq_driver_fast_switch(
>   void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				unsigned long min_perf,
>   				unsigned long target_perf,
> +				unsigned long max_perf,
>   				unsigned long capacity);
>   bool cpufreq_driver_has_adjust_perf(void);
>   int cpufreq_driver_target(struct cpufreq_policy *policy,
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -50,6 +50,7 @@ struct sugov_cpu {
>   
>   	unsigned long		util;
>   	unsigned long		bw_min;
> +	unsigned long		bw_max;
>   
>   	/* The field below is for single-CPU policies only: */
>   #ifdef CONFIG_NO_HZ_COMMON
> @@ -232,6 +233,7 @@ static void sugov_get_util(struct sugov_
>   	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>   	util = max(util, boost);
>   	sg_cpu->bw_min = min;
> +	sg_cpu->bw_max = max;
>   	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>   }
>   
> @@ -484,7 +486,7 @@ static void sugov_update_single_perf(str
>   		sg_cpu->util = prev_util;
>   
>   	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
> -				   sg_cpu->util, max_cap);
> +				   sg_cpu->util, sg_cpu->bw_max, max_cap);
>   
>   	sg_policy->last_freq_update_time = time;
>   }
> 
> 
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
