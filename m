Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BF31A053
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970924; cv=none; b=c2j8tvofjKdkwx/D61JpHMSBZBoS72j4Osd2lbshwpqDancKKE2n3CH6qPLVUn7JZCcJ6Zae+B+lmsnjTb0gWcTmGA+r3i+uMLxomJYqh0MMEO4kixyHvqRdTYsSMsD7Gk6pMIlq8NN91Y9jqJkg3Da4OZ8bOya08XvozMDOAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970924; c=relaxed/simple;
	bh=rcm/a/MRtt696rd2hkCBk989dMVF2oY1LYS7HTWHUKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ7WUksRVYxhfTBUxj9HY/ecIQn7yiOp9q2TLsTpII9RXNz/xD2LxmRk9uX+lEYNhBgBrhm4jMSLLSUG8I812yBGja13QBFB7NYYdNjeCfpvBRUOLZltbYfpoTu8ag2VhDXCcn/UlXVg//Ydok+1PsT83lEuSh3oKYHyVW6Q3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hg+68iqp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3FB1a6S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hg+68iqp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3FB1a6S"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458VF2Q1346341
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 08:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bgHh7EY/77BObta7BrqRKnbHiZ/J9XmUTAVLTrHyjt4=; b=Hg+68iqpOytGicwi
	KbD9LdqH7sfMYjlqP9pbOoWGTU6VFK34AL9EzmDQ5nvUEEF9A05N9XEw6Ye/YmoZ
	O4cjflfDfXFbM0/T66aFec1MaMeieKzGYmMsJBhbPOnPvk9GGKRCxUR08gtN3Gbj
	5S02hjLCZ9wsJOOiXYnP1YESBTIxh6Gl8SCYcu4JWmej+3d1wseykmANZMWyEXeN
	Pz67w3aXdj8erw0MkE2bEVkBMICuAduov5WDvgrHtBgOANj6MfEPrturWRkyEdP7
	DHU/0bKKksAprH3Hnk902+1HB951b8LoFgc6iZPQ28pGqVkzeJT9bLYC+fNjTeDO
	DLWe2g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2xb6p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 08:48:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3653e382405so2331997a91.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777970921; x=1778575721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgHh7EY/77BObta7BrqRKnbHiZ/J9XmUTAVLTrHyjt4=;
        b=A3FB1a6SQEsteJBw1nrNmYFyTTjF9/dAGa4NgjAci+ZOyJWn1UIc+hJ0my86boKLox
         jpdmgAtRa+H6RUamzAAQeroTrQ7kQ+ExcIeBY3ow6IyzRhJXDet0iyL1/2r5+TqZmz+z
         dWK1vhVhoTOh4E6WWzfSU0o7T8k2uFWD+bdADZ1tH/k993Mn83Ic3m3zA5NUYHoCnx3s
         DcdwQbuZ1yL8NEzpeNV/s1auOm0IJl9aEi4xSwklz9yDGWBlFirKMLsrt5lUdHzXhyk6
         uy7rHCjFmIuTBWK+js0W19oU/9ysU52qAZ3cq+xXXBGE/V42F8kwnVvGVOc04rhT2sw4
         7+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970921; x=1778575721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgHh7EY/77BObta7BrqRKnbHiZ/J9XmUTAVLTrHyjt4=;
        b=MerDZeOU7BDvWIes0dg0nMg3sV34CkhbaVPS0txtl98EPy2TY8xBB74AICHHRqYSUu
         HHMkKmKW6x9NaR+eXeCC1hHm492xMJ7OZNWzMM0vS2HgA8uDLGMSrh8oHvSHtP5VSHnd
         1oALUqjfAZyVo71m67wwKwIvE1Yi2064H7eKy+e8Qo2QXeLf2Feha09b5NsiRmr3pWOa
         9JM3ujECgdA61aN5Mbr28Z4f8fjB1AiVM88+/kGzIxs8NjDQUEBvIMQXy1dmFMe31BOS
         bKHW8bSp6luvnA8f7SjDlbfeRp22izY8NFWoGW1T2rtiaTMuk4Dpsi3yySBo085TTedV
         RPVw==
