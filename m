Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61893246788
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070067; cv=none; b=q6FClr/nYOkPdWGeAsf3PLmGsvJVP5fCEbtd2vzMIH96U5m2zL66a4jc/l/A1E1vkpghgBDpNHh5jYAnSGbxI2a9i9rgJPIaen/vfVrDjtd1NkClZCSss/1S8zIlMct6j6r1avPCXfcQw27CHHOLP+/Mhr/jDgYDJRtLU6C+Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070067; c=relaxed/simple;
	bh=F3sahIc5F9H37XPLmF3ypq3puhEsMkLGGOfvBF+VKNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMwLDvT3F/yZq7TXavbh7LabEkXRIggHbDJ9EmaRuptpZJ0glm1q0SFLzkXsXqUoGhifEE3EtgH2gV3yjbZNBjVv6jTbN2/V8yvCODZykDU59ZaERAc/wUJo4KXyElUKKWSj3xQxP3ERJG+UM4p/nc/U47KXKkYK9kznU8kDtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AoVUPr/K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRubIIj2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AoVUPr/K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRubIIj2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770GmTw3477121
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 02:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=; b=AoVUPr/KMBCJWVge
	qjJSDEs1VQYikwckSmo7dfD9rW9exsurvTREmlIY/goqwA3EpvD6QjXkEEbNFLf+
	IVCkf62Zcl6gCQGgLwbivuGOQ6g+tUElaqeAt9H3ihgavJ8m1eu5eguyJTOyGBPC
	RIE7H2c8mDtuceV+a/Bqv26NgznSEsxSmsC5ngZwBZ92keCGplQfZwvXsL6k1ZBd
	gQ7KnvSjvFetFxuB7ulCTyFVfvFX8x/wyTgzT0J8zer/hWV3+VRxSmQM9RuuU1M9
	mSBWDF6Rjq9NsadiuAtO61EjskxftmFLDPBict7DeqZJb3OGRuwd2RTvPAXw2lkx
	hQILAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h9vd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:34:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf321d786so31721051cf.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786070065; x=1786674865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=;
        b=FRubIIj2YCRh24dc8EZtVpZzO+ga2QY6daaHrOKy2HHHqJTVjA63QC18M3QPy0GVUj
         ZGq1CKc6o9Zc+Lzrdf3rmYVN7ojlgZTD71M6Mpj/LkkIldtEBHaYJWhyc5yIfMPpFZR+
         GRpnaxD7ZcrrGz3CKdGipSzgQV4mcWJv4HchLPfJUB5xGoqDnr1cCvYJi/i4e8AsK6ML
         bLnLTKw+SGboGl2tb4lZIeJLWA6Zv+eilpY47lBudGwadlUtIzUDoEhUtU0dAb/H2MX+
         I2r7vWRYIH9H5SU4bssEadrF1c+mqD9yRQFQ2Tnw1PBaXA92O0uQE0MreyhCBOvBapyb
         PHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070065; x=1786674865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=;
        b=ZyLgRJZ5GzZRCJgajLxAZaPURCrf7T5H09dZzmNFq1uJJctyHsm3tScU5+wsXaJF8f
         dhN4ewnNc06a0nAHWs5915TpmphcqJdD+MC2DMauFs+Pg6FDant9IdRTLBDWCG7vGr6X
         NQ0OLtPFLsO8FEyFfAjND8iwT9NiW+vU+RHqil0nAXC3FWpO/D1LJDnXa7glu82ID0Ci
         KiYnZ50YfT+zgDF04pFVUQrJeLbamlPrmxNaaAAPLnln+dhFR5L0GQCYOt5fG6qJuIlq
         fjPbXFxZUBVhf2kNMwq5u1jYhkApTdQJ82W8mSWtkRbhZZhRpvLB32aWkIXE0Tlr3IjG
         1Rkg==
X-Forwarded-Encrypted: i=1; AHgh+RrgnOC42ZJm/5O44niEi+nRjmJ4BENRmhEY+yX+uL28E8LO+7V3/p/VicTmWhIMQGWc7APu/8oWmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLFHE7fHBYaEVMf/4ovg9SqpwaIohgE954fGlJ35yAcK/r0RJ
	YqpTh5alqMuQiaKkJyhv9CMok9DKY9tCfPb6pZYesSIVNpzEs2358OCkBsW2I156d4vIlHDyX+D
	0TejyOY/f8HrtMMvcvG2FuTp9wqdIq8X0F3Q58+5IYa2heX2f9tn5cjkJYjvOUw==
