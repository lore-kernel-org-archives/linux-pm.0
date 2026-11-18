Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973655;
	b=XvlA4LPV8o8MywOt52LMwEKvjDHvxGTmDVzoO+YYki52w9nYOV76czW7yTZiyijiY7K/
	 6olvTU3lkfxPuXrlxLJz/UXnQAMCDstKGEtokYZvsmhADR+0FwxT33OLbDBBjzwelPT8p
	 G4bDMDcY9+4y0t0VrHJZKSY3ZJ66LrUseJrXjSXdpYEVEjNStDREki85TqlAQU4SJAL8L
	 5D+drKDBw29IUq4jaFPEZOSSWkpbihqBojPE+r9lQBqNe2eCEgfuqKW7RWBMi7O565bCp
	 PlpYZKhonL8GWd7eCULoHSkY3ZWqtJfgpZvNT33hr4fg4ktCkgG0oAqc5ghhAooSIug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AYtjnP2yQm0onoxAY31O2Z/NVjo75NmF1Hpq5N3hnXw=;
	b=cLD9Cditc/lAttFoXW4jXzhpUPkC5u5SCLEU7TEiVOtzykd0jEUGwVGwFw8jBe8YnNph
	 rmaI0WY5Dfjh826YxMPrfAL/xdH+AQeWcTPkmjxRQ5t7qHvFXAlfE5PXrdTd7FV1n5tr+
	 PJi/xBsE+IfhP9uarqsTIaZK5DogE4pZHVB9cmkJM6ReUs9SIO9GzVeamy1wGc2mE50yu
	 6mGWAVyX1HDCJMinw4G5xW5+nq1Qn9MmNuGuKoinW67jBKXRns5+S7pyK4giDdMNUHAjm
	 VAXs9j9uJC6xmJhuYUwwQON8q0yqpaCix40InIFClSKvsOocXk0wZ6aAMlZIbhmzpJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URdO5GDu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NuGOEOMn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0D606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB0D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URdO5GDu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NuGOEOMn
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2ejYa2010509
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AYtjnP2yQm0onoxAY31O2Z/NVjo75NmF1Hpq5N3hnXw=; b=URdO5GDumrbt7yQi
	t45ph71r36BGnxp4xR6UAasTVy+UyOXBD2UD+McP94p1qiI2LXt7+njAIdrVvR/r
	DWGGlXx4eMfHepT/zs/FXi1HQ9y8m2DGmIBZnKQVdWesbwvKIybwUrfO5NeJ/w/J
	47RwzofSmx/Qz0cxhFOzP/2kIEviNsxu4C6x7CadeUanaQZzdKkK2Fl8n7OJl6aD
	T5sqkCYbC/QhnJBb3pHute4G8Yh7F2/Xr53abuIXLQetzpCyJZyLsQuur9AW/KN/
	qkGrzHqmPMwzQC3vA+KevsSWJGvE1DEplBiDf6nzziTswmeOaODFjJBppY0al+L7
	BXSiQQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8h261-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:47:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so643545a91.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 19:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794973653; x=1795578453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYtjnP2yQm0onoxAY31O2Z/NVjo75NmF1Hpq5N3hnXw=;
        b=NuGOEOMnTZcVlrXyoF2+B4DqmvSA+y3upE8mnAhcwNFO8pcrb+HfNj+yNJstPIU53Y
         UOoH11REDeIismjafSNl0JLM33SFhT/ixSZ0yN70XZdFXTKl5i7ixtBgGwz67iAQodsK
         FaNqGDgOaFRMZ0qKNOPybEGEcICSXlFa2dfPmeFHXC6/gaaGwTUsuhc7SOn0mhFVxowE
         SU8njdvNbBQxYW5xmYmAedKWZwACGzTI21QX49nHoZCDRrwQyR8LLq4wph6AdPG8osma
         NuH5qkkN7ikezFclLT3mPfLqx2CJx012CBLcSHnq2riiYUV0v+aQ6W2MSIFsi1SjYW5S
         wMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794973653; x=1795578453;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYtjnP2yQm0onoxAY31O2Z/NVjo75NmF1Hpq5N3hnXw=;
        b=NNjCz8mWoh4E2WSxNI74in8Pt6YLTobTbRmo6XMp3O6r63MH/uqg/WzBlzINYQLnia
         UMFj/Qb3NBItJF69TPa46iDCRP1YQ5+5e9acVOhilqVLaXzY/HV5/IrSEKss1QzPWmvN
         B9S7eYhPA0am7aJazIXbay9JaBBPoBcSXqSXS4deMRV3nd4dAgqpo3IuZ9LVw6g923Td
         PclFcVxmvv3HrALytxdwqb4YZSXq6qkjJuncGGRLNncBMkJLZrlGNu+f9gBk756zQ/yi
         DyCadKH0FKj9jDOyD1gJVXrP/EkDaihCMaBBZACG6umOlu10S3IQvkcaB0MZepgViKk1
         28LA==
