Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95D3C8737
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035295; cv=none; b=qqxEt9+4FRt86WNzC2onZjXDpViwrmKv6ZccufnjAo7ciu+1Kts5q5c0jv7Cz7XHyMwRCEneXvt02x9Ggwxa6YZ5pDdpjwVnh4EyPYcR3Fug97WXVJo75uMmE6d7H60Pgx41mmo9tg1x78P5WsHCAeex9uC0EmgdiW9LozS0eUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035295; c=relaxed/simple;
	bh=g7mTCaNy+qXAYxV5j5ONa70Z2PoLfxCg80HoTtjWOgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh8X/3S7sjlCgoMgme+HtFW9MRY3fzR33nRwD5pzhzPv2OlzTA1H/2aW0P1MVtPINGtknkIibHWOi0p16/7QeUDMZIu50BK4/HqavsrLwT07u7w3AJ8Tyq/OYSbDDH+WN0fFwXrx32VaOnCNJgzOxbUdYG6sYTPyftDfcj+5OCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNC61BQ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SxzWc/Zj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNC61BQ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SxzWc/Zj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318wcvL1459000
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TWmGZ7CZcJb3X90qICYay41hOsfqZ5P1zWycST4heJ4=; b=nNC61BQ24hkqlOFz
	4FnjbxUUaAv3GSHKXxbEgbGfRwsjrR1PBxpmo8WQyGmc0+wbkuY607T64Sg+Ra5n
	pAT/o1/a+fGvZg1MqXYTuHgdIeFK/NQR4y8uEwQpHhN6P0QsKTRp/z/4cO+CcUNR
	ZFE9Tq7rsdZlFdcrpTQyH6lRFUapKwnODAwXHo9omcs3gGInlPRUQQegiR8y9qm3
	/pKsFGPgsVGa/SBodtSS3AL5vRD0eRwYvawpF5UIMfjHsW9KUqRAUp6+hR1tGvtB
	EBC48VKX/UwY/83seQuEoUxZT3diTFPVwieRcoObIB3YIvGHLbQU96fHlZKCjbCH
	Cl/R5Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8uhg1bfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:21:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d0095b0d80so214752285a.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775035293; x=1775640093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWmGZ7CZcJb3X90qICYay41hOsfqZ5P1zWycST4heJ4=;
        b=SxzWc/ZjSrRK+4AUsxrUo/cBgfRySw5h7kA9UzdYUh5//I1du5zRnCPtZXpIWZI0GJ
         wPFj7MEb8fXhd9ji54u9WQOvi6zRfjigFlH+1RU0fo+89spyBjtir5OsoJle+uaBXWaN
         6SL9m5WB6Y506oLUSSIATy3s8zlVZvNOshEUjr5QkPGnMCthPa9+k6q806Ndc9ls/Pux
         7+n+gPzTZXF//wlOZ1BtvZyUJfBlmfHricR1DX/XmpSiZ1Vuksc3REZXzPwpmra2ydjH
         5eBGCr9cJSWHkf/bx7r75/slVRDNCCr8bz1SDhrMeYRtahlLGRylDU/E+una/ljIYMl3
         jzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035293; x=1775640093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWmGZ7CZcJb3X90qICYay41hOsfqZ5P1zWycST4heJ4=;
        b=QRZtVsy2g54d0XA7UA9tLnPJt94TsVDLwvVcp0CvkUxcC37DXHQ/oZJ9s3pNQgo1F2
         2KRLEFTYVJvtyQiJcJdQSsRUnvSLUKhrSr1LVtSEScwDWj8vQV6Ij62++n8Oi2PI/hrO
         lBs28E3ZR+lKMO1QZuG2Aeqha185qTW0I9n/mRDttgEn36IDB9bG/fUzyXENPOv1ICx6
         Z9zQ5M9qFykXWt+8p0vQJSZQqcRNvQK4TIB812rTL5jdXj9RLMd6nIZy1lV2t53y5aZB
         lqHTEWa406gr788zH8F00wiDBlIQyOpqFIZ1VpgrMmd0kgHsat3+lnwmsaRElqmcPaqF
         6BkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1huKm7EwRxBVqmRVrMhAZUUKdQ8uvgz7q96QjnFJkC5DG6rqE+EDMNQgMQ6zvsXUe3c23kx8OIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwumzvOUA1eByS/5UbiVntWa/Vi6WSZPf1Ozl9c2LeTWghRUegs
	Vyb6maD8p2f6PGYznNh1k1mYcfbYObC3BWvtCEMyanoY3G/81NCtwleC45LtimohrDDQ0LRSY/7
	G01FasmC4z6NYf3bR0Lok+DfnsWh6BqjbpU+BDz0AHCCAgHUJ60Lp9SSAhRd8ow==
