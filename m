Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CB3B3C1D
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883843; cv=none; b=L3DUa6Z2/u7cHegCZrG8z94iMkg3b2+m4O6AZnvRdsdxgIYJ8xowpo1KSkbDKCHE10FG0UxsKnsesaakI3NWB6mhBqT9KytrjxELuE4WOUIeMfXxZWkucOAUB20i3lvWAHp6/7j8cJo9ADtaB09b82DulNAgT09ldtHeYy+j07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883843; c=relaxed/simple;
	bh=C4yYazntPWDzseRjzv95bID1jrYEwNZptGnvCAlQJM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4UaJGNZbPx7zPqoYKmkwyYsfTvg+uNxGyGVxNrzKtcdFAtBVjQqW3Pjt4f7qZcjKogIe2zxgkn5PPVC2k5oFhMvEEaf4zgC5I/qTHVFpuYBxbfn6W3a0st8A0GpSqzSh2T7t8qeo+WHyeHfOMOoku18wxe58yahEC11ZcdP0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgL2uDCJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FskXvHt/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgL2uDCJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FskXvHt/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JD9XwW259723
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ugdUMkC7tuaLPVYYlU/o8v7Jtmi3r69VxCdHHq6dOtU=; b=cgL2uDCJ2W3egRcW
	95nueD3feuhoLZDvet4UYdoVG98B8s6nOsM+VND7jjNKxG2Mb/Mrmuzg2/rDqZcs
	BUudLgan7QmtuEmwQDlHAOV3998FppeqBAZ6DccZz4bamFTEuRAqvVOqmcAzMLbX
	NV0BNG6fN9vuH36VI54ITvHyBK+0YB4v8eAGCPZ/DcEhLEvr0Gaitm9obmKWNCU9
	HphqRkjierVm9sBG+bnXDypqYDMLyBFmC/7hTxMgiaEMAKWhFkzpM4KM/5wmo9DA
	uz+gTul7GaU3zIxElXs2wiH9xeA3X812tt0S1G+O1hIuLEzvn74vaLIH64utiA2n
	lqv+zA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp673s48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:43:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so1453208a12.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781883835; x=1782488635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugdUMkC7tuaLPVYYlU/o8v7Jtmi3r69VxCdHHq6dOtU=;
        b=FskXvHt/mNgGTLaeN89Qx02zk7O2A93CYRgYOmwFU97E7YQfclwnEo5j27M+kYbRXa
         r0uuOrM/0LTBGR66DMvZaEScf+luFNMp6AJZuLs2u8MB1/ZKlfJxMOkk54uHZTZOHK2M
         C7JuyVpaFHAGOZV5RhaBuCsPeOS1b0WawhsTQBtVHhqFvFQ8SawRd6bBoBDDIbGejETz
         P9kvcmOmCbMJcb2t6BUbhdvNYWIuZiZpPGlzl0u8sWxMq6Z6Jpl1BsgHKGL23pH+9H7m
         JpNwLooq+p5PaLhpTcYU45wluFDGEOBM95A+DSgv/Cp02VA7qWLnMHtcT74Hy+NZKoC3
         1hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781883835; x=1782488635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugdUMkC7tuaLPVYYlU/o8v7Jtmi3r69VxCdHHq6dOtU=;
        b=m8wl2iVxPH70I5fSr3/Ya9TC1mKStKyppsJWGEXs+0UwUUSARLYZIqXCSQCThUSHVl
         meDUkfncsDwnO8BL4/t469QDLqZkqvjk3WaMmgQGax1vrQ4DSX7xUuzOFeS8GRngNJFJ
         wxx+ls+I7osiRXN8T3atXfXsosZTlO7JM6GktHoIZWg0EZ5ANcNZ6PLKnN/3YwCPmsVy
         2CdTx98cHCIswfHtb1Ucfak8eHf7fNbcPNzc5jUZXwi4NhQ2EHO1Oc4qda9uidoDjure
         1yoPx1bj+EtBnpNX4CLQOYqg58vn3YVLEc3WDXASS8Z309x3W9gbrn8ONsWIqdNI7usX
         6i2w==
X-Forwarded-Encrypted: i=1; AFNElJ/XjjBiXf7I6+7FqG5IaHzXkQTFzIXwC7YHWdQFyM8vRAcWT6obiXA6I2ZTeZa0Tkr5B7e9yKb4lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEMjEgmEbcZiq9TSsCiRvhn4e4UYx4hnooPyfz/+/FH3ib1i+
	BbmgKbXTATHq1P0tQ/UrssfuFPH0au69NfC9Mz2sMmUeVCWCPC1BkpR4/hfA5hV9oksMEoENUb3
	g7yLvhfLvxqC6Fwj886hJLQ7EFIZcKrC1P/uV7KITFT4sZ3qzhpZwr5miNtFK7g==
X-Gm-Gg: AfdE7cmcdnFalebTQELZhsJ/8TO1/Zr+rohHBWIwLC7tadPe8brRTxmS4fg1uPOsFa+
	PZmkuO4SoGPQ+PbCNTBZZK0SG8S7ctA8AepTCrQMxphXOKayj5TI5HnrmY9eL2lJRjYIyuknLCD
	wQiSwXbkcEjaDeRX+Jyf9rc4Z/FbDz1jVXWGmcu//2jcsqVpwAhZ2LF2iZLohwZMRgSwtrc7SHI
	0Tfm4+YGIg6dwQJTfMTYw3KfhvXwWfpltIJ2hNv9Du/aPGRNoG3x3fg4K3ECNzujvw8K+CnqYQZ
	DaLhceGCxDyzai3XRgSy+0OsGKscWSss6VQmMYeGb3l0yG75XVet4rdycLsBp0i6lGYnNmP07Vp
	PoQYZrk6ip/uhYddbJLnBP6iaPrVvjdpAD9Uf8HOt2rHmMnKkFYjisfDv+v+qsLmtMvmrwfjR/A
	XYUTw5EVE=
