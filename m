Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11711FC0EA
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858027; cv=none; b=GRx2HWYUevwqUMBgDywh4z9S/jgaeD9H0zm4F/FbGenvB6EI6QXJjK3sFkUbl9hnDMCTXjG3gXjOAAdL+5slwTsKMmBVEc4gkiFnL0M+XRGKGQofe71+GVHca6mRdmC0cLxCUlk2YpYXp7OTcWG8lFFJXX0YpzFKMhjFZ8G4hKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858027; c=relaxed/simple;
	bh=BMaFdJwdKh8m0G/mlKvbaQ99VXHfgpu3pT6rHTchjMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rybKQ+HPdzBdzr9Q0fjVCFiVjXXY62LjzpvzqLAGLx6yKsQHQUfBxSaviV2y9QLR/c9k21m6FDquKvn3dakseo2h2VuiVS7g365xoMnMYSJGeQBLPomH+8AravkYQFF4Nko4wy3PiUPUG66TxMDP9i/isQ4/TmLjzB4Kdkhh55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Br22pOco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+9/eYvo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Br22pOco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+9/eYvo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2WrI3322300
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZKjNeaSkkQHHCBSs2ff+g9JaM7hwwYVptVuggdglOjg=; b=Br22pOco/8a1gD3t
	+ZzlSD1nWb/9xDc+dkvLQ+Mi1UQHghw2NDaXoRbHFPgBiA0X1v4D8w9A17NsgTed
	wEp3uhrJdUS3zZzloHmMGJirIttHiNTvqxZUa+inNFANMnxEx5W9tYJETxiuUtYj
	LUvuzk1foJwenu3VFInYBO1LNKy8ufGEQ1etN8nldXST00aB/213jFP43/au3drR
	OziDrL65/ZU7VYV1xPysjfXdeo0lyNW/8w5jiU5MUdBOcmg0IRi0glSOzor3KGEg
	uczejDphfCacIXlTiQz2ve46jEwzNP4E/oDjFyvnuDiZvG/1+qCxFXPkrvOMWhs8
	ByYmgg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edfqk21c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:00:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so10353954a91.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779858024; x=1780462824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKjNeaSkkQHHCBSs2ff+g9JaM7hwwYVptVuggdglOjg=;
        b=i+9/eYvo68OKeTKFY12UogXQk52xy32o5GT7SUiekgpd3VmCKyS1IdfUuIGN0FTSCL
         JUQZtNf3SO+hGBHNiQb9qdjBquAXr2IzDF8UxfsJhDJAuKSFA8DaSXlxAkVKckhcuRL1
         wFJv+ZU5R+4n6DhUF3ui+/Wb9nSU5JqtEaP5zSr0lhEavFWL57yPYTGuXMH7aQovImcw
         7tyjV4wrz1JzcWN23VyXv+kj9rAsCc3JnDmeEcpADa+L7XVP4aYE+ycB0DbwTASIweF6
         ZZwr457tGTHdGfvQeaZwmo1noy4pzQsmgTW1XYIFp6rOLMgMjx9OxcVlJU+Qzx1nwsxF
         JTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779858024; x=1780462824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKjNeaSkkQHHCBSs2ff+g9JaM7hwwYVptVuggdglOjg=;
        b=eboPgHGUuxRN0Y9PBcIL8605C7LMai7EsUC/ssL9J/GbdizY6Hy5puRNVG6MSRMdkJ
         YWwLmh/J8aK1Y38vUcr/WnhgQ5titDB0zMF+QwAjnoK3wUS1sv7MaKbNgC0irlC/EceP
         Zwi3xD4tsXo8KJF8y5spLf+UR66TPaWRlkaQiLdAV2IJAWuw9jlzjD8PAx93G8OkfeJ2
         qJtpP1oKQv4NKbuOQa3qYLeZJVmo+5/jNH8MccxcTYizEbdHZAZEFAo+Ae54sr3mrOfT
         3uKA7GlmcpNNB0flPI0FUAuxQF8bhCF6i/IN518tZzJAlC0xy9dlg1zwde9zAmfGDT+T
         m4PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+ZIVXQfSvbVav7NBlSDwTLUkzQ/9rSyTler6/U8BUD0tYP/eNhVa5OV8XXJ7dcE15Fag2ntSuvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7k71fgd3jzx/V1ov+fmGonSOFCnAoqlf5Zii/AyeT98zc+Kbd
	WvN3COiuXIXauwJPV+LCgP9LkCDza5iRmgftJzWfQ2aHzIptAQE7qWD2GuBR+OUvOC1AlcQ8HTH
	WT5YyjcbP0BWucPCoY+e20EKMDv3L76GFeK5idX9aV9aowglYzO4C20+xmQmmJg==
