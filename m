Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD2325491
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973726; cv=none; b=qiEHXe1t7XCrttyHf1k2Mf0beqMLcykFTvtLvi4dURSUTksSuDXcxRrSfKm3uXd8x85uUwL28SzC8kwvUiHQVjpqo6RkwSsQJd5EEoyKNnZCkXEfUuUX//h20Urq9LacXy34Wd+Hm7gZnRvAa3yYqVSY2UhDCD2eRtAOTdKPHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973726; c=relaxed/simple;
	bh=PR7Wdss652FBLazi6jLFtm6E2EgfHDdQfxJFN+tksfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twhmWBqQX4Bk4bkWzLWw8ccwawaCJt8jPNPFJiD/78qXTonrC9/pbD4fFG8v/8+o9o9ml8hCgp9k8gVsRmMJ74UmJLVHT7nEh70RLimd9kyclX3l+kV5JUUeWIyxL0M10fRR7Lbd+GbpHSvQH2eR7Q9t1qxT7NKmBdzR2KqyVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iWxechIE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEkeiLsE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iWxechIE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEkeiLsE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64570VLk1960830
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 09:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1KkySOLo4+xAyVqgNYM8VLGdX22LIlY+bmdfeecgSx0=; b=iWxechIEMo6AOn1T
	NFSj//h15brRDJz9I1dLXcapHuA5k8gaEF+a/UEt3JfSbmDD4n9fCzdh4He0V53B
	6gIp01xh/Km6eWdu6rzPvFJ6hFYBR3mIi6dikcLOg/xo8lzGZ69GslvTvuNRkMWK
	CWp2mL31eZfwuldAybZCvsiCPfJiql27GIMT4Dj3dVlqZjh7aNm8ZJGqyw1E3Fnk
	17S+gZEHiwZ0Ybh70twWOTmsaQpcHIL4Dtg8dw2B51MEnW/yziBIVeRTEwLftIK2
	AfIaWNTNcmN00qIoVUenaIwT1mM0juCBfTWRQ4+rQOGOpQzXg04z7bEIPR+G305q
	UFnc5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dumk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 09:35:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50eb8bad331so19024981cf.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777973723; x=1778578523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KkySOLo4+xAyVqgNYM8VLGdX22LIlY+bmdfeecgSx0=;
        b=AEkeiLsEwaoXrYWcRwcZ3MWwcP4x3tcJt3+nsZTLuOcMDKeyteFokcRuDm3kaDLIRA
         DEFp7MDRou/tHi2YImq55G4hR1aMrCWM9JXBlXq68Z31F8PACLfUKRu1CA3mL8kpZw8T
         0arjXw7ZAmxrf5cvOzxw9RQk4ca+fb6IJJYrkx9+AFiHslrKKyMU3vP8SkAwHd4MGThc
         AL5F5IQrDJiXvH6ilksmIH2Nxn/arNASkPvje/oD6iM7AodIIy4R25mARQ9vjByTd/My
         +eG+jN4MIcCCZ9HHiXOl77xs1/YjayRmZgAcqYarfmaKxZ2w6F8kf7OKsj22RyM1ID6j
         8CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973723; x=1778578523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KkySOLo4+xAyVqgNYM8VLGdX22LIlY+bmdfeecgSx0=;
        b=SUDLUOJLg0yjxWbNjdB0bPbEeLT2aVy/jFUiIuRM4E0Vrqf5IkbW78AEOk9aRxDRcU
         4Zm6lv6QJK4t6r2qklnbXciGa14VdkIAQhrl3WjAciro2AG7we++v65Rn9rWdJs5WnmC
         By1wWPrlxH5N7Ikg1lZTdV+gAh0eJo7bSHp7HFDD9msIBi2J+AQFNfK57vMQTVX9NAo8
         Yuix2MX4Ygp1IvPXS9INleEkR/YWURZARDmk/sayNfG7XanHDzqzKB6wtwyHofTLyMtQ
         /LXpgnnJnXvA+mUKBLkk4xagSU6us7IRpHbuYO9ClXTbanmvbCTI3JotANoIwPYdi4wJ
         Pw4w==
X-Gm-Message-State: AOJu0YwNvZM6nlLsbYLbcNNB28ijXktr8MA+Ymb/9v9LbU9aSDHBH4LO
	9Ufgy5JU5a1/UNwnXCgEWe+2Pl8jwHYoOO8xI/g87waRokIDC36W2S/DmbVWLoBku68uEC/jKBp
	2ortsZ2TbMB7UZVTzDbcObp4UjeCHxzXjMr6cFk6F2AbzOCKHSX3+wWGzpzJQzg==
