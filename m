Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882335;
	b=pqiwyJHHJMoLrijJ7KmXlAlF60Wj823SzzedYkLO8lmsdobD2wZJij2svZYoArPtTL5G
	 O31OQIs/HI9DNM5Kj5P69Jhh+wNR7+/6kHowtu9wZ8PIAflgLHxmer7gCR8RxckfxrYsD
	 8LxtcMlcHXHVZDhPwmh/veyNMdwt1ZPLUn8wfvPHE/o8XkD6oKraDo4+cOgV4cazOxgqA
	 d31KP/75SsXVna6nql82iH2622F6Fhr1fdPrOtGkPNfNzihubkehyytSgewKjRkB7ARSo
	 1y7GdC9IZWTMNmId54HuL6mG3ukUzWkDXo8aH2t8zj4iL0BDglaMYIMxorI+iqRd4PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0vGWXmg1itow1losLFRnU/f5R3wkwSa21eMKz4MdddA=;
	b=zxIzrsgiGPzTAlIvILMfHYlMtu3RMfQASFXy2AqlUrTFGiB+6qCFQ5/RjMx2kkqoszbJ
	 QiZlzxnjVO3Ax5yDcnqbzlGdeKFh34qA2CD6JSdxGRfpPzOp3NgWL80rIILfclIWforsg
	 2EmL+dddjZLlxmoHoQuzwzeuxiLb3mAp8m5kXvTGcShd//cz58VKKA29uPmNZ1oQfImc/
	 liQodIQK6YSVB2hu+yiWzJlgbN3f34Oir7bPt7MIIbmr460lx74N1G1zns+kiEOiO1rns
	 +Gk8NluA0s88YmnAxeQ5RrfS6OOAE5ew0qVbfejO1PhIHGHzjlcrHavxo9O14P025dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nvuwQMiV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bhg6gbKA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423F606A326
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5423F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nvuwQMiV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bhg6gbKA
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tQOV433380
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0vGWXmg1itow1losLFRnU/f5R3wkwSa21eMKz4MdddA=; b=nvuwQMiVy3FMNKIC
	1mUT9ynZD3oO2NxhwX/O1AJvLxJfzaB3zxVjOtL/1f14o2lB7OejhMzicbqSnQxI
	wKenOhhKu6i/tGEpbBPgXYTaFLKoIgoquB1XEIxVy1VO4p/ruRpqaytwZp7u0ig4
	A36cb7VNs8SbIE8Dlu9UOvImMwMLoePZYJtGpdTJjuSXkkpXoTA58vG6wbMO0Rxt
	LwwPWoaY7l4BRpeRv+aWPVNc56pS+xWi/KbX++1WfqcceDy7jLrkggpU3FovSX2A
	quJpMxvj+YDTOG6OHwG+XirJC+yX6NQHXKe71RawkE2PcttwoXnPCEObRH3TkAAv
	I+pTcQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd9hnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 12:38:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adad90c894so2178871a91.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 04:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793882332; x=1794487132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vGWXmg1itow1losLFRnU/f5R3wkwSa21eMKz4MdddA=;
        b=Bhg6gbKAzgjSlP7nWQca0FzkQTkYtfwITf////RZz4BJV2I7Gg7THAjlQg7bpda0fi
         rr2QDKQKbpQfl0GH83CyujfHfeSRE1ExAuUxs/39u0pXIgfjvy5yIInKxSQZAFEDRuRE
         ZN4IXWywjFW9A6wTvP0aaxM2Q/1DVsgFZf76QZP9aG8s9VlaxZqV8O+Vv5DDCHtMaUiC
         HfoGGg8mSkEWi4gAiqNHFwPTcTzN2zSgZ/pD1JNvwH4J++BVAmoRhhJqs2bZmYPWx4IG
         XebU8WQ4CVIKOj2DhoF9rT907ixMa2CKlrk0hsU5qDLs1eggoaItfbMhtu7fRvUwMdgZ
         Op/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882332; x=1794487132;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vGWXmg1itow1losLFRnU/f5R3wkwSa21eMKz4MdddA=;
        b=PqGPzz/2y/HeQ7oNX9VyZHBZwXeurJ6c18w9HufjwmXICdxMzV3C564gm0PFYbElsA
         1p2fSOz2EE2aGwoxAd/WHU9n8727t27Kuf244glfjvPfdOR13+GQ8tJLWclFC1L+z7o7
         H9VoU3x54GAqd+PCGxNzJyGIvAdC5dc7wF9MEl3LbKxgYsjqYh0H923gQdkjgmoUg/dT
         Gqoc/znMO+APm/CJbKqoJzW8khIrH5Q6iCgRfVCSTbcbfVz2Og9TGzobCvAA/39Ch68I
         7l/NuvbRmsvf4eOFhLHCjG4bJ9f1P0A+82VDFdAVe2v2B+oLAaYHk7QC32YdPXRx+rrf
         t3Ww==
X-Gm-Message-State: APuU4Z9P5emv58oIIX7e5vp2m1PtDnfJ2JTzqHxWX5M99unnj3Np68m6
	utAKmfFHaTSz6DtVJXS51cb6i5f9LvYlj/nrsE0NpU6+DxlkyiHFhAkzIbT1XJO6fBFETbDL/4g
	7uauIkdgr8APBdMQ4pyohsS4MczsO3pEJ8US7fT92w59p915H0lMg38LDM5EzYg==
