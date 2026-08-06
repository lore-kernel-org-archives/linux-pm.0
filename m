Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921E3D8121
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015349; cv=none; b=qNpXBh9i5gDYHX4LPDkpJOHG17Y4cLRcn+EIEokJgyhWA17BgKKd0SfS3TlRJ6QcrxzFmhoueKdkHkUZ0b2djcXR3hJc6FtthVwdDJqhkDxDXwMFQOk1kwj1OkWx7Ko7lCG7ciekg1oHWPkIr70rnPxt3zV4j4PqEINidNpRgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015349; c=relaxed/simple;
	bh=EmoTjcFKKWkEpYz+sN13qHspYotNdUDpMAOcLy9NsfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyFnfNt+LLXmT2LOZHzUBp3JZOqKUSM73HuL9UeztKwFxzE0P71lV3x0MomxWpmbbF9zqUBU/yQiW1IRQXVKq1XUUxMHgWaI9xez6DfxPxtoyv00a/xiSN59eaueZXrWUuTYdu/XN/ak255RUpBdhyzjowwpoi7/McGbCAQDXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLYUTQ4/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AoXEW0OW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLYUTQ4/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AoXEW0OW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nfp3865623
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 11:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	el4JFaFHcBqvnx7H70Vfy2ndmqSRpKtLmn/ho+OvcDE=; b=ZLYUTQ4/21InzYzI
	Kqp2HdEQDJI59EkODPj5yoYaPCytkZaTGg747L2v7FZI7XEZShC/UbIPX6C6sc/+
	7KnfRvysOxR0ZhYG1AgaDgdCJlzXTj8OucxRlemLumQ6sWDez0YRHYZUqTU/IMRW
	e6r2ZfLt9WjdO3sERIAxcUu05iWO/RxzBQ/meD21Tb3ihhwwvbbpdXhbMdyzCn8M
	S/Nnunmhi2rZ6duabmVmX7rjs8KSz4rQ5ddSWNvbvnHZisGp5AKZUdfevoJPa/PT
	atz4oYnoUKbDKa0iZ0e9n2ZNReDHE7HD06vxcfcYn4LClx/3WK5ayu1olUtAzMIr
	1jivTQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5bxsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 11:22:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso2385866a91.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786015347; x=1786620147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el4JFaFHcBqvnx7H70Vfy2ndmqSRpKtLmn/ho+OvcDE=;
        b=AoXEW0OWu6Zq4/kjZJCqw1Zd5p5UC8RlrTpNK+I7aAQfOCLqo4ZGAFQVo7bzLp7Ipt
         9KdF0lHrl14EVP6ClDrbh5wZ8sgcAfgfYXy8Ow/q+u6DkFDECZP2UT9w/A9Pn/KbLloX
         XrtP1nUKexgMa9lXZZhhgiWMh4YJgXZpxRtV8PXNzMk1ucSaEbvUlKiI8/HAPToDyfef
         o6IpdJ4uiG1xgu4d+XEV6Xk6U1zXLRMc465oPKx2xaF7qtBD76zBR2XBkPWD9EdUF1JA
         oTk2zR0ZBMsf4sNO/UujeYmSCpRPNjh7ak+EJJXC/ViMLu1S5TwFiPk5cK5D0MKC9b05
         AQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015347; x=1786620147;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=el4JFaFHcBqvnx7H70Vfy2ndmqSRpKtLmn/ho+OvcDE=;
        b=SRm9Rjez1sUuF8QESC+YdFcapJsmNwKD5fg3QS+GWlq3RlmasmvHS637OT8CfaopxF
         RpUE5Ks09fPc9BCsePj7z1eJe/X2qmXpHK1TxyqvjNN8he3uklLh/zgL1YnOg28E8Q9K
         NOkaVAgH3PiVMrScTRFOJDPyUT8ktLuRbHFqAM8fW8AOqGVUsGUEKnf0c51bdLGg5/nL
         o8o9NStQZbeKrEzWPCy8XiCT1giI6t62I/X2lU5yeZSP3Q31myPGDMXR+mSbZVy/CkRD
         /LFcYw5g+2cz/DK4WIwfumCATh6o7SjHI0+fMiDZCxH0hZFs3DG4rxeHTGXFNz0rwS1+
         9qrg==
X-Forwarded-Encrypted: i=1; AHgh+RqEBgHbA7kLQ5Dx6+8SkwijCK3OUCsQnJ1a7r55YBx8F9tTw+QDuC/zuI4RTnoBT+sxBsW/w0c0Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNBoLp9Tbz3/00vz3ko96st7XuLO79JYLfa8HErVgsaMzYi5y
	7uN5aPbwfwVGPcAJWKRZEsMBKmkzvs6/xums+owb9bg/4X17vHSC/cnpvC9CdPrK2ywYSFi2DXZ
	p1jfBug/6+nnwfG3lyqmpVvvBU1WF9QemIUgD2ymgejrGuIW/XZkMOcxPbcSPx19+4Pa84i38
