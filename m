Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C32D5935
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531022; cv=none; b=biYmlKywiYWWCkjXJWUxKuAAtCkWkHSAH0N3574Cp62rmjDb973LtMvovB2FjPr8meYW7u7WlTRzhHmi1rQGr80aZ+VOTM7VgP7oPajCQLWOc8xKnO6aV6nC/Hzmcfy90tY1lBCjKYdVBzyKe/u4tJdhba/Yxbp1Th5ecHs1yA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531022; c=relaxed/simple;
	bh=ZlN3qnFvcMaUaK5LkQwONXd9M6rRx/1/Aa+rV6E5vcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXt8qEh1CjRSnn/CLW6DJrdb4WI9s5hm5N9zoZ8wzpWM9ppih0/FZCgThufSLrzLRHMYNPyI3hCq8fGP0avbjV9PclvA8Vr72v4ZEh3D3cfZoQzf+zzFRMxXhDSMlUfCs8eBxPg8CknMsjv7hNFpDlKEXyB14FZmtdrnWjQEUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lq2+6mGZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jVIsYw3g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lq2+6mGZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jVIsYw3g"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QDEv2F052584
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 13:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3JdTg4Aaai5fyyFKYt0yR1/n1FJsYQ6S4oCZLFO8Tu4=; b=lq2+6mGZCR3UKpC9
	t5MDVAatwUJSNklAEBqIEoti/ORkBFmicJLglDsR22GRYarZazdWzbGuwr6BZBVK
	mqZUpZaYKU//HqEYIqoLnC3kMZPBTQ31HS2dTy8JroYZOXr5Qf8YGexyP4e5I2n0
	6rJDp6ExzbXfZSw893Md5PLzetWFvRN78ZZqkn5VX3i3wxWY29bi0aOJuvUC+Tg5
	eaR0fmWHVvpsg1lqTMgbpuCRWJsrjnqTyWFSMM+v+VrjhnLiO2GLMiEw2boKw+I6
	B6zHrUYQpnXwdwg0vjueNzScgiMWbcItDQf3uIR1unFWvEuMyLO2ytWnx1V9MBkc
	5hVZlw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t2xfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 13:16:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so1359996b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774531017; x=1775135817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JdTg4Aaai5fyyFKYt0yR1/n1FJsYQ6S4oCZLFO8Tu4=;
        b=jVIsYw3gWeOyhs/jSdWprn+kVq546QoVDBlT/jwvtgGNJwUi7dIcsByJbC9znmQ2u1
         9IHeAI5qiMQ3VfduTumHxh6himlKfhfUursvHOoFujtZ4FXlbHUSW0s8ulv8tAFNTF6o
         wQDeG+pv1f0RC6zH3yr7Z+4FQ7xXXsYg471Se15eEEawnfDPTuYjKfRjtrHHevfaxk3V
         7uXojix/ILav+5nLMp+qszHZ3qqPgi3aYvXpxPWN7YU7jETIf8BgPMpbRisKHEQk5bjc
         STkbVQenGH0qDkmU6kLPnus/EPc6RdKwUvNAihHlnVtjhoRf7F/rW/6VqNF8BbgmIUzb
         d1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774531017; x=1775135817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JdTg4Aaai5fyyFKYt0yR1/n1FJsYQ6S4oCZLFO8Tu4=;
        b=bUkm2dP5NG8jzc4pE8gDRcMkLJbtApYe+W96srWWPUSJlHT6harkI8W98wNnr+9h2I
         H00okCRBHTZE2kPGM4/PjWn01ULHpp6qTR6susFNzUy8GdexGJF6jcjhBMsa1KPljOBv
         E40CzNqvMLqDEY5JDsMvwFJeakOTH0r9xBfxbzBBWAVAA/2lgiRnbCvBm1qIOb+vOvJ2
         ANIKWynYEmB1z3j7tcZxGNd7K1o5IQMBuq81BHukifLE7/m/BSrP9u1xMy0krK7v9cuY
         nFF8zN2Csqa7FMz5ZqQKqFsmzjL/H8YGwropzYR6gcSGB4stiD8gX/TMfkcKanM5LVhd
         NybQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgSrqBCRVSxXmekFbx51cA/3Jz+G4pvgs2V+k7z3jCEHgL8qqyC4Ge6JNKAlIeCuiuX5yEWz/zlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqsuEK+BdGMygiErMvHiFPaBbMdI4F8CKbeKk/SDKYG1aWZ7d
	iDSAsWx6Oi1vh8DflG3hMCWgjY+GkZ6wI4P4qVibBaSpjkQNSyWYoZXcs6XAr2DknQir4qYZm6O
	Q0nzW4bDHcffDVh58jJiASs8Fvztw6LqYxQs80rf5x56W3mZs15vmTT3plIMpPQ==
