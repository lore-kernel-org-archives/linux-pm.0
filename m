Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002532D8795
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268164; cv=none; b=S51j5LCjkykN8XMVtLMJRZwISWhNXoG2ivUpkXW1Gc/n7DP/xW9Ud5daVzwbVggXT0MoJ+GDMLDVTMfj1suh6YQpE5vggtH+niO7Fvappv5dleIJ9zRai2PG3ov7GXrYsqrmWL/5KRrUhzgxvYSrFRmF/KYutG+G7lOzSc9bcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268164; c=relaxed/simple;
	bh=blPrQv6Ns3Mit0Hx70fOfY+zeFSu52/E1w2zNv7yzLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZ8lods70ZQqHmbstKKCneBmlx+SbYLfRxY5VsklRwStlpyEKH/f7VuinNgPwgg04L6aW6AFdWGfc+AQI/sAEGbGtPc2ajBcda9nrLE9m1zotZgAE8+v2Gg582DxkGnzKo87Ri0J8P92Fvm48YoV3d6kxOzCxwXv4xVm0brc+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tg7y34L+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TUo4Ebkp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tg7y34L+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TUo4Ebkp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G2wH6724365
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1OZKH5y7iZAGgxSzgL7TtICfgLbmwbiTKLrVadgAsLk=; b=Tg7y34L+Fnjw5R4X
	dJD9purB3UVRz4qUc3jfvZN0YRrjhRPWOlqSE4sS6a2S2Js7EZc/gNvpdqs4e5Oy
	C1yvJOfxCkZxmXNSFZ0yWPIHPdRxyxJhNrjrRHUrkvP1/+KdgEo/vtoYV2NfkRTj
	Lzm89OnXvsDAdWqpQ/urxH5qiK9yNnwUipqGqcd0gOPZ/6fWc1Lwnl/QEpQ4w/Im
	6di+Rj8aBbB+UAd+SCx0xxkDch6hiNZwXNCkKPzRla9r8oBunQYJknWMh/bXiI71
	07I0H1usUqbvNkYF40odNF5HZ5/CbSyvwZTQBEN5dorLZvtF9vASLON+7VymLXfw
	coBWiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k0ugpub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 19:22:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d812c898cso56034121cf.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778268161; x=1778872961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OZKH5y7iZAGgxSzgL7TtICfgLbmwbiTKLrVadgAsLk=;
        b=TUo4Ebkp4d3uNwSEQdkBp47AXbGIU86zpUQXmt9ojaG8GduF678sYYirowBfYZiYVa
         9v1JxVVFkrSg8O+O3WhK58QRz/aW6QksiPxdS9i8kxVaFtMF30p7D2HSsReyD7VnSz9D
         kbI5mHPKz0jbIBwP0wFV5rlqxMxUwczuPa3fxIxBkiG52Zb5wO9v1TXoUtpbWbD5n6Z/
         No5AWHC6bnsqJMBxRvYadczi+IpnvJbDV96SKB8L6Lvs32R6hQiipHylzRWrypL7NG2L
         7rAUUJZ6iocLJK2lZhESeek5mPSjm6Y0md6lJRdHK95rbEio/g1sGW+QkrzDGvpGFsR3
         wTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268161; x=1778872961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OZKH5y7iZAGgxSzgL7TtICfgLbmwbiTKLrVadgAsLk=;
        b=IwrnmKn5hxZXkW6hyv/dl/EOstccqjmDYNBvyHrH0mtpMpYiSEqIU12DI2EEKieZSx
         zsSTESbIuc4WRpf5kKJHfIXdleFjHbjgz+lJ3twu6J6DCSIhHT8TBHDwIEArKK/UkiQM
         924kCMgEHDIN8OK1qh5Fbv9Jt34Ygx4+yrps/6HNoDAt0BV+H6CBVAMJLNJHF8XUelSd
         S6b0BIm06pJkmCuoT4CmRjd03J+f5P0RshL2OhNM7uotLHiqz7m31iT4zy/2eSUez2o7
         u2tI7AOThininNngvImQcZIFJXUpzrcszBftpz0PXdczfB0VU8Fq+UWV0/T/vOkNWFMe
         QZgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mCUYtjKQGtBND+kkDVwR0Bb/00ohf/aD33K3vAFS56mv8R8Jf5xL1yq0Hv/+0tuGtTEQUYUOMSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGG6dZYepggoXKXSjrVqLmLiuh98ZTq41shAhL04lx+NiX4Hdz
	z4PU33eoJR2tFER7J/MAM79Qn2YGvG+KZsEUMlluwTxlgfEKkbQcNBbGPlPBZDsuuc1+zphuXV0
	RRXKmsCc2eBlkwrTutsn5T/qsbsjc6b/vPLECGC1o4a7sOVPqoGmjbBQc/hNY5uJqStXn4ER3
