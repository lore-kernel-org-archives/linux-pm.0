Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075423EA8A
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650295; cv=none; b=Xnh1xGokya7XDJ4XoqsPIw+nE8XJ1sfRf4AbhAMRtcHSSl8KzPilh89hr6OYkfdeqBww44AkETq11gGxNio1u1uDWZ5yQsIPslGAsZ0cgrFA6UEocC13mQQ4L1lnimRPLLRQIGNONKEifoS8/puuksoi9QOCym2H6potF8z5WoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650295; c=relaxed/simple;
	bh=ROrzfDw3JAFFN0UbBl76kvuv534qkWfgUkGQK91ddvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BApY2c3GzdZfST207uhegVYH5KxW8FUNjQLwznjAB30nHG7wmsHZYs1TRGop2EtE1vDOVrfnr+vh/cR+3aCS6n21B33Ajcdp5f6qYyG3q/RMopXLzDx164o3O4xtecO92RZfhaBw+O1JKuJ8M9loD2A8wi7XrgP7NmZ4cACxGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vdy10V9L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvbHkG0l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vdy10V9L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvbHkG0l"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64c8u662943
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDgTbD32XG8MKV+bVlGmYgXMPPG/gcrNcT+UREXyDSw=; b=Vdy10V9LosLFIOdq
	nYqrfOo0i2NLE3KIQNxnmYi47r0/3C11tSQfFZND8MrxQlYKRzFmFD0W7x1qmHeU
	jhurxsPf3bG6Pcspc0nIgZ+2sxdQTZ9Y2cpiFFwxynBB5nDir9+pD4qFmCjvWWmM
	wIB9hwMV8/z4EG/JUO5P7CQlzabuaIrJTBFLIPL6KSYkMnhErDxI86KUvQIUfvbi
	Mj3/bvP5mcEyKAJQe4vwq+b2qzlce9PGQ5MXA61cuBJiERFn93JsF2u9ERXjisP2
	kvHxlq/Qc4WAQH/Jr3YIyXdO4aV4jmZlk2fhADD+ExjxxJif9aKymROy4PpUt8U0
	3VQ0cg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043mtyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:38:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4b96c259so62042285ad.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773650292; x=1774255092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDgTbD32XG8MKV+bVlGmYgXMPPG/gcrNcT+UREXyDSw=;
        b=gvbHkG0lEW05nkzsfTLCiAsoq66/Jw4Aem44gHlMvOsu8gsS6lbA4GCzP3TIFfl9sg
         n2YRaHmFv7d4l2PDvv7aPeJ2fs53AFvUwYYbkpvJHFrrirg5b7aqmSYR7YqaGZtWwu+p
         407yVLczzWxOXyJKlO1uB4Kd4InX/gYINVAh7cFVeBsxbBAnBbyJoyBNQDMhj3RBmsun
         S1yb8g/Ujt6wSESKVGtw6QhTYPP8NfLNKHPG1duyGlAm8/Kf15LOEzjOOdp0gxg8+9Yn
         q5qsSzJonMwIakkDtD61TFNfzj7TjLjjz/jXqedGPiJMpB3rFQYSOOcy9N2djxbJ9sEw
         14/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773650292; x=1774255092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDgTbD32XG8MKV+bVlGmYgXMPPG/gcrNcT+UREXyDSw=;
        b=gDnulvWHfX+mo6mDkG+pAIYUBFibSZLTqIF1FuPqvOH2HQTXRQ7Ku5vmkAt26v8msy
         dIuVEpmEK87JbezOVcc+w03xAt8G3HnHTJ9E+0pcBdTpq8G0tstzSzicIqZ0ilxnUiqS
         7vYej+PtKeJEdgmCwfNCnaaEaK06Dtm6vU7awo8fuIrKu4vPkgtiJPRkb/VmKfNRfrpc
         oOphJKxUU0m8SVpL+dquacXlr7O7/S/xq+Yqve+UhouoXJNL0bP0Tqiw4e3RagnjgCPb
         vPsYkoGaqGqlbDkw6IpSVzdLf+OrMKyv9L73b8ZNK1KUA6ySqFAG6UXo6yJi1xpBJ0Wh
         rcog==
X-Forwarded-Encrypted: i=1; AJvYcCUnWesMrVUoSvqrcbY2KQrK4w69iwMv1qRpL61U5kf3WCn1djRmtq2U/5I/7nH2be7wALpPOyxFNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z+F+QHyQFOaTi3txujUsXgFyISniBLlu1HOKCfdcFcvQllG6
	HJP9t8nRP0bBBwfKHCMt3uBg5K6SMjZYottEBDXxhlqN8ETyzQVuMo09KQI89l1RPcnwNhez+uF
	tCMDHPBgZq4K63KLYfZ7q0qi+LdEp5BSYFwSV8kr9xBWgjq41+Ego0lmERFo8ag==
