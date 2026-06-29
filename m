Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97E3EAC9F
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744948; cv=none; b=KAn30sBar7Yc3KRkZRPpzmopQCARy2zIGm022T3oqSAEPNcR2sM1+hOwd2W84Qg7SQZOD1O2vdr9QtairO0NW0OKX9B2YXEQbqBEjrjq0oSIfVzy5kz4e3lCchwG9BlcW9YrbdpGhEqRqRR4k+B4BDPGnl7jpmkeBl6ebScZZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744948; c=relaxed/simple;
	bh=SGuGoCNOVXq+MiqzY8nl+r4hDYbQvXD2Xf7IxjEaxWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rbs1vxtvMvZIiV3ckmfwvvgYd0y+S9SvbwgVxLS2fDE1k8frIy4vLFijhQFMN9ApUZ6GIi6nyHGggc3b5lM3WI/0cT4yNMJrWZpwpQkqSZuEeGUVWCZLY0P2dtKylyXHiQsD4bIeUpba/6dDC1t0bhwa8ee2xl4Na9wTxGOA5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsBbdYII; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BV6Q9y50; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsBbdYII";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BV6Q9y50"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATTmk2579629
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aROXKQm7BEsZKfoq0OpUQLeRAFljItbhTNwvfVJL5gA=; b=AsBbdYIIneQgNmWB
	C0Xe6omrBeZli0IAckm3+KJeBT6KyQJPLmJBnQ2GypNg28yGEL9jDhF3NPi9oMim
	+i5nkWHD6lGqCfbObB3KGP+iOXAKZIGAhFjQ2GpJbPY497DkYWUbOOQ7zGECUZcx
	278zK4icF/5JDKmhvNZUqGm3eWvfsIA6Fhex02t7FH5Q4fWsk4eTS+aXANhMJ2Lj
	EdgL6JeM3ToY6V24aJiau0biKMUFgO9vYF/G2P74JpwleCq7Fa6V/BEStfk2K7y2
	bzBaeaQvfB5mffmGl7bv49WSgANRkeWjhAVYBlLsZJdvJt95KfUgC4IsSdV5LXSX
	C1QRQg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hxr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:55:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso2498962b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782744944; x=1783349744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aROXKQm7BEsZKfoq0OpUQLeRAFljItbhTNwvfVJL5gA=;
        b=BV6Q9y50Jt5INDFRO4XAI1fa6ShXP9Hksg3C3FIwELLHwt5oqGNPG85oY7VWIvyvOe
         Ry8MPfxfstY4+2O5mxFrfFh7THv8hij0S7a1Q8slBMuZ2IWfiVhc2kfoa7F2MxfV+os2
         Hpt3s2s5EiUNlLfovezYJmPasQ+9EE2odr46VEPVYszu3I06iQMalmfsSdlIqCA/zFcB
         9EGU8YW8gCni1PXNjcPink7jsLb+Dvz8k07poACuwlk2pig8vKQjhJX1MUktgnI3tNkc
         BbHq7BXtldxtSOdT0ShzC3HVKoUZbWm5YTFAMFhptRu5zlHU9K0Q/cOxG2Hj/c8rIXCG
         qjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744944; x=1783349744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aROXKQm7BEsZKfoq0OpUQLeRAFljItbhTNwvfVJL5gA=;
        b=Eddb8bDanoBITy1C6eTKbziSPk4H/Fl3cEt6/eZZbsawFxLrPV/T+XKgliTQHze3nl
         eD7SBMobIwIBFYI+RPJhMy5daLYXb19l1FrLY6IlAgXuCffUJwLz92VOOg4KOpAwH5QM
         TveIcbdjOU6S4nygFLSU3JITzlg4a1pJmJlw0LDHcQwsVMOoJUBndONkS9H2FgCrJNCm
         HThQdGnw/x8w7XCKg8+kd27R3s5iK2doFrJAtt82lqv3ooehRIYClGph7UvucFMwSMhu
         yGOSlnm8s0lbOEhbVeXOnVxvN+zg5t6DcujXbF1J0DdQHJ6EGR0TnNGCMqsTOvH0p/mO
         MPEw==
X-Forwarded-Encrypted: i=1; AHgh+RoOIHiwfQmjHs4sIaprJeRn0+nJfNGnu8bIK4mXXPAMVYNhHvmC+VX8M2xQYZI4vdAuQT6d5nqUoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/C0tYRN/XgwpvtxcjJ0vtXMQXbqAs4n4cI9ryoplmLLF6IBvd
	48450tRutDsSlOiyvd4vA54FIZl7E4+uCh8zTq6HvWS2HPwXKKTwL6tbm98BsNmogGgcoevgaXH
	nKIJ5KjFPw0NRg8GGm4UWeg5SVPiWDfaD/vzfma51MSGru9pR3MLg/A50/gt0og==
X-Gm-Gg: AfdE7cl/EqZdo38sEsR5KEA0SRiaRXQzuM3OEL3m+ttjoJWI9TchWwu5KueY9zXZ6JK
	NpOJdY75cvJeDGNNoQcOkbH33CsAREFSozAJvQnxd/gqpqqKXWKMFpNV/vwvu9hvfbpW3y+sxkI
	ci1hqgKyskBd8TpNd3u+J457lhgZiH53Oq8/yRsktKNDqbTGiEhaHh0rF7QkzzMjouDlMNYZD+K
	dQ8J28h4TAh9y8bE27X7K6s49+Ok3v7sNeCgT9omjanO7rVAtVuXgji1FgARyTMj2VPGkyLQByu
	Wsmun4+uiCqoPnTwrRV+snFZJTx363+3bXpnqtU8M/LpvCfEacgeeFnc49BzYwtUf5lPbet/xLA
	Tfi+Z8WmdKYB1+A+Tv+98sb2kpILk0bxFnufsedoODh0W/Mgj9aExVCNXqR7vk7hF2ModUJylkL
	nZyKlVoA==
