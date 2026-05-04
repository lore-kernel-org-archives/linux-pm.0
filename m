Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CC35B62F
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890864; cv=none; b=QPlQebrZdEMO4UipyIZs8uPzqW879nlKpiScCd6GCkluF9hzS7N0FANlaLiMc92mHP8EK+DRPqMDo2Nfh6qpuqFJl1rjl17QlsJcCUbP0MMMbSYR+IXmMH4qh8uzjCTfvUcCybHCcK/FFJL/90+uRxVs178a0U/rbvyE8mKiaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890864; c=relaxed/simple;
	bh=hglptU7g2QB7mh3FCsH9iFMs6qsEX5uAMiVaW/R0P0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pChO2ZlXXo3bmp+ZCgG7+iA+TGhLAHc6rPe/kvSb+nG4X3W8RDJh4uI2V9IypL+N4sGOnWMnukjGje64LW8SB75vQrjwp9tsoTazFVT/gzof1JeB4Zg38k+RLeu7qbt4ROOXrqMbhQgcAx+3OIQYxOIeiAoa5qb1ouBoXPpnI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hk7YjzWf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdYNic7Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hk7YjzWf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdYNic7Y"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448ffu6487336
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 10:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRsOTIc4cMSBxuEr1E3SbSoZgphqegltfvq2CcDf89c=; b=hk7YjzWfRB/eYdH6
	CxoU1gblt0JlqmGylHMg3pNpeOGbEXxye2yOXIJCpsY5V85o2Etj92mTyw7cdT2I
	1mnDz04iE3T0pl8f9dRoHKy4KKtqj5ChoT752QbHpIjj7ORvdQv2kjqsWSpxfMEi
	3QuJoiJlvPaogdqnfQQ2x4Jz8uas88KgS7CVuh/7iXOv5tfH4zChwM+9i7kCacwu
	HdQOgNTJVRr4Qi6HxyGCZnmJXCFxdxsbgWIpdT2Pe9Ucc+jFpbzKO55Qus7L7vGl
	npLRU+ftL3AfvdIHtKx37NOR1ECVSZTUng7E/6L912PzXVUqbLxkEgilI5tfhv4f
	CG7q5w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8uxnb6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 10:34:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b249975139so74927045ad.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777890861; x=1778495661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRsOTIc4cMSBxuEr1E3SbSoZgphqegltfvq2CcDf89c=;
        b=LdYNic7YChYYVUYxE1hont0V4ZfV7VXueHw53RH/JWNl497KFpvrOaEEb0AnthtgNM
         IZ+q30bfsOWy/S/LXabSP0C0xmwa6Swnb27BedUCXuOsDkX/KHAklnNmhUrty/0pjgd/
         hwvoC9cdwsQeDC0sOzg/OLF13FNV+i46J35Zqoqsy51DZdCs6SoxtWeKPs59TPkXq6Yk
         GHKKeT4HeRVYZFdAQdOj1Kp0pdPJx0Xdyhh7mtDoMeob+qX+lHOGg18klq8iycFnHvLX
         8BT0C0I6UZ4Us3SoWVRjaFjXCLqshbFqPDawFFfKvPxDrn/+EdOCHqzATWzPy8N/+Igq
         dO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890861; x=1778495661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRsOTIc4cMSBxuEr1E3SbSoZgphqegltfvq2CcDf89c=;
        b=bRGG5yKKvZoOy9Nb+p8y+KWPFm/D/qPuI8PcMEAMCdG7h0hK3fEP8wxlNYcwom6LZV
         X/jj3RcCcBAp43rB5xmO1AxFG7vy+91mEgGXvl47DrgiMH7WFZjJ7Se9N8SyPq4BKQga
         Y+HZBJvqdMHOcgrnmM83SOQb1mTrdsYNeRNDquCgkUrv1pD9obigpot0L9fTbGWB1bfH
         k1SFJe5fueXudeyLRAe7CsK2Vvz0pj1LRPmCep5W6HWL/WUnLSGt+X0vOe595RW+6wim
         ZP0d3/MgqW/iUAG8Qd0jP2aayL/OtuKn1ungqW31DhNZ+WeXMWKEQWS4qKp6xaDQtWNj
         iIgw==
X-Gm-Message-State: AOJu0Yw2YymfuSY8TUQ0hBZQroPJ7Z12hyU8xcI1G9kNj+3tXQYzEBNP
	ld6NWKJbGTj9tHd93C1SyHS1A0wJm58Zq/GWAWMteJ5Ql9PSzrorTmDDwWubbH340XbnV0RRFJ8
	9rkFRnzL2GXgwjcBBso5u4w+n7/XyAyObtRtIm6EmC+vfTAPPzG0Sb1ERf7juTg==
X-Gm-Gg: AeBDieuxMltG1E/XKeYG3USPEg90WsgcGaz4e1EoFJrNnSQ8FCPmR2bujDzCLcJ2XYG
	gGxNschXIHnt/huXNSLDvTxw/jtx6RYwE0EKFQRevMC5Rl3jzLeemx/D84CroG9meX1E82t4wX3
	IdPSABcWg6fDbYAcfIJwxJeHnngmt+/gUHMn0By0lWzEUHTBC0YbKxm/GLjZDuGF8p7LeoWWZmK
	rLjaWbJEKJxzLTRdOCFby2qJp1OJYLP5Pnh97NA8//GvR4iKg1xJvtraUBkw7Ld7WbA2xIqHWf2
	ddSXdP5YMmBovgz3214+UZcs5ODurIvAxy6aHoMP/wLIEEGV+eM09kGLNEYFA+10Zoc4YgtTlcx
	v6rfDT9kWQTECkXK89uPm+raSvLbCkoSXnF06TnB7Z+ThhsFipmDUfNfUpBcigQ==