X-Gm-Gg: AeBDiesHA1JbEphGpgVbRGDavQPPxRekxjQlFurRZZ3bCLVlBPlcIbhdhZKNSPp8EFv
	l6uyw8NkMeNBtcwCtxxFzh7z6ZOJRRHxNIGjDhfPnhKGiy1yXFoje7CkVuQwEonhLMlVNOIchrS
	R+6Uj9JHZ/nq4u0a57rKL5BY3U76Ntb0R6w4QlGHSK0VYVZIHDR1dxHnBaEDSocbTpGZrWj5cf/
	gzOvFzcUwjwq5gMTMlxrRLWX+piZ40VxzsDKtl5d4iq/Ln2whSFAsf3trotg2Cm63AW+1g9nvUK
	aOeASffk5k67UYAtOmJ7q27jUAn+8wwgJffu9Qf7bciIkXdLDEqmHj64PL4PtE6c5Anv5lQoB9C
	gRTpuXbb6r9foMaTYbg8zvvy2JY33YfbDCLfsRkNy+iYeXAUCabdE4j59tcBtPprCbOlgcGe7Cl
	Pgq/uUDcld
X-Received: by 2002:a05:622a:18a9:b0:50f:c36a:3828 with SMTP id d75a77b69052e-514621f7ca9mr207125751cf.58.1778268161086;
        Fri, 08 May 2026 12:22:41 -0700 (PDT)
X-Received: by 2002:a05:622a:18a9:b0:50f:c36a:3828 with SMTP id d75a77b69052e-514621f7ca9mr207125301cf.58.1778268160628;
        Fri, 08 May 2026 12:22:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee? ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db13717sm5497605e9.28.2026.05.08.12.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 12:22:39 -0700 (PDT)
Message-ID: <f00ef10a-9adb-4553-84cf-24995598ec1b@oss.qualcomm.com>
Date: Fri, 8 May 2026 21:22:38 +0200
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gWgoZtuK6nZ+71QbdV96GXq8McQ=azcCuceph3XxBD4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dIqWXuZb c=1 sm=1 tr=0 ts=69fe3801 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=2VRkuRyHidHvWF5fyokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: EVGwckRIQzKBWx58Yz0pqcFRAN6TIhJs
X-Proofpoint-GUID: EVGwckRIQzKBWx58Yz0pqcFRAN6TIhJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MyBTYWx0ZWRfX3AC3IQn2P471
 0S28XJtLquv2bp8FxzJ7hDILBydM1cvXs8IeXNUofNYzoUcn3KiN7T+J6q4SG8FubuzvI2Rm+l2
 3eXNY4X02p0X3b4BjPKElhI1664nRO2Z4OmzaWxXonS85NiSoUptNv8md83otFNwYAu5WG9p2bm
 DgLwCRNBLQtXkyXigQX0o6KcMMttusCqDxZtwdeKdjY4FxIXtXb4nmQDjdcRaD+KEYSR54CWy0n
 VXw2EFltZW2oJ5R/qCxXWqBcTBXNlTZ6qdzhHsBE0UQzBtfFvn4x4PPLj7TIX0W1aA0PcUbwyTf
 KLPvu5+BwCgmGQTMwlERw4iSBgmjg/ZxhLuZ5l1Sci7O6flUx4uA2pyZsIbVUjg4ECo++JzKaVB
 LpAM8ix6lOZWmY4W80aeQ7PiqxKuPNrcSvAIbZSjtJFPs+hZ2E2+70CviGtYyp0Ad2GtBNuVK+0
 2zI0GYtvrMzjyZ7NJvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080193

On 5/8/26 20:24, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 8:05 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> Use class_create() instead of a statically allocated struct class.
>>
>> This allows the thermal class to be managed through a dynamically
>> allocated class object and avoids keeping a static class instance
>> around.
> 
> I changed it the other way around during the last cycle, so is it
> really worth changing again?

Yes, I think it is because it does not reintroduce this change:

-       thermal_class = kzalloc_obj(*thermal_class);
-       if (!thermal_class) {
-               result = -ENOMEM;
+       result = class_register(&thermal_class);
+       if (result)
                 goto unregister_governors;
-       }

-       thermal_class->name = "thermal";
-       thermal_class->dev_release = thermal_release;
-
-       result = class_register(thermal_class);
-       if (result) {
-               kfree(thermal_class);
-               thermal_class = NULL;
-               goto unregister_governors;
-       }

It is replaced by thermal_create("thermal") which allocates and 
registers the class and we get rid of two global variables. But up to you.
