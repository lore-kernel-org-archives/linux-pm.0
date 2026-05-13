Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A44968E8
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687296; cv=none; b=h/Qs6XYYhfbEKCMDsS+G1eda15/l+RjiXPnJ+khpaTe8zLiHzlEVtcYugnDLDi1FiZzWcBChanZZOAdPJgJMiaBmnVDbfAzjoLlV6BnawdSLbQJx5Px0MTwi8wG4kiLyXinqs2omc2/tM8vy+SdAoOxXUw6TwyY96Ej54ehU8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687296; c=relaxed/simple;
	bh=B6gVdJ82eASWzVEe3re8W4x0Ic8ghsqQNSaR51u6ix8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJCq8nKhHw7p3H/uMPxqFOi3tw8DUZw6h89aD4UOyyspMsjYadCgB45BHufxjMccUGh7bddyklFyMnFa2//6cLOdDrEQiMtrQO8uU4g9QqGIIOdRyHvYW3RVHMmpFJ/Hki9VvlUvkxlcG9X2Ioi+2KV1MMxxFfBk/sPnljtOivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agK50N43; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AvHvrYjY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agK50N43";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvHvrYjY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DARhxR2321427
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WKXEZxJliKRGFa8fwM078KGSwPOKmBzehEwSz/5jnto=; b=agK50N43D9UeK4zO
	8RcocUgXY32Q4MGd6h6CFG9cxRUheGdIkUMZEghW/63TbNtkdRYw26AECtcPGQ6Z
	6e4A7JNAUBICz5LzrHwUFMFRdby/z5eoGYBpvKuiFtbUAUJpr2bLru/5KMq0BHEd
	fakWmFJknYU1w/I4DtZlvN4UHIIuEbu7YIkkSjnAn8cM0SGOwytrTSSns9io1k9y
	63U/MQgzHUjpBaJ0sP6T1FMkt38vOV53Tma5hQPp7pzB+GaLjeydzAQ+TmHSgpFC
	MunXijQ5MaRwUn1Kc/6bsrtFpHGWrFsOa4plIALp1M2ecjJYfzBTi5UzX7H18zKo
	8UQkpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguasfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:48:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5162ee45a77so20310761cf.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778687293; x=1779292093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKXEZxJliKRGFa8fwM078KGSwPOKmBzehEwSz/5jnto=;
        b=AvHvrYjY/+RJ0LAKxhGxLoN7/ndcYQCoPJGjXJFWCpTm9m3W2SPPmqTujJPKY4frkD
         uit8JDRc3+UNm+Hr0lMFVfG52A+XQARlUmcswW8UpmX/hR6FxuzicSiic7/B1GnKJZSY
         Fdy6i/FuYit/G/1Cp7xvJzSuSIHjUvjI45q+S49WyC/AIVAV8562V4aVjLww7HdJHXSb
         cIfWH0oR2aPWtwzBuR2p6CVLLq4eV1zlyM8s4+lr7uw9nXyhO/caXAbpb7w3eVb0Jxjn
         q56fA20Bu7+tgEZsES69Mu3wbMApA8gGBYbJMaqhSwvoeLxaerztZSXBodKdSHwbh/Lw
         eT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687293; x=1779292093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKXEZxJliKRGFa8fwM078KGSwPOKmBzehEwSz/5jnto=;
        b=DkO9wdqPonOtlZeVX3DjZz8nohWbecLvMc5T1FXuot9W9qAsZO7JlQ8FLhDdoAHcOS
         q1dNTtHG1UNcFILAP9+OA/kXTVlqX9xmiGpVOFsZLbsOdd9EkORMWBeNoSEWnVFCzt8X
         3tRiL3BBTB+XaZJX7IjDLzLrjupHRLPKezXxa85++8Konb9lU0Dfx7slUiaBAQlguY+t
         iSmupTWaWadpO7wmhPbbjZD3mML+wdOH1DJsVY7EVEbHo3FWcHz+PWeuPuLyYTK5SDNq
         j3akFfPvmnW9oNIMgTMtpZ9R9qbnUimu7G74Mc1UsZwi1d5aUOJThjPnmpryiqiXMJiH
         epKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GE8cHetAbsJYf4eldSddWj2qNQZiO23R8f82MLQAky/7dqRelmwoyBihcVCIqB9gnHM36z0AskQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMo5ykjH5o9tSMGM6kOIFUf4noGKF9VpPAAZ3ulhOuDFgsHlll
	1Lk41RhQchyZYeL1rMz3ZN6vn5KFx6Kthtw9OzLLfiTMdOZJxHeAUWMEDt6diEfJizotdcoo0WP
	m9HA4hlSBbE0+194gwFfvDqQvxcdO35AJZbD7zRbuqEilDOPBeSn39mPOcg5bO2SWVOZFIPy4
