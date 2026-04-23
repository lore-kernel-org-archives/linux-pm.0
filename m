Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F4317145
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957438; cv=none; b=GWp7HFBFW9kUFAs/3ZSMEQaHH8ooMCbs13rIFDSYeFGeCNrdhTJkw4WjMmt9bBLH7ou7o+3OvuBPfsKfKe/JBCx3P2bFHYV5nMcU8EDFWoxklSGCLRZ96UmRXlZ++l5dks6Xk0GC1yxwEex0uyfZ/ZdAFlDg8JX4fH3rQ94fCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957438; c=relaxed/simple;
	bh=gaE8mNQT6IPknLkLLO6v/or9S4a6F9swdPDSRgxH6eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6K0cIQQHOoYy0naVGONm/LqBVSp4I9OAgx0UgzIlqykSsMGQcJXVzYtPe36436WK+mStX2q60ABVPtBJVV0n7itPyn6HKCgiUmSITHynhnKMYsVZZDv9WE3I3v6dN0PZw12GMzSIh+PjiSxVqDZZu/6nAoM4efWeCXQ67boC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PA6gL6/3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xo0BsJ62; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PA6gL6/3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xo0BsJ62"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NBxBxK010534
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eze/1plM2v1qn5QnTvk0ysvssVshSt8k0/rXfQex3Xg=; b=PA6gL6/3dqpWMUfW
	jEkt63+YX5zSJ4fDKeSX6I0cS9gGGPnzeX0g16rPwysV6c1G3Sdxr9/EHJgS61BH
	apN6HLXVpgRHrhjy35HCYO74wSh5ud8aQgRrhIXzQPhxd3cgcnO2z8OpxaN5qy2u
	PQGatrXMIpHgAeakubttffluTsQzVZbQfsMPtjxWs6TgwoSa4VFpwQZvKcTQ5m9x
	Xr77nDCX+F4E4QA10o08WcIcwVL6ERjkHSKgVCRoskcpUDop90IAJVlfIze1gstY
	egS/4r8ycsjCO7Ed0HaMQAahN0mSwVRKQTIWM9dghK2WiZNdZo32t3lTTZHLhceh
	uBnBpQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk178rv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:17:16 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479ef25c477so2659267b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776957436; x=1777562236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eze/1plM2v1qn5QnTvk0ysvssVshSt8k0/rXfQex3Xg=;
        b=Xo0BsJ62Hxjv46R7YE4QCdMgwn+ifZsRAlOnsNyqygEMwgo7mkpAYLjjvnPIZorueF
         /mmKomef6lTnP1zBsQ5SJPBzeJNe5zYEGvobw8UXlDzukdEXF1dn3r7VaRbeoAL3V0de
         p9oousPnAKcd3lTGtWaVu4VeQDLuSZ3D6wK3RADjc3Whv75VYKAn3FC+D4C8EPrmK3AB
         Ht71rsjHEkRStoYHWyvp/r3c1z4pKfd1DrAcItG5iLe178+tJUz8VYdWw5kBnUhf6L2u
         eTOUD4yxBhf2jiNfm9oLk7glHQqEc/0BRJ6OgNfnZwBTL2SSFthkkv1V2cYa6HyZ/X5A
         UPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957436; x=1777562236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eze/1plM2v1qn5QnTvk0ysvssVshSt8k0/rXfQex3Xg=;
        b=S4jNnYD3XZ7IFwWx+6YtaF4poVhJB/gwPHA0kl9lVVv2BTqbRI0Qm/p5liyG3Rwt0J
         JLemCltlWxjPqhiZE6EfpuOWd3F+ey5ryjqPfZP09HO4IiXuq8Q5pvu4VcEnH8e3lUPu
         LmLAjm93GLNp9eonzbqcefZMDhKKaEO4x16YfyD/unOCeunEECgIN2xuqU3dSnuSUO2r
         SjeCnE871Gwj0zDcIJMEhcAHoHYenh8CDbkhiskWtUeA9P4MB47//2O0CcZs7vSFm8/n
         9D4/HS5nlE8MolXZPx+mIOnXvMmJjOvmzD8MBUJtPwJsMtCmyNnyrjq6+nJyLwii5+n9
         hfjA==
