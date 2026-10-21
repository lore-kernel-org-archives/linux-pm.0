Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572529;
	b=yOP3UysNwdFsEXU5a5MYLo3yZg4lIUxhCXhpPZDaYuk4xTOFEKdYkW1w9lgWJ/Fxzd9t
	 aoPzKT5DOR9BQpdj1MozA3LLqrijmOV+4lmxhcCxB38AcfuZPlYTOhIjulXazf1exCgYN
	 CTm3Ce1CHj21LIkCmNZqJdTM8aexo5YtHb/LhnvEy6wO4Q3QPcxyVUppb4qL4XUgCt7+P
	 O4Ddb6B2qEH8AIxJr6YouOBNUqO/HH2Ijt7LWVRAhaUFKtRGMjY2lqCY0tcSma7Vqc4W6
	 oNBp0HQy7AXerM/XYoXoXc6038hJmC2f1Y6t71PVPWIiGbTli1gDNoH7aeqRZC4w9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iYQse/yDDEeSHkDsCSzLZpVTju3LUd2J+KjtYalRUN0=;
	b=aAmWY9956TpyenENPAmhVdHktZSOkcqMMvkGSzRPPMEDGwnTZFRl0ATZKm7jmnpqW+Hl
	 YW+yxdwXrw9jSREiDKHHk9KTaPjJQOymUFdyOzWrYw2RibHy7zXmYKw3X1uoKJX2xsqxW
	 9O0b/puMoZg4RM4NOwENa9NtNIDh+GjJzL7F8PZPxNWRqqFFLUJvwnEv/g8H+c1YVOS9/
	 JzvQ/R0p3A6U1CHaKMUYM9Xz2/K48ObYYQsSHvRkbZfPqKP616AYAulphT/GT5EOiz6nr
	 iZZtskotY4CtxwYNE+3u5lYyv88eHWmLrsd2cXbzHCWrT1o9u5YBqZrRWG3gAkozz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ddrk0P7T;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EgnrJ77C;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA99606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA99606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ddrk0P7T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EgnrJ77C
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5irDU3018345
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYQse/yDDEeSHkDsCSzLZpVTju3LUd2J+KjtYalRUN0=; b=ddrk0P7TZCmiBLPd
	dgOH1GZhbZG/Sh4ouG87H4ydMiS0DehQ77U6wTT5iUFQdOUp0JPiXwnz+C+WUrzP
	VEcxjtQ7tqtDkQRhxeaGTiCVnhoKRVqlAAmOPAI6ZBcxQ2pqDKpB82rTkCzbjIJH
	0n2KGXKLVKGZnQlB2ZkLTNJRtZ8m4i36/bBFPf5k1Ho5eu10GH9SGa2BB9ih0Og/
	UoEuL5USjjGQM2aX9L0gI89jPmRyXrXGyowQ6EmJVFe84kCXTu8EC7rXDHCS2mYF
	/hfZO96zHU7sjpY3duqRyLU4is9hXp+aDbMFUEVkFYCq7P7TwwylC8LiZvPNnn8T
	YKOQUQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd3ec3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:48:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cac495d99so9377685a.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792572528; x=1793177328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYQse/yDDEeSHkDsCSzLZpVTju3LUd2J+KjtYalRUN0=;
        b=EgnrJ77CR9xkWKmucfP040B1gEk+BNHIpuydCQmgbn4X6mTL5L1A/Zjm8gQIxJblMX
         3F3DMMgOR+mEuyYYG8FR+3g7WkbeDNk1M3+kLbuA7lQTreJ15FnyqZ7c16tWfgZOERmQ
         eQm3o3LltzGN4/pOAHFtiOcNp614H3VoxqDC9/4aCXVdPxS4hev4E0zOrgKGAfXIK1ge
         JwZUV6gxorTAfwECUPd/HRm3L7bsHtJ7TcBtYrVSl5Kcx8LEawxv6CkqKLdY3job0iX3
         SIho04BvEKlitA1Bm8YV/cG+wN7F6954niZhmY0tNfe5hzntzauw5ZG4hQwbi65a4NbU
         u0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572528; x=1793177328;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iYQse/yDDEeSHkDsCSzLZpVTju3LUd2J+KjtYalRUN0=;
        b=0EMpifN5ogUC9JWZTZsJ6khN1L3Fn/V6dxlYyQSJPeNn0DQh4pFcOiXRwpQfEt2NbY
         Sw1GSdw8qCxUVP1HI+L/Hvvo4L/mL4PB649y4MKAGzSmEyPDVQ6EGn8ICFJl7AQfBysn
         XeYDV27h7nu5vpRNHvTEKkPnIXTfjY+OL1C++5RRiqrQ/Kl11pvqwCLPbEmhqyVtWGwy
         mrhcjCldl9dP0mq34FEAs0byG9FI3YECmeUFyJ9oF27ZyDG0P1YYTYCpuI1jcU7Ea79u
         v2GfwWDeEpz8nCPoq/I0/avTDaADVv+Ae2QM14fZleowKCd4JpldTJH17pT9B5HIyQFZ
         SxAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQFZGAEtoUmG439Xbx56v9HfKRbAf2yYUK32s++ajabvFKTMrLiqDFikuMbRRjD5hLMTtDeps+Nw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvKZW8MQp1hZwaJ8gB8VktiuDZqWCaE+tGU53z4ox7Ld9zMGk9
	+axrmIuUEZfVbYfRuq1YrPw+sGk8EhH2HAjFlPTwyG5G0yVAUJajf8ZZ9iqMxRHbgRpiFidm671
	63f/NOIXaR1ZC8sP04eZdgAikgJfYZXzpEiuXgxlnj5xd+jGUogH1rUFl/M3BQg==
