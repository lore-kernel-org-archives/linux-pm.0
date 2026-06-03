Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D66346A1E
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495346; cv=none; b=H6huaF5T+b6Pz1+f9aX6qFfqjKqQuPDzXenGSBIt8keqEj3b6mn2M8RsRD3bRBk/sP5FQaUciRD7jUKOzD0SHa4zGZO1aZoM2rD2S8YqSpAAFvFLLXqawi5bG233j4Oseh9GZs3T8PzjPBUAiBS3gPqd93NFy4Vuv0lyl6QzSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495346; c=relaxed/simple;
	bh=5q57Ll64Gptb6Z3cMHEn7AH0lMu6trdmtIQANyRR074=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVvST7FGKwZWlOF3cq6HkY0LC85YEiIDBEGumbfnPyR3cyo8hFdlspKBXgj6y8GIAoZ1+BxirJ/2r5az7D9GCbo06jNxxL/kRP4DHPPlqP/YCmPpMTVr6ECpyk0Tfcgw3eBVOHaAaPb52Sm8v2w4IGWgEHBTT92f29sUjsJQN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgHBTNPX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cONcz9ew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgHBTNPX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cONcz9ew"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653DQtp81956497
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hH7KWT6cXh3uKU606LDzlxduout/UQmpGnjBLUaQ+Tk=; b=MgHBTNPXivkCNtK7
	PfUhOT/iHHs3wZPZSTDcOjXXvoqpQqXf8Ai39TDMU3glZwMXyyzEQ/nwS2MGrn5t
	uJc5rW+Wf5YEvnJW/XUDJWMDZaVTUQ9gUyS71Nu2i0cw7cFPdkp9WLJrzygC+2so
	urw6Gza3HAgW9/uy+Gj79p1pwQhHgelbWWrrMyQQFopdUFEX9ofJJYWUZC2tAino
	nexP+K4f1ZbGBo1SGls4I193QfPlZmSIpxCFMBNZVscv8ANLuWetgEMMzE/qFNfN
	/VBLTh7b7lTxZ7JzkKTDkJ7ORX35QNAMj62db9JC67OJGtpBwLS2qS7gqMN4XrOM
	RQHK2w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1k33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 14:02:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf281d523eso32383325ad.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780495337; x=1781100137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hH7KWT6cXh3uKU606LDzlxduout/UQmpGnjBLUaQ+Tk=;
        b=cONcz9ewwNT/mmsS1f16lQVZDMg7k8rQAN5a3u4tCGEu/lMuSvFb9lJwcvhg9nNOTB
         dC+tsF5EbFbYA7MjulU2diu5qFDPLVAgOUcUIVZL7O3d65HM9+JJo/WcWAI91IjGOu02
         KPHOAhhzB8eWwbz3q45YVvG1JZG3zCNK8eCI8HDIxGSYK7QjKmzIDyV8iHL+kzOZyC7N
         OhYvZwGeuajJzRKKCyTxosj3WBd8hozfCJPQtjc60JZdPPCGcYLOFkrqNN1LEa2zl2q4
         05hCLoHrx0CrNHWZM3MrNnuH45hQVFUHXdsnI10knzd6W1PQVPk/SfhoUS+n3oli2MvX
         B76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495337; x=1781100137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH7KWT6cXh3uKU606LDzlxduout/UQmpGnjBLUaQ+Tk=;
        b=CGji4DZqpMUidmMqN+HCT5XeWzqtRosGvw50YuthN1goiCW2DaExAZ/FVwJd2YbW8U
         nGc4S0R4g61zOQgZogkJgX53PrlVrcrqIf3n6zCys3UANldrQRUnbkntc7EcTO6nKcB/
         valNP+BEeU0W0Z+tWtmU7ap1nQ1nR+Php1AubEovuU2doIOKzz27nGX4JSt0BUtxHhNR
         DwIgJSR2/3Q+J6ks+KBAvNLzkaolk4NnVFZGiWFXLJrXVk/WpPI4+i2CXAI5UQZqdYWd
         6A/e0k+ofgQKJ8qKiIZybwCTy7Z9IX4uSDUSt3/L9V9aAnYHdTFXDnTCqToSb3h1ZY5j
         Cbqw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yl2XT4o4xmTSxRTY4hyungOdEWVGVQBxW8ZotUFsrfCNzfpe9d5td+cVvGdts6h1+W0J1YT8FPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hhqJzXZ4rkGP91RWZlsXGzVBFq0YK50FJd8iM/BMuDENFDQv
	3Ukv5Oa8EF38Zi+Yys1UkqyPoKn0GY/CjrZ9bDFx1NLEN4ISgUIEpfi8va4pmLtbqpn6+Z2iZXa
	3Yg3TP8d/aUfwlH3kYe44/HJrfwviMOuKtfvwzfawzjjhnHtLDhlBQKnKSvaS3Q==