X-Gm-Gg: ATEYQzzK7VoGjHeJ4mJzwMTvOBFy0l0aEQYr61nhC9WtKbRkAVNmvFGWahLF+ud8q0R
	q7zGm3D4J1Qk8Z/Yl/vCk3YqKvI1v5i1WnrGg/DjdfsbP6uJeAB4twSCpypxcnPhK03TlvTL0Zh
	xya5AceRmhKkqkbSBx74iB8zRY2awCmKZFlgO5unIW+u84xtFftoL3j6Gr2uio9h/cWhj9snx61
	LApd1sXIPkn3XFpPVjz+bOuU62enH8DgRBqrEU5WZkfAYN6hfb+TgT0KN6lwzN63jbXn2TwKwK2
	18ELN68Y82zuygwhmpyjvhHXLnWpFLe0s8Er1/kkKlj8X8y0TRVDteBizq+M6feN8jsXV0xy8E3
	w8vPH0vmIMmZ3jUmZd74I1JzpqQGkVQqAtAnCqedNedszKcm72OtXo9j7Q5PgvLRCL/hZGumJ7m
	ctbsh3lUqRMeBNLv7w
X-Received: by 2002:a05:6a00:8987:b0:82c:70a8:fae8 with SMTP id d2e1a72fcca58-82c70a90044mr4422956b3a.24.1774531016766;
        Thu, 26 Mar 2026 06:16:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:8987:b0:82c:70a8:fae8 with SMTP id d2e1a72fcca58-82c70a90044mr4422908b3a.24.1774531016098;
        Thu, 26 Mar 2026 06:16:56 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d390a4csm3426033b3a.31.2026.03.26.06.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 06:16:55 -0700 (PDT)
Message-ID: <6f41fffe-9548-41c9-b6bb-df07e5c9ad7c@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 21:16:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-rt-devel@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
        zhongqiu.han@oss.qualcomm.com
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-3-kprateek.nayak@amd.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260316081849.19368-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c531ca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8 a=50MYKZWsfa7X8wndP2cA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6TIFtqsdRQWcvnyeq9I0ABf0nb1Ahxow
X-Proofpoint-ORIG-GUID: 6TIFtqsdRQWcvnyeq9I0ABf0nb1Ahxow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX2OvtyyKZjFEH
 kr1lHuLqe3zWDpnD5bwwxw1ni7raHEwshZo7KRdS9Z1b7SBQ73pMhjHEXslIsoE5SnTvqiuZFKP
 G73RSrLZxTeVmppFTJneoMVbqwn/NGYzChxDHHHQCDzuksioT5DTCGwyGL294uGf4+p+FqH8sJp
 ckWEZYufzUF07G1DBFOe6nZfkzzBLbSHehMb9luRXYMjlpCXOdP4SYbdD2quoGSznlE/Ao/+NJk
 TRwTVjxdTo27nkx2V3H53H8j8+9JWUhtWDvdpjGCZK28FebYk3sVvXwDulHzYdVsA506D9etoej
 LiB6moG8gi1Ec462a6NnX8xNoGTgYDvkYHPzI06tTrjyFYVzTrKI1yDN1pz1XXEqABZsiHBatse
 aYBgL3OyZeTLR1iFYpNjB08oO6CLFhiMtD/hVrk5Xr9d0YSBILHAIBuKvvRobXBY7D16Kk1qloj
 IVv594kJ7p9vrV9QFcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

On 3/16/2026 4:18 PM, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".

