Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175966;
	b=XjO0Ka6D9AjdeBYc9+64YCS4Lzbr08kjLGOx2u1hBe7nLTM+R5JVSiyZNYsVlZEwJm8n
	 jKkcm6EfCdd5a82o+JPWJWcr7Zr0ZfoKNdUqbM3t89iNjTuaSS64SgqeftSaerTZ3akLw
	 9FCDEkB13ef9/Y697yLUeKORQNf52JWs+zQr4+fkasGFP2pMHB3P+QnDu60ddrAa/i4A3
	 2W+F/YlI28uFBzCPFF8yxR2Gqa9uqhrLR/RnN6y8tCmyYFWiyS2tFfcFWzDoZJNJgsns+
	 MBbWCpkmTCUTLLjvLDvYNIZz8OK2w9KvKkrX1BL16pAEme6SQJWuMeN7ta99t8OAQWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sf1TWW/3HG4QfIaVTVwxXEcF5anGYYDsxbkX9aPqTg0=;
	b=XpkJ31NM1oxlnFeAZY9KN8mnalMACnUlvcVvXPFoHviC462LYuUWCeC66gGo1wjYu7pW
	 1ZQgMW2qGt5KLSf4/IsmUl1nCM66C9tHAcWKsPb9ru8mKqpERGJvLu7a9rFui83BAQ+t6
	 vVna3czXSEo+OlpMcNCulnD36L1FsoXA0hMarYkAhrN0MJlFG3rUZK7+/KmQfZM9tjH1k
	 +aXvOfCRvB5GYTPtWlpIueHD+VUomEQQMCxPnvFtCj7DZfUBMOlClwdN+DTZULejVr6kp
	 GuyC7IfnVFh7zDS9NNV5Tr857UUctO3KdSNi4V4VRxN/p87rFdl37nx5LWnldWVP4Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BZZnV1Ho;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMgwwsY7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55193606A323
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55193606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BZZnV1Ho;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMgwwsY7
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KBuX1642973
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sf1TWW/3HG4QfIaVTVwxXEcF5anGYYDsxbkX9aPqTg0=; b=BZZnV1HoTJPOHFH6
	lR8CYjd0lI4eTFGocQe+uV2qoM+H7Y8hMQ/jzFxDJ5MFHb4IwTtFrCcfsng9hZbB
	XFVxHXEIlFSYU9b7XpV9azCkHjuHXqe0S30b9UZU/g6NJzoebK2fVZ31uruW9X+k
	4OFfzMt9nxvasYdjxmyVTbfdZc4mI6cVNU8P/HrQ+hvi1Y7MhCRkkIyolLnp4Wsp
	QdeUlVP1s0OJCLqqj6oj8xmnIFAwHPvgZnFaudTrCuSekkl7HIjJSgy/UUk9e20p
	9IaReO+fXZs4oaHOogiFzx7WGeHKuznPksEqW7SJjFTQRtFq1EJRo8Kul4dQ8D1X
	5frejw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjpu394-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:26:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2005ce21so93882385a.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793175964; x=1793780764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sf1TWW/3HG4QfIaVTVwxXEcF5anGYYDsxbkX9aPqTg0=;
        b=XMgwwsY7Ln5jhCG9XHDjZqzM4DCcMDbdYf/J1MutxMWLNzznuFAP60HrZ8QpB+rgfU
         JqjHeQnqHLKpj1ntSleGZe7ZK10VU0tJeuYh2o70rCYN5sT9bfgzoIqnX5XJS31RWHwJ
         NGsWlmAtQMCV5hMi5istZUqYBeeADDkRiwatt2afeXy67m47Um2mkefCsiDYxqjTS7Zs
         w4XLcYvNV1oaSTs1BpgYyzWaZwrcSD1isbpi0V+Z2/WdZB41c6p70GWNTh7MdSbtI+QM
         QDu4c5jMfXIWSUKZzxd+zg+rCUwoYRo9W+I0OqyZeqUxigIalM4jMIbs+OleAcdb5FGf
         EQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793175964; x=1793780764;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sf1TWW/3HG4QfIaVTVwxXEcF5anGYYDsxbkX9aPqTg0=;
        b=HiCdZTnExIIXSUN1dprjbIPoRoWDx7aXND1esKwBFnZIn/HQ7M7WOcrl9ZBEIRJ11Q
         MPR2GuPa1lRgsSemO9L/XC0Gh8p+mUqCKA2mDVUzcO5Z7mWPEVI8AmJ2EgFyN1NdD9qG
         vVRlHMu8v82W+GLaqZRX2FmgjqQclZEBgknDesHLCmb6EwplHq2DyX/TJX5K2sDGPqc3
         9DDoK0uAUhNrCZCL1nkmoa6OE61QcZ/C9ODBxCnOdrra4ICGwvwRQvkZRqvmdQgnNlhG
         4GIe0h6maWUHcw2O8jchOjBrsbKxzVq4QGug/yhgXuTQ9haj5Fu4sU2t6pHGc0TlWQcf
         0Ecg==