X-Forwarded-Encrypted: i=1; AL+hErECzQlDFb75PWbgXPu5UDAxqiCCwEjkq9p/SC4kLWtlu22PNRxWJr9iSYCYNWQfsFyXskc2DzTtfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9HA+Co8AkpXwJruIJ+UgDBJCqvjKgSyQ0BbQmGMKiuU/UqNGVV
	9C+RU8BYEj7WPScdtLKNTCUVct7NsgvuaOA38O0RJ5QTIRPwql9wETLm+o49Si2lQR5nGWUCptu
	W17C2yG4tGiMhdo/ylpKlXu277aqrjqLbZQ0sp19DLzIrNJUjvGAcr4C0kt/FoQ==
X-Gm-Gg: AZFdTZe67SFwaLoZ6SLHfBbR1z1RO8FJNZz+miNG3E/88OrrK3d/LTHv+VMqrDZ671T
	eyq9Huktcr9JWrka1MEyIN+luZu2XRz51gbw/U/PGHAwmIGTK4vma051buSXU2s+jitP+7UijVf
	1V09wBYZX3BKYNTfdnWf2wjlT6hYaMKyuWb5xhenwsL8wPszMhCvNa9fe3J9aUzAOIUgkCx9AKJ
	Vj+DDQ2Chxsjkpqq+Nw/6h9OSq9BDFrtX0pVeBsL12qAfnHTtGzF5vCUgcIT0pkLjETMsMEfoFD
	M3yCO/skZ7xt+X1/uCpH4L1lXINOXJ3T7qFP6WKIM7mdVgBoj6yfxSNOh+Pv9Geljq83ne125v3
	nRG6ebRQu2M09jrC2O23jDKFl0dHDKdl/i4WVDy9P47drc9I7bzxy0zxiLJnWNvLyEzaI3MFhJw
	uescsTIKAaZHC5rDLnakTXYHKMw31yzKedkyqSc7V/t8I=
X-Received: by 2002:a17:90b:2684:b0:3b3:b71e:b2ef with SMTP id 98e67ed59e1d1-3b3d07c83f9mr1488931a91.50.1794973652573;
        Tue, 17 Nov 2026 19:47:32 -0800 (PST)
X-Received: by 2002:a17:90b:2684:b0:3b3:b71e:b2ef with SMTP id 98e67ed59e1d1-3b3d07c83f9mr1488907a91.50.1794973652066;
        Tue, 17 Nov 2026 19:47:32 -0800 (PST)
