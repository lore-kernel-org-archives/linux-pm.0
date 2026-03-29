Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A02259C80
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774774857; cv=none; b=iIAUE01GBx4sCzzY8AdAM9gh2Hca8E4W+HtyjnOvzsgfwn2AdkENBPb3BX3m20L4oYcM/Gpi144cxwC230KJYeaBH+8Zwm8OgIR/rWJ9nkxzEtsZ6Kc3RgTt73TA4sajka6FnM8lpLtMxD6cUP65gPOKrQ9txwfMtgG5wgS19Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774774857; c=relaxed/simple;
	bh=p83u1R4Lv37rWAthfo2eat2x5HQ5u30yzzRoxfBAu7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=na7glJ05kC7XZ0249go7rMCritbzg9i+fj6Jp8uAyHVIaCUP92HFlYmqKNS8rEmFbXIUrmMkEgAeil1/jKge9FA1lGyIERuE2nOiGgawFfOPCwOByhnYmCSTY0FBbSSxuFRJukS/7PqJ816V7lTNpMkWAX+Q3npGbsjxXaO2qzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hi6eH9Lr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VIHpM+ON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hi6eH9Lr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VIHpM+ON"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T7SNup3473612
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 09:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6F+NQl3ytmRKbuu1QUA+sAm9Rdpu+SGt8jg7O9iRPL8=; b=Hi6eH9LrK9FR2UVf
	Q8HV6RUJndhPI0k/5C646OM3EhDIpZsSdw2Mtef1AfkqEElj7/VWDXXqAI6ucAQc
	Dr9Ok5pGh0ecuQzlmUx/hUyokTnEMBaIZZRhw+TTNI6TJ7hq9Uy1EBcV7tSHreKb
	Q23xVcEDvViKG0hhFBXwvhyYaMSn1mwDt6m6dcJ23mhI+wt2m29bzpyYLvXaloM0
	0DROANg2Reu1p9jWcVuAeTitimwHif1iEMVLgKEvYmHWrKc0z6mZcK6a+FxJH1AZ
	3t5bh+5tnXZGhPTZCwjSwqGuJ0Ol2NM2sHJkxRogvn/ViUhWc8j95E7gOSvV+ZPV
	ZqLpDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d64bm2t7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 09:00:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso4103513a91.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774774854; x=1775379654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6F+NQl3ytmRKbuu1QUA+sAm9Rdpu+SGt8jg7O9iRPL8=;
        b=VIHpM+ONYTYWt1PbMUW0xtHh2JYTGeP3lWM7fHLIx3QLp1zUA3XCZDV7syy5rdestO
         uVsOLV1hJN6dDrVX8jW6b41fRQgazsoSa2Xj75cnatfO1JWYzU5ScKg/L4/vGxgWN2DE
         ferpDM2DrQLioL4bkW9wTpOtOR7Lcz+48PHpD5yhn8n2ds30ji4tn/JXIwT2As7iRfqK
         NFJxLz+7Ltv/SAVIeo6k+nH+GeFK90ynJWK6sBP5/t1dSn+dNS4LBlu/XcnqLC0vWCQ2
         Vt45qEk+qlmNimlATpbhYvfHQfYvLHFKS32eUU+DJVquEOimgzOaS/FKrEkiowah9CRz
         sRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774774854; x=1775379654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F+NQl3ytmRKbuu1QUA+sAm9Rdpu+SGt8jg7O9iRPL8=;
        b=OaEy5S4rpg8zH17+tjplfSgnScrAJt4viO32/i8Y6O+rB7mGWR5BZG5vspQn7Z6b3l
         CqCycS6efDFRoim7VT5fSkJZyU8CxNNE1MV/Ix9ndvycDu6s96+idDcsIvxNUqr5cvnn
         0377CDr2WLrzxJZ4l1xc28fCgzE5zktMImtpDFUgunDpe7PVT0S9zqypLvHWKnl1orL2
         as7BlGWoKFinQlDehqB/5aJYt9ohaWNYu0wCh+kfQRm9Mhnv3Xk7kv2VFczH0pSIRIl9
         ZIikko+bIpLltJGrrizASAZqLe+1pS582AHHXk3H4ngKY8REbxc2stO9T7itFCgsR4CP
         Mkog==
