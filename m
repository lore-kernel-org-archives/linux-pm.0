Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628038E5C5
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961471; cv=none; b=VQqiTlEXH5Rc24URRs0xDmjBVYi2oLWCV3gZUeTeTPEAqmFJdgNUpnWEL5m7k6bxk4dq4JfS+qax/o7sgjTmc9pIhCfQ/RTzpIV7JVa478PNS+27syREcWjHwgu0RtFd3VEK6B9ykS9mMw5Y622Keus9ZgftxffA+obqd61R+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961471; c=relaxed/simple;
	bh=I8tpmUCdXDnmNTTQPtydXmLa/HGkM/XtUuweTq5GZZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIvB8SdOWD2Rt2aWPV2R2iNYoDgTc/IXR/Su+npJDRBPSSh92BX3GOnHi5hEpA6t/7LVnxw5zq3Xv8weOamLDRwspIqWo/r5JWzAHmp6JGv0Qh8YyWIvlojajV3OYA8sSEcN8u8b29ptIZiY+wsZSx4v4Zgprhk1/UlPH8p4Rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QY/eEHCA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W2/w0H0h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QY/eEHCA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2/w0H0h"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6455KOnB636022
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 06:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kH+3fRsAoaOmnczAkrSERaBxbQ/RJ2t95JOmwFI8TA8=; b=QY/eEHCAQL1hS38/
	9tQmt4izOrLB9Y8j1wsWvGgVcP+qP0d5s/oBd89zmr56yeUlDi/Co2M+FlotfJgo
	Q5ryx4GRoQWzBZhTQ+yqKog/zFyBWlJzByEwl08gsyH+10OzI1DqWhL/dSd+2GLO
	O4jtK7sk41h49XeGug6cow6K5ga73yrNpTmHK3mH6kCIFAiqHQqwR+8b9pGhXMig
	jG7pWBko0nJBLlMvhLq8xuw4It7ITVhlbvjtFbxDbeP5n85HPrLMpv8zDcmfdbTt
	XYH2dHpVK5svb45nxe7dytIyILqsFIZzZsNl+4iAB22llaRmG1J/y45pK23z+XZ+
	WQvVsg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsx4bjk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 06:11:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b7aba0af02so47092305ad.2
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777961466; x=1778566266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kH+3fRsAoaOmnczAkrSERaBxbQ/RJ2t95JOmwFI8TA8=;
        b=W2/w0H0h5a70V9Fr7onNcYQy9YQo1uc208qFsBmSLKZ5LfmHPyOAqNzBXLZDQXpxSB
         B0v96q96Gx33bJao8ouOV4LKbKbhJ5pqe0Qq6q8rYC0BLXbbxMgT8vP74SWUIVwdE7t8
         GUjMJ2iCCnM1f8b4d7KJ2sq5U6xjT7hczkxIfp9Ctvcbef202YLeQgJPr2swcO3lGhQd
         0YqDNfzUcZVxlJHoHyxmvI/Yh18QyBUGBOGmv5bxLMuF9gKft6QV6aPx8XnlyQXpsAXH
         1xOfZUHf3eXoMdRDLHeMBhB4KhaT5a01YUaekWSITJ8SaDeiCi0g5J642aE2byk3aZil
         wyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961466; x=1778566266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH+3fRsAoaOmnczAkrSERaBxbQ/RJ2t95JOmwFI8TA8=;
        b=EeshOL6tnYI85DfueguTDbpZdWtH4EG6egn+HAwiu8tH6U81+uMnK5Je/1eypwwz0s
         blblmSFhcvvj3mI0mBHGV4dJDW/2SJG49PtDybZbBIM0tlIb98xRC1+g926zz+x4bTyY
         r9g7YRFC4/WWew1vbanlF0ycOI2mWT/vQgIZ9QIsk69Hg4LvlTiMSKZnvlrc7lTtXP3z
         YYJCF2o54AMJMsu5gnfZzeWdc3ntSrRXDjqmwVWBh2RG2dYjLqC/r8GfP9abGy8aOWtj
         TFGzvUJEVti0qnuIokH1UaL4zbRjlvyf07gN+2beQiXXglyF4AaGT6ljl6zT7OjroKFp
         sdNw==
