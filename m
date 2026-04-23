Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424773C9429
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922794; cv=none; b=AD7NtS1dIu56XFzgWgQugLuRLIPfV7LgSUfNeA3wXQzk5MSPnok8s/sm4IgfNp/LRDxeg5lO75i+N1MkQYBFroqm4nEQ7n4ZTjiwXavtmWluTxQ4FZGrJqMnSFvDXp5g9iJSAxyjXrdZwHB6Oin1vDpWWp4xjUbSpaNH/dR0eGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922794; c=relaxed/simple;
	bh=NRlQOT/MrDZNinKs5KppazJLAiX8V7buz8mCDi2WVP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6MdbQsjL5UYbhXSgJsOehDG5A7+JoZVCinDLYMeItrIU7DmHFhraxayTJNL9PUIVsLso4LE86lbt8O3gVJiM1QzT2rN+FHT6upZO3PbsBZE0HIbBrvFgmTOcm4lQ4f2GOWtOX4/FZPxyx7qEGnVfoWb6r3fa/4ioM5td4khAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OpXjDeXh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fyq0Vn0c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpXjDeXh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fyq0Vn0c"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3F3w5121893
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 05:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oWyLJPmJ5MEOaqp8lTB78ArF7rnI1vWecPhy5LBowBI=; b=OpXjDeXhED1juNgZ
	j4iARDeDRfYDiqJ70f8PdPvShDM+3cG7BAQEwc7FWmhAFMoBuSQamUAgoKIsVhNc
	t2gw+FGcyajj/kKeVTvdQwh5eoANJOM8QJiwCmtcdANmNHCeLZKZGGD+hnuffVZ/
	U9WaNTR10zjFm8DQl0E1DJtj0/Y3LpbMYRoo9KSi44I+XF85TFvv7GVs4p7X9G0S
	tLpjTnQGeoVaJXOfCY23gBOujDBgB+FLjYh5Fh6rTrIRE5KAbvUALqJMPUcqDbzR
	efraCCRXDdGdIF6hhJzP/g8zsDBcRS4h2KFIQc5OTyjSqpP8ztFhbUtMahL5nq/m
	Dmd3bg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h82b9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 05:39:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so3123728a12.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 22:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776922790; x=1777527590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWyLJPmJ5MEOaqp8lTB78ArF7rnI1vWecPhy5LBowBI=;
        b=fyq0Vn0cX5sYQwkjojeZwtaMi/YMCacqzzNPg81iL+Tk98yPR14E/vrvm9fRTzLb0T
         Hfw1SmZJdfC3bcGGzFLPfVmlR+39zty2Xtjg2E9LbmgBED2u+HZDICzPioKFT3E7/IwO
         ICXefrjYS9FoljTQQYEH2UQOof5ElrgWbAbFF8bBgnBpvEI47BaKJdnuP5Llw8JI+dLz
         iaIDGE4+JdYbW2XhXF8oYLgOYHAaQKyzEu6oce6ylXcJXu2KIlg/Vl/vjkTFdsy6JDhf
         0vBlg+bBqiF7MHU3MODG2nmYsDoRZnA23lkUCeq0aLi0Th416oXCLBXpQ1Z7ubAzCEsP
         3O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776922790; x=1777527590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWyLJPmJ5MEOaqp8lTB78ArF7rnI1vWecPhy5LBowBI=;
        b=ZMEWpIcyBOm9BFZ8vdEQxO/BKwtQhP9fqd+BskqAQVkm0g2QLm236L+9xiCn2zrgf7
         xZocNLowtJ8Dzgxj9GXMTohHmvmJI0/StEgi1Dr1Cd/2PdwohnGyyADujRy/m2b2C8HC
         u4d3OYORhatF3/8AtXxrNiv+Qj0npnLruNbHB6uqSXcnte9TUqZYZl3t04w0INKo2PTS
         3sbjlIi/zqse1HEqv7/sQv+vtkS2svBBdpB87gDh89KvbAFOdMkRdoi5YLV2t3pI+/Nj
         B/ESNfoudh2qGgEDkWYGInwe1EXBYutyT9/u8FMpZxt9sxZC6omFQX8ERVO5tJ69iw1i
         jhhQ==
X-Gm-Message-State: AOJu0Yw9WaItPKjmalab7C9B72S/DuvqEBbSlIz4ycAwhfvz5xCCibqz
	xFR6sQX2gPF7sbkfSMV7sfgdhAcEmePzQKSWdC0e7FzgBv4YXTIh0hyfuvJLlpqTzP81l91zOEs
	5o6UrCErBK00vWq3oAkbIjkp7gH849Zs8nQ+YAlwmet9mkR8k+e0F/97N06yplw==
X-Gm-Gg: AeBDievS0m21Nozgu2Z6ptJlIeESg1KBoaDGB3AJhw7IueyLtnNTT4I7KW3aPzftB2X
	r7bBwSb9AkBDzEK3rMDvgZsnydk/ziGzER8SemYMDEo/3Ce+a/60U8hr15kzUW6yTyqhTPAPguY
	3dYP90AitRdhYRQkqWwVq2L123p5zMjRAFL6ACPkgMmrQiD/sVcoayKZ8+oeswGZQARjJ2mRCJx
	HvbzZqg1IrPEK1hJy83s33oKyPSLBvCI4lKhXPRfzl0Gm+vgtgurYFMnoT1Tyt02OMeuTGRJ4Vp
	sEr4iFfCB8rpJOm8KFjuZ8ByP3GJ+bLv/3EkYH3Wxc82Mar9IbaX4mAwdPCPFfNIjwlClq9T30t
	8Du+iPDZnzRmlaBJn45RSyVq5j9dT/qeqRHCMlbLiOx/b9L+Yij1xLvDC45zk1gRJp7kGhYP15W
	m6Vk5YwF1WJVEzyoHiOJHl2g6K1bTI