X-Gm-Gg: AR+sD12ngCP5oA7Znm3kANAvItJcSnw7fyYDwPlwC9QoJditbRYlWZr3ftVwkrGVOX6
	xvsX7OYFKIenmVyFoo2ie9s4/Cfvd2LfftZmwyTpFkN9Zd8wZLWD9fzd37+80ymdbHbuL1XAxnK
	OdfPzwujXAUKv5nyBV7hIqsM0CSGjvDJvfZj+RGecnrpWkqaWa0Sz8aQYm8cexeyf711uth8bHv
	TOMYnE1VpEHbGk5c/TT3x3/gr6Z2FC5TPDLhskmiEuDRk9f+f7G6rabsU6v+wuqcI73gtqxl02U
	nagJ1NaCWRcj7d8nViS0lo7KIY6QVnw6sAw4KwYffN0MKaQkBsjNDeS/28Ps8cxBl1njaGpb8hg
	RRa6Eck55fv0Wjtq2ZpZMJxnn/YGrtI3QpfRDAM95VdPs4g==
X-Received: by 2002:ac8:5c8b:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52d18e1a675mr1913661cf.3.1786070064617;
        Thu, 06 Aug 2026 19:34:24 -0700 (PDT)
X-Received: by 2002:ac8:5c8b:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52d18e1a675mr1913241cf.3.1786070064134;
        Thu, 06 Aug 2026 19:34:24 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a4dcsm113421675e9.11.2026.08.06.19.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 19:34:21 -0700 (PDT)
Message-ID: <64e146aa-4907-495d-b394-7cecb1727816@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 04:34:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mfd@lists.linux.dev
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
 <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mbl6NFDlpLu6eMw1_f4leSZzVxr7gYFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAxNSBTYWx0ZWRfX9b1eaZG0M/qG
 gsiiu0yZ/6UstPa7i8gLyTN4EGKUYDdGj0dsj3iai2nRN7UHyFug6u6BCDY7pF2/weQSG6fv6GB
 ZQeNMV3/Mtp/BqCTmBNrAJiA0f7nmOqIVYG4aV7DLJr9QLLEu8gWIlhvcv65dczVk34hw0G1kP9
 q7Oa643WFJrskvqqm0QL2yP8oKziBAjcQIteXbOys2kPvWBeCyEHASZtrfj+0HINgdZBO/n+diW
 KMkPoUwUDHgUxXPEJu0iDiZmfYIxZD6utCrbq2f7JyaiujC3exK4Pj2gB3ok77CtGRscH7LnZ9F
 sA1xvi1nttTqEZmlh14AWsFtVPcWi4kLpYiK3p5uQb9rPbZR3ugOGtT0196NjNRMDAPef21Mdhf
 p53l+CFuOgxKgnLji5B24LckA0Qn1qkdGboMjZGW7QDcr7RyEPeThx3Z2Abxx8JHxpYwNyfQYf/
 mONI5Q/qyEAg7N+7ydw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAxNSBTYWx0ZWRfXzont7wrlPUoT
 zK1vjP5CbNNjzP+BLBh9oo+EYUiA3ceiiUdpa8u5sU7NqhBFxgMeQaVvlIxDEsZutp85Q/07B7/
 njxtLIEaJ12mdVpaiEp9QxZfy7bL+hM=
X-Proofpoint-ORIG-GUID: Mbl6NFDlpLu6eMw1_f4leSZzVxr7gYFA
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a754431 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=YaFGZCiNkOP6CsGDcAoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070015

On 8/5/26 10:06, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Replace the hardcoded MAX_LEVEL constant and fan register
> with values read from platform_data (fan_reg, levels[] and nlevels),
> as new MCUs need different values.
> 
> The cooling device's state is stored as an index into levels[],
> and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
> rather than writing the raw state value as before.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---

  * Through which tree this patch should go ? (assuming there is a 
dependency on other patches)

  * How this will behave with 100 levels with the step wise governor ? 
For a 100ms passive delay and 100 states, it will take 10s before 
reaching the full speed
