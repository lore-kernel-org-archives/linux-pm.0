Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2303115B8
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253002; cv=none; b=pOUlqfwU7cXeKmNFyUT7igUcaih0zvUpe+4U3oofSVjeePJ499+uQKtDg/MA3K6k40NmPHQhtKgq9u/zHluM0tTtsGv6Z5sOgcGqfPqS/Qn+e5SN172ZfwZ1fii44mFMrW+ZQClvsrtF+8TZh2RsFyihd4fRWSLw9dK2pAezAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253002; c=relaxed/simple;
	bh=jTr4WS2NYmhdyKOHSsxcJ8Mk1kaJnfIYHHyXs2tqjO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocHrlDZre21ZrGun/1o2L3MKzp18rwoY2mpwTg1fzJlRj339PNTYSIs8Bdj8FbXspUJEGmp0NirF4fzl1Wv1/Bq4ciY3nZQofrnJKpZNbNAFzG9uqzLRLaTmgvMKDfhrrSPtTamRPFhZYDgd/XofclqfgHamJXkfHtMWBAXSVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVg+TAY/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SHCZbHcY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVg+TAY/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SHCZbHcY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SF6YJw3305493
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+tPfAbLZDTU3izOK/EgYpGIRm9s6aBpybhh/ZrMzDac=; b=OVg+TAY/dAw+y7Zf
	V+ME+TAlrS7Nvi9mdfUxLKowKBLCryrMu5XIhs6GFXnG7xAUWQjZJvUJfEFQaVtw
	6HW0soS25wnJmmfjnH/PxZ4BoU93lAIuxK1rd+0GXgAMD6DQz7KEqeRHsH+HwBLB
	eAFWjV+Gdem3Ectc9xH1h4OOJ7w0ogImDc6Ne0GhXaYpHWVxJAmyoLM/rcXTsq2F
	IIaA1givqxar+teuS7AIRXtdAZC3LEz/eAubtgGP6FV6ayMPKe5sDKce0Ktl7J2L
	elVWjWXK9NWJWoOc8NJK9lWJxk+9u6cGbndrfGjNA8xt71VBXBZvPRpC3wQgkXU3
	3zUdqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7krex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 15:36:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21c01cf3so68857301cf.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785253000; x=1785857800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tPfAbLZDTU3izOK/EgYpGIRm9s6aBpybhh/ZrMzDac=;
        b=SHCZbHcYOq1DCafiGnBBHF0uWvddDSbxGJP8IBK3Yrq1f4lbHXgZrtBtIdEJr9thZZ
         /GIxjuZWVC5WsKlgvq5EnFoM3Xh4HxR95PhZ8IxIt/Z6NR4AFVxEb7kfflyX76Rq6M7y
         c7Ga/TRn8QdZbVJfCnCI4lfIVwwRFOPqlO1hz6qdJdMdM4H3SaBFPwDGVQr4Z+PlQ83m
         bbUQ3gfLe2qcjAmRmO5FfN9dkWUHLO0fySYNZwnHvg+yQ6M7jG9vnaW4OVAMo7NzA/F5
         eseGzhTZw8auf6bmwD6XNztJWzav1DKL+uG1WsLMkVfk0N/xJvjxx9CBGAsFGFVAtyll
         ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253000; x=1785857800;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tPfAbLZDTU3izOK/EgYpGIRm9s6aBpybhh/ZrMzDac=;
        b=EOAof/nEJNgpN+NNw5BTh/w0LWNr8mJ8bemr/ixFLge9fryG4wbyDj30eJZp21jBcC
         FGuNE/oF/UliWRxq9WKkcqi4jJcBi5LlFe/PS4UvRfbWW6jDDOkYwBjMfbAjwSExo0sR
         UyJ+E9NjlxVYI5M61GlDHwdnnVtcoe2Pg4zbojWsSbY3smaeKG1+pcWVKlG6xRUaEmL4
         dzEaK+hqmpEhW1T6oQXYN0tUDCYm+p/EXMPtKahPJyEXCGWiVx3VM+ufMEqi3cgwi2gz
         MKW5EW/54/FDFoHwT9SI33Lc5BMfZTcj//T5F6oHrW0ja8UOYwb+iSDlBqagPkOniDRJ
         Zxow==
