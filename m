Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BE493D51
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141482; cv=none; b=C/9cnOBrSVCnx81MYuiSDG61R+xwDX+PdGjmQhCnh75vFl6lLxzGht5EFpz1ha5j4E7CpXSOD0Fwh7VCqNdx3Z/fm73MoYEH/Dfg8WQ183W4UnlOWEtOdgRXvvaJA5nhDXGYZYMOJGCb3UTPkiirfobNJYB72zKDDFmGvVuxfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141482; c=relaxed/simple;
	bh=lcR2Fhlxl4eRvKV2aDV7+wbKm3ijM4c8/wlYtrzXmuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C58SmY5FhkBqrJfrMyAyrXNXE+MnjChfR9Ue+/o0WZ1fwiDv5P6usN6to8s91JqgUp/MMxINdWUcheRw9FUKOw+bgFf+DD4OOiNAZ5mTf5q5KlVvDYNEd7FIlfz1PPTY8XrpFjzrTLZfjY2DSFi6wV/fj7BvIpO50MexV/0X6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ed86Ehpe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6o0C2v0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ed86Ehpe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6o0C2v0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BF8imc170556
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q1DIDB+x6TVxI9bR6AVmRa+Nh/rJ1EKyRd7jafxRodU=; b=Ed86EhpemUWHPrpc
	A1/sabt6fK8VXcL0QXO1psVFVXBtxgBOqiMOVVKTVNUbL6Ix0S5/uSN8lMRy5o1h
	bEp4bcgFBK39K1/AormBdaeIxzzMVytLiw6SiFs/+qfw411lM150nI3LBz6IzFrO
	dpIWtLuA0y3K9YW0RecQN9FmyaH2S73Itfe6LJwvcApclFutva5MjW/VMkZFqet5
	D6w/JNsd8sjpH5qqxO6z7gfZu8NG5Xk8Lmi2dJqOWZpaajC+7sqfg+G3ew1lkLSD
	dPBs2kEFeS9SJCSEvw7CENnRzGYlq/zWeTM9o8YKJvJMA/TyrgjmFNiNP0TWOvY2
	1b4m7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e850d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:44:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db0a41434bso18156195ad.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141477; x=1789746277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1DIDB+x6TVxI9bR6AVmRa+Nh/rJ1EKyRd7jafxRodU=;
        b=G6o0C2v0QDxhlbjG0ZrIE24e9Z2aiVf3dIQvywz+CSKKGRrH6ORq2FFrZaOD1U0p+6
         qwYEE7m+FF4Fa7Cki2qtSdFnLbkR+MIOp3XWmPiODWPa5RCVqQ5ori4dzuWkQDHIyL4r
         Rx21yPINF/qUO8/ctbY0exeYXIEYV5VYG8U+TfZCqNK5SQ/ytsTTfknGF304cuqhrsnm
         loBJJfWauMrNifLYpIbzPmFNnSALv6JwYa53Ize3jRCaa/yS9ONrb5FyXeYgX3VICHat
         KIWD2KwJcCywVizuGKXZVvHyZk2OOYj6jonZDpkngFaVWhs15tvmtOyJpxo7axx9L/jo
         xc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141477; x=1789746277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1DIDB+x6TVxI9bR6AVmRa+Nh/rJ1EKyRd7jafxRodU=;
        b=KH3sTPJOxhzQ+wsFrkl7/q0wAd+pxeKybTfHpSgus2npMThlLa3Et2teYuhw+LrgUL
         PX5UYM5k+wZ+SkMCzyb1pJx+f88+oLLx9XRsamJooTid9zLoqVicYtYXpWIwV5m+cLPu
         DuvfSjRI6gpBdTt2DySw0mf+XPAelbpwEN2/YfWUcCcBbFWPP626bae92O0GRfRDwG4W
         OtsR5ETnS58Tdc/U7oWfJzxysmRWAdNj/KxRyVyo3WyVyPZUX2NLBIK1dg3oHqHF3GDp
         +HpzwWhNPmr/GFo6gF4gNDKzxGcQILsKYjqLV0XEZmSOODElDcXf97B7DRu24yghNADF
         w5kg==
X-Gm-Message-State: AFuF++lY1tGWO3AakUw4lpZ4NVjy1MkQ4oLgmggEoZjkO41j6N5OlW2I
	OsIIwS7cseuFtBYf2lgYWAOnpFjSiFs7GT1xjgrW8TW/iJ1CK3Mb7y0PWJ/jyfDhVQssAKop5nc
	buymlNQJZ0Nf/b3bj+qMQR1Li2xJl9KvsM3LvoMkZReNPQWdOonsmtDTX0MLw2g==
X-Gm-Gg: AYBFou2MFr2RmSwFJOvVDWTxB7fm4IoFvQ24yb0ffnjkmwUx3/3Un8stYXIs7u1gnhE
	+YJXio86byMUDV0CRoVxiWarm5REhDDW+qEtt2AqAIJF87Y2ekMHWY8HsoJXwcc6kF/93OrSi+f
	2nFvIbUZECZ3neUI7wRlDzvK5+Us+Q65w4v+1efdfr8sxLyQziuJ+ChXTZ1WGqxinCG3LUIDled
	NBOGd7KyChJVLN/abm6TtDx8iIRZgSbiEY0Hu1Tmy28o3UEKJzwtUT0yTcY1QyPJ9D61TklKdX+
	8zUR2CMV/wDJ0aabE/0eTgffi0mz+zqovamBraVSvgI5X73WzYcP0gDpvCChtVJpFX6HJVwwP7y
	+SK+vEKZAjwMfssOlbiavdPHql/LJC4msqw==
