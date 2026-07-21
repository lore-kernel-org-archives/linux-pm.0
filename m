Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3642B338
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617213; cv=none; b=FfNEFNIg+StxyiCpQkuz2gdiM3KLcFInJ9SheIjlQq/aoaSaaFPEeOe36PLLRBvNcHvrtIfUdZ/pLD32TG0WSBS1hlNRf1QjBCZX3wVKVjoJPO9x14RHJg2/MH09ziHPSSm0z4sM9ciwi5ny6INOaQFfEQ4ENdiDH3xIkSTUC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617213; c=relaxed/simple;
	bh=EQgFfhQI1n9OXhIjmGDq9tQ9oSF35xcMPt7UZryq8iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZP53aoALivsKGb8b7wy4ow1HCbUzo4lPNhBPpgoTDjlctLCmvIGJ/mLJcXuHzHsyE6qJ3NR32P3hnoLWEbvoxjU8slrm6V3MVQsByBE0+FWb6Fy2lqhgZ30ajG8LHvin7JwMirapWFbWVqouxbeFM6gzGOlCHWjjlOpKXQ9ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFLky9X3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeSjjVX3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFLky9X3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeSjjVX3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L3xobw568594
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1daOcfcPekbXPTo1ZKu5apWsbmT+eRXZYZR1KNyfufs=; b=KFLky9X30NQClw9T
	JPAWRsdbrK6VOQyXuR21u7NgiOH8n0FF8dCbSdKTWupGJEZnZ7CLVxSLCdxsGCOj
	V03pvP1ZeFOGNITQ7WXxSbFvhAQ5O/Tx7O5V/wGUVLaBgfDYaY1kowntYuygYO9L
	u7sm39nHMe/LZOvcO9ob5EJnHJ73xAuJAIdjPFXdf6GyVM9ssgfA3k2ouMOnoFbm
	mn06qgcnzRaZbTl/hLiKa+kS2HkvkrroVV0w75zKbJloM1SUTXaRmPTmPA552Stn
	PJC6GWlA8k/ZzOtgtdSWts3gPbie7E5aT2mddShTCi4cW4gxK5SOYWpeKRsbEoSH
	YX+QEg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvrmku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:00:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so7360061a91.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784617201; x=1785222001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1daOcfcPekbXPTo1ZKu5apWsbmT+eRXZYZR1KNyfufs=;
        b=DeSjjVX3EwkpGtlbPYVtP3OL1wDgI9J0AGMYSbEHpCX+f+60s4QA2bgWJ3yKzOc/7a
         YUsVcOgOibE1+vGedMy2tkiHVa3qluQSK5JCrkWFKBAU3iGL/fGvubnIFOHFZNtnpIYy
         HtY5WG98L3em/revaQGypobX3k/KHYJTRvZdtZ7HHjNUnWParFU+JXNSIhlypGK5CiJc
         kHGefpilJByEigi66Jrq/IurlmAdHzIjJmGokPlVInqR3O4tPf/0j6VknP/B+HNS2NXo
         B8Il6jgWcZ/8iNHo9aeha3L/39GeDU0pTwsLX4Sv4vv2Zy3L0DoQWUc9Hokh82jf5Ckf
         B5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617201; x=1785222001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1daOcfcPekbXPTo1ZKu5apWsbmT+eRXZYZR1KNyfufs=;
        b=OBzpoLJI3p0+zgFfGE/UD+uHWMW6GkUbiNMwVIEJe4Yv00PdtzFgPH06FkbXAtuEKZ
         aStTEzEZnmI5QHgVTm/Kvvdbk2kvXSKfcDCwsVLhc6lNvS+0PLj8vf/tZqGxNkLeLLfU
         eXNbsivGyz62xUgAJXwd3bu59lGyXusCEJnOBEo/Z51hp6NA/wYhtWCwsuBwKNe0xfvi
         JnyDERWsrbzVcgiV3MQ+pYpaVmRRu02gjXXhlcMgJ93Tr1NdnCCzI5G7EJ18KECM6yMK
         mLO88YlADTLdSIK86ucXrJg7whCoyIJqF6q2nY0aTvcLDEk3+von7UBq68rBFq7Gz9y6
         DIfQ==
