Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522446EC86
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935062; cv=none; b=FQyCFPT+sWhaR1wFxYtv4Ig8WuvqFaVbw3Q2kjAqo92n7z9ZSaYvaXwKNpocvKl6ngLwN2Tq1d/nb3Q5rKWlgzWhP9rs6MDhh0e9GlocWEZKUdVmFjR7Pq1Yw33CKPuv2QLqjXMBJXjovyzfcsEraOfvDguoOSq+DLQbHJwN5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935062; c=relaxed/simple;
	bh=bEf2TdxqrsfETQHTsqCcWujzWjSGMWByaj6TVgxXCMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKeqfAdtUFLbxF+WbzfQ8HI63JjoU4wCSHFVJ8ECNJpz5ahJq6mJgT2zyzRIArPG4ZGM9+3sAnoTnNjEbsSga2Jx8oFEFsE781zwV8LwbaLLmHdziI2JtSoFwHAaRufPjEApEcH/AxIMQeKv+rhDb654y26e7hGoalY/nTf6ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHgzt1cf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kJyuyVs0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHgzt1cf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJyuyVs0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675BvM0n2165173
	for <linux-pm@vger.kernel.org>; Wed, 5 Aug 2026 13:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=; b=dHgzt1cfWHKULlsv
	wZNznNeUUj+QTA2jU2koJnxoYfOrQk6fTQ8eYgR2Bcc/HqssWU1Q5FneXuJKV6Nt
	X6a14+Ox1dVFT/nB3M15SW5l5i2ZMAmU3oQDwPN6dRJT+LU3ZlZzlifl8+/m6lx2
	gV2xoSg767IzpEVjMlncAcNhJ+UOamZTaEvpYbCA/e0TvDsbRdulhJC97KfkGjYf
	D+AflNg7C/gAHawHpLeYiIoY7nqj8lQO1bDVtXonra5nXp3dx4TaMK//ae3lFGGG
	AeND3Jb67jRMoqKk7KiufgQWsTefISdSkYwjfUAIZ/LWlSZB6ZFQbRfoP19nMXnD
	DPydkA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuwbqt7hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 13:04:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1519795a12.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785935056; x=1786539856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=;
        b=kJyuyVs09PoeHrTVgT3C3As4p9WFdk8Dx9eH8LGE8hgntdEJ0xVOh1CPkbYgXcdHy1
         7Ci0F8jrCTUPtg9jyH9xaEuHD53hTtA1RpOS1ydKZ7ipmM6DISfLJIIw44YN9ier+vPV
         Nrs919AORa7Q/Hgf1k2s/VT/CB8qSstpdFcIB0V/yljNeYxLLjghHeZRZ03Q1CM9dH2M
         dlffANsSdXVoZrobKeWPsV3/9jHJ2z0PK3qSCU6sCvv9/hA50FvYXe3GFAcDu+VIHmEU
         USkpWNXs2dT1ZVfketX7FkUjMudKP3zdXa0Ir93cvzbMiW5bYssu4lLxEuNucco+gLVm
         97Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935056; x=1786539856;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tO4+RAdzUgSn/0bwqvyhspSzxA4rGtcmvR6GRlgszg=;
        b=OUzM1wcK8Fx4SD97yJCW473CgZQ9u0HNfqjw8J17y3CBUP2L2EuMVgz7/1Zr8FM/7K
         pj/rDM7a1I7Ua38PwmZkSJuHiJO1QvOBuWLuydYlmYx+EAJ32znROXAxoewmSr+VQfqm
         27y0T24HxQGS6SumbozUluqIoSS8DzM55/PREQSkdT28THjqKpaW09MnILnQLUu/3W6e
         k6zdxQcN3z3WWCok5yaZiJ1xnW/5W6ZOV1aEoUGougjBLddLgM3aTMHd35DiE7ZITjNK
         eTh2vVLAQXXNXXiq4/6pHHNAWrO+w1wIKMXGl2ecg+hgJwet+642W878QbIH+OHZp6M2
         oEdw==
X-Gm-Message-State: AOJu0YyglQVabJo7LMdwO1gLlqS2bHnWguUEpnpYx/Q3VUKElbZ54RdB
	iImGM1x013s2JhcSnGsE9p+jOMpPLoLDUgpFIxGEAyv7yAVxFE6Q76uc+6DX9rYlKk8flvUhjpn
	WIEuh5IGmbv/EGo4505Yb0d05eTO9RQBpkySQ4eNz7aFDHsOLqlsK9ncV08YmbA==
X-Gm-Gg: AR+sD10KAJDp3AL+5+Yk+MDy6nhLMRiN2jNBA6IdCM9/KeoEypDjIJZi2CxpmgQu/oI
	81EtqssRKN+Rj4pe32pxvYG3YeEIBmHdQjE4/YkOSo6hD+jOHU39xK2l1etNuZDqRIcewEfoS2B
	nzHfs9xlJoxpFtZ+yPr3yKxyC4vTEsbnMTO/hQpv9mXfYGY48KpNDvqR3l2c9YTPATRG80JMGCk
	pmvhLk0yqC1KfKkoEH+KDEophCH+CPo89gAn08PLbKGZW/3FFaR+yThT9B98GsFlHts9dBOHGSl
	lDvEm9glJa4SbkVpN/y2eMFQu7ZOYtg1SVI47viI1nR9SSOj/qXTYsBdwSCk+q6fKUxYSFYTaxM
	fS49SctIzezoGQnaryRjuVxh6aM5t8SJ72M7UE6YLNY/EhrWdHHbsm/Rj/5z2BXWylOmE7q7p
