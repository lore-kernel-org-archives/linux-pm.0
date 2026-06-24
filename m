Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6933F8C5
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300363; cv=none; b=FAPsJ59/jcPq9Lg5c4iNaT5pmJbd8899sOdwkxdTET/PLHdnIO7W9NKx508zTnUkwZtcDIyDUB9cIvlTUts4LX2rxMZI2OSb43w40c4J0RSyerLSpUJEyxKle8CsSBnnhLpNb1cS8Cx2jFPfRN0ipQuQxcyI79YVNFpWH67Y8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300363; c=relaxed/simple;
	bh=QyRMrgiQxK+4SZ4C7IkqGeqvE/p929yInSvh801TBuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INGKn1cjP2+xfCnR425KtMGUERoACURzX/i+5nAC5a+KqqWTcpPHYyaB2896I4clstmrFEXrDA0Ap0r7r+7E1q5FSkjvBc94XEFpEd++BeFC+z/BdosCmGaiPAhE7+WfyXE2fI1KUVJ93L+xWEToliux46zNHlLtoiktpLeu4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K5Yjp8/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTH36Tfd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5Yjp8/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTH36Tfd"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OANdkx2502051
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yw8koDn99ZeNzw5vCl5OzTNmlRbyRxNk1xWkFyFXfr8=; b=K5Yjp8/L3kZ8wWMR
	BYaQdj3VqiNDeCZvVFI081ydLbeUVqRIZi/s5d/N8+nw5s90qFDS630JBaMqvyI8
	YOL/5hcccIWOhqu1r5MvyNc6Gk56tZUDq9GoHG1rtwfW+194hcfci1WVGbK5tfbY
	agtiOOAGPmdT72NFDzed6LjN8M+17vANGpNLvvZYQ4agpAlKn4bdnBOKetjjQZAk
	w3cvDos3RdsCHJOH5qgzM9y1ugt8hwtYkU121yh1Pu4q0jbgvVWJ8JNO3MjGd2J4
	OIoMsRDhUCTbC0Wr1NTr+pwoo4RKBg/GQQmMXlbMXLrGhM+VD8A4kJpUarj34SeU
	bwe1yw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d450c3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 11:25:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8453e61d6f0so940287b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782300359; x=1782905159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw8koDn99ZeNzw5vCl5OzTNmlRbyRxNk1xWkFyFXfr8=;
        b=eTH36TfdOfWiRM1+5VftBkMxaMsrvndqymKRKWI1Oq0glm9uP7glN1xHozTjM2ndXX
         iretqx2TC2INB9a/21DvOHetY4W6RM8mn220fxJvqscx9VwKnUV9maqygCF0UNkSpp/e
         nMxnTZVoVlqBq6cocqcJPWJf0feU7MUfRbpM3yBcDapBjwnXnuiymsZTigqHeeixFjgn
         DGRudRw2MOvF0+qRV6dqyEwOWkO8q+GC+oiaNvnrMSMR+1ktyOkkTk1NawcmxjZjPQay
         KP9usrj5gOm/xf45rpVsCpPe4pBZUlvUv6JNuMiJaxbB4v+JZGIQSpmjMWF8sr7AfXvE
         rObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782300359; x=1782905159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw8koDn99ZeNzw5vCl5OzTNmlRbyRxNk1xWkFyFXfr8=;
        b=qr1OjrtSqAJszBKfnVgQBVdvI4PkJ/ELSqOf+Uof5W0OL+lV8EGzak6JHXAkSmjDxd
         KjL060FfCVs8DxW4YYFTBGFWwR+DA0vI6SgSvGlut5fpwmY7sMDAP5AJR/K6hojOGR7W
         +FI4iqtnO3Qq841n+iKnA+Xzu5DpUe5aewjIdV9RLEAqc6JvDlI7D9O1BTOnIjBmA/8I
         Nv7ri5GBIo7Hodp+N04rZMlwRIcBgH82/pnrZxbsC6f9QE0zV4EVdnXoQBDNmjuI3Uxv
         +0DmO6iOGSnFKuW6Exx5i4pRTEE1w6BqJC4RXS4xCmQgWbQn+w3NYysjN8QkO6PUw6Yj
         KHrg==
