Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D93128AE
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673421; cv=none; b=kIomRXuacYMmTRIKOzL6sR1hFg+BwBZ/EpL7os5xR1TDgDvVKb0gCu8V+xMTZAILyJE5f+8pkQJeZvXZSugb2pB1Uz6zrDSYMg41nXiw0ySNBLPj0exE3a92RFVlPSqUCPocrPQTD6XQmnoCL0S5Ps3wR0LmpulAgu/LYkF9xEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673421; c=relaxed/simple;
	bh=EZNWj67TxgIq1VE+4I4fSpVFm88t6C/a3QFfd4xpnAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZcYrIk/I0qyrgEA94eCPEYYRfMOkShVYSITk3U07ASs6OZlMWNngypIO5dplNsB6E+0ckvADhQKSMxY3lmxjHXGJ4FicjKlKLdDfzLlWL+p3ZTj/am7qGYVozd5UosPyV8uiGnlDskyj/nfT+3mLWs2YtRSkPwxnoLPVwaY3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onzAdZk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgqSjWcS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onzAdZk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgqSjWcS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBl1b52672206
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aCODfBGAeL0cibHdox9jxkGJAyfhaMDkIMYHx4tRmBs=; b=onzAdZk53HGPQGyk
	0CSTfd5m9dkxInOz4bsfgnWhW/ENpD8gR7TExcvI9R0u5gFhbRnQvOkLiOOy9hyX
	j7Rq66Rhej5PgO2H9TR8sosME3vdFqDbEXpXhJsLE4gg55i7XwPp/UdXKBjbXsMU
	yjkkhTcQ7qw8XRhECISMAiZZU3YYD4LSdKNwtfGHGIabjGJ3j7qmIBKKiNWQfXjl
	WGht/XV7VNX6yhDYactTSVnDe4YmJEMhTfpIz6nmfZlJkWovtEqlIzkNFyusXLCq
	Nxh4gZ1/vEmsFtBHHKG9t5LPyvYwmBjFaxyG7SeKE72tipNH/sAr25xxNNDrAAyW
	RozcAw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xpba4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:39 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d77bd5bb50so43687099a34.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773673418; x=1774278218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCODfBGAeL0cibHdox9jxkGJAyfhaMDkIMYHx4tRmBs=;
        b=SgqSjWcStXtCEk1kMDHHwHpBppQGbcz8JIS0pgn1XuY+S7EuVBW35PPI0ZAi9W/x3X
         u5EYxW1LE4x6SYECfHU65eldlJXCGkQCvSN4DFpr96Ht2+p7qgXkQURbf3VnB+23QBWq
         IAJlD8aRSicg9ROkTsfZ0Xo+ViZq14alQ/8IGFl3KXX6e190G1ThppBau36Qp8n57VnO
         U6GCy1Cj2vgd6VlDBKZ8GQQb8pF2huRmqoZiusAGjeJQtLHHI5zXRqwKCCtxvkZceae8
         2RCuvTguOVJ4BC+BzUiHfM8BxmrG1LEhmWoKJtQiw3KnFxtTaRqDB9yXiPdGMVSCID+V
         yXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673418; x=1774278218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCODfBGAeL0cibHdox9jxkGJAyfhaMDkIMYHx4tRmBs=;
        b=GWMr9IJUDAo4nuzhc15kt5tqAkowgjzADY10G58C9AcL2LBJ9B8UGMiAuPDkNbWfnh
         cXG9g5zgbeOMN/zNxjEjh2qMwUKwUb8YtS5aAgdH0jJ51RvtK++SKIV1BstB71QZPfD9
         EHS12uixr9mTbw54D20eHhqN1I4jrz8YZDAjWw2Ymqzi7jCdxV5AFxGtMEKfzT7hyioP
         UzpzO9Vbt30IkS+C+GULy4zU1xW/baz9YFeHJQS7mT5ZCMWHcXpqmB4IQXYTrsR9JZmy
         +0CnXTLMtpiQj1ElYVeUs3rkNl4qsmpMcL5+4+/Csro5jnmw9vm9Fe6IT/XdA5RNG7ml
         Px+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXINjfLsPpcQ1JmA82PNfI3i1TZ/6X7OIqPHK910DQ+nBFd3lZlzveXPJCJicir5aPu9s45BGBMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7oFTpVdnwAdkLEtPq31+EjJIIOzoKeUUppnRpCrt5a2M/5RB
	1982oiBi+Ha7rjfLT8EcVWUUdzhPlLEPbJUx1ShGZCpD7E761rYkANT96LDLwfzWNLPs8pOwm0X
	FvSJyBDLTmM85rAec7BbUTwOPP2EfU10/46wX4M6omPPSC1THCF4PSTHUZ8IIMA==
