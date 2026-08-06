Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13C3D79FD
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997078; cv=none; b=BsiDk4jBl0pV3jWCvT5by0jX/YXV10oe1GEG9eUIyRUKpL62XTptLfjBOogOhseKjHhcIJdoiVBaszi7xoA08EjOCvWxHwF+bHME0wZpz07XrH9TuEyZBPvTeEbCGn+TrhTKBDRaqyvS1munMT5gPcoYWZeHUsjcCxQ3HCunjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997078; c=relaxed/simple;
	bh=WOuEJhvl2qrZtKj8atfAzb7IYB3fO5C9klrW+kllfPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGtCSfw1m3oq1ZGO8/Vui5pvnoiaG4FkV3HFPm2uHcBaToTE8FYCR1jCHIWNQ3D/IO7ATotkIH+kgClNEjDBbM8Q8Slb/sS1tuujcOslC5nzF59DtVY/ywoUyhBLKt0/4uAVdzDkMEGcwnV1OdHgQa8sVq0f501YXTURDw8/lAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJdBvNuj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y6W1kPUh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJdBvNuj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6W1kPUh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nb31R4063346
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 06:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=; b=ZJdBvNujW1YPC9SP
	TeNgu5issziDmsY+bgXEto/Xd/gOoKEj3Q0T8IFTF9Xq5fi/2khpomO78t56wTaS
	jfDh2GmJ50iSQS3U1EooboYEUL/XR2wv0grPCXUYWE5MKuH2GKQsIVMmEZDhtR+t
	fyS5VO8Iepm1gl+Qkl0UcMEOZ3DoPySsWTOmlDm0cehJmw+rmNHtSpwSQbTrHYEe
	tAGL2w8ypOYwzNLFjoS1chFUKWUTx3PtwWnsaK6VsbTy05rYmxCDaWxdVyVjKr7I
	dWySKX93xR/7yxaWhBofRyyuUeCJYsFoaFjbQkXq/a2yedIJhC6T9dJeBe1WMWbK
	1/Skvw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5kvpp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 06:17:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848544a8496so2123723b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785997075; x=1786601875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=;
        b=Y6W1kPUhwMueIs5IXgsEi5Ex2CT1vWTJwHE51Z3u5g9vcSfN/Urn18H1fmOLgmqjMR
         IWRLPYXjfrJvZ6ak987iIKfmBDrTvvz5YG+Ul2+fRJF+CTzUMQ88fAF0wpgy5wcaFsIQ
         /J9DkgoFbc2dmo95VNzX29C07OVM8hnhyFcEKpMcSzlEVYcyJzQhNgdGFEL2XrO/egaF
         Sv3ax1vMXhZntdMGzfOqR/Gmjt2u6LsA2EHMYkpZV1qIwcb6XBIIT871tA3aB9l6UoDC
         NZWfJEyM3Q1xcYoJW8LdClCriUFx4DJGnSpbLsaK4u6pPArLQKSNBJshydfT0/FNhHdY
         I3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997075; x=1786601875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWoOi9kfJdwN9ldzBQDFhMJIGe4x9Biq0zX9zwnu+28=;
        b=ktyB5Xh1AB3IGxZAUOW2aOG9Cwrc4YQ/onMIOxwljpaPZMgDEX/A6O62ttfRnzl+vI
         iiDu4q2xGMGhgCUsqNFBS/8spIbggiiuIr8M29GdNcCH1dHzyNMZDDkG7lNWZEniv0L/
         VZFEctnknKsnqXVRHQjRW2STwihgF7phuULMFrTeCN29JPVFG84NepU2RTv4X5nz+Xwz
         S4LdvWysFRqdfajGdtX2cPWBn7O3o3URb1W5c2gYBSMzaibtEuVGLLCY2mqg3GmUuEr2
         3bCgs8zK1/JXqdu6cwJw3nankPyEOWbWmpmhzuk1IKeO2I78iUbQRogFDrLKEAlpUeAH
         C1KA==
X-Gm-Message-State: AOJu0YwPAivLl4iIIVXWd3WxYurxsd27Kj80hT2oSLg8po5wIB7alKBJ
	4/8IIjoX48xiQW9NuG8FqDTa9E46ivuS1jmxqL0HOo+jrupCKTscWRJvUxYV2DMNlLnT4x98koj
	++3eITY5ZxL2sAR6roxXd2UFStwKiBmLwlXsW8k8kOZFNsZRM3IvizZ5/X3+kOw==
X-Gm-Gg: AR+sD12yZQfUaMD5f2F4G8oZwBiQmLmhQer6SWFTxOHaeHLSWCLlh6fAyHqT5ZezC6c
	ItrB1qTLeRB08uAlU/YJS4gQ7Ik7+ycmbg216X90AHVezNV9tysMg5Hll6Rs9HEdw8veuWvCPf0
	kcApEasPLmk+WVW114uhUCStBlLkGke7UZ/00d7dpKQkVkuCxcXysjdY7APuaz4ABC/sWvnLm2t
	Z8zBTUjShxXLwpGWoYFBFXUKzLCP0u7UdFPQT3bkaXgFnl6oLB3DtAdx70DcSzUTHuS97LMUaZg
	oQPcdj7uA60jfE3vkqTYUkDf3bHaVYAr9oDsqxeEqvzWir+6pKRp0CAIJ6pwlq0EWJrJdzUB5DK
	Tt7FCiLX5RJZsaAVth6eOLI8aCdpMSOeK8pVd0W3g6wjeG7PGMDJ7/WNa0JL34v5XcPgIL7Gj
