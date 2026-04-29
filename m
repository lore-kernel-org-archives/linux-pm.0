Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798A3F9F45
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467669; cv=none; b=t9fq54y9cJqz9KYLzlkymdXeZOPb0PclJdZuIyKPcffN8SIjYcHVUE0yfgxVhzDGa58GbnLpcZ76rE46WG7a92zEfhUiyiyoEGbep4wNxd6dDCChIy5FTGoqdEy5eC1k0jChgOtoKhxzx37NeNPh6Eejhvvzvxr8sa0BKXqowJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467669; c=relaxed/simple;
	bh=ZBHIl+7YenhNGLl9sfN40S23UX9LDW+/js0AUwP7N1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGIf5b5q7JznVIHIf5Y8WMZZnn7e1kVmHz+m3KENrA8e93m5+ZdDFFXR7+ECxEqMUtxyQIBehoas3o4dM1iVR6WPEfnun47nmAW/lmG97vMiAPGVi/sWBZlxgDn1/H7u64MtINn037KrEP+zIH5J2rhe3izSuIOUm8aY8EZ33fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NhAsbHRj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSEPFfCT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NhAsbHRj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSEPFfCT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8plfu3752354
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 13:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaqoXUYdQwM9RZHKZDK8o5sQEVbYSN5l9TYBWHIKPFk=; b=NhAsbHRjZZ93vp9z
	vnMAWEBiDKqDfn/ZMj26DomUH2hSozMfdS73e7A7rtVegjQi5/XBXgSaxHFHFyeU
	CEtUXRdtYr2LRgbyKHLioY1bUaNbqvhB5vDgganBlD0yQnO4p4Pti1vSQXe+FfFo
	CJoHzebdsRZ/lkaDobcN+8fykIR0p0rvmxVBiNXQaw6FbO51hirEj+CPEdsCgON4
	sbN5BlqpbTw8TyoUO+muJo48pBX7Me1KM0Zhdad9AWOiwe1rD1esDtWvhO4ggTa7
	l/NCLHWWCOtShg2AWrQSbE9oOotPpL/f2BhC9VIjIL/EYt+NsGd7hEolKJbyWiui
	drqMzQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1hk83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 13:01:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f220f1dabso9102961b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777467664; x=1778072464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaqoXUYdQwM9RZHKZDK8o5sQEVbYSN5l9TYBWHIKPFk=;
        b=dSEPFfCTK/Num81KPC9ozjwospMr85BaUmTzuXy4xLLP6aR2YXgbsT/uUTwOJ1JcgJ
         m7aCz9AzD7AXbYVPS0TP7FcjOH8b91GHmdo9/iLxcWS0/pVfweqmQ3cN4lv9bh0fAB+l
         3FbPYamjJVeyFP0ONTzUS8XvH3W3VCp0BrZ+dway5mA4/4kouWzqizGaoDSopwiU3YRr
         E82QH5lG3BN4DDtFWQEBmxwWzl9ZEk74HWIinBpBuqAY4Qn1R8li8X5cW9a0CjZ9DLAd
         EiRE6Fh7uZT45Rra1p7avMNIJGsDpR80izWeEpiILHrlxdpbOAsDGzo8jYdstK8CpOi7
         TKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467664; x=1778072464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaqoXUYdQwM9RZHKZDK8o5sQEVbYSN5l9TYBWHIKPFk=;
        b=e8hF7ciufYqvBXQ5kqcIgFe9cSD9Jse1TlC6znrPVmHd+0qgHNMuD6XcxV+12J4LS1
         B0AErE+l+YAhbMiJ6jy/PFQ/r4JlxcnTZEtrNvxbGCpU8/U/gXdVJPISur2naDiC+Q4n
         22c4uNsjretj/vqLwLEew1+dk6TTmiam+Am9MniY07Af3m0LjYkKiqw4D58WFnhrDoTa
         N+AKmC3yDCWjw5R2MVg001fqrgOHIKaXcMVYPZSQy/z1cS0dIlDKypDmbm4DG6LpXr7J
         WwEaaM0P+XXibJDLaH3xNEqjx+IzYJUMYeZ2HNcCBU7f0vR/sY8OP6z3fIER6OvbvVzB
         aRCw==
X-Forwarded-Encrypted: i=1; AFNElJ8TOU4EkcF9UYfnccPQQVL2vBxfq+eHqwie2apVN0vrMmu4wxOAseWwNvKZt97fEVqUC3J5+LUAOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuL0tiqJbsn3EUpxcWClC2wy66H6/hSFh7F9AusZEZSWh6BkB
	sdkj1PyMLlR1snIB+o8of1eu8gaJlRKMGZNrfi7nZHMclwy/HKqGJdEaxyThlbbno+NoY/0w2sF
	YZtAvD1cVQv9RJ220PHtWvUy9c5l0f4rRhxcU/S/1aZTTHj4jx5/UuFisUROQiQ==
