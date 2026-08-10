Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741543839B7
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362744; cv=none; b=BPJxAWar9LtKGMZk/pF1H8xh1kddc3EW5YU6jmqoUSzxmlgrCi7D3p/sY+uyb/nnNZ3MOHM2cxRAz46HBaHp+r3msed0hwHzxX0hiYCZRYrdvUArGv/5Z6nw4yBZJHSr9wYG0T171ECf7sFMSTnAMVNF7gLTdfIbEsrmNV6vUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362744; c=relaxed/simple;
	bh=R7MPEfWnPo8722Y7YoY4MPXT2lM06UwWRJR1wjzKO74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JwpciZZLhnnL8jTYU7uZcA0T+qHGeVSrxN11vRxQE3VMVQMpgPl80GLgKfLQmOqXCxmKaxvbzD0td7bDxt6eWyC2KxK84EPjaypaVrAZXFY8wQXN1YDWGVbsWcBxD2xZnD6kWrGwz8ZKgLuEAlZDX3QPFd5dxw9sAm5Bw7E8WMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+OCcbam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSk7GPTJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+OCcbam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSk7GPTJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9S4X3890368
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U21gp2rJrmtDoIardEIIjG5T+Eh859Iz632mm2y9CYE=; b=g+OCcbam7XAPErqM
	8zut19bYnt3vAesiaYi+t3tifKxyn2sV+oofiFE+j+4CfIEBFthnvlpA8npL4jwX
	HTbSvhcc+yFT0eN1pvueT90U3vNzTQwNzLhLtA0z0xdwZJfCz5bGbH7P+1AwwqsL
	T/rThrPvFuGTp6NueMsGQUDANm/3Og4AjLRqWByzioXAMJIyizYtYWtfGNbpqTwx
	qEPIIuxmc3Gd03rFoHcXfyAPmE1+9NCyxTdfAYFe0+0W4HsVwWmkdVgI+OpT4nkB
	WqMhahr9FP93njRbFqd46NeAxrYpMgs7FKBGE3TUgPC/8Xygtgqc7YQIfn9v7osC
	V7PInQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v49bqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:52:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so3784321b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 04:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786362741; x=1786967541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U21gp2rJrmtDoIardEIIjG5T+Eh859Iz632mm2y9CYE=;
        b=FSk7GPTJuoM62cBAM8GS0BcNWItikzTIRVYwwYKdUS3Nvq+FOsMlq3jAs5AnlmlpXS
         sKa4sNLlrnd+8kco/MAMrpSzgnk69SDi1W9yIGsxHRfuxMFj0MZ3Jl2redS1lNRg2hw2
         5Hj48peXSUjfIvspga8Y0zZtxfpXH2+dy7nOXp9wQpifnS+kiUWLWpWOmwrcYQ25fn6z
         ka4ikw4nfuqPQg7QJXR+Uj4KffTBJ8yoRg5wvLlqIWQsnGBYubOkhvyz0AXwIOD+ES8I
         sNYCfeYhrupHCMALY9qpjOKb+WHqjQWtokJvovtQxcAi+gSE4AkM8ebsRxpq5aOT5yeV
         CxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786362741; x=1786967541;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U21gp2rJrmtDoIardEIIjG5T+Eh859Iz632mm2y9CYE=;
        b=Q+bL12QbmaXEfHwNcpIYIZ5eXvbgbL1MRwR03YH2el3UiikNpFEfSXPoY+nHMqtTkQ
         8JPsop9y9UGsrr7uyKAC7lSP6QIsPwYt59Iukk60gA7bdNkHgzvXfR49zpMn7UVgyYf6
         u/bXgdCFXU03vaPyoNHf8usqr11eaL/e4K9T7jo6JV33wag1SYiUo6lGnQXM6HFZglWY
         Vtcl4J8GVE5XiYtHqK1G/1ZIBzm1iuU5Ry/eYQl+xsBeXwxTZuN/ASMzMkcyfSKoTAF2
         Y6ZGPSoa++KJFduSM2w63V0gAOHVpGxr4t6nlGG0WBtPgGEeftQg7TtFRL8zXuW7iHRg
         nl8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpAK2malfX593VfdHf3oCHDQ26ZneJCPO+RfIjM6uIv08rbkWEiNyTt8U5CALDOLwp1riHrLlREAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPW1UCYq1jmztmEqw4CuTOUO4xER94/fR2cQZenzMnIF9Humx4
	TYBwXUdYcTB19kYTKCQ+zfJiwpBVXgrzlvAU16Hr1M8TlPEIT88TnUcKs4TV0F8RaFq/9LqdvIR
	a/O0CpRhM7ZKXpqmwY6xmNI7WzMPoccu+7RD9pT4yqzwSMwpfnQYfdmFJpmkJFQ==
