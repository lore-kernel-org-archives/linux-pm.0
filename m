Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BC3F823F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916800; cv=none; b=cnF/d0woYuISaaqI519H84HckIvOwx6dCW7xQ+wHnXPYhg8ka7IYUNnILaa4syFCj2KQn3fa5KRvXU6iluGbR5LlCbzDQC3OoIbKN8iGn2BYgvip2Xm9Qx1mNUP5ikcCoPCZ9mxmhkSNGg6KT7jT+VOGDUBoyDhl5M/FnYrZMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916800; c=relaxed/simple;
	bh=lxN9VsKxnMk9Ca2mxV7LEwYa0CIq7CinuVnZKRXFfis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtvjQO+laAbchHP1i0Vp1mlZGxyf3qT1DHDCned2EjnR4l1KZ8Efq8ynbt9YmOMHRizcKCARke7vJJ1zWUKx+lippYvwBDLwwhNGkHr45FT+5TfmfpnUm4g7z37eOV5GjhNl5TaJh/yBlfxhoO+N7GO2ZAd8AxUoatNXpFq2oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfq3xTB+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LFv07/og; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfq3xTB+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFv07/og"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA7kv33306365
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 11:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5AhiuAVIZ1+LG5oeQ6rnK/3zmSX0mgVXYXhfcI3yIwU=; b=lfq3xTB+qsdgCgZ4
	09AP4rZRC3qQREgcTruuqcIVn/oJry+e8snFr9Tw4ip5V4hPe2GQLDMoLUPrhzH5
	mpGsra6uyRzcJWgzmprLiNI3g4QurMhEc53Q2natH9gScEzSSsNxgS7UJ6zjC0ja
	v0E3+pv3PjjoJcNxXuKjb/541OTaqpAMSy/JnvyI23AvXgf3RmidrreCSUvbMubM
	UWUvSUcaKnzHW1x+4Ifi83e2kJaN+LKrsmkRAYklXXAOrFdtDlae7e7m3OFqPJtX
	O7V11LrWcQGMf1YjzYcV9uVP52jZQ3r2SfiaVIbCo7NRf2IH0YhPbk/3R+YfM8qW
	ZtMrDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p9d5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 11:33:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968dfff779so1570009a91.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787916797; x=1788521597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AhiuAVIZ1+LG5oeQ6rnK/3zmSX0mgVXYXhfcI3yIwU=;
        b=LFv07/ogSikpMdNG1yMMhxeUiKhozUjptVzSsfmLtx5DrLeXkLeFfu3tW10QUVr5iG
         45edGtfJSGv1veUKDqXO7jvRR0s3xGyTE6mxgVFo+UHftXcyDUP9N3nhfzXCN4umaYtV
         8Jj6/JV/gtmoDZRID8TBFNgK9CB7o1ph61xrlH7xIII5IGLqcYvOe4Hpz0x7nGE6w3K0
         UEHUWFf0zrXUDnaXQtlX/uDpNeezFIALIRlofgkpf25P3FevHQ/SfnIlKg/Y3fjY8TMw
         +MUmNbKGkaYcf0VTFMaiIvvRaDOBmjqR+OB2ix+T/CHR8VycUMyAMqgkd9TOU/tB1j5+
         fa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787916797; x=1788521597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5AhiuAVIZ1+LG5oeQ6rnK/3zmSX0mgVXYXhfcI3yIwU=;
        b=dvWi4JLjdPOA+xZ9UTZda69vosHTvUq5izN+rSfrGn4hW9Im1h+WI/MPkGLvh15mvV
         4q0E6okMzStYmWypiQM6TzrsYuX5xNYDrEJmZH2kl3rvjXIzRdSBfJ6BngdX9CttXmVz
         Y1pQwtkubsrABWy3QsM6NQP5B9Gb1/K7ZcgB6/kGJa6Gn0vcDHLsqoIg1LytctFE/REl
         470nDE9Vqsb2j+GVtXs7/RhTnnZlmVaulxpghSgt5asAFBWjip5pkZV584lrA8NaEx8B
         3G1fRfnd+i6ySVRjNqkBRjI+c0uMkvjGMZ0zeSXf4VMCg1dMSsQZJPqslwuTLsop9a6k
         ZCQw==
X-Gm-Message-State: AFuF++lmv+CyzBPMbNl+F+O0N8qThdpZRBTWpmZIKnpelCmC9yWVssvq
	jo/xaRIGq2kD05Kq8t7rnNw4YCsCO+/pxxvlnPsca/TfnbDGi/prua0dBgUxBytliYKmO68jkPk
	V3/MmY51A5YbIGBs48RBVHw9g/gQDwGIF5mZrRAheEXGc2/FZMYOZ0pbdDTSQcA==