X-Forwarded-Encrypted: i=1; AJvYcCWlxnyYQ5H/czsqducDmmvgbhl6/aYBeQ/+kjmaBCtAv035veTY5hx+hJ7kGy71Y/9EPe9yktU5UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ne31HGB8a4ZOjHyA4uq3Be9nEgCCFvGXjacQPUI2rRCaRqkb
	JsuZvUOJfomj78xozCdAFaZWpEEb+IOxuZ5u6HNiupg9fEhnCakhWghyXqxp4c/XpEMsbJ3gz/Z
	k7v7wwmoOi50wN5BOjP8fznm17PHGS7q0tQi6qAnOFdNPwhI0hkcEndDtxkAWRg==
X-Gm-Gg: ATEYQzzXpmRuit8/zJHtZXpjH3Yfcev8LL3D5RrEnXKHGzm+BMoNVHlzFDpl2PuPAud
	1IvLU3mj7/2h3CEdtP1zu14chDljtbPqnHZ1l6hku2V011UVn7KKXfqBbTjEjlVRWUF8Sle7Qpa
	Sa9x7JD410lUO/CXff2sATfxu7ad7QJ/bmlyqw3DcZAEzFBIbiEfKMBVamglSvOfGdfGkC4qUmZ
	07JEcazgIAx1KBoRFrnbrIjLcybvjbhlzAb2S0AbXNfxtKsPTKlODmSVJEGBAYMXYOVvlfM2khq
	vA6xpZX0fH2DMpZum43WBfqj/yK7K54b9p4tHolh8+l2qg7qXVAVPiYKq7gVsRPQb4dAWrlCs5L
	68O1G6dblPkb09HHuEZOFdngNZiIAzBTYSp2LUzcTtsp/lBA6IuCuHACRL+r0OOF4ZlUFKEMn4H
	16HdqHHKXJLtx8S+h3
X-Received: by 2002:a17:90b:1e53:b0:35b:929f:7e95 with SMTP id 98e67ed59e1d1-35c2ffa7b14mr8045223a91.4.1774774853461;
        Sun, 29 Mar 2026 02:00:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1e53:b0:35b:929f:7e95 with SMTP id 98e67ed59e1d1-35c2ffa7b14mr8045179a91.4.1774774852893;
        Sun, 29 Mar 2026 02:00:52 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a82231sm13114540a91.6.2026.03.29.02.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 02:00:52 -0700 (PDT)
Message-ID: <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
Date: Sun, 29 Mar 2026 17:00:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260326204404.1401849-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4SUEDbmK4vVa1KPX20YcbMOsP_zClL5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA2OCBTYWx0ZWRfXxw7CuxmcFkp7
 I3lqIzZqfiSDPYB57W+OAm/apl9GIdyuXx8PNQIYLsg5irmhna0SsYG07X8EzL/EmR+XB3+LTJi
 U9SwvD0PZ6Nxg1Wz1nLbYKvj9iu0yAo1Oqzqo09B47sLce6R7DiXX3HLCs01WCgGSYYIWymAAAU
 N1OhryLFxi42Sb4TnRZCmIzv7K+zwRt+himkmfjMOik+3SREAXb6vgw3vijftzSRrZ8327uCOZB
 boB2uQGAGhu4ujFBNgaW6IxQJlwRiDLdP2frz3DHz5ftazR28EUKpGKEw530CsdMY1QZy+yQXKE
 AQze385WNwdXJc2A4TINqotZOtVufBvGpCN+r+9ZlybxIMOsweTClliIXn9SMwRrqCVfy2BiwG1
 i+DmkCCYuKXhJzs/+oBO6oHapp7pZEgRbJx6/FVljUY6Q9vTBTBkyAJ1Nq8I9TzAFmlJULl19YT
 1nyMIMmV0PRGF6DBpbg==
