Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501D46AA7C
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090038; cv=none; b=UMMBjaOW9WWXPDa2nCvi5Tu0aaQ9BaKFrVLxZzAkzQ1CEtrV+2+jQv3bOi/7LxwD/FKZGmRsALEpuBEUdty4SBi2Idi9sHehJ2KQninksIo+9CnbUUKGZOtWJdc8dlP5cYLkWjpGaRO0YYV9FKj1z3xAqXdl/cbx4UmPBoaQNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090038; c=relaxed/simple;
	bh=R6W+KIBwAziL+0bmHN9d08M6zXwjtUWjKyDUQQpICbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFsfxFaSJ5L+X+V629x5f7Sh2P9oBfEpp9p8K/QtOYPaoNf/cWn0cRqCKGI0MZ6ycgQ26ON9IHeYrcCt8G2OHrIKLsePhNRwhP/quhQHnh0InYwBedyuvT0jm4sPXoqt7qmSWM7/2cvoJ4ZGKAYrS7tKFhRm1Wv7kUfZDN+lF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6FxO46e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b6fVrc0g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6FxO46e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6fVrc0g"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67780xkc3219574
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 08:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mg60GGen5JLXLiduqgYSWUUEhr6GUTU7AVg+S+hy3xA=; b=n6FxO46eZ50PCYEh
	IyAjClt8f4npcS7X6yb7qN8e96FHkEF+hJ+TD8F+7Ugn+Ew71zbmelcNHGNEhtkv
	Fo54n08iGT9etAwx/CpUBUMe+jItuQpA0MHl7tIXOtXxwztYx9+HpifjFS1lX8gv
	S13lOHw642T7XxE2/UYpe5fecPcBtQxwHXc9PH2jBJT83tTJ1uQu65L9gJ3sU1ux
	M5TPTbSATD0Xh4QS8aN+jA6aN2MgbJjBPr9Qy0Ylk6/ComGvveDB8u5AOXm1ItwR
	+WJgkE9qjI/0ck4D8/nEdj9uwLYCmXjeD7u5Ad/2oDGQHjxrPzvWHh4+cP8TP+mz
	iWS/pQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6htvwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 08:07:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so40117005ad.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786090031; x=1786694831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg60GGen5JLXLiduqgYSWUUEhr6GUTU7AVg+S+hy3xA=;
        b=b6fVrc0godlr2WIBl3DJKYlXkY5tv6Me9H9YrAXmdWVPzV/7wSvLPsqzHnZb3wrQaO
         DCN3MLOkbqQ/EZ1hzLGpQahfrUys79zuL+p4+r0H+Z2qAPYLaMKpXGJsHziDOsFy/Hni
         9E/QbWRRxkkuQxNFaqmP7v+cOigIA65lxO+gnd6saUmdqmVKnFzU5vPF7NCOOa7IQ5tE
         vZSIqcDGQ2deroJSuIsudxJDVGua40VW0nfTfQDxjYzyu89cyJwr2z9JjHZIKaU/XglM
         HKtVXGBNMLdg9ZcK8gl8r/Gky4n9GjVN3xczC0KlUTp3mQzAZibnDkKghk31KD1e0Ssr
         P4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090031; x=1786694831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg60GGen5JLXLiduqgYSWUUEhr6GUTU7AVg+S+hy3xA=;
        b=qCViqMg4Y81z2K2wbJ0bminsgkVrs4hg/8OuJtdHFLZjcBR4PJtuRH23hsiQbat0Yo
         jgozR9rhHvHljUhhGG4UfGiaXPqcFwsCZYIwGcfrNn73lvmZqHKu0tkFUyu5SVytf6by
         j7XuaE/5wNAsOSXtkKLHcIHmeC642EsPuWKc17LMjKIgw8KeUVZTJbfXfK3UemjiewKv
         5GBpf+g/hnH7C2lkiAZGc9jqCRqYEosMNupV+8SCFHBoxvtizDDbDud80Ew80Efg/aRf
         2WP+Cw4VuCM8ST0hSliyPUwoE/MvYNnV1ilCVle56gcmHLFo0MocOlkGN5jv/S4Mxi4j
         whNw==
X-Forwarded-Encrypted: i=1; AHgh+RpIYRj2T2ZW8aBfgBRRWilg1BEC6Zvl9T7e7c0aVykF5EhC0XyQqrPQwgTPWweSYvr6rKjfd1z/gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKX9XQ3wLQk5ooec+4Uc0yqLlXyO0SIduD96D8eVhC82LwJKU
	e+FyVJEEqDGVaEDHuj7nNT9zwp4PA6IhB2lnkpDhKL95qAjQUqRQnD7eSO9MwRoj9gbZJR+iPed
	QXy8MgCocUQgpqR7hW6TokSj9N0K+naKiTh0vCHU/mY44VfQb6zK1q2MuVexUwA==
X-Gm-Gg: AR+sD10tLUyJTXBur8XNuS6VYmlsWNnBetitThxBFqh+0AQq9N4DVQeUriUlYvafueN
	KH0W9dGI5POXPYOL0cKb013NWR9QC6Ur85bgm4NkiWKmrckGJsDjm6X41AogdElXhjTl728C6F3
	ecrzdPs9xzcodZpECh9Ro89M7KyZZGc8xfth/nSKpoE+M+QNTIBzgPzxuJYCm2IsTKfqeEI0bdZ
	Yqs4Y6JRLa2VwG94ROeXrYo1mzHNvNsh32FmpE/r5EByj5Jaz8I3cBD01mvgffBuLAbjFfG8gVz
	WDI9q2/pStNsFPj47HMAnY1hce2JY8LsBSSSPlGAKwt7dw5MNnt/llOyh2j/vWsgOLMRXqLM0lv
	0JMiNWkg2NGvfa/GdpTtm3KbtHpTj4HRl