X-Gm-Gg: AeBDieuJXSZswev9W2suKl+ryyIBTRPSnFiS0HTMXpjWfQ/+WzsyxOZeDimCpaEQNPI
	6f32aP7Amp6++C4cRF9Y/l5Aj4EYQftMaMz7TaMQ2azVs+wAinEHUc/6w3T3fb6u+VstLOPpfxh
	9hdi9Ez8d4ruxL/9riRMxYU/k4f84rhqbxtN5N/52ZlmQahMHOjYkh/63lH28WmmtdQarPyoX1V
	nPRpvVUnyDsQDtiq3Ak0dbUZ0h2WYQxJ9I0ze1TAwaBU6xhmVlXe9/td1o+TpMIHqhMtJH8OBHv
	foN9WKqnQveb7y3sR7+/JihtgLrS/XyA1pHNWUDCiM0SEH4LwK1F24yRXkXayZGGjd519A10tza
	ipHkzFB3unP4h/AFJ3BUrGhfGgpjmwfLzRLVsqXmYUFFfyVDk83qK60qJ5Rf/BrhPImFMQGzSSh
	ZUr9PDfytO1cg3XiiPqSZfJycbKhA=
X-Received: by 2002:a05:6a00:b4f:b0:82f:a085:c46b with SMTP id d2e1a72fcca58-834ddc29b1bmr7422158b3a.47.1777467663998;
        Wed, 29 Apr 2026 06:01:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:b4f:b0:82f:a085:c46b with SMTP id d2e1a72fcca58-834ddc29b1bmr7422036b3a.47.1777467662797;
        Wed, 29 Apr 2026 06:01:02 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80e24fsm2620547b3a.56.2026.04.29.06.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 06:01:02 -0700 (PDT)
Message-ID: <73fac9ca-451d-49f0-b9c7-5ef6bc0119bf@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 21:00:55 +0800
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
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260423084731.1090384-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f20111 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=7bWAtcYhG9OEsK6uJVQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzMSBTYWx0ZWRfX4rytKRj+H4XX
 HsqEze1ebJM8Eeky50dnXCB0GspVubupcARHFRqF6jwpyeDKKzITA7XP2yjMm98oUSaU41QhLa5
 eAbIXF1D4ot/tmAXXKxUtgmS8uCzaXLSjHEZKDoHYpiTIhXCaA4dRSnvA6bfhPKyqSVgqTOhv3y
 c3ETXW3jsDMDB39wE0BXDjoqs0C0bnOvXWJ+CZbzY55FjK/GwQ/gYVFvDCWUUhMTHkF1XQZDVvy
 I3BVLPUSRYovcukTEzsCP0Czv+b9z0st/1uxUx21qdTbwyLlx2CRMl6whCRAU5IOvNvunU9cBmG
 c4ICAqzUcEer6F8ge7zJ2uUIr2ZUdVT5+I9y0vpnnw13ovCmWSHtgFnt6eYzzslt2WLvZBvOw1o
 rGfjP3Q280gB12z0vN5NkOLhpcvBiaqm3HVbNwe3agMt+Q7vpAJouppgXzlZIe4Eb/xfQFxq1F8
 MCBpg9/wJSFtZ9gT1aQ==
X-Proofpoint-GUID: vvPUTsq0DICZERvWoVi30Dh_Ac-QM4f9
X-Proofpoint-ORIG-GUID: vvPUTsq0DICZERvWoVi30Dh_Ac-QM4f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290131

On 4/23/2026 4:47 PM, Pierre Gondois wrote:
> cpufreq_set_policy() will ultimately override the policy min/max
> values written in the .init() callback through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>    \-cpufreq_set_policy()
>      \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
> 
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>    \-__cpufreq_driver_target()
>      \-cpufreq_driver->target()
> is called. To avoid any regression, set policy->min/max in cpufreq.c
> if the values were not initialized.
> 
> In this patch:
> - Setting policy->min or max value in driver .init() cb is
>    interpreted as setting a QoS constraint.
> - Remove policy->min/max initialization in drivers if the values
>    are similar to policy->cpuinfo.min_freq/max_freq.
>    The only drivers where these values are different are:
>    - gx-suspmod.c
>    - cppc-cpufreq.c
>    - longrun.c
> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>    used as a min QoS constraint as suggested at:
>    https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>


Hi Pierre,
Thanks for the patch. I have a few additional inline comments/questions
below.


> ---
>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>   drivers/cpufreq/freq_table.c      |  7 +++----
>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>   drivers/cpufreq/intel_pstate.c    |  3 ---
>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>   11 files changed, 51 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 453084c67327f..1ed4bcdcc957f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	perf = READ_ONCE(cpudata->perf);
>   
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
> +	policy->cpuinfo.min_freq = perf_to_freq(perf,
> +						cpudata->nominal_freq,
> +						perf.lowest_perf);
> +	policy->cpuinfo.max_freq = cpudata->max_freq;