X-Gm-Gg: Acq92OEIiqGsUm3pb1zt+HipHg/z4FYhv5mK0ygPPX12G4746OwYJya5iZDxBjF9G5R
	Y3zjRA1vnQf4MgFFrsLERT27KDAYfgvK8jerlnWHcknaFgRVBRDMbVLsWNYwkt4EAdA4K9NDSXB
	TWFTx6CHeUKsAeyv7jdozlq38Gacoc7h0Wcx0fRKWWSJFyVZkM8l4QeYKxmtG6/j2ttx+heZzrc
	o7b6dAFoudhb06sxoowfRHqvr8CeMOXt0XWSrc/9aLDMNW3OfNJu37q3S1V3G5aocmm01Dsjyqn
	dAYxy2unSE/N1+n8BNfsrv1p3XhH7zYCiVbtKibAmBjuVey4QbbDJH4TWcrbJNypbkV+GLgCGNz
	Oh4byGIsIJ9Go7dCfzcctQ1mF0N6Rp4nQZcA4QbI/ZTrAfTJkJWlBfdxw4JF1onurmcli6ifkmL
	MABS7Fl5Abi1yam2c1PAmoy4h7aBTd
X-Received: by 2002:a17:903:2446:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c163a0fd98mr35342655ad.10.1780495336476;
        Wed, 03 Jun 2026 07:02:16 -0700 (PDT)
X-Received: by 2002:a17:903:2446:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c163a0fd98mr35341475ad.10.1780495335559;
        Wed, 03 Jun 2026 07:02:15 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm27170395ad.3.2026.06.03.07.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 07:02:15 -0700 (PDT)
Message-ID: <afde3eb0-6aef-4175-97d0-8f24be9feeb1@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 22:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260528090510.829513-1-a-kaur@ti.com>
 <20260528090510.829513-2-a-kaur@ti.com>
 <e033f55a-2cf6-431c-8c20-f08c98382136@oss.qualcomm.com>
 <191fcae6-1578-41b7-b425-f93abc3b8be7@ti.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <191fcae6-1578-41b7-b425-f93abc3b8be7@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s_b2Hbu5deWF5RIvV4gPWJl_vDv8RQ-u
X-Proofpoint-ORIG-GUID: s_b2Hbu5deWF5RIvV4gPWJl_vDv8RQ-u
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a2033ea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=sozttTNsAAAA:8 a=pIEw26tzc6_NIsGox4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNSBTYWx0ZWRfX+opUokLFb/at
 mmdAyF0xG7e6RROiqPBhvL04HPx/Ow3U1sP22rYQazgmkNMYSwICoU/P7/9PTfgi29i7D10LATu
 ny3igKFNGUmrB6XFuhNIDwSHob7y0xBLoOJU6LUPmXKBv06UZwlYaOdqGXEm2gL2+2CQTFlskKH
 QTy8a4RLiZaj+08HLnsO+hgbf5t9Tddt1VisKNLAbijk8Ce/wXZ1VUn8Hrp+BzYjeIKAxBM9Y/o
 sBIRIXV5MD2WAoovpANbN9t6+6jAuNLHlqwB7bRgmDD8wNLP+Pn5En8jkrMxriz+d7oCb13FLNx
 Czr+5T19XHM6bSC7OL/4LSIICpE54cHvMaUOhHQCbMXYyNvdDH5vzphfn3gxfvVTe7WaHUCZFBH
 001GsZIgeOuRm2786NziYK+I+H9goq0jLmsItNaaef8lsv/0szDF/MB2YmT1wZ3Fo5FmobTJ3Dp
 E5p3xexpQtNQ9I1WBbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030135

