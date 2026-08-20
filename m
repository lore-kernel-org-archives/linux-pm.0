Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AED442B2E
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229340; cv=none; b=FkuM8WptW8HYnoCUEP99t0xL6ZpcDrwKGLr82fYG61EViqm79QSKINnjVweSWWqmXhtno2NLyZ0XNkpVwWL+rRQqdWamwfxnYkrUqK/ugdjUhf7v0lb5QcFVj9I1V9ocde0hJmvlnrmGuJrxXKkLvYWLELROTC+z9Z0/qNFoHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229340; c=relaxed/simple;
	bh=zLJG/f14PS8IWMmKFHbSudOFvttrq1FN6y5gEITIHpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gueb875j6a7L7BbbSnhbwArYVCy1nHRvgm6u3llmBCniwqeHYN5IbAQt42K0cUjTRSGGGE2L+hNcW7GGfHgDpI8LJ0BMUKRkNW0YjVlmCgPQlPpL4b7r9FUid/y0/V4I9d7QZUc1mW8aH+ire93D/m8teINfGXViwNHLD5WMzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCOjQ2Yz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PA0Po746; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCOjQ2Yz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PA0Po746"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PC4K2465314
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=; b=WCOjQ2Yz+ctme2+G
	930MCKEQixYauFh2behIj4WORi+WRFrD3VgbG1s99Kr2Pwb/PBdfapRnmaVz7gdm
	ZrL++AdweLK1nyEN26K6779di+4MSP/UI3+YYyXFsKPu4xj5VhFER/AkCmLhYu9L
	UteIYKBg1uaPrldwpi6HNrkkUo0ozmKui9U9NWI5IQj0qr2ja7aIBgt2zkbz+0xJ
	e9wi9+3PRSo8PLHwZtx0+MG9D3OxdHMMU+KmjbMYzwz3/qDNcUnF1g5FxyO7qKhb
	zCCOFv/O5H512wkqgknQuP0eWbVnlPjhmAZrulvz9OUZfLDz7CRs/nMdkkqS3qlS
	3qzz4A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gx1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:35:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so2559051b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787229338; x=1787834138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=;
        b=PA0Po746V9ydMk1cYNPRnsAxf5UPB5dF7C1FPnC3d8xDPBSQXez9Utg9NaKpKWiHjk
         gkeTEk3SwGu1XvCgniEgtZ0k0r32Ju1NOL8TjSa98mMearhRkQAgkxyrr3zbSD3YU+vK
         ouyDbMzy+A21WvMYwBrorLi3BR+NBwVQylKqved/P/uT97UviiGjbPIj8N26i+l8Sg88
         M4yOypcod/gGBNvHP+jlo66azQfW6LmKV1r1TLgVmV6nNl0ktlgXtcuWcZL729JHHDhC
         WeIJ9VB7j7LCFZcbkTR0uNJ0D64fVqhcsiaIKtm6X5/Nu5zQrj9KsF+ZOQNOYJohr62W
         pCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229338; x=1787834138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvhd0zZOpOWlXPQG6hjDdSgimOp5ylGte8t4ByQ3TVI=;
        b=jUH6xQjes1JG/9cAjOrfI61Nb8x94ccRH0BBt0SLpqpc2jYak/f0qrppO68U28FZdA
         TWt117WZfZDhCm6ZeUE7LoddkFb3BJt94SkAAjnUbcbfjzSVs7cOn7t1tN+g7qF1gCzc
         e5CUjlPkezNbZ1JBNpHWk5Vn2MEFCc1c2IqdECiOxbzwdybj720RA82wsmgw7ElxEpar
         oHtJLzJGozoWPntvzmuXhTPEcmRjeh4fiurtVZ9smrldw6XF+7DqkMnScBLcp/SXoBMc
         ajz53y/0kqSGY69Yl+QSf5Purs4IeWMa83CixC/T5qUsu4/vgXooRpuUH+r0GYgIwKqF
         ixoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrL05jfma585pSO3AWyhdjuXc9+N9HXZdYvCRAgLJJ67rg/B0sXDBBgd6bktq/cu1t94Vqvot9tFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RfpWNba6v8JiPfz8VJwOMGyBbUa3YHSvcLwLL8WaoI2sUVjY
	rEfGir7efHAdtFzFPfkejl+82NNbDMAnftYd9b7qJW6T4/QluRRriBpmttzh4Rap6bjU1xUGUfZ
	aKnQvv8YJ0omPqURwrzBUGJfrtkzgllbcADpu7HupUWNsCCBsxSPG7LCnerR8Kg==
X-Gm-Gg: AR+sD11/OLAOq63sXdY7LCHLHxXCsyy2qoiR/AKON/07bYCbe6Q3YaBcvmlg354BAJP
	fW7YeVulcvYTTJLoc+7oR1qdLdjoFeHStnE6QKpEeOjmPNteytmWNDEHIQBaQCG1JeREZXuWRvy
	pSFZpVYk8FDl3vcDf3wF/DlcWvk6lw68Vzk6MzlwMofVN/CYT8unDhkY40HZXjEXvtqyXkmkL4F
	S+J4IrDjwAuPKXc1qbIHk10oJ584aw795SSVKOrNuMHqqp4ncZSTZ4nLYQZTtn7qD4IkKoE1A4U
	VDodtUdcrCkzmjsVcLt9Be2fG27vmL8SuQK7XhDh8EqvKuntVDJq/0Kc06T0jnhCn0RFj5lWbqC
	8QX0tEFVrq6i5aLup/edVsw4j3B+VTbNJvWvrzlDgSqk+9C1C0HoYB3OFqhanpXuZdsIAYHb+
