Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750905;
	b=Bv25vZ+rV3rYCbvWXyDWNCWIlTDQlIl6Beo9j6DSFmRjo31BJuVdACmrNlsRW8KEYyhl
	 LmSq/ZJxj+FnLhr7OhFezAYMcj2Yr1DaGrglCeWtjjvmBjfRNPHznHb9zgRbT7j2vNqmR
	 gxdbnjPy8OXuHBEManvNHKsTdXllW45SIXM3KSr7s/J3yOjV9tuuUIyh6c0yEApxZOr9a
	 w/P+5EkZtyBrascuiEwCkBnpulDjXu3P3kmc/npqUeCeiJ9JSLG/EJGJv4zA2NHDKte1B
	 U8UaBrrCcZFBa1OQC5/UFh69gLcoOtoIxSj9khNhnljEbaUkJKBW+tI1RxeHmKhuNHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=j/B7u+aLU4cptfM/G8VwPhJ6v2wabYzrEeZVFO6+qug=;
	b=b4PFgnycy1j3sCf80w20ki5la3UeJ5B/ju997U8UjsnqdJZpHOIpAdP+tBeqP+jLHG/l
	 06OlGNenvV1P1zDh6XKL+iSfdZpPp4e2TzXJlSliMlD5JKfHY0bbuOBpYOSaSWK126S6K
	 bru4q/e6MkVT9/Ldr5WALKqprZ9oo8FcDjNOR47M2wnCbe0iE9hIHEtsN34jBpQWc0sT9
	 7RPr90JsZYL0x8F4N6J3efBQQLrIx+Fyw3PaDi9+/NRpLivXdZTYlmO1rF7nPQSFNpNmj
	 fuFfiEdLLOIUvE+wCSSEvOQVf5eImGnXTQzAoZcJW358wZ2mIVGo5Qg2IqigL9E6abg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cUi8MYUy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GEq7IxF/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94241606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94241606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cUi8MYUy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GEq7IxF/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQJx6dJ1713402
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j/B7u+aLU4cptfM/G8VwPhJ6v2wabYzrEeZVFO6+qug=; b=cUi8MYUyahB/zYqd
	N9dp/3YJmTKq3AKc8fxj/MkyYFRoAhM3d5utDPc+8w9Kg17q9a5yuH4bILXfzNbT
	SzhIHWQ5H8ArcycrViUQu6hqQs5igD0enxVKGmV5DpqtpuAeMEq1pIX+D9KswfeV
	vqoRopMjfCNBQHtrfi5T/r8pTPNUqGTjuWd8Xn4vkK424Ir6NlOr39XUAdVbTEdI
	fFC7I1QnshtpPoTeGiX+Rd7TbeQ65rQI+6XvoRxUAM4K7rTox8Ay9z4ZNwY31UBi
	W5ewkrAti91wI3yl91sN7+Yxh05thvo4xMDFYJWrPP3DKRv/IHCuet+SuxTDbm52
	hSXy1A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne3ceu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:41:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso5581781a91.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 19:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795750902; x=1796355702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/B7u+aLU4cptfM/G8VwPhJ6v2wabYzrEeZVFO6+qug=;
        b=GEq7IxF/TKAa44CyOf0A8Sp1pvpQ//GiK+keelbZUZBv9kmH5hyzfw7oxA5Zsz33NT
         s/IQAiIIfiMDcc8vvJ1Mqj5+8CHf7aX+pD1qgwDbT54OD+U7tTMkWogtkW2mhm9d1BGU
         un8eg+ITKe3slgTs5gzNZ+clvbp2ZVKSIeKNue7vtE9AsB6CnkAsDK3gyCjSsBHIb0GZ
         Yj9W5kK4656yQZFPVQoSQ4X8SmJpvbSiKhnOTunx4OHY5hO4dqH79XkxcwmiA8XajgNi
         30wh/GduXmBjz2laCa33U8VAu1PTEno77Te3vdzUPnEWesHeIeP2lngA2kHf85ywHlho
         +N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795750902; x=1796355702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/B7u+aLU4cptfM/G8VwPhJ6v2wabYzrEeZVFO6+qug=;
        b=Cs8dyp9/Mh9dx5HkJNB8YwvYFC7p7vEkrN+mf+wMeHqloNalYm2+zhGl+uAe15im38
         EGi+ez+JM9Uy9LfFoC0vRjxVn4b7LmB1ulQEFpUOvZBUtzo/9PVpF5ex7QSVPMynh0zQ
         PcCxpUDpZ+gpsn4CENi+hApTxTbYmvk6RocQlQc5wmTAI1SbTQd3jpmsLidqEMvFHhbK
         hdlIb+1q3oso16XBK/nO4sMHsGaAvjVYcfTxqHF897Qd5UHMn5ta71OUQIT2qJNIeJOP
         IbGh2mjBHkf/uwUgzIC5AL4uyiJjYTQ1OFfmbS9Wj4zHop6ADceC4Gl/QCoszZuYDYRL
         HNlw==
