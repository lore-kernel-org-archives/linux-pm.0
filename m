Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8A466B55
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178382; cv=none; b=fvROe6o6zZyPUO+YOi7FTNGYgISYe80uL7gVrKpQ3KpPBrTNo6vs2sbbrDJG4Tn2zaclamPqeGX9UWe36LMEvzDEtxGXuhYADP4cI1i74kRygjbgWSCqjFVGB0l0gtQFS93r3DKYzUjVjqmK9gstZJrTxKJLvoiMbt3lJ1O9ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178382; c=relaxed/simple;
	bh=L3NQ2YE4GxvPqVQHaKZHlYDv3bsa3OrB+g6BOBqYAUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyhihT5mdoZT3NTPI5zgLQ/CewMHNULwcv6v/BUnJCYEHJ2SaDAUP3e0t4qUEYznPP5Zp1WWvvO5pn9bRrWMHvRWp+HtZoVnB1J+Hs7LcShRJpdee4x1viw5Q4ADf2IknuKz8K3AQtHwB5yEbM6HybQ4Dj76H+YAXLx5OvyZ0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8Q/hwxB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VgHH4bm3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8Q/hwxB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VgHH4bm3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Gpj12150864
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 18:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3CQNMQY8gebJrNPyhGrQH/4DNUoIfAzrz5wukQGE0I0=; b=e8Q/hwxBGWSViXVQ
	xOYnXaLWELbWnRfVOqHOvg9uer1rFHM/33WtwoSE0FHa8WISgzi5PIDg/yTkeu0V
	YS+5lLlaT83Uwj2vJndwB4wJcbAL3OZxG+XVOqoi7TvFPOPNVB5o4O3vXGop5YQw
	1w+iXlw4GHqKQeHAvnsTnqvEgd0xoXh+e0Ms0TMihjqVuRcXYL+D5j2Q6nvY3BPp
	QYMyPAGlhjB6AEfWldM3mzEqhdgZ1Ykc9VahML3eGuGD/C1x6LqMQ4IjzRODbRxJ
	tGeJvQGUU/w9r3Ebbv5qcogRw2RrulDpljtLusiv5EP/BHkw6yJ3CJs1r/DnOVxP
	Ia6zeg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kctua52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 18:26:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d812c898cso27958151cf.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778178379; x=1778783179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CQNMQY8gebJrNPyhGrQH/4DNUoIfAzrz5wukQGE0I0=;
        b=VgHH4bm3dqzF1YXvYb1Rf1F/Gwd2qWYoxqpgXq71qB5/omQT4omISOER7VaTm7i2+S
         bXvm5KirFLtNsTxvLAj32pZ3veldlu7mSovcde52B9uELoB6WAR4LadUjVWTP1lXuYjM
         K29NGOVsqcD4XJ1nAR7NIXfiz6TuLVm8qRE7OOMYkSpvCopzj3RI3IqMNnyG8Sp/OufV
         AeAE9pU0f4O5A+b3L927Euob6+oH9hzP8Bffwva4IyFkKECeYhp7y2q44lnwHfY3UaOL
         1kE+qaOF305xKbV99zQs85kESyaD2CSau5/F/+ffHT6GuQtG8YxLgbhWNEOPwsm5ly1j
         HJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178379; x=1778783179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CQNMQY8gebJrNPyhGrQH/4DNUoIfAzrz5wukQGE0I0=;
        b=UJAIwwa65HkRbsocUKpeMDJumdJY/lztnoRX6cDBy3QjI00oMJKZihNRgnzhsEXXs1
         p45NuXwp+98qQPNQG7EqB14s8jqPzYqk5aDml+1fYa3z89aXLTwmY3Lq6O0sERiiRbgW
         USpV6+ZlKnxRREoTO9x2AV63q+rrJeX+6WW8uH8Nv7UW5aEZp0Nzk8n48xs1s6Ke1s+o
         kTPUVxJJUu49jIJqR6t+tpGprySNLHFTyuOjK4nyreRe9+L4khAQxp9q3iaVDcU36D8t
         a1hJ6HtljJNMh6+BnuqbC7aX/jqTme+JaK0+baoA4kyZiiO4WG0ydjLaZLPXErviz2ib
         1vdA==
X-Forwarded-Encrypted: i=1; AFNElJ9m+Y3pd6BmNbGdb3qX5pJUrFjJs+e0yC/3zcE9+LMWV4hjsQFMAwQXlyzodUrVhAM3neGaaXyj5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNlQGqSbo+9RXTO07RZpR99MCciY4nkfPsRwZfI5ZKmD5TWpN
	cWegzCVfFPQzBJpNd6jNL7z45UioMKgelr/tp+g2vlzYXYZPK56quy1fpg6ar4HdINU15JkAGpY
	ALKO7Ja/j+lp7jpSXspFi/WOdBiPQ4XQNRok8q3DMWYkRwHbFhx1O3v+Txr95dA==
