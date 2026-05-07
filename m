Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1A3A4505
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142585; cv=none; b=Y4bXeO288I7pYM/3JdsyA9ogeITUlaamsccGDpLDRuvRAvR/aSfjQIWIwRfa2fjwFQvnSrfB/0PV6m1/QNW5iMimk5+AVFMSNgnU6/QKAVZtvIVLt64TlFBYl8whlTdPoVDFvxdArvRMnvOsjW3pkbbQjs9OhEpVmfPYyC5lgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142585; c=relaxed/simple;
	bh=xbT7uS2ko3LS9LfWfODXj5s+ARausbqKmwBO4cHbBEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqeJy/XTXUfLwYDYArVJs6lK+aSe720wmCJTp2IAAjaGTCCi2oXB7Lbsrjhu9WK9u3R9iAWDB+0GlUurT0q3xT/6oG4k2EZrFT3ulMQ+tYtQJKE6K/exn/BQXSdV25fQjlH9X4+WQJynGUVYyApwsHPR5STgnV0C4pCYH7904UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+08H1eY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CP9Ld1RM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+08H1eY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CP9Ld1RM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6477q63j1425037
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 08:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L0nSTx9b2aAqA4L87YJfIvaaJ8Ye42UC7DNezCsKjms=; b=F+08H1eYJpGWp7cS
	bZgVcOweegFcAdKe5BnrL1cBQgBE/f/oL5P4c/LuTH3FhvAplNtxPkevM6Y87KBg
	IAYPsb2T2iPpWTp64LcFuCMgQDb0Xp2RMV1RayKqHG9bwHGbAEdVWjw+mb7FdTI2
	ytApVN86u/ergo530NNLpQJACWL91cF81OTBMi2C6OdgTASUfqcAtcBdptikjGvY
	wiwB0PdFhguRCqgo2HUMD9rW6A80svhUKRVkJ3mP6lYYfnDt0ki3FagDLGjeV+8U
	109Robt9xkLMPTdtRxO6OWH6Sp1xjfbJgWwxne//inySululbzJWK5eYrO1DzSHz
	5EYzdQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfr4qg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 08:29:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb3403e99so12512201cf.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778142580; x=1778747380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0nSTx9b2aAqA4L87YJfIvaaJ8Ye42UC7DNezCsKjms=;
        b=CP9Ld1RMVDu0dFPUjZbHFn9t4aYAVYptzKhALQKq7SM7gKNhJbBPGHhfTQqHfzoztG
         OWhgns3Aw5IGCOEebJRvAoYx5jRr0IkxJk9lHy2X/YK5Tgdqxzr2HXxWEcd/MrSdk0yL
         OFcPBz5zz3nc6xqJNyQAxM0CWG/K9yPllYXld/rsqp9vbrH4wPEJn0lvgfbQzqytCExb
         tuCOQO8WdoHHBF3XXCF0Xl10/s6TBfKCxZMI7sYuUvN58V2yWEgHZOctK6yPrlv0w4Ia
         AOlV/awo1qg1lznaexFMVbLx83xOYYwMNiWpM1M5owDjJIOH7FSwy3xRectwI6lipOHf
         1big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142580; x=1778747380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0nSTx9b2aAqA4L87YJfIvaaJ8Ye42UC7DNezCsKjms=;
        b=GffN3LlA0ka8gMYnSgYV/+ui4G2MWPnRT/6Hlxb67QItPqzrrztLkGfljWxAivnxY8
         80dnvtT75gtRpKp44nDb7Ylxh27bP0yEfeLmbHUhXIxzL8c31SoMD7GxMVKGUhLTIH0P
         vhpI2I+7hPnpA4pVLDfh6AyyYKQmy86Ikrj7W7D44r+wiM4E2rdA7bUqRmFdc6QqVDpM
         cm+amYtPCC/QSSu9qY7vfCJ7CWabn5O+Z/SkOweHLLTob2WUQrQNEnp0q3bkbfKYfnRh
         s+JUOSWvOSVDyxAasYtHQs2KRP9B1HPcIJdcs4/4FxSBLC58YLSAhOLkEb6z4oKNm+AZ
         RNXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C5VNoJCidD8QJLH6kppz9myGzEBJ0A+Gl4qm5EfoHH7omU0Lc4J2RbEiq2wd4VTv91SdYWLkAtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDfwZgHomS1u5BDyeVsiNVUn9yaZbV9C4uENNY7s6jRDrHybx
	dyXww0C3ESISQPinDDSeyTvnFl5Ln702TSx0rpMKwIRsxKURpGlCNCSxD0sLUhzvSYGjTVfyggO
	nNmAexRzXRieyUVe/HS287tCiQuhq/V5uyVnsK5JURtN02fiQOH2Q9ziIishCOw==