X-Received: by 2002:a05:6a00:12d0:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84f2e006b31mr12828326b3a.19.1785997075233;
        Wed, 05 Aug 2026 23:17:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d0:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84f2e006b31mr12828302b3a.19.1785997074774;
        Wed, 05 Aug 2026 23:17:54 -0700 (PDT)
Received: from [10.133.33.183] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b2688sm664295b3a.22.2026.08.05.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 23:17:54 -0700 (PDT)
Message-ID: <4606a5b1-dc38-4af0-8244-0b84d5bc4322@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 14:17:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Fix rate limit overflow
To: Hui Su <sh_def@163.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260805143942.805176-1-sh_def@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260805143942.805176-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA0NiBTYWx0ZWRfX59YV45xKqjwd
 cwJEybBidnJwiNs2as0pOvHwOW8aSZjNbglcUYmVsZKBDvF7A/Ecwn/+aF+PIIzxATul1ULz4fE
 cr2iwGt5XMXViI8A7SnjHYqaiiDpFzy036p6wl5njklt47YYcNCmVHjeu65Hskkl3/Gaqbw6uhn
 l0qzxcAmBcoCUlBwXd8GTU+8CCNdl5JQwaM+WTrZGSci77M/+Do2dNWKJQj2xShx3IoJTDdoi7i
 +lR4gNJr+0thIGXt0EXd81tzKIEGfjk+99qAxLOkJ1tEcm71ajZpYYCz0xSYtO1pckCCNyTnqbJ
 yFDfaeve6T+FYFpSxTJSAYbQ5F1aaDpSptxE4N7gFxba/IYu98U9oYKnclnafNjE7why/vmfdR1
 pUsmSpvRg3ttIyZGEDIZbB1iSqA+C7cTICcasuwI4gxqpLoCHOc5Vklv5e8scPJqA4qgViGg2Mt
 V4Bi21djNw3hMlh+k8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA0NiBTYWx0ZWRfX9mWJz3nqmryf
 fGK8EiQ7pB2frgqr5mWzEW4pkHULMl3Q/oQkJ/hatXwtLJDbeIA9QbTvuvuiM8P5Ikl7JV/LXiZ
 v5qLvyfYE0cjQK9SJg35Fq99q7THeNM=
X-Proofpoint-GUID: jMoWEBCEYXcj9acpCK4z9ib1_bm8VDB6
X-Authority-Analysis: v=2.4 cv=cIbQdFeN c=1 sm=1 tr=0 ts=6a742714 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=baNAD00l4KdnJNx0rl8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: jMoWEBCEYXcj9acpCK4z9ib1_bm8VDB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060046

On 8/5/2026 10:39 PM, Hui Su wrote:
> rate_limit_us is unsigned int. On 32-bit systems, multiplying it by
> NSEC_PER_USEC is therefore carried out in 32-bit arithmetic before

The real issue is that NSEC_PER_USEC is a long, which is only 32 bits on
32-bit systems. By contrast, unsigned int is 32 bits on both 32-bit and
64-bit platforms.

> the result is assigned to freq_update_delay_ns.
> 
> For example, writing 4294968 to rate_limit_us wraps the delay from
> 4294968000 ns to 704 ns. This makes schedutil update far more often
> than configured.
> 
> Add sugov_update_rate_limit_us() to widen the value to u64 before
> converting units. Use it when updating the tunable through sysfs and
> when starting the governor, so both paths set the same valid delay.
> 
> Fixes: 9bdcb44e391d ("cpufreq: schedutil: New governor based on scheduler utilization data")
> Signed-off-by: Hui Su <sh_def@163.com>
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index dff4ee04694c2b90301ed0fa158a509a3423cee1..8bf7a2c34b9f200d8f5776205ea2a7f495e04e69 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>   
>   /************************ Governor internals ***********************/
>   
> +static void sugov_update_rate_limit_us(struct sugov_policy *sg_policy)
> +{
> +	sg_policy->freq_update_delay_ns =
> +		(u64)sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;

Small nit: better to use (s64) to match the type of
freq_update_delay_ns.

Besides, sashiko report one torn read issue,
https://sashiko.dev/#/patchset/20260805143942.805176-1-sh_def%40163.com

On 32-bit systems, the torn-read mechanism itself is pre-existing and
not introduced by this patch. However, this patch does change
its impact: the main difference is that, prior to this patch, the upper
32 bits were effectively always zero. After this change, a previously
written large value(In practice, configuring rate_limit_us to a
very large value, especially one exceeding 4,294,968 us (about 4.29
seconds), is neither reasonable nor common.) may leave non zero upper 32
bits, allowing sugov_should_update_freq() to theoretically observe a
mixed value (old upper 32 bits + new lower 32 bits) and temporarily
treat freq_update_delay_ns as much larger than intended. This could
cause one frequency update to be skipped, but since
cpufreq_update_util() runs in a hot path, the next invocation would be
expected to observe the correct value. Using atomic64 or a lock on this
hot path would be more costly than it's worth. Based on that, I think we
can keep this torn read as is. Please correct me if anyone disagrees.

With the commit log updated,

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> +}
> +
>   static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>   {
>   	s64 delta_ns;
> @@ -606,7 +612,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>   	tunables->rate_limit_us = rate_limit_us;
>   
>   	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
> -		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
> +		sugov_update_rate_limit_us(sg_policy);
>   
>   	return count;
>   }
> @@ -848,7 +854,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>   	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
>   	unsigned int cpu;
>   
> -	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
> +	sugov_update_rate_limit_us(sg_policy);
>   	sg_policy->last_freq_update_time	= 0;
>   	sg_policy->next_freq			= 0;
>   	sg_policy->work_in_progress		= false;


-- 
Thx and BRs,
Zhongqiu Han