X-Gm-Gg: ATEYQzw6iaqubaoe4CvYYmqsm0PE7B5it48HzUmnn0bopGfycKFitY/U8IDY1q21q67
	XbwlNUcpPNrfampQCr6jhJntAfzw3ArXrfVv8xjYfaHCAGLlF6yxXNGDKGmw2r3DcpX5sXbjUfb
	7OSRRj43J4OUvOVqfDPV8QaEjfz3S8js79RYgRiIYHMBGDZpNREPDKDXrPzN+BITW0ntVME0Hlp
	r8fFfgp/RDUbXg1MEj2h7UlLToCRnIsWVYLIayzZ2GtOnKUrU4XbQREk25fx5j6iWebqhwM8KhK
	CtbGFw7BOTJWA0kBa/EVHU3cnJX2hqLXKy59/nZIzV96sufHfF9cOgxB8hbr+M1WLJX9IBPIdeP
	0ykWkbswRmSRKtO/DyzA49IKgsUpG46/EBQnLRy1V1VTjkp1bxwR/LK/96wUghx9MKs2tCRn8th
	9mJVwI/uKuYiJK9Qq5OA==
X-Received: by 2002:a17:903:287:b0:2ae:cdf7:4740 with SMTP id d9443c01a7336-2aecdf75827mr108192805ad.17.1773650292368;
        Mon, 16 Mar 2026 01:38:12 -0700 (PDT)
X-Received: by 2002:a17:903:287:b0:2ae:cdf7:4740 with SMTP id d9443c01a7336-2aecdf75827mr108192555ad.17.1773650291886;
        Mon, 16 Mar 2026 01:38:11 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cdf4sm128855745ad.8.2026.03.16.01.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 01:38:11 -0700 (PDT)
Message-ID: <20c1e58c-bbd8-49b0-bda0-91e3459134dd@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:38:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: optimize policy_is_shared()
To: Yury Norov <ynorov@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>, zhongqiu.han@oss.qualcomm.com
References: <20260314192544.605914-1-ynorov@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260314192544.605914-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA2NCBTYWx0ZWRfX7ORGRW6xNbor
 MVo3M1yMI2MVXjg+zIZXpH1UU/dEF6XgqQB2KH+tqPHAkITORQMiGKyEGi/9dbSq11u8p/ZPBIT
 XJ4vOXEYX4tgGooafBpfBo8hwxpcdkCF4C0hlrjVPpkBifytQ2fAFxbBFJiNV3KCI1OOE7sw+I2
 qbbtMHajK7EITpRvWJv6t1P54f9513loNCtngRmFtLbLOlwb3TutNiOFiLmsvg6q0tjWydVz66Z
 TMKdMUhhicLF90WFbA+/Sas2++VKmFFp/+y2yomr1iS230mzHE2kXPLsro5ibfKskNgnUk7fTEd
 Cdeq9cN5jo9zsTygH4u64ZwghbVe7Hb7asetAbyrmhL3F7jK9EKfsPI334ew+zBEhqiRbovQdVH
 Ufdh4wd5A3Fk1jxjvidqA1WMuIgaorJdcQDKOfV2/nJiBjVfTeR0j6TsVwfhcHI/s5W5+dMZVn/
 9nLjv3VYm4VaHaHeWRw==
X-Proofpoint-GUID: yYz0Qo5KxFvx_W16DdzU0elsVfzuX-1f
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7c175 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=407Z2pdP_-DL_vujbKgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: yYz0Qo5KxFvx_W16DdzU0elsVfzuX-1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160064

On 3/15/2026 3:25 AM, Yury Norov wrote:
> The switch to cpumask_nth() over cpumask_weight(), as it may return
> earlier - as soon as the function counts the required number of CPUs.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   include/linux/cpufreq.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..8ca2bcb3d7ae 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -232,7 +232,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>   
>   static inline bool policy_is_shared(struct cpufreq_policy *policy)
>   {
> -	return cpumask_weight(policy->cpus) > 1;
> +	return cpumask_nth(1, policy->cpus) < nr_cpumask_bits;
>   }
>   
>   #ifdef CONFIG_CPU_FREQ


Hi Yury,

Thanks for the patch.

I see the intent of switching from cpumask_weight() to cpumask_nth() to
allow an early exit once we know there are at least two CPUs in the
mask. Functionally this looks equivalent.

That said, policy_is_shared() appears to be used mostly during governor
/driver bring-up paths (e.g. sugov_start(),cpufreq_dbs_governor_start(),
acpi_cpufreq_cpu_init(), etc.), rather than a hot runtime path. Given
that, I'm not sure the micro-optimization is worth the readability cost.

Also, cpumask_nth()'s documented return value is ">= nr_cpu_ids if such
cpu doesn't exist", so comparing against nr_cpu_ids would match the API
contract more directly than nr_cpumask_bits (even if they are currently
equivalent). [1][2]


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/cpumask.h#n540
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/cpumask.h#n78




-- 
Thx and BRs,
Zhongqiu Han