X-Gm-Gg: AeBDiev6zqpWFtZN/07uxA701YxTA9ZOo8UqaNiqDgTrbHiIy1rXAnlRCm3hffDl/bo
	J0MP3p0bTFiZdwaPNPVpus93KIm0PfQLnnUrz4AMVhMXmgvbFxEPItLQbvvln+KEkWOpf3MZjUe
	GizAuN56/ayOOxhCWCAEypG7m2WMOSL4608HkjhGeUuh4EhGQCT2LJJLd5VVjYrhCdvtE4N/aTD
	Q/8IZ81TUYOBPov8/HVPBzg9K4FTgHDOzaCETebc+gCe8S0rphEW9yue0/4AT+yLed5zlFNu6Va
	+zEviqq6zSjX7W1buRspgINSo1KCEaOH6PiS/H/EukqPLXejILWVmlypE4/xvoJD70PU7nBav5k
	J02XgOm4SEIY17elCweVY1NdDo+CNfufC0VwdFxOqO4a+92esCU0e1x4l5YlHFoirywjsTSggt+
	ukXYxJUcSD+CoPvCvbwlg=
X-Received: by 2002:a05:622a:1182:b0:50f:c245:85fd with SMTP id d75a77b69052e-51461fce778mr99136241cf.31.1778142580113;
        Thu, 07 May 2026 01:29:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1182:b0:50f:c245:85fd with SMTP id d75a77b69052e-51461fce778mr99136081cf.31.1778142579748;
        Thu, 07 May 2026 01:29:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2319:772a:829b:bcac? ([2a05:6e02:1041:c10:2319:772a:829b:bcac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm117331015e9.5.2026.05.07.01.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:29:39 -0700 (PDT)
Message-ID: <806833f0-0843-4d0d-9e5f-d38b1589ddfd@oss.qualcomm.com>
Date: Thu, 7 May 2026 10:29:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc4d74 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ad5PGLBgRj6ha0h2GxQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4MiBTYWx0ZWRfX9rwkQV22lBgb
 kaFJBAs0AtqAOejbW7vlQy8X09Hp030gfDtBCozY8iWGVLPSof0AyCbN36IgUbXmgs5GPuMMGeb
 xM3GmSQ9Yb/6Y8h2BSv2Os7D0cZhc4ElAVx1of6N3JITCHuqI8cwL7xrkvNKqbc7AuGObYG6Y3M
 NVACSE6ztBvEznffBFJkacjKST27i7TWtw75u2XgVCSPrm0s80c+XSVI1aeRWnXwAUudN5RfDJO
 VVOCtwX1unvOOdKTubnFPlXaVDkeb4//g1VlypU4ApDObN06lhbDg66zQno7DfgBOVsmUslo4nk
 DrkUMbPIS2rHf5FrcGmyiJ1R24cfXR09VEgG/cxmwuP/BcadWsSvvM8IPk9T+350tp11xIKQhtU
 8wBRue7thyYySIswN6hgFotITgrk31UnTC9dmgUTcifwvo0J3a/0r8FDfFS1/JF22Cl7AfhckOK
 PHbpb8y1pSZGSg6PE8A==
X-Proofpoint-GUID: 524rjE1UVd9uim2aXwVNa8Y9kyin_dEx
X-Proofpoint-ORIG-GUID: 524rjE1UVd9uim2aXwVNa8Y9kyin_dEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070082


Hi Rafael,

On 5/5/26 16:44, Daniel Lezcano wrote:
> In preparation for the upcoming changes separating OF and non-OF code,
> split __thermal_cooling_device_register() into allocation and addition
> phases.
> 
> This allows moving the device node assignment out of the core
> initialization path.
> 
> This change is not a trivial split. The lifetime of the cooling device
> is managed by the device core through put_device(), which triggers
> thermal_release() to free all associated resources.
> 
> With the introduction of thermal_cooling_device_alloc(), the allocation
> path must mirror what thermal_release() undoes. In contrast,
> thermal_cooling_device_add() must not perform any rollback and relies
> on put_device() for cleanup on error paths. This avoids both double
> free and resource leaks.
> 
> As part of this rework, add the missing device_initialize() call when
> allocating the cooling device.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
Are you fine with this change ?
