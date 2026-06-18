Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA513ED105
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778148; cv=none; b=RRSatl8uDAo925HsjM4v5EwfOoMhdJqBCG9ys953MsPpqui6PhaMUdtpFNQoth4Wx3qqXiyWF7suzWrJEWisz5ST4BEp6hvnZAsJbeJJr5HQOqptFeq9P9wVChCyjkoUrFwegjc4BUv+hppJdDwZY8n7XevnX6Xo3UoaETlhkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778148; c=relaxed/simple;
	bh=7GQkuyRg+UDBSS/P9xS38Vtou4tB13kaAZH5MkFcybA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJUd3cDuIlR8jVKvuan9Plt7VnBFNcOVWtXxOm1IhvufPJO36iC0rzKWq20G40CwD2cPLezA41gt/Qr4Eplg6EWUVbJZUsplFjqV+L2rRIpSD+R4jE2gmLf8zyHfkW0byPh5KktqV9q7uyOUgcMRHmHWpHaK0+s9iB/SPR5KkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKsp7sSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+Q3x0ZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKsp7sSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+Q3x0ZQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8Dg3C692793
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 10:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=; b=OKsp7sSkXt71iqPF
	MoEK0azKtufcbzTnjKMsKcLZicqHEtdG5zx1cRIMPPWSnhAYfhYFamCRw5UDukQF
	GC7TqJMHWCdzmCkIQvaqynaXDLENCyXiCaG/CgEBOupPhwwokqXG3TGHWjutST7G
	qj5UE0hEH3vopXmmS2qyfaOGx+fImd/EjTzA5+vAhbE/26k0eoo25s7ta7c6Y96C
	hqlSfVjzcJ+vov/bGEh/Wz+Yycxck93O72JlQRQ77EWrkJFmfc3a/Xw7GYlf4yvl
	yX+V/XKEcwJ3Hc3vRBBNIo3K7iUw6TZZpcHz0vQH63MwTe1hfSyupYG29P1Wr434
	QipzZw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2cc31u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 10:22:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8453e61d6f0so555034b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781778138; x=1782382938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=;
        b=J+Q3x0ZQ2z5hZn3R8ecdMVCj/xVGpem+U6o2DgY9taV9vwt6ywLwAKFrs/i+os/Dad
         Ds5u4GzYW73Jrx+Dc6QwJtThIB8TK1u0lEr6niZ0K8pOE+3xRPxDvj0pUdFcdtE9wf6f
         gGibRLnechQu0CASaSWPwV89A+rBYM4Ml3cgWhDPTl8SPiNrfxfMDw4mKVEktTt8gNP6
         crCEtnbXBPdi2vTNYQQMzJ5EWbFRcu0MaG/l2qrhSUfG137CA9seTlC4UWuFbrc8oogb
         SL4CtwxCwjUm0s9txUVDHHEhyF5xFxBDCcEYJlwWza1dXL21+6/7zoZWypYSQy1q0Zoc
         ADdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778138; x=1782382938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=;
        b=LTS7ixfCQpZmAEV6YmDGXRv7mmm0XPv8sg5Bt5yfsini4iF7lM5eU5UOnOCQnQxz7I
         300FJrbaONcXH+79pHURvRXdeYJHp71HRwsheMQ5NLFf9MKK8C0MGaRkLQn8mIZZohA6
         /iT/csS/a3UYziQPrbhDy2zVZzwGPwnyqbkXUrJcaXiiTZ7YVVtoHJcR25Cw8G+IZCoY
         cfbgdmfdfNOh400Kg9uaHGSUj4o9Ua1Yld1RB3iAu5s0+lvXbBh3W+KavE+P5ErGFc2T
         W7hZJSSLJEAFLF8z+Fz+xl4mGKhlKybbp6PyJQfuTrCui/ntaROUROFTU9Bwj40bWqLW
         BPKA==
X-Forwarded-Encrypted: i=1; AFNElJ+CGPZrtld0K+w0nFUcqB4J/J2dHr8sIk+uJ+/3TPANyvd5+6MpxospUh2HdLcUistWJZA0fWkC4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9q2N5CSrr6+anBqEc/yXf8JYMNiMKs6nG0zEvqUOF7JdW9sP
	GpoP76pKeUj/0fQfG8eB521LuxunriO0CvLzOTslBjLxf4dPm5BlLW95Ly04ivyrJoSXWSsrIuk
	LdgFjkf8+gugXptDpYKh251Dylm5VIVTekeycv1m4ElQE/HBSAnkk0aDKDRunrw==
X-Gm-Gg: AfdE7ckHS9fAxMNqcbz+6jFU6icthtYA+bFDM2l48JqrASElbeOBiRgzsrPuwdSB/9s
	7LaxnyCmgsRvPQemyyitubi4FkuM/Q7C2ANJdid3zhw+94cRkC4PXmxY9kJatc8IRVBopE2Um6H
	0kICODRuAgnjb0aYvYkS3xFXScFS0Y8Eotn7dQyvzbC+IBoPJdLdW3YlrtMBgAjH/fSD7Peyqyp
	K8j2V6oh3udjvAH+75UxtVs6BHqib6mBWTr+TXKH2lKyomcCfekLYjudKXHxowVLZYZK1TY2sVK
	iFq/yZ3KWOAT1XIRX2VbGk11CZTAuOXdhYcTBlnqKboKsg/9WQDZD0HEmcRSyTBSMJqobfN2sNm
	LNKfcMbdMmrBr2ZpLwo0ECJ7DJ/fOKmSbBxl+wWD7