X-Gm-Message-State: AOJu0YzIkii9BiPnHq/iqToYO9ul3a4q0/tdYSAfopOyrPXbH31s8Ca3
	VQUGZkmCFjkFgGCM318bARWdkGpLo4STlONerXB14nBHpb8PI4OLqltgHXzmAJxIv7Ln2fqUtSu
	E6HCYsKnC3s2ZAulaMl/8t/0ZZhKZfVGpQtKc1T1hetBRBIan8s4RJi7TMwK0Qw==
X-Gm-Gg: AeBDietDveQ7M4GglCT5h6kcg/ZFyFU6KxNAstYceuM8fBKKH5Ad5E1YjrW4f8SLgtT
	maxzxjvuBqcHmPsGmB6Y+ZzlDJL2twXn/pPm81LGxbXrsOC6S5JNewh3b1jVXCwLaBHea9GLSNS
	PEMpY4TTBCsfeE9q3lufDJjEQrzzd2Y6YBnX0Z4oBFRpeqXwdbGFubhDHaixdr197GMjS76kgC/
	m2EmXGgMENIdiwgt7QNAqS/JHdLOh7/ZW64P4mcofpWx7hK+oHXczN4dTQbVnQNC+uzBJvPw5Xa
	QPDoWuCV/oHvgEB6JWIDPLLssUvpcVYNdnGSW6Y8+OKNWZgGUU+UiWlxmzjLfaxhyDo9pZY1i/h
	gChsHGyrSc2eZ6zgOz/jwrS7oImLiWXBH5o47B2MFbpYMRizDT3uU9t0BKzobOT5iQqPrRRn3IC
	R+pNg5V2R/hFRlHxCt4AQ=
X-Received: by 2002:a05:6808:50a0:b0:47a:8c2:a558 with SMTP id 5614622812f47-47a08c2b6a8mr4055139b6e.43.1776957435921;
        Thu, 23 Apr 2026 08:17:15 -0700 (PDT)
