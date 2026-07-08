Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5A37DE8C
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518127; cv=none; b=P1v1lAuMb48dzWrP+eHp8Ecv2MT0HhFA3S1ISdnud1FyjsP0BdmjPrkSeF4TkgT2HOgb7TimmQXCM2IHtt6uHSQp8AXVL8UeF0wW3fvI8aJB5d2w9dPEjy15OuB4vMroR8kSZSWXc5kh3o5BXpf8ARiwsoUxmlmbKMFez66TojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518127; c=relaxed/simple;
	bh=Fn3Kq18k1/hMDDN7yL5CXZ/ziFrXLMx6EbDgh56AroI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcZ0SBhMpKPGrSi/kL6ngsP5Ej3AKl65fTu+0lvTKxy/V37tK2VtxZeJHy2PPrOqfHxqgK49ljOo2dZw3VVnerBaZIZVcPLLjynTjmg6dqMg3d2RhseFg3GEYbreIK9EeujawSUPUh8mbK0XmB285oEwTKZz3/BpFVmrPjTYIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mqEpa8np; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQLX2s2G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqEpa8np";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQLX2s2G"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3MiA2666569
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 13:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=; b=mqEpa8npHQGKRky4
	U80gPlXm4mghET5zArMq+7DG1VPZLTGiUEl4bjrkCDaiZHZq5crl0ewMo8yj+N33
	LBVfjba4sEO35K8TYrTMIGRmpyYBBKQRt6bWZXXfJMZaEkAPnAmH0ozlthXT9zNe
	DVp8Oi1r8+gwgf6APV5WonRJCBhZ6B9eq5l5MFIbyOtQ3ZTrmqFPjUz/6DvcgfCT
	UL02NTdgZMRKFVn6YwmoAPkPgSi6G1lppx43zdJO/9sxC2SVMHsFSRTVjAVeNa/l
	klcxCn2GGIdZsHcNj/xxvlIvtgRz0/b7siQyu6u2k1jEy7sm5zVWOuJzXRpXQos2
	USBa8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgudgk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 13:42:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so7396941cf.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783518124; x=1784122924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=;
        b=iQLX2s2GVZeAMsmNKvbfq0yJ6XyfyRoqWADQ4vUz4LoIrR9L1UyJab0568x16s2Rs+
         ljG4T1lMhJoQqWfizWXijmUeBqlXlZO3jGZHhPBnI3zv4tnuypkYnzFurcecOVJs2trO
         kjBHA/BL2qzl//w3ttJ74Xc4ooHOcA6RWYdfJh+6RI/F1fq6gkKwqC8PpUxfPxraaDHw
         GiV4kHye3z5oo1msX77H/UB1yPdfyk1vgKQrBQgqfr5v1Y59r27JEy/iGuimGzKwGX8D
         N1mcXNuP0NfVHFLt+SeyGUegksYa3MVOVRb6RdVBg1MyZlu4e2hhru4H6JnGMAy/qCwV
         /3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518124; x=1784122924;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=;
        b=TgMaxdaN4qlc6lxhcT7rvMJLBCiMYgKiqAtsBesr9ldzKtcLbLVEOr55Pent7LnVM2
         0lkm/sn6RLyaxKS21yJ3ci4X7EkQ4XHkQ7GSy/rsD836NJsZDj2dP7C+bSXrBlHq3ftH
         V4Y89bfcdSTGJs7jd5FZo0qbiSUlY2DZbr4+V5CRWN0C6GdjUjjCmgNGIjcRIptUX5LF
         20CEetmPvTjnIxaWyc7GyDvvEu7dAhyMjKfoWsmIYXeRfJRTyJKiG4eKz/YzKZdoG+ct
         Mw/fqZUFp1gDO5hNOKrwppgj4IjxbmQUB6Utw89Xst4ZPpjH24E5qgaDpvdyu5DOkvCY
         xDbw==
X-Forwarded-Encrypted: i=1; AHgh+Roed2yXRwdaPZzWstfg244IZ/zrJeH9vFwI0x+3YTQq2M/3b6DD/5qflLvVbK+C5v4O1xQm28DmDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZS5J0lDOHQMrgodQzb3LdG6YTvqdjK+BkrubTHW+esb4zk2B
	aZGR6QKKf5+JsK8PyBuhM2JtkfCVwzGwfTBWOJnmSqwE9wJe9+UW1BE7n3HbNOVGGdHnQa+bjCi
	Rsd8E4xN1EmHWhgVBjfNdLscspW43DRheLCX52YWP7x71nx1fbQemFiULhaaQhQ==
