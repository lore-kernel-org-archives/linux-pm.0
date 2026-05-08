Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA736C9E5
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268507; cv=none; b=p9p1HnFawsxTbH1lMrXYVn9BwX5QHRT0JPxIw63wKdOv7Lc08VMqlCvldk3qaJw0NzxqeIwe+/EFO7/E42MFbQZfWm7UEYouKL2ea9xtJyT4NuSW3ufjYdUurMcz8UCcsV2MWW8yYs+Xo6ObE5cxUehetu3YPdJn58doN3towUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268507; c=relaxed/simple;
	bh=iu0yd2HrqmUVBDGbJG3eyeYFbpP6EoShCJD5XszxaH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSxZvhlFnk+RCb5q1ybwMYp7nuNG9IMeKEJOcUSNlxZX87n7LNeTvIrg8udI9zc0JWZNRHXA+zO+xxJ8537xGYsdJGb4ZTAmN+hrccNfI9KZG6qHmBgXbkXzuW0GMbvBgBFKpGnKcLKMaqRWRyceqdO+9gfxh2BSJcSi6HYRbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvEJmFf/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BcQmErDH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvEJmFf/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BcQmErDH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648Heewj1662003
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 19:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0z/UQcmSogSZMpi+9Lu2bIZyE+LAeVttpueQeiqd0Y8=; b=HvEJmFf/Ta3O/AYk
	idtSBCsP2eZI5S9ITA64GwlgBn8/5hPc7v2ogytgYTtGO9watK7r8cf4K2uI3LRI
	fKtXYmIbsfSwMkk/AFnkT0zvFiBO7/tFVTBVB1R39VfGkBFLMFCqjlG1SmtA7t0X
	eacl8WyKpvBaHsVZX9kpFF4BBjwLYzim3azsfoLk+zBLIfJfH6BE1rajPE7aeutg
	kNOpF2Rdn0PpvMa987kt68FlhO1QFTUrwynRL5Ir5aYwlmo/y/85nM51To1W/JyR
	yO69VHtuMV6OulyDqGlXAnS27eP47mafaFxhVGy50W/8YiFQ8AgjIAtRgqs1I2VE
	y8AZEw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1men0b9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 19:28:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d5d1c2289so55245361cf.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778268504; x=1778873304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z/UQcmSogSZMpi+9Lu2bIZyE+LAeVttpueQeiqd0Y8=;
        b=BcQmErDHZecMjem78aBNNoF75U2PsvjSIpY/1bZpUyZ9tM9wI5i8802WYRB42NevMW
         tk0PglpigJHt06yP6oiX0vN5PkgNuf0wDbAfqPesMH4fq3CbL/3PR175KAy5zfqNi9A5
         fq9qzHKEMKGBnw2Op+a66MCwihYji2O3iqqGsTdPPlEC7gHOvxpevEoDFJt6F7OFXzgP
         0jIITsxEoLApiK+oGieWyXn8FaQhdFjgD54vGGl/0Z8BzZ81mmcEBRJzSo26mkM7/vSa
         b3cvt/PqjurprsNI1YdyFWJokQwgp9+pEodpqfXGepVZ3qBWwGdaBY1K9/ErAp65EN3F
         +KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268504; x=1778873304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z/UQcmSogSZMpi+9Lu2bIZyE+LAeVttpueQeiqd0Y8=;
        b=tJgeHV3KFxnvwL3wUhFlLBuexpWMbp2oV2RaTle0fEvlXqxiTWsVTxFrbfZYtrVZbG
         s5NT84pRp6sIu+Nl7q254uxXnV03uFutHtChu2bR1nWsoMfJjyV/bTCHvbHQHaAt6Dly
         4wXh9PJZfKgNGzMUt67Vs50MfSshsRIxBkCIfYBHvoO7i6hB3jLF6w3YyUDprz+d2ehV
         TuWzDSkfDcAZ1wGALnlSSPhEnl+UNeiYwgQOVoNUdWbIzosInaGfzQfnYa4p8zim18js
         jWCROVWftCG6q+jfUQkBT3eSoBRxkaAysSaSnOy9d4WbnibeB1u+BVsp+iPeEzj3WDJC
         akpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TAzJOEr87Tj9RRvdQaITsGyF/MY0r9MFma0s+Q5mFap/9sseqUlnkJXoSE3Qgv1Chp5v52jik6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFW7y5CgFemGkhmIFTa01jtKtaEEsIKOgZ52xmIbWjGNncfFB
	ebKn8z2BiakL5lBAe6Pkf8XzcOx+CtR+ytcC+YmRfuRbjBcZMbYusPE2QHeOzzz7ZI2CxruP2BW
	SZ3hts/U5jgnUdsiSXils/QAZFo5ajx3Wy28EVeJz5ouV8tjL8IB/gEZv/TT9NE0QnIeJZ41S