Agreed, sugov_update_single_perf() is only invoked for CPUs belonging to
a non-shared policy; in this path, policy->cpu is guaranteed to match
sg_cpu->cpu. With that invariant, this patch looks correct to me.

> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v3..v4:
> 
> o Added the Fixes tag. (Gautham, Chris Mason's review-prompts)
> ---
>   drivers/cpufreq/amd-pstate.c     |  3 +--
>   drivers/cpufreq/cpufreq.c        |  6 +++---
>   drivers/cpufreq/intel_pstate.c   |  4 ++--
>   include/linux/cpufreq.h          |  4 ++--
>   kernel/sched/cpufreq_schedutil.c |  5 +++--
>   rust/kernel/cpufreq.rs           | 13 ++++++-------
>   6 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5faccb3d6b14..ad4b5f84773a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -710,13 +710,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
>   	return policy->cur;
>   }
>   
> -static void amd_pstate_adjust_perf(unsigned int cpu,
> +static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>   				   unsigned long _min_perf,
>   				   unsigned long target_perf,
>   				   unsigned long capacity)
>   {
>   	u8 max_perf, min_perf, des_perf, cap_perf;
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2082a9e4384f..17a5b8e0ea1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2231,7 +2231,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>   
>   /**
>    * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> - * @cpu: Target CPU.
> + * @policy: cpufreq policy object of the target CPU.
>    * @min_perf: Minimum (required) performance level (units of @capacity).
>    * @target_perf: Target (desired) performance level (units of @capacity).
>    * @capacity: Capacity of the target CPU.
> @@ -2250,12 +2250,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>    * parallel with either ->target() or ->target_index() or ->fast_switch() for
>    * the same CPU.
>    */
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				 unsigned long min_perf,
>   				 unsigned long target_perf,
>   				 unsigned long capacity)
>   {
> -	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
>   }
>   
>   /**
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 51938c5a47ca..1552b2d32a34 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3239,12 +3239,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   	return target_pstate * cpu->pstate.scaling;
>   }
>   
> -static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>   				      unsigned long min_perf,
>   				      unsigned long target_perf,
>   				      unsigned long capacity)
>   {
> -	struct cpudata *cpu = all_cpu_data[cpunum];
> +	struct cpudata *cpu = all_cpu_data[policy->cpu];
>   	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>   	int old_pstate = cpu->pstate.current_pstate;
>   	int cap_pstate, min_pstate, max_pstate, target_pstate;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..4317c5a312bd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -372,7 +372,7 @@ struct cpufreq_driver {
>   	 * conditions) scale invariance can be disabled, which causes the
>   	 * schedutil governor to fall back to the latter.
>   	 */
> -	void		(*adjust_perf)(unsigned int cpu,
> +	void		(*adjust_perf)(struct cpufreq_policy *policy,
>   				       unsigned long min_perf,
>   				       unsigned long target_perf,
>   				       unsigned long capacity);
> @@ -617,7 +617,7 @@ struct cpufreq_governor {
>   /* Pass a target to the cpufreq driver */
>   unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   					unsigned int target_freq);
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				unsigned long min_perf,
>   				unsigned long target_perf,
>   				unsigned long capacity);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 153232dd8276..ae9fd211cec1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   				     unsigned int flags)
>   {
>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>   	unsigned long prev_util = sg_cpu->util;
>   	unsigned long max_cap;
>   
> @@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>   		sg_cpu->util = prev_util;
>   
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>   				   sg_cpu->util, max_cap);
>   
> -	sg_cpu->sg_policy->last_freq_update_time = time;
> +	sg_policy->last_freq_update_time = time;
>   }
>   
>   static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..a83aec198336 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1256,18 +1256,17 @@ impl<T: Driver> Registration<T> {
>       /// # Safety
>       ///
>       /// - This function may only be called from the cpufreq C infrastructure.
> +    /// - The pointer arguments must be valid pointers.
>       unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>           min_perf: c_ulong,
>           target_perf: c_ulong,
>           capacity: c_ulong,
>       ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
> +        // lifetime of `policy`.
> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>       }
>   
>       /// Driver's `get_intermediate` callback.


-- 
Thx and BRs,
Zhongqiu Han