X-Received: by 2002:a05:6a00:6f49:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-84787041e28mr2459371b3a.20.1782744943300;
        Mon, 29 Jun 2026 07:55:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:6f49:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-84787041e28mr2459348b3a.20.1782744942651;
        Mon, 29 Jun 2026 07:55:42 -0700 (PDT)
Received: from [10.133.33.246] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845d8560fbasm4904766b3a.15.2026.06.29.07.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:55:42 -0700 (PDT)
Message-ID: <faa8f6fa-f393-42f4-97dc-7cde4fbf9616@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:55:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] cpufreq: Stop using 32-bit MSR interfaces
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, zhongqiu.han@oss.qualcomm.com
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-17-jgross@suse.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260629060526.3638272-17-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfX7ve7xtgsbkFY
 2eUq9xs/fZrkhtdCIRZTSehevWi3LOGdoWdQVPs8G3V46UjlOA9gX7axU6qDVwWh8mSfooenvWM
 bYDuJiP/AaOlpGoHzIvc/Vc6JPJzWqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfX7DmxyeF4wbuv
 HS86xMLax1gQNv9Wd4kV7zh36ZEaJFaSrMVv9mIImGUfw2XVDhszJyHXLf5aAdzCnt7hbxFYew2
 A9gcRuvtr2mxvgo6zYP5pTiLz+GnxOFZBcM34CVECqXoG+erahike31fEeNBcmAzCaRbPxXYL0F
 I4z96xMArMR/A481OLNcMu+51sggEtrrbhs8uj6KIwRa26g64HbMPTyoHg3qLw7z3QrCmlq7+0W
 QFNfABTFDqdHlHjFRkDGkaNv73oaqSLguqeet4SVFVXoxb5QbVKLNmB1vQwdDnhHR4fQzwEm4D4
 0mLuNfD0rhQdX7xtBSIYN12r6hgRDgbVw/EXBFEs9D+uBAf/ZQL+SbI7+cHr92V6NRMPmYnP4op
 sradzCbgXFuO667E+fBdTXtEcB4Y+OsP/owWU1fPM+NZbFSgUVdpY6wFSN5VrFKZiIcB591CASl
 dtGNUbkVCJjnpxbakqQ==
X-Proofpoint-ORIG-GUID: pYINZc0GkGO_swy9bxQfGZKkU9cm6H20
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a428770 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=iox4zFpeAAAA:8 a=-HW9kgWw5hcRzoMMlDQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: pYINZc0GkGO_swy9bxQfGZKkU9cm6H20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290124

On 6/29/2026 2:05 PM, Juergen Gross wrote:
> The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
> removed. Use the related 64-bit variants instead.

Hello Juergen,

> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c       | 22 ++++----
>   drivers/cpufreq/e_powersaver.c       | 48 ++++++++---------
>   drivers/cpufreq/longhaul.c           | 15 +++---
>   drivers/cpufreq/longrun.c            | 78 +++++++++++++++-------------
>   drivers/cpufreq/powernow-k6.c        | 12 ++---
>   drivers/cpufreq/powernow-k8.c        | 67 ++++++++++++------------
>   drivers/cpufreq/speedstep-centrino.c | 16 +++---
>   drivers/cpufreq/speedstep-lib.c      | 63 +++++++++++-----------
>   8 files changed, 166 insertions(+), 155 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 21639d9ac753..b40fa99b5ab2 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -246,32 +246,32 @@ static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
>   
>   static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
>   {
> -	u32 val, dummy __always_unused;
> +	u64 val;
>   
> -	rdmsr(MSR_IA32_PERF_CTL, val, dummy);
> -	return val;
> +	rdmsrq(MSR_IA32_PERF_CTL, val);
> +	return (u32)val;
>   }
>   
>   static void cpu_freq_write_intel(struct acpi_pct_register *not_used, u32 val)
>   {
> -	u32 lo, hi;
> +	struct msr msrval;
>   
> -	rdmsr(MSR_IA32_PERF_CTL, lo, hi);
> -	lo = (lo & ~INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
> -	wrmsr(MSR_IA32_PERF_CTL, lo, hi);
> +	rdmsrq(MSR_IA32_PERF_CTL, msrval.q);
> +	msrval.h = (msrval.h & ~INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);

msrval.l？

please feel free to correct me if there is any misunderstanding.

how about using u64 directly?

     u64 msrval;
     rdmsrq(MSR_IA32_PERF_CTL, msrval);
     msrval = (msrval & ~(u64)INTEL_MSR_RANGE) | (val & INTEL_MSR_RANGE);
     wrmsrq(MSR_IA32_PERF_CTL, msrval);

As per my understanding, we can use u64 instead of struct msr in many
other places in this patch as well.

> +	wrmsrq(MSR_IA32_PERF_CTL, msrval.q);
>   }
>   
>   static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
>   {
> -	u32 val, dummy __always_unused;
> +	u64 val;
>   
> -	rdmsr(MSR_AMD_PERF_CTL, val, dummy);
> -	return val;
> +	rdmsrq(MSR_AMD_PERF_CTL, val);
> +	return (u32)val;
>   }
>   
>   static void cpu_freq_write_amd(struct acpi_pct_register *not_used, u32 val)
>   {
> -	wrmsr(MSR_AMD_PERF_CTL, val, 0);
> +	wrmsrq(MSR_AMD_PERF_CTL, val);
>   }
>   
>   static u32 cpu_freq_read_io(struct acpi_pct_register *reg)
> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> index eb5a9209d828..13709f9667ea 100644
> --- a/drivers/cpufreq/e_powersaver.c
> +++ b/drivers/cpufreq/e_powersaver.c
> @@ -90,7 +90,7 @@ static int eps_acpi_exit(struct cpufreq_policy *policy)
>   static unsigned int eps_get(unsigned int cpu)
>   {
>   	struct eps_cpu_data *centaur;
> -	u32 lo, hi;
> +	u64 val;
>   
>   	if (cpu)
>   		return 0;
> @@ -99,35 +99,35 @@ static unsigned int eps_get(unsigned int cpu)
>   		return 0;
>   
>   	/* Return current frequency */
> -	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> -	return centaur->fsb * ((lo >> 8) & 0xff);
> +	rdmsrq(MSR_IA32_PERF_STATUS, val);
> +	return centaur->fsb * ((val >> 8) & 0xff);
>   }
>   
>   static int eps_set_state(struct eps_cpu_data *centaur,
>   			 struct cpufreq_policy *policy,
>   			 u32 dest_state)
>   {
> -	u32 lo, hi;
> +	u64 val;
>   	int i;
>   
>   	/* Wait while CPU is busy */
> -	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> +	rdmsrq(MSR_IA32_PERF_STATUS, val);
>   	i = 0;
> -	while (lo & ((1 << 16) | (1 << 17))) {
> +	while (val & ((1 << 16) | (1 << 17))) {
>   		udelay(16);
> -		rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> +		rdmsrq(MSR_IA32_PERF_STATUS, val);
>   		i++;
>   		if (unlikely(i > 64)) {
>   			return -ENODEV;
>   		}
>   	}
>   	/* Set new multiplier and voltage */
> -	wrmsr(MSR_IA32_PERF_CTL, dest_state & 0xffff, 0);
> +	wrmsrq(MSR_IA32_PERF_CTL, dest_state & 0xffff);
>   	/* Wait until transition end */
>   	i = 0;
>   	do {
>   		udelay(16);
> -		rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> +		rdmsrq(MSR_IA32_PERF_STATUS, val);
>   		i++;
>   		if (unlikely(i > 64)) {
>   			return -ENODEV;


	do {
		udelay(16);
		rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
		i++;
		if (unlikely(i > 64)) {
			return -ENODEV;
		}
	} while (lo & ((1 << 16) | (1 << 17)));-->lo has been deleted?





> @@ -139,10 +139,10 @@ static int eps_set_state(struct eps_cpu_data *centaur,
>   	u8 current_multiplier, current_voltage;
>   
>   	/* Print voltage and multiplier */
> -	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> -	current_voltage = lo & 0xff;
> +	rdmsrq(MSR_IA32_PERF_STATUS, val);
> +	current_voltage = val & 0xff;
>   	pr_info("Current voltage = %dmV\n", current_voltage * 16 + 700);
> -	current_multiplier = (lo >> 8) & 0xff;
> +	current_multiplier = (val >> 8) & 0xff;
>   	pr_info("Current multiplier = %d\n", current_multiplier);
>   	}
>   #endif
> @@ -171,8 +171,8 @@ static int eps_target(struct cpufreq_policy *policy, unsigned int index)
>   static int eps_cpu_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int i;
> -	u32 lo, hi;
>   	u64 val;
> +	struct msr status;
>   	u8 current_multiplier, current_voltage;
>   	u8 max_multiplier, max_voltage;
>   	u8 min_multiplier, min_voltage;
> @@ -195,13 +195,13 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>   
>   	switch (c->x86_model) {
>   	case 10:
> -		rdmsr(0x1153, lo, hi);
> -		brand = (((lo >> 2) ^ lo) >> 18) & 3;
> +		rdmsrq(0x1153, val);
> +		brand = (((val >> 2) ^ val) >> 18) & 3;
>   		pr_cont("Model A ");
>   		break;
>   	case 13:
> -		rdmsr(0x1154, lo, hi);
> -		brand = (((lo >> 4) ^ (lo >> 2))) & 0x000000ff;
> +		rdmsrq(0x1154, val);
> +		brand = (((val >> 4) ^ (val >> 2))) & 0x000000ff;
>   		pr_cont("Model D ");
>   		break;
>   	}
> @@ -237,20 +237,20 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>   	}
>   
>   	/* Print voltage and multiplier */
> -	rdmsr(MSR_IA32_PERF_STATUS, lo, hi);
> -	current_voltage = lo & 0xff;
> +	rdmsrq(MSR_IA32_PERF_STATUS, status.q);
> +	current_voltage = status.l & 0xff;
>   	pr_info("Current voltage = %dmV\n", current_voltage * 16 + 700);
> -	current_multiplier = (lo >> 8) & 0xff;
> +	current_multiplier = (status.l >> 8) & 0xff;
>   	pr_info("Current multiplier = %d\n", current_multiplier);
>   
>   	/* Print limits */
> -	max_voltage = hi & 0xff;
> +	max_voltage = status.h & 0xff;
>   	pr_info("Highest voltage = %dmV\n", max_voltage * 16 + 700);
> -	max_multiplier = (hi >> 8) & 0xff;
> +	max_multiplier = (status.h >> 8) & 0xff;
>   	pr_info("Highest multiplier = %d\n", max_multiplier);
> -	min_voltage = (hi >> 16) & 0xff;
> +	min_voltage = (status.h >> 16) & 0xff;
>   	pr_info("Lowest voltage = %dmV\n", min_voltage * 16 + 700);
> -	min_multiplier = (hi >> 24) & 0xff;
> +	min_multiplier = (status.h >> 24) & 0xff;
>   	pr_info("Lowest multiplier = %d\n", min_multiplier);
>   
>   	/* Sanity checks */
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index a18d1d11725f..4c2599264333 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -118,13 +118,14 @@ static unsigned int calc_speed(int mult)
>   
>   static int longhaul_get_cpu_mult(void)
>   {
> -	unsigned long invalue = 0, lo, hi;
> +	unsigned long invalue = 0;
> +	u64 val;
>   
> -	rdmsr(MSR_IA32_EBL_CR_POWERON, lo, hi);
> -	invalue = (lo & (1<<22|1<<23|1<<24|1<<25))>>22;
> +	rdmsrq(MSR_IA32_EBL_CR_POWERON, val);
> +	invalue = (val & (1<<22|1<<23|1<<24|1<<25))>>22;
>   	if (longhaul_version == TYPE_LONGHAUL_V2 ||
>   	    longhaul_version == TYPE_POWERSAVER) {
> -		if (lo & (1<<27))
> +		if (val & (1<<27))
>   			invalue += 16;
>   	}
>   	return eblcr[invalue];
> @@ -761,7 +762,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
>   	struct cpuinfo_x86 *c = &cpu_data(0);
>   	char *cpuname = NULL;
>   	int ret;
> -	u32 lo, hi;
> +	u64 val;
>   
>   	/* Check what we have on this motherboard */
>   	switch (c->x86_model) {
> @@ -835,8 +836,8 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
>   	}
>   	/* Check Longhaul ver. 2 */
>   	if (longhaul_version == TYPE_LONGHAUL_V2) {
> -		rdmsr(MSR_VIA_LONGHAUL, lo, hi);
> -		if (lo == 0 && hi == 0)
> +		rdmsrq(MSR_VIA_LONGHAUL, val);
> +		if (val == 0)
>   			/* Looks like MSR isn't present */
>   			longhaul_version = TYPE_LONGHAUL_V1;
>   	}
> diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
> index f3aaca0496a4..99abef32e7e5 100644
> --- a/drivers/cpufreq/longrun.c
> +++ b/drivers/cpufreq/longrun.c
> @@ -35,27 +35,27 @@ static unsigned int longrun_low_freq, longrun_high_freq;
>    */
>   static void longrun_get_policy(struct cpufreq_policy *policy)
>   {
> -	u32 msr_lo, msr_hi;
> +	struct msr msr;
>   
> -	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
> -	pr_debug("longrun flags are %x - %x\n", msr_lo, msr_hi);
> -	if (msr_lo & 0x01)
> +	rdmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
> +	pr_debug("longrun flags are %x - %x\n", msr.l, msr.h);
> +	if (msr.l & 0x01)
>   		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>   	else
>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>   
> -	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
> -	pr_debug("longrun ctrl is %x - %x\n", msr_lo, msr_hi);
> -	msr_lo &= 0x0000007F;
> -	msr_hi &= 0x0000007F;
> +	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
> +	pr_debug("longrun ctrl is %x - %x\n", msr.l, msr.h);
> +	msr.l &= 0x0000007F;
> +	msr.h &= 0x0000007F;
>   
>   	if (longrun_high_freq <= longrun_low_freq) {
>   		/* Assume degenerate Longrun table */
>   		policy->min = policy->max = longrun_high_freq;
>   	} else {
> -		policy->min = longrun_low_freq + msr_lo *
> +		policy->min = longrun_low_freq + msr.l *
>   			((longrun_high_freq - longrun_low_freq) / 100);
> -		policy->max = longrun_low_freq + msr_hi *
> +		policy->max = longrun_low_freq + msr.h *
>   			((longrun_high_freq - longrun_low_freq) / 100);
>   	}
>   	policy->cpu = 0;
> @@ -71,7 +71,7 @@ static void longrun_get_policy(struct cpufreq_policy *policy)
>    */
>   static int longrun_set_policy(struct cpufreq_policy *policy)
>   {
> -	u32 msr_lo, msr_hi;
> +	struct msr msr;
>   	u32 pctg_lo, pctg_hi;
>   
>   	if (!policy)
> @@ -93,24 +93,24 @@ static int longrun_set_policy(struct cpufreq_policy *policy)
>   		pctg_lo = pctg_hi;
>   
>   	/* performance or economy mode */
> -	rdmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
> -	msr_lo &= 0xFFFFFFFE;
> +	rdmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
> +	msr.l &= 0xFFFFFFFE;
>   	switch (policy->policy) {
>   	case CPUFREQ_POLICY_PERFORMANCE:
> -		msr_lo |= 0x00000001;
> +		msr.l |= 0x00000001;
>   		break;
>   	case CPUFREQ_POLICY_POWERSAVE:
>   		break;
>   	}
> -	wrmsr(MSR_TMTA_LONGRUN_FLAGS, msr_lo, msr_hi);
> +	wrmsrq(MSR_TMTA_LONGRUN_FLAGS, msr.q);
>   
>   	/* lower and upper boundary */
> -	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
> -	msr_lo &= 0xFFFFFF80;
> -	msr_hi &= 0xFFFFFF80;
> -	msr_lo |= pctg_lo;
> -	msr_hi |= pctg_hi;
> -	wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
> +	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
> +	msr.l &= 0xFFFFFF80;
> +	msr.h &= 0xFFFFFF80;
> +	msr.l |= pctg_lo;
> +	msr.h |= pctg_hi;
> +	wrmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
>   
>   	return 0;
>   }
> @@ -160,7 +160,7 @@ static unsigned int longrun_get(unsigned int cpu)
>   static int longrun_determine_freqs(unsigned int *low_freq,
>   						      unsigned int *high_freq)
>   {
> -	u32 msr_lo, msr_hi;
> +	struct msr msr;
>   	u32 save_lo, save_hi;
>   	u32 eax, ebx, ecx, edx;
>   	u32 try_hi;
> @@ -178,15 +178,17 @@ static int longrun_determine_freqs(unsigned int *low_freq,
>   		 * For maximum frequency, read out level zero.
>   		 */
>   		/* minimum */
> -		rdmsr(MSR_TMTA_LRTI_READOUT, msr_lo, msr_hi);
> -		wrmsr(MSR_TMTA_LRTI_READOUT, msr_hi, msr_hi);
> -		rdmsr(MSR_TMTA_LRTI_VOLT_MHZ, msr_lo, msr_hi);
> -		*low_freq = msr_lo * 1000; /* to kHz */
> +		rdmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
> +		msr.l = msr.h;
> +		wrmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
> +		rdmsrq(MSR_TMTA_LRTI_VOLT_MHZ, msr.q);
> +		*low_freq = msr.l * 1000; /* to kHz */
>   
>   		/* maximum */
> -		wrmsr(MSR_TMTA_LRTI_READOUT, 0, msr_hi);
> -		rdmsr(MSR_TMTA_LRTI_VOLT_MHZ, msr_lo, msr_hi);
> -		*high_freq = msr_lo * 1000; /* to kHz */
> +		msr.l = 0;
> +		wrmsrq(MSR_TMTA_LRTI_READOUT, msr.q);
> +		rdmsrq(MSR_TMTA_LRTI_VOLT_MHZ, msr.q);
> +		*high_freq = msr.l * 1000; /* to kHz */
>   
>   		pr_debug("longrun table interface told %u - %u kHz\n",
>   				*low_freq, *high_freq);
> @@ -202,9 +204,9 @@ static int longrun_determine_freqs(unsigned int *low_freq,
>   	pr_debug("high frequency is %u kHz\n", *high_freq);
>   
>   	/* get current borders */
> -	rdmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
> -	save_lo = msr_lo & 0x0000007F;
> -	save_hi = msr_hi & 0x0000007F;
> +	rdmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
> +	save_lo = msr.l & 0x0000007F;
> +	save_hi = msr.h & 0x0000007F;
>   
>   	/* if current perf_pctg is larger than 90%, we need to decrease the
>   	 * upper limit to make the calculation more accurate.
> @@ -214,16 +216,18 @@ static int longrun_determine_freqs(unsigned int *low_freq,
>   	 * on some barrier values */
>   	for (try_hi = 80; try_hi > 0 && ecx > 90; try_hi -= 10) {
>   		/* set to 0 to try_hi perf_pctg */
> -		msr_lo &= 0xFFFFFF80;
> -		msr_hi &= 0xFFFFFF80;
> -		msr_hi |= try_hi;
> -		wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
> +		msr.l &= 0xFFFFFF80;
> +		msr.h &= 0xFFFFFF80;
> +		msr.h |= try_hi;
> +		wrmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
>   
>   		/* read out current core MHz and current perf_pctg */
>   		cpuid(0x80860007, &eax, &ebx, &ecx, &edx);
>   
>   		/* restore values */
> -		wrmsr(MSR_TMTA_LONGRUN_CTRL, save_lo, save_hi);
> +		msr.l = save_lo;
> +		msr.h = save_hi;
> +		wrmsrq(MSR_TMTA_LONGRUN_CTRL, msr.q);
>   	}

As sashiko.dev pointed, from the second iter, this patch code
will clear upper 25 bits to zero.

https://sashiko.dev/#/patchset/20260629060526.3638272-1-jgross%40suse.com

for (try_hi = 80; ...; ...) {
-   msr_lo &= 0xFFFFFF80;    /* iter 1: X.lo[31:7]; iter 2+: same */
-   msr_hi &= 0xFFFFFF80;
-   msr_hi |= try_hi;
-   wrmsr(reg, msr_lo, msr_hi);/* writes X.hi[31:7] | try_hi    */
+   msr.l &= 0xFFFFFF80;      /* iter 2+: locals=0 -> mask = 0  */
+   msr.h &= 0xFFFFFF80;
+   msr.h |= try_hi;
+   wrmsrq(reg, msr.q);   /* <-- iter 2+ writes 0 (vs X.hi[31:7])*/

     cpuid(...);

     /* restore */
-   wrmsr(reg, save_lo, save_hi);  /* locals untouched */
+   msr.l = save_lo;              /* poisons locals ->next iter bug  */
+   msr.h = save_hi;
+   wrmsrq(reg, msr.q);
}

I'm not sure whether the upper 25 bits are reserved, but the original
code preserved them across iterations. It might be safer to keep that
behavior unchanged.



>   	pr_debug("percentage is %u %%, freq is %u MHz\n", ecx, eax);
>   
> diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
> index 99d2244e03b0..2044e8a336ec 100644
> --- a/drivers/cpufreq/powernow-k6.c
> +++ b/drivers/cpufreq/powernow-k6.c
> @@ -83,15 +83,15 @@ static const struct {
>   static int powernow_k6_get_cpu_multiplier(void)
>   {
>   	unsigned long invalue = 0;
> -	u32 msrval;
> +	u64 msrval;
>   
>   	local_irq_disable();
>   
>   	msrval = POWERNOW_IOPORT + 0x1;
> -	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
> +	wrmsrq(MSR_K6_EPMR, msrval); /* enable the PowerNow port */
>   	invalue = inl(POWERNOW_IOPORT + 0x8);
>   	msrval = POWERNOW_IOPORT + 0x0;
> -	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
> +	wrmsrq(MSR_K6_EPMR, msrval); /* disable it again */
>   
>   	local_irq_enable();
>   
> @@ -101,8 +101,8 @@ static int powernow_k6_get_cpu_multiplier(void)
>   static void powernow_k6_set_cpu_multiplier(unsigned int best_i)
>   {
>   	unsigned long outvalue, invalue;
> -	unsigned long msrval;
>   	unsigned long cr0;
> +	u64 msrval;
>   
>   	/* we now need to transform best_i to the BVC format, see AMD#23446 */
>   
> @@ -118,13 +118,13 @@ static void powernow_k6_set_cpu_multiplier(unsigned int best_i)
>   	outvalue = (1<<12) | (1<<10) | (1<<9) | (index_to_register[best_i]<<5);
>   
>   	msrval = POWERNOW_IOPORT + 0x1;
> -	wrmsr(MSR_K6_EPMR, msrval, 0); /* enable the PowerNow port */
> +	wrmsrq(MSR_K6_EPMR, msrval); /* enable the PowerNow port */
>   	invalue = inl(POWERNOW_IOPORT + 0x8);
>   	invalue = invalue & 0x1f;
>   	outvalue = outvalue | invalue;
>   	outl(outvalue, (POWERNOW_IOPORT + 0x8));
>   	msrval = POWERNOW_IOPORT + 0x0;
> -	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
> +	wrmsrq(MSR_K6_EPMR, msrval); /* disable it again */
>   
>   	write_cr0(cr0);
>   	local_irq_enable();
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 2b791f1ec51b..fe1f499b4fc0 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -87,10 +87,10 @@ static u32 convert_fid_to_vco_fid(u32 fid)
>    */
>   static int pending_bit_stuck(void)
>   {
> -	u32 lo, hi __always_unused;
> +	u64 msr;
>   
> -	rdmsr(MSR_FIDVID_STATUS, lo, hi);
> -	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
> +	rdmsrq(MSR_FIDVID_STATUS, msr);
> +	return msr & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
>   }
>   
>   /*
> @@ -99,7 +99,7 @@ static int pending_bit_stuck(void)
>    */
>   static int query_current_values_with_pending_wait(struct powernow_k8_data *data)
>   {
> -	u32 lo, hi;
> +	struct msr msr;

msrval?

>   	u32 i = 0;
>   
>   	do {
> @@ -107,11 +107,11 @@ static int query_current_values_with_pending_wait(struct powernow_k8_data *data)
>   			pr_debug("detected change pending stuck\n");
>   			return 1;
>   		}
> -		rdmsr(MSR_FIDVID_STATUS, lo, hi);
> -	} while (lo & MSR_S_LO_CHANGE_PENDING);
> +		rdmsrq(MSR_FIDVID_STATUS, msr.q);
> +	} while (msr.l & MSR_S_LO_CHANGE_PENDING);
>   
> -	data->currvid = hi & MSR_S_HI_CURRENT_VID;
> -	data->currfid = lo & MSR_S_LO_CURRENT_FID;
> +	data->currvid = msr.h & MSR_S_HI_CURRENT_VID;
> +	data->currfid = msr.l & MSR_S_LO_CURRENT_FID;
>   
>   	return 0;
>   }
> @@ -131,22 +131,22 @@ static void count_off_vst(struct powernow_k8_data *data)
>   /* need to init the control msr to a safe value (for each cpu) */
>   static void fidvid_msr_init(void)
>   {
> -	u32 lo, hi;
> +	struct msr msr;
>   	u8 fid, vid;
>   
> -	rdmsr(MSR_FIDVID_STATUS, lo, hi);
> -	vid = hi & MSR_S_HI_CURRENT_VID;
> -	fid = lo & MSR_S_LO_CURRENT_FID;
> -	lo = fid | (vid << MSR_C_LO_VID_SHIFT);
> -	hi = MSR_C_HI_STP_GNT_BENIGN;
> -	pr_debug("cpu%d, init lo 0x%x, hi 0x%x\n", smp_processor_id(), lo, hi);
> -	wrmsr(MSR_FIDVID_CTL, lo, hi);
> +	rdmsrq(MSR_FIDVID_STATUS, msr.q);
> +	vid = msr.h & MSR_S_HI_CURRENT_VID;
> +	fid = msr.l & MSR_S_LO_CURRENT_FID;
> +	msr.l = fid | (vid << MSR_C_LO_VID_SHIFT);
> +	msr.h = MSR_C_HI_STP_GNT_BENIGN;
> +	pr_debug("cpu%d, init lo 0x%x, hi 0x%x\n", smp_processor_id(), msr.l, msr.h);
> +	wrmsrq(MSR_FIDVID_CTL, msr.q);
>   }
>   
>   /* write the new fid value along with the other control fields to the msr */
>   static int write_new_fid(struct powernow_k8_data *data, u32 fid)
>   {
> -	u32 lo;
> +	struct msr msr;
>   	u32 savevid = data->currvid;
>   	u32 i = 0;
>   
> @@ -155,15 +155,15 @@ static int write_new_fid(struct powernow_k8_data *data, u32 fid)
>   		return 1;
>   	}
>   
> -	lo = fid;
> -	lo |= (data->currvid << MSR_C_LO_VID_SHIFT);
> -	lo |= MSR_C_LO_INIT_FID_VID;
> +	msr.l = fid;
> +	msr.l |= (data->currvid << MSR_C_LO_VID_SHIFT);
> +	msr.l |= MSR_C_LO_INIT_FID_VID;
> +	msr.h = data->plllock * PLL_LOCK_CONVERSION;
>   
> -	pr_debug("writing fid 0x%x, lo 0x%x, hi 0x%x\n",
> -		fid, lo, data->plllock * PLL_LOCK_CONVERSION);
> +	pr_debug("writing fid 0x%x, lo 0x%x, hi 0x%x\n", fid, msr.l, msr.h);
>   
>   	do {
> -		wrmsr(MSR_FIDVID_CTL, lo, data->plllock * PLL_LOCK_CONVERSION);
> +		wrmsrq(MSR_FIDVID_CTL, msr.q);
>   		if (i++ > 100) {
>   			pr_err("Hardware error - pending bit very stuck - no further pstate changes possible\n");
>   			return 1;
> @@ -190,7 +190,7 @@ static int write_new_fid(struct powernow_k8_data *data, u32 fid)
>   /* Write a new vid to the hardware */
>   static int write_new_vid(struct powernow_k8_data *data, u32 vid)
>   {
> -	u32 lo;
> +	struct msr msr;
>   	u32 savefid = data->currfid;
>   	int i = 0;
>   
> @@ -199,15 +199,15 @@ static int write_new_vid(struct powernow_k8_data *data, u32 vid)
>   		return 1;
>   	}
>   
> -	lo = data->currfid;
> -	lo |= (vid << MSR_C_LO_VID_SHIFT);
> -	lo |= MSR_C_LO_INIT_FID_VID;
> +	msr.l = data->currfid;
> +	msr.l |= (vid << MSR_C_LO_VID_SHIFT);
> +	msr.l |= MSR_C_LO_INIT_FID_VID;
> +	msr.h = STOP_GRANT_5NS;
>   
> -	pr_debug("writing vid 0x%x, lo 0x%x, hi 0x%x\n",
> -		vid, lo, STOP_GRANT_5NS);
> +	pr_debug("writing vid 0x%x, lo 0x%x, hi 0x%x\n", vid, msr.l, msr.h);
>   
>   	do {
> -		wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
> +		wrmsrq(MSR_FIDVID_CTL, msr.q);
>   		if (i++ > 100) {
>   			pr_err("internal error - pending bit very stuck - no further pstate changes possible\n");
>   			return 1;
> @@ -281,9 +281,10 @@ static int transition_fid_vid(struct powernow_k8_data *data,
>   static int core_voltage_pre_transition(struct powernow_k8_data *data,
>   		u32 reqvid, u32 reqfid)
>   {
> +	struct msr msr;
>   	u32 rvosteps = data->rvo;
>   	u32 savefid = data->currfid;
> -	u32 maxvid, lo __always_unused, rvomult = 1;
> +	u32 maxvid, rvomult = 1;
>   
>   	pr_debug("ph1 (cpu%d): start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo 0x%x\n",
>   		smp_processor_id(),
> @@ -292,8 +293,8 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
>   	if ((savefid < LO_FID_TABLE_TOP) && (reqfid < LO_FID_TABLE_TOP))
>   		rvomult = 2;
>   	rvosteps *= rvomult;
> -	rdmsr(MSR_FIDVID_STATUS, lo, maxvid);
> -	maxvid = 0x1f & (maxvid >> 16);
> +	rdmsrq(MSR_FIDVID_STATUS, msr.q);
> +	maxvid = 0x1f & (msr.h >> 16);
>   	pr_debug("ph1 maxvid=0x%x\n", maxvid);
>   	if (reqvid < maxvid) /* lower numbers are higher voltages */
>   		reqvid = maxvid;
> diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
> index 9237ed8f2b1f..de50fb367c6b 100644
> --- a/drivers/cpufreq/speedstep-centrino.c
> +++ b/drivers/cpufreq/speedstep-centrino.c
> @@ -345,7 +345,7 @@ static unsigned int get_cur_freq(unsigned int cpu)
>   static int centrino_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct cpuinfo_x86 *cpu = &cpu_data(policy->cpu);
> -	unsigned l, h;
> +	u64 q;
>   	int i;
>   
>   	/* Only Intel makes Enhanced Speedstep-capable CPUs */
> @@ -378,16 +378,16 @@ static int centrino_cpu_init(struct cpufreq_policy *policy)
>   
>   	/* Check to see if Enhanced SpeedStep is enabled, and try to
>   	   enable it if not. */
> -	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> +	rdmsrq(MSR_IA32_MISC_ENABLE, q);
>   
> -	if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
> -		l |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
> -		pr_debug("trying to enable Enhanced SpeedStep (%x)\n", l);
> -		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
> +	if (!(q & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
> +		q |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
> +		pr_debug("trying to enable Enhanced SpeedStep (%x)\n", (u32)q);
> +		wrmsrq(MSR_IA32_MISC_ENABLE, q);
>   
>   		/* check to see if it stuck */
> -		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> -		if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
> +		rdmsrq(MSR_IA32_MISC_ENABLE, q);
> +		if (!(q & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
>   			pr_info("couldn't enable Enhanced SpeedStep\n");
>   			return -ENODEV;
>   		}
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> index 973716c1c29c..2afc3f177a29 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -69,13 +69,14 @@ static unsigned int pentium3_get_frequency(enum speedstep_processor processor)
>   		{   0, 0xff}
>   	};
>   
> +	struct msr msr;
>   	u32 msr_lo, msr_tmp;
>   	int i = 0, j = 0;
>   
>   	/* read MSR 0x2a - we only need the low 32 bits */
> -	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
> -	pr_debug("P3 - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr_lo, msr_tmp);
> -	msr_tmp = msr_lo;
> +	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
> +	pr_debug("P3 - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr.l, msr.h);
> +	msr_tmp = msr_lo = msr.l;
>   
>   	/* decode the FSB */
>   	msr_tmp &= 0x00c0000;
> @@ -108,19 +109,20 @@ static unsigned int pentium3_get_frequency(enum speedstep_processor processor)
>   
>   static unsigned int pentiumM_get_frequency(void)
>   {
> -	u32 msr_lo, msr_tmp;
> +	struct msr msr;
> +	u32 msr_tmp;
>   
> -	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
> -	pr_debug("PM - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr_lo, msr_tmp);
> +	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
> +	pr_debug("PM - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n", msr.l, msr.h);
>   
>   	/* see table B-2 of 24547212.pdf */
> -	if (msr_lo & 0x00040000) {
> +	if (msr.l & 0x00040000) {
>   		printk(KERN_DEBUG PFX "PM - invalid FSB: 0x%x 0x%x\n",
> -				msr_lo, msr_tmp);
> +				msr.l, msr.h);
>   		return 0;
>   	}
>   
> -	msr_tmp = (msr_lo >> 22) & 0x1f;
> +	msr_tmp = (msr.l >> 22) & 0x1f;
>   	pr_debug("bits 22-26 are 0x%x, speed is %u\n",
>   			msr_tmp, (msr_tmp * 100 * 1000));
>   
> @@ -129,13 +131,14 @@ static unsigned int pentiumM_get_frequency(void)
>   
>   static unsigned int pentium_core_get_frequency(void)
>   {
> +	struct msr msr;
>   	u32 fsb = 0;
> -	u32 msr_lo, msr_tmp;
> +	u32 msr_tmp;
>   	int ret;
>   
> -	rdmsr(MSR_FSB_FREQ, msr_lo, msr_tmp);
> +	rdmsrq(MSR_FSB_FREQ, msr.q);
>   	/* see table B-2 of 25366920.pdf */
> -	switch (msr_lo & 0x07) {
> +	switch (msr.l & 0x07) {
>   	case 5:
>   		fsb = 100000;
>   		break;
> @@ -158,11 +161,11 @@ static unsigned int pentium_core_get_frequency(void)
>   		pr_err("PCORE - MSR_FSB_FREQ undefined value\n");
>   	}
>   
> -	rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_tmp);
> +	rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
>   	pr_debug("PCORE - MSR_IA32_EBL_CR_POWERON: 0x%x 0x%x\n",
> -			msr_lo, msr_tmp);
> +			msr.l, msr.h);
>   
> -	msr_tmp = (msr_lo >> 22) & 0x1f;
> +	msr_tmp = (msr.l >> 22) & 0x1f;
>   	pr_debug("bits 22-26 are 0x%x, speed is %u\n",
>   			msr_tmp, (msr_tmp * fsb));
>   
> @@ -174,7 +177,8 @@ static unsigned int pentium_core_get_frequency(void)
>   static unsigned int pentium4_get_frequency(void)
>   {
>   	struct cpuinfo_x86 *c = &boot_cpu_data;
> -	u32 msr_lo, msr_hi, mult;
> +	struct msr msr;
> +	u32 mult;
>   	unsigned int fsb = 0;
>   	unsigned int ret;
>   	u8 fsb_code;
> @@ -187,16 +191,16 @@ static unsigned int pentium4_get_frequency(void)
>   	if (c->x86_model < 2)
>   		return cpu_khz;
>   
> -	rdmsr(0x2c, msr_lo, msr_hi);
> +	rdmsrq(0x2c, msr.q);
>   
> -	pr_debug("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr_lo, msr_hi);
> +	pr_debug("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr.l, msr.h);
>   
>   	/* decode the FSB: see IA-32 Intel (C) Architecture Software
>   	 * Developer's Manual, Volume 3: System Prgramming Guide,
>   	 * revision #12 in Table B-1: MSRs in the Pentium 4 and
>   	 * Intel Xeon Processors, on page B-4 and B-5.
>   	 */
> -	fsb_code = (msr_lo >> 16) & 0x7;
> +	fsb_code = (msr.l >> 16) & 0x7;
>   	switch (fsb_code) {
>   	case 0:
>   		fsb = 100 * 1000;
> @@ -214,7 +218,7 @@ static unsigned int pentium4_get_frequency(void)
>   				"Please send an e-mail to <linux@brodo.de>\n");
>   
>   	/* Multiplier. */
> -	mult = msr_lo >> 24;
> +	mult = msr.l >> 24;
>   
>   	pr_debug("P4 - FSB %u kHz; Multiplier %u; Speed %u kHz\n",
>   			fsb, mult, (fsb * mult));
> @@ -255,7 +259,8 @@ EXPORT_SYMBOL_GPL(speedstep_get_frequency);
>   enum speedstep_processor speedstep_detect_processor(void)
>   {
>   	struct cpuinfo_x86 *c = &cpu_data(0);
> -	u32 ebx, msr_lo, msr_hi;
> +	struct msr msr;
> +	u32 ebx;
>   
>   	pr_debug("x86: %x, model: %x\n", c->x86, c->x86_model);
>   
> @@ -343,11 +348,11 @@ enum speedstep_processor speedstep_detect_processor(void)
>   
>   		/* all mobile PIII Coppermines have FSB 100 MHz
>   		 * ==> sort out a few desktop PIIIs. */
> -		rdmsr(MSR_IA32_EBL_CR_POWERON, msr_lo, msr_hi);
> +		rdmsrq(MSR_IA32_EBL_CR_POWERON, msr.q);
>   		pr_debug("Coppermine: MSR_IA32_EBL_CR_POWERON is 0x%x, 0x%x\n",
> -				msr_lo, msr_hi);
> -		msr_lo &= 0x00c0000;
> -		if (msr_lo != 0x0080000)
> +				msr.l, msr.h);
> +		msr.l &= 0x00c0000;
> +		if (msr.l != 0x0080000)
>   			return 0;
>   
>   		/*
> @@ -356,11 +361,11 @@ enum speedstep_processor speedstep_detect_processor(void)
>   		 * it has SpeedStep technology if either
>   		 * bit 56 or 57 is set
>   		 */
> -		rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
> +		rdmsrq(MSR_IA32_PLATFORM_ID, msr.q);
>   		pr_debug("Coppermine: MSR_IA32_PLATFORM ID is 0x%x, 0x%x\n",
> -				msr_lo, msr_hi);
> -		if ((msr_hi & (1<<18)) &&
> -		    (relaxed_check ? 1 : (msr_hi & (3<<24)))) {
> +				msr.l, msr.h);
> +		if ((msr.h & (1<<18)) &&
> +		    (relaxed_check ? 1 : (msr.h & (3<<24)))) {
>   			if (c->x86_stepping == 0x01) {
>   				pr_debug("early PIII version\n");
>   				return SPEEDSTEP_CPU_PIII_C_EARLY;


-- 
Thx and BRs,
Zhongqiu Han
