Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106278;
	b=UKBmDKEqjvBB4S00NyS3pO1dIrWdkDyX5J9oDyfh7mVLTuFVS98Z9ZSMjaSKY2gCWlTI
	 mzgut9UAmcLXdvF88tH7lO/eBIo20+VJQ+NnK280IzWcmOH7ZAsiRXmL7a3ZNaW/xQHz7
	 st9zX7ApHtQwdYjX6QBiNU/5TStf/mF+2piS/aP5VpYs4SsK9ej8L5SwwglyrrEQWJyIc
	 pW0enJ/bRAn7mEfUOCx+BaCrJWlrbA3WaUsJnAM9kYErjOPa08bTc+J6U+w2Hy8nbUI/E
	 I+5C1SujqhKyILIzBMNuU7zydC/Sg2jNGffPKuG2yg3uOJ/xnTp7Wr0bI8ssOw+lzzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106278;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=20sAaBtek/W6uwYCnGF7PYPD9AnfU5r554thWYjEZOI=;
	b=YS2gSEuBNjdSDHE9uXOs9ndCnKEUsNaEkdbxbmZv9i5TapRJnd0hExxNgNBmTf3/9dH7
	 pLJbnaDbfOwRRWErqtkFpWLlPFQBYoStrvenODtj3kcV3WLKBs9Ng3lUrh+S17ScsiQWH
	 LckZoMVJROkRomcUqAvyX1clNsdEG6nEly57xRiLwRm4cFJI4bBiy0AFubuYV/vlsYviU
	 8JVXuQ03NXr17+SGJJrrttCGpAz/eIL/utFi5JKIt9rLcknWg089YIBi/BDV1GABiefev
	 SIQiDGJXcRw0HZuzg2Yw99yglDz+O97mAUUiLD40gn51CzB5eC+JD1LRyt844qsZ2Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzoEnh2f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BD8liUP1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873B606A32E
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7873B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzoEnh2f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BD8liUP1
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeBht1061450
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	20sAaBtek/W6uwYCnGF7PYPD9AnfU5r554thWYjEZOI=; b=CzoEnh2fY3FWxv+S
	mTyVyGZt1JOg+PzIKup5Pv1txj9hnaELLI7UhW9atQHV1vRzQpmfQLCNyDl7dYRP
	2v6JkzqfmnHdJeCvEx0z3H/FdXaEoMfMiNotmlzWH9X+qWYvb9WMgBVrW4J8QjZL
	4cMteuqeRrUT1wPg79EoKsmR1JgrDdG/Ug22wxT1Z9Ms7RbZ5LvSHaN73atvd8q0
	MHQJzNkFICLfmxuIvfkGmjNCHjdPDQGxERMeqAcexn60WWlqZwj41RQzLW6U2LR7
	ok5WyZsHvE5huQFUHISRqYwmnPF/kPH4y/kENR8N9A50S9oICFsvIxPg93V7xHUt
	2unGSA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2t9mn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:04:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eae4d7ebd2so240949e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793106270; x=1793711070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20sAaBtek/W6uwYCnGF7PYPD9AnfU5r554thWYjEZOI=;
        b=BD8liUP1HYEvR60U6DRxz3FSP6rt4asjLuyFsoZfJI+dSHGYuA+jP3dkZTZr7E0AXs
         CFVA6dkq+F4yQkCLfzI6Qc+ykNgSDfhLDnvO6utVg/w64pDbZKIbeV55VIdf7fPFhgjF
         O5+MzmmjRVYmTDMPASXkGjoWZNWFerSPHroB2RFKZzfwJrractCnjsV8hAgUdgnpdeJw
         63KxNslt2FEyLgXb5WYb8aYoPkSqvEEUhIVGjQNyCJghO/5OEK16pVsho6B0MObZgvxq
         JsEzqUZiqITCFeRMQftUtyBb3h+NoqaM9R24Ne8yZab0Vuq9SwEAEmNGJXcr80ZhMdEL
         k4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106270; x=1793711070;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=20sAaBtek/W6uwYCnGF7PYPD9AnfU5r554thWYjEZOI=;
        b=ZYaCzh+fOm2pv54SzML4/JUh4srErPOWk3beQTFtu19hDqKz85lAdLL2oRnUUz7J/Q
         WuOxjJptbG61fYQG/GFKwzGZniafx70lwn5hR786XrllRuvDMT/wvRT9u2Buu8cMcmfX
         X2FgniyTko5kpdU47Q+Jf1Ni76a6qO9BfEG/bPM4WuJllx44IE97TaZ69ytbPG2v0dOI
         4sp4AEmj3iRBaX/4X2JJo5fRM97WMnwM9BBRJYKCDLdcql+GbCC3dt6MA+v2mJ5bNo86
         lKPkiCMAnnr7VYLuiDEXIGU/cDIdUpg+h2GE1CmzlXNVT0ii8VF7YWaYA1K7s8NdUmA4
         Z11Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpg9eIORYBeKKHFv+ZH9vMoCybN+w+enpPFcVBd67AFVmWsQ/oabKXsNgccaG7v56R4WcFr1/TmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL8EGkz9Iii7Lxq53ZQvXqnp/2KtqUAr0przWQwwx3G2SQonpaz
	0wJxynVTLBGnI76t0nnZuDdJLUUjjVWCuq7mxgqwgytX1j2AXJxjbA2S1Qdp4qPmgP5TD8cuwTW
	1BNQFASD5V56It1V3O3ofLMoeaoUkTNfQ2fhXfSw4mdM3v/XF6LrUCprNextbWg==
