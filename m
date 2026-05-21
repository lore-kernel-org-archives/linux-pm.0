Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F53B5F48
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362277; cv=none; b=JPLRDkCvip0jCG3/IFax93hcSfIRIeEI+qLsVm/SnqE4KgnMeXT9UOuQqpDSVVgP6qolj+mB49I487RoAZCwfwO4RcWmoj1A+HG58hzlut5sFtZZ60Zsuz2JcFNKRxI2LCL4uVYfvWRgnv9pof51VC80uJE4qa8Kj2cxJb4Vj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362277; c=relaxed/simple;
	bh=xlK4wR30Get6eubzseSjA3iYaEkpST+adJFHECpBVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSp1EnfAaZnaKMJNCCk1ooiGRBrajodQgmk0GXtCJj7aTfbeSITfMkhefsiwmJBdEWhuroqOlKIkqNOSCfIP/XMlulTjvXmzh5dG48zGOogAc01w8FUuMC0IPpM20noNr/Iy6xf/LGPIowwqODpyF5ckFLHmk7wTYSVxxeXt79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZjX4Pqn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HX31AAsV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjX4Pqn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HX31AAsV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9A8s82633750
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rjOIjZmNsHI/mHiPsfUA2XrCOYx/OJ3QhhVcNXQP58I=; b=ZjX4Pqn8zPdSGDdm
	ItenlA+6zdadPvXLHk2gZn2oPAZjzKHm1WMHNPyZbeBCfFWnTN6EKeZzkseU3G2b
	1s0pExiaUmIZVhg2HVYr6+H68Z097LH+Zsni9jgRNKC+9YMhdZgE6GL7v/2h58iw
	x2/gtSOmaB+MdXkM1PxnMrAzVxDtaSMRd0+g/6Z5s8FOaPuf+1WxH5TW5gJaq+aw
	sutGds8EdlaDlsADCXD9rXyuujyShFZOpaJew1RHga1dVxHvBpEn7b71cF7OayC8
	vExZUrhxK8OtP8JFizNwEfToO15kqxGepCoEwEpeb1RgAZdKYGiHXqZqinvbCrng
	ICnwTw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8cqa9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:17:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90f6e66879eso147538785a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779362275; x=1779967075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjOIjZmNsHI/mHiPsfUA2XrCOYx/OJ3QhhVcNXQP58I=;
        b=HX31AAsVjcP9rG1X9QOdV+Geqni2xmKTlTmz1tNr9HQLHMcJBMg+CGTwSChVp2AXze
         7oO4lroQUMdjn66c/arLUk42L+4YyaK+u+UaX9JxA+DFhXY8Rew7R3/ug4oGwORuyYIS
         bR+7wtMSp3ej+T2WMSnUXVOUKQG+XHCeRrFiHOB0zw8Qr52KFj9wNaT3iseCoZ/oTmi6
         Ld69LodISoC2fe89HD++M0jAse7xYaoIX1Fg0uC++3OqFiEn1yK8ucWRnlN1myGe4LH4
         63T64wKvJcRUQejY6g0bva67zmp+J2uH7xg3HAq0SHEm9s/x0abOaAlXrdv3drNYS70C
         i4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362275; x=1779967075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjOIjZmNsHI/mHiPsfUA2XrCOYx/OJ3QhhVcNXQP58I=;
        b=SSjPJ8IhmLtRJS8oJ68dyPWxn84ZswIzwo8kQEXMGIhFxyH5vwgEJ/6PGlH6+aqgRY
         P2Zvql4WLqTIv3YJZMZFrJDgq2+Mt2lpYyDKDQ+OvxwdMWgQRukfkO0stEVfXRrZXIUi
         LTNoIOjCNB/fsX5sQ1Nfjv4kt0Cpl6EV0gwEuolo864olcqVCSNx7met6dH66S/PNPct
         nqvO5zsdVqC5RZsGsKGLVom5UdcUnt5wI1bUg9XXWxgyVxqg1JJtzn9mpZ4PNOWV7k2g
         /q0+h72vjOjnTvaR2ENul1Ho5dJJVMqdCMAELHXY1qtaMO2Vr8x/AasP1gmoGzS3uOUd
         Y8LA==
X-Forwarded-Encrypted: i=1; AFNElJ9PA/zw9dSKjfUXOpA8URZlFK99VHZ+nMpFiAXqWoneI7AhawWQDmPMzjdsj6l4qaE97ydao2UbwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymsTK123W7hqCrBrRu29abjq8pEInvRrhAH1mk2Q8znmAZKEsQ
	BuUb/lW8wif/cImMkGOgs/dev4UfF+4WYRefTPmrvcNtn/6E656SL+xxf3L4Df9wXSirJ8TU3r2
	rlwlUb5oA/0y0JW56m2zkCsWDCSrjxBpqCCA5Hhx81vreqQMYyN+phf7D57Mpug==
