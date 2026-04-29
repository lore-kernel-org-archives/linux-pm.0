Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779A26F28D
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475363; cv=none; b=ligQXk8EZ2v3u0UKFzW4FP0HGbIW0aMsCYLG/f7eOX0qaSWT7w4pc5gnRPxAshtTDYaKepbsvXIuXQRnggTQf741iWH8el7VwM1cHqgK0ozGtUh05ZFsRCR3mTCVvznnsSpbjrtn9xtJp4JE6Xou8xHztKrp6UVtTDfOQOat7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475363; c=relaxed/simple;
	bh=gtnFX59B1anRZ4vdjMqWGofH8RnHiE4XajnuH5mLi1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiGMd37i1DzNcr/zCASjXcIX1/Jqj22ZEwrVTrZmfkTC7vkPru7km/ooMJpqcApRDpU7Lr4igdG02ulGPEn/icvLMp6izOw5P6ySjL2V8bMcppCnxswVXX3RshxnM8FRX6MOs0fnua8DApEUhRL1fLaavqpqf74jNw7PV65xy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kXOWK4FY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKqGfMuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXOWK4FY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKqGfMuz"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q0Cu963229
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	878qtYQe4fjVo5NqOixdnFpHTcI6ba58NmRzlD/+pms=; b=kXOWK4FYDMIl0i0k
	xYFSCh32mDwTTpWHsrMx+KAVzh9f4fdZGPheBiBrf3Dr3mwtMm2GAJ+PSRmgLdk8
	IZpBbIrjVWQTmpQT3gCQeSxqxGC/5xEam9uQwivEDMSzfnwpzfVeUrCMT8VVPEzD
	EO84TDk/dkVeW7Xlpxldg6af8ggOx8kCpBXgSG5FFsIUdhTw8BueRlB6v7Jpc8eH
	Sh6fussvOQtBugPAKPpU4RTuR2aGyNsv7xVJ5hinERpcxIZ/l8K4zqVY3nwr8P9C
	FK+e6KKkho06mNsfL3WqHuKPZqI9epKb/6zuF5AvkLluy8JvW22OUdhStaTV4Aa1
	FJ51nA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4uyhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:09:21 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-47bd318565dso1980431b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777475360; x=1778080160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=878qtYQe4fjVo5NqOixdnFpHTcI6ba58NmRzlD/+pms=;
        b=RKqGfMuzXzuOE6OQd/X6zfwIBMHDJhYjml/qb4E8lDeJ8OSpV1T4/gPClKVvK+cKFE
         txZyIQvRh0d2xM7n22ww6ku/8l/Nzts+XDB4AYwSn/RWmBm5ekU3RR9Kkr1KNEZTYKAb
         AYAVhVPAY8UlJCt/vBXHZjkKubySgm6r72abvgadZkf29wnGudTD4pb2r2KRX5V+KrMD
         uIRqL4yJpVT11dGboTu0PVUOpoxkoUeRQZ1zkZpRNKBo7N0SqyFOuFAZZxp2j/A+Wjg+
         nLj2jy5aJ+jOTg/XvwSNDnljwGJBX8gtm4bvSOiKAJ7I5jykdqMXpg4t72VEBGP5v1Sv
         GU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475360; x=1778080160;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=878qtYQe4fjVo5NqOixdnFpHTcI6ba58NmRzlD/+pms=;
        b=OomJrLveJ9hvAUZmJ11QDsunikRZoVwuevv2gpCdbKWyFp6YtXkOX+GU/5g6uUxMQh
         ctYtuOoKwEUqCmh6p1xTdmC9DBSbsuH8Ml6zb61DdcHMmrmdh3/E0hWwKQ9upif2DAzz
         mHUnUt8xVCIyGDRcRnUZ8LjpxQAELMH84xQTduQHfa0Eel/OXV8BHGShSszn1mMo6PJE
         AYr9IvXSJyAtPnysg/kIR0mGq5UenNNP+wuMWlGX0lRIijXNNjJ0fy942FDP6mVb8MCT
         u1GhPLK4wSFvJx+0SO2bgBkIWdu+P+snPSOZjxrsHClat0X3Ckwza0TIUidQEcVqG89z
         2mSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Hl5E90XPkvfzIj6BH7l7/K0DhbmNttEfe6wplHP+D/h0NKF+2gWF+Yi9+3LSSl/D3/cuA5hkENQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziF9RNm1ajKv0AeQ7fMR2iCPF8vGijvyg2Ow+VHojj5eNlyqRB
	/sSQzlpy6QF2aytyyHqckpTxXfHuojpxicvCFvo9mMdexG+by2SDcOpT3naYC5JzDOvgi3QOA7s
	wxMe24vuEF6kiaiVAZhxc7rSgRKn1RN3YSWmf1drApNBye54afkQvkIZnOrAZMg==