X-Gm-Gg: ATEYQzzy7E/KHmbOcR8bF83bbuzOGNMq6SRPLb44iMFJbAE16dnTCY79n0wkJK4Bar8
	X/e5Q8QOvTquhgN6KxhKqu6TupGyW30cq/qQqxjlu7YvarSAWHggbd2PvvArIyLZuaThVGFCVMf
	4d+iphszx2M+vykga8W5rnlkoINMGuaUfom1adEUocKQjHB/NVNFMrBnrJtnDQ0D3xRJ9g9sQIh
	S58Z4j78P99fgapXYzYkpIIL//gdU1Aj+x1ceKZccicYGU0bYNrfAwPtfczJ/1ZWX72CHfFS5q0
	q7KnybizepiGC+tR/5rq775R9ywy/ZSsgOaWT+jdI5YhU0NFBgsgYv/BkG7mkNImMf9ARv093Io
	qhq/A2jSey7n+MlaKipOzfQUAsESDI11/ZWHoqiqBnXmeUcEolz7hooj/kNsJ9BEJdFaPG5qg1M
	BcrTM=
X-Received: by 2002:a05:620a:199d:b0:8cf:e930:8a9c with SMTP id af79cd13be357-8d1b5c03f81mr278770085a.6.1775035293196;
        Wed, 01 Apr 2026 02:21:33 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:8cf:e930:8a9c with SMTP id af79cd13be357-8d1b5c03f81mr278767085a.6.1775035292757;
        Wed, 01 Apr 2026 02:21:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66c074f0a49sm2535246a12.1.2026.04.01.02.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 02:21:31 -0700 (PDT)
Message-ID: <7b2559df-5131-4893-a28e-8d5dd909bebe@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 11:21:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add new power
 domains and new levels
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MiBTYWx0ZWRfX0PXkvpHDCSOi
 wSXKU74q2HAmTiKT8gBKgVqAl0jzxw+ZNvJsXEuBqC3rF+218B7ARjHM+J84OXffb5FMU7Uqz9d
 TEuKHadujBs5oreQHFqMEWT8cghNyYTNQ4negvZP3uogHXOQAteVLn8LNDu/EgPncdsS475Ncgy
 v/f0Nj/tLnyXNN/8xmmWMR/khnLb6YL5tszGw069LE8PnQIPZtys5P7CIHiqXAgo71LM4vjYY+1
 O8ruieAPmmm/iBdB0/xS2MyXaJnPN4FxOyUHvcqQKidp+F/epb9DVrGHvkbkNv9HciiqN6Y2Iya
 g/2K3hom5txPxAgECR6Sr7lc6inOxol2VT4P4IgT3ffhAxAaSK+MUR38seSa/cATvGAqpOdZsxl
 6Dkl7Fv06pJRNooWQnBmYS+4lKyofPcjxmpAFjV1QBSGAmQOoTJml5FT2wX/WmdWLC/6WTgM3K+
 hyg8oI/OosaPvoU1A9w==
X-Authority-Analysis: v=2.4 cv=YcawJgRf c=1 sm=1 tr=0 ts=69cce39e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=5ybyJXMKkUk--e2QuikA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Jl3s80C-7dhSJU-sVpkq4qp_tD709eIr
X-Proofpoint-ORIG-GUID: Jl3s80C-7dhSJU-sVpkq4qp_tD709eIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010082

On 4/1/26 11:15 AM, Fenglin Wu wrote:
> Add definitions for the new power domains which present in Hawi SoC:
>  - RPMHPD_DCX (Display Core X): supplies VDD_DISP for the display
>    subsystem
>  - RPMHPD_GBX (Graphics Box): supplies VDD_GFX_BX for the GPU/graphics
>    subsystem
> 
> Also, add constants for new power domain levels that supported in Hawi
> SoC, including: LOW_SVS_D3_0, LOW_SVS_D1_0, LOW_SVS_D0_0, SVS_L2_0,
> TURBO_L1_0/1/2, TURBO_L1_0/1/2.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