X-Received: by 2002:a17:903:8c5:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2d106e99159mr91519465ad.22.1786090031379;
        Fri, 07 Aug 2026 01:07:11 -0700 (PDT)
X-Received: by 2002:a17:903:8c5:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2d106e99159mr91518835ad.22.1786090030918;
        Fri, 07 Aug 2026 01:07:10 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccd96afsm5147305ad.24.2026.08.07.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 01:07:10 -0700 (PDT)
Message-ID: <f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 13:37:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
 <20260803011400.1fb6c93a@jic23-huawei>
 <a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
 <20260807001822.31f7c137@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260807001822.31f7c137@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1OSBTYWx0ZWRfX3UEJVyMhE7NZ
 VHBTDDfeHiRNVwmWGZtA9/7mEjI2RFLLOt/SSO/EvdiN8qPKRmEwhKUwns78i8rHjI2uPcz/qwq
 iwKAIZCtVd1qVUoptcOSzdKXi7GZN1A=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a759230 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=m2Nr5YO-714gfbtmP0IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1OSBTYWx0ZWRfX5hof2Ufgrore
 uZIIXBrA1Q0p9IfoXogpX6IBB3gzXk/o7VtRpjQFcDRZH0RkhYab3g6UQkLZ4kZJrfsnB92/MSs
 zKxGN7Ot0cXUnmaJRlpyxQ8CG1eyQB78MZ37XhvqfxiBnGCzvFYGaXSuXV9O6toCsGhMdloMQCa
 LtvjYLggZOBUAgTlheEuRi+vZSIRMFRNBogSrH6FAVHlyPDR2wHcpUWjHTO8Wp50f5wF2rk95xG
 BbVkWcLfqHJMPjPPwzgNprF5HIbgNoCnksPBTHzlxurf7+HFkfx6+Pb4Y9WsIZiXNKr8omRKJKr
 GuYyEa3IfDxgXIB2E+CW1ACEbu9dC60fk5bg1sGC9jNwHkrxf/o9NrjhWPdyFneUtAy/+mUnlsG
 LeM7PtG1+WA09N1ug9lZwc1V34oDL4092NWUjqvr/56xabyZuSBJ9f6ruPH0oaGUogwjH7Mojj1
 RrVXxxKWgXFJm1J2Iqw==
X-Proofpoint-GUID: m_nu6GYykXlAQ4rZjPbrWDNqK_H5NMsi
X-Proofpoint-ORIG-GUID: m_nu6GYykXlAQ4rZjPbrWDNqK_H5NMsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070059

Hi Jonathan,

On 8/7/2026 4:48 AM, Jonathan Cameron wrote:
> On Thu, 6 Aug 2026 16:22:16 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:
>>> On Fri, 31 Jul 2026 23:36:15 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>>>> for improved performance, mostly at the hardware level.
>>>>
>>>> One significant software change is that ratiometric conversion resolution
>>>> has been increased from 14 bits to 16 bits, so the maximum value of
>>>> these measurements needs to be updated for Gen4. Add a new scaling
>>>> function for thermistor channels which use this type of conversion.
>>>>
>>>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>>>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>>>> support communication between ADC on the master PMIC and ADCs on any
>>>> of the other PMICs, a field of width 2 bits is added for bus index
>>>> and the bits for SID are extended from 4 to 5 bits, in the SID
>>>> register. Add support for this.
>>>>
>>>> In addition, it is possible that the master PMIC has ADC of one generation
>>>> and it needs to communicate with another PMIC with ADC of a different
>>>> generation.  
>>>
>>> "Possible" sounds a bit hypothetical.  Can we state this actually happens
>>> on some devices?  
>>
>> Considering existing upstream platforms, this is applicable for SM8750. I'll
>> mention this in the next version of the series.
> 
> What happens on that platform today?  Wrong values?  Should this be treated
> as a fix rather than a feature? 

There is no issue on that platform right now as ADC channels needing this
support are not added yet. SM8750 board files only include pmk8550.dtsi, which
has the top-level Gen3 ADC peripheral and some ADC channels on the same PMIC.
Gen4 support would be needed only when PMIH0108 ADC channels are added.

> 
> 
>>>> -static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>>>> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
>>>> +				       struct adc5_channel_common_prop *prop,
>>>> +				       u16 *data)
>>>>  {
>>>>  	u8 rslt[2];
>>>>  	int ret;
>>>> @@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
>>>>  	*data = get_unaligned_le16(rslt);
>>>>  
>>>>  	if (*data == ADC5_USR_DATA_CHECK) {  
>>> This feels backwards.   We first check for the top bit being
>>> set then check whether we care if it is set or not.  I think
>>> checking if we should look at it first makes more sense.  Also
>>> shorter max line length:
>>>
>>> 	if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
>>> 		if (*data == ADC5_USR_DATA_CHECK) {
>>> 	...	  
>>
>> I thought it was more efficient to have the check like this because
>> there may be several channels satisfying the longer if() check for Gen4
>> ratiometric channels, but the chance of *data being exactly equal to
>> the error value ADC5_USR_DATA_CHECK is lower generally. So if I reverse
>> the checks as you suggested, the outer if() check would pass for every
>> read done on a channel which is not both Gen4 and ratiometric, which
>> seems inefficient for an error check.
>>
>> What do you think, should I make any changes here?
> 
> Efficiency here is going to be hard to judge without guessing how good
> the prefetchers are and to me this doesn't smell like a performance
> critical path.   I'd go for clarity of code and check only
> for the invalid value after you've established it might actually be
> invalid. So change it.

Sure, I'll make this change.

Thanks,
Jishnu

> 
> Thanks,
> 
> Jonathan