X-Forwarded-Encrypted: i=1; AHgh+RroW5gcd+CJ0waW9A+o7mHWa93wuz5lNAd/2EEytLnt8/LQhbtObrflWrwJuDqNIGtmIthPMZ0fBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4/kTBfbIcrOAMCMf9lW6syKrb3wGfm0K3il1OaqfqZ7rlniB
	xNI7IEMaj/oPmYdhey3oZoNZQAhyNnKG7Gq2WqOfY3ih6U1KZWeD0YZb9w2UaIBZ1oyIdkQ5fTv
	sL+OyX6nPgJad4baiJA+1CE6o6Xw97xtjxVXIDsU5PGRVrXuJewzPhz2gdklTMA==
X-Gm-Gg: AfdE7ckmrhirU6Z4BfNed7vP5Vsp0fiUiKwqQs1NFQDH15oCJlxQLhdZJRWeg51gPQ9
	22rED6sFk/thj5QNfA8xN7qO55N5q1z4RqDwHEEnVz3q5VqfI/D9kcvj9FpYrRemEJFLPlpWPut
	vVU/65hJOth2p+F1M+j/diNufXeakf9kyIOcc3RAwshXK+N2kE+LeEUmGepv09ErHjJZXla9LuP
	381Y9UyeNTwRUurp7SuS0maOJiUPzV4MGyPL/QPR3T5w0J74fHyG/QEL51KuP2hTS5F1YTAzmbC
	XZ21g6SedSQ1LXcl0KtxIytrjkJXkj/5rV8Rm+EkO3Gtr8an3K/uLCdXBijFG2Rv18NWWrZJb6r
	E68xN/YKzLNU2gpi8RVTw5GPsHJfk
X-Received: by 2002:a05:6a20:9145:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c3ad64da60mr18812485637.24.1784617201193;
        Tue, 21 Jul 2026 00:00:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:9145:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c3ad64da60mr18812449637.24.1784617200719;
        Tue, 21 Jul 2026 00:00:00 -0700 (PDT)
Received: from [10.218.15.172] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429ff04absm40704841eec.8.2026.07.20.23.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 00:00:00 -0700 (PDT)
Message-ID: <f2d4b312-4a11-425e-8329-33838ed37d15@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:29:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <akfHIH_dZrr5bosu@J2N7QTR9R3>
Content-Language: en-US
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
In-Reply-To: <akfHIH_dZrr5bosu@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oD5rcA6BqJpiYF-zxh52zZuMRICU1wx1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MSBTYWx0ZWRfXzZaxHJ61j/n5
 5l7XHX9F5vT5tZchZbu9Jdrx8u5KNJ8N80aI70zcL0LK4+pE3ZDX0RCzMVIEB8M0SrgSOx8X4ih
 cUW72/SVkgkFXI/ie5JzMnXipP9+9f0=
X-Proofpoint-GUID: oD5rcA6BqJpiYF-zxh52zZuMRICU1wx1
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f18f2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RLVnq9SYGZ7K_u37rsQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MSBTYWx0ZWRfXzkK7SLOU/WDT
 wyRYZj5qccjsjmrCasGPMbWU8a46JLTQcqY+16jwoodsalESCNMnKspiV/jxIN++hpbTosvTItJ
 Ehr/ZkGj6YzB1iWdAHMO6UeGU/LSwkyVckNL50O3wambor9KrA4fCYOmvXdjNRQspugS7F5ThBv
 c7ZQsMXzu5B+xk1y/dmjOjGTF9E0xUTGwu15XCnkId76ILUWpxV30EeaeNebsgrl+re3faA06EH
 0YbBLKy/XK2WD7QM98ZYTknst7vIzuRVyJ0aHt0eaglLhOLBcvMFiiLtdlnRDeBdyvnKD9Ct6m2
 NEtqeCCL3E05SnD0wIAveSCxir3ouAF6GQCIRBQl1PfyfPpS2yzUd1DBHyrGmDZ0YudJ1t8f6qq
 OTQaCpUxc4WSEbidyGhGQNiR7PZ1pnySUYUzEOi6AUcbmHe8WAJBP2S1dlJG9xiBRSI34Sg1gpy
 0AySayv3Q6kZBlEbQFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210071