X-Gm-Gg: AYBFou3W6DUGLFXkrXzKp2nyqqn96jx+qmX/XomJgo+brPun00WL5Y+jaF5K17WKY0B
	Ej2LPCqENxp6G1Je5Vju0FSe4yStUdEkA3er9iF0eJgJSU66xGqry9QSELUKMo9lWJm/0AZjG72
	7EqjSnHlPzEFbnmnM0/K2fxvsEbM1lbQxfn6Q/fdFwHKwjUtByQbR7Cu1KwkS2572JtNYW8hnsx
	fvziJDaMQh9rjDH4s5ASDtlxgYRTcjAx+wJ9w9xMebT5O5KdPo4lOj/KgnmcUoBMUTOesEpWXRg
	eM+5qKvYLwPHFzvXeyMczETGkW7Me9RADayhzVfBgZhGqikqUt3bnF2vu0jbOF9hp3xCyJH8GNa
	vIN3XRImYPEKtcEOkkKj7rQ==
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr390413385a.6.1792572527790;
        Wed, 21 Oct 2026 01:48:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr390403185a.6.1792572526007;
        Wed, 21 Oct 2026 01:48:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fd7039sm58003766b.54.2026.10.21.01.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:48:45 -0700 (PDT)
Message-ID: <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:48:43 +0200
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
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXwJ5B9c6TxcoT
 6PGM4kMlmOLb5wGzjBr++fG1w9e+UXAPuVCHfGGYTfzn6gMqkV2cHnsaxBX3EjrnEl1L2wTc+IX
 RWw7q2j7Bqesfe6GcaPXl13BEs9vvCXEM0k5GtClROA4Bi2xoh6R8CDxaQMu3kb4zoy/AJ3qSny
 WeU95LHiwl/aGVGLpetFdu2M5hjAK/dTIA0XwYZiqX06F96vBz/FdWQysS0DdzeRC/SR7LteJpk
 ecMZG5Pa+FhMp6//5TSTOSWRtEoKy7zrBPhLrJQ6On/yakSuGqX+n0CUw493pcG7TcfSeWTwPPh
 zHGm+qgqFIhgpC7BHcPBbbur7nbZMNoTrnBNS5xmI+e7wN/jRgZgBdJjN8fSOn7YJ1NM5FLISaA
 nY6R89vmwPMwVxTyBTyfSQvFlmve7+N6abvY0e3g9yJtB75I/kV9SJ4VKgpCPpwA6PqbS3iwILV
 WmDTYlbmyJKbXiqz5iQ==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad87c70 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=F1JjogKJRsLEfutlwsEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 76NW6OsNcm8vCZTlFpZlhWP7OsKiSXan
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX1i5mftRu2cbR
 a5wmTGRx0aOpQ//XA4/wljd+1vERNit8qODj9v8pEI4roo1tss94ULAdw9iGaprXqjDNvyzHs95
 5M1PAFxaI5qyG4TyQxNBDcrOIal6A5s=
X-Proofpoint-GUID: 76NW6OsNcm8vCZTlFpZlhWP7OsKiSXan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210034

On 10/13/26 2:21 AM, Qianhui Xu wrote:
> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> 
> The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
> instead of an instantaneous measurement: the property getter indexes
> context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
> offset written by the maximum-load path. 

I'm having trouble parsing this.

Is that a description of what happens on the firmware side? What's a
maximum-load updater?

Konrad
