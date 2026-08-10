Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55503DA7EE
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364150; cv=none; b=LwIhKG9k1kjqp3R4eL/T+1VHbEFB29+xm/EPSxpD83pbAR1w/78+BO+ceMOoOmw5R+czeqwtkYSIkzLT/i6fRyOJnW0jCEKfim8j73+baRwMvfFf+icXRx6TETzHY2e+8KYYDh/ZsW/dwJORT6GDCYipoRBdOqRd5ZsBLRWxOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364150; c=relaxed/simple;
	bh=pxualnNlmo7YthKcXIIvriepZ/5ljp8QuHSHQiHYqO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iS/t5lZP5BiL3G0lBDGdZ5q7g44iLUprIO7Q7MugGglfTCYims3bl2NPK/HgiPCxl99nHeIokFazdFcUsDbTBHCxHRFiGpLyVllv4GQVtCX/C8YwAyNOHyi81QTZLKEBBNWnK1OPBpZfKTt9BLcoRkjx/f8FM6c9VXqOrgwpZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjB47tlO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKYm7SJv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjB47tlO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKYm7SJv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9RxAV872426
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 12:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5/uSnkWrBqhnPOKlandBmdCcng880qvU9W4Z1j8HbI=; b=hjB47tlOABVwefmI
	99o91r1Ogy/n1kJeu00Fq5Q/3cJVNfdfFhjob16TSK36/qBkqwo05Dg0SKVDyAr8
	Pfxh4Y+23qVgEfWVgwvAz1RvDZstofgfAWecbJFBpGoanCp0tLLLp7zmB9188IFH
	SVOA8hTzd+6NYp9pcC97KsA15IyF6P8aqSgPH6faz4u4J4d+XxwbOAAvN+pWCdzx
	sN4/Lxi0dN4YwIIptffLpWb7wQJeA1zWSPa1OEpcTbqa4clakunvNewnpa4v9zwd
	8sB8KrBk5yzehY4Uw7M4xHTvp4/QFurQlHBfTCbSMzwwNpe2+AFEkGopMNUiFPJR
	H3T8yQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v59d7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 12:15:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fcaa5f82cso1911519a91.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786364148; x=1786968948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5/uSnkWrBqhnPOKlandBmdCcng880qvU9W4Z1j8HbI=;
        b=AKYm7SJvZd/btsV5f7lj6Ptz0nUKugHJWRS1jd7EBP3wDSwnSyonPnD96dylMqbzQL
         /2CE+lIpKORSR4m68oczlSepaKeGNfgHG0VnRJJairZJ9EvKu6dfHGixscQu0NjJ8K8q
         oS+AUYcfiobGiBK11I3fgNjQVSXOGiGAMcMTOrYzgsPbyZgcaO4b4R+iz/ZpnobpqCsb
         zP8D0/5PPFEilws/yKJc95m78Qk/gjQGXmnH+c5dXcGLXnofPOxZecKQcmES+fmJ2AIP
         u9CN0w5IWHw5ueF3aYyb5rrNyaRWNiCsNW6+peU9LlPf3cijehE7pR07KOMLP2rxOX0D
         aZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786364148; x=1786968948;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5/uSnkWrBqhnPOKlandBmdCcng880qvU9W4Z1j8HbI=;
        b=dhCSvkqcz7RcONd4zADZexQi6AMcnBEBaM4kNNcSECMGTSyYNJvraijNLXNz2XSKiO
         eUvHDt1ehBX/tDhXYMJZRsJVIr4iiM8DWEas8HET2m+IXfqMNGg6uLBfoWhxPVZfh7oj
         YwiYuVPti+wuUAoFQYX5Gb8r/TIPW5BY7i3/S2ZO8R8UGol9yjcmiES/urN9vdhdASh5
         6Z2cRu43GcEkPdYA1frEAahUsps21qFA+Uhfy7CwuYKvgrQWCjKuIDAH+EuD8oiHxuOy
         WxTxJ9Ed4eC7iFBU3ygr+GM9jh7KY3FFnpgLfW1GhFFs6A4/1U197UczUzQ7IQZttddM
         58QA==
X-Forwarded-Encrypted: i=1; AHgh+RrWV18k6iynYmY3UP74RMiNGEjZzMVbvTl7k2EFIW9/LiKqzC436futpnCHT0WKlW5C/NZ9FDw2FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxocPVp4+R4vfWLorxrBpkdklvucyUdfR7gXkv1vfMqizwiQe2S
	grNCPCPAD7IDfinCe6F3Ve/ywoAgVVuuvUZaPGmzt5QjHHLm3f8pQ8IRzasUHQwkmfocOPp4UV1
	IOFrxiDuPu/CPW0qbW6L3EPq5ux41v18u7fshWJItDFJBoYAftePHLuBPqaObfQ==