X-Gm-Gg: AR+sD11nMWyYQAcWsoIqtwdse/9NZ8B4ub2O++tJlF8RruQhBOZAgm2kuNDLiTiWyKp
	gWhIpvQ6gSbjAEI4dQuJfofneRao8OJ6yoTEqQbpC2niZ5pe0HSaYOBUprPMeIHGFSMm4jPYzXk
	YoqqCUI3ogztEoNcaB1f7G+RoVVg6XjthU/v50wvdeJ+aR7v4XPyro0X/zE4pVLwYoNJo4CtFC0
	hD47McxvlHsV59lU0Dw78riRTg1Zj4Ztqjo1V46LNMIQP+EjAvd9fJqePdlg22VR23dul9CEO7j
	9xnkWMn86Hm4T6xBVTuZFUaQucgpCxFLfm7ph3DHzIq7cvqaFhHoSPnsztDNA9lXUGLZ0/9jsg8
	aAHRBZ6NoheTynd7MSeCajxmp1DNpGQ==
X-Received: by 2002:a05:6a00:3d4c:b0:848:417a:d1a6 with SMTP id d2e1a72fcca58-84f2dff0031mr46284349b3a.15.1786362741211;
        Mon, 10 Aug 2026 04:52:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4c:b0:848:417a:d1a6 with SMTP id d2e1a72fcca58-84f2dff0031mr46284296b3a.15.1786362740767;
        Mon, 10 Aug 2026 04:52:20 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a55f13bsm3803111b3a.47.2026.08.10.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 04:52:20 -0700 (PDT)
Message-ID: <1340caea-a8b3-4b1a-9c50-065a8cf6fed4@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 19:52:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: add NULL check for acpi_perf_data
 before freeing
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20260810061045.2397-1-lirongqing@baidu.com>
 <3c7c27f1-8ccd-4b1a-a21e-9bde219bd9d0@oss.qualcomm.com>
Content-Language: en-US
Cc: zhongqiu.han@oss.qualcomm.com
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <3c7c27f1-8ccd-4b1a-a21e-9bde219bd9d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aSbdRR4HmaDSoiPsS2Mkhe9sgarMIsoo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfX30RZbjDS8L/7
 d7Jupe0k1UBLV13ue1TtLDeUkma+TwurbJo/udz0LUr2IWkQJj+24dFLfs0G2+YQDzIL2eMubvi
 5RRrRieyhaEOaYK9PQUee8LxcB5sS3g=
X-Authority-Analysis: v=2.4 cv=W5EIkxWk c=1 sm=1 tr=0 ts=6a79bb76 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=zuLzuavZAAAA:8 a=3mpFhDV91uyD16peNRIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfX41sX0kr9ZIkW
 O+ccMeImhZCqk3k+i09w1o0zvKIAAqGHOizzI0CbsWul0A/h2CvYsE9Hcep+AfkICBboxjmJHM4
 CyS7RjgNMMcV6+0llnvPis3DDi8dQTiNjYvTwWl7YN/fGbTW/SQrsGmUPRAsPPa76TNHKuUHRZz
 bysug02Hje4iP5meNyfzPLH+mkZhQybnR8XAMJxq15xh5SHScdN0dG4deB40mEIMIYhpFKvQFVN
 ziEaTllj1lxeT1eaZ2zmAFR3/6qRcUJFy9s+g+dy3IN3vLTUJJJbDeeRY5GJOqFDrV4tsatQLWU
 7RnQeHQRFhBiBP4zefpSWH/ygOnTx4kDbJojg+uwSASKq7RYXecrSPSic+XcG7sMVki9QfnoTTd
 di2o6DThyvoPM4SW/5JLVvpog14fUnsw0wU0bE7iF5c8thb6Ucy4oRzF2ivQosp8hrOBg/uocsj
 /1Apmtg3pgPx6RN0v/g==
X-Proofpoint-GUID: aSbdRR4HmaDSoiPsS2Mkhe9sgarMIsoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100103

On 8/10/2026 7:21 PM, Zhongqiu Han wrote:
> On 8/10/2026 2:10 PM, lirongqing wrote:
>> From: Li RongQing <lirongqing@baidu.com>
>>
>> If alloc_percpu() fails in acpi_cpufreq_early_init(), acpi_perf_data is
>> NULL.  Calling free_acpi_perf_data() will execute per_cpu_ptr(NULL, i),
>> which does not return NULL but an offset pointer.
> 
> Hi RongQing,
> 
> Could you please confirm if acpi_perf_data() can ever be executed when 
> alloc_percpu() fails?

Sorry, typo: acpi_perf_data() --> free_acpi_perf_data()

> 
> 
>> Dereferencing ->shared_cpu_map on this invalid pointer leads to a kernel
>> crash.
>>
>> Fix these issues by adding a NULL check at the start of
>> free_acpi_perf_data() and setting acpi_perf_data to NULL after freeing.
>>
>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi- 
>> cpufreq.c
>> index 87e4923..cd2ca87 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -517,11 +517,14 @@ static void free_acpi_perf_data(void)
>>   {
>>       unsigned int i;
>> -    /* Freeing a NULL pointer is OK, and alloc_percpu zeroes. */
>> +    if (!acpi_perf_data)
>> +        return;
>> +
>>       for_each_possible_cpu(i)
>>           free_cpumask_var(per_cpu_ptr(acpi_perf_data, i)
>>                    ->shared_cpu_map);
>>       free_percpu(acpi_perf_data);
>> +    acpi_perf_data = NULL;
>>   }
>>   static int cpufreq_boost_down_prep(unsigned int cpu)
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