X-Received: by 2002:a05:6a00:2e11:b0:845:4888:74c5 with SMTP id d2e1a72fcca58-84f2e01746dmr7039489b3a.23.1785935056265;
        Wed, 05 Aug 2026 06:04:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e11:b0:845:4888:74c5 with SMTP id d2e1a72fcca58-84f2e01746dmr7039396b3a.23.1785935055669;
        Wed, 05 Aug 2026 06:04:15 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2c6145sm831463b3a.12.2026.08.05.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 06:04:15 -0700 (PDT)
Message-ID: <1a89f834-93f3-4741-9979-39570af397af@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 21:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Avoid unnecessary reads for full-width
 writes
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Lifeng Zheng <zhenglifeng1@huawei.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20260803210527.1285229-1-christian.loehle@arm.com>
 <20260803210527.1285229-2-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260803210527.1285229-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fYSlZXzeuUlK7CC1QdI0isHGmyd4bifm
X-Authority-Analysis: v=2.4 cv=B+uJFutM c=1 sm=1 tr=0 ts=6a7334d1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=CXDJWAA9LoG17zI0-BsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: fYSlZXzeuUlK7CC1QdI0isHGmyd4bifm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX5qb28xCsn6wa
 +AElpWeYK0avcktyINk5oSMv9osN49VMJqC9lbCmNZjLwcd07tOwv5E56PzoacejHkXDgJ9+14J
 fuuFzbzP/uz1obvBb12y6C+0MEm6qSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX/fSSKf5gDNVT
 1BMU68XN7T72QZyhvzkhqtVLsG3rmEGW6pZMno/7IelzspB0bwyw4uHY0GTUJ3n0HxdPImfoqb0
 XXAIqOz8VZ9LhVagXkZ9OFpj7NdFzUv16wfYAQmMzrbQAKoyl8SgEuyY1xBRsn6jK0MynjKcTn2
 M0uh4bf/j58YIm+Fg/5UhCl2RhDNs2kRbrCj3sKxQKQv/7/fEPEAdavHBi+X7bJXP7oHTmd5YSm
 e2tbGjiOHVBz/hbLz0W/OmvSc5KdXdJNqFP8YKRnRTCjPVtj4X+VNK0+E2IXJ1YhW6BDh0BAX3Q
 veZswvyYtPBTHynahxeKcQB8rWvY1Q1i+o6pTJ3+tXav1FJDcsCUIyMXVD0QOInj1v8lJG2TB9v
 iouLkfaSDgxdu7D2j21q4zdAWjZJFGsq4wYzdknXaFuLPpzJZQ4NjUSW7kWacxEhIHnsaj9upJ5
 DbQ7/co3RfGxaoxoy4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050105

On 8/4/2026 5:05 AM, Christian Loehle wrote:
> SystemMemory GAS entries may describe a field within a wider access
> unit, so cpc_write() reads the access unit before updating the field to
> preserve the surrounding bits. It also does this when the field covers
> the complete access unit.
> 
> When the bit offset is zero and the register bit width equals the
> resolved access width, the previous value cannot affect the result. Skip
> the MMIO read and mask operation in that case. Retain rmw_lock because
> another entry in the same _CPC package may share the access unit.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Nice optimization. Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..9b8d68b44ea9 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1162,25 +1162,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   			return -ENODEV;
>   		}
>   
> +		/*
> +		 * Only partial fields need the previous contents to preserve bits
> +		 * outside the field. Keep serializing full-width writes because
> +		 * another _CPC entry may share the access unit and require RMW.
> +		 */
>   		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
> -		switch (size) {
> -		case 8:
> -			prev_val = readb_relaxed(vaddr);
> -			break;
> -		case 16:
> -			prev_val = readw_relaxed(vaddr);
> -			break;
> -		case 32:
> -			prev_val = readl_relaxed(vaddr);
> -			break;
> -		case 64:
> -			prev_val = readq_relaxed(vaddr);
> -			break;
> -		default:
> -			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
> -			return -EFAULT;
> +
> +		if (reg->bit_offset || reg->bit_width != size) {
> +			switch (size) {
> +			case 8:
> +				prev_val = readb_relaxed(vaddr);
> +				break;
> +			case 16:
> +				prev_val = readw_relaxed(vaddr);
> +				break;
> +			case 32:
> +				prev_val = readl_relaxed(vaddr);
> +				break;
> +			case 64:
> +				prev_val = readq_relaxed(vaddr);
> +				break;
> +			default:
> +				raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock,
> +							   flags);
> +				return -EFAULT;
> +			}
> +			val = MASK_VAL_WRITE(reg, prev_val, val);
>   		}
> -		val = MASK_VAL_WRITE(reg, prev_val, val);
>   	}
>   
>   	switch (size) {


-- 
Thx and BRs,
Zhongqiu Han
