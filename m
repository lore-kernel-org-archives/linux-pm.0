Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA943636A
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972918; cv=none; b=QW+M9pl6EFNiNhOiFjmCXr3/ijL1DwhzfX+CTAYWr/0J1PSPpi7YhCOH/NNeLK/jwL1gqf+9Dg3JL7/gIM5egS+HN3VxOKQGVYWpFkirJtZkq955BRx999ZADDLE0dVW9/AOzrYQGonknGLFeYSE5mCyst+S7uWmqqibEmneUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972918; c=relaxed/simple;
	bh=NDGPWt+D2ZXDyHyMBO6JKFeHYSXg9EA5515WHJ+RyIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUn6pp4+FEux+Eh12zQ7Fsg5dqUScXDW7A6v5fNFMi7EahhKGb/Z2xJ2MaRixMRTZW0gPaPTamq3qhZdvmOiWlcHhSaaEVE3tbDu7dospDnBayZtPRPje86Tr5XLo44oHSWIu3lM9eR+d+Bff/DIvdlQPumJmNz1RgIhvzlbbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilduPxHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJ0jrZII; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilduPxHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJ0jrZII"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD5uX51994269
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gzIWZwyHiva5dFFB1nsZ7LRuFC2QV7+W8VsetgL6odA=; b=ilduPxHA0sBskZxW
	F72jyL5bIcSb5+4/z+0L7B/VrXJicmILlzbC6JdOK0E7qHK5yAPBSau8eYsJA4DI
	rpFbzunOHevAcun0cqaS1ZqfL6yeDkz/MoM/J4feC3TQEBmdA9BxXcCRmcg68JU8
	mpIh5pr5/AnbvwClxq7h+OA76TpRFXe7AesWUliQEIwLb5feV8eIQNNigEVZ8ivZ
	uexvATzARclHEnZPExaRrmhZubBBR34AWW26tG/p8WxEsRN5ai28/1j2nLa8Zy5g
	H+5HC+SmJg2N33E53LcDZB1WoRMFHTxFNtwqjrTgGYf2UbvwQnl7xQaL0i3Ndu5J
	B2YXHA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1h69p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:21:54 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-744c091ec4fso77530137.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786972914; x=1787577714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzIWZwyHiva5dFFB1nsZ7LRuFC2QV7+W8VsetgL6odA=;
        b=EJ0jrZIIGohJ+19y5ZCvaCQh4N1xlig/rimrvXM1I6HylAmQ+xNbAfvuzc7SLtnvsP
         oVnageqgtr7D1rbFQsS9HEedlBxTV1GJMgsLlPm5mGFDvIueMUOIakwjE0v8kCBKoYWl
         Bdd2z81Af/u9MiV7animnlqZmF5Dv+/gBLFwtUoiINJNqH1B0ktVI0k6UTu9r2OZMnSK
         4dexwIgV60cE9nQg8Smw2xHduIorXH+1yHGN5F9abhogdYuHqu8BxeLFIsZ2J5bcQBMA
         XybFZX2w1S++rFNxW9AlFrDIRdXbw3MojBhEU4ghGeEGUxkJsSCUTWKEJvRiZ+n5TeRy
         gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972914; x=1787577714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzIWZwyHiva5dFFB1nsZ7LRuFC2QV7+W8VsetgL6odA=;
        b=RGck8h3kvVHBvwioQM9pH0YcSS1gx32Jpo3A5wjC1/3PGC2yxDCge0CN6zNqdxLa26
         DFdi37FKHFyC1ntGVVsQ6bPYAbT6PSwkoi+QGRvyJHMnXIH2A7rJB78nf3trH9haIR+q
         SDGGyMzKoetIm1Dk7a9+Galatf8bmAeJzpswKUaZfaJjJrwu3RUVTlwkb79hoJSELM6p
         WPGsZMBcRpwPY8OgLSu9E4Chi0/SLx4s3QuPrM5iSuK9Iwt13W9dQnU+bkHojyjMylB6
         2SAPSNSqFMqzU84K4FcYV+eV6osEXk9Fr1TiF5jLRz0MN4quoS2QJ/vTk47eoPqOpRFl
         ouZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9S/9pwiJLDDLSqQKjEuND7cNr+lIKeMF3TYegxaeJ1PcTlw299fHmoRD9I/1j7rVM+CznlhjHpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcwbXXWfJOdkFMLNEODWNTHj3RqRSKUQsWdF5nUIDEdOahJdS
	WaQfktlgYC7i01J8f81KKAGg4JmZodp9MhruHk21PBdyY0LZmMMbBiyUzsuSFTTMPqwyWYziFt7
	/iS03hU99SxN6DuSVPoOytM4cTf5h6vCc2i4nTLN5lTSZD6+TSjecmnKSvD3jnQ==