X-Gm-Gg: AR+sD10N/XSCyZP5pyuUqojvfmllY9SIu2RTIpPGRjubLsYWTQlisSHvlwzPOHUTBxs
	k5yfqtAB0CwcKUfDzsWphRiYwDFviW3FvyfoT2mwaOEsd2AICa9zWrBTXg4Vp1y4p52eYCZRdju
	NNxxHxx4U3NmD0ViQ36a9CT5TjQ1iw2XEChkGvpgitfkhVdXHJ2XGkQxQKdRQPZ65+qN65laFSi
	3RN7lvTrK8iy0tRqJHdGzILxhol1YjqFCp4d0vCKAkPfMH/8jVih9fvLHM5WAdGh6WFJYSl0/VK
	Q/qdPPT5lFWubbkI6CZj2tgLpRtofvQQXYaiinWk+EsxZsjCVoeyP+9+nKdl6+fSr+bi+jz4z/M
	fWZjbvx1M4qLWdi0md5gJ645LI4QKEA==
X-Received: by 2002:a17:90b:51ca:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-392cc912a89mr1098555a91.4.1786364147591;
        Mon, 10 Aug 2026 05:15:47 -0700 (PDT)
X-Received: by 2002:a17:90b:51ca:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-392cc912a89mr1098497a91.4.1786364147144;
        Mon, 10 Aug 2026 05:15:47 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6f13dsm12428530a91.1.2026.08.10.05.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 05:15:46 -0700 (PDT)
Message-ID: <ebc24dce-c17d-43bb-9c36-b105f4e1d55d@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 20:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: Initialize cmd.val in drv_read()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20260810061045.2397-1-lirongqing@baidu.com>
 <20260810061045.2397-2-lirongqing@baidu.com>
Content-Language: en-US
Cc: zhongqiu.han@oss.qualcomm.com
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260810061045.2397-2-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNCBTYWx0ZWRfX2ex6R+3l+4vs
 dC8eyeVWdwLMUbfYdhdJ/lFalD+OFhQiGTiZBRTXFP5r1LX4EIb8H7A+x31xBqZN6nzXXKX9Oj9
 11C/69ctg/Gkzq3R6VB+Q9g31bsfMmI=
X-Authority-Analysis: v=2.4 cv=J6qaKgnS c=1 sm=1 tr=0 ts=6a79c0f4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=2QSLavsyAAAA:8 a=zuLzuavZAAAA:8 a=hP-e37SESAiXYNlssCwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=9H_80fVQ3bbXSWzY4Kdq:22
X-Proofpoint-GUID: X6ZC0y0JGj-xg0PnpgYhqIVGGqF8L4g5
X-Proofpoint-ORIG-GUID: X6ZC0y0JGj-xg0PnpgYhqIVGGqF8L4g5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNCBTYWx0ZWRfX5pry04f+Rx0t
 mFCDvsmFjk+AiRHy//OASVdRroxqqK18Cq3oMb/up752FC9RsPzTYABYMN+8PxW0aTBFYSzV+w1
 VZ+hMcj23BjnNNoTUVCw9iZS4f3G68daYBH6d6+Nps/Bz/k6M8U8pz6x3DYUKphNtmHJfd2G1bX
 6twW0LJtpsvXOzXHUXYynh7yYEWnO1K6cdTNu8Tc8Osp8VnFu9FBobWLzM4CfucC03eZHhuUAPt
 gt71fDS/eA6oCK0WHDpYd0c4rJsxJ+WKyjSnl3fxdPeZuBH24+YkV+x9vx90p9MoVmzP9ZSKmAy
 6zMkLyFDV6MfT07fr9aCGtDGsbpARp/rXoElTGtu7LD6u3ggETHJbZR1BiebK9C25y/nfCa+AiR
 0N2p52giUh8HNL7HzHJpHNHbsa1Q8JHEeIi5oDSzws+JSp5l8DHlvBGjuRu27QMH4kAc+7G+6Q1
 VhSrmqc/t0AQf7U3D9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100104

On 8/10/2026 2:10 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In drv_read(), struct drv_cmd cmd is allocated on the stack with .val left
> uninitialized. If smp_call_function_any() fails, do_drv_read() will not
> run to populate cmd.val. As a result, drv_read() would return uninitialized
> stack data.
> 
> Fix this by explicitly initializing .val to 0 when declaring cmd.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index cd2ca87..6c7ece9 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -308,6 +308,7 @@ static u32 drv_read(struct acpi_cpufreq_data *data, const struct cpumask *mask)
>   	struct acpi_processor_performance *perf = to_perf_data(data);
>   	struct drv_cmd cmd = {
>   		.reg = &perf->control_register,
> +		.val = 0,

Will the compiler handle this automatically?

https://en.cppreference.com/c/language/initialization


>   		.func.read = data->cpu_freq_read,
>   	};
>   	int err;


-- 
Thx and BRs,
Zhongqiu Han