X-Received: by 2002:a05:6a00:4c8e:b0:842:2f09:fde9 with SMTP id d2e1a72fcca58-84541991be6mr2404143b3a.8.1781778138580;
        Thu, 18 Jun 2026 03:22:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c8e:b0:842:2f09:fde9 with SMTP id d2e1a72fcca58-84541991be6mr2404097b3a.8.1781778138109;
        Thu, 18 Jun 2026 03:22:18 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84535894715sm3890225b3a.11.2026.06.18.03.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:22:17 -0700 (PDT)
Message-ID: <2bbb3b84-45c8-42dd-8e4c-d5aade9889a3@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:52:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
 <ah9ouLQFI7VtHCWL@ashevche-desk.local> <20260604114630.23ca427a@jic23-huawei>
 <aiGPMqHcz_AkUezI@ashevche-desk.local>
 <d095233e-ac2a-4b50-8a62-29fe1e36c2d1@oss.qualcomm.com>
 <aisELR6v1EWGcmqb@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aisELR6v1EWGcmqb@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX4fHkRlVDDbMO
 N9/Pt2b0r0FNW1Fi9z8yAe3x0KvbsMXwDCR2T6pdyi+tjhLMXoWf3J2OGgo//8aNH7+GDhf2x9P
 jJFXmepymbA6nm9CA/hFMAAdoO+pwJYy8/s+M9gOVR3ZubH+vqUGIYkvXbb7+7H4sXm8ElJj+d9
 Yr5J9dWbIUEI+74MvazRrgosEINq2rFfdWc79FSPxjh8YTquzGR5xF6yCMkUVBHhVcVn+OqaXx0
 GVjRASvB/1F9qYMULvuL4nixWzWvSmoI/CvI6jjJWicchwE/FGD8rvvkrruEFIYuZ4X+w7iDC4h
 JBKdhIgfDkogeA2bkprKr2pzq7NIi9EY7BEVBzgknE9YrD+6ouKn/6IYXjTJ2546drQ52Cl/X+G
 CHEnFON7YWxQ/fW+Rw7p4ChzVRtXz+ENyGiG6BF29qDxn6WsmWRITWHl8iPsm6Cm7lugvKnBSca
 GQxdaX7o81OAMN4yO2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX/6nar1gOnMwG
 qHtmg3KCL09ein4rl4wL8bTa1QcajGm3+GkERc0fTpn4+3FG2eqLXyaPPgEv441Xhepqsns0hos
 dG5s0T7ptY1AuqN0R94wzu1qlc2OZgo=
X-Proofpoint-GUID: IpOgKyuWo8GM7oDv1E6rcD2uFkAl0-fd
X-Proofpoint-ORIG-GUID: IpOgKyuWo8GM7oDv1E6rcD2uFkAl0-fd
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33c6db cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=2FWZ_7yD6c0lXRLnv0MA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180096

Hi Andy,

On 6/12/2026 12:23 AM, Andy Shevchenko wrote:
> On Thu, Jun 11, 2026 at 04:13:07PM +0530, Jishnu Prakash wrote:
>> On 6/4/2026 8:14 PM, Andy Shevchenko wrote:
>>> On Thu, Jun 04, 2026 at 11:46:30AM +0100, Jonathan Cameron wrote:
>>>> On Wed, 3 Jun 2026 02:35:20 +0300
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>> On Tue, May 26, 2026 at 04:26:09PM +0530, Jishnu Prakash wrote:
> 
> ...
> 
>>>>>> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>>>>>> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
>>>>>> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>>>>>> +					adc);
>>>>>>  	if (ret)
>>>>>>  		return dev_err_probe(dev, ret,
>>>>>>  				     "Failed to request SDAM%d irq\n",  
>>>>>
>>>>> Also add a patch to drop this duplicate message.
>>>>
>>>> There is another thread going on this.  It might not be duplicate
>>>> if -EPROBE_DEFER is returned.  The message won't be printed but it
>>>> will be logged for helping debug deferred probe reasons.
>>>
>>> Yes, and I explained that it is duplicated as long as I understand current
>>> code base.
>>
>> After I checked for Andy's first comment, my understanding was that
>> devm_request_threaded_irq would internally call dev_err_probe in case
>> of an error, so this dev_err_probe print above would not be needed.
> 
> Correct.
> 
>> Please let me know if it's better to keep or remove this print.
> 
> You already know my position here :-)
> 
>> And if I make the change, shall I add it in a separate patch
>> before or after this patch in the next series?
> 
> The rule of thumb is to make sure your series won't do ping-pong type of
> changes: when one patch introduces (or moves) some code that is removed or
> modified in different way by another patch in the same series.

Thanks for confirming, I'll add it after this patch.

Thanks,
Jishnu


> 
>>>> So maybe we have been a little too energetic in removing these.
>>>
>>> Or maybe sashiko consumed a bit of LSD :-)
> 

