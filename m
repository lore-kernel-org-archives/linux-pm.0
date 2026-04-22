Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E735DA5B
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873714; cv=none; b=Jze21szQO4rLlb0RSyaTkoJz4MvdsJQQ7jvt6y6ZTtmynqqCjjxWApyCQY6E8yTxf+oAfOujD/ZkxM4RdWDjvjVf1DClsoZkw51CTUz3ElF2lSNaFM8WYWEji/dq/m0eqc3E6cqifXXv8k7rxSSgpf/qZ2zHZ46h98TzszTzDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873714; c=relaxed/simple;
	bh=o6jX84yg2Ct8H9sQ7gKIiIsXGPNUyXKJy8PFaF9vsd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBirM0JiXXdevD/u9walbCB2CI4mmAGdJw3xCzvlrBVz5cJuTRaf69SxvPGXRaOvhOE9hp0tKODi+zEEJYuqPVDYEBwkvGKx6szEPxFFMza4oWwrGiOsxy0yKlVeMmJF+JIhriGGo/gRFqKRsYOx3CKVvixiTC6vilnd9sVtNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhZF251E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yq/AQWoJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhZF251E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yq/AQWoJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAOcWD3083047
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 16:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+kcBHMPox19CCVrcCwTnG6bXSCj78ShYnTQf+unKAiE=; b=hhZF251EuVOLvaJo
	ap2nH7ljGJ7/aPEUUqeF3tJwJ9TNMc0zovy6yicrRsOwJftAsSKMP0HsiUkOt2WT
	41VcMgJv3qXHmt9TJKiIdiE7U8i6jbo1CVy0tbq5wIOzgJxzU9evclCJddg5x2x2
	GLTyI+GVfcUhdDPzoRfClJsQBpW3Du6F9U4vgno2HrOWMXKvMZPq7x/PgbUt4oAk
	fqL2K5ijScfJdQF+nw2YuQ88Fb95QsWAgUBBLY/y8nqaZbxPKRIX+TR/B+auuXxr
	QvOjFd99ti3k6SZAYqBsu8KOczKJ9bzpaZIivAPKkKOqifUEqaH/nVTsnr7fVyee
	Kfd+3w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmm9p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 16:01:52 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-46f083f82c7so10623762b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776873712; x=1777478512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kcBHMPox19CCVrcCwTnG6bXSCj78ShYnTQf+unKAiE=;
        b=Yq/AQWoJyN0zVqw3v8DuYcueb5HTvSPbPt3lWVuh61FqqU17OcKEwtxXZr5fOVFdXV
         E6E3tPdkwaks0fPR2gziYBIQnArQ7Fvsq6mQ/IkZlg8M3y2TGSICWSFBQpkHPcDb79WP
         lXKr9bnoKr4Ev9Wuj3RxIlCPJ8l4LOoYMl+3H71toysB1RnBuPtGnqGODmWK7/YlCMGn
         Aw4bRoUkZ4TBpKwOA8A8Iqq9/XhUMC0LBxeZWEW5zb2Z7vZ7uDPfRNCVOOhOFOWLChoF
         gxze0xqLOR0I9a3DQxwPi1Kbb2Lm0Mm5rdh/owSUwXAHmxFcO/XVVD4Y58RDNsKJxfjY
         gKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873712; x=1777478512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kcBHMPox19CCVrcCwTnG6bXSCj78ShYnTQf+unKAiE=;
        b=UtnxuN6AX5dtAshmPnYL6HZGEQcTGja/qyJZ+MilCgTWFOK9+l+S55mKJl1XLHNeJD
         RT6YRWbps63oH3vGf2u7vMqXQCqZLtNmkj/9ThVk9f1Y5iYuySQXRrTaCV8eiWA7pw0l
         p/l06iLPiabYGgQNPSYaiKixZDaXk0vEECAD630voLu3oCwU8PL/geBILNaC5s37zfZB
         3dofggc1XuHl/99jQ14E0MSjaJJy8p6Zt42WTX7z/0NyF2jUtnrlQuB1ZMuUrXcKbNzi
         FjVJeA6HIoSSatFbCgRdrba5K8I95a84YR8UxKbRAtgDYwmCbQMzl1dzPPFb5KKtBTex
         1FcA==
X-Forwarded-Encrypted: i=1; AFNElJ9/Ho6f6c6NNQTWNP3d79iCmSI21yjz/tts8AuBRq/RlSk70CzLA01GAueMqUOs61CWhRfdKzEBSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2b1eC6wJA3P4wtswRMFVoA78KyAHdGrRTGI6XqQZ+6vUp79FE
	/DC1noam1fDckszFVs+v5g1jgCsm0k0hBt3W1zqr2rU5qIcuCbFohSFf5cPIW587k6uHM5kX3XF
	tHYatdFzD7Q7GcD32HYAEwdia5HMRohk5NwfnfWilD5J55nVktTOpZV6s7Uc8Kg==
