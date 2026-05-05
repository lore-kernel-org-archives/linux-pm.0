Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151033DDDA3
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967020; cv=none; b=SO1K/7AMncdmDqzjOXgrfYQ9INpRUSd2noJVRExwweMwvX9mPTy6etCf7DEVsriooCBRopuZHwDKYIt1gLBF3dpcHMlxCQ/k7yO2tQwth7Z0x+QR+m9nJ8rcTxRToGS44tpjInIUa4kDYpEWxzMCh2RCQTMVDhD6euW1PeXulOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967020; c=relaxed/simple;
	bh=YIXdhkSI4IBQ2M1gYRb3l31cOI9LtoXRCFRBCa2ycTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMkFPmUH5PpC0t036JpyYrXkjmTmZ3Nj/1b7/mDJkHqSzUYh/QPVMxJ+CqLjsS5wnSk3F4HCY3vR7n9Vzp22Cu8TVoD/rD3xMGHEeOlGZbvM2QtiN+kufoKptJYI7GNxZ5bTXmynYfYsF6SeKmmcEu+Zk/dX1e0WXVd90ZbInCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdIfM8o+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LH6z0DKS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdIfM8o+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LH6z0DKS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456UIOI3467670
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NqVV0Dm3mE9t6xBMdrebrvfWi6udNU8mtnEESR0JZNE=; b=CdIfM8o+KRzrQ6Mt
	Wd178V7/1hW8IFZrTrn/ckaQxJX66Dgp+CC8hIk6f7WNoK3Y7+uwXOl1SPzMvLhl
	x9HwsvpXs5co0X2OTmXSxIIJnWPjJYI2/08M3f8dKCFHkPGCzkWS26Pkc98ZaFkm
	59xNvQt0tcFy5KNdco/+7rcw5SDAJ1/1v/18AEM3qfbsjSUIMt9VtzL5IgPAToNv
	HyqDwml6sU8SkdMDFH/O0S0IG+6U3W0cNZn3ARj24GGUK+PIHOUAFgLz5ygc2dUP
	EmRHILM43BHn7dEccGNG69+C5+ggE4vQw4zbX0lb0akKiatDRYTZiFVbAFolkegG
	uBtXiw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvtjuaeq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:43:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b5f089a5c3so101527976d6.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777967013; x=1778571813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqVV0Dm3mE9t6xBMdrebrvfWi6udNU8mtnEESR0JZNE=;
        b=LH6z0DKSkb5xcWkb1g7LLpDtttm0nIhpsrYFwpd5JB2bB+PZnWrrb/EBqgswY37ceG
         xmvjnjRXNBgBfQAV9ic9Iyz7buDfLyrAXYffWEQ4GpzO1q1EUdQFCLjP6dTUokk9qrlT
         omWJySUQJCsCCUXGOdTNPB9OvGFQQwI7RukdIOEe1fYL72y22wBGA0ljZFYINlkB1lwl
         NhFQMhUcFQu1Iw6S6QO0TKofaxedvcB1Yi+pQqTtroPne4JRfHvY9zRVlhhNfxp0kofE
         keiTW786ybUBoC8KqFS+feMCNPTiNioAny8IGRN8kPB+BAjpZ1mSy284G2UqwYrlvhyO
         fKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967013; x=1778571813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqVV0Dm3mE9t6xBMdrebrvfWi6udNU8mtnEESR0JZNE=;
        b=Hh5csZsSCu2thsHXEQkrEYksRe1mmOcHdUAPxmnd5TStijqz/JvxEuV4+1IVKY17tp
         3DeSdjnsjjHMnxlswrcCQB2W+krRanrrie2ofYXcNdDwJen9HVm+axXhIXb9qAVYknbs
         TcwDxDw566XA+gsWEeicVUU2VWvjwSauq6mOLCuxZGVOUuiJfNp58hLwfsIoZUIcIMJx
         4LGa0isBDIPWt323ZBn55OvbZPZAfeRyD8S1utu9nPPnSlkwKPXz/rlosOgsepV6J1ey
         tkJFhdTnpbYKRTWNhMz9KR6qOK7/1Q4xXxA+Hi3fNv+OVI1oxWcxvgeYhshhNRjXUmua
         WrCA==