X-Forwarded-Encrypted: i=1; AFNElJ/Uxkb+IOZujRlBV3rVBM999ovX/1Ryj/+2eXVmSZyVKj93UqTao9k1zVG9UFdE03i5MKbpaNWPBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ukrpYWvxfDwg5RVyhKqbRpO2Q3eFZTHWnYaT7Z6NI5PNuFS1
	JH7n5yZbZv5aIszfgxp8TnFqP59Yj5ZzJ2yZgVkGRiN5CmiJeyfciEMWquR+VZpIugGK/5HR36U
	hLrpn4i3Ak+u6Bcez0WDp9sTkLGzsA1Nr0/0fwsClhJrLYU1Za9toYwGLUvPWSQ==
X-Gm-Gg: AfdE7clN1lCnsArIPQXTz86i2vUpVBs0RFUz/ydbDq8RPLRHfel0aknj7c3f1TtIQ/I
	tu7qBmQ+V9KDxbCM/MOjn2tiGqEcx3oWmd4GiVooC0UKI8xZk8E7icz00nnz5ZKViCR+Nn3hCx2
	ZGAeNaypFmPVkamLdSMImx3xEBsWWEDbYId/JyAdtVH47XPGQ/F3XtnAGTHtgcaQl2ev/nS3Bz6
	HFeUSwbe2BhbTJFWWO9wOU8gwWu55ys8QSkanBLOgEJ8TJoL9TXadN9kOw6BvZJq0CJCWpDnT7e
	4raQ4SRTb0RtU5O2y6lRuKWW73sVo4dWRQDgV3/ybRVoHvI9qnRif8/xeXxXHij/0+KE1fzrwiS
	/MFkkHYtpJ2mPCDfCWxhkwb23603cSBOdKxPo7XuZ0C+dkm+Zo3Jm5GsQ4/tudaPfOz9wXlUgdD
	YMnwzGv1g=
X-Received: by 2002:a05:6a00:2e96:b0:843:468d:7804 with SMTP id d2e1a72fcca58-8456255cc6fmr21221622b3a.34.1782300358959;
        Wed, 24 Jun 2026 04:25:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e96:b0:843:468d:7804 with SMTP id d2e1a72fcca58-8456255cc6fmr21221592b3a.34.1782300358493;
        Wed, 24 Jun 2026 04:25:58 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4122616sm1972257b3a.52.2026.06.24.04.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 04:25:58 -0700 (PDT)
Message-ID: <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:25:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in
 cpufreq_boost_down_prep()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jim Mattson <jmattson@google.com>
Cc: bp@alien8.de, tglx@kernel.org, x86@kernel.org, viresh.kumar@linaro.org,
        yosry@kernel.org, andrew.cooper3@citrix.com, ludloff@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, zhongqiu.han@oss.qualcomm.com
References: <20260618224527.1506419-1-jmattson@google.com>
 <20260618224527.1506419-4-jmattson@google.com>
 <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NSBTYWx0ZWRfX+wKI5HEnS+0S
 TuB+tPMDISj9lzONfjfTQlbcZky1rZyB4rW4/S/uJFY2HgbJxO/Nz/w7kPEUh+fSPuatm6KNEPO
 9ShwXOSYvseoXKjK8m0tJUwkuj7j12Y=
X-Proofpoint-GUID: l3TGIROry0VTT_Y83xyjeLPElqaARikP
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=6a3bbec7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=eh6w_bVcWWKbaMIl5p0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: l3TGIROry0VTT_Y83xyjeLPElqaARikP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NSBTYWx0ZWRfX85hDLHM2gFkb
 4zrmJ47tE/3prP6u+vwvoS6YUdBz2IeU3xG32FQnntA8CfeQRqb2qx8XngV22DfsF9FYs094ORf
 VNWKH6Wth+7d1IYnZf3rYdWVHF/yfzgZjexhytYzQCMo0ugR+S0yqavLHy6BrhxlqV51jaDKVrY
 sovXgWXrPfQ8uVukxSHlkOeyBDjvIt17v1drHA2TJsTfSqfZ02x0ojVqoI5toNRhmuiqbFZvR20
 UZvSOiKTjLyUqgCLieP0AU96usPyz8ZljAGyE6immFvCDWB5JfsJ8oCpFLX1wXta88TDjsW4PVz
 1biz1rJ12gZhkCRsqz3T2l5GrlhjbKlTXrvWV3awgPGRQgkbk5brPozSBYhZwypFtZS08n6cjwN
 ewNasdNtMhz1dkcUxZLtLLIYMkZnKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240095