X-Authority-Analysis: v=2.4 cv=eJAeTXp1 c=1 sm=1 tr=0 ts=69c8ea46 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=mlNTxsip7M4kkws39F0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 4SUEDbmK4vVa1KPX20YcbMOsP_zClL5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290068

On 3/27/2026 4:44 AM, Pierre Gondois wrote:
> The Power Management Quality of Service (PM QoS) allows to
> aggregate constraints from multiple entities. It is currently
> used to manage the min/max frequency of a given policy.
> 
> Frequency constraints can come for instance from:
> - Thermal framework: acpi_thermal_cpufreq_init()
> - Firmware: _PPC objects: acpi_processor_ppc_init()
> - User: by setting policyX/scaling_[min|max]_freq
> The minimum of the max frequency constraints is used to compute
> the resulting maximum allowed frequency.
> 
> When enabling boost frequencies, the same frequency request object
> (policy->max_freq_req) as to handle requests from users is used.
> As a result, when setting:
> - scaling_max_freq
> - boost
> The last sysfs file used overwrites the request from the other
> sysfs file.
> 
> To avoid this, create a per-policy boost_freq_req to save the boost
> constraints instead of overwriting the last scaling_max_freq
> constraint.
> 
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> In the existing .set_boost() callbacks:
> - Don't update policy->max as this is done through the qos notifier
>    cpufreq_notifier_max() which calls cpufreq_set_policy().
> - Remove freq_qos_update_request() calls as the qos request is now
>    done in policy_set_boost() and updates the new boost_freq_req
> 
> $ ## Init state
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> $ echo 1 > ../boost
> scaling_max_freq:1200000
> cpuinfo_max_freq:1200000
> 
> $ echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> $ ## Final step:
> $ ## Without the patches:
> $ echo 0 > ../boost
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> $ ## With the patches:
> $ echo 0 > ../boost
> scaling_max_freq:800000
> cpuinfo_max_freq:1000000
> 
> Note:
> cpufreq_frequency_table_cpuinfo() updates policy->min
> and max from:
> A.
> cpufreq_boost_set_sw()
> \-cpufreq_frequency_table_cpuinfo()
> B.
> cpufreq_policy_online()
> \-cpufreq_table_validate_and_sort()
>    \-cpufreq_frequency_table_cpuinfo()
> Keep these updates as some drivers expect policy->min and
> max to be set through B.
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   drivers/cpufreq/amd-pstate.c   |  2 --
>   drivers/cpufreq/cppc_cpufreq.c | 10 ++------
>   drivers/cpufreq/cpufreq.c      | 46 +++++++++++++++++++++++-----------
>   include/linux/cpufreq.h        |  1 +
>   4 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..d0675d6a19fe1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -769,8 +769,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>   	else if (policy->cpuinfo.max_freq > nominal_freq)
>   		policy->cpuinfo.max_freq = nominal_freq;
>   
> -	policy->max = policy->cpuinfo.max_freq;
> -
>   	if (cppc_state == AMD_PSTATE_PASSIVE) {
>   		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>   		if (ret < 0)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 011f35cb47b94..f4f574fbe547b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -807,17 +807,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>   {
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -	int ret;
>   
>   	if (state)
> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>   	else
> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>   
>   	return 0;
>   }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5757f12633d16..d2f393d738a39 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -609,10 +609,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>   	policy->boost_enabled = enable;
>   
>   	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>   		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>   
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	if (ret < 0) {
> +		policy->boost_enabled = !policy->boost_enabled;
> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +		return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   static ssize_t store_local_boost(struct cpufreq_policy *policy,
> @@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>   	}
>   
>   	freq_qos_remove_request(policy->min_freq_req);
> +	freq_qos_remove_request(policy->boost_freq_req);
>   	kfree(policy->min_freq_req);
>   
>   	cpufreq_policy_put_kobj(policy);
> @@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>   
>   	if (new_policy) {
> +		unsigned int count;
> +
>   		for_each_cpu(j, policy->related_cpus) {
>   			per_cpu(cpufreq_cpu_data, j) = policy;
>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>   		}
>   
> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> +		count = policy->boost_supported ? 3 : 2;
> +		policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>   					       GFP_KERNEL);
>   		if (!policy->min_freq_req) {
>   			ret = -ENOMEM;
>   			goto out_destroy_policy;
>   		}
>   
> +		if (policy->boost_supported) {
> +			policy->boost_freq_req = policy->min_freq_req + 2;
> +
> +			ret = freq_qos_add_request(&policy->constraints,
> +						   policy->boost_freq_req,
> +						   FREQ_QOS_MAX,
> +						   policy->cpuinfo.max_freq);
> +			if (ret < 0) {
> +				policy->boost_freq_req = NULL;
> +				goto out_destroy_policy;
> +			}
> +		}
> +
>   		ret = freq_qos_add_request(&policy->constraints,
>   					   policy->min_freq_req, FREQ_QOS_MIN,
>   					   FREQ_QOS_MIN_DEFAULT_VALUE);
>   		if (ret < 0) {
> -			/*
> -			 * So we don't call freq_qos_remove_request() for an
> -			 * uninitialized request.
> -			 */
>   			kfree(policy->min_freq_req);
>   			policy->min_freq_req = NULL;
>   			goto out_destroy_policy;

Hi Pierre, Viresh,

Sorry for the late follow-up on v8. While re-reading the patch, I
noticed a potential UAF issue on an error path — I might be missing
something, so I'd appreciate a double-check.

min_freq_req, max_freq_req and boost_freq_req all point into the same
contiguous kzalloc'd block:

slot0 (min_freq_req + 0) -> min_freq_req
slot1 (min_freq_req + 1) -> max_freq_req
slot2 (min_freq_req + 2) -> boost_freq_req

If boost_freq_req is successfully added to the QoS constraints list, but
the subsequent freq_qos_add_request() for min_freq_req fails, the error
path does:

kfree(policy->min_freq_req); /* frees the entire block, including slot2
*/
policy->min_freq_req = NULL;
goto out_destroy_policy;

policy->boost_freq_req is not set to NULL here, so it becomes a dangling
pointer into freed memory.
cpufreq_policy_free() is then called from cpufreq_online() and does:

freq_qos_remove_request(policy->boost_freq_req); /* UAF */
or this boost qos req will leak.


If freq_qos_add_request() for min_freq_req fails, maybe we can remove
boost qos first, such as:

if (ret < 0) {
	if (policy->boost_freq_req) {
		freq_qos_remove_request(policy->boost_freq_req);
		policy->boost_freq_req = NULL;
	}
	kfree(policy->min_freq_req);
	policy->min_freq_req = NULL;
	goto out_destroy_policy;
}



Besides, if freq_qos_add_request() for boost_freq_req fails first on
cpufreq_policy_online(),  policy->min_freq_req is valid pointer but qos
req is inactive, will trigger one warn on
freq_qos_remove_request(policy->min_freq_req) {
	if (WARN(!freq_qos_request_active(req),
		"%s() called for unknown object\n", __func__))
		return -EINVAL;
}


> @@ -2788,16 +2810,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   		return -ENXIO;
>   
>   	ret = cpufreq_frequency_table_cpuinfo(policy);
> -	if (ret) {
> +	if (ret)
>   		pr_err("%s: Policy frequency update failed\n", __func__);
> -		return ret;
> -	}
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>   
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc389710..89157e367eefa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>   	struct freq_constraints	constraints;
>   	struct freq_qos_request	*min_freq_req;
>   	struct freq_qos_request	*max_freq_req;
> +	struct freq_qos_request *boost_freq_req;
>   
>   	struct cpufreq_frequency_table	*freq_table;
>   	enum cpufreq_table_sorting freq_table_sorted;


-- 
Thx and BRs,
Zhongqiu Han