X-Gm-Message-State: AOJu0YzacdjJ7t5qwndYgNUSfiFxipmc4+H21P5duBimP9IBmLv7QvtX
	ltjwq0dUWQVvxyNJiXyj8Fbls3HZrq+s8K3fpNSTDVOZ7Y0uVWCVvy9uei6aePCkgGOWb2oikOj
	WTFsnlETFR9yqf7DT7OLHxjViS03oP3BJJksMJnT/mV1Aqjkq5G+FPW/pi2yFJg==
X-Gm-Gg: AeBDiev18dDd6+x5RCAef2fsZW7wzqleh8BL7GOSin7ZAlZFWsgJoNXOwlwjZ0ZTuOy
	te0FQAUJosp7Ma7yAVix76A8culQLAwWEHrOJ0WbOq1//seBiUxw7F9wOgyuWBn5WX1vqhhW5Ni
	drAiV5vowfsLT/lxs/G5v1YzwF7wuoXbhICar44pdZtjckNy77QhEBx55XJxJe3jMtKrzYFYuni
	/X3IU3WwirnaFJjq1D4vBGKzO8dOJ9uy2Lvfdeb3HiKhbWDDj5x7FMKHfGwP0fQ13vhDQQllINE
	dOOpWtLit2eIQBiNAsDhwVjUpzO8NG40GufFNeE1PWAfaVuHLqXvKEbZLlpsSx0IdE3qnZXACbt
	+BXW7ZQh3QJewhcr9emvBkupE8MhNB5/Q703GOuNIQ8xC8QEbORg2vccqFCXlgA5mfzXuSmnha/
	ocMcUEf0dGrBolmqsw
X-Received: by 2002:ac8:588a:0:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-5104bcba50emr188220411cf.0.1777967013509;
        Tue, 05 May 2026 00:43:33 -0700 (PDT)
X-Received: by 2002:ac8:588a:0:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-5104bcba50emr188220161cf.0.1777967012954;
        Tue, 05 May 2026 00:43:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17ff3659sm10970165e9.18.2026.05.05.00.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:43:32 -0700 (PDT)
Message-ID: <0d95cd5b-01a8-44b6-bd4c-a7e5fa81e181@oss.qualcomm.com>
Date: Tue, 5 May 2026 09:43:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
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
 <e473e26b-f4bc-4044-a893-c0f255de6cb8@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <e473e26b-f4bc-4044-a893-c0f255de6cb8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OMlGFMe5S2mj-yOohTSA5QpjDDun8TSV
X-Authority-Analysis: v=2.4 cv=KuN9H2WN c=1 sm=1 tr=0 ts=69f99fa6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QoiBiMnBE-sNsCsPl0cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3MCBTYWx0ZWRfX/onxfbRkT7aV
 oemlefk8lKQuO82795L6h4l3LBhBK7o5nZYF17tviR1LpsZIwCFSrWtS36UDq4bmHQApNJOF9Wg
 WIUAKY0Hzf9ba1KzetNfXc3v0Wsph3uVvMxMVSp+Wc7wQfe+iEGx8cXzS3omqdd2bA8oyEJx3Yp
 5QPt3xI0wSwEjXrTWz5PhkifQSq1j3T3SziqZhR1R2jj1/KiKi2XQoqqgGLFEQoJJsSZZDHePhF
 c1Aexsv5Vtnf07n0N9Ww/ACvL/cBXCdk7mcg96bIeX3ADu+iyis77DiXviOHN/oypSya0ZbLd7F
 URwTUOVoZqDYfVc6RZV0WJObgIUDPRzeEy6ZJRC5lmwG12KRDrCGXUv2uxSQUG2tR5OAvjY7iZY
 ihb3MltM6FQAo6QtBD+gzwhBG2HBi+/KqUWle9oe2fe6rUKGhSqXbWW5lipwdJUnonb5b5vflbj
 o2IknPTijWnn5lOpurw==