X-Gm-Gg: Acq92OFBXsfwWV6sMlHCKG13wWp6OnhMOwMOCyKdPfhIlUkMzOkRt9fVb5aNJzrPt0v
	L87skNa/3MdMF7WsEVRkijg2SwRYLXF481YCZxhC3jQKKEc8K9o+QRQ9G4moEOQCUMKMIW+V75f
	U3ypXfmxKpVAbkISEjmdBXSKMqM4RqZ+2dOgzqKQV84WXNerMMgzIlfQzhMzNbpMWsy46fi7QoN
	isUw/40RsW8aWG00Ugwfus6Loj65UwOVkmaieawE6EfBnRQlD7VfYnal82Pk/7Akv2WsgXoq22u
	iXH7mobXYjHiOJtp6fxL5uB3PEAEp/xRJ/DQwlojx/zjPWVC7VDcmCcDJ2gzSM/1UEZocdSrCdG
	WSUsDlIHUoymue82bGpmNTvEqo0OPoLPcfjK6921EtV5WIfOAzrX6K1UlGh/HeZKrtcqmcLuzo0
	KICNqXL7id
X-Received: by 2002:ac8:5d89:0:b0:50f:b9a6:82b5 with SMTP id d75a77b69052e-5162f452f86mr50532341cf.1.1778687293266;
        Wed, 13 May 2026 08:48:13 -0700 (PDT)
X-Received: by 2002:ac8:5d89:0:b0:50f:b9a6:82b5 with SMTP id d75a77b69052e-5162f452f86mr50531721cf.1.1778687292592;
        Wed, 13 May 2026 08:48:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8164:8816:f817:5d0f? ([2a05:6e02:1041:c10:8164:8816:f817:5d0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm41948631f8f.14.2026.05.13.08.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 08:48:11 -0700 (PDT)
Message-ID: <07a879f4-f114-47c0-9edc-be2158832f1a@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com>
 <48c1ae15-3fa7-439a-a492-c82b39fb0a89@oss.qualcomm.com>
 <CAJZ5v0hxWiPX2iGFZjsF8eiNuiXEXm_b0N9RH=Z1M+JsV268jQ@mail.gmail.com>
 <08a0a584-c752-42af-8613-9a790e4becfd@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <08a0a584-c752-42af-8613-9a790e4becfd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a049d3e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fSSiD8RAkG727a986RQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: eBvm63VvQkXEjLTcpcovnpPThy-D4JKV
X-Proofpoint-ORIG-GUID: eBvm63VvQkXEjLTcpcovnpPThy-D4JKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MSBTYWx0ZWRfX4iczQBEPK2CY
 5/2i3DZMuge1BeCSnJzb5+a17/DQRicc+C/cYEnSrNrtW9+PALeTBz+6FPvX3VHpez1F6zanlZW
 13BfBVSUCxyUceE4e0FlL0ENBNkHGxfDHqgqe2OY2/42skBuQmd98eP+vKsqDGT6Xg7sXIOrkU9
 TUGJKC2c4ySG0YeYQvmgj/iIHQrebZM6HU41bqkhrl8VGuFFgFu9szLDq5YyOCwX+oy1cz3v6DK
 gWv+gi9bmdY4QaNGZ1zpR2XXp8uZroz99auzl2z/yQGLY0mvYMI3c4J6AOiKWrgNxsUA3fLdg79
 5N43SdOUedfjSctTRAe/M9m8Y+sauG2MJpE8LJiTmabH6+oiXMKgwHkyvHNV/lj1/RJKZa0wnQ+
 Ph2TX0AJfAR4vMSvyeC/TTtBpO0U69wDW8paiA1tFYTuNmlq1w0yOJMMydd9EIDqDFQZK+prDqW
 GRK9hSReIX0tlBQPpmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130161

On 5/13/26 17:45, Lukasz Luba wrote:
> 
> 
> On 5/13/26 16:06, Rafael J. Wysocki wrote:
>> On Wed, May 13, 2026 at 4:22 PM Daniel Lezcano
>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> On 5/8/26 20:10, Daniel Lezcano wrote:
>>>> On 5/8/26 20:05, Daniel Lezcano wrote:
>>>>> This series cleans up the lifetime handling of thermal devices.
>>>>>
>>>>> Currently, the thermal class release callback handles both thermal
>>>>> zones and cooling devices by checking the device name prefix. This
>>>>> approach is fragile and mixes responsibilities across different object
>>>>> types.
>>>>>
>>>>> The first two patches introduce dedicated struct device release
>>>>> callbacks for thermal zones and cooling devices. This removes the need
>>>>> to rely on device names and keeps the lifetime management local to
>>>>> each object.
>>>>>
>>>>> The last two patches convert the thermal class to a dynamically
>>>>> allocated object and simplify the initialization logic by using the
>>>>> class pointer itself as a guard instead of a separate boolean flag.
>>>>>
>>>>> Overall, this results in a clearer separation of responsibilities and
>>>>> more robust lifetime management aligned with the device model.
>>>>>
>>>>> No functional change intended.
>>>> Unless I’m mistaken, the patch sent to split the cooling device
>>>> registration is correct with this cleanup.
>>>
>>> Were you able to apply the patch splitting the cooling device
>>> registration on top of this series ?
>>
>> I haven't tried that yet, but I'll do it later today.
> 
> Just to double check, we are talking about this patch (that we discussed
> back then):
> 
> https://lore.kernel.org/lkml/20260505144447.2853933-1- 
> daniel.lezcano@oss.qualcomm.com/

Yes, I'm just wondering if it applies as is

> With the re-work done here, I can put my review tag into
> that patch. The error handling paths there should be safe now.

Great, thanks for your review
