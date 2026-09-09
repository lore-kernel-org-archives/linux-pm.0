Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEE57ED98
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970939; cv=none; b=kAjWf8jPiG47TWSBliGyK40yK/JNHS+QP7xHfS1Y266vYKVwEC6ZEOUpOfEg0U4v0+sQMVNy5ViqU4+eLHqiSvONNUh0GE9Z1y4NnKBy+55tb/Rvmh0zNhqANhseA+WuM+dkprb2EDTWazjm1eYG8ODI1rYq8GedxsGEd6e5Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970939; c=relaxed/simple;
	bh=Q7NUp2MkJHfxY3tIGeAEVf4Yvjl19i+ocRuOo5HNDQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgZGTKrby3T6ej4tYKD715JM2/9qSv3Hc8MaC0DS40Krx0XWOBDaxt3TpedDM7mf9zlV6Z/myLezoRuHaL3bcVY3hPtzn+3NXD1Hnenod5IPan/BAi42RqQmnnzVMHNtDnwHltfUj4cWniwzpH9WIgTg2sg8nsg6WEN8404JdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VH28Nwv2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTfZ29zS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VH28Nwv2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTfZ29zS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CCjvs1400923
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 16:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ssfjYTj1l3r/nXGifnneYFAL20uCc6xve74iaokQPg=; b=VH28Nwv2d9EhqaEc
	FJeZXRJGY5N4bjkAzPBXR6ndi2BsaFONDZ3XyR3wMbxu9zdnY3bQyHjMJ8JWLLLu
	xviPq/oHs3fZQDC4TlfZbvz2T/hq8VIPzAw5WCgGIP/AosdVoU95zo6Ypr8js3u8
	yx6w8e11o1u1/ALSvcVuDQ8jHOs/cq2s6t6KxIoOAbzpIFf9FSMrPxkiv/f5mJWf
	cxE7B2LyRsjUiyUleMpqqB0zv5QVpRCBv6BFP6tQ08PjCov0XyhyRtUwcNp28krx
	RjE430/3RDL8pV3aRuCtE02cBIfY9ZbuqF8n+Ilxmo35PaEJw51Oe/DcDxnmdoij
	Rf1S2A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x15s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 16:22:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-868db1b2c64so1398874b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788970937; x=1789575737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ssfjYTj1l3r/nXGifnneYFAL20uCc6xve74iaokQPg=;
        b=QTfZ29zSkB+at1q5/UP1HOtBWKARx1GtiSwYH7r8S7hBCWMj71SdxLi3y+0s78KeZg
         nxp9Vop7ZoOoKGWW7Pmcrqv9lIrXQmQvzahxRRU9Z7z8qPeTV23F1yM0aoV8/lBc33MM
         Ca8ZsFH64qgW1wgb+Jj/FZkIbbeCStYJzgJDnDL9KrwwNb/+zFMHQfarAoTtcx+9k2lZ
         gJwZDl71Ac9LorsLf4SbBxncRbE8rfs9dM1gLR9jmeWVMoslYoOOGwfhu40UZfT0aIg7
         WzKHYL/a7MaveNydHBGm+tEh38MQytJrroW9aBxFQhun5D5VvQI+OC4SkHiSutqCUb51
         VK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970937; x=1789575737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ssfjYTj1l3r/nXGifnneYFAL20uCc6xve74iaokQPg=;
        b=dFz8gWAOj0wZNluRlFg/inphedk3I0bpsq5DHvWQuqaTVRK7s1k6BDbaIS4kpaaTde
         4L18wV4dQYHpEgPXRohb4sfmg0SqYQ+Q7QOLJixsAty4XrtSlEV8zcQSRR57sCU2Szj5
         ogGPvGJChlpB3nDTBYahMgrqsoMlQasqGQjIonwuQAs/acDBxTOuOZZ5ySkQKWnwmcQt
         9JxqFWClnNSmJLsZBEp/9d8e84LFULqSGmOnjI6H/h26ECEUuL1R/uSvITwrsWlR3spK
         3dH3ri24lfilBLJBCDu0uiDi6w5fKVqXp0fgR1ozpb0skXpC5BgrrKUQEnzFn5bgri6f
         JWMw==
X-Gm-Message-State: AFuF++n+32cv7s2GotgoNHACRfXPPnQ0nr1Q70Oo2ixeZseDXDYzzg6n
	XSHfRI2YG8k323zXeoKYnvI8RjEfOUAgGnnBDNquflPCi/kk/CGb4RkPTwvh+zh8VdqcqWfKmF1
	M9+BlyB/ZxMnAleFUgkAlLhBfST5afsliuW7uG3DwPPKHxKyb+dN6xXCb2x0PeQ==
