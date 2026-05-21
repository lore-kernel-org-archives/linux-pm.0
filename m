Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01701A6815
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371903; cv=none; b=D8qqhYy2crjaUPT2vBiTlQWQdpz0yfzXzFq1H2X9l+1SSKtQWgH+X9VzI0iHmgQjVbqQGPgou6w1fKrOxH8R7E4tj+j212pKoEeNFdSFTQ/FHNJoTE1tbEZl4UR+GhJpIW26FN5J5BIKsDhiXf9SK1KAOb2FsCD8j7tGnAcAos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371903; c=relaxed/simple;
	bh=5W7zvDbYb5ud7DIuSVmNWYuGRmj2WGwA7i8DPJAlscg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8+n/YPUcT8tKkTEjS9mfT22k/iwQ0XGpH8upLBxLByuacTK0E1ThC4onHOCDxo+SQrMgZQ4byYJuDMT0jfZHiEP3i9nzD9r5hifb2a6eM3Zq00yJveEAyP1hG67DPjGQiYDY1XWFiUFpIBFSIGXgq6c38cJvxs70cPNyECgfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSYJwijC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZPqDkoBK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSYJwijC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZPqDkoBK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LDo15m3129531
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cfs/KCWe9kEqW1turPK549KRfx/Jsvd4EaJuFgi6Hvc=; b=VSYJwijC6rHLoWj9
	bmbG16HNcmgyemd1AfvyAAOOa9zgdLnsuVm8yspcOz2IxfukDa3Do+t+JkDAoWgK
	+T//68kco3ws1HSjD4o5Qy6zhmdkqOmlurQPnTApQpq0Kv7OdvNxdFVpNHoY5Yce
	10xGRez5Y05VsccUWJzAu581f/jUvN2Z+qa76jxU11o6aZ8G1gxCv7q2pg+GTzx3
	D6X9zCHLcEyUyanim3X5oB0AeVKVgiNZ/xr+dfUdpBRlEczM9bZ7Dj3ZhZxnFVRh
	HR6YI1dSiQ4sbUi331ulAsIUPSgdT1clzpMGMIFvktrZoB9KXUkKf9InGMOzMuM6
	bxlb+g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gr145-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:58:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2baf7748d0aso60059345ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779371900; x=1779976700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfs/KCWe9kEqW1turPK549KRfx/Jsvd4EaJuFgi6Hvc=;
        b=ZPqDkoBKYjxLFjz1swlGoiKrqalhaAjK0hPg9m89ux7y1aDdeNQoIwie26eHbwiUdR
         dthsEP09swvGW9I3FmQiuOwpEU2UFGL+fokNFHPMSo6bI5mX9f0jqm2Q7BwPlYE5D7KB
         T+cylo2pHZzuFrlsd7EVX+F/JjrCg9JZGAhxl85aSBzgyvj6gOD1iADSBFN/FKbAjL/D
         v6VPraB5NJwIF683WMWvBrOMTHOlWsgk8RyUTqVPMvphnjRbNdNsIeWxZkDRgcMZJz8B
         Ryb6IbCpFL767JyM0rWXLApm1hYjh+9pbd7bK605m9h2B5tnVs5chkF/LBpgyqzpGmAF
         +s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371900; x=1779976700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfs/KCWe9kEqW1turPK549KRfx/Jsvd4EaJuFgi6Hvc=;
        b=YzDQgXWYOFpql9BPl8p2KtPTxUTcpplx2KjPxBrzB8ptJ8R8SEDUAGLYZL2h8KOyC8
         ajH1Q0gbwKTTzeVQrhJzMP3KZJJgl6tA6krm/EOhjXGEVTJo3ZkoUHkTpenOzkJo5/2T
         h0JGgyODdhN4DiTwXwy4JkTeYyOEmd9Bq0XKBKWE5JtK8gwaUnt7ELy4PP+XTijNND/O
         S8u1RytPzGRsqz2fe0e0UzQYj/a9GUoi0n0RjHpvtCNyVI7omkjQnNsVd8tp4cBNuiWj
         KrvVEIIWPvq3ULlHrvcfKl1A9Lolb5jMf6vtfSk2w8VfiUSScm7rpsmT/zYcgOyfMjyz
         hKdQ==