X-Gm-Gg: AeBDieug5t1m82CdAzqMcMKp/b4MAKdJLwqVHrY57yrPDePfYuicZtHGYhyUEa7FGq0
	S05LpUiJymeV4cXBG2mELxYcsjbkA4bKNjHiOfVcYRxfARn8ZoIan2A0UDTI2KFaQrm93gThOmj
	bxc6kprPkwxw7e5Ifb0F7N+aETFaSOwX2MAakWX0GiQmjR6Ol4hyUh6oNVj6jjlDHEmGMLh8SQe
	10fZWH3XXMY/8cTk/ca9uqmx+NELV0aUPM22B6AABiKIK3im1IOtOUhVvaVHmnBuH5jMri3joz3
	ispUPohkN7KUuskj8U6WEnGY+bGrF66QbR0Cr1k7Pm1sNAqLQaujfVGjq+RhnopRWblz9XTYgKD
	WXcmDiu+19SWd61rQRlet4ZoU80bJz+wlTARwfQIOMD7OH2T9a3wPqv/6Bj6gyoff2IEq0eq4bm
	1MYx1UOe/j
X-Received: by 2002:a05:622a:60d:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-5148e7c9362mr55226711cf.10.1778268504398;
        Fri, 08 May 2026 12:28:24 -0700 (PDT)
X-Received: by 2002:a05:622a:60d:b0:50f:c65f:a4fc with SMTP id d75a77b69052e-5148e7c9362mr55226251cf.10.1778268503877;
        Fri, 08 May 2026 12:28:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee? ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm6509018f8f.8.2026.05.08.12.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 12:28:23 -0700 (PDT)
Message-ID: <d86a9d33-2488-4c99-85a0-41b733c445a8@oss.qualcomm.com>
Date: Fri, 8 May 2026 21:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] thermal/core: Allocate the thermal class dynamically
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0gWgoZtuK6nZ+71QbdV96GXq8McQ=azcCuceph3XxBD4w@mail.gmail.com>
 <f00ef10a-9adb-4553-84cf-24995598ec1b@oss.qualcomm.com>
 <CAJZ5v0gx+yHZsBdZ7=O=Y-qcFOOCHwudGo17GdfH__z2_zBbiw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gx+yHZsBdZ7=O=Y-qcFOOCHwudGo17GdfH__z2_zBbiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MyBTYWx0ZWRfX9Nye7scMndRG
 oTmB1+6U7BQg0Y0lQyN42VAgzagMFgtlIY2wOlyZl442yhXALzLMyDWNa3tC43p3/1zGLcqTWe8
 c6EXc5r/wmbMCrfGj6x6SPMaVIExp2OUUn/MzcTMtRn9i/AoL08a1s9K/NHdFICBfLkFs7FOGHY
 VBM28xjFDsN7/dsn8n2+cbNCha69X80b/2evc0nsgvMlNmSX5jJ4UflInKTFk29Z2VB3KuarIwU
 SPk5TUe6HDjBgCcxyvytXyv48oWJ+/EdqJKTsLjLOkWSfq2SI7Vv7Q2OKAYEwVH5A+jF7e1gdbL
 tdS77Qb/W35NP0i3QnGdrMERBOFRn4FRAN7tmFl2adoNHjqf8k83MqmBn4FfPzZLPGcOkWg3WPS
 HS/YNw7hSai8bW9bEBf7a1w1YaeSzCokwPnu4RZqMI3eUbr9VIIp4vTSbJCbhKdzl/OXcCGSVwC
 dHBPhUVqHx8eQsirjDA==
X-Authority-Analysis: v=2.4 cv=LORWhpW9 c=1 sm=1 tr=0 ts=69fe3959 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=TqEP7YGcEmlrFrjrNAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: n1SfwyAoYQzN_UMm0AhE_pfNi9gzXw5B
X-Proofpoint-GUID: n1SfwyAoYQzN_UMm0AhE_pfNi9gzXw5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080193

On 5/8/26 21:26, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 9:22 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> On 5/8/26 20:24, Rafael J. Wysocki wrote:
>>> On Fri, May 8, 2026 at 8:05 PM Daniel Lezcano
>>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>>
>>>> Use class_create() instead of a statically allocated struct class.
>>>>
>>>> This allows the thermal class to be managed through a dynamically
>>>> allocated class object and avoids keeping a static class instance
>>>> around.
>>>
>>> I changed it the other way around during the last cycle, so is it
>>> really worth changing again?
>>
>> Yes, I think it is because it does not reintroduce this change:
>>
>> -       thermal_class = kzalloc_obj(*thermal_class);
>> -       if (!thermal_class) {
>> -               result = -ENOMEM;
>> +       result = class_register(&thermal_class);
>> +       if (result)
>>                   goto unregister_governors;
>> -       }
>>
>> -       thermal_class->name = "thermal";
>> -       thermal_class->dev_release = thermal_release;
>> -
>> -       result = class_register(thermal_class);
>> -       if (result) {
>> -               kfree(thermal_class);
>> -               thermal_class = NULL;
>> -               goto unregister_governors;
>> -       }
>>
>> It is replaced by thermal_create("thermal") which allocates and
>> registers the class and we get rid of two global variables. But up to you.
> 
> Fair enough.
> 
> I'll queue up these changes for 7.2 early next week.

Thanks