X-Gm-Gg: AR+sD12ValRRH6HlL6qjuEc4C2v5HITqy3NgB0yWFv0TiBuHsj/a7Cx7Yf3bVBTkBA+
	t0+bk7l3pdTyUVtxkLZdPJYyFT0atAq9/EdBByQVoqL5pYvWu9pUZxe0AksXWmnv4kCCyick2Iv
	8rmtEdzMs6ZvkemULx9Owj7dp/bnqACl+Rg1jeOzvSX+vLzEUAUL+S7HEhqFIMySKIpWNjhdmnm
	MEBUv/SCSpXVBRc+YRI6Uv3yfp806RFvgg2RwBmZPlaC345YWv76dn2zERLcS7Le2KJEISj8xaP
	WUJOjhzq2uXW+5g41E3RoZ8PQTJp6rGPFaTpjHRZ2dCm6HIwd5rN9IZLqVW35w1FfuEnXTbZEHS
	Sr9eaQlpS8LX5ZdEZ2OR4dH7T5MHS+2Gl2WxVytuZwRMK5yRRT3805LwjpCBkarPvGHMXuBI=
X-Received: by 2002:a17:90b:4486:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-396d0a46cfemr6594504a91.0.1787916797389;
        Fri, 28 Aug 2026 04:33:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4486:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-396d0a46cfemr6594460a91.0.1787916796889;
        Fri, 28 Aug 2026 04:33:16 -0700 (PDT)
Received: from [10.133.33.99] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc07777sm2431868a91.12.2026.08.28.04.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 04:33:16 -0700 (PDT)
Message-ID: <014e71c4-dfc6-4085-ac71-3e7ac01f160b@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 19:33:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: sparc-us2e: fix frequency table index copy-paste
 error
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260828075649.2728795-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260828075649.2728795-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4kPH0Xj4ywMZG5eeKVANSzbLuyh4d1E7
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9171fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=A9UGcEbXNFXwkxVidG0A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 4kPH0Xj4ywMZG5eeKVANSzbLuyh4d1E7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX4PVs8B6STCiF
 MLdub4OROqg8J9jNp9vMfn2/G9iuTRnd3vfteZKMAg0FmKNMuZLmaGUFToPFrFPanMkbyMUDs4u
 jhTc8K9oJVoqHJkbsLkAhUdKs9yqYiY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX1lMYcHjLeNGm
 TGDScwSqnObLb9DVhvR9Qqg98duK/AHPwHdBG5bNq6lZv5RQeKVZSGlwTEW5sTx4Aon1X7zRhmz
 cFpxZGdJs6jWnDpLoKsMyLL0m/igvlBkxFoLBApTYC5G8jxZv9BELZYxBL3mDltoQoqp+pHQo8N
 9mu3G79SAy+RtY2IMEqJd08QNyEBKjsjog0YELWqWxSdeSNioVX61Ouo6P3lllQykl/1ucRhtx+
 hF46kOOqHeOy6eVOKbwm9VvXaEe7gs8EWiwn57t6gfs3xCe4St7PYoegQgrOqBmiV6eJLYXTHlO
 Hvn9s/jVUx/UnSm6vVzieQCLsLbUDOfLhqEol1HIJ3UPcVqqUt4gUee8zwCQ03BR/JEGPsjRwr5
 HYyb6+qF8M+ye5ALtagTXmkv7j/KugHDsYYIVZ/Uw1PBIdwvpryLzxZBUL3tXHWzekheqz2aMYF
 L1p1eYxD4lq12i0gKlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

On 8/28/2026 3:56 PM, Xueqin Luo wrote:
> In us2e_freq_cpu_init(), the last three writes to the frequency table
> all use index [2] instead of [2], [3], [4] respectively.  This is a

Nit: Should it be that "the last two frequency writes both use index
[2] instead of [3] and [4] respectively, and the terminator uses [3]
instead of [5]." ?


> copy-paste error where the index was not incremented, causing the
> divider-6 and divider-8 entries to overwrite the already-written
> divider-4 entry.
> 
> As a result, only three frequency steps (div 1, 2, and 8) are actually
> available to the cpufreq core, while the intended dividers 4 and 6 are

If the core passes the array index (2) to ->target_index(), and
index_to_divisor(2) is 4. so the real available div is 1,2,4?


> silently lost.  The struct us2e_freq_percpu_info::table[6] has room for
> 5 entries plus a terminator, matching the 5 hardware dividers.
> 
> Fix the indices so all five frequency steps are correctly populated:
> table[0]=div1, table[1]=div2, table[2]=div4, table[3]=div6,
> table[4]=div8, table[5]=TABLE_END.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>   drivers/cpufreq/sparc-us2e-cpufreq.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index a68706406b88..5cda391ad03b 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -282,12 +282,11 @@ static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
>   	table[1].frequency = clock_tick / 2;
>   	table[2].driver_data = 2;
>   	table[2].frequency = clock_tick / 4;
> -	table[2].driver_data = 3;
> -	table[2].frequency = clock_tick / 6;
> -	table[2].driver_data = 4;
> -	table[2].frequency = clock_tick / 8;
> -	table[2].driver_data = 5;
> -	table[3].frequency = CPUFREQ_TABLE_END;
> +	table[3].driver_data = 3;
> +	table[3].frequency = clock_tick / 6;
> +	table[4].driver_data = 4;
> +	table[4].frequency = clock_tick / 8;
> +	table[5].frequency = CPUFREQ_TABLE_END;
>   
>   	policy->cpuinfo.transition_latency = 0;
>   	policy->cur = clock_tick;


-- 
Thx and BRs,
Zhongqiu Han