X-Forwarded-Encrypted: i=1; AKwUvBw/1erqkuOKpd/T/bP9hUXSXyT8OrMrqeFQvOIbiGmBDKwPy0Eqqhrw12llrxWaXq1HxIZpvV1qtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgeuisgs8nNT0j/4b3GcPsyhhdOtlYMuFEU3ISGLwlPKYCECn/
	jfdWMoOOq1kkPIAETe3jRS9lzKuMrD2ZqRZdW6h+ZpTht9dQvqGRwhOZYzSzIdY5pufB2CiD+4b
	Fyq0gO6/mRMfHH3jc52CrJ0ytvQ8C6LJTqqI5MiQt0bzERIxQrp/h66XXxMOBeA==
X-Gm-Gg: AYBFou2NAye8LKXFvKKlAFgZBFmJyaILjPjV2v2tDSlEOGLQ9piqGfdr9Ysnmlu/F5N
	dp/LmNPrHp/YD3PQtGGx1q7EYMAgqrEqE9NomPoyTeRr5zJLMKwFVjzgJKYbgFRUozPOnzJYlmD
	Ci4GGeMOll5m+IA4AHypA6f18ed+RGg2alNb2ishrejuETwk5jaWbXbRuSkzVd8hGI6cF9otVsG
	M9ttQli9Xh29aMQJzPGXDYd0D/qnFnGLbnWFplT0fE8MZK1eZ/tU1/5lEuXZl6eQApSI4gStqcB
	hLoG9x+nwYZ0tXzRU8/OHEEGGp0bb4wyqPgcr6/4LS0OyTr4GlVNqsIwVQeLWfCu1SAS6nL3jW6
	bv+js4DMC7qNnvXAPY4zJQ4VyVl1o7R3o0Tt1jhIqfMTe5In0IucrvmQQWNrUqwo9pu1rvhwMqg
	Y=
X-Received: by 2002:a05:620a:198d:b0:936:df48:d507 with SMTP id af79cd13be357-94408a26947mr214970685a.18.1793175964212;
        Wed, 28 Oct 2026 01:26:04 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:936:df48:d507 with SMTP id af79cd13be357-94408a26947mr214969085a.18.1793175963800;
        Wed, 28 Oct 2026 01:26:03 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c9f1403sm30752595e9.9.2026.10.28.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 01:26:02 -0700 (PDT)
Message-ID: <4ffc0e05-f6bb-4b3d-9281-1930a1d83da8@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 09:26:00 +0100
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
Subject: Re: [PATCH] dt-bindings: interconnect: qcom: Relax child node name
 pattern
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Barnabas Czeman <barnabas.czeman@mainlining.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Danila Tikhonov <danila@mainlining.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261028081243.38562-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028081243.38562-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfX+qJ+j43pvUta
 WlFYjVXgu91aJQsZvtMiL7ZV1w+I27WLf/4i7UuzTazzN+l9wqk7tD63cO1/IRKuGpdstLi40zJ
 NVQ5L/gkDbG7IR4Exb1eMk31CyDJl07VzmrPpDnEPPURsdEVN6WXgUh/wKDY7VeWuuKnphXnGkz
 uToDd/kn6uTIaPEF+knc3EGYmVI9pT2w4Ym1kJOG1YHoSfZSLvKc2pOulju9h+Cq8KP5fD6P3dC
 xtI15NIvBZ2PBEChD9q6h9onN43UWOjaF7mSTdX5Ta7ZGyThwyw53HcwYakUkDpWYoXjjv4P2GD
 QxmGy85yQ4LwXrTCblcikGUFCgpmrVoi22s6SAFbRIhCaHiHajziQ1wMMzCJ/bb+HD1hhC348fb
 MQ9h5N91ME4ioDtF3kHAYHko7dHZS+gECz73UP5qpgU4OVBmxIMCEWsniHrciHahkevqhMs17LQ
 Nd12sWvpoD4nT973T3w==
X-Proofpoint-ORIG-GUID: _kjklSiv_JX01Ulw3qURlak2UM8h9Io0
X-Proofpoint-GUID: _kjklSiv_JX01Ulw3qURlak2UM8h9Io0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfX67pZ/z2i1hta
 QfNu4WDeNMrgxLgBlGb5EdPHFWNPWzDNO1feJAuz1m+wpywO5dk6jN/sqLmpe3lK/v4sp7hOHW4
 KZxN+Iz9Qbwc+31qz+dWmt3KMNJUnw8=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae1b19d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DKZtW8Xn8zsu_FwnbecA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280033

On 28/10/2026 09:12, Krzysztof Kozlowski wrote:
> Some Qualcomm SoCs interconnect nodes have a one child, thus that child
> should be named 'interconnect' just like the parent, not
> 'interconnect-0' or 'interconnect-foo' (see Devicetree specification on
> generic device node naming).  Ideally the child should be just a
> property, not patternProperties, but that would be an ABI change.  Relax
> the pattern for children to allow the correct naming.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8939.yaml         | 2 +-
>  .../devicetree/bindings/interconnect/qcom,msm8953.yaml         | 2 +-
>  .../devicetree/bindings/interconnect/qcom,qcm2290.yaml         | 3 +--
>  .../devicetree/bindings/interconnect/qcom,shikra.yaml          | 3 +--
>  .../devicetree/bindings/interconnect/qcom,sm6115.yaml          | 3 +--
>  .../devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml     | 2 +-
>  .../devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml     | 3 +--
>  7 files changed, 7 insertions(+), 11 deletions(-)
> 

As Sashiko points, this needs updates.

Best regards,
Krzysztof