X-Received: by 2002:a17:902:e745:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2dd2a3502demr87243905ad.16.1789141477454;
        Fri, 11 Sep 2026 08:44:37 -0700 (PDT)
X-Received: by 2002:a17:902:e745:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2dd2a3502demr87243315ad.16.1789141476868;
        Fri, 11 Sep 2026 08:44:36 -0700 (PDT)
Received: from [192.168.2.5] ([183.83.172.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfef639sm13357245ad.71.2026.09.11.08.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:44:36 -0700 (PDT)
Message-ID: <908bb1c3-c9b2-4275-a8f5-55b51ac84988@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:14:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and
 selftests
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfX+398/PIAJp1K
 zyjgQuzSqumgpE+lsDEtdrmWoFUGELrgcbsk7XW9cKayuQWgcu69OOKekQbUJCVc7nohR40A5x+
 gcZlwL/hZwQCbO0KBix5paByES8Fq5ifl7nX2tPCR7gfqMyFa96cVFrT4np1lcbz839K/r827IE
 /BiP5NavLa7lCakVH9zOcENFGZbeygLbKDUrmor3IwOIXLtHw/hXoqfURastqXHlToUghJkQUuO
 /IFZx7jL/nIA2qWHeB7SKbhL5Bt1BQV3HKZtwgZDS/+5wl0hhRYx8UgnoWpOs6ly+3Nerd1oEGz
 yXVmTCbO2TnHBVTfEuNh0okm9GR5XVTlvwov2U2utaT+4ZOx8JHuHZDBUHcHxGLo1rAgYh7BHUc
 QW5E0EDdTImeYfYGnH620VrcXywQ9Gy+WGGxoVs1VERRQ3rc26Liklvr+gOBBCtXC+OoTGR76R5
 Z/FV2ffo78K0oO4W/AQ==
X-Proofpoint-ORIG-GUID: 0XTI85AKPR0NnKwqVq20s5phy0JkovWq
X-Proofpoint-GUID: 0XTI85AKPR0NnKwqVq20s5phy0JkovWq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOSBTYWx0ZWRfX9rZqZikNhpa2
 dgL3rNkbfom/jN80jgylqQkFIn3CzcYYBsvYaJFIIpOZeAVRblImMC9wDjFEYUG0CllMDafnNRz
 7+DDpQ2nIBC/cfvVht3dS29oAkGmsJE=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa421e6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=OBv5q4clJIp12fzIbOuMAg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RYFYpSSLLWBHpy-p7LEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110219

Hi Daniel,

On 9/7/2026 3:33 PM, Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> On 8/6/26 13:01, Daniel Lezcano wrote:
>> Powercap controllers frequently expose a hierarchy of power zones (for
>> example package, clusters and CPUs). Until now, each driver had to
>> implement its own hierarchy traversal, parent lookup, error handling and
>> teardown logic.
>>
>> This series introduces a generic hierarchy description and helper
>> functions allowing a controller to instantiate and destroy an entire
>> powercap hierarchy from a static description. The framework takes care of
>> duplicating the hierarchy description, rebasing parent pointers,
>> creating zones in dependency order and performing the appropriate
>> rollback and cleanup on errors.
>>
>> The series also adds a kselftest exercising the new API by creating a
>> synthetic hierarchy, validating the exported sysfs hierarchy and
>> attributes, and ensuring that all resources are correctly released when
>> the hierarchy is destroyed.
>>
>> The patches are organized as follows:
>>
>> 1. powercap: Add generic zone hierarchy creation helpers
>> 2. selftests/powercap: Add powercap hierarchy creation API tests
>>
>> The API was primarily motivated by the recently posted SPEL series and
>> also provides a migration path for DTPM to use the same generic
>> infrastructure instead of maintaining its own hierarchy handling.
>>
>> Link: SPEL cover letter <https://lore.kernel.org/lkml/20260702- 
>> qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com/>
>>
>> Daniel Lezcano (2):
>> powercap: Add generic zone hierarchy creation helpers
>> selftests/powercap: Add powercap hierarchy creation API tests
>>
>> -- 
> It was easy to migrate DTPM to this API and AFAICT Manaf was able to 
> migrate also its series to this new API.

Yes, I rebased my Qualcomm SPEL powercap driver series on top of this
patch and migrated the series without any issues.
These APIs significantly simplify the driver code for creating and
managing the powercap hierarchy.

Tested-by: Manaf Meethalavalappu Pallikunhi 
<manaf.pallikunhi@oss.qualcomm.com>

Thanks,
Manaf

> 
> Is it possible to consider it for merging ?
> 
> Thanks
> 
>    -- Daniel
> 
> [1] https://lore.kernel.org/all/20260819165605.1398880-1- 
> daniel.lezcano@oss.qualcomm.com/
> 
> [2] https://lore.kernel.org/all/20260702-qcom_spel_driver_upstream- 
> v3-0-434d50f0c5b0@oss.qualcomm.com/

