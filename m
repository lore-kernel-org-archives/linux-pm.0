Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055641F345
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693230; cv=none; b=UR/9SZo2K7BepIY4YIezWxSUVDRS7DFPwzZZ4ZnI2dtqpCDbrnqlg/hadEgXf3AVvr8AaScPJ0P8uFXQ4CVUqP5CX8zY1gKqqn3+r+0Ec6AG+HpBR4okRibCQXMwZTllf8ga8llcrqe1midXSMtSd71I3VO9U6bfa4jiFsQ76Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693230; c=relaxed/simple;
	bh=nH7Q+YQSIAoDWSgqsEWKxhw3QmJgbzhpW2lFA09Gi6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPyTNOui89JQPLjTvG2sli75gKP8cYFIJvoP5BuioxUoddqvdQYkjaRgD+hqIT9sJDt/e0MXUsAR/OCaB2QYb9ibKw6sqN3uBJzHx6kk2Fcbtsn42TLBNP7n8d2KZ7eQbv3FIFkLB5J75E9W0ev/FzGvbz4vqJadHETL7zfYyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGZAaeSX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VWetiXrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGZAaeSX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VWetiXrp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QgJR980084
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hH6IKL9fwc0s1y5p10ke9/jOey7Po7DQwNE9DthmsPA=; b=kGZAaeSX8C8u/uFM
	L9TOEGXxq77bUZyqea/qMvM01/CHZ8R6P9s/0mDOwC49W5vnfnU68LF6O4xGqlN8
	JN8DplqM2RtC4qKo7VMBu6wdMKKqtH4c9KOuegFw0C9YXdhhDO2hSV9+AowUiT7P
	VOv3M239qLqEHWwmmm2B4T82pVZx0A1+zAVt0ifvj6EeBX5Zr9Wlej2eYY2xQdxs
	qvPQdokD7aYosdX/vGt2RT6y1M5oGH17C7z4XxkUvvAf7hF7p0AiCBpMOeIYCbU7
	MGlpCvHtyRRfNwgtLNk6AR0KFeScR3o0nt9ZQSOwOYwCJQM1jNy65P5ORa8vuS9X
	g9uk1Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1pea1reu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:40:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487eb67173so1074075b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786693217; x=1787298017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hH6IKL9fwc0s1y5p10ke9/jOey7Po7DQwNE9DthmsPA=;
        b=VWetiXrpBVTUrQDqm06kbgOEHGTNxPQvmxlC7G5yGoSKPaOFAj+p2nwV4EDT//E8PY
         qXlQBOMRMt4iVsUxKlJb0B63QA9bsUaNkeXiYb6dj3YdCi2cJupIxc38xOGvN6Hg2DdZ
         KcJrpuMZW2jClliudbssALiXECXB35RTC/kOJdN28vh/di/0WuNC3US9kolAzS2YkfpN
         6nhONo/duYrL5lmTWaKcFR0ysTiJMjTWda+7Mcw709RGRqx+kzQx1cDP1qEmmMM7NNjJ
         TkM/aUAUy13TV/ArYC5X8LfSEsiiXBMtx2wLespMkJtg/dIA1mKDiekEB5OKhhixi3W2
         ai8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693217; x=1787298017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hH6IKL9fwc0s1y5p10ke9/jOey7Po7DQwNE9DthmsPA=;
        b=CWyp4eFCH9mfXJKOvaoXz1raZFOi+QcpODEdZn2M/D9ZCMe3kdthFOxAjJRNUMaKYj
         q8bcdmlxaEHdGcKZxvS8Hu4nVhzZSZc4BUkKJYZGCueFfJDfm8PLh6l6BBWzKj1rMPCH
         VNO2EOiTd+/Ygu9pamSj5h87WMJwroHhjr6+DzgwzG3k6tlJgGcY5Zu3VNWkzRZJfXWz
         /ogvN61WFH75wAGM9tIszh1dG+yoP/y8MSXESTDmtLi6k0vzc1f/uArkkPuE95Iaecg7
         8Xggc7tcxpOyQYysEjOdMcj2U3i1ME1wBC9AR6ld2I1DGnYNeCE6UB2EjWM4MaBGefQC
         gWuA==
X-Forwarded-Encrypted: i=1; AHgh+RpBP1RDuk83u7hCBU84QeGzJFBAICJveGYjMvlQPmJN9r/A3Qf6eARdwBrMuKdLn1OtoOLzIF1nfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzg0qq8BTq6F2t0VAOtcqOpg2dQXVTxdMqOQ6ZiSDGhHd4J7yN
	2F8WKRTMcPPrwR3KhcfAVb1aBKKHXSQZm945NR3ik50rBWPNsGgHeqCZhzKkdIh47035jOHRqNe
	i2FY/ASvdFj0/M3Y7RmKMC5eV9XRSrDbKnP8kFQmEGaTxhoEUoI2k7gZ+969d5Q==