X-Gm-Gg: AR+sD10EZYlZz6ZcPt2ba5x13NSENh23PLbYBDi6ATeA5ifQFe38g+x6Gxw4xLlatcm
	UxNBO+FrBuiTEMizFs6yL/OrljXYmpsrXC9FeUzyUJj5G25aku2A2b4uWPtGAMO9syaQfh6mBSU
	OJnIR0jn7LkSqodaMLoOHFKZ3PBBYemYL1Ug/V2m9u679+HWg74xBmzmE23ehjoVXsZYFJ4UOjw
	w8ikZShAmC310GeDeao6xadbidJnPBR9KDRLfEfFHpr9lIhhsMSYAT9Ema4rv6NeLi3Bj48HLC8
	skRgs/r/9SBSwY0o1eNy1L65mhunHiky1ms0MMhku+O9ueHBiLcehUPF5LimuXVZ9z4/2RQTfOk
	vBu4mUqg2jVycN2G8pPsO62OB
X-Received: by 2002:a05:6102:946:b0:738:133f:8d60 with SMTP id ada2fe7eead31-76f2a3d9574mr1610864137.1.1786972913707;
        Mon, 17 Aug 2026 06:21:53 -0700 (PDT)
X-Received: by 2002:a05:6102:946:b0:738:133f:8d60 with SMTP id ada2fe7eead31-76f2a3d9574mr1610848137.1.1786972913305;
        Mon, 17 Aug 2026 06:21:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b99f78sm28129966b.50.2026.08.17.06.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:21:52 -0700 (PDT)
Message-ID: <97d391b2-4d8e-4141-a139-a41eeed7c6bc@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] interconnect: qcom: Add Kuno interconnect
 provider driver
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-7-3079794f0f73@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-7-3079794f0f73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a830af2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pe0felBmJweB1gBNqhwA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: zmBs0P4ubjRhfKRe9nKRRcQcFEAcCyiP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwMiBTYWx0ZWRfX4T+Bck8TMSrz
 OGkFCsegMk0tW8cjqEOEINXsao/zZ1eOhY/nw/M+yIvkfOMJtA7Rr9fQCFqmwff2N8xMxYSjPc0
 ql5WOBFYVzJkUYNOIrCGiBOVKeXlRMBvn2dBcHTRRDaFFUCsqPR8aJp7jQm5+gVpGSzG3QXYi0r
 9uz1SUURxzB9rFdM73BpF5FoDuBIs+xicecpKltdkH+4bYvSY4fATFL60iqaP5A9Ny6tX9gdGO6
 Fr9wajCcDPEyPOHOp3/+tDNbjugK/neAZb9kIR47MA+1b6qgPCVSkI3eYrcyOorGlaSD1+8T6vI
 goxKRxlyY48ReBl2r76qg396lHCdGkeRJy/bhVoKvvMN1mc5gmUWFvEIxBL7iRyIaFckvGa9suS
 1peYFOaNc1d4zVUYZ/GkIbrJuj0BBB9D0m9ij65GI93zZeyd3hwCkNV4zI9ZnpQXzGz7c7vYJ5e
 2rr92GNqA97SrDXIS8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwMiBTYWx0ZWRfX8b7hf0P+0/hL
 j/YaH7U3IDUh4RUvNmvB7UsPcplqMqHs1OR0/ZPkV533ud1HXF/mDfsFhLTM9MLe18LiCjNxvoy
 XXT2KjhJ22zl/dFPYyir/SQ5aJbu8Do=
X-Proofpoint-ORIG-GUID: zmBs0P4ubjRhfKRe9nKRRcQcFEAcCyiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170102

On 8/14/26 9:31 AM, Hardeep Sharma wrote:
> Add the interconnect provider driver for the Qualcomm Kuno SoC to
> enable bus bandwidth voting on the platform. This includes the
> aggre-noc and cnoc-main NoC instances with their associated BCM
> nodes.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