X-Received: by 2002:a05:6a00:4c11:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-851d348dd44mr21853602b3a.0.1787229337933;
        Thu, 20 Aug 2026 05:35:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c11:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-851d348dd44mr21853463b3a.0.1787229337347;
        Thu, 20 Aug 2026 05:35:37 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1556753b7sm1768171a12.16.2026.08.20.05.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 05:35:36 -0700 (PDT)
Message-ID: <49b8a931-f814-45c1-97f4-cbb825dec700@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with
 per-node
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        Hongliang Wang <wanghongliang@loongson.cn>,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-4-chenhuacai@loongson.cn>
 <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cwtCBYClxFdkrEXyxLEJJ1zcbUQmKogG
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86f49a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=LayQR5MyJkDDx0UqswYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfX8AtymjMvLuNo
 vlWH6t7kgg9j3hb4W1F73/whYmJ7aYcZj4jSMo/skYCcuDyHwpAc4yES95sbAmTA2tEbrYf4g5c
 fxS1uaLsR/KqEQ4aoMJZpLG9aeAqSAgMLp+ff+Nn8Z406FLjylGCuXG9FPtrKsrrA/1MPfP62KG
 FPXDp1cobmwNM7xI9nzpoPy8ivEliuJHo578pXUo7zvg1FLmbbCRH3G+vE2ueJZUcXcKyNfYL9f
 dHKLcVDD0cOCHUyTLCfyrQwUNE5ikjmaTZujuVKRfatTlUAgKCkndD1ZRnILdYaTcFDUJjp4lPf
 0tiMQK6Bv1UMR0jNV1cOj96OaE3IuGSRWDugPMSyu055Aaa426GFWgPoEPW/Hqzt/bHZpVXV0eM
 qjeK86itGyaoiXjlH2KCGY9MHfoUltZ5QSkoJ08+6jrOAUdv4kv+KnM6lYEZamCCLW87R1jmFu6
 Gwmnmog2ae29Bds5qwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5MyBTYWx0ZWRfX3FzQ0tB8eRIq
 ODD0ci0pkt5cIfQ2LUw6QcMkfg7EOFYj5XSSiJ/VuSe6qt/dtPB8HwBOJKBTNhhHFCdBLCn7UZ+
 IXEcGkvS9rOlTqUtzzMx8N/auRy2T0I=
X-Proofpoint-GUID: cwtCBYClxFdkrEXyxLEJJ1zcbUQmKogG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200093

On 8/20/2026 7:34 PM, Zhongqiu Han wrote:
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
>> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
>> nodes in one package and SMC mailboxes are also per-node. So replace the
>> per-package mutex with per-node one.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/ 
>> loongson3_cpufreq.c
>> index 630f679aa739..e3cd78a5ab18 100644
>> --- a/drivers/cpufreq/loongson3_cpufreq.c
>> +++ b/drivers/cpufreq/loongson3_cpufreq.c
>> @@ -169,7 +169,7 @@ struct loongson3_freq_data {
>>       struct cpufreq_frequency_table table[];
>>   };
>> -static struct mutex cpufreq_mutex[MAX_PACKAGES];
>> +static struct mutex cpufreq_mutex[MAX_NUMNODES];
>>   static struct cpufreq_driver loongson3_cpufreq_driver;
>>   static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>> @@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 
>> info, u32 cmd, u32 val, u32 ext
>>   {
>>       int retries;
>>       unsigned int cpu = raw_smp_processor_id();
>> -    unsigned int package = cpu_data[cpu].package;
>> +    unsigned int nid = cpu_to_node(cpu);

What if NUMA is disabled?

>>       union smc_message msg, last;
>> -    mutex_lock(&cpufreq_mutex[package]);
>> +    mutex_lock(&cpufreq_mutex[nid]);
>>       last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
>>       if (!last.complete) {
>> -        mutex_unlock(&cpufreq_mutex[package]);
>> +        mutex_unlock(&cpufreq_mutex[nid]);
>>           return -EPERM;
>>       }
>> @@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 
>> info, u32 cmd, u32 val, u32 ext
>>       }
>>       if (!msg.complete || msg.cmd != CMD_OK) {
>> -        mutex_unlock(&cpufreq_mutex[package]);
>> +        mutex_unlock(&cpufreq_mutex[nid]);
>>           return -EPERM;
>>       }
>> -    mutex_unlock(&cpufreq_mutex[package]);
>> +    mutex_unlock(&cpufreq_mutex[nid]);
> 
> An optimization independent of this patch: considering to use
> guard(mutex)(xxx.lock)
> 
>>       return msg.val;
>>   }
>> @@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct 
>> platform_device *pdev)
>>   {
>>       int i, ret;
>> -    for (i = 0; i < MAX_PACKAGES; i++) {
>> +    for (i = 0; i < MAX_NUMNODES; i++) {
>>           ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>>           if (ret)
>>               return ret;
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
