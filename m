Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE046AF0D
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692592; cv=none; b=Pnsohr6KcRMOaxaNb2U0SrqqUcPFt4i0cm+06hVh2HEvdnjwRFGusLFWjxByRuBijhGU9+L3Ob7e0eZwEyTeLq/r04MgGgYFkT3CRPszCti0q0Z5eaHb0gb0jD8+4BhF1+CZmfeHuabpQ3taSigg8KF+cfiL2SoweE+3u0YI+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692592; c=relaxed/simple;
	bh=KnTuYeZRW8y7/0KsX+KsMVHS3o+Iun6XoHfPR8REoOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfVZnWexROwqrKXOmIEP0mXRK/wBwFi0XSwGHjJtWKCP65uaV5cE1BIWWD7cU6R5ffizZPXhrTXgm4goUJeYrb3APd7f0buZQnF5/SI/aerMM4OZeTetbsBvT6chwpNnS5UKm4B4choNbDfAylHzvygF4265dBM6ZqVauogVFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hj6tap4s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GI93GyPY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hj6tap4s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GI93GyPY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8W1WT2192320
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 10:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yZE/UYjH0ajhhmsX7fNo8hWaxZ5NU8yaye5JkX/d8D8=; b=hj6tap4s3U9IembA
	xIXPtrZdvMZX7kJdB5YSJ0FamtjXDYBiuc7wNYMJ3pSh8ylAH/d/G0NTYga78MDZ
	+6ay6cKH2B2/7yXbtmdjNniHP4TWL5AFyEtSL40QySt6PFnBy9zHkmRGc1yaz+00
	vrwA3Z8pebvzFTYcZi5tKD6tdrLCmXlyMdC+Y2481yar3jRrzoyD8J+BKNM0fLCc
	6oHbJ+9KUtYAYnXWT56pQC8NLYppgMs2UvWBd55YGrFKAI7iNrIGRkEhSea4JCpw
	2n7NRV4XK3vmuQwZblO+pKrTjC0EpJtY2t6Y1g2VRSEBOg0+/vZj6ebfnQNslC4p
	QcLSpQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjq66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 10:36:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157b3e5182so26160485a.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781692587; x=1782297387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZE/UYjH0ajhhmsX7fNo8hWaxZ5NU8yaye5JkX/d8D8=;
        b=GI93GyPYk5GDsqOe0+aFhGqyVh98Hklu+oxiWs0ylec7ihPVbMvsfq08Y8WxLauwDo
         7uHXhoC9DRhxx+QuVhiR2F52RTDZtzcbkshYCGci3sxRzvqxHU7oWlWgmq8ocD6l+NoW
         8FSTw97u2cGQnDECESTyaLr/ixMWg8LSboa82gGZA2yixIrgdqIXzpEZuRjKo3/v9IpG
         TwYzRSI89MW7yPXnaf15MiCj1s3iAc1Mc+H1Bovi7El5TyiSsSK4aJJ+Jti18Ph3RCtY
         MMewqlm8MohCGKudtVBeZg1xvviZPwadbFwPjbPqIMNSAHhMEqiuCDHoQ92murEWI0ih
         8sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692587; x=1782297387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZE/UYjH0ajhhmsX7fNo8hWaxZ5NU8yaye5JkX/d8D8=;
        b=i1vy3gm1TAYm08ShU9g1GMGJw1ARmJbN+mJ6nthqRipajTGXi62+20E0VcSToOhyK8
         fY58koXfSIXAlTTs7TPAQUGvkQW3DQqRGg570BGOfpzyieqxM1yoglF2Ku6NRufmGvvz
         JKj3mU/3bYZwysIwEyWzVh3mQpIshGHQOgeK4F5Dax9VKmDkDjvsXVYiFGowSvFX4j2F
         lutDiTU7XyS9BxxB/z81Lm8vDkD6RXtXmwiT9oN14RhmyDnIKhhOG/MF3L1VIKKEm1Pn
         Myr4+HIOkiS0cjBzdwbjJBhYXtbhcxiN4/6ipOaik8I5BYZpjfamfwhD7DdKdG10bBVh
         tasw==
X-Forwarded-Encrypted: i=1; AFNElJ/gbRuED/zU+IOdeBkMjtx4tjyi20kDRyHOpfiufop19Php2NPHQNxWkfeWDGYaPpgfkHhGCbWk7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhqDTweYhvbBeKK0Lg8FYMQFmzDujBpT5lyw9I8sixTy7wOK2
	LUNwhNV6JEs8rXrJ/8xlFsirqWuNNqpe9774t9zIUKM62uKn25zFsh62SGxxBE9bDpiWRLc5U3X
	HC0kTSyl3npXLV2ZX7/MkwyZK0DS3N8qtztUOd2xjlvg8vvxPT2hFLRbHwLPzHg==