X-Gm-Gg: AYBFou1eLEHnGHsZ5DgzH+lh74twPxxqq9k+ay6l57OXIdFG2ZdtBiWlJROzlZcj6q3
	6s7vGNT/1s2rXce6V/hs+JcF8fzHYTLd4xUrOOPvAISPECyioNFVM/laubTVQUEFP8RNfsmn/2v
	fiYLjMSGzF+/Vw3hb9TjKerIJWmIlVo6yEij1thSnkfTg+h467gkB6Uir4RVG2VnfCYoTZDgbKS
	I9y7OzASJCz42KxwqdUmeJS+T64XUIsFq9L0W2YpQsN1GfU5C39g8Jrxn+UsYh6Aa33gshdXv1+
	nIpaNFN8GIBMXs0SBq4ydK89MV1U3tU+Zb9VeyRrdr7UjhwxmgXqiY++6TU+6IJtCcNJCWT6Wpc
	ZJi/a/ZAcK2CPv3rXdmfxPgjp5W5DhnvnkltqiX2j5HXhMXKvz/6HPe3nWyxqRbaseeiYWukc
X-Received: by 2002:a05:6a00:3bd7:b0:868:eabf:e07a with SMTP id d2e1a72fcca58-868eabfe7e5mr3488988b3a.10.1788970936852;
        Wed, 09 Sep 2026 09:22:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3bd7:b0:868:eabf:e07a with SMTP id d2e1a72fcca58-868eabfe7e5mr3488954b3a.10.1788970936246;
        Wed, 09 Sep 2026 09:22:16 -0700 (PDT)
Received: from [10.133.33.154] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-864782f0be1sm4593429b3a.41.2026.09.09.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 09:22:15 -0700 (PDT)
Message-ID: <d78f8ddc-3d51-415d-b399-5a39a63a2586@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 00:22:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: qoriq: Fix clk reference leak in get_bus_freq()
To: blaze <1466528493@qq.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <tencent_60DAC4127B362B6743CB0BFA2C31982FD807@qq.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <tencent_60DAC4127B362B6743CB0BFA2C31982FD807@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rjhUVV9B47g75XTzYu4Mo-2d9rLfUI5U
X-Proofpoint-GUID: rjhUVV9B47g75XTzYu4Mo-2d9rLfUI5U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4MyBTYWx0ZWRfX+PJs2W/XlPFp
 wwvFzGUd0qbafLSCJOPQp7AZY2iA0LJ21UwT/z8mHZu5+WZcY8B2v2mYz98Jr96/WOL8Jl6tiGb
 ofrFDLIyS9O2lVZlwG0mXXONnpM8mso=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4MyBTYWx0ZWRfX46ioR4+BlduO
 tDbTYu74ZX4PlMptxYMvSYHSafuBDQ4triuBUGwBRe8AK8tFv8HVYYJiN6MrtAKutV9O3reTnJ0
 yiN7HisSDxJlCYjbS+e4ZfbSAJEouKPJzpfEs5Io3z21s7HA3/c3jXoaIZUruC/sUzUVBLhsOQZ
 1VpnrUxum+Se0UR4bui6cFutOLO+2nAAy0Z7Q5TMYdGMNa4oFNSr4yjArTGoZecqGMfznUKPlaD
 qEbq3KEcVLZK2vAcPV90/R3uYVME2EkapTqtaEfkWgpNDRmqZ3WYXrYiBnTPArh4oXyLTK0M9Jv
 tgcP7e9PM4Rz8McfQg60wS/qe+Xt9+Ne0toP6kFiLMuCRnZFQNL8C+e65U8aRGpZUCdtJSTaDTt
 smhi8pWEfaoIS9BdjOThF3vbmymhJ1OVQUKGEDr5IE69wSGkv7sx/KUPzKQwmpWHbRU/XWwdw9u
 Dd3VrpUJZdBBpqgoqjA==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa187b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dZbOZ2KzAAAA:8 a=e6XpzHukWT2NPN0GgxIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090183

Hello,

On 9/9/2026 12:41 PM, blaze wrote:
> clk_get() acquires a reference to the clock which must be released with
> clk_put() when no longer needed. In get_bus_freq(), the clock reference
> obtained by clk_get() is used only to read the frequency via
> clk_get_rate(), but clk_put() is never called, causing a clock reference
> count leak on every invocation.
> 
> Fix this by calling clk_put() before returning the frequency.
> 
> Fixes: 1b6f255990ae ("cpufreq: qoriq: Enhance the support of clock from DTS")

I couldn't find this commit using either the commit ID or the subject.


git show 1b6f255990ae

fatal: ambiguous argument '1b6f255990ae': unknown revision or path not
...

> Signed-off-by: blaze <1466528493@qq.com>
> ---
>   drivers/cpufreq/qoriq-cpufreq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 0000000..1111111 100644

May I know why the blob hash is 0000000..1111111? Is this patch just
generated by AI tools?

> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -62,7 +62,9 @@ static u32 get_bus_freq(void)
>   			       __func__, PTR_ERR(pltclk));
>   		return PTR_ERR(pltclk);
>   	}
> 
> -	return clk_get_rate(pltclk);
> +	sysfreq = clk_get_rate(pltclk);
> +	clk_put(pltclk);
> +	return sysfreq;
>   }
> 
>   static struct qoriq_cpu_data *qoriq_cpu_data;
> --
> 2.43.0
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
