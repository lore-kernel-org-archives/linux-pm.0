Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E078357CEB
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610378; cv=none; b=T6q6U+Zp/hiTVSuh6kPrgvuPbAH3dd2yCy94znG/z6fZ3fnETTwP5rWOrPxKlpNStatnbA05NdBE4JKSCtoZTZ38AfdgdQuhMcMhu8un1BK96beepKBxdEOoXY8Er4M11/3VGJzh8TqgUlOA8Qq5GzoMTid16ezLGHrpT2eGL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610378; c=relaxed/simple;
	bh=xUoKAl/tOQq5A4/9OWwbo8axQZkqumbFn7aijamQtF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qej8unpDKvz0rkCyjr0rGNxg5GqWQeHcF8lFUB36ouxcq/xvZuXiME02cFm8fRrmSdaeO+ZuBRnlsovxMiA1+MKivgZTC5RMEaOtT2aRUbakyCE3v6aKTzjIUJoQnQRcSn+jUSvr+J0CaPcXy9FyoCTCnbmNi61aLnZSKUF501k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bo56dbwm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B37Sux6Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bo56dbwm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B37Sux6Y"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GABtu73384276
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 11:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LH1kOVRIq6/aNLun9y9f8La9VZeozCmkQYJl1HbzIHc=; b=Bo56dbwmNHgvMXRI
	jYdT2sZav8I535vosXMy53qAKfGnRoqxChiIa2jwUkFsuVmjFYyt9Xe6myBFHZtM
	bFmytrdwD1mGF/K7RWuqYOG+d35rqZg+BBVwB4aGnRdRmFcMc1CnI4MQ0omu6eN9
	byk3OZzTlS3TOueomdMPXox4wdqHZADi5lFAMCZ+t0h/9LfDHsJrNmEnKqm5bCGW
	Ld0MAFsVluI7/+Ngz9SdTaQ/Pw7w9bqdU9KkeGC8gHa80pez+CePBVHY0wg75XZ6
	L7/dkpwkNH+hcaNaM9healHt0KfbB6HsXpjgq4lwnL8bMSLY5HuYP+cUqomY6Qv1
	zs4hGg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ep97hc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 11:46:16 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c5a5133221so139219137.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781610376; x=1782215176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LH1kOVRIq6/aNLun9y9f8La9VZeozCmkQYJl1HbzIHc=;
        b=B37Sux6YL525ZS15qZXQ+BM6iLBEw4nCdSWF/oJejLU85G77OWXj9GR+6oGDNIDV0o
         wa8uyUfkNzOLS7QuH1/pKQbt1skXgtHpGJOuVTBUKd48lL2xxWbBlXp9BWZn75T8CDF9
         1e3aoBCe3LbFZgm65vwBM5ZrX4FOoa7Ob2kYJPfOvN9Rv0tHnBX+Gmr2XLnrSHAwcDZ3
         F+hKfUQgU42E8csqDPD5WgBCQBQCdTTIn+yslxwlG8+uMw/s5pGWxGVCmCw+T/dc/OEh
         RjAg75M8nBXJpr11yD4ZG6arS3hBice8Wy4IOq1yGZ12COxfkhjoHKWQ7WIWTYUtJcXF
         /ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610376; x=1782215176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LH1kOVRIq6/aNLun9y9f8La9VZeozCmkQYJl1HbzIHc=;
        b=D65/F68ftiuyqIjswFLy4+U/ZzPVPOFYRsCK+e3g/IAw2XIdo7q+o0mfWW81eqYAj9
         uWqH3PTF3DFYJiJSQpvWZGaaTuLxAKH1JsguMgTgfyw7sBKHKYMIZENdSCdKatKq6LQC
         AjCJ8Dko1jo4P25MBcLJnNL2fWDj7ZNL3SzgnHR/0XINOdPsJ2uOoJhItFlDHK6EvhwH
         10CiIBVoQou6sevDpk8BiheaXRLEXTUFhamfs4HUVtw3d+1u5mbngCfuYg/X4CJhzHKw
         uG+bNgLwbMp37WIXthPFuNIX0wHVI83JWny4+r34l7niRbZ+Efj7qcWS9dmwUyv7EMwt
         nOcw==
X-Forwarded-Encrypted: i=1; AFNElJ9PP+07WHxdXIvK3mkID7siogE92zq3l+UfwtAzYy3t7qEJUKUjFFBTJnnO4WRmlX0I96h3r79BaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZoImY7HC6bEnq09Krpulk8pq76opxVpvyy5vNlRqRUpLV/Tg
	WcenbRkAYMz/9XOFrED7aWsH07D4j4PUBXL63xwvHE0qY1XWgsEpMpqM+DrZjxHMznSfY47S4Ck
	1+VY6SXO9YTtL4xs6xQxPac9U2yEIIShLUiJqWV+wQSE3FhH2gnEVULJBxUluag==