X-Gm-Gg: Acq92OE4be/BBRTYMFC4PejuvnwH5qKkQTKwdRVDPj5RgMPod5nuTos4WBmdBo727ak
	fRc2PXFyQGiYatAruFSZNhckKtHI6I9SIExabPuVvkCCciCaGHcDgMoFQq2pQFBlYHWpOGhtPjv
	GcABsV7b+sjwFNF1PXJRYvfRhMrbKjteg7YVsX3IkmeBEcgoTUana/s/zytkk510EwURgdT+Eo/
	zzML0kDtF372ANkLYU+RxdVAmMsQT0E0MUEia2cxot0in78u+QvZJtctcX1S97YivyS3ukPl2uf
	NTfCZjKt15lml2JAkfOlAoWWS7O8h1AIQOAdU/4ouCHj6TuTBqivOLHOGB2m+abjxqC2iea61lC
	6KuJs3eZ8c7FiIdxps1hKD/edxkZ0RdkVDx/+/k841gHRZLUKXOeUXg==
X-Received: by 2002:a17:90b:3fc7:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-36a6765a2e6mr21134389a91.18.1779858023973;
        Tue, 26 May 2026 22:00:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc7:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-36a6765a2e6mr21134332a91.18.1779858023376;
        Tue, 26 May 2026 22:00:23 -0700 (PDT)