On 6/3/2026 3:23 PM, Akashdeep Kaur wrote:
> Hi Zhongqiu,
> 
> Thanks for the feedback!
> 
> On 01/06/26 08:58, Zhongqiu Han wrote:
>> On 5/28/2026 5:05 PM, Akashdeep Kaur wrote:
>>> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
>>> device before soc_device_match() can return valid revision
>>> information. If ti-cpufreq probes before k3-socinfo,
>>> soc_device_match() returns NULL, leading to incorrect CPU frequency
>>> scaling behavior.
>>> Defer probe when k3-socinfo hasn't registered the SoC device yet.
>>
>>
>> Hi Akashdeep,
>>
>> Thanks for the update.
>>
>>
>>>
>>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>>> ---
>>>   drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>>> index a01abc1622eb..8219751da175 100644
>>> --- a/drivers/cpufreq/ti-cpufreq.c
>>> +++ b/drivers/cpufreq/ti-cpufreq.c
>>> @@ -99,6 +99,7 @@ struct ti_cpufreq_soc_data {
>>>       unsigned long efuse_shift;
>>>       unsigned long rev_offset;
>>>       bool multi_regulator;
>>> +    bool needs_k3_socinfo;
>>>   /* Backward compatibility hack: Might have missing syscon */
>>>   #define TI_QUIRK_SYSCON_MAY_BE_MISSING    0x1
>>>   /* Backward compatibility hack: new syscon size is 1 register wide */
>>> @@ -347,6 +348,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>>>       .efuse_mask = 0x07c0,
>>>       .efuse_shift = 0x6,
>>>       .multi_regulator = false,
>>> +    .needs_k3_socinfo = true,
>>>       .quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
>>>   };
>>> @@ -356,6 +358,7 @@ static struct ti_cpufreq_soc_data am62a7_soc_data 
>>> = {
>>>       .efuse_mask = 0x07c0,
>>>       .efuse_shift = 0x6,
>>>       .multi_regulator = false,
>>> +    .needs_k3_socinfo = true,
>>>   };
>>>   static struct ti_cpufreq_soc_data am62l3_soc_data = {
>>> @@ -364,6 +367,7 @@ static struct ti_cpufreq_soc_data am62l3_soc_data 
>>> = {
>>>       .efuse_mask = 0x07c0,
>>>       .efuse_shift = 0x6,
>>>       .multi_regulator = false,
>>> +    .needs_k3_socinfo = true,
>>>   };
>>>   static struct ti_cpufreq_soc_data am62p5_soc_data = {
>>> @@ -372,6 +376,7 @@ static struct ti_cpufreq_soc_data am62p5_soc_data 
>>> = {
>>>       .efuse_mask = 0x07c0,
>>>       .efuse_shift = 0x6,
>>>       .multi_regulator = false,
>>> +    .needs_k3_socinfo = true,
>>
>>
>> It seems that `ti_cpufreq_soc_data` is a hardware description–only
>> structure.
>>
>> After further consideration, may I know would it be reasonable to
>> consider using of_machine_get_match() instead, for example:
>>
>> static const struct of_device_id ti_k3_cpufreq_of_match[] = {
>>               { .compatible = "ti,am625"  },
>>               { .compatible = "ti,am62xx" },
>>                 ......
>>               {}
>>       };
>>
>> if (soc_device_match(k3_cpufreq_soc)) {
>>      *revision_value = 0x1;
>>      goto done;
>> } else if (of_machine_get_match(ti_k3_of_match)) {
>>      return dev_err_probe(xxx);
>> }
>>
>> Just a thought — you might want to consider this if it makes sense.
>> Sorry for not pointing this out earlier, I may have missed it befor
> 
> The structure already contains driver behavior flags alongside hardware 
> descriptions:
> 
>    1. multi_regulator (bool) - Controls whether the driver uses multiple 
> regulators (driver behavior, not HW description)
>    2. quirks (u8) - Explicitly documented as "Backward compatibility 
> hack" flags that control driver behavior:
>      - TI_QUIRK_SYSCON_MAY_BE_MISSING
>      - TI_QUIRK_SYSCON_IS_SINGLE_REG
> 
>    The needs_k3_socinfo flag follows this existing pattern - it's a 
> driver behavior flag that controls probe deferral logic, similar to how 
> multi_regulator controls regulator configuration and quirks control 
> backward compatibility handling.


Thanks for the clarification.


>>
>>>   };
>>>   /**
>>> @@ -443,6 +448,12 @@ static int ti_cpufreq_get_rev(struct 
>>> ti_cpufreq_data *opp_data,
>>>           goto done;
>>>       }
>>>
>>> +    /* Defer if k3-socinfo hasn't registered the SoC device yet */
>>> +    if (opp_data->soc_data->needs_k3_socinfo) {
>>> +        dev_dbg(opp_data->cpu_dev,
>>> +            "SoC info not ready yet, deferring probe\n");
>>> +        return -EPROBE_DEFER;
>>
>>
>> It would be better to use dev_err_probe() here and return the original
>> error, instead of using dev_dbg() with -EPROBE_DEFER.
>>
>> Also, the message "SoC info not ready yet" seems a bit too generic and
>> not very descriptive. Which SoC is this referring to?
> 
> Thats good suggestion, will update both in next version.
> 
> Thanks,
> Akashdeep Kaur
>>
>>
>>> +    }
>>> +
>>>       ret = regmap_read(opp_data->syscon, opp_data->soc_data- 
>>> >rev_offset,
>>>                 &revision);
>>>       if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING 
>>> && ret == -EIO) {
>>
>>
> 


-- 
Thx and BRs,
Zhongqiu Han