X-Gm-Message-State: APuU4Z/fKoh7N1myRY9arV8GNtSyD2Ds/2uZU01MhXLNRMsIMu4hvQTy
	z56kyWgd663a08NYZWY5GotVVazBReJuSGMyOJgU9UUbHesouk4LmnpaGrhawkKo17P4vd+61co
	hDnqir+VlTrngXKFmg1V1DvykjpDxP2xodfvQou1gaJZDrx7cNC5pFm7H27pxJA==
X-Gm-Gg: AZFdTZe46iKzmVp3skJE7Vn7r2Lj9blD7aBv8Et4CprBp9COP+LLJdvZDxHBm3h6lx+
	ftYEM7W+q3lSj/FhbF25fPDvPTXShKlT5dFfW7e5vzvjlSXpaNDmkMHpw+qy+ghkh1MP82QArPY
	vwQbtPZOTpzhDysahhQsSa+k6UMPX0em/kQ3lCmeDe2TM2BHDRg6qBQ/kNSyguY0sescezENmIA
	pT7AiCozDlgqVgQqgak7qADtnF4srkHP5/Q6p/ZcnytIAV+SOgc775O8kdZIPsrAj4Avw6u/ydZ
	xmm12tNRDDkvfsCYtmyFs/xv5862Ig2jJk2/I2VVEbgxd+CmMXtBc4eKbzpILBp6Y0z+JrG5+Qj
	zmHKZ/KwS5bmla3qBqlWJh0hBO9Q65n/m4FQT17iMC7J6lwBqj2mWEDWHxEFFwNZIOUg85jSNLj
	Au8NLYu9981QhY2t614MiJkc/Q85herPaZjgX9LL3flaGt
X-Received: by 2002:a17:90b:1d03:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3b41c8ff729mr22806062a91.14.1795750902028;
        Thu, 26 Nov 2026 19:41:42 -0800 (PST)
X-Received: by 2002:a17:90b:1d03:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3b41c8ff729mr22806040a91.14.1795750901537;
        Thu, 26 Nov 2026 19:41:41 -0800 (PST)
Received: from [10.133.33.190] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm36441127a91.6.2026.11.26.19.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 19:41:41 -0800 (PST)
Message-ID: <234fef36-b7af-43e6-8b72-e58d924c528a@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:41:36 +0800
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
Subject: Re: [RFC PATCH v2] cpufreq: Keep global boost enabled after partial
 enable
To: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.loehle@arm.com, ananthu.cv@oss.qualcomm.com,
        pierre.gondois@arm.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
 <20261127014937.413500-1-jiangtianfeng@linux.alibaba.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261127014937.413500-1-jiangtianfeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08fbf7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SRrdq9N9AAAA:8 a=dELt5KNJBVKGH5iyx0EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAxNCBTYWx0ZWRfXx/Me6KBW7UpJ
 FL2s1t43z7f815qh0++VSAVUA/v12xjFRmhK2NEP1rRcsaO/LvFjOHfBW0IRoQegr5MmrjTqgQY
 ddjHs2m/CxSYWZS2b0IXKSMnk6mFU72CnDBgqDGdmd3p8UAHS+7AjaNd1x039uxMCOqstAf2+d4
 zXCtDrRddNtkzBTgANoUVN5IvZ9/WxlhB47mo3G05xfCEDHMxYWs9q6TulC5nxro0uy81JVsv7p
 vWope7v15w21eCQtnQ/V6KxAzDEE6Jgo3duE7aAimmw2zpiiDERpM+HzIqXAxwXDsyWHlq9igtF
 evsfAQg/2vt+YTr7dy3LA3T+gq7v7O8UerMkvM8SB/Kc3J5tDXhZ5O0ZFXQaLCVEJqTVQePpp3u
 dmUPoVsqHjdMSF/fWFLKgoOSPi5aYvxjkTEEW+L8Q5i5tkVwObfgbTYDqz2Kq8mlhpUHa0kQViW
 qtmShVrwj9TheqdkBKw==
