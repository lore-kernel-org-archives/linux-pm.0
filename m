Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B23B19B4
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812290; cv=none; b=T+9xjZXYwUyVkkkfkUCpGYiJH1JAifu5hb2wpiDIrMdmByQSO7kmC+q2mcTZTiSxadkb+NYWcnjQuZaGgbWRtag0z0vEg1aifqejSm4fS++3X9oZnwiI2kZLwupzrkttaKFaO4y95l9CNzQ4Ti/7GK0H88wyyICyy6QwX/jMV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812290; c=relaxed/simple;
	bh=7IZ0w0YQU64nz+Dkfx+hX0g0EGwDct9uNAfDXFj2UqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uDf4T8wFTIjiThZ3jPlj5OK4LCigfkg3OcXLhFUt5csHazZYrmDxQ9IHh0yU5LjgIB5/tDEmU9Uje5b81BiUam3QhS3+7/lWobgEGsDE4H/zR89Sk379Rwdy+yi5V8NoIIx9n0llG27nVBrl6G/4Pof3X6m8idies/H6B9IM2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZ1MATlY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXgcQ+ti; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZ1MATlY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXgcQ+ti"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QG0pZN3322511
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 16:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7z9rVd8N941MDY1O0PNVjwau0om2vSKSU/WoDo9hc1g=; b=AZ1MATlYKHJHDwpb
	OKngKzH2C91eolrPBJWCh3CJBGVWik7SCe43DR6f4cD3xjYzx3V/JXbL3bZwd4bi
	YxoTR0lWfIxgNxVd+kuXBk0aufwOU6qFrX5RFf9/uIZUgcVET8XGSwLtzlDasFMT
	8N89sk+LzvMOIJWmF2vD/hyBCRz9sFXvZUUnC/rb2zq499Q0r+NLi3zPkRZGsg0f
	A6O98RusylV2oi2d3nuNL3N9XK/X4TzdpVWy11YxEY0xoHBokLsOROVUYnFR9qs6
	K95AyRXi18kEkTcPeGP7P1fo04LW+kMB7dZiEPwFXOXHP3BLNYi6KKw5MjtZZg94
	ku2X2w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edentg4eb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 16:18:01 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-63302aca17aso4571893137.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779812281; x=1780417081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7z9rVd8N941MDY1O0PNVjwau0om2vSKSU/WoDo9hc1g=;
        b=LXgcQ+tir8DvmHZKXcgLF0EWaLhBbyn2heQz7foghkVspHr12r6DJJ0x/stlqLsKF6
         MX6vhQey4KsB1xaMSQ+HW/TC7vOtT1c1Q9FhqEiCO/iy/rkK+2uo9iJ4TlbmJ0XKr3XW
         ad1kuALFWeuYG7tgZapuE8TZTbkbuydD8krwrF49vL0H6+fJcUBk6mVCDfY91gR7dn06
         HECMq0KSJPwc9Z10zrtPskiTjC4dW8BJvPlt4h9MwfsiLwP3AtJGaNoTJ/ZIkJ4/HH6Y
         jf+sw+GNYp6SJfeckYgnJIi/dd6764HPGjnpIvFCewmQNSwTVpmWQSj15fFBlQrjJ4V2
         HSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812281; x=1780417081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z9rVd8N941MDY1O0PNVjwau0om2vSKSU/WoDo9hc1g=;
        b=TxIkvvMTCdQH5H23l40Vip/YLoMo1zX4v9rq2r4hEPJWEQB47/dvtIlcZBv6RSLmAq
         b9X3plzof3dMLk/z9lyU3qqY4TdY/4T5yRS3hMyEaKmQj6W5QzfbP76CqdD6+gFz52Qp
         upf7FeVq9lkOZMu1nC1mddS6YPvWxcnsn0Lho27MfAmrMBjD6tWAm6C5EY6TFEE494dL
         O8I795NjDmhDIfNzBKgj+TWZf+rphAI6KxwiP+hutivwoPhAvrPT0PK2vMflhbnh0I2N
         qSWu4X43tg8njx+1r2bH+McIRlXYXYJa2nejsDA6vUx8XHRGKE3JuzAz4GLA5E99u8UU
         waPA==
X-Forwarded-Encrypted: i=1; AFNElJ8ehX+NSnj4lnHA9/BpZmy431G3p8njCktWljxLE+k1j5FOBGD0gKcquLVoHMZvaxKWy0ruPZm+Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnyk59CDla1iBk4F1iA8oFMqeZ32ASo1G2p7y7dNH72Yv8jdT
	2j9UBH1pjLnJu5jgRaOoEsZGmmVhmxuaeri0Nvac6fa3xCKNo1tPnm+app1DkRZnZrz7V7HY740
	v6uk6CCBnLsQirC7pzz6ypZ3lulgIlICr5u7F5nVflr7SNamoEU6OYaXd9OiwLqxZdtkCpg==
