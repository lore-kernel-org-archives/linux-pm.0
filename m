Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6A43B6EB
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509398; cv=none; b=EhZf45BYXAsIwizDvKQfoPf96cmedS/CqnPlQaGdmVuT8SLKXjvSh2XLrfrrYwksM0WttGypqgKSB/zB/rMi3BU2hXsS6eN5NZNKnZ2jfJVoZK54HzkmSl9jHLajyZWGQIHLPt+gBbvMtm7lsuR7p6Omr46pntWCA/ZkXzMXgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509398; c=relaxed/simple;
	bh=T30Tq3ggKDbteLsy1U84/TctejsfGDMd3r7y4dsbJKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6T3VNSDffs4/eTPKHnKRf//7jWUu2fSG5WNGX2oI92IoG1NvXQ7SSHlKIJogajvaMbBTuYqsX78JxeNwWEPb15n9ZpC58B+ijR2AaU3U06B/6yGhpeo3Lhfb7RAJqUE0L+FUsT4GmyuTP6HlAqflUAewJI8CqMgC492H39YEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2/TaqbC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOey296V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2/TaqbC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOey296V"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66888xxv2083234
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 11:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RRFbIA+uhZJ1/kqwFGK6iYRh+oIYC00DEy4Rs+x4Vlo=; b=U2/TaqbCIsltRNoG
	6R2vFWQmOOo4nxA9fs0usJFZvVlZKO4NMm6JGrw3EEKYgtCP8XG3EX95u2gSbG9n
	WrGURB0UyME5Y94Xw/x2Iy/f/AbcsekeeHocqX3jaKHxR0NA6x0xVZVzppI8MI+2
	ZYcAbfMPoTm0IplYmOUw1+I/IrHXE4+yEmEy29KnoqBc0fi8M1z+tL4iGalk1THv
	t3GvIhZqrzYAJCIhGKvyTc8bkmGALsjHLHxy4Esrb2MnbMH+evGXHI3rMXEaVD/v
	VHROZSjLlAq20VBV6hFUbrGgtwROuA9qM9uWcTISkYCxFoAdMPfKLGYR1zydD22Q
	uOJFAw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqw98ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 11:16:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccbb61893fso16890945ad.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783509392; x=1784114192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRFbIA+uhZJ1/kqwFGK6iYRh+oIYC00DEy4Rs+x4Vlo=;
        b=DOey296V/ke9qu0N091Op5Y3+jnk01kgxFsOvQzmJFRAtn07qmm2zlO4Vx3hskiWbB
         VUgAF4KUEosCO1glrF7Xh8Yw3qSKq5BslBW+Hxd4Ws4jfW3FHgSjn77SJJlBbY2Hxio3
         ATfv9vM6awUVQ4it7pKj2uA1FDf9GaHBZqHScuxB9lSz56XgwR9bj+H84hMr0bqKLdqA
         EevNjDm3uQoSMZjaHOHwDPcI0bVDs9aMij92Lh5zT4YIb3sZdiuh/nk3LmVfKMG/MZn/
         2xZ+QXhV4KM+A7P5EHTfV9vkxs4bKesFbLUWLpYZXwDD7SCkafZ0RuYWJG5UpHyuYxtv
         fq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509392; x=1784114192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRFbIA+uhZJ1/kqwFGK6iYRh+oIYC00DEy4Rs+x4Vlo=;
        b=Si/rEga9dGp1eM9I9WQ/ytFkuj8mbIQ43kRTfG2h0XXtxv8ZbmuaEiW6n+lwP5KWRo
         e8rkEFuAjxNaaVH3RlPTG+YVGWzJl/Jn0BAFFvJnrrffrRpyehWHhWT+VLEw3ae4MGnP
         dbAY7xIoK+zeOoKkfbqafsphErjGCSQY3/L7p8zuZukuUzB6UAfqRaP/+5hm13D06n0G
         Sz4sQ0Kwr8OT351dLiNKGaFKnC5sv8DHqwDWlW5Spja3t11f8E1920YOmaIA1nsiiHif
         FWA0nCjIk2Wz0H/SjST/5vfo7BxvDCEqkb6lt5rtclWAbMAoKYyekuvi7eIsfcTetDPm
         5LXw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ2HlZ7sNhzfZAvHnjhy4uptI4b0jfpR1QjsZTCjbLI//GLzgUwjAIBo9EjysHAAcT2cr2TtuAMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9VXywOlToqzkHNHIZ8lIVGQAN65mnm/dLCdvoLB5sk70OfK0
	INzKhGv0dD063YBrGmJ9GHE9wE0Izg2CZq8hrndxFznu39qQGUYlrGMjMh+BLPlYUztzcg/nNpv
	lFw+gkXD71oxT+bJyWovC8mKPEssv5pd1LFbWcMFgK74TRxX9W0ablMp8AMHg8Q==