X-Received: by 2002:a05:6a00:94e2:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-82f8b531fe8mr21830128b3a.25.1776922790146;
        Wed, 22 Apr 2026 22:39:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:94e2:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-82f8b531fe8mr21830100b3a.25.1776922789523;
        Wed, 22 Apr 2026 22:39:49 -0700 (PDT)
Received: from [10.133.33.145] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40dasm18765415b3a.40.2026.04.22.22.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 22:39:49 -0700 (PDT)
Message-ID: <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 13:39:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, stratosk@semaphore.gr
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
        yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
        linhongye@h-partners.com, zhongqiu.han@oss.qualcomm.com
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1MCBTYWx0ZWRfX1o9WWDqVUWcB
 H7inqkvgUKFzwfAYPOXfUqOHmNL26NhCjjYRUVviRL7N/5RmuV3hZajFGDpo63DPgsTRDSR+wHN
 IfDaFf6gV6WMHxYoH0IzybiYDrNAKjGrRvSJSQ2hlA2VRxNKDgOPdyuXraO6QsPqVKQnLkmdZVP
 oI/fvCTMA9835J5eXjz9cirDGrjTznZP0URO8SD+7euuTmp7B4P+gFPkNz5JhjofBnQSiCD5cQ1
 UHmVmuaUDHuUnjV9aNDSMbm6O8U3qXBXp2enh6/FNfAjGcgWYmUzpP4QQGCL4/PMPRVSQ3SMBH3
 KE72lQTjdn/XS3whpyzsPSrZbmF3ExRYPAvR0NKQ8HPGI/+PKihRQJ3i4I/YYBFFJcHWwvFDSUJ
 1bV71x31ayp5uAaxXiSbSk815D0q7jsZzQ7IabebtV+V5hjKOXFbZsQsB2xmr1tThXWKB6td69w
 +cSeYgKuukBgwwybt6A==
X-Proofpoint-GUID: 1EcmQz8QuGn1KOxYE71tyuv7KjposQ5y
X-Authority-Analysis: v=2.4 cv=RaKgzVtv c=1 sm=1 tr=0 ts=69e9b0a6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=i0EeH86SAAAA:8 a=3wOXrwv6UN5-Hd3-6V8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 1EcmQz8QuGn1KOxYE71tyuv7KjposQ5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230050

On 4/21/2026 8:35 PM, Lifeng Zheng wrote:
> In cs_dbs_update(), the requested frequency is decremented by one freq_step
> for each idle period. However, this can cause divergence between
> 'requested_freq' (target for current update) and 'dbs_info->requested_freq'
> (target from previous update).
> 
> When the load crosses up_threshold or down_threshold, the decision on
> whether to increase or decrease frequency should be based on the *previous*
> target (dbs_info->requested_freq), not the current one. Otherwise, the
> update step may be skipped entirely if the current target has already hit a
> boundary due to prior adjustments.
> 
> Ensure that frequency scaling decisions are made using the correct
> historical target, fixing cases where frequency fails to decrease despite
> sustained idle periods.
> 
> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Hi Lifeng,
Thanks for the patch.

May I know would this ignore conservative idle decay when the previous
requested frequency was policy->max?


Scenario: Increase path, previous target at max, with idle
compensation; the original code does not have the same behavior as the
current patch.

Initial state:
   policy->max               = 2000 MHz
   policy->min               = 200 MHz
   dbs_info->requested_freq  = 2000 MHz  (= policy->max)
   hardware frequency        = 2000 MHz
   idle_periods              = 2
   load                      = 90% (> up_threshold=80)

1.Original code
Step 1: requested_freq = dbs_info->requested_freq = 2000

Step 2: [idle_periods block]
         freq_steps = 2 * 100 = 200
         2000 > (200 + 200) = 400 ?  YES
         requested_freq = 2000 - 200 = 1800
Step 3: [increase path]
         if (requested_freq == policy->max)
           -> 1800 == 2000 ?  NO  -> fall through

Step 4: requested_freq += freq_step
         requested_freq = 1800 + 100 = 1900

Step 5: __cpufreq_driver_target(policy, 1900, HE) -> hardware = 1900 MHz
Step 6: dbs_info->requested_freq = 1900

Result: hardware 2000 -> *1900 MHz* (net 1-step decrease)


2.Current Patch
Step 1: requested_freq = 2000
Step 2: [idle_periods block] -> requested_freq = 1800
Step 3: if (dbs_info->requested_freq == policy->max)
           -> 2000 == 2000 ?  YES  -> goto out
Step 4: hardware stays at 2000 MHz, dbs_info->requested_freq stays at 2000

Result: hardware stays at *2000 MHz* (no change)




> ---
>   drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index df01d33993d8..f3c3b54e4bf8 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   		dbs_info->down_skip = 0;
>   
>   		/* if we are already at full speed then break out early */
> -		if (requested_freq == policy->max)
> +		if (dbs_info->requested_freq == policy->max)
>   			goto out;
>   
>   		requested_freq += freq_step;
> @@ -127,7 +127,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   		/*
>   		 * if we cannot reduce the frequency anymore, break out early
>   		 */
> -		if (requested_freq == policy->min)
> +		if (dbs_info->requested_freq == policy->min)
>   			goto out;
>   
>   		if (requested_freq > freq_step)


-- 
Thx and BRs,
Zhongqiu Han
