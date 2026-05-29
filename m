Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B23A8723
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042119; cv=none; b=ff2sK7DLiItRB3oUS0v3cJB8Ic+bPWbBJVPXzJBpslKlkBqYvt/3aj5Evf5HS3om+lyEHsxer9Xtw1Dp27G/vTwUeJ0WQXVf9qtObPM9clxk290qrFHY+EfAEv8fet9kmLnx52+VWz0nppmXl6P8R6TkgcEbv5zXEbKqVJFT2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042119; c=relaxed/simple;
	bh=WUVxhXzmB8uPNvi/ZQYWakDnsjdqi0YrZMtCuFg3dW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ociks+KvZtxbyHa5m13Qrg7H0jUINDdVZIniEQxCVIipTm1KyqrBY/+Egpsa3sjcZOyk46sztV9IogMnVH1VxiqhH0BJowplUhqlXXqpq/poAS9/2lru01TW0KlcLBYDv8G/kBJ9n/3wuiSxRibG9SmT3O9iTLnERtpn57eSzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBecIaz3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hpSDivrE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBecIaz3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpSDivrE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T5KuZ51249223
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mzQpnzu1SKsYZ2m+zDkXHsIhMOLKeojhZ3aXI9k++z0=; b=QBecIaz3NMlBwFyE
	ehrdxbTk6PpKMJqF/OJ5jmeP/WyUYHx+BhY1DJmr2arflkJ1JvzBT75p/iaRASVK
	VaB3H9X3uEW53HtwqjvegwvUtIBl/RSVag+UOL1cE+Pwg30bdDzxviqplAoqPLMl
	HSL73dsv6w4j3JDG46QgfpGYiP967JcORaqeg9NHAv0C8bFLiW2qvlnfcu1d4dyA
	db2tuwMf27yxleRFggctOV0X0dAfkxZKx9etLf8f+JrOyMAn8iI2/P2lOruTN9k2
	kOT/48v3GYbUgLPCDAD/kCQAiW+/pKVCh6E2hAOlIvkO9aguyysbZ+UtO+jw3rkQ
	kRPQJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj0ns1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:08:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so13585900b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780042116; x=1780646916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzQpnzu1SKsYZ2m+zDkXHsIhMOLKeojhZ3aXI9k++z0=;
        b=hpSDivrE8Zr7wUwXSP14okRREOvxdWdGeEZwvGnQQKb8wAah53y0YXnTphOmHsOkxZ
         3TEDe0UpTN50Udv0vaqKerefXBFMWr8DxJ5enLLjk7QuPpLkivZaR6qIJVhfYEwWw2/a
         6Aj29qQ8xU/n/6XhxtQpnO/4u1zcWKVGVXpdvnhWHLyZh0yxLSeZq57d0Ulk/Es6KAed
         Zxw4PO9Ca4THPFGJK2K7RJyzVq/2NfgEoppZArHjAIIEPLnS8ItfCKJWPqEOSFFx/I9i
         e3AZpXubtLs7ny5E3Z1JqNxvJvZTlkGPxnanYydcgfbCgqOKZKVP5SiAMsnhxfYRwf1k
         xHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042116; x=1780646916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzQpnzu1SKsYZ2m+zDkXHsIhMOLKeojhZ3aXI9k++z0=;
        b=rQJaFq1V9eK5c3rmk6tjmoOFU65KqCbia6nBWh0qLSdnCd0zW/uTfinuv73DH1spsZ
         bu+nSH+3M04Uh0HkLx2ssZllq/c36RWdpUh9UixMaCKGrlzRAwmFBnVG3MTXF5wlksLW
         brl2VgxRshEer9lbQKfaTHbkE7UGXGEuvMOto8QKCXsf1WnIT/eoahC7PkoOsjwAyIOl
         b+z5Ebc9KFJ1U8JMv2vo6GpbikLuvTVPHfLjTfYLK5CBDWu6yjPJUSmDRjPOBS55Mdt/
         GBbFiFqk37NsYVMa/03b3zUFmBUaIIhUGgKm8u99uw1HquhM5JuB6wBg2svo+Z7RBvwD
         hK5g==
X-Forwarded-Encrypted: i=1; AFNElJ8X9ZL5SXhVnzyDgNt0firfxCHivzxNTJzMRtugQRnkTUstjt9ZQWfBF56M7+NLK2+8Ib59YaTR5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YymdZcxn2iv2xvY+KASAczN1a/YNlzpIIbi5oQMtBsC1bILihiJ
	ZcJkp+ikaKf3RAHtJuptzlRBiyna6BfGtWbqwk9yv0hUaZpiV39S8Sk0OPtNKkfTa9ScJzy+NEu
	zpRTIDKN09q2n5pjxl7zUS02pWUENP6u83/t3mHCs3r167RZIKWPJzKNwWteuWw==
X-Gm-Gg: Acq92OGZUwi4IFR2v7MqnrBXi7r2z8A/V8I1jEEpwZOeANG5bPMKJZRayAy3ODcZnqO
	THPxXB0eXEvTsdxppgtXvUHyseeektARJLF9YIQHBmGp3M0rhBUUFbliMs8c6A5sRwwDoxaiGaL
	3cBvpHtgzqLRHSbHwl2PZQ888V3aqnxDLBOnTf4akuV00m5B8jR2sIWx8BtlNAKCH4bgKs6Xlfi
	XEr8BMScnViYT1XusjhAswMCfA1SRu9GeUycFi+RTSS6zDQJCWlELVY1X2AEla9Wogd0YEj5p3M
	4tgJRMFh7XLdUW/P+0cdUcewm0NIGKkvMKGB4w/MfkyOojJLK40quJ1gHlb+FKr3Aty9PtLDAQQ
	DM16CW7nB2Grht0GBcV20vu649ByiAM3rWynbIiOK+GSG5NjkZu57S2yfS+72C8BN/Mg7xCmwXs
	Yui8mHKYI/reZz71HHDZgOD8hd9pXv