X-Gm-Gg: ATEYQzwmL949yTkQjStJqRdCwcLkyEvVb6CrnTsaD89pqcmD117Lnnd5UeujIYJEhLc
	c5hv1wiiMec89ApD1+3IKJ0Dck6Ez8v/Yx/9DE8MrJLhS/znDUrRw2jJCrBBODPCxUiJ3GWkJoX
	JIIsmEL5d4z8ST3GsddymlqWijMMQl5YO359L1bcDmlgfG+zoNfPOlHiItwNQSHai0t6JPrcFWr
	Gy5PwScKUdHpUjaIwD6rzYm32tu1bwdIaPbofw4+VCG1YZ4YuxkelFMJLqLt9uWWvrLSyYHqtQw
	B1bHTtEgvJf9eam4OsBMPGosllSqAAq28rapM8y9dUAukZFYQOKncucYzuprYUSy2sfHuuzBqmK
	Hx6DE31njA24iCRzlD6cpa5sniGSEIa+FfAq1QIKoVz/K83gKY3/CdmAgGhGrrV2ye+dcZtw2nR
	/U38+SgGPF
X-Received: by 2002:a05:6830:8217:b0:7cf:cbff:85e6 with SMTP id 46e09a7af769-7d776c64ff8mr9921417a34.12.1773673418354;
        Mon, 16 Mar 2026 08:03:38 -0700 (PDT)
X-Received: by 2002:a05:6830:8217:b0:7cf:cbff:85e6 with SMTP id 46e09a7af769-7d776c64ff8mr9921381a34.12.1773673417911;
        Mon, 16 Mar 2026 08:03:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855725572csm192675105e9.2.2026.03.16.08.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:03:37 -0700 (PDT)
Message-ID: <e3b1fedd-79a3-41be-a94e-a08ad0c85b66@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] dt-bindings: mfd: max77620: convert to DT schema
To: Svyatoslav Ryhel <clamor95@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20260312085258.11431-1-clamor95@gmail.com>
 <20260312085258.11431-4-clamor95@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260312085258.11431-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMiBTYWx0ZWRfX2uR9aHFuJfFR
 IR4q3AGKM8hehYnhCjWJ1Au3urgK5vDhRqXO84Fq7bZXDBLzVKmYmnN6naM923Squa5WWZA0tfp
 DTAlfiW7dFvRxa5R6bTHVfP/EEUQYU4O8yorSak9Uv9bDl2Ym16mRKeGihFT5EAn2C122plEZaC
 nwyxJtzQwh6YJUL3hndIW/+7UaAXyA0kQ3nCyzd7ufkfMINGOUFO9qnGH6US42146pAE/Pqrza/
 Soyn22v4xzmbQfs+ym1p2ywPLJ0pUL6GjDNZ96gkuzrNCip1HcilFDmU6FkE5gKUF3BvcEOr7QJ
 eVAnDqNTzyxAGvlVaa1UyNC99+y51+6WbMBExPed7Px8NqvobCwTw7Maofmg5RYT1OUWXXLXX6F
 wyxCVd9n5hvWpSvHRIcaYVsaqf1TWG9dT1ZBYE5UUoHqRaYIRpc5ojuPwuLwFsOAXCkx+iJvzP8
 V63eK3dznrruGKEuYAg==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b81bcb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=3ki_b_XlgFUerp_oe5YA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: QclqTNBYsQiNnVEAPa3cpf6bEsx8SpDu
X-Proofpoint-GUID: QclqTNBYsQiNnVEAPa3cpf6bEsx8SpDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160112

On 3/12/26 09:52, Svyatoslav Ryhel wrote:
> Convert max77620 devicetree bindings from TXT to YAML format. This patch
> does not change any functionality; the bindings remain the same. The
> thermal bindings are incorporated into the binding. GPIO controller
> function in MAX77620 has no dedicated node and is folded into the parent
> node itself.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

For the thermal part:

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>