X-Gm-Gg: AeBDietpadcaWAn4lg6U8AvnyYMNZG8vdBfoIFIRtPfTFLpwCKfDFvNPD8Sq0AtNxBS
	SBHJvG9cHg7Ow0nDSPMbY6R+ph2cyMVNXdt8KOVNIeEw3UzXH2fIeHKZJeMUZJnL5j2cGhvOfaq
	yuUCxDzRUl/9EjGFj3NBuUDNLsrzEHG0yx9VNx2BkdSztO+PX/4LuGvrxDnj6On8vM4H/GYrQ+w
	QmWMvOVfbPh5Rynvu5Ueq/irhmHU6/o1dPpRd00v2m5mTa59vk8RML8DSj2pcr3LZ9IZqmezT29
	OLtj4DKsUskxP1KVxcl6AHud3oCG3I88d/2Sz+7QHDavIaIXLc7r4s782qA5MTy1VZBq3617Hwc
	uP4it+2iSLdQxdvqm9s8eTi0FXNJSzVsQXng6TgGCVwbusuZ12ZFXGWo40LR3g9UqqapNTWYURr
	B5/sdColkFEI2ojkZJ
X-Received: by 2002:a05:622a:18a1:b0:50f:b1e6:a901 with SMTP id d75a77b69052e-513069c599cmr34542601cf.24.1777973722625;
        Tue, 05 May 2026 02:35:22 -0700 (PDT)
X-Received: by 2002:a05:622a:18a1:b0:50f:b1e6:a901 with SMTP id d75a77b69052e-513069c599cmr34542261cf.24.1777973722195;
        Tue, 05 May 2026 02:35:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm603925965e9.9.2026.05.05.02.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:35:21 -0700 (PDT)
Message-ID: <b4972eaa-cfea-4fed-990d-2cd34177d045@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:35:20 +0200
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
 <0d95cd5b-01a8-44b6-bd4c-a7e5fa81e181@oss.qualcomm.com>
 <1dd4746c-e93b-479f-8aed-ea9a21a03316@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <1dd4746c-e93b-479f-8aed-ea9a21a03316@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4OCBTYWx0ZWRfX9LkF5VGw0dss
 loeuyUdQu6tcbiI+C5mNDBdrI9kMuSRIE7aG/zMlK5cPIe5l/JnTHmlaeSGhjQR/sYjcDqTbBLh
 vsccXHQ8I/hHGg2Iz2UsgJfg19aVKJ80eJniSSXeurzwO74mhoZEPK1KrpPh1TUhH5LTjTZjEUr
 ZM0E42lQ5AG5+QE3/sq2NWc521TBHa5QdS8qvvW31LV+7WHFaWO/cup+tCZcYYoHgj0sHOA35L7
 n8bYm0eQGraXldy0J/+n2m9Kb+IUtMnzSWqs5maqgSMkxGu4vfuLDdNPJtpu/n3NntCQcr2Hfui
 O6fxau5QeRJyKpDVwRZXBP1QvmK6M3FhnPwUTpB40ZqyLBa9urdc9iCPKGjYuzS0cSYJUWd1HzW
 eaJNSGOE9EKplI5z/e/Rr74VkP/IvbMipPZ9LBKcffKKXISbAK6GOgWqTOSl7OEQUBhlDE78MZ0
 lDCUOUGsViQtbZhy6rg==
X-Proofpoint-GUID: _wJ4Fhif4nObQf8IhMyEAct8Pm1dX9NP
X-Proofpoint-ORIG-GUID: _wJ4Fhif4nObQf8IhMyEAct8Pm1dX9NP
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f9b9db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pvSK41EeoSHcvvxgzhsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050088

On 5/5/26 10:48, Priyansh Jain wrote:

[ ... ]

>>>>
>>>> int prev = INTMAX;
>>>>
>>>> /*
>>>>   * An explanation ...
>>>>   */
>>>>
>>>> for (i = 0; i < max_retry; i++) {
>>>>
>>>>      int value, valid;
>>>>
>>>>      ret = regmap_field_read(priv->rf[field], &status);
>>>>      if (ret)
>>>>          return ret;
>>>>
>>>>      value = FIELD_GET(priv->feat->last_temp_mask, status);
>>>>
>>>>      valid = FIELD_GET(priv->feat->valid_bit, status)
>>>>      if (valid)
>>>>          return value;
>>>>
>>>>      if (value == prev)
>>>>          return value;
>>>>
>>>>      prev = value;
>>>> }
>>>>
>>>> return -EAGAIN;
>>>>
>>>> (Not tested)
>>> This approach has some misalignment with the HW recommendations.
>>> As per the HW guidelines, 3 back‑to‑back reads must be performed 
>>> until a valid read is observed.
>>> b or c should be returned only if none of the three reads(a,b,c) 
>>> report the valid bit not set.
>>
>> Right I missed the point the HW recommendations is to read 3 times in 
>> any case. Maybe replace if (value == prev) continue; ?
>>
> We need to store all three readings because, if all of them are invalid, 
> we must compare the first, second, and third reads using the following 
> logic:
> 
> if a == b, return b
> else if b == c, return c
> else return -EAGAIN
> 
> Given this requirement, comparing (value == prev) inside the read loop 
> would not be correct, as it does not preserve all three samples for the 
> final comparison.

I tried the different combinations and comparing inside the loop should 
work. But the optimization introduces an implicit inference not helping 
for the clarity of the code and probably prone to errors in case of 
changes. So probably simpler to keep your approach. Please add a comment 
above the if a == b return b else ...

Thanks

   -- Daniel