X-Gm-Message-State: AOJu0YxUgrleUdSSASH25OS2qy+2MM02z+yhVRY6ykUuHf9RSCbDiDHM
	LfYtXT837JwrpMQl4LFICESUi9s3eqdc5xK2VeBZTs82gz6G1lmcHb9M3J/xP6PFxMNRqnf1cjW
	Gb44D4gpTTSbcpg/foy5erGjlJYHqF6oWjTJvXAB4d0FZR72HUsJBH/U+VO8iFA==
X-Gm-Gg: Acq92OGkhhsbcBfM2Ab2I47XX6V4+TpC+YrU0w0nvn8Ztnlu4uzi4Bz02usEulWpKRJ
	PEqhWVe3doO1uUo3zkXDST0eXpkZt1yiUEdWtfcR2gXFUl2J1ubQxutbMMMQUR5fvoLYFtBGICf
	U8fTboL3z7GOc+A1heLVclh+uonjJS2ctjqwDOkT8gd/Kx+msJTmRqP3GbLjJIY44NNED9krzgP
	3zEu1YRDZrcxyQS6sl+ROs4Q8neJae/c9wcouKkvHYbma60Ri2MJZOGMD2JRCmBteKcah3c2d4g
	aXnQ/eiz68EjtI1JO3Uh3c3Xap8qAZ0T2raHX8AI4Ej6fe7Jf7lPTjDiVrZm2PaYDKbAFia05Ot
	GyaAmVtCD/KSfCOai6dlS89a0CiXbeiYSTxFOYlnvteFXCpDYY/GgdA8gyizGVcQf2MGVwAhv50
	/Ck+Hx9XgXHty+grxISQ==
X-Received: by 2002:a17:902:f603:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bea32ee77amr35852245ad.16.1779371900452;
        Thu, 21 May 2026 06:58:20 -0700 (PDT)
X-Received: by 2002:a17:902:f603:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bea32ee77amr35851945ad.16.1779371899965;
        Thu, 21 May 2026 06:58:19 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9a3b4ecsm12712955ad.82.2026.05.21.06.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:58:19 -0700 (PDT)
Message-ID: <0078ab64-05a9-428c-a8ea-ae5a2df4c1e1@oss.qualcomm.com>
Date: Thu, 21 May 2026 21:58:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpufreq: Avoid redundant target() calls for unchanged
 limits
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
 <4c0a951bc57b7fd5cacb6211a96770e5791b1fbc.1779360823.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <4c0a951bc57b7fd5cacb6211a96770e5791b1fbc.1779360823.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a0f0f7d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=RTY-GXQpHRsC_R4ByjIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TYffHXNaoceB5PRU_Dqfk_NHHk27zc33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX3WUTJEocGtR1
 nJl1aWAC7WPeOe4IOjkZeRh8qpu5hiVPwuJUXiohgWhdH9NECFT41g+ZNGdi1Obpd/KrpDk8jcf
 dLSVWoAzaaxyA3rQ0+p1O/Ng6nFhCgbP9OGxBdAY2stilPd7mjsrHYCGldSet17DBicXeI51fEP
 IpqrV50S4/ER57rWkxJ1P0hbdaDuCAISJIgkZ3q+g7WUlvpDgffVsX9IqSYWcELIo1oDvM8g9bJ
 7pkfQz6d99fFXKj2uqO77XPBcj9hYU6jtvn/JJDJACH4+ODPLxSFOWT1pUPhZBW99i6NIQSeBu6
 yiNoR7dwCpP/V46/KQO++ZqmN8CcSd3Yqxe5yYjSwlQteElFMEsBBEnY5K69nYhWdhrKnSfX+nR
 xNoNLDFAtVrWzn2SxdPmldEITrgI5IZGbTVsVPWPP+RzWOi0yuEtLs0dxgR7TkRuumNHG9jaJYc
 H5qv7xPVeaFAGPwGqog==