X-Gm-Message-State: AOJu0YzDFf4moj3HXVYkpXYLGt3DXVUP7GpIn+HbBfUDZ983kAToeWEc
	CqriWRxnA/p5blVT206kgnfFpk8xMFhKRDszgc0sIavNQVdRAccMtTXU9aR5ZvHbUGUlG5Pgj0T
	rvIWyghjGZnYMLldycTCK6/ild8Qi5IoHRhmHk9Ezp6dvKYkdWJnTqU1qVNJcjA==
X-Gm-Gg: AeBDiesA43Mc2PW0MpXqOdAvyZnD/DqJ/fPfINTdLfTosqT4qG821QF1iiDQyqBp8g1
	gt2sIORWNLiam0sqHPZVy5s07pVhkc1iG2iukhBEZXmz+S6wQqs0sKexKPPlgnBl/eTkDYw7pue
	NYY+On3HFRXSgcJCeSllKK9h+5mLHUrOQMoUdfu+yRlf4/zAL+OBPmCnFO9r59CLE7MhscsT5s4
	1kFq0ICt/ypmAC9mXRybq3cOcWnbNHYCpt9tZ6vqaRDYiZL5bo9oCiV0eQNB8WeHXk+g99b6S7E
	obUg+Lgq8Cvz26MO65ONF2XbgvdR9GRI43sOWuVuspqivkPubhqMkK2FfFaGJZj/TY/1E7aYIs7
	8Utq4wPDl2TGfWQJ2JW2UkRCCL7/sfN0mejgh7MRU514nL7xBengnA2pGeWiIzMo=
X-Received: by 2002:a17:90b:4ec5:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-3650ce8ef90mr13223348a91.14.1777970921341;
        Tue, 05 May 2026 01:48:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-3650ce8ef90mr13223322a91.14.1777970920866;
        Tue, 05 May 2026 01:48:40 -0700 (PDT)