X-Gm-Gg: AYBFou16IkRa6n+7J7T1W9BZw3ObCH8toa73q27ZMUjsNzsNNvJK34TWuAFzKqBcVhY
	gKbmL8vC7Xk//P4HaWL0+2VZ+kF8TOg4t3dT8RlR2HIWyb9yLTaI6MT2zH8zahtDgZ+R3J1kVCA
	PbkjJc9fzdifMtYDkLM5kXGu0+FunHXCrgXp8VHUouJUhEXT0fk4gLRewUfOPMT6CuC6ODKnDWM
	H4AphHGi9HDbFGKsOInL0AMBhh/Q1eRWmE3uxFnVrZOEPFwpZ6RSvY5zccSOM8HHKncQ2FVBMMx
	3h6agFFEi9Xu78x1tvif4znV89mNcfj9yVuLebBzdrL6Y3hOZFPGd+96Sgce9HRJw+km94YTEcV
	vgEI3obyfSknOb/hQJ6D+Rz2hOj2qdciThUjyyNKxt5db0X1xsGse0nMr1h/NZwFcARzTcCKXMB
	VUmeVKwfcwzIb5iz7XRMe4KoUVvi7ZK2h56nqOylCgM90=
X-Received: by 2002:a17:90b:2ecb:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b0a38a68dfmr3664188a91.59.1793882332119;
        Thu, 05 Nov 2026 04:38:52 -0800 (PST)
X-Received: by 2002:a17:90b:2ecb:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b0a38a68dfmr3664161a91.59.1793882331646;
        Thu, 05 Nov 2026 04:38:51 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b312e45dsm4573531a91.3.2026.11.05.04.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 04:38:51 -0800 (PST)
Message-ID: <f3db86eb-9101-48b4-b552-c6ddb927a134@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 20:38:46 +0800
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
Subject: Re: [PATCH v2 1/2] cpufreq: Preserve global boost state on failed
 updates
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sumitg@nvidia.com,
        zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com,
        zhongqiu.han@oss.qualcomm.com
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-2-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261105090311.1026648-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec78dd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=PbuyZ-RghgUmf8ib_JYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Zoo7JGFEsW0xzaepL7DVBlVOCjzC_kD6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX2I6IWbwu1jYH
 sSVOnZ0jcPc4nsrQE5j+sBVl37Bzde3l1K8Y/mM7XsPdNfbLWfuzUMdtGDBjOS4rrbUzy+vb/Y7
 JyGRlmmgLG89dso5TeJahECwNqD74zw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX7rHfKQ34F+vP
 //ve8csCOSvLXCSYhW4K/Grw9QofqmgFNMkU4Pw9P3FkRzkGsHQINKylkTF+a/uLiBfmbdzCloY
 aNcrfPeuTInG/6aIYL5epk82ajCUjsmurU5q1891XbfUHR2dS9edvxA2QtBKdO3EZIy0dL8IF9K
 taZ86QXhZgXo4vxR3K8wB0cv93GBSzwjaW3hsCO7rkD+1Oz9K5lFWfoLtOJR/+34A6kPR85h/Po
 ZIAO6tLLVOQRb4tYuSA0M+1fP6bI4w7H9tXgpCK5ijJisqkoCFO8GpaNaMTzSk33loeHLw6sALD
 G9ia6d8uDSdPw0DUomzmbyOyTKk+Kf/O/U2LmbMJ7gtl95JJMAUu93gXES8MgC1s9OUkwKDtytj
 9i1+lqT6SLToQRubdHS053CUB2jaaJV9g77vBbMfiGhkDl8acdFYEw4i7+PU1zEJiPUaGrCL/fG
 PzI5fihWB8XDOIaXbwg==
X-Proofpoint-ORIG-GUID: Zoo7JGFEsW0xzaepL7DVBlVOCjzC_kD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050050

On 11/5/2026 5:03 PM, Christian Loehle wrote:
> cpufreq_boost_trigger_state() restores the opposite of the requested
> state when updating policy boost state fails. For example, a failed
> write of 0 when global boost is already disabled enables the global
> flag without enabling any policies.
> 
> Save the original global boost state and restore it on failure.
> 
> Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/cpufreq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..23a77f5524df 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2814,6 +2814,7 @@ static int cpufreq_boost_trigger_state(int state)
>   {
>   	struct cpufreq_policy *policy;
>   	unsigned long flags;
> +	bool boost_enabled;
>   	int ret = -EOPNOTSUPP;
>   
>   	/*
> @@ -2822,6 +2823,7 @@ static int cpufreq_boost_trigger_state(int state)
>   	 */
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	boost_enabled = cpufreq_driver->boost_enabled;
>   	cpufreq_driver->boost_enabled = state;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
> @@ -2841,7 +2843,7 @@ static int cpufreq_boost_trigger_state(int state)
>   		return 0;
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	cpufreq_driver->boost_enabled = !state;
> +	cpufreq_driver->boost_enabled = boost_enabled;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
>   	pr_err("%s: Cannot %s BOOST\n",


-- 
Thx and BRs,
Zhongqiu Han