X-Gm-Gg: AeBDiev5wNHvN4SqhjrHUchH0XnNGGmcGxkIFZg7cFoeT8K+oyt03dJ4oM+o+V1Lsv6
	Ac7s9sOVF7rOaHoyAnxnjfV144bgsKoEYb86lnviWpTc8pUNRCrcX2gT+JbHooRGPf+gHderFRp
	br5JmwCZqxns2ITRPFa2sXlOEPub46C1P1wiV8DkQTB+putJurc2V4D8nMrZEYalzk/gXwxNFkO
	4hoQddkU0mPRdyl8m5qvb9IM7w3WME4Gcu7faaDwtyr4eQ1DoxQXBuVkV3PCeguKfEvYV8a9uRO
	9MQzff54YKp2l+ZBXKxXI48GtstBD/vOoI/j6Yr3yyXGXF7eEdeylz1YDwtk1Hw6+Glxu/3lcll
	m0OSx3oQneggJwYNm5cKFr94PxYGu4AwETYncG+naryki0FaOUgQEUSm5ta2LQCisEgnqNgQ6DL
	FdHkOeVBlban3NFlinv18=
X-Received: by 2002:a05:6808:e68b:b0:479:e826:ccdd with SMTP id 5614622812f47-479e826d1c3mr3812354b6e.5.1776873711961;
        Wed, 22 Apr 2026 09:01:51 -0700 (PDT)
X-Received: by 2002:a05:6808:e68b:b0:479:e826:ccdd with SMTP id 5614622812f47-479e826d1c3mr3812253b6e.5.1776873710861;
        Wed, 22 Apr 2026 09:01:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm143199855e9.3.2026.04.22.09.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:01:49 -0700 (PDT)
Message-ID: <41514250-3da6-41c2-8a33-41a50c0b3602@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 18:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/14] dt-bindings: thermal: cooling-devices: Update
 support for 3 cells cooling device
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: rafael@kernel.org, gaurav.kohli@oss.qualcomm.com,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
 <20260419182203.4083985-15-daniel.lezcano@oss.qualcomm.com>
 <20260422-calm-badger-of-courtesy-809761@quoll>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260422-calm-badger-of-courtesy-809761@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RikghgnCwtuCX1kMNXVdDrZ8cfEE9G3D
X-Proofpoint-ORIG-GUID: RikghgnCwtuCX1kMNXVdDrZ8cfEE9G3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1NSBTYWx0ZWRfX641YFH5DPgye
 pQRkCFpJRmvOzgvoZNluSg4h8TUnTI0rYQSyoE+zXDKFj2+0gXn7+kJfayOkSfuh6bVSbrRXf1F
 WTZ0KL73hQRy0oOo3NiKLgtRT5NhEORTTfvVR88hCG1TVH3LEp2QTmZA2z1tqzz2JsCCA45SxeI
 zVLjsp7c2xjJIR/xf6520Hb8M5eANUXj/VGzpGoRSNoYeoOHJP3t4JtCAbjpQ18MXHZnoNLzK77
 j2tZ8XnuIxIkQxYu3I0JUMkzv95tSjnMxuPjAhd38IStqf2T6iwnTIwTr2gn3MKgwwy+46UaKYj
 JWZw+CawQhXlc28rRIBXqHuHTUirFXBQL67hPVeFIZunhyDzJ4TCtHrOb4gubRmlaaRrL2srsOC
 yQOw9KlDFKwam7nrKCkCvkXGs8zV9kYnpwiUU+pbJhHr0s/FeTbnaBrEuHODRxtTA6uhONeVl8V
 rDt77+WTZFx2KWKc5xg==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8f0f0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=sgfxO1epDbPhlZI4IqgA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220155

On 4/22/26 09:31, Krzysztof Kozlowski wrote:
> On Sun, Apr 19, 2026 at 08:21:58PM +0200, Daniel Lezcano wrote:
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
>> index b9022f1613d8..28f5818f1e60 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
>> @@ -44,10 +44,14 @@ select: true
>>   properties:
>>     "#cooling-cells":
>>       description:
>> -      Must be 2, in order to specify minimum and maximum cooling state used in
>> +      Must be 2 or 3. If 2, specifies minimum and maximum cooling state used in
>>         the cooling-maps reference. The first cell is the minimum cooling state
>>         and the second cell is the maximum cooling state requested.
>> -    const: 2
>> +      If 3, the first cell specifies the thermal mitigation device specifier
>> +      index for devices that support multiple thermal mitigation mechanisms.
>> +      The two other cells are respectively the minimum cooling state and the
>> +      maximum cooling state.
>> +    enum: [2, 3]
> 
> In the same commit you need to narrow
> Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> so it will keep value of '2' (const: 2, like all other bindings).

Ah yes, thanks !