X-Gm-Message-State: AOJu0Yw8gGCi1p5wqe7R4NrbYP9wLfHF04opWafZ3rrQX2Bke6pUHMdc
	GI64ipsRSYlwecxauX0J6EZ32z79I/lTPkLuBv6wzlZovnjxTR1Perw+a5sxxwMc74nLjURBz4w
	fgjDsqCN0AcZYhwoZ/ypfElea8oXJIjV1vY6ZLPxcNTEfS7Q0TMqEtiF+yUzR9g==
X-Gm-Gg: AR+sD12JZndryArAowNahn7d1CEibLgj5o0sMefpyzAZG05dDzBowjTC0Ot5g6Tt2Rj
	I5VLC0kYcmMcPdp5Ga7lwkAonWt2ek4T1Lphp8OEhqjOHztTAoVjpHoZPkP8NvLENPTRz9jSBvm
	4Bmo8ODMt5IIeQm0ND4iCvsAQGbD4CpVzaByRJRx/eau2RQx/a+KgwDDVZ0kZ3THS1t6mxVOIye
	dxQ10E25pwwK8+klLUbXVqA3aUw1eXqILBCtQQSFhVeQsXQntSoaJUWJ0HldymaknSprITsog9g
	xMgJLGlkrC1STgpcTIVibZygdXqJxuDPUsnBuDS7J5O3J92MyXE1m+3fgQfkEjr2sDzdg6QpTdY
	RR1dQ1d1ver8YKpWYW+r/V6w+p34ivG3bNjDSQwsdT2q8EP2HFtVyZUzTVAZ/RIJJZnKY
X-Received: by 2002:ac8:7f14:0:b0:51a:8c97:fb90 with SMTP id d75a77b69052e-529d71d2b65mr25828351cf.57.1785252999683;
        Tue, 28 Jul 2026 08:36:39 -0700 (PDT)
X-Received: by 2002:ac8:7f14:0:b0:51a:8c97:fb90 with SMTP id d75a77b69052e-529d71d2b65mr25827731cf.57.1785252999103;
        Tue, 28 Jul 2026 08:36:39 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:237f:3a69:9c1d:e9df:6c3e:258d? ([2a0d:e487:237f:3a69:9c1d:e9df:6c3e:258d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4443396sm97758175e9.0.2026.07.28.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:36:38 -0700 (PDT)
Message-ID: <fff5487e-5c0a-4567-bcc0-3e5a083c4e75@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 17:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the Maili
 Temperature Sensor
To: Haritha S K <haritha.k@oss.qualcomm.com>, dipa.mantre@oss.qualcomm.com,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com, gaurav.kohli@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260619-b4-maili-upstream-3-v2-1-e54516c37022@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260619-b4-maili-upstream-3-v2-1-e54516c37022@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzOCBTYWx0ZWRfX3ninB/ZmgsrM
 xca+mBX/kAS5L+dooLAvFg+rL7SBM+UdULmSZGngvgpqzGl4Dxtw2+KoQgMsBGG+BSNhJ2PlS4L
 hJUFCWcfsRITdFHRrmbshk6eT47xi5c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzOCBTYWx0ZWRfX1wuQLviqFrgu
 krPRHnVH9u3bt94JThomy4rpxqCgC3p7Ufq3JX1iU7Lham98qY720t0ZAhKs4PnRSzSdHeuccLG
 tCFC/KFlokwvHBFN/UNHjaI8TQkmgwnQW+2/xnkowewSxLF21H8TseFxAF2Z8R+HxRWIGbTCb0F
 ZEeYpQkleha4Jez7S2rufedoAF+2WrD0JMaOUEvOimV/J7nMHRc77LLeN2TULyUlxexPmynZOkw
 46RZu7TyFULMa9xgNxU/5Hk1SWYRebeSMwt7sW5iiOSFpB0R/OQLAaiuy6VDZ5ZnJfYn+y9jCdX
 p12+ApQdDm5BDLp5CykimD2iRT1rroYEXfLfJwPPoamqxn6tP5aBqRnxaNv8AF2g5yqzcRMKh/k
 ajgGyHh9IHom3JtM/zEzDa2dwsPbDw==
X-Proofpoint-ORIG-GUID: qYPTBjPS8gjbWfm3lpkKjoTN9fsZBLr5
X-Proofpoint-GUID: qYPTBjPS8gjbWfm3lpkKjoTN9fsZBLr5
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68cc88 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_eGdy_ivWqBgClNpbDIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280138

On 6/19/26 12:20, Haritha S K wrote:
> Document the Temperature Sensor (TSENS) on the Qualcomm Maili SoC.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Haritha S K <haritha.k@oss.qualcomm.com>
> ---

Applied, thanks