X-Gm-Gg: Acq92OE+U9RncbMmGJncMNnV6KQqTuy3+DxDge/902c0GyhnWJLPreW8L9riWe08IWa
	6XXiqGf55XW8rgb5tLBF+dLC+yyDUU56/8k+oDRHho6HDp3hjnYy6wkzbBEQcry2kEJmckcEf9J
	8FVz0ohnUisYLDGMLb2vnUxZtFKnMZOqGaUZ1ueWfJC3zGVa1s+eRWXOvl7nKb/hrwgdzQVDAr2
	HdZ+Vff6qDLRdvCQ1hmvtcTTp5aR9bIPfybnZn0VtIg6kZfNnFonkd01rQNyFvUMHSLq5Iz0dJs
	5/N8Aboj9qexVoXd1ctELfX+236SR+VA46Z0AwxL3dgwXeoeeTkp9wzdsp5Zu6MqLa4amZXojWs
	j3Ch2Ns1W+qqsUVrCibBTlwXzc0K1DXMHfMHt2ife1xEc5rnpVgi/tBpgacrj/N3sczZlOvE74U
	DaAm4m5lMxRHP8Zzrk
X-Received: by 2002:a05:6102:50a4:b0:631:44b7:b875 with SMTP id ada2fe7eead31-67c8ef47d6cmr8684795137.26.1779812281155;
        Tue, 26 May 2026 09:18:01 -0700 (PDT)
X-Received: by 2002:a05:6102:50a4:b0:631:44b7:b875 with SMTP id ada2fe7eead31-67c8ef47d6cmr8684764137.26.1779812280642;
        Tue, 26 May 2026 09:18:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1? ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm331332605e9.3.2026.05.26.09.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 09:17:59 -0700 (PDT)
Message-ID: <b20c560f-4bc3-4686-9c91-36d93f1535b2@oss.qualcomm.com>
Date: Tue, 26 May 2026 18:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: samsung: Enable TMU by default
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526135312.8697-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260526135312.8697-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ja+Ma0KV c=1 sm=1 tr=0 ts=6a15c7b9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=n2YIJuLLpjprAwdwynUA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: CAF6Vq6UrpUbShWMnNWk8Agxrr2CFJ75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0MSBTYWx0ZWRfXz17RaqONBhhl
 ezvTFPnC6Ni9AqbkMqbO+anbAQsX5QJyaV6gddeCxAMsqwfrct1p88w8sdxRjWoF+UQHFgOJ4jt
 +2n6QPtKMsiTIrVp5zdeejr0iDkRj+gEn4fRETaOCa767jq/MJP3cY+VwDarFJetVo0cW7J0PFx
 oId3+WWysagXEKizVqtBCvoHMH588wH0AxyMd8gLwA04iyJV3gGQVaTIr3TP+phI702yqRZfLpA
 X+EZ+K89RctgRk03wIxcKmdyh364sH57MXQRgw4wNtQTMRGYfxMIwLjFIO1I+4SjT9T/WwwS63Y
 d7HctxAmtgXEvYXE3VjpWF+kX8q0XoKcqdTycFqv7xnPv33ECVRfwA16rt/TRdxwG0WbD9Ypv+R
 Y2JHRcn341ohqKrmQBk4NMUoBBt0cFDrU2uzL2evujrgRaOHeJFQ9CYQgpqSkNSuIxdVT7qgwZ+
 aUqeA5J530cDgG52GmQ==
X-Proofpoint-GUID: CAF6Vq6UrpUbShWMnNWk8Agxrr2CFJ75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260141

On 5/26/26 15:53, Krzysztof Kozlowski wrote:
> The SoC Thermal Management Unit (TMU) is essential for proper operation
> of the SoCs.  Kernel should not ask users choice of drivers when that
> choice is obvious and known to the developers that answer should be
> 'yes' or 'module'.
> 
> Impact of making it default:
> 
> 1. arm64 defconfig: No changes, already present in defconfig.
> 
> 2. arm32: No changes, the driver is already selected by MACH_EXYNOS.
> 
> 3. COMPILE_TEST builds: enable by default for arm32 or arm64 builds,
>     whenever ARCH_EXYNOS is selected.  This has impact on build time and
>     feels logical, because if one selects ARCH_EXYNOS then probably by
>     default wants to build test it entirely.  Kernels with COMPILE_TEST
>     are not supposed to be used for booting.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Applied, thanks