X-Gm-Gg: AeBDievo6V5DGuyojTGGm3hDP9m+A1qnM78M69dkA7DoX5JW1mAjCJAtZ35BZgmNJTC
	mqL9Dx8Z2TbMTxbrABWFOk0zW12j4U802/SNKPHFWi/Prvs39hhfGIIZlfLqs2c7RM250uX61Ii
	YH7+pkVcWrPXTaYquLW224D8itAo7H6tckXgJscSrnoHCQ//ZGIvg1cVSOGInnKNkFHrH8rU39Y
	3vJ+3IORG2C2RwN/OxBdJiZBXrL5nHJpdaZYtw6CLG1iLsbLFVZgiudw0+i3U28V1gA6DP75XbX
	JZZE+5xIZVByKrx1FQNY+0ii0kuxCgdy4pZmuhdMKK3OU+L+QH/QEfpZDk27Z/LekjbxOKURCuA
	gbtXLilhnBAkqQmZP8Qkl62PlKjbCrL5KKOnNv62Ux0VxR3lp/uiwPbrSR/Q=
X-Received: by 2002:a05:6808:14c5:b0:467:de0e:feb6 with SMTP id 5614622812f47-47c3d96ee0bmr2047597b6e.11.1777475360106;
        Wed, 29 Apr 2026 08:09:20 -0700 (PDT)
X-Received: by 2002:a05:6808:14c5:b0:467:de0e:feb6 with SMTP id 5614622812f47-47c3d96ee0bmr2047563b6e.11.1777475359694;
        Wed, 29 Apr 2026 08:09:19 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216675sm6501075f8f.11.2026.04.29.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:09:18 -0700 (PDT)
Message-ID: <ca6c656c-07a1-466c-9c1f-a2efbf1498d0@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 17:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Make important drivers default
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
 <20260428-interconnect-qcom-clean-arm64-v1-3-e6bc3f7832db@oss.qualcomm.com>
 <bb02291a-1579-4069-b6b1-757a0b5fb7e6@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <bb02291a-1579-4069-b6b1-757a0b5fb7e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1MSBTYWx0ZWRfXwDzKs0JryP1N
 uhtVo+cxGmsKExB/dA8TMzyt59odE8HA6nk2pFBHlYOqueZmcphrQNwOqXaPSrZQhzz2SoqyGyi
 VDWkL5MByZaNs82DycZhytNrAGcptPWHzqW/te4/UTd3sTer1CPO5jh+dQsUWJvQAL7vlyKfP0f
 Cp+mEcfzPlgWdgMxg1QqHJr62867kg19ZDR06d5JpxKjXWmJdk7uTNwkkMwYMHiFCB3pSQmFZO8
 0oaiJtM1d+lB6CzIsrq8WTmUVsUOe1XqeVCnjk925xhtqGLBU6spBrzIE9dqyivlQ+8+Ga1QMH6
 ba3Oqtmeug/8CtOAF1BnNeOiP9P6TNO883VLXrhal6HWUcStR7pn2TZWbNQZAs5QehzLh6Zw8kN
 RC12LShNBsuj0p2Asks7RcLbI6mGnwixeCyfun5uryapDS8yUUMXqULGAiUUU77vn0/Sv1pSL3f
 T5jp28z4ofBeStVLyXg==
X-Proofpoint-GUID: HU1xiOEv-MCFNc70uO-vUUMYdhqp-eCj
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f21f21 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=XT8seR4E2Wfhm39xuMUA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: HU1xiOEv-MCFNc70uO-vUUMYdhqp-eCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290151

On 29/04/2026 11:23, Konrad Dybcio wrote:
> On 4/28/26 7:32 PM, Krzysztof Kozlowski wrote:
>> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
>> basic or fundamental SoC feature: bandwidth management between internal
>> SoC blocks.  SoC can boot without these, but power management or
>> performance will be affected.  These drivers do not represent any sort
>> of buses visible to the board designers/configurators, thus they should
>> be always enabled, regardless how SoC is used in the final board.
>>
>> Kernel configuration should not ask users choice of drivers when that
>> choice is obvious and known to the developers that answer should be
>> 'yes' or 'module'.
> 
> I'd say let's make them all `default ARCH_QCOM` - all of these drivers
> are required to boot (minus the OSM_L3 driver which is "only" highly
> desired, so that your CPU's bus isn't heavily bottlenecked)

So the few of them should not be a module? That's what you want to say?

Best regards,
Krzysztof