Received: from [10.133.33.86] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d187dc82sm2003736a91.6.2026.11.17.19.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 19:47:31 -0800 (PST)
Message-ID: <6452ab41-2d7c-4995-9f6f-1e8207767cdb@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 11:47:27 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] cpufreq: tegra194: Add support for Tegra264
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261117154954.625126-1-sumitg@nvidia.com>
 <20261117154954.625126-9-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261117154954.625126-9-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x0k6NmYIipg6WtEUec1K0HN9DTGA1Dm5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNCBTYWx0ZWRfXxi3uzI0PRcJS
 n6FUpU5briBRPvk07A6NUaRk4SEKf9OkKiI04njMBR5g29B6yUBQOM5N0U+5GBR2n1Wkkhzecn9
 Jac/Okd0K213SUOX5nZo7bAV0A0NmLM=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afd1fd5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=jyGxVx0bnOFcdHMOUhQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNCBTYWx0ZWRfX9ylTLNkbkU5X
 ocEDpcrHCmLsMhCgYW+tIvDe0l5wbLymTCQZN1WI7vhCbopMWKBbk22T9/RwKM19MqLEFKh2DPt
 Em2q3jziiQHTofmXZFGgOwCc9/V9+vjM5vPDnWzLKbvvsc0t23SbcuEb9KxEHeQQVAlryg/nFhZ
 Ok34t2gMzmFsyMK5fUphi2JxiNAvpREATtHbgGVM5DIWCITbyo6hdgXthIqDv72LPvQsmiVC0U+
 KTZMUC5LJ8Kj9IZUD305r5alExoUc6ogfoZeBr4adEay7RVW6cc0SgdQN2/EvJBjPlOfCwPxHZe
 98H1usMz3a7WUqmm6obZU8Z82VWx+dd5KTAu9ppLwrdo4bSkPQkaUyI0JXNyxpHTekonJRqPmf5
 ooDkyWm9z5cDf5T1Be3/fcKvsV09H08L/NokeAGGMj5gAK9eHZJRuzwD0QgkhlufAAHC2HwCcmm
 jOE9j9Udw4mFB2HqLaA==
X-Proofpoint-ORIG-GUID: x0k6NmYIipg6WtEUec1K0HN9DTGA1Dm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180014

On 11/17/2026 11:49 PM, Sumit Gupta wrote:
> Add cpufreq support for Tegra264. It requests and reads the CPU
> frequency differently from earlier SoCs.
> 
> To request a frequency, the driver writes NDIV to a core_freq_req
> register in the CCPLEX register space. Two clusters share a clock and
> its register, so they always run at the same frequency. The driver
> exposes each pair as one performance domain and one cpufreq policy.
> Each CPU's "performance-domains" property gives the domain index, which
> selects the register. If the CCPLEX node declares
> "#performance-domain-cells", probe fails if any CPU lacks the property.
> 
> To read the frequency, the driver samples the per-CPU 64-bit AMU
> counters through system registers. The AMU constant counter is the
> reference. It ticks at the system counter rate, so the driver takes the
> reference rate from CNTFRQ instead of the fixed 408 MHz clock. Probe
> fails if CONFIG_ARM64_AMU_EXTN is disabled or a CPU lacks AMU.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/cpufreq/Kconfig.arm        |   4 +-
>   drivers/cpufreq/tegra194-cpufreq.c | 161 ++++++++++++++++++++++++++++-
>   2 files changed, 158 insertions(+), 7 deletions(-)
> +}
> +
> +/*
> + * The AMU counters are per-CPU system registers, so this must run on the CPU
> + * it samples. tegra194_calculate_speed() queues it there with queue_work_on().
> + */
> +static void tegra264_sample_counters(struct tegra194_cpufreq_data *data,
> +				     struct tegra_cpu_ctr *c)
> +{
> +	c->coreclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
> +	c->refclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);


The core cycle counter and the constant counter are read separately
here, with interrupts enabled. An interrupt, or a preemption after it,
between the two reads skews the pair, and the resulting error in the
computed frequency becomes more significant as the gap increases. How
about reading both with local_irq_save(), like arm64 does in
amu_read_core_const_ctrs()?





-- 
Thx and BRs,
Zhongqiu Han