Received: from [192.168.0.100] ([49.205.253.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b2651ad0asm416092a91.2.2026.05.26.22.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 22:00:22 -0700 (PDT)
Message-ID: <d1636899-7a73-4db9-8f33-843405248d03@oss.qualcomm.com>
Date: Wed, 27 May 2026 10:30:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: switch wake IRQ handling to PM
 callbacks
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
 <20260526-tsens_interrupt_wake_control-v1-1-6adcd75555b9@oss.qualcomm.com>
 <06029f19-86f3-4a41-aff1-d6fbc6a45193@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <06029f19-86f3-4a41-aff1-d6fbc6a45193@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fqPsol4f c=1 sm=1 tr=0 ts=6a167a68 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=7EkVGsDKQkQpIrFIvUsDxw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=863ybj6Vyh57Y2ADhnkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: tenO3DoKpIXTtQbQVYVpA6_Dr-jiOxuJ
X-Proofpoint-GUID: tenO3DoKpIXTtQbQVYVpA6_Dr-jiOxuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA0NSBTYWx0ZWRfX7yAcjFUXE1c2
 O/3HKUFqUPr/HwFhmeeQKRZ6tp6SOYdQ4oagOs8jpN2KOv2rpORPfeBeEtzjFO2wu2KW/OqEKCK
 1TtcE0UNwrsnCh1e4qEpTvy7Bq5EOlIlZOsWZvweZ/ezJ23C7H7xZ1rqg602F9VD+kxkPF30Q36
 Uamkfqwi31kkE/yo9PwTQQX/nTHXnvVGGDXWp+zspoPgjXe2/Tydwap4T71AEPQMX/WCXW2bdhY
 +LfXsF81AEdPalcKtWbWYApH5RXOoOjp1u72XuXh6fleDKypE75wcFPEriN3yS1m7TcdccgZxon
 TBXndJJNmtA2/dPhhpAgtCMLKSJS3QP2Jj6aj4TyGZ/CZd44prf+N4Fmr9yJylR4czfgd2X0JA1
 F0bpstZj1L+4BPYPVAGvNbl07uG6w52TlEPUyca2jHrmSuSqx6JF0buAGJQtaJMI5vk6ufWeBJ7
 l6syYFrHCjcPnJfDgkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270045



On 27-05-2026 12:05 am, Daniel Lezcano wrote:
> On 5/26/26 12:18, Priyansh Jain wrote:
>> This change improves power management by using the standardized PM
>> framework for wake IRQ handling.
>>
>> Move wake IRQ control to the PM suspend/resume path:
>> - store uplow/critical IRQ numbers in struct tsens_priv
>> - enable wake IRQs in tsens_suspend_common() when wakeup is allowed
>> - disable wake IRQs in tsens_resume_common()
>> - mark the device wakeup-capable during probe
>>
>> This aligns TSENS wake behavior with suspend flow and avoids keeping
>> wake IRQs permanently enabled during runtime.
>>
>> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
>> ---
> 
> [ ... ]
> 
>>   static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>> @@ -1172,7 +1180,7 @@ static const struct thermal_zone_device_ops 
>> tsens_of_ops = {
>>   };
>>   static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>> -                  irq_handler_t thread_fn)
>> +                  irq_handler_t thread_fn, int *irq_num)
>>   {
>>       struct platform_device *pdev;
>>       int ret, irq;
>> @@ -1204,8 +1212,8 @@ static int tsens_register_irq(struct tsens_priv 
>> *priv, char *irqname,
>>           if (ret)
>>               dev_err(&pdev->dev, "%s: failed to get irq\n",
>>                   __func__);
>> -        else
>> -            enable_irq_wake(irq);
>> +        else if (irq_num)
>> +            *irq_num = irq;
> 
> You can remove this check, it is a static function called inside the 
> driver which is supposed to know what it does (like not passing a NULL 
> pointer parameter).
> 
ACK, will update this in next revision
>>       }
>>       put_device(&pdev->dev);
>> @@ -1232,11 +1240,44 @@ static int tsens_reinit(struct tsens_priv *priv)
>>       return 0;
>>   }
>> +int tsens_suspend_common(struct tsens_priv *priv)
>> +{
>> +    if (!device_may_wakeup(priv->dev))
>> +        return 0;
>> +
>> +    if (priv->feat->combo_int) {
>> +        if (priv->combined_irq > 0)
>> +            enable_irq_wake(priv->combined_irq);
>> +    } else {
>> +        if (priv->uplow_irq > 0)
>> +            enable_irq_wake(priv->uplow_irq);
>> +
>> +        if (priv->crit_irq > 0)
>> +            enable_irq_wake(priv->crit_irq);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int tsens_resume_common(struct tsens_priv *priv)
>>   {
>>       if (pm_suspend_target_state == PM_SUSPEND_MEM)
>>           tsens_reinit(priv);
>> +    if (!device_may_wakeup(priv->dev))
>> +        return 0;
>> +
>> +    if (priv->feat->combo_int) {
>> +        if (priv->combined_irq > 0)
>> +            disable_irq_wake(priv->combined_irq);
>> +    } else {
>> +        if (priv->uplow_irq > 0)
>> +            disable_irq_wake(priv->uplow_irq);
>> +
>> +        if (priv->crit_irq > 0)
>> +            disable_irq_wake(priv->crit_irq);
>> +    }
>> +
>>       return 0;
>>   }
> 
> If tsens_register_irq() fails, tsens_register() fails, then 
> tsens_probe() fails and tsens_suspend_common() / tsens_resume_common() 
> can not be called because the driver failed to start.
> 
> With the version of old DT without irq, the device_may_wakeup() should 
> always return false (no irq == no wakeup)
> 
> Using the check on combined_irq / uplow_irq / crit_irq is not necessary 
> because if the code goes after the device_may_wakeup() block, it is 
> because interrupts are set.
> 
> 
Thanks for pointing this out, will update this in next revision
>> @@ -1276,15 +1317,18 @@ static int tsens_register(struct tsens_priv 
>> *priv)
>>       if (priv->feat->combo_int) {
>>           ret = tsens_register_irq(priv, "combined",
>> -                     tsens_combined_irq_thread);
>> +                     tsens_combined_irq_thread,  &priv->combined_irq);
>>       } else {
>> -        ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
>> +        ret = tsens_register_irq(priv, "uplow", tsens_irq_thread,
>> +                     &priv->uplow_irq);
>>           if (ret < 0)
>>               return ret;
>> -        if (priv->feat->crit_int)
>> +        if (priv->feat->crit_int) {
>>               ret = tsens_register_irq(priv, "critical",
>> -                         tsens_critical_irq_thread);
>> +                         tsens_critical_irq_thread,
>> +                         &priv->crit_irq);
>> +        }
>>       }
>>       return ret;
>> @@ -1343,6 +1387,8 @@ static int tsens_probe(struct platform_device 
>> *pdev)
>>       platform_set_drvdata(pdev, priv);
>> +    device_init_wakeup(dev, true);
>> +
>>       if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
>>           return -EINVAL;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 2a7afa4c899b..83a8f3580ed0 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -567,6 +567,9 @@ struct tsens_context {
>>    * @ops: pointer to list of callbacks supported by this device
>>    * @debug_root: pointer to debugfs dentry for all tsens
>>    * @debug: pointer to debugfs dentry for tsens controller
>> + * @uplow_irq: IRQ number for uplow (upper/lower) threshold interrupts
>> + * @crit_irq: IRQ number for critical threshold interrupts
>> + * @combined_irq: IRQ number for combined threshold interrupts
>>    * @sensor: list of sensors attached to this device
>>    */
>>   struct tsens_priv {
>> @@ -588,6 +591,10 @@ struct tsens_priv {
>>       struct dentry            *debug_root;
>>       struct dentry            *debug;
>> +    int                uplow_irq;
>> +    int                crit_irq;
>> +    int                combined_irq;
>> +
>>       struct tsens_sensor        sensor[] __counted_by(num_sensors);
>>   };
>> @@ -639,8 +646,17 @@ int get_temp_tsens_valid(const struct 
>> tsens_sensor *s, int *temp);
>>   int get_temp_common(const struct tsens_sensor *s, int *temp);
>>   #ifdef CONFIG_SUSPEND
>>   int tsens_resume_common(struct tsens_priv *priv);
>> +int tsens_suspend_common(struct tsens_priv *priv);
>>   #else
>> -#define tsens_resume_common            NULL
>> +static inline int tsens_resume_common(struct tsens_priv *priv)
>> +{
>> +        return 0;
> 
> Strange indentation
> 
ACK, will update this in next revision
>> +}
>> +
>> +static inline int tsens_suspend_common(struct tsens_priv *priv)
>> +{
>> +        return 0;
> 
> Ditto
> 
ACK , will update this in next revision

Regards,
Priyansh
>> +}
>>   #endif
>>   /* TSENS target */
>>
> 