X-Gm-Gg: AeBDieu0sFsMBqQ1Oc8jzC6/uHPUaED7RZy4MwhLhumkDVcp2s/AON2NZvHyzq1iqZu
	ycG5TtmXQF0nNVAthmwJVZfkPA5SXUSP37d+bz120z44eUVAPadrMkXYAPKlmlvq7fMwGOko3Ej
	pGShv0+ZaTX2jDOMw7IHwUwsQM5Tt/zysqU9qhFxVgHjy5hNFvhFzQT/OQjJHEU8qn3ZzAnDkII
	4fUG/RgGd1MBxLElrVLbhE1+LGxP2AzXzY2VaizKCLv9uqnLvCxtEhUUZ8DtUphNaLdxnBCuwm+
	nMSHVNW2v9XBnuDXCr/RWlELN7xV8IOfURiJeoxoYqU3bZpsXyTJECQzC/d6WcOvz1Z5UpaGAvG
	QRVLvcQAiXeIG+eJ4i7oUJhgHKK9C31RNYAtb9f1HYcYRyDakfwZ6ZPYHTPX8Emk+RoGwdFkpYI
	Zusg3Jl2qq
X-Received: by 2002:a05:622a:4a16:b0:50e:6182:b3d with SMTP id d75a77b69052e-51461c28afbmr123624751cf.21.1778178379111;
        Thu, 07 May 2026 11:26:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4a16:b0:50e:6182:b3d with SMTP id d75a77b69052e-51461c28afbmr123624211cf.21.1778178378557;
        Thu, 07 May 2026 11:26:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3? ([2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4541712368esm723832f8f.26.2026.05.07.11.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:26:17 -0700 (PDT)
Message-ID: <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fcd94b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2unuyZozGMYncX3Y5hkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: LmrsIozuvX2ofUyKo_NgUHj3mFJeXPct
X-Proofpoint-ORIG-GUID: LmrsIozuvX2ofUyKo_NgUHj3mFJeXPct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE4NiBTYWx0ZWRfX15vyPtS0JYnO
 QY7FodUIhPx8dzGPtZGVcNSUFful10jGKDRPxuabayLMaNlTsIc/So3ESlapEGby+L3BEC9/7gF
 G9jWGkFT1ROGpjf04xutZ6IP/Jd1q8PDWQ7DfW5HpJ4olO1BePPxKnNzYMBjIBZj0zfhLmid4IR
 MgcQGU0MgTdMxLKzti2Gv29vE/ipvOTOPuaagocUUL2eM7J+B6VF75QukmuxxpsLEQG1hXsxgk1
 pIQZIf0ifWz9ScAQdvdOjQlhO+zHOwEXaytx4Ga2tAwZPjKR3AJhMO7r6MJA4k2h9XYHZ723iiM
 nBGypvJCHg9RkHE+zW2aozKkGFponpIQDtl0alpb8Xd8xHyIBZp0py2/Lr928fOCg42ZQ6/hZhw
 uxQ2wailUeUr0kXVEBSVZeiE96z+wNkKBhksPJ1osNFZLIdaIz9+KT9/LHraXlFQkxY6YcPJPSo
 0oqVnjEnLODWS0CIRpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070186

On 5/7/26 12:02, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 5/5/26 15:44, Daniel Lezcano wrote:
>> In preparation for the upcoming changes separating OF and non-OF code,
>> split __thermal_cooling_device_register() into allocation and addition
>> phases.
>>
>> This allows moving the device node assignment out of the core
>> initialization path.
>>
>> This change is not a trivial split. The lifetime of the cooling device
>> is managed by the device core through put_device(), which triggers
>> thermal_release() to free all associated resources.
>>
>> With the introduction of thermal_cooling_device_alloc(), the allocation
>> path must mirror what thermal_release() undoes. In contrast,
>> thermal_cooling_device_add() must not perform any rollback and relies
>> on put_device() for cleanup on error paths. This avoids both double
>> free and resource leaks.
>>
>> As part of this rework, add the missing device_initialize() call when
>> allocating the cooling device.
>>
>> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---

[ ... ]

>> +static int thermal_cooling_device_add(struct thermal_cooling_device 
>> *cdev, void *devdata)
>> +{
>> +    unsigned long current_state;
>> +    int ret;
>> +
>>       mutex_init(&cdev->lock);
>>       INIT_LIST_HEAD(&cdev->thermal_instances);
>> -    cdev->np = np;
>> -    cdev->ops = ops;
>>       cdev->updated = false;
>>       cdev->device.class = &thermal_class;
>> +    device_initialize(&cdev->device);
>>       cdev->devdata = devdata;
>> +    thermal_cooling_device_setup_sysfs(cdev);
>> +
>> +    ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>> +    if (ret)
> 
> In case of error here, when the cdev->device won't have this name,
> would thermal_release() still be able to call the cleanup
> for the sysfs bits?
> IMHO the check 'if()' there might bite us and we might not free
> the sysfs allocated memory.

Hmm, I wondering if we can invert dev_set_name() and 
thermal_cooling_device_setup_sysfs() ?