X-Gm-Gg: AYBFou0QmK1gZwny00R97CLOMXe5cpFIGpacCmXTBZojtTl9Os/AGIBS054UX0acQV+
	G+hGhgkQO9teYFBuL3/cjvmJZld30Fy5dxzQFtL5lLXFXmxyUtS79tyw+Jph6j7zSqOtllAhyVZ
	RoESYUZjC9Ddw++oHbyzszgIpZOZwLd0cc7NHrDuDYYI+lQwtFYJQxEvpv+Mg5LvMvPDX6dZbUe
	Yd3DfZ8SEDnFlUooGMK+UcD8yAsLIpjWAFXBgVX6X5ln5ZTIoRIZB+DRd5mEMblil70wEtZM68G
	KA8m29wsKT/OKCVERNr1XE18ZA3v/qMSLgm4Clb2382W3fFrtCv8JPKH5ECcBGrpO1gF6Kq3rGO
	EZRpb7/lvIchx02DfXhONWQ==
X-Received: by 2002:a05:6122:c2da:10b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5ec23230f38mr3698474e0c.3.1793106270057;
        Tue, 27 Oct 2026 06:04:30 -0700 (PDT)
X-Received: by 2002:a05:6122:c2da:10b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5ec23230f38mr3698435e0c.3.1793106269536;
        Tue, 27 Oct 2026 06:04:29 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a894d5sm2072671e87.50.2026.10.27.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:04:28 -0700 (PDT)
Message-ID: <08bc0714-4998-494b-baf5-bf1fed8a80f8@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:04:26 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add SM7250 interconnect
 provider driver
To: Ishu Brar <patches@brar.si>, djakov@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        konradybcio@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d62222c-befdb9b3-ce1d-469d-a6d3-00511529579f-000000@ap-northeast-1.amazonses.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <010601a17d62222c-befdb9b3-ce1d-469d-a6d3-00511529579f-000000@ap-northeast-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0a15f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rbLHc7TusOZuPl1584oA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: oVizaqg8_IwlrSDQQepT-qgsISkFUJEZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MSBTYWx0ZWRfXxciXsQWCTEd7
 wkM5AjetiJU7kv+e987u79EK7uUoHTY/KRPP7/lrArF/E0wVEU3Tqj7r0nFoJQiqqfvCxyxFKv3
 pSIsXtK1qeZDMXxHGrSuJFHS8SfaCD8=
X-Proofpoint-ORIG-GUID: oVizaqg8_IwlrSDQQepT-qgsISkFUJEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MSBTYWx0ZWRfX5UZXcmv3zLa9
 GE6WgAgj4u8SvbY2NSRzAUtKi98bzFf6rX8SH33AsVap2W3fDPY9UBg02cQik0spykdCXtksDjc
 vh9mfcwPfsCPzPFLgkgz6hIkRIv6L7uX9BHRUO8xDjH2yIdy92uZY2MlERubjf8le3Ia2b9Lybl
 USTadDTbkcUmRbV6/JaEk29WhRFu2J75bWk0vPbeaB6BUaNFHzKkWD+8/dTtV/njOZ3oYqmUfx6
 yw/8itpMbFFvG6Z29B0Y0Zi7s28xnnIgLfAtOXpD+4ZeHX+4Mqohemh1RGsh9eiCyHuGvF4g9PQ
 Uul5ghvza2pqdvJLIfPmN5MtwPm8TU5C+pfrLc1AJ3jO5475dS5wJ/8iaV/tNU4yj6VQg95BLwi
 jAZ5t8E2jI/efxPczQmrSlWafAB9aMGRrtqqDyOJHcc4r+HCbJYmFgaobM74jzap6wy4dOaDqbL
 HKGtYvckBLUSMowY4Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270051

On 10/27/26 1:42 PM, Ishu Brar wrote:
> Add a driver for the Network-On-Chip interconnect providers of the
> Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). It follows the layout of
> the other RPMh based providers: the nodes and the Bus Clock Managers
> come from the downstream interconnect description of the platform.
> 
> Tested on a OnePlus Nord: all providers probe, and the UFS, USB,
> display, I2C, serial and camera ISP devices get their paths without
> errors.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