X-Gm-Gg: AfdE7ckksK8gzhxDcizrOVG21L1AHQiQ+m5pzYIPsBmAtggsVeKtFcFqLAm8EdGZt1e
	oDIfHGJfn4egDhm9jnNKtNVA7Ap+/p7M6wiT3/qrOmylJzILfw2W/oW/s9L9auIjG8PwzYs5/KK
	wnDlFsSBt5jvjt4pUySJD5jLDLBzP6v9lH3tVXlPJRr7cD3pofdjrxlydy3mxTBolFVBaIY+jmv
	8uqHrja83PYLQ5tZbk/OopIBR5v+OeabLLrD5xtRODaigJXn5rL48mTGaBXy2UZdRIBTMa5zaaL
	FT/QVfw7ul8bRJcLEtgRxW07oJUp7DK0GFiRHH8H36QjCPjeEg7T+p6FI39i9xXBKvshDegxLmD
	IoK6xVpEDxd8tzJQUIDtUUh00HmGz0dedZFAUCjqi
X-Received: by 2002:a17:903:1b4e:b0:2ca:d151:382d with SMTP id d9443c01a7336-2ccea3a3cc7mr21992365ad.14.1783509392012;
        Wed, 08 Jul 2026 04:16:32 -0700 (PDT)
X-Received: by 2002:a17:903:1b4e:b0:2ca:d151:382d with SMTP id d9443c01a7336-2ccea3a3cc7mr21991985ad.14.1783509391556;
        Wed, 08 Jul 2026 04:16:31 -0700 (PDT)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm26753585ad.0.2026.07.08.04.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:16:30 -0700 (PDT)
Message-ID: <d0993d41-a770-4104-afc5-5a6ec02f742d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:46:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <31d10d03-8730-4735-a83b-957b750b736c@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <31d10d03-8730-4735-a83b-957b750b736c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwOSBTYWx0ZWRfX3Mn96E+rF+LU
 dXOcXHgXpE3JlF/kUy8Yql5PIy83ITwVtZaey3YFkLbwHai96abJMLATPISCd6LyOR3DlSNce/O
 i+0JR86wb1LDQp1ezBvxPE08SsLwpCl7RYM4LAsn0c+Qx9NgF/9bD9tl50QeIBdMk7G9llHm2p6
 qFXFGHfyI7LkR1MnE9P/HdFHbOCQRNZdEM6YeSzzhW46DjUBqcS8oaToKPqH5vbdVKSn0l+jgSi
 DI5eu0H6fVKNahF997HeiTkgBNgJ1mLsKgTWsRdb939+9pBZ9yjuhxM/+cciNtnPq4FG/yr4X/9
 +7XyG3UByl+1jFgbykdJjAVHbEXD5ZOoOB/mhJgHIBcnegY1+fjrr5nd0yx5EtdvSCAGKbGdsKT
 uIUZ0JYgWHJqHMfUCU9qb45B8QAUon54lm0rdUcEIQPl6vw9zKcQcn6+aHaWhWsY89ZLIlc8cQL
 IRx4+tfFbS0uXB5tKWw==
X-Proofpoint-GUID: Y_PB104R9BJSXh0dhS9WTEfSbB30NMtU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwOSBTYWx0ZWRfX0wBnVAUhrxX0
 hPt219/EqRWZu38R/yRlHrTHRhQdMFXbMATWI5VP6B0GJvnjK81U4xI6ulunVy1CQql0ZnKdqF9
 YT+lajU+mDxl0oONUbFCfZi5y3hbSeE=
X-Proofpoint-ORIG-GUID: Y_PB104R9BJSXh0dhS9WTEfSbB30NMtU
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e3190 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=I6ZbpqCI0Cxx4O-sBFcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080109



On 7/7/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 06/07/2026 20:11, Daniel Lezcano wrote:
>>>>
>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>> need to add them ? Can we do that incrementally ?
>>>
>>> That's what I am trying to understand: why the implementation uses only
>>> the selected two devices, if the modem on Kodiak supports others. How
>>> can we find out, which TMDs to use on other devices.
>>
>> My understanding is that is an initial thermal setup. Gaurav will add
>> them step by step while setting up all the thermal zones instead of
>> sending a big patchset. And TBH, that will be much easier to review.
> 
> Not sure if I understand correctly, but bindings must be posted complete
> now, not later.

Only TMD endpoints connected with a thermal zone in the DT are 
described, these cover all required kernel-managed TMDs. Others, such as 
battery current limiting (BCL) and cold temperature protection, are not 
controlled from the kernel thermal framework. Will update the cover 
letter with these details.

> 
> Best regards,
> Krzysztof