X-Proofpoint-ORIG-GUID: OMlGFMe5S2mj-yOohTSA5QpjDDun8TSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050070

On 5/5/26 08:11, Priyansh Jain wrote:

[ ... ]

>>> +    .valid_bit = BIT(14),
>>> +    .last_temp_mask = 0x3FF,
>>
>> This is GENMASK(9, 0)
>>
>>> +    .last_temp_resolution = 9,
>>
>> Please comply with the SSOT, in the init function compute the mask with:
>>
>>      ->last_temp_mask = GENMASK(9, 0);
>>
>> and remove the initialization here
> Thanks for pointing this out — yes, this approach looks better.
> If I understand correctly, you’re suggesting that the mask should simply 
> be defined in the init function as follows:
> priv->feat->last_temp_mask = GENMASK(priv->feat->last_temp_resolution, 0);
> ?

Yes, that's correct


>>>   };
>>>   static struct tsens_features ipq8074_feat = {
>>> @@ -125,8 +128,7 @@ static const struct reg_field 
>>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>>       [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  
>>> 7),
>>>       /* Sn_STATUS */
>>> -    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF, 
>>> 0,  11),
>>> -    REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 
>>> 21,  21),
>>> +    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF, 
>>> 0,  21),
>>>       /* xxx_STATUS bits: 1 == threshold violated */
>>>       REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 
>>> 16,  16),
>>>       REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 
>>> 17,  17),
>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>> index a2422ebee816..15392a17ef41 100644
>>> --- a/drivers/thermal/qcom/tsens.c
>>> +++ b/drivers/thermal/qcom/tsens.c
>>> @@ -315,10 +315,66 @@ static inline int code_to_degc(u32 adc_code, 
>>> const struct tsens_sensor *s)
>>>       return degc;
>>>   }
>>> +static inline enum tsens_ver tsens_version(struct tsens_priv *priv)
>>> +{
>>> +    return priv->feat->ver_major;
>>> +}
>>
>> I agree putting accessor functions is a good practice but here as it 
>> results in duplicating the function, the benefit is discutable.
>>
> I did not introduce this new function; it was already present and I only 
> moved it from the bottom of the file to the top since it was being used 
> in tsens_read_temp().
> However, this change is no longer required as I am removing the use of 
> tsens_version() in tsens_read_temp(). As discussed earlier with Konrad, 
> it makes more sense to check for valid‑bit support rather than relying 
> on the TSENS version check in tsens_read_temp().

Ah yes, makes sense

[ ... ]

>>> +    }
>>> +
>>> +    if (temp_val[0] == temp_val[1])
>>> +        *temp = temp_val[1];
>>> +    else if (temp_val[1] == temp_val[2])
>>> +        *temp = temp_val[2];
>>> +    else
>>> +        return -EAGAIN;
>>
>> We have a, b and c.
>>
>> if a == b, then return b
>> else b == c, then return c
>> else return -EAGAIN
>>
>> It is like we have two consecutives successful read. IMO that could be 
>> simplified to:
>>
>> int prev = INTMAX;
>>
>> /*
>>   * An explanation ...
>>   */
>>
>> for (i = 0; i < max_retry; i++) {
>>
>>      int value, valid;
>>
>>      ret = regmap_field_read(priv->rf[field], &status);
>>      if (ret)
>>          return ret;
>>
>>      value = FIELD_GET(priv->feat->last_temp_mask, status);
>>
>>      valid = FIELD_GET(priv->feat->valid_bit, status)
>>      if (valid)
>>          return value;
>>
>>      if (value == prev)
>>          return value;
>>
>>      prev = value;
>> }
>>
>> return -EAGAIN;
>>
>> (Not tested)
> This approach has some misalignment with the HW recommendations.
> As per the HW guidelines, 3 back‑to‑back reads must be performed until a 
> valid read is observed.
> b or c should be returned only if none of the three reads(a,b,c) report 
> the valid bit not set.

Right I missed the point the HW recommendations is to read 3 times in 
any case. Maybe replace if (value == prev) continue; ?