X-Gm-Gg: Acq92OFVLTutXcWWVnD0RjHzg92lk1rknqx6dPHmgH23PFrCbFJaTa4clKJCifFQdty
	Dbj0slyj0XOLa/oA1fixywrGXJ/LalPFvbiyAwSMx0oHsrj1d6hWFPZWHOrd7L7JX9kgrn+pIu7
	CIAep/XJLiYYm4gQYWGv9dRb74OwS4CqCFuDnahSx7D6mULe/S7QqAoasJgUyleeYuf77jpiNm2
	tL2mcqydlc4twJkVS4bOeP8YoqVX5T0jKK2tqyKZ1h+STeTiY9oQiogE7WJGrXedZKRMhKjv3JJ
	fw4sx+/hTbZ69Bwsx8ApYzXS4MOXOIFomCvEaHjkvLoM1tgAXstm6SWIY371RVbjVmfC4A/6DzU
	ENY2OKuutH7maskYt+1qtylmrhywpsqvUEa5a3MVK90vSKQ==
X-Received: by 2002:a05:6102:3f06:b0:674:84bf:8e0a with SMTP id ada2fe7eead31-71e88e6c8d2mr3158907137.7.1781610375811;
        Tue, 16 Jun 2026 04:46:15 -0700 (PDT)
X-Received: by 2002:a05:6102:3f06:b0:674:84bf:8e0a with SMTP id ada2fe7eead31-71e88e6c8d2mr3158899137.7.1781610375389;
        Tue, 16 Jun 2026 04:46:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693c6d7cf3csm3940045a12.14.2026.06.16.04.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 04:46:13 -0700 (PDT)
Message-ID: <fa071c6e-2529-4410-a5b3-3c077d4cea99@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 13:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens: Disable wakeup interrupt
 setup on automotive targets
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
 <20260601-tsens_interrupt_wake_control-v2-2-ce9570946abd@oss.qualcomm.com>
 <80333371-48b3-4cdc-85b4-5625af6517ff@oss.qualcomm.com>
 <5b990bd7-e234-49eb-b5ae-5ec117fdf2d5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5b990bd7-e234-49eb-b5ae-5ec117fdf2d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a313788 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=GStInHzQdJ2FNXMrR3UA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExOSBTYWx0ZWRfX2TmAxevnum4c
 GUljCOEIu0RorGusNz0cN7zKr1fK0Ra8ZEpeDLPOadlogNVPDmor9MXFhMCwKKxCFGJUvx0gFUq
 iu4kT3kn982aSkDCsIStnQHpxqjVq24=
X-Proofpoint-ORIG-GUID: 8eEm6LE1XkE7Ulx_UxJyxYv9MHUOI0kV
X-Proofpoint-GUID: 8eEm6LE1XkE7Ulx_UxJyxYv9MHUOI0kV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExOSBTYWx0ZWRfXx64Ozvq9+idk
 B5CLnMJoSM5PIf5eAGjh5FepZJD3iUBtV0qWPyIoIvN5yAN7ElG2wbDrVQRu5zE/UC9yAeDYb/9
 fOFGopsBpQxaEA6yB6+lYvgiDDmjXX44Ju60m5qX8dFsajOIm1kse/KZDlkeFzn+SrWU3LdiTM7
 SMM1e1k1JLlfNTMV4ewZBbhv7FwoLyrxhHhX4VpzfLC8BSuAmsZf87F5btp0u16HcVYMJt85fGM
 JQJSqqSKMZoqSzZS6WOA4bkAtZPXyMDDVuawm/yTavKv9Sxy3EkR8RKNOv9TYO/FqTtGHPZfd2Y
 7bwh3wMa2UxeQp0MGn/njV8k2TyFQ8m1SLPm5ZZ6/w6fXg1kbfp8qdq05TMmC4phswb88N9x2+s
 QqbSty8bfO5zv/wrqh5djhM5fDhQiATLDjq/L2c3lVM6phIxPzUcAXQ/ODFGF9dzsTFtK1JFw6A
 UKpA47IshkNeML6OwlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160119

On 6/3/26 2:27 PM, Daniel Lezcano wrote:
> On 6/3/26 14:25, Konrad Dybcio wrote:
>>
>>
>> On 01-Jun-26 08:37, Priyansh Jain wrote:
>>> Add a no_irq_wake flag to struct tsens_plat_data to allow platforms
>>> to control whether TSENS interrupts should be configured as wakeup
>>> sources.
>>>
>>> Create a new data_automotive structure and add compatible strings for
>>> automotive TSENS variants (SA8775P, SA8255P) with wakeup interrupts
>>> disabled.
>>>
>>> Automotive platforms can enter a low-power parking suspend state where the
>>> application processors and thermal mitigation paths are not active. In this
>>> state, waking the system due to TSENS threshold interrupts does not enable
>>> useful thermal action, but it does repeatedly break suspend residency and
>>> increase battery drain.
>>>
>>> Allow these automotive variants to keep TSENS monitoring enabled during
>>> normal runtime while opting out of TSENS wakeup interrupts during suspend,
>>> so the system can remain in low power until ignition/resume.
>>
>> Can you not just disable the wakeup source via sysfs for
>> your needs?
> 
> AFAIU, the system will crash for this version, so it has to be disabled

I can't see a mention of this in the commit message, but if it's the case,
it should most definitely be there in writing..

Konrad