X-Received: by 2002:a05:6a00:4387:b0:829:8083:472b with SMTP id d2e1a72fcca58-84211467b20mr1641098b3a.4.1780042115025;
        Fri, 29 May 2026 01:08:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:4387:b0:829:8083:472b with SMTP id d2e1a72fcca58-84211467b20mr1641056b3a.4.1780042114436;
        Fri, 29 May 2026 01:08:34 -0700 (PDT)
Received: from [10.133.33.131] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ce75f9sm1080257b3a.49.2026.05.29.01.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 01:08:34 -0700 (PDT)
Message-ID: <024dcce3-52ab-4c49-843c-78687b293914@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:08:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] cpufreq: Set policy->min and max as real QoS
 constraints
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260528090913.2759118-1-pierre.gondois@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260528090913.2759118-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA3OCBTYWx0ZWRfX1vFQV0fWIIGu
 hdY2BhKl7kNXAjVFUBvAdR44VgWtqEtFZMTeNSMqv+CkYcdEo1hhwvJy08bpv/LFL3ykHH/jG/f
 fwkk9spG2IYqG2HHi8+cYF1iXwr84eoWcmGvxA+5U4iAGcVWQEdkBTesu6xVQ+zgbhMA5iB/MYD
 ryEuypfrbPOX4/JlM/dIWAoPSrJnYKQJAu3AW33/vAUoAEpXokT4X0Pqa5FRsspLQ9PyiIXfsIt
 ir3aB57yn41XBhrN2uAKa1hWAiZyVxCfG/SB9MC0JahOyzUBlrRXQzIc+Q0UElEDwx5E0VHWaX9
 32GcDZcUpAhi+D05n2MUVLtlYEfG/0KCKjQxKzLSt/BcFbgfI+MISeUFeiRNzNaiPE1wKOqnJIY
 fci5YO8JC62cukDMwbdiLhHn/uPqNpZEFt86YipB+4f0xnMPuMlFXOQ2DAnCCe5Fym1p7QL79sX
 HX87Go0x6skDF8XVRNg==
X-Proofpoint-ORIG-GUID: PcpyKCxFwduDFjx8-OKtqYQm6w-KH90n
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a194984 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=StPsgHckyk6waopqk1EA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: PcpyKCxFwduDFjx8-OKtqYQm6w-KH90n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290078

On 5/28/2026 5:09 PM, Pierre Gondois wrote:
> This patch is a follow-up from the serie:
> - [PATCH v6 0/4] cpufreq: Introduce boost frequency QoS
> https://lore.kernel.org/lkml/20260317101753.2284763-1-pierre.gondois@arm.com/
> 
> v3:
> - Added Reviewed-by tags
> - Return 0 on cpufreq_policy_init_qos() success instead of
>    a random positive value
> - Moved policy->min/max assignment out of cpufreq_policy_init_qos()
> - Updated documentation


Sorry for the delay.

Looks good to me for patches 2/4, 3/4 and 4/4.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> v2:
> - Split the patch in multiple steps
> - Replace min/max -> min_freq/max_freq
> - Add references to commit 521223d8b3ec ("cpufreq: Fix initialization
>    of min and max frequency QoS requests") to explain the intent
>    of the patch
> - Update documentation (cpu-drivers.rst)
> - Set default policy->min/max values before the call to
>    blocking_notifier_call_chain()
> - Create a new cpufreq_policy_init_qos() function to put all
>    the QoS and policy->min/max logic inside.
> - Didn't add Sumit's reviewed-by as the patches changed a bit.
> v1:
> https://lore.kernel.org/lkml/20260423084731.1090384-1-pierre.gondois@arm.com/#t
> 
> Pierre Gondois (4):
>    cpufreq: Extract cpufreq_policy_init_qos() function
>    cpufreq: Set default policy->min/max values for all drivers
>    cpufreq: Remove driver default policy->min/max init
>    cpufreq: Use policy->min/max init as QoS request
> 
>   Documentation/cpu-freq/cpu-drivers.rst |  9 +++-
>   drivers/cpufreq/amd-pstate.c           | 14 +++---
>   drivers/cpufreq/cppc_cpufreq.c         |  5 +-
>   drivers/cpufreq/cpufreq-nforce2.c      |  4 +-
>   drivers/cpufreq/cpufreq.c              | 68 ++++++++++++++++++--------
>   drivers/cpufreq/freq_table.c           |  7 ++-
>   drivers/cpufreq/gx-suspmod.c           |  2 +-
>   drivers/cpufreq/intel_pstate.c         |  3 --
>   drivers/cpufreq/pcc-cpufreq.c          | 10 ++--
>   drivers/cpufreq/pxa3xx-cpufreq.c       |  5 +-
>   drivers/cpufreq/sh-cpufreq.c           |  6 +--
>   drivers/cpufreq/virtual-cpufreq.c      |  5 +-
>   12 files changed, 77 insertions(+), 61 deletions(-)
> 
> --
> 2.43.0


-- 
Thx and BRs,
Zhongqiu Han