X-Gm-Gg: Acq92OHARXekpJMjPTi7VtIFDcRLPoJpqFiVabnm+ne8ZPJwLDFK1xmfVtXfLYgRV3n
	yEl7e5pwCjm6U0P5CZp7YA6uvNKaykCtrxpCulW2fPQG+nUWwiG7zXRxI05fx5cIkEuy4aLIsfX
	+OCCPHICCfZPdTUd5r8jp2cGPvYe6r5bTLvUhZYSa35FnL8vNdmNqjVQNJtn6DbKz+2UVINfNDS
	/WQf9/5hySpcoMIrTLV3khwJis+TakZkiYM6Jcb34S3XToXv+2KLAgV45MmfDl92e0J9pPYc0A9
	7TgFvFzE0YWm7GXX24xikfjt9QivO0ujKSd1siu63+TLNqBi4GJTpBnNdXQw148b5ipuUq+6t0V
	3oL2u1/HDs1c7mBujT77SZD+1Vuf6ZjXtXEo=
X-Received: by 2002:a05:620a:d8b:b0:90f:7ce2:3019 with SMTP id af79cd13be357-91dbd008667mr252972885a.7.1781692587553;
        Wed, 17 Jun 2026 03:36:27 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:90f:7ce2:3019 with SMTP id af79cd13be357-91dbd008667mr252971685a.7.1781692587168;
        Wed, 17 Jun 2026 03:36:27 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5103710sm773989466b.22.2026.06.17.03.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:36:26 -0700 (PDT)
Message-ID: <ff72dd25-926b-4a51-99ad-4535f6025dcc@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:36:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] interconnect: qcom: add MSM8x60 NoC driver
To: Herman van Hazendonk <github.com@herrie.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606-submit-interconnect-msm8660-v3-0-f9da0158cdf8@herrie.org>
 <20260606-submit-interconnect-msm8660-v3-2-f9da0158cdf8@herrie.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260606-submit-interconnect-msm8660-v3-2-f9da0158cdf8@herrie.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5OSBTYWx0ZWRfXzp6BcfidiI5Y
 7tC37AVdCdF6AKLjfh15F1nipNAuFkuQyXSlVdhnOGSKOkASBnVtPtx69WyAFlj94pLZPaKZUvI
 TmrcD//sFUbBKBKAus+feST9dHB1peioZW5l7CYpElFf/CxgXVLAW1QZuY6f5hshX4dpyN2dwE5
 3007nbtz860Q9h2X1BJqg9brPe/mJFyr9sqb+fjv+75IcquISdbM0T7YV1lulaoqToAm/1h3rOV
 6msiuNb/7NLBFxsUAJWlA3efKE5gw5ga8h9XTKkIh81lt7hpQBu+ogsEPeSDndym1HPrTaHqUjO
 g8WEL6F6yCnRLGXTFaf34RljsKiqeBL9L3Sw6VmP1z5VneIrSbKQU2X3whSFBwf46NGUV5uoTGL
 hI35sehTeqaoqf16jLIg7DleQCBF4AWNh+F2FHtMzKyeUUmC4p9odtoVeNbpjZzUoW2A/C42LWI
 8NwoCc2hZnYy44nGzPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5OSBTYWx0ZWRfX6uCvBR0Jhxwl
 JtFtA0Daq4Is40HJ+N8gKSeJ+Q7qeV3ys1HKnWmYpXUTzClAPmx8XcA1RzC4lRYRjrASEZ24vkh
 o5BU6qgMchObcwzcIPOkj2wSSdu0GK4=
X-Proofpoint-ORIG-GUID: x0wO4wNjPYrlVDbE_fhn0LeQAKT6QyYx
X-Proofpoint-GUID: x0wO4wNjPYrlVDbE_fhn0LeQAKT6QyYx
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a3278ac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=eFASmHcy9aB7nxdwtpoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170099

On 6/6/26 2:34 PM, Herman van Hazendonk wrote:
> Add a Qualcomm interconnect driver for the MSM8x60 family modelling the
> four NoC fabrics (APPSS, System, MMSS, Daytona) that connect masters
> and slaves on these Scorpion-class SoCs.  The driver implements the
> interconnect-provider API to manage bandwidth between specific masters
> and slaves via the RPM arbitration tables.

[...]


> +/*
> + * Minimum fabric clock rate to prevent bus starvation.
> + *
> + * When no consumers request bandwidth, the rate calculation yields 0,
> + * causing fabric clocks to drop to minimum. This creates bimodal
> + * performance: fast when other subsystems (like display) happen to
> + * request bandwidth, slow otherwise.
> + *
> + * 384 MHz keeps fabric fast during concurrent MDP display scanout
> + * and USB gadget traffic. legacy vendor kernel docs: "AXI bus frequency needs to be
> + * kept at maximum value while USB data transfers are happening."
> + * 266 MHz was insufficient - USB crashed during display activity.
> + */
> +#define MSM8660_FABRIC_MIN_RATE		384000000UL	/* 384 MHz */

Can you ensure that through a vote in the USB driver?

Konrad
