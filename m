Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975340;
	b=yLqeDA3E3IdgpHY2gCdIEB1VbEuXMMMoHrs0GFd4gB3smyzmneuujYGl6B0i+o29Xcgk
	 6CnEJhOJtGI4y4Un8MvEPHjxq9z8sajKWRDqfOpv+yNTpLdkAE6YyLUB4Qpl6+rxNAaac
	 cExEI1t5GK16jpFueM+qO+CpTyVt2f3tRLcKDcHwv2wAz3Z91gS0GppjcyBJ4X4AO5VwC
	 DumDIdFzkgM1yEldg6lDPO1T9wer03JJdLoW9wEExYiWEooL2voSxKhnvsyEEKOY2rgbJ
	 F5S1pLjNH6nC7ilXCb+Te/wd6purhAI+o5RNks1n5ztweZaCWuphyuEKHzcEAHsahsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xNJaMwym5ZKKLsYL6cTFMXYIEs5/IfORKVL2O86kwWk=;
	b=f1x0IN/b20gYz+DbvRp+0qNFsqd88ErfNHJez1riljimjmzN77NN77jlzhdT0NdAVsPe
	 MBo/qZ0uH7wFXB8x0ncEUTdGpua13et6XZ3XT4Ud0+/5EcfC0ChmFap5iCZe4hDAamnwG
	 3RuVm+iicr3OqbrOEU9kmNBz0AUkXYufyGAWirDLPg1PvmR6sZRZZDLFwuxZwDN/hTkJX
	 VketKef32bRptWC+gF+5lhHKtrbUV4fnAOdRkk74sO0yep/lJyLSJhmrALxFuEDGLf0mr
	 C/twDThfookWNpWHo3Wcv2Ji6Rx/N1vFjJ/rkhimQiQMa6TJD3el9xu82IQA18yGI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwKLl0Jl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iisccVqG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF18606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwKLl0Jl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iisccVqG
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2UrqY2383089
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNJaMwym5ZKKLsYL6cTFMXYIEs5/IfORKVL2O86kwWk=; b=QwKLl0Jld8xitQup
	l+HsJF2Dv2+jTBtru7ZsdYqqX1NdfW0xBgn87bKfSnM9ZJLMF/kN9FpBAGdPKCHB
	uYeHUEIDc3sHm9wMyOQ27YYb+qqvkOUnoPDSIS5N+H97Xig1YLWL2IqcHFLunPry
	/EqNW2Q5csx24b8hEyrL3RIskz/46RkabyYrs85YIg6jAJBNIOQJB6XtFQODoQqG
	EaF5JtRDv9ifdpGkQLKwKUyAN5nqvWmS4xZtL3LAXGS+JW7gzkTXBwVHvDNoOh3Y
	DgOJZasNpMNlXve0huTRL4PRoUj5aVNigf3l6MTztQVYUxvQghspkm6WIEr/wb0d
	BsBqPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvas56x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:15:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso376484a91.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 20:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794975338; x=1795580138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNJaMwym5ZKKLsYL6cTFMXYIEs5/IfORKVL2O86kwWk=;
        b=iisccVqGUFzmhNz8fi8ir5AsPA9lcaaIW56Nw/ZhnzoEsmzcd724v1O4Psedb/VJXQ
         vo2tKpnBKll5DLAHdw3yukPcseiET3XKO1vsTADurvba9ulFyj0dj6/9RveGX8ecR27V
         o50UGFx5xfPhr0OfRRVlPK8J0t5FfOPFWKViV4AW7IalEEc9BM355TmPfru27o0Dxra1
         2MmxTvuhLn0vrIDg07cF0vnpLMGmNJMY620o5/NcTa0vmN6BbVOYi/pegL0Qjl0HhQuF
         bY9Vu3xmSIuZGS4qaxkIEHtoAzX+FIKFpwkmzvQwe5siSPDW10MYk4MrmktjEYjPtn6a
         NYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975338; x=1795580138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNJaMwym5ZKKLsYL6cTFMXYIEs5/IfORKVL2O86kwWk=;
        b=Nc4ZOR4v6Mn3kRDPQ8ydTI6ApXi9u7dpR6xL5YIpVoQgL3Kzk6alOpW1CTFQL7aKZD
         Boc+yFrVDrSzldRIAkDU69nDtIZiTr939A5glL2yiayo4qrd4U7DB+plDltmgROcxAYc
         JQ53kb4eHMeeRhgj8bHGqqfIbJ2SKV6Cq8NrfV6gHAadbHZO5f34DEl595ktyRRgTyOj
         WjJQUwahxGutOCYjjwwywom5ppy4P3EnMFGnxWnYEQ4M1MoOWK6HQyvKv4ty5kaYVjkK
         KgK85gSfnoLF3V3PpUhXry8CBdT+OPQAsdh7nzufkZR0HdNuHV8oQUjq+7tHBd7mM5Q4
         cwng==
X-Gm-Message-State: APuU4Z9hWMhfeN8Exc7FhGABU/bvAYe2eASIXlmsrCKWGKfhtrhC/dCv
	UcX3mB+7GgoaUgMHViN4GrA9gFthv7bxtcDrR8uOt3XqL9Xv4MFYpDszDxTnHP4MmoLxf/++ev3
	Gk0SGIyyyW4KMIFEyHS1ofz0oGUUfWTleOHfMjy+cLALQL1RqebKLqW/DKiTawA==