X-Proofpoint-GUID: TYffHXNaoceB5PRU_Dqfk_NHHk27zc33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210140

On 5/21/2026 7:39 PM, Viresh Kumar wrote:
> Drivers setting CPUFREQ_NEED_UPDATE_LIMITS expect target() to be
> invoked even if the target frequency remains unchanged, so they can
> update their internal policy limits state.
> 
> Currently the core invokes target() unconditionally whenever the
> requested frequency matches policy->cur for such drivers, even if
> policy->min and policy->max haven't changed since the previous update.
> 
> Track pending policy limit updates explicitly and skip redundant
> target() invocations when neither the target frequency nor the
> effective limits changed.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c      | 31 ++++++++++++++++++++++---------
>   drivers/cpufreq/intel_pstate.c |  1 +
>   include/linux/cpufreq.h        |  3 +++
>   3 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1..225228e9f4ed 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2366,9 +2366,13 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>   	 * exactly same freq is called again and so we can save on few function
>   	 * calls.
>   	 */
> -	if (target_freq == policy->cur &&
> -	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
> -		return 0;
> +	if (target_freq == policy->cur) {
> +		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
> +		    !policy->update_limits)
> +			return 0;
> +
> +		policy->update_limits = false;
> +	}
>   
>   	if (cpufreq_driver->target) {
>   		/*
> @@ -2620,6 +2624,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   {
>   	struct cpufreq_policy_data new_data;
>   	struct cpufreq_governor *old_gov;
> +	unsigned int freq;
>   	int ret;
>   
>   	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
> @@ -2652,12 +2657,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>   	 * compiler optimizations around them because they may be accessed
>   	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>   	 */
> -	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
> -					       new_data.min, new_data.max,
> -					       CPUFREQ_RELATION_H));
> -	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
> -				      new_data.max, CPUFREQ_RELATION_L);
> -	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
> +	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
> +			      CPUFREQ_RELATION_H);
> +	if (freq != policy->max) {
> +		WRITE_ONCE(policy->max, freq);
> +		policy->update_limits = true;
> +	}
> +
> +	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
> +			      CPUFREQ_RELATION_L);
> +	freq = min(freq, policy->max);
> +	if (freq != policy->min) {
> +		WRITE_ONCE(policy->min, freq);
> +		policy->update_limits = true;
> +	}
>   
>   	trace_cpu_frequency_limits(policy);
>   
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fc..7f19ec6b70ba 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2942,6 +2942,7 @@ static void intel_pstate_adjust_policy_max(struct cpudata *cpu,
>   	    policy->max > cpu->pstate.max_freq) {
>   		pr_debug("policy->max > max non turbo frequency\n");
>   		policy->max = policy->cpuinfo.max_freq;
> +		policy->update_limits = true;


This patch looks good to me overall.

Just one concern:

Could this be redundant?

It seems that intel_pstate_adjust_policy_max() is only triggered when
!hwp_active, whereas CPUFREQ_NEED_UPDATE_LIMITS is set when
hwp_active is enabled. If so, the update_limits flag set here may not
actually be consumed, as __cpufreq_driver_target() would skip the
update_limits check for drivers without CPUFREQ_NEED_UPDATE_LIMITS.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/intel_pstate.c#n3808

Also, it looks like intel_pstate_adjust_policy_max() uses struct
cpufreq_policy_data rather than cpufreq_policy.


>   	}
>   }
>   
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4d4b4ed24b30..ae9d1ce4f49c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -146,6 +146,9 @@ struct cpufreq_policy {
>   	/* Per policy boost supported flag. */
>   	bool			boost_supported;
>   
> +	/* Pending policy->min/max update for the driver */
> +	bool			update_limits;
> +
>   	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>   	unsigned int cached_target_freq;
>   	unsigned int cached_resolved_idx;


-- 
Thx and BRs,
Zhongqiu Han