X-Gm-Gg: Acq92OG6tgW5lQkvZRzfvwpmTxI359cy2YcnksFk5L5VoSOZ090L14kj4eAHlnVRa9/
	xn9IjrNHlnUn9OBGQKcSpfWsB0gHPNpKb+KEF/uQ7iVIVTC3miKaXfa8KZ6+JngJ31R8+MTszxP
	qSPP/9Dvsk4HT2Icjf1KmFyh1xQuDYtcpcWEPPnwxgQHUK7wz671oK353pOndrK5jrLlSR/0ULJ
	75E2F/WNGX9FxuNkPKFBIrwqVJaAjuUUskandAdBn79p8+lPtfL+oqQV7prDzfKkwmtJA50+oH8
	2IQrf++UJgouLlWmcn7WTTD3PKKutekweg4XP0LoROo8+Dqqot3RB49z76oByT6nF88d9zrAy00
	uZEcBUxYyiaZnf2mf20xG6hlIT9aTAVeXXtM2J1nKWK6qvXJAQSD6yshXFUpXZvx4VLGxb4wINi
	ix2vM=
X-Received: by 2002:a05:620a:4804:b0:8d7:a89d:958a with SMTP id af79cd13be357-914a2d2377emr193349285a.6.1779362274989;
        Thu, 21 May 2026 04:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:8d7:a89d:958a with SMTP id af79cd13be357-914a2d2377emr193345885a.6.1779362274444;
        Thu, 21 May 2026 04:17:54 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6887e01f7a6sm26576a12.2.2026.05.21.04.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 04:17:52 -0700 (PDT)
Message-ID: <e3b15b7e-ba09-43ca-9e6e-b778393d6acf@oss.qualcomm.com>
Date: Thu, 21 May 2026 13:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8dIU1awGZk_hZzIsGx6-Dz0Fof0YN9jr
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ee9e4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dRO4Il1Evtc0n822G-oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExMiBTYWx0ZWRfX1yyzgJbwa/K4
 cOKMc23X53v7UjJeFudlyTYOl+1xiAJrtKQcx8uEujOz/hf/zea+xMO6TQK3zfAl8wx+kRGOnoE
 6XqO10VcA0iIFlrQ/LCeEK+rEkXCp/bTfnPdOruPqXfWF/KWdIynLQPrROBKjVAuN0LudUd4S1S
 HfqLqZNWmPs4J2fCAOWOC/j5uZzUlTHiuYbE0IHAMQRcn3VzeAIaoaiNWkBJ1sVcF4vzscQ7/Ss
 gy2vBvT+3+EjczzOhDHvMcZxxMnDIfAlkq9xT8kCch0LU8AfrAXoyMEbZhXFRJOScBWPvrAH3bq
 92nBjDd9MkIHR26wd8jEHD3T/ezG2tlx//pHuCHl82GvlNk+n/N75xRBXG9Z+g3JHazXN0zD1Ok
 0ZRZXYuPKb8rKSobedK+/dcEmTKwDwm+M5VGvJzHUdouhTUxGcRx2iH4E1lHHI5aI648UMl6wmB
 CENiwGHD25C+Om3iNkA==
X-Proofpoint-GUID: 8dIU1awGZk_hZzIsGx6-Dz0Fof0YN9jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210112

On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
> based power monitoring and limiting capabilities for various power
> domains including System, SoC, CPU clusters, GPU, and various other
> subsystems.
> 
> The driver integrates with the Linux powercap framework, exposing SPEL
> capabilities through powercap sysfs interfaces.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> ---

[...]

> +/* Constraint configuration */
> +static struct spel_constraint_info constraints[] = {
> +	/* SYS domain constraints */
> +	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
> +	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
> +	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
> +	{ 0x1C, 0x7C, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
> +	/* SOC domain constraints */
> +	{ 0x00, 0x60, BIT(4), SPEL_DOMAIN_SOC, POWER_LIMIT1 },
> +	{ 0x04, 0x64, BIT(5), SPEL_DOMAIN_SOC, POWER_LIMIT2 },
> +	{ 0x08, 0x68, BIT(6), SPEL_DOMAIN_SOC, POWER_LIMIT3 },
> +	{ 0x0C, 0x6C, BIT(7), SPEL_DOMAIN_SOC, POWER_LIMIT4 },

Lowercase hex, please

Can this data be const?

Konrad