Received: from [10.92.176.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d1c70d8csm25681785a91.13.2026.05.05.01.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:48:40 -0700 (PDT)
Message-ID: <1dd4746c-e93b-479f-8aed-ea9a21a03316@oss.qualcomm.com>
Date: Tue, 5 May 2026 14:18:34 +0530
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
 <e473e26b-f4bc-4044-a893-c0f255de6cb8@oss.qualcomm.com>
 <0d95cd5b-01a8-44b6-bd4c-a7e5fa81e181@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <0d95cd5b-01a8-44b6-bd4c-a7e5fa81e181@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f9aeea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Z3jtgVVlpKzii3TN01EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: czWRv2RhwfoVqdV2KJq360RF-PBzPEcw
X-Proofpoint-GUID: czWRv2RhwfoVqdV2KJq360RF-PBzPEcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4MSBTYWx0ZWRfX5ZS08NZzsaDh
 NtvpKhPYYkW8YZZUJNkkDqNUIUe2eeK4qRmsR5tSVAMkpdrkQkfLzDe6cy0WObgxTPoRnEtlXOQ
 tXdUUup/FihkeveBVivzB+e5nRLNc0YxO8mAHbOUKClLihLqtZ0KgIISpaVATMLYmzs9hMwqtV4
 M3io1xK0bE3xqXVZd2P/aUgJqNO5bs4QclSNCYcjb5wEVyUoPNC12UW6XPYzCVDgr6sosAxXiix
 lrSp4H5c0axmesiG7UBA4E8RTqfPmCfGwqceiwtj5IbtLj2bc+1Dpzc92sttikaTCmbAc13pN17
 0zvdkmsQ0ITn9NCML8qoIlVLWsCn78WkzAXBHX1Ts5gGtWzXcegd/G6olMvuOyFL+3JmuvzVVTT
 PkJJRJ+07J/u50IP1k9SpK7igl4eWTapcYjT2Pd45rBHyRHtyfK7lqkW53of/lsmVzHP49jZLM/
 Dex+fmRDACKpBqjBH/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050081



On 05-05-2026 01:13 pm, Daniel Lezcano wrote:
> On 5/5/26 08:11, Priyansh Jain wrote:
> 
> [ ... ]
> 
>>>> +    .valid_bit = BIT(14),
>>>> +    .last_temp_mask = 0x3FF,
>>>
>>> This is GENMASK(9, 0)
>>>
>>>> +    .last_temp_resolution = 9,
>>>
>>> Please comply with the SSOT, in the init function compute the mask with:
>>>
>>>      ->last_temp_mask = GENMASK(9, 0);
>>>
>>> and remove the initialization here
>> Thanks for pointing this out — yes, this approach looks better.
>> If I understand correctly, you’re suggesting that the mask should 
>> simply be defined in the init function as follows:
>> priv->feat->last_temp_mask = GENMASK(priv->feat->last_temp_resolution, 
>> 0);
>> ?
> 
> Yes, that's correct
> 
ACK
> 
>>>>   };
>>>>   static struct tsens_features ipq8074_feat = {
>>>> @@ -125,8 +128,7 @@ static const struct reg_field 
>>>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>>>       [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0, 
>>>> 7),
>>>>       /* Sn_STATUS */
>>>> -    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF, 
>>>> 0,  11),
>>>> -    REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 
>>>> 21,  21),
>>>> +    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF, 
>>>> 0,  21),
>>>>       /* xxx_STATUS bits: 1 == threshold violated */
>>>>       REG_FIELD_FOR_EACH_SENSOR16(MIN_STATUS,      TM_Sn_STATUS_OFF, 
>>>> 16,  16),
>>>>       REG_FIELD_FOR_EACH_SENSOR16(LOWER_STATUS,    TM_Sn_STATUS_OFF, 
>>>> 17,  17),
>>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/ 
>>>> tsens.c
>>>> index a2422ebee816..15392a17ef41 100644
>>>> --- a/drivers/thermal/qcom/tsens.c
>>>> +++ b/drivers/thermal/qcom/tsens.c
>>>> @@ -315,10 +315,66 @@ static inline int code_to_degc(u32 adc_code, 
>>>> const struct tsens_sensor *s)
>>>>       return degc;
>>>>   }
>>>> +static inline enum tsens_ver tsens_version(struct tsens_priv *priv)
>>>> +{
>>>> +    return priv->feat->ver_major;
>>>> +}
>>>
>>> I agree putting accessor functions is a good practice but here as it 
>>> results in duplicating the function, the benefit is discutable.
>>>
>> I did not introduce this new function; it was already present and I 
>> only moved it from the bottom of the file to the top since it was 
>> being used in tsens_read_temp().
>> However, this change is no longer required as I am removing the use of 
>> tsens_version() in tsens_read_temp(). As discussed earlier with 
>> Konrad, it makes more sense to check for valid‑bit support rather than 
>> relying on the TSENS version check in tsens_read_temp().
> 
> Ah yes, makes sense
> 
> [ ... ]
> 
>>>> +    }
>>>> +
>>>> +    if (temp_val[0] == temp_val[1])
>>>> +        *temp = temp_val[1];
>>>> +    else if (temp_val[1] == temp_val[2])
>>>> +        *temp = temp_val[2];
>>>> +    else
>>>> +        return -EAGAIN;
>>>
>>> We have a, b and c.
>>>
>>> if a == b, then return b
>>> else b == c, then return c
>>> else return -EAGAIN
>>>
>>> It is like we have two consecutives successful read. IMO that could 
>>> be simplified to:
>>>
>>> int prev = INTMAX;
>>>
>>> /*
>>>   * An explanation ...
>>>   */
>>>
>>> for (i = 0; i < max_retry; i++) {
>>>
>>>      int value, valid;
>>>
>>>      ret = regmap_field_read(priv->rf[field], &status);
>>>      if (ret)
>>>          return ret;
>>>
>>>      value = FIELD_GET(priv->feat->last_temp_mask, status);
>>>
>>>      valid = FIELD_GET(priv->feat->valid_bit, status)
>>>      if (valid)
>>>          return value;
>>>
>>>      if (value == prev)
>>>          return value;
>>>
>>>      prev = value;
>>> }
>>>
>>> return -EAGAIN;
>>>
>>> (Not tested)
>> This approach has some misalignment with the HW recommendations.
>> As per the HW guidelines, 3 back‑to‑back reads must be performed until 
>> a valid read is observed.
>> b or c should be returned only if none of the three reads(a,b,c) 
>> report the valid bit not set.
> 
> Right I missed the point the HW recommendations is to read 3 times in 
> any case. Maybe replace if (value == prev) continue; ?
> 
We need to store all three readings because, if all of them are invalid, 
we must compare the first, second, and third reads using the following 
logic:

if a == b, return b
else if b == c, return c
else return -EAGAIN

Given this requirement, comparing (value == prev) inside the read loop 
would not be correct, as it does not preserve all three samples for the 
final comparison.

Thanks,
Priyansh

> 