On 6/23/2026 8:47 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 19, 2026 at 12:45 AM Jim Mattson <jmattson@google.com> wrote:
>>
>> During driver exit or CPU hotplug, acpi_cpufreq_cpu_exit() calls
>> cpufreq_boost_down_prep() to re-enable boost on the target CPU.  However,
>> cpufreq_boost_down_prep() ignores the target CPU parameter and calls
>> boost_set_msr(1) locally. Since this runs in an unbound process context, it
>> updates the local CPU's MSR while leaving the target CPU's boost state
>> unchanged.
>>
>> On Intel platforms, the open-coded read-modify-write of
>> MSR_IA32_MISC_ENABLE in boost_set_msr() is vulnerable to preemption and
>> thread migration if executed in process context.
>>
>> Fix both issues by routing the MSR update through
>> smp_call_function_single() to execute boost_set_msr() synchronously on the
>> target CPU. This ensures the correct CPU is updated and that the RMW
>> sequence on Intel executes safely in IPI context with interrupts disabled.
>>
>> Fixes: a3605c46e0c0 ("cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usage")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmattson%40google.com
>> Assisted-by: Gemini:gemini-3.5-pro
>> Signed-off-by: Jim Mattson <jmattson@google.com>
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 21639d9ac753..48d678812fd6 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -528,10 +528,11 @@ static void free_acpi_perf_data(void)
>>   static int cpufreq_boost_down_prep(unsigned int cpu)
>>   {
>>          /*
>> -        * Clear the boost-disable bit on the CPU_DOWN path so that
>> -        * this cpu cannot block the remaining ones from boosting.
>> +        * Clear the boost-disable bit on the target CPU so that
>> +        * it cannot block the remaining ones from boosting.
>>           */
>> -       return boost_set_msr(1);
>> +       return smp_call_function_single(cpu, boost_set_msr_each,
>> +                                       (void *)1L, 1);
> 
> While I have not investigated the history of this code, I'm wondering
> why cpufreq_boost_down_prep()  is a separate function and why it takes
> the CPU number argument.
> 
> The only caller of it is acpi_cpufreq_cpu_exit() which could just do
> 
> set_boost(policy, 1);
> 
> instead of calling it (and might check if boost was supported at all
> for that matter).


1) It seems that set_boost(policy, 1) would be a no-op here, since
policy->cpus appears to be empty by the time ->exit() is called.

acpi-cpufreq only implements ->exit (no ->offline), and ->exit() is
reached only when policy_is_inactive() (i.e. cpumask_empty
(policy->cpus)) is true. set_boost() does on_each_cpu_mask(policy->cpus,
...), which on an empty mask runs nothing.


2) The patch's restore on only policy->cpu
(smp_call_function_single(policy->cpu, ...) will not fully cover shared
policies, and how much it covers seems to depend on the boost-disable
bit's scope (but that seems to be already discussed in the cover letter
and is probably a separate topic).

Please feel free to correct me if I'm misunderstanding the scope of the
boost-disable bit:

On driver unload the policy CPUs are removed from policy->cpus but seem
to stay hardware-online, so a stale disable bit on a non-last CPU might
still matter (those CPUs are presumably still running and may want to
boost). Abstractly:

- if the bit is per-CPU independent: clearing policy->cpu seems to fix
only that CPU, and the other still-online CPUs in the policy may stay
disabled.

- if the bit is shared within a group (e.g. core/package), "disabled if
any member set": clearing policy->cpu maybe only covers its own group,
and other groups spanned by the policy could stay disabled.



> 
>>   }
>>
>>   /*
>> --
> 


-- 
Thx and BRs,
Zhongqiu Han
