Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D970378D9E
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356575; cv=none; b=EL5GTJk9ndPbVkuexRvUy4UngrHkwVgFcuC375SG95leQBtss+LL1EQSGlf1PyPYdA5cBMG3UWw6G1KOrPLunC9Z0Tqb3pQDpFnA+GTyWn8f2C8pkAQTkWldJhHZPL1SjwIf89kEbcIz7HRAgQ2K4Dy6A+BviWXnyDMFxcQzrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356575; c=relaxed/simple;
	bh=76Npx/Dj2IdUOT2bSfFas7IgNHimnQX3IkL0WTge3eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6CSmvWBol0NUHeKvvOAsr7JuH+TIpoibTBKxCHVqmuyEG3NfnAuDU7c9M2njv7/n+gexb0X+276WwYypkihQ4xNjxWmsmv9dkyoj5vWXJkH2TaY/4TLXVeGsU+I9AQ+TpF6HH6x4aYj3L7ZelC3fBEgwNv6MKN/t0sEDXuEd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgV7CS5I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=THn4LqTH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgV7CS5I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="THn4LqTH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99vKR3772932
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DBwUd4KHsO7tlBa9Aw/UBAV2IQBpN1th6rKIVuFZ6rM=; b=CgV7CS5ISRGlcJc5
	EPIcW6ld8HANe0+HZvnNfMgu8mjJ8Ux3P/RP2abyU7W/17z8t+KhUjwmi4vr3fFO
	M6nKuFr54Y5n/a8/7WEtdb+rtckZnI2tTxRAiH2yoV0ysiLHwcjFpt2D+0v8MXdw
	Hm7Sr2jorymP541/aKH4NiiCUQHKGrHOoezZWbOvdAfpn5smEaLxNaoYkiUTSWk+
	bpRlOFYBCaLpTJNXpmx2zGdQ3+FPgMqfiqq93lovZ0XS2SxeM3H3VpPNbYYsq055
	bOYR97uru5SVTK2d0ckmy3mQyBI+bbrWHeLUrXFIPg3wLnZyv36ra7tszlDE/gQX
	69KIXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42j8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 09:42:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914ae262b06so602985a.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779356573; x=1779961373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBwUd4KHsO7tlBa9Aw/UBAV2IQBpN1th6rKIVuFZ6rM=;
        b=THn4LqTHy17ewf/GlnrpDuQCv8mkcQVz6sofDqUNb6GbPb4q0AhvM8IDe65Hl6wz+m
         DVkWvuECQT9aVc+Hurt1k3lIsQJqWTs2xkfPjNirDq3q5ZR2TCMjW9TjFOSt+pkfwemx
         YiSP4LhVeJ9Cjhb5muBH8LanF3lUfEH38OMKDeqOg0fpTwbzcuIHwFlibhTkEQg6Q33R
         u/mgjwlpu/BolQGkvxtr3+5zAEuNFULMuDJ47r9Dzc8DvyfFc5OTmyu9rH7gF8WrMxPf
         iX5vSZmldrPnysBX94cVeEGyG+qT38VDK8hVAozbijsbch30y6XGefMbxWu/1FoCawqb
         w18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356573; x=1779961373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBwUd4KHsO7tlBa9Aw/UBAV2IQBpN1th6rKIVuFZ6rM=;
        b=SUAncZik406V0lNWEGrV5+4JBHAXF6DjobWNfHZmlImjn6MyUNkhgsR/qy391FNuzQ
         G8Bmn3AMxMLeq04SKa3JIBW11T2haEeFJhpNq+KxZBW2OtQ6udV1BauoIltgOudGLATC
         WnY4Ds07UGTKM09dI5i9PBN2Lgwxtq8bL/H0mfzy4Tw4mnWkFXLgPa3Aft2msnGhGfCU
         NFqL4EyPDTDjytLLHDZPzw0Sgws+n/LN5BlCZBs167PQffhqg9ZVw/Kokq40nEo8A1cc
         t33Wsg0Lvx2vIwTnuH6TJ4OzSKDAVuak9lUFCKFuAXTQ+jIZas4QZqC8/R4Y1qRiGywv
         i4LQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8v28B0gHqgxpThp/bMkPYCUQWFDIRtP8OmN4QgtHr81M9a03OUJ6K0974TrGVIqhNB50SxZ4J4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbQJ+qGWgOjWP9VoyaT7unPOx0HePmf6U4362ai9b7hu+Q/Z+
	ceYYSeiaGwUyO5raeGXUU3FwpWxHuh8O/hSUko5ZZCyLNjQIeujApMGOyj71wCDntS9AFAK2dGD
	dVtpWjM7lALl2weyq+7K0148dbfP++8+01oJ37nJoY/1eQloPWvcSHwACTzaTjg==