It is better to update doc as well to avoid new dirver developmenter set
policy->min / policy->max again?

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/cpu-freq/cpu-drivers.rst#n102

>   
>   	policy->driver_data = cpudata;
>   	ret = amd_pstate_cppc_enable(policy);
> @@ -1907,10 +1907,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	perf = READ_ONCE(cpudata->perf);
>   
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
> +	policy->cpuinfo.min_freq = perf_to_freq(perf,
> +						cpudata->nominal_freq,
> +						perf.lowest_perf);
> +	policy->cpuinfo.max_freq = cpudata->max_freq;
>   	policy->driver_data = cpudata;
>   
>   	ret = amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	unsigned int cpu = policy->cpu;
>   	struct cppc_cpudata *cpu_data;
>   	struct cppc_perf_caps *caps;
> +	unsigned int min, max;
>   	int ret;
>   
>   	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	caps = &cpu_data->perf_caps;
>   	policy->driver_data = cpu_data;
>   
> +	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> +	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +			       caps->highest_perf : caps->nominal_perf);
> +
>   	/*
>   	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>   	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>   	 */
> -	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> -						caps->highest_perf : caps->nominal_perf);
> +	policy->min = min;
>   
>   	/*
>   	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	 * nonlinear perf
>   	 */
>   	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> +	policy->cpuinfo.max_freq = max;
>   
>   	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>   	policy->shared_type = cpu_data->shared_type;
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index fbbbe501cf2dc..831102522ad64 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
>   		min_fsb = NFORCE2_MIN_FSB;
>   
>   	/* cpuinfo and default policy values */
> -	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
> -	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
> +	policy->cpuinfo.min_freq = min_fsb * fid * 100;
> +	policy->cpuinfo.max_freq = max_fsb * fid * 100;
>   
>   	return 0;
>   }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>   
>   	if (new_policy) {
> +		unsigned int min, max;
> +
> +		/* Use policy->min/max set by the driver as QoS requests. */
> +		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +		if (policy->max)
> +			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +		else
> +			max = FREQ_QOS_MAX_DEFAULT_VALUE;


Nit: Using local variables named min/max is confusing here since they
shadow the common min()/max() macros; renaming them (e.g. min_freq
/ max_freq) would improve readability and maintainability.


>   		for_each_cpu(j, policy->related_cpus) {
>   			per_cpu(cpufreq_cpu_data, j) = policy;
>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>   
>   		ret = freq_qos_add_request(&policy->constraints,
>   					   &policy->min_freq_req, FREQ_QOS_MIN,
> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
> +					   min);

It seems that the current patch is not merely a superficial cleanup; it
also changes the policy->min value in the GX driver, setting it to the
5% value expected by the driver. If so, we should document it in the
commit message.

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
tree/drivers/cpufreq/gx-suspmod.c#n137

/* gx-suspmod.c constants:
  *   POLICY_MIN_DIV = 20
  *   max_duration   = 255
  *   maxfreq = e.g. 300000 kHz (300 MHz)
  */

cpufreq_policy_online()
   cpufreq_driver->init(policy)      /* cpufreq_gx_cpu_init() */
     policy->min = maxfreq/20        /* 15000 kHz, 5% */
     cpuinfo.min_freq = maxfreq/255  /* 1176 kHz, 0.39% */

   /* Before current patch: 0, not policy->min */
   freq_qos_add_request(..., FREQ_QOS_MIN, 0)

   cpufreq_init_policy()
     cpufreq_set_policy()
       /* reads QoS=0, discards init()'s 15000 */
       new_data.min = freq_qos_read_value(FREQ_QOS_MIN)
       cpufreq_gx_verify()
         cpufreq_verify_within_cpu_limits()
           /* 0 < 1176: clamp to hw floor */
           new_data.min = cpuinfo.min_freq  /* 1176 kHz */
       WRITE_ONCE(policy->min, 1176)  /* 0.39%, not 5% */

After current patch:
freq_qos_add_request(..., FREQ_QOS_MIN, policy->min)
   => new_data.min stays 15000, no clamping, policy->min = 15000


>   		if (ret < 0)
>   			goto out_destroy_policy;
>   
>   		ret = freq_qos_add_request(&policy->constraints,
>   					   &policy->max_freq_req, FREQ_QOS_MAX,
> -					   FREQ_QOS_MAX_DEFAULT_VALUE);
> +					   max);
>   		if (ret < 0)
>   			goto out_destroy_policy;
>   
>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>   				CPUFREQ_CREATE_POLICY, policy);
> +
> +		/*
> +		 * If the driver didn't set QoS constraints, policy->min/max still
> +		 * need to be set as they are used to clamp frequency requests.
> +		 */
> +		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
> +		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;