X-Gm-Gg: AfdE7clt5G9F+HtbvBhIKq+0EMhPnxrv/mHV9kH5UFGdeU7T/nlPaFbB6OTMjYFgm8n
	XlGH+NAOTeUfY3l3Vx3lry98MCJrCOVOltv1sZ12fdFa+HBGv6Dz4LPvHiafs6OvUUbcXKU++LP
	23T0fDv+qpG3X+5ywv7xX0JXnkO3PhgfEjpBa7LVXv5G2cbu35WAiVUu2ZPL4lnGgoSUEm/G39d
	DaYKjxGQoBOlqdZZGzUAhEr958xY1aQPl6Rrd4s1A16iXhmDWcVGVI9GLlPQ70mryMo/ZZ3K2IU
	pTvn14tvXL+h8t1pryoy9tsUgfATPsZtZ93cSuZHtZz3zeGdS56SYqxvSekLgZMdJeSudbc6wGS
	xESBL5ipVTALbi4RDZaBG7kQRAlRnaOHCP304LizDENXlJs8R5iWH/knbIuqpvooW8W3aMR1vLA
	==
X-Received: by 2002:ac8:6f10:0:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-51c8b41eb83mr26572281cf.60.1783518123811;
        Wed, 08 Jul 2026 06:42:03 -0700 (PDT)
X-Received: by 2002:ac8:6f10:0:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-51c8b41eb83mr26571551cf.60.1783518123041;
        Wed, 08 Jul 2026 06:42:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2110:e352:d7b8:8bf2? ([2a05:6e02:1041:c10:2110:e352:d7b8:8bf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a58853sm48871385e9.1.2026.07.08.06.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:42:02 -0700 (PDT)
Message-ID: <713c728a-f68f-41fa-a64b-09ccecef9157@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Add VIM4 MCU/FAN support
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
        Conor Dooley <conor.dooley@microchip.com>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YVevCLiGexrSsJ4y3SfME5Jf6bVEORW1
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4e53ad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=J7wINilrcEgEcG5NXz0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: YVevCLiGexrSsJ4y3SfME5Jf6bVEORW1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzNCBTYWx0ZWRfX4sk0g+fUx5Fr
 jwQuAWaWbHiDJT4xUUgvVWEA5Kol4bSrWtlCw3KsUeugxwSJEb29iOgyvR0QmCEPzFKxl72FEg4
 Go8KK7NBrGQJTVfw1uwNbKa3AXT2D3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzNCBTYWx0ZWRfX+fCZtzb5FvCL
 cOx5jxevYo95N4ww4BNuBgP6B596mmGf12usoLGPTWSm+Te3nX8EHk6pmXRcLFUhq9BpeVPywAr
 G3VcD9zSlkeHWiAbnjIkOTiu62BGu9WtgU2LNbpyXDqax+QSSmhGKQmvDePa1IrLfzYLcCtyod1
 pqdhhmRyerpGZaq7Su/jNvcpC5FLjBqkqd2UsSpTN9m8ZpmoNfgUfUJ5TZXx/MVAlyT1vIwhM9k
 Oq9s6P1CYU4LXkSn87fPMhLfh0rvhsLvgpD0k5mDBQZSzk7bxPOFL3rPVtFzOW5/p6PrccOsYOe
 HhFgHsTTiJcJxiWUyPhWdKlMb5jnV0LrrWG7/XOtb8alELRKowbH/Uy6o45MlB0rtCcOH1vR9xH
 5LqU5dWik1Ugvv0W7EaNsiZW84wsBBWjLMaJnFbIXkAOUdrFhy3UT8mcYOiu74eN4XtbjSG6y82
 saDl0WeeUqMeo0D8rvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080134

On 7/2/26 11:55, Ronald Claveau via B4 Relay wrote:
> The Khadas VIM4 board features a different MCU variant compared to
> previous VIM boards.
> While it shares the same I2C-based communication model,
> it differs in some ways:
> 
>    - A distinct register map with its own volatile/writeable register set
>    - A fan control with 0–100 levels instead of the 0–3 levels previously

That means for a eg. 100 ms polling, the first one takes 10s to reach 
the max speed, while the second takes 300ms, right ?

>    - A fan power supply gated through a regulator
> 
> This series adds support for this new variant by:
> 
>    1. Refactoring the khadas-mcu MFD driver to use per-variant data
>       structures (regmap config, cells, fan platform data),
>       and adding the khadas,vim4-mcu compatible string.
> 
>    2. Extending the fan thermal driver to retrieve the fan register
>       and maximum level from platform_data,
>       and to optionally manage a power regulator for the fan supply.

Through which tree do you expect patch 5/8 to go ?