X-Received: by 2002:a05:6a20:6a21:b0:3b2:86c9:baa5 with SMTP id adf61e73a8af0-3bb6c4644e7mr3759782637.38.1781883835297;
        Fri, 19 Jun 2026 08:43:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3b2:86c9:baa5 with SMTP id adf61e73a8af0-3bb6c4644e7mr3759741637.38.1781883834782;
        Fri, 19 Jun 2026 08:43:54 -0700 (PDT)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8f0a7sm159393a12.7.2026.06.19.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 08:43:54 -0700 (PDT)
Message-ID: <56a6b35a-407f-4529-b655-27d6cde5e595@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 23:43:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Adjust the .adjust_perf()
 driver callback
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mario Limonciello <superm1@kernel.org>, zhongqiu.han@oss.qualcomm.com
References: <6277654.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <6277654.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n9qerOX5sLpgE_RstO-TRQ1aj6NoQXwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0OSBTYWx0ZWRfX0T6qpVQ2GjZj
 jqfP2FU0rcuZqLRNkpWseD22hFzBAj5tj3GWkqe9dhsUL5xGehRTh5Mo+vBVTT2okd0zLLfoXD/
 r5iM4f5FCPJxnIaNDkQjK3VxmQ0i36uaMx94+gUfZO63fLja/AlC7n2Nt8nMzbI80xTuIaZjCuN
 XmniDW9K/60/9Yb/Ibl0ND+EpjuklRgdBHFQIszlTFiu+qouQwvZHOMX1CoqkeQ+p9sisYzI0gr
 fxRrJstW88Q2t/ZBKYD5R9EerqwSs4IzXTxgjZeXezvmZ3+bpsqst82xlkoEBGS1sY0fdDtPytE
 JLPuD18tzBMIiN2hiPG5YW4zjxmNaOGVrCB3dsnHwl7xGTQViNf4X3ks9FV/EAhxkK/PU1Cp1xN
 oLmvLK1cTNQ9TtVNJl2bYQdU/+kJlrziMo9QB5R9h8wvR2ad+HxzxAsrWgCWifBcUBS6+JAdo3j
 iS5M+Uu9qE1S878nqiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0OSBTYWx0ZWRfX0rxpgrAcCP+d
 IlXS/mFSmR66oRRC6NX7GJA8AN2vWCJP3VdW6yquykwy4zpJdlpVs7s76Ywb3TWMhTUqXjJi7WU
 i597UYxSlXrDi0b0EplxTLFiKkJZZ8I=
X-Proofpoint-GUID: n9qerOX5sLpgE_RstO-TRQ1aj6NoQXwr
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a3563bc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=d4jfqAhGOrdBWL2RbNwA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190149

On 6/19/2026 10:52 PM, Rafael J. Wysocki wrote:
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
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me. Thanks

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/14060154.uLZWGnKmhe@rafael.j.wysocki/
> 
> sent mainly because the v1 did not update the Rust bindings by
> omission.  It also fixes a few typos present in the v1.
> 
> Thanks!
> 
> ---
>   drivers/cpufreq/amd-pstate.c     |    1 +
>   drivers/cpufreq/cpufreq.c        |   14 +++++++++-----
>   drivers/cpufreq/intel_pstate.c   |    9 ++++++++-
>   include/linux/cpufreq.h          |    2 ++
>   kernel/sched/cpufreq_schedutil.c |    4 +++-
>   rust/kernel/cpufreq.rs           |    6 ++++--
>   6 files changed, 27 insertions(+), 9 deletions(-)
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
> + * Carry out a fast performance level adjustment for the CPU represented by
> + * @policy without sleeping.
>    *
>    * The driver's ->adjust_perf() callback invoked by this function must be
> - * suitable for being called from within RCU-sched read-side critical sections
> - * and it is expected to select a suitable performance level equal to or above
> - * @min_perf and preferably equal to or below @target_perf.
> + * suitable for calling from within RCU-sched read-side critical sections and
> + * it is expected to program the processor to select suitable performance
> + * levels between @min_perf and @max_perf inclusive and preferably close to
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
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -792,7 +792,8 @@ pub trait Driver {
>       }
>   
>       /// Driver's `adjust_perf` callback.
> -    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize, _capacity: usize) {
> +    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize,
> +                   _max_perf: usize, _capacity: usize) {
>           build_error!(VTABLE_DEFAULT_ERROR)
>       }
>   
> @@ -1262,12 +1263,13 @@ impl<T: Driver> Registration<T> {
>           ptr: *mut bindings::cpufreq_policy,
>           min_perf: c_ulong,
>           target_perf: c_ulong,
> +        max_perf: c_ulong,
>           capacity: c_ulong,
>       ) {
>           // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
>           // lifetime of `policy`.
>           let policy = unsafe { Policy::from_raw_mut(ptr) };
> -        T::adjust_perf(policy, min_perf, target_perf, capacity);
> +        T::adjust_perf(policy, min_perf, target_perf, max_perf, capacity);
>       }
>   
>       /// Driver's `get_intermediate` callback.
> 
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