X-Gm-Message-State: AOJu0YzLZkdjwMTepEQDr5n8h4mP/+yc8u1ZzFtE+LIftuaymBz56Sp+
	8b0c2/36iAC7Ay+bvwWavw1dWc0G0LtCc/IYkCMPIpw2T1eZuoVxUWGgtq6iv60zb0uM25RHP6t
	mU/BnEgBRRZYXoqkct50/S+O4RnxZzqJ5Mq6nAI8FDnVXBAVrV0ccBWqbnFYYPQ==
X-Gm-Gg: AeBDiesB8MB8oIIvKQ/C9VRBW4ulQyu0yrb0SOOS1D2sm45mTN/FRBFD1X1Ad/U8jIb
	y6Rg82K/TQLbLD4+8dItwqkxjN+8y5ZAEnm9/zBdK29bC1byzSC3dd3Qxybh68bVQjoS437N46J
	qD0kWoYUFiMyz1z2gNxHnSjAztsctDy5Y/4FGP1nlz0a6ELZ9TcWUUdH1VMd9j3hTqtEMxJYSLZ
	g6w/sI1Eetf+umTSjnz2AVLJnUN2B8mLeJq98n/NH3/SUoz52CLXbw02hwRzlfCyJNltIyab9Lg
	PQgwksp4o1p5bPPBcdVsftL5Aca29T4EO9uQP0l5ElCWNmdTTf2gsv22NwbxakCYj1CYPRPZ2Kw
	JtL72oZmqgk7jU0NT4+J4hdI/n2Yn6lZV/nf5A1b4hOL7M4/bmICKzLJdFEWrhEI=
X-Received: by 2002:a17:903:286:b0:2b4:5f67:5914 with SMTP id d9443c01a7336-2b9f283212cmr122995415ad.33.1777961466392;
        Mon, 04 May 2026 23:11:06 -0700 (PDT)
X-Received: by 2002:a17:903:286:b0:2b4:5f67:5914 with SMTP id d9443c01a7336-2b9f283212cmr122995185ad.33.1777961465815;
        Mon, 04 May 2026 23:11:05 -0700 (PDT)