Does it make sense to set policy->min / policy->max before the
CPUFREQ_CREATE_POLICY notifier, since some drivers may use them in their
callbacks?

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/cpu-freq/core.rst#n58


>   	}
>   
>   	if (cpufreq_driver->get && has_target()) {
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 5b364d8da4f92..ea994647abc88 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>   			max_freq = freq;
>   	}
>   
> -	policy->min = policy->cpuinfo.min_freq = min_freq;
> -	policy->max = max_freq;
> +	policy->cpuinfo.min_freq = min_freq;
>   	/*
>   	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>   	 * it as is.
>   	 */
>   	if (policy->cpuinfo.max_freq < max_freq)
> -		policy->max = policy->cpuinfo.max_freq = max_freq;
> +		policy->cpuinfo.max_freq = max_freq;
>   
> -	if (policy->min == ~0)
> +	if (min_freq == ~0)
>   		return -EINVAL;
>   	else
>   		return 0;
> diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
> index d269a4f26f98e..ebda2bbebf44b 100644
> --- a/drivers/cpufreq/gx-suspmod.c
> +++ b/drivers/cpufreq/gx-suspmod.c
> @@ -397,7 +397,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
>   
>   static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
>   {
> -	unsigned int maxfreq;
> +	unsigned int minfreq, maxfreq;
>   
>   	if (!policy || policy->cpu != 0)
>   		return -ENODEV;
> @@ -418,10 +418,11 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
>   	policy->cpu = 0;
>   
>   	if (max_duration < POLICY_MIN_DIV)
> -		policy->min = maxfreq / max_duration;
> +		minfreq = maxfreq / max_duration;
>   	else
> -		policy->min = maxfreq / POLICY_MIN_DIV;
> -	policy->max = maxfreq;
> +		minfreq = maxfreq / POLICY_MIN_DIV;
> +
> +	policy->min = minfreq;
>   	policy->cpuinfo.min_freq = maxfreq / max_duration;
>   	policy->cpuinfo.max_freq = maxfreq;
>   
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fcb..68ccc6eb1ef30 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3049,9 +3049,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>   	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
>   			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
>   
> -	policy->min = policy->cpuinfo.min_freq;
> -	policy->max = policy->cpuinfo.max_freq;
> -
>   	intel_pstate_init_acpi_perf_limits(policy);
>   
>   	policy->fast_switch_possible = true;
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index ac2e90a65f0c4..231edfe8cabaa 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -551,13 +551,13 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   		goto out;
>   	}
>   
> -	policy->max = policy->cpuinfo.max_freq =
> +	policy->cpuinfo.max_freq =
>   		ioread32(&pcch_hdr->nominal) * 1000;
> -	policy->min = policy->cpuinfo.min_freq =
> +	policy->cpuinfo.min_freq =
>   		ioread32(&pcch_hdr->minimum_frequency) * 1000;
>   
> -	pr_debug("init: policy->max is %d, policy->min is %d\n",
> -		policy->max, policy->min);
> +	pr_debug("init: max_freq is %d, min_freq is %d\n",
> +		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
>   out:
>   	return result;
>   }
> diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
> index 50ff3b6a69000..181962b0924e6 100644
> --- a/drivers/cpufreq/pxa3xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa3xx-cpufreq.c
> @@ -185,8 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
>   	int ret = -EINVAL;
>   
>   	/* set default policy and cpuinfo */
> -	policy->min = policy->cpuinfo.min_freq = 104000;
> -	policy->max = policy->cpuinfo.max_freq =
> +	policy->cpuinfo.min_freq = 104000;
> +	policy->cpuinfo.max_freq =
>   		(cpu_is_pxa320()) ? 806000 : 624000;
>   	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
>   
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 642ddb9ea217e..244153a1cead2 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -124,9 +124,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   		dev_notice(dev, "no frequency table found, falling back "
>   			   "to rate rounding.\n");
>   
> -		policy->min = policy->cpuinfo.min_freq =
> +		policy->cpuinfo.min_freq =
>   			(clk_round_rate(cpuclk, 1) + 500) / 1000;
> -		policy->max = policy->cpuinfo.max_freq =
> +		policy->cpuinfo.max_freq =
>   			(clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
>   	}
>   
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> index 4159f31349b16..dc78b74409af4 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -164,10 +164,7 @@ static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
>   		policy->cpuinfo.min_freq = 1;
>   		policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
>   
> -		policy->min = policy->cpuinfo.min_freq;
> -		policy->max = policy->cpuinfo.max_freq;
> -
> -		policy->cur = policy->max;
> +		policy->cur = policy->cpuinfo.max_freq;
>   		return 0;
>   	}
>   


-- 
Thx and BRs,
Zhongqiu Han