X-Proofpoint-GUID: hzFKKrRewiEQ8eXswT6NWdgRxP_yWJeZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAxNCBTYWx0ZWRfXwm2CMg9nZIN6
 qoQJF2DuVvBNAqugty1Rn4ZPQmUSIeLZ79Lut18wvefq3IMcIenF/pUTAHZZnzj7AzNvgdMhuLf
 4PFR+xEEihsvkpZxwrcgJzwMVzorqpA=
X-Proofpoint-ORIG-GUID: hzFKKrRewiEQ8eXswT6NWdgRxP_yWJeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270014

On 11/27/2026 9:49 AM, Jiangtian Feng wrote:
> When global boost is enabled from the disabled state, a failure after
> one or more policies have been updated successfully currently restores
> the global flag to 0 without rolling back those policies. This leaves
> them locally enabled, with their boost-related driver/QoS updates
> retained, while the global flag rejects per-policy sysfs writes.
> 
> Keep the global flag enabled if at least one policy_set_boost() call
> succeeded, while preserving the existing error return path. Global
> boost = 1 grants permission to boost; it does not require every policy
> to have boost enabled. The mixed per-policy state is therefore valid
> and individual policies remain accessible through per-policy sysfs.
> 
> Retain global-state restoration for enable failures without a
> successful policy update, same-state resynchronization failures, and
> disable failures. Do not roll back earlier policy updates.

The "same-state resynchronization failures" part of the changelog is
left over from v1. With v2's condition, if global boost is already 1,
writing 1 again fails, and some policy was boosted before the failure,
the restore is skipped. This is harmless because the restore would write
1 anyway, but the changelog no longer matches the code. Please update
that sentence along with the comment.

> 
> Qoder, an AI coding assistant, helped analyze the issue, develop the fix
> and state matrix, and draft this description.
> 
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
> ---

When posting a new version of a patch, such as this v2, please
describe what changed since the previous version below the "---"
line, with a link to the previous posting. See
Documentation/process/submitting-patches.rst for details.

Please also reply to the review comments on the previous version
before posting a new one, so reviewers know whether each comment was
accepted, and if not, why.

>   drivers/cpufreq/cpufreq.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4332cb114070..707de10ad36b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2887,6 +2887,7 @@ static int cpufreq_boost_trigger_state(int state)
>   	struct cpufreq_policy *policy;
>   	unsigned long flags;
>   	bool boost_enabled;
> +	bool policy_success = false;
>   	int ret = -EOPNOTSUPP;
>   
>   	guard(mutex)(&cpufreq_boost_mutex);
> @@ -2911,6 +2912,8 @@ static int cpufreq_boost_trigger_state(int state)
>   		ret = policy_set_boost(policy, state);
>   		if (unlikely(ret))
>   			break;
> +
> +		policy_success = true;
>   	}
>   
>   	cpus_read_unlock();
> @@ -2918,9 +2921,12 @@ static int cpufreq_boost_trigger_state(int state)
>   	if (likely(!ret))
>   		return 0;
>   
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	cpufreq_driver->boost_enabled = boost_enabled;
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	/* Keep partial enable usable and repairable through local sysfs. */


This comment is left over from v1's goto branch. In v2 it sits above
the restore path but only describes the skipped case, so please reword
it to say when the previous state is restored and why a partial enable
keeps global boost set.

> +	if (!state || !policy_success) {
> +		write_lock_irqsave(&cpufreq_driver_lock, flags);
> +		cpufreq_driver->boost_enabled = boost_enabled;
> +		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	}
>   
>   	pr_err("%s: Cannot %s BOOST\n",
>   	       __func__, str_enable_disable(state));


-- 
Thx and BRs,
Zhongqiu Han