X-Gm-Gg: AR+sD13b3hCEX/9S3AGBJA6qarnp2iZPMk1MCwv/f3+ZX7EJD5bdlBJ8MCcYNvk4siC
	REPtSHkQ/WwJDH5VXXezz8+zaLqXkwqJr5PLktDsc+X8g6dfEVFxBbV8JF1BUClWhXOpxGVG5AV
	Zvwm4yZMMYlKLu6z7xDMtuz6SSTtqB49gH8RriZTuH0K4UG1qldJnZQ3BkI7/ddElq3lKXFIdVQ
	qT1HT0OQ85OfZhn/MkarzzAuY9TMctXHD/o2sjioWXvJ0H0ZLfP/YQsbwsk8d6TBFL++7tSMYiR
	G38xJNG3HbNHWzgI7mAv3tFH7KRMwOJQKNGYbFDIeqi96S8JcdL+m90UzaQqv54Nsku0aSvQju1
	B+7YtiFM9e7V2vUGPqol03hItNz+Cex/PdPFB5BdbJBOuiWDAAbbg3BetMGOGBL2CxHNdcbwwZa
	mj2AvUM2SZ5mp7WChSIFU=
X-Received: by 2002:a05:6a00:2e90:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84fde3d4d19mr4081133b3a.38.1786693217274;
        Fri, 14 Aug 2026 00:40:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e90:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84fde3d4d19mr4081081b3a.38.1786693216789;
        Fri, 14 Aug 2026 00:40:16 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc08f386bfesm153763a12.3.2026.08.14.00.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:40:16 -0700 (PDT)
Message-ID: <500fc16d-b4cc-4c07-9d0e-f2a4e734cdc7@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:10:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh power
 domains
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-2-5e0ede4a0c72@oss.qualcomm.com>
 <20260813-gainful-festive-goshawk-1be511@quoll>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260813-gainful-festive-goshawk-1be511@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbGmcxQh c=1 sm=1 tr=0 ts=6a7ec662 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cQuL5MwCX6JIoe3bmXkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Sz656hLh7-wNsCwmpvkmO3b6MOiTHDMW
X-Proofpoint-ORIG-GUID: Sz656hLh7-wNsCwmpvkmO3b6MOiTHDMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX/ptw7cjGYreF
 W1rAAvJGxhX0t8jX7PtrLz7NWuMIIXtRxKCXBB+M0RX/F0h9G2yhNU3cxXCq5nPOxSbLhRIJQmz
 xv3W/R/t4qirata1DqeLsa3gA4V0EcqidIdjNmChGmOHLSnhQCC1y4u+t9ezUvgZWovy83yVEBG
 P5lu0BoO2lFn8wnG5e2sr6aonj0qSX0p8z7cMtHOo2Se8jzTq4yRWlsd+/TqV2avImYpi9W3igs
 aAARaHfUXBIkYXdfsKcethz2izFiv4mmYkLu+UgRHfLLzae8lP6Vrl8/TbtZbgoad6CDf8wdxl6
 YcmboqPJ/z3pQ3qEfc2eJlrgEqxAWILotDNvyTm9AKjdMYOOTlV1TOx05paLJqR/o1OUlNHnGsc
 hJPCu8V4wNthyuHn+mZJVxOzV1AMesoLhrOJBtupdkSMDhQ8CogWZTE8mIsmOOa9TT7Lg//tqCF
 CYFC2hsMfd8FEReHZxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OSBTYWx0ZWRfX0F6RZUr09WQI
 L6nEUXyLxoFFrKrdAvZ/TaKqpAQx1Gag9s286q5JXAr9d1hHKC8x1xt0tWZ79zHIjUOftrhIq78
 q/KDnj31GeQrFv3WQUlLoE+tDzzE3B0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140059


On 8/13/2026 3:05 PM, Krzysztof Kozlowski wrote:
> On Sun, Aug 09, 2026 at 12:57:01PM +0530, Hardeep Sharma wrote:
>> Document the qcom,kuno-rpmhpd compatible to enable DT validation for
>> the Kuno SoC. The corresponding driver support is added in a subsequent
> "DT validation" is irrelevant.
>
>> patch in this series.
> As well driver is. Look at other commits how this is written.
>
> Best regards,
> Krzysztof

Thanks for review.

Done in v2 : 
https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Best Wishes
Hardeep Sharma