X-Received: by 2002:a17:902:ed0a:b0:2b9:87e0:1f80 with SMTP id d9443c01a7336-2b9f25e667emr65107385ad.24.1777890861303;
        Mon, 04 May 2026 03:34:21 -0700 (PDT)
X-Received: by 2002:a17:902:ed0a:b0:2b9:87e0:1f80 with SMTP id d9443c01a7336-2b9f25e667emr65107105ad.24.1777890860821;
        Mon, 04 May 2026 03:34:20 -0700 (PDT)
Received: from [10.218.50.10] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa8c3f2sm120191565ad.4.2026.05.04.03.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 03:34:20 -0700 (PDT)
Message-ID: <05346f88-4ffe-495a-af0e-ff5e0371c03c@oss.qualcomm.com>
Date: Mon, 4 May 2026 16:04:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
 <c369dcd6-eca0-4d01-89f5-d19a41fd1477@oss.qualcomm.com>
 <10c07347-a0df-42d3-b216-5150817b9ed2@oss.qualcomm.com>
 <a90cc3e2-73ba-4ee2-a607-e73160cd3e9d@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <a90cc3e2-73ba-4ee2-a607-e73160cd3e9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GgmQcNfx6_CFrOv_yFxd2Dna1cV6ZvzJ
X-Authority-Analysis: v=2.4 cv=QqxuG1yd c=1 sm=1 tr=0 ts=69f8762e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=gIxJPFuM_M9iIqC3imoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: GgmQcNfx6_CFrOv_yFxd2Dna1cV6ZvzJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDExMiBTYWx0ZWRfX8FXLtfhqj809
 dyRW77SNOInLYrTTIjkbIc0SZoSgOyCueMBTKdaVd8mU4OJlM2uRjiTCpn5KfWYgAbb91zsljfD
 rREj5rrEf1ZgjiYQBwXhElb24XxMdp+aUxoAMz/bpc6tMdP3PTrQ8MwU374IRi6RI6BeuDqCRDq
 DPbsU+Xo5UkjZCdv1g3xsw3ePyxfO9TN+OPvtqCr6vxVcKc6+LuhOFYwnPieCFipzxSw2SnrTI8
 doD5nf4B2i9/6Ouf+zxFMyqK/IwGbdecAOglp0GMsd5tyaMZ21cjqqdeMcTB0wxWUukY/CjnLQM
 Jhz1X4MlFNzjaH/kVfmLNxINl3nxIOcRwHwASredWYNzPrxE+kprhbisKedadne1hP/VNAH0JZ0
 Qie6xxata0dpBfA/Ljk1jmahPq/MYg6Mv0GNyHEzSV/pfeEQK7/7yBz9BIHwxf5OeGDdF0htEsL
 yKEzA94llzUVLh5cYiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040112



On 04-05-2026 03:29 pm, Konrad Dybcio wrote:
> On 5/4/26 11:42 AM, Priyansh Jain wrote:
>>
>> On 30-04-2026 09:21 pm, Konrad Dybcio wrote:
>>> On 4/30/26 7:44 AM, Priyansh Jain wrote:
>>>> The existing TSENS temperature read logic polls the valid bit and then
>>>> reads the temperature register. When temperature reads are triggered
>>>> at very short intervals, this can race with hardware updates and allow
>>>> the temperature field to be read while it is still being updated.
>>>>
>>>> In this case, the valid bit may already be asserted even though the
>>>> temperature value is transitioning, resulting in an incorrect reading.
>>>>
>>>> Hardware programming guidelines require the temperature value and the
>>>> valid bit to be sampled atomically in the same read transaction. A
>>>> reading is considered valid only if the valid bit is observed set in
>>>> that same sample.
>>>>
>>>> The guidelines further specify that software should attempt the
>>>> temperature read up to three times to account for transient update
>>>> windows. If none of the attempts observe a valid sample, a stable
>>>> fallback value must be returned: if the first and second samples match,
>>>> the second value is returned; otherwise, if the second and third
>>>> samples match, the third value is returned.
>>>>
>>>> Update the TSENS sensor read logic to implement atomic sampling along
>>>> with the recommended retry-and-compare fallback behavior. This removes
>>>> the race window and ensures deterministic temperature values in
>>>> accordance with hardware requirements.
>>>>
>>>> Signed-off-by: Priyansh Jain<priyansh.jain@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>> @@ -125,8 +128,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>>>        [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
>>>>          /* Sn_STATUS */
>>>> -    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
>>>> -    REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
>>>> +    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  21),
>>> ..this change feels rather odd - the existing regfields seem like a good
>>> place to handle this register map difference
>> This change is required to ensure that both the VALID bit and LAST_TEMP
>> are read as part of a single transaction, in order to avoid a race condition where
>> the VALID bit may already be asserted while the temperature value is still transitioning,
>> potentially resulting in an incorrect reading. If needed, I can rename the field from
>> LAST_TEMP to something that more clearly reflects a combined representation
>> of the temperature value and the VALID bit.
>>
>> Let me know you thoughts on this.
> 
> Hm, I somehow managed to skip the connection between the two..
> 
> I think we could retain the current (pretty good) containment of all
> register differences between the versions as-is, with something like
> this diff:
> 
> -	ret = regmap_field_read(priv->rf[field], &status);
> +	/* Fields within the STATUS register are only valid if read atomically */
> +	ret = regmap_read(priv->rf[field].reg, &status);
> 	if (ret)
> 		return ret;
> 
> and then falling back to the prior definitions of the VALID mask etc.

Thanks for this feedback , this seems correct approach, i will update as 
per the suggestion provided

Thanks,
Priyansh

> 
> Konrad