X-Received: by 2002:a05:6808:50a0:b0:47a:8c2:a558 with SMTP id 5614622812f47-47a08c2b6a8mr4055087b6e.43.1776957435470;
        Thu, 23 Apr 2026 08:17:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8a9b:1477:c29c:4bcb? ([2a05:6e02:1041:c10:8a9b:1477:c29c:4bcb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm502913835e9.0.2026.04.23.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:17:14 -0700 (PDT)
Message-ID: <8a4dcb94-ab88-4559-9027-49308ad02b73@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 17:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] thermal: amlogic: Add support for secure monitor
 calibration readout
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20260421-add-thermal-t7-vim4-v3-0-a2e7215ed003@aliel.fr>
 <20260421-add-thermal-t7-vim4-v3-4-a2e7215ed003@aliel.fr>
 <7aaa7873-9274-48d8-a6fe-cff4239b03b4@oss.qualcomm.com>
 <19d70883-21db-4963-841d-7c00505e0d9e@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <19d70883-21db-4963-841d-7c00505e0d9e@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WGIGtfNB48K1eBRiH5lG9rt6p480RRXD
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea37fc cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pD_S-A0WoN6OyM3pGvIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MiBTYWx0ZWRfX0gwmNwdcDdzu
 wZ4hH3RJouD01qEoINsh5YFEEeavUwZkes9fyE2aqsszd4yfotU1csZtHa5Y++XnuujCUKQT1sC
 uiFEDtZbITxzyoolI6RyluBrkabc8ahvaBqSWwSNoU313p7UAP9CL0WGGuB2IaCMttn/oucFu9q
 VO49wpJcfMwBd8/DxCA0Aj1P/sQcxaQgjOwneeWyyUIqxJ5TVwQlLCLZLOqiUjRe/ZWdDy6WavE
 +5AtZ1vaehyFZu7bK/5USxBEgwiY6Pp6wxMmyPCiJRG+3VUphgEPaqwXt0rz00P+mhCH5U254xK
 0IZu/1IvfMowlnmAgfovNypEmMxBOANf+lpZGaLsfumP3jua+/N5Gn1bG64LORlgwdtY0GwLmVw
 8aql8hbYuHmFcHv+4vKjRnGmwVBy9NzIgUJvNRK0ubnHtKtSXDz11K5q6SrZcmZ8BIV0+0uAqLS
 mh8yIUQMmChO41FoOSQ==
X-Proofpoint-ORIG-GUID: WGIGtfNB48K1eBRiH5lG9rt6p480RRXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230152

On 4/23/26 17:09, Ronald Claveau wrote:
> Hi Daniel,
> 
> Thanks for your feedback.
> 
> On 4/23/26 12:25 PM, Daniel Lezcano wrote:
>>
>> Hi Ronald,
>>

function1() {


>>> +    if (pdata->data->use_sm) {
>>> +        struct device_node *sm_np;
>>> +        struct of_phandle_args ph_args;
>>> +
>>> +        ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
>>> +                               "amlogic,secure-monitor",
>>> +                               1, 0, &ph_args);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        sm_np = ph_args.np;
>>> +        if (!sm_np) {
>>> +            dev_err(dev,
>>> +                "Failed to parse secure monitor phandle\n");
>>> +            return -ENODEV;
>>> +        }
>>> +
>>> +        pdata->sm_fw = meson_sm_get(sm_np);
>>> +        of_node_put(sm_np);
>>> +        if (!pdata->sm_fw) {
>>> +            dev_err(dev, "Failed to get secure monitor firmware\n");
>>> +            return -EPROBE_DEFER;
>>> +        }
>>> +
>>> +        pdata->tsensor_id = ph_args.args[0];
>>> +    } 

}

function2() {

else {
>>> +        pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
>>> +            (pdev->dev.of_node, "amlogic,ao-secure");
>>> +        if (IS_ERR(pdata->sec_ao_map)) {
>>> +            dev_err(dev, "syscon regmap lookup failed.\n");
>>> +            return PTR_ERR(pdata->sec_ao_map);
>>> +        }
>>>        }

}

> Sure, I will do that.
> 
>>>        pdata->tzd = devm_thermal_of_zone_register(&pdev->dev
>>
>> The thermal zone is registered before calling
>> amlogic_thermal_initialize(), thus pdata->trim_info is not initialized.
>> When a thermal zone is registered the thermal framework reads the
>> temperature, so it reads an invalid value because:
>>
>> devm_thermal_of_zone_register()
>>   -> thermal_of_zone_register()
>>     -> thermal_zone_device_register_with_trips()
>>     -> thermal_zone_device_enable()
>>        -> __thermal_zone_device_update()
>>          -> __thermal_zone_get_temp()
>>            -> amlogic_thermal_get_temp()
>>               -> amlogic_thermal_code_to_millicelsius()
>>                   [ Use of uninitialized pdata->trim_info ]
>>
>> Right ?
>>
> 
> Yes, I will move the initialize before the register.
> 
>> IIUC, amlogic_thermal_initialize() can be also split and moved the
>> corresponding blocks to the functions to be created in the comment above.
>>
> 
> The SM and syscon setup will be extracted into two functions.
> amlogic_thermal_initialize() itself is kept as-is but moved before
> devm_thermal_of_zone_register().
> Let me know if you'd prefer a different approach.

In the initialize function the following chunk is added:

+    if (pdata->data->use_sm) {
+        return meson_sm_get_thermal_calib(pdata->sm_fw,
+                          &pdata->trim_info,
+                          pdata->tsensor_id);
+    }

I was suggesting to move it to function1() and the rest of code from 
initialize in function2()

That results in amlogic_thermal_initialize() to be dissolved in 
function1() and function2()