Received: from [10.92.176.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e791sm126025065ad.7.2026.05.04.23.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 23:11:05 -0700 (PDT)
Message-ID: <e473e26b-f4bc-4044-a893-c0f255de6cb8@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:41:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
 <bfecf67e-faf2-4889-b29a-2d4d5cd0d1a6@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <bfecf67e-faf2-4889-b29a-2d4d5cd0d1a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MyBTYWx0ZWRfX+9T/eBMuawfn
 ZZvVwFnIrmJ0oGhXOjf6NrakHeuR3h2z6eoaqd+HOJYvgMpiUOZ+iCFISUXml7a8FQkwihOR9F8
 R6hLtDN6F30vTFMm1bOQnw8487Alhkdjy9a33Xf4fQXhRuO/Dv7LEjRhynKMWQyCjU/J93fnURj
 /QXiMBPXErL311sI5TCu8xY3NhFPcVMGVgEY3kE+StoIfq0OEoAtnmPcOJwzJDAsIKD+2nMuSHb
 0KOFtG4t2vpMe0+9sX18lq/KVtitWDnreElm3MOd1+ZXr2qXcxg9BJFWC7PA10igNDsUGfNNl/3
 G8Ds005NZi/3TQ6QuI1Vb37CJTG5dZbWJ870n8Qk7fX/hUFpGGUYOycBugJG7ARJ7nQ0FPMwLrs
 Mnih602KWETl/vWsS2PD9CndDpG1vaQhbBRVQyru8InQq8W1yrraw9+QQwq9505Fbb3nXJm6SfS
 /em7WmZOCfBV2/7ytpg==
X-Proofpoint-ORIG-GUID: 4LHj-0-xCT7CM9tIHxfJtPLuqz1lN6wt
X-Proofpoint-GUID: 4LHj-0-xCT7CM9tIHxfJtPLuqz1lN6wt
X-Authority-Analysis: v=2.4 cv=LdIMLDfi c=1 sm=1 tr=0 ts=69f989fb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hN-AtFFO3wDZx7e5qRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050053



On 04-05-2026 10:59 pm, Daniel Lezcano wrote:
> On 4/30/26 07:44, Priyansh Jain wrote:
>> The existing TSENS temperature read logic polls the valid bit and then
>> reads the temperature register. When temperature reads are triggered
>> at very short intervals, this can race with hardware updates and allow
>> the temperature field to be read while it is still being updated.
>>
>> In this case, the valid bit may already be asserted even though the
>> temperature value is transitioning, resulting in an incorrect reading.
>>
>> Hardware programming guidelines require the temperature value and the
>> valid bit to be sampled atomically in the same read transaction. A
>> reading is considered valid only if the valid bit is observed set in
>> that same sample.
>>
>> The guidelines further specify that software should attempt the
>> temperature read up to three times to account for transient update
>> windows. If none of the attempts observe a valid sample, a stable
>> fallback value must be returned: if the first and second samples match,
>> the second value is returned; otherwise, if the second and third
>> samples match, the third value is returned.
>>
>> Update the TSENS sensor read logic to implement atomic sampling along
>> with the recommended retry-and-compare fallback behavior. This removes
>> the race window and ensures deterministic temperature values in
>> accordance with hardware requirements.
>>
>> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/tsens-v1.c |   6 +-
>>   drivers/thermal/qcom/tsens-v2.c |   6 +-
>>   drivers/thermal/qcom/tsens.c    | 118 +++++++++++++++++++++-----------
>>   drivers/thermal/qcom/tsens.h    |  22 ++----
>>   4 files changed, 91 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/ 
>> tsens-v1.c
>> index faa5d00788ca..2e0a01348c48 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -77,6 +77,9 @@ static struct tsens_features tsens_v1_feat = {
>>       .max_sensors    = 11,
>>       .trip_min_temp    = -40000,
>>       .trip_max_temp    = 120000,
>> +    .valid_bit = BIT(14),
>> +    .last_temp_mask = 0x3FF,
> 
> This is GENMASK(9, 0)
> 
>> +    .last_temp_resolution = 9,
> 
> Please comply with the SSOT, in the init function compute the mask with:
> 
>      ->last_temp_mask = GENMASK(9, 0);
> 
> and remove the initialization here
Thanks for pointing this out — yes, this approach looks better.
If I understand correctly, you’re suggesting that the mask should simply 
be defined in the init function as follows:
priv->feat->last_temp_mask = GENMASK(priv->feat->last_temp_resolution, 0);
?
> 
>>   };
>>   static struct tsens_features tsens_v1_no_rpm_feat = {
>> @@ -132,8 +135,7 @@ static const struct reg_field 
>> tsens_v1_regfields[MAX_REGFIELDS] = {
>>       /* NO CRITICAL INTERRUPT SUPPORT on v1 */
>>       /* Sn_STATUS */
>> -    REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
>> -    REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
>> +    REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  
>> 14),
>>       /* xxx_STATUS bits: 1 == threshold violated */
>>       REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 
>> 10),
>>       REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 
>> 11),
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/ 
>> tsens-v2.c
>> index 8d9698ea3ec4..814147735ba5 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -56,6 +56,9 @@ static struct tsens_features tsens_v2_feat = {
>>       .max_sensors    = 16,
>>       .trip_min_temp    = -40000,
>>       .trip_max_temp    = 120000,
>> +    .valid_bit = BIT(21),
>> +    .last_temp_mask = 0xFFF,
>> +    .last_temp_resolution = 11,
> 
> Ditto
ACK
> 
>>   };
>>   static struct tsens_features ipq8074_feat = {
>> @@ -125,8 +128,7 @@ static const struct reg_field 
>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>       [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
>>       /* Sn_STATUS */
>> -    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  
>> 0,  11),
>> -    REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 
>> 21,  21),
>> +    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  
>> 0,  21),
>>       /* xxx_STATUS bits: 1 == threshold violated */
>>       REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 
>> 16,  16),
>>       REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 
>> 17,  17),
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index a2422ebee816..15392a17ef41 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -315,10 +315,66 @@ static inline int code_to_degc(u32 adc_code, 
>> const struct tsens_sensor *s)
>>       return degc;
>>   }
>> +static inline enum tsens_ver tsens_version(struct tsens_priv *priv)
>> +{
>> +    return priv->feat->ver_major;
>> +}
> 
> I agree putting accessor functions is a good practice but here as it 
> results in duplicating the function, the benefit is discutable.
> 
I did not introduce this new function; it was already present and I only 
moved it from the bottom of the file to the top since it was being used 
in tsens_read_temp().
However, this change is no longer required as I am removing the use of 
tsens_version() in tsens_read_temp(). As discussed earlier with Konrad, 
it makes more sense to check for valid‑bit support rather than relying 
on the TSENS version check in tsens_read_temp().
>> +/**
>> + * tsens_read_temp - To read temperature from hw in deciCelsius.
>> + * @s:     Pointer to sensor struct
>> + * @field: Index into regmap_field array pointing to temperature data
>> + * @temp: temperature in deciCelsius to be read from hardware
>> + *
>> + * This function handles temperature returned in ADC code or deciCelsius
>> + * depending on IP version.
>> + *
>> + * Return: 0 on success, a negative errno will be returned in error 
>> cases
>> + */
>> +static int tsens_read_temp(const struct tsens_sensor *s, int field, 
>> int *temp)
>> +{
>> +    struct tsens_priv *priv = s->priv;
>> +    int temp_val[3] = {0};
>> +    unsigned int status = 0;
>> +    int ret = 0, i;
>> +    int max_retry = 3;
> 
> Please avoid litterals. Add a macro for max number of retries. As the 
> value 3 is not an arbitrary value but a documented value, add a small 
> comment to tell it is a hardware requirement.
> 
ACK
>> +    ret = regmap_field_read(priv->rf[field], &status);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* VER_0 doesn't have VALID bit */
>> +    if (tsens_version(priv) == VER_0) {
>> +        *temp = status;
>> +        return ret;
>> +    }
> 
> Please use a callback for v0 and v1. Set it at probe time, so the 
> version does not have to be checked at very read.
> 
Yes i am removing version check, instead adding valid bit check as
discussed with Konrad earlier.

>> +    for (i = 0; i < max_retry; i++) {
>> +        temp_val[i] = status & priv->feat->last_temp_mask;
>> +        if (() {
>> +            *temp = temp_val[i];
>> +            return ret;
>> +        }
>> +        ret = regmap_field_read(priv->rf[field], &status);
>> +        if (ret)
>> +            return ret;
> 
> It looks like more than max_retry is happening. One time before the 
> loop, then 3 times in loop. So 4 times in total.

Thanks for pointing this out, Yes correct read will happen 4 times will
update the logic.

> 
>> +    }
>> +
>> +    if (temp_val[0] == temp_val[1])
>> +        *temp = temp_val[1];
>> +    else if (temp_val[1] == temp_val[2])
>> +        *temp = temp_val[2];
>> +    else
>> +        return -EAGAIN;
> 
> We have a, b and c.
> 
> if a == b, then return b
> else b == c, then return c
> else return -EAGAIN
> 
> It is like we have two consecutives successful read. IMO that could be 
> simplified to:
> 
> int prev = INTMAX;
> 
> /*
>   * An explanation ...
>   */
> 
> for (i = 0; i < max_retry; i++) {
> 
>      int value, valid;
> 
>      ret = regmap_field_read(priv->rf[field], &status);
>      if (ret)
>          return ret;
> 
>      value = FIELD_GET(priv->feat->last_temp_mask, status);
> 
>      valid = FIELD_GET(priv->feat->valid_bit, status)
>      if (valid)
>          return value;
> 
>      if (value == prev)
>          return value;
> 
>      prev = value;
> }
> 
> return -EAGAIN;
> 
> (Not tested)
This approach has some misalignment with the HW recommendations.
As per the HW guidelines, 3 back‑to‑back reads must be performed until a 
valid read is observed.
b or c should be returned only if none of the three reads(a,b,c) report 
the valid bit not set.

If a == b, return b
Else if b == c, return c
Else return -EAGAIN

Regards,
Priyansh
> 
> 
> 