X-Gm-Gg: Acq92OFe9A6TxqIMn7XtpOJ1w1lcKvrg87V/PEX/VHcH4npKwD+/OMeckOYrE3vABQE
	qhLSQ2yDqo/gxI01aUeEBjGIekTCyqM3u57/ETFevTQoJKUUNCqHZ0+m7tWcxwFgE8u3GB3za2t
	prQFw5zbQho04au/f6gz+XEhkp+0gtaV0C1dBc1VnQnyG5xCGb8G06eCYQm0BpYN044OBD+chma
	KAOWat25XjdBeSKp9rVX4DAfxnpQFfUgF5OFlN8/9RNIPwfjSY5b+oTmIfTWEJm2pNGJ5Ul0DCi
	bZ6OjEz5SCXSz759ktEyUKnW3+UWEq6YYXP0aIKq8owx2vjSEEapdwgwo9givfdFN8T7gUXSquX
	HfGQb6U+sW4UYr1nvsdvE3P39ZdlIsKa+M215+IP+/D62DgSXxZHO1HRlhy+z2GQKfwYkJblnIT
	A+t/kfh37YhC9RlQ==
X-Received: by 2002:a05:620a:3193:b0:8f3:5b1d:ed86 with SMTP id af79cd13be357-914a2e3e411mr167449585a.8.1779356572739;
        Thu, 21 May 2026 02:42:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:8f3:5b1d:ed86 with SMTP id af79cd13be357-914a2e3e411mr167446985a.8.1779356572203;
        Thu, 21 May 2026 02:42:52 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aef37b1sm22701966b.55.2026.05.21.02.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:42:51 -0700 (PDT)
Message-ID: <907fd71a-7053-49eb-9547-592ef63333e1@oss.qualcomm.com>
Date: Thu, 21 May 2026 11:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] interconnect: qcom: Fix indentation
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
 <20260515-interconnect-qcom-clean-arm64-v2-1-adeebc73596d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515-interconnect-qcom-clean-arm64-v2-1-adeebc73596d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ed39d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ewqw0S68lcnLxXb8CmkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: iQ1Khe3qPUtwRlQqWtTLZQlw8g47ASO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5NiBTYWx0ZWRfX6UQ7klDZ5O6N
 xtBeTEPe1bM0ZtbicuIyLEvcjGd+D6MAZE9WXLjrSbKIMj+WHgrt2vzVbZwaW2h1sH4kVEFKZwB
 z9LUwYP14JQDyByvlbHJAAm46ooghGc/aYGQOoE0ZSuOvqzEFGvgj7VQz5lyNgPIZka5XMdRg+G
 oMjjyfsPtvbm9ix8ezMnDgU43riiXsndgwHtmJqF92zqlFXE280xyp2MfQyf13XQQKSVrCTHUl6
 3YLxtZXELxRth1NOcpe2pu7lbI6b0gL4azqX6AGOUYsmSb0xwofiLhtTUFMbfU3oFSHw7cbBRVX
 9HYfQFDntJA5tr6JzuUydM7pXfJko+sA8QPK7U7k65Xj+qt4LaGk88LCPZxVbmHad+h5RAAp5hF
 hkqZFdjnPU+vPCoXEcwNEhq2TDMvUoJysFpl6BL2kH/AuzwbCQMwWbLpNYnHVQbAssqFM2AVSYO
 ILgKxdsjrZV5TrviDjA==
X-Proofpoint-ORIG-GUID: iQ1Khe3qPUtwRlQqWtTLZQlw8g47ASO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210096

On 5/15/26 2:11 PM, Krzysztof Kozlowski wrote:
> KConfig entries should be indented starting with one tab, so replace
> spaces with it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