X-Gm-Gg: AZFdTZe49w9pzFTQCH27ZFFEsbOTKlXnP4x8NPi+HXtB7Ot+bzfVBKDh5EfWknZWKFQ
	RY//qL2ZKGQsN1ASSUS33sqvyfU3qHxGxsawincuXBXkLOZh18i2jxbnbWIojvLZO3vI3hRdVr7
	ywLXFbK8Uw3YO8pA7se5f+aHr7BGhs1Oi7w1KNNpWqCLNpkX1zZ2jDG5++XGpaoSjpgZyFaKjGm
	uyonC4IvXFljHguTsNfs5GfZRQD4CsAm6NxeIB98SspUB4kGoBugEIB4KzqANPtjaMeJ5YsUWrw
	HvobINrKrmuwbmTezywr4+fng80mTVMPR32mWTGLtAsKt0QDmilA4XzY3fO1GjVl8t7YXJG9M3y
	afIAnq5CKTNwdrJai6W2RJPkTik8tdjLC5cDZV5QOTNuYtve12C4FdNJQ2FozOZpo0wn6+/e4Q6
	OZdoH9xb1jnYr4lRPsIVMJyrbqrr1a3oEOyIbEJTjKCw==
X-Received: by 2002:a17:90a:d2d0:b0:3b3:b621:4026 with SMTP id 98e67ed59e1d1-3b3d04d00e7mr1481998a91.0.1794975338070;
        Tue, 17 Nov 2026 20:15:38 -0800 (PST)
X-Received: by 2002:a17:90a:d2d0:b0:3b3:b621:4026 with SMTP id 98e67ed59e1d1-3b3d04d00e7mr1481969a91.0.1794975337581;
        Tue, 17 Nov 2026 20:15:37 -0800 (PST)
Received: from [10.133.33.86] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56f6657sm547501a91.4.2026.11.17.20.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 20:15:37 -0800 (PST)
Message-ID: <c310d7ef-28cc-4ad0-9414-8b5ead52f53c@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 12:15:32 +0800
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
Subject: Re: [PATCH] cpufreq: mediatek-hw: Release resources when hardware
 enable fails
To: Haoxiang Li <haoxiang_li2024@163.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hector.yuan@mediatek.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261118034205.2002363-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261118034205.2002363-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd266a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Byx-y9mGAAAA:8 a=ae5kI6K66oS_w7Z61gEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 6J_sNtyNlwFcNazGcx8YOR0h70Ahc8Vo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNiBTYWx0ZWRfXwNmPzjp83pUF
 4pga8aYt2VVa/eotEeW7hJi3HS1aM9Mo2uMUmKFrS5XZoIgRmX92dkf8m8aUcfcGxgeDVSU+lhb
 FnlmPQ6rmjgn9lVmms9BfbXL800XR4PIBip36R5nJhvDNI8ETIPTefpNsdaycGK841xNMvBZyEK
 d3dBXSasXInKK0kb43cS9dCC8hSPD10N5oN+sdsf4503x4KJMKoX8i/FhJHz83q9yGYMkqvf4n1
 MLFlWm0awHPMwjFB11sHCH0RfT+q/Hq88JUc8DsNI5q8a0n2lyovtWgxBKohKHQYccEWlc343RI
 5jWbiRd6CsQTk4UcIn718lbX29QIl4oRTD9PUKYljsDUGmtp2yS2ulIAlacjTT9jOObqeRP6ieL
 is5BUH+fT3i2QAKVlbUlF8RVyyuOU6YfpGynnCRNdf6AL+ADL6zVHHgLBB1urmBguXT9Qcs9rCA
 YkwEVPrkNKh+hLRt9nQ==
X-Proofpoint-ORIG-GUID: 6J_sNtyNlwFcNazGcx8YOR0h70Ahc8Vo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNiBTYWx0ZWRfX3b6QWzQqsz3w
 mJPPp9hRisViTBQ/A4p7n+ywNJMlhUuKUQzbcH4MJ+Yomkld4UnrQk4jmZ3kTeZbQfybRVXddt/
 3XE4ri+DnwLUTNK4S4LzfEj860aal+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180016

On 11/18/2026 11:42 AM, Haoxiang Li wrote:
> If the CPUFreq hardware fails to become enabled, mtk_cpufreq_hw_cpu_init()
> directly returns -ENODEV without releasing allocated resources.
> 
> Reuse mtk_cpufreq_hw_cpu_exit() on this error path to clear the hardware
> enable request, unmap the registers and release the memory region.
> 
> Fixes: d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case")


The same commit also introduced a leak in mtk_cpu_resources_init():
when mtk_cpu_create_freq_table() fails, it returns without iounmap()
and release_mem_region(). Could you fix that path too, as a separate
patch in a v2 series with the same Fixes tag?


> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 2c57371ad502..65f15fe935db 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -289,6 +289,18 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
>   	return ret;
>   }
>   
> +static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct mtk_cpufreq_domain *data = policy->driver_data;
> +	struct resource *res = data->res;
> +	void __iomem *base = data->base;
> +
> +	/* HW should be in paused state now */
> +	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
> +	iounmap(base);
> +	release_mem_region(res->start, resource_size(res));
> +}
> +
>   static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -321,6 +333,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   		if (!(sig & CPUFREQ_HW_STATUS)) {
>   			pr_info("cpufreq hardware of CPU%d is not enabled\n",
>   				policy->cpu);
> +			mtk_cpufreq_hw_cpu_exit(policy);
>   			return -ENODEV;
>   		}
>   
> @@ -330,18 +343,6 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	return 0;
>   }
>   
> -static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> -{
> -	struct mtk_cpufreq_domain *data = policy->driver_data;
> -	struct resource *res = data->res;
> -	void __iomem *base = data->base;
> -
> -	/* HW should be in paused state now */
> -	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
> -	iounmap(base);
> -	release_mem_region(res->start, resource_size(res));
> -}
> -
>   static void mtk_cpufreq_register_em(struct cpufreq_policy *policy)
>   {
>   	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);


-- 
Thx and BRs,
Zhongqiu Han