On 03-Jul-26 7:58 PM, Mark Rutland wrote:
> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
>> The Qualcomm SoCs like LeMans, Monaco 
> 
> Are those released products?

Yes, the SoCs are present in upstream:

arch/arm64/boot/dts/qcom/lemans.dtsi
arch/arm64/boot/dts/qcom/monaco.dtsi

> 
> Are those mobile phone parts, or somthing else?

These are ride (automotive) chipsets and IoT boards.

> 
>> support suspend to ram which leads the SoC to ACPI S3 similar state
>> where SoC is turned off and DDR is retained. The hardware design on
>> these SoCs forces a constraint to suspend and resume the system on
>> boot CPU / CPU0.
>>
>> If CPU0 is already offline before starting suspend to ram the
>> freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
>> proceed further to invoke PSCI SYSTEM_SUSPEND.
>> This leads to a system crash.
> 
> Ok, so that's a firmware bug.
> 
> Why does the FW permit CPU0 to be offlined in the first place if it
> can't handle this?

FW permits CPU0 disablement because it functions properly in regular run time.
But there is an additional hardware constraint in above mentioned platforms, that
suspend to ram has to be performed via boot CPU / CPU0. Due to this constraint,
CPU0 is required to be online when suspend to ram is triggered.

> What does PSCI_MIGRATE_INFO_TYPE report?

It is a optional function call, which is not implemented in firmware.

> Ideally it'd report Uniprocessor (UP) not migrate capable (1), which
> would prevent CPU_OFF on that CPU, and would force suspend to happen
> there...

Also, above platforms are multicore (8 CPUs each).

>> In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
>> config and when enabled prohibit the CPU0 from getting disabled.
> 
> I don't think it makes sense for this to be a config option.
> 
> This is a platform-specific property, and it's possible to build a
> kernel that boots on this platform and/or other platforms.

Yes, but for that reason the config will only be enabled for SoCs that have this
constraint, it will remain disabled for other SoCs.

>> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Moved the check to arm64 specific code.
>> - Link to v1: https://lore.kernel.org/r/20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com
>> ---
>>  arch/arm64/Kconfig       | 9 +++++++++
>>  arch/arm64/kernel/psci.c | 6 ++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index fe60738e5943ba279e5571862423df4fed3db661..21697a535a25d286a2f8afe4921a41b13cc32c0a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -263,6 +263,15 @@ config ARM64
>>  	help
>>  	  ARM 64-bit (AArch64) Linux support.
>>  
>> +config PM_SLEEP_SMP_CPU_ZERO_STRICT
>> +       bool "Disallow boot CPU (CPU0) offline"
>> +       depends on ARCH_QCOM
> 
> Why can't others select this?

I can remove ARCH_QCOM dependency if any other want to use this.

> 
>> +       depends on HOTPLUG_CPU
>> +       depends on SUSPEND
>> +       help
>> +         Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
>> +         has to be executed by boot CPU.
> 
> As above, I don't think this makse sense as a config option.
> 
> Either we handle the FW bug, or we do not.
> 
> Mark.
> 

As mentioned above, its not a FW bug. CPU0 is allowed to be disabled from FW and HW constraint is for
suspend to ram to be performed on boot CPU.

Thanks,
Sneh