X-Gm-Gg: AR+sD13FFVuqCeEs5VsK27Fdj2gQjfYmqZnLsXVaFl+xkz3Ed0oSZFCIHB0kcFzW2t6
	p3JkmRuWjhLN6A+jykDpIdPCR6bSi/12kpes+ocTqKN7bOmY5MFekZaaFRxuX530rHeyggQiJMU
	StncR9O3pnJ1W+3+zoBwjI1Z0+PkvQzGb/zHGtdUHxZNl6GhdyzvFipa/BE170hR61PXdm2GMZG
	QMMAdGHEHq6ejQ7E6j51kXw3xVZpvwyAX3WkgGd6o/Lb5KN0Wgae5i8X3G8xnVTdIJYtM1fq3sf
	hJoHVATNF8cLVmqakwRg60V2A0/EMFuu4kqxVr6BjWbHZgaOQViI0DOwK/Hv+9DegFxUnSMF/s4
	WE1vJQlkI/sZH1F4ZYjrXLmbv/RwrpD60PJHAquEYBRXcTPFpM0Y3xfcSjXMBkFp88lNM2ug4
X-Received: by 2002:a17:90b:1c84:b0:38f:5828:857e with SMTP id 98e67ed59e1d1-3903c5b4c5emr11406198a91.16.1786015346859;
        Thu, 06 Aug 2026 04:22:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1c84:b0:38f:5828:857e with SMTP id 98e67ed59e1d1-3903c5b4c5emr11406139a91.16.1786015346367;
        Thu, 06 Aug 2026 04:22:26 -0700 (PDT)
Received: from [10.133.33.203] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5b98csm1343904a91.13.2026.08.06.04.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 04:22:25 -0700 (PDT)
Message-ID: <54e74486-12f2-4b09-916a-1a8806871b6c@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-arm-msm@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7uuLgZMS6_7WfgVS5GjV6ft1DhMaMJJL
X-Proofpoint-ORIG-GUID: 7uuLgZMS6_7WfgVS5GjV6ft1DhMaMJJL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4OSBTYWx0ZWRfXwtaWRqJIHcBV
 MOtfIZb93oBYY53mJN7yQ+MxyNCDffCyEHPKR9pMiWktqfMN3WFq9NTW2seIXbc0eg0NPVwW0RX
 P23uZQK8foJQNT7r553bE4bLSJ8BCwU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4OSBTYWx0ZWRfXzOte3VR0DaEW
 bVz3gEzJY8cLMLOv1AsIztTs/ZWUi/Nn2UjCDHxljVxsVI0d6YAFFJ2QFywDG4XlMdtYTXeug64
 v0bwSXZZ9Gg/yy3qEFC/uKabyqUymsp+QTNISYi6/sP+6wLrnOm5SqZkralqEyRF0r3VmazX7uU
 hVlbLfEO+eLLFk3+qwFDSn2LAUVxR2JRgK+mG/S84Iq2gwq4f77i89lVPeP/AkNrQ7AmmTPOTJK
 Ex3LMaIVNbTfsH1VdYRhbyTwzNFRla9QBRzGlJmXdZsErZkhwYkTP7c1hgiZFYoh+bUuQzJ8q9E
 I0iON4pQZlP1ji48D+YS620z3/aOrxJ4ac/NtHnwH+TyLabNW4VEtaDhFdTFlMGUcH34RQ8HNIh
 3nfsLu+NHaqrVxYzFxEQHeyn85tRjokoNGtOnrJopLFwwEQODh48HHs1fFKyYeG8Gl2ttVRYA03
 I0L5ZHgYauisX+xEzkw==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a746e73 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=BelGTQZ_NpiV2tDX9rUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060089

Hi Sibi and Ananthu,

On 8/6/2026 12:42 PM, Sibi Sankar wrote:
> From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> 
> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
> if max boost is known") guarded cpuinfo max updates to only allow
> increases, preserving values set directly by drivers above the freq
> table maximum. This prevents cpuinfo max from decreasing on boost
> disable, leaving policy max pinned at the boost ceiling.
> 
> Remove the guard so cpuinfo max is always derived from the frequency
> table scan. Drivers that correctly flag boost entries are unaffected
> since the scan already excludes them when boost is off.
> 
> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>   drivers/cpufreq/freq_table.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index ea994647abc8..791118466ca4 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>   	}
>   
>   	policy->cpuinfo.min_freq = min_freq;
> -	/*
> -	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
> -	 * it as is.
> -	 */
> -	if (policy->cpuinfo.max_freq < max_freq)
> -		policy->cpuinfo.max_freq = max_freq;

As I understand it, the guard added by commit 538b0188da46 is
intended for drivers (e.g. acpi-cpufreq and AMD) that may set
cpuinfo.max_freq above the maximum frequency in the frequency table.
Removing it may cause those drivers to lose their boost maximum
frequency.

The regression should instead be related to commit db80ad776cd2
("cpufreq: Remove driver default policy->min/max init"), which removed
the "policy->max = max_freq" initialization that previously allowed
policy->max to track the result of the boost-aware frequency scan.

Please feel free to let me know what you think. Thanks


> +	policy->cpuinfo.max_freq = max_freq;
>   
>   	if (min_freq == ~0)
>   		return -EINVAL;


-- 
Thx and BRs,
Zhongqiu Han
