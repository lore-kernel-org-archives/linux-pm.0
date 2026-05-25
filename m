Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A137FF44
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711726; cv=none; b=NRJ5Byu9a1ZsC7Md9FkXEo/29UuEROrQbL6Jlc18yIU2xTRDSXKLd8tJLoKwxrVxJ3U+G8P2mIHSeMf4wyIZf7+Tkn5rNOhjtcLfd7567NK3IC0hwRE4hk6fhkmeGzkov09eZham+MDcEohhx6V6pa7bnq744sOzK+aG0buWl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711726; c=relaxed/simple;
	bh=2btaEAsFIeOo4Dk/9XtErvOk/K+pyuYcCLZyVtuxDsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAXyb/HG5XgyRw36Prl13GGY5NJumeGTJYyli3Hb9+G6KPlmZJZ1iLSUE29s1boFo6DiiQHDumSphO3eDyTLyi9S/rnk4UjfI+bXC6nTr35YD5R3/TFnenzcjbvJvB41NQvTRCLZvGvQ3uQCtoccKZTHgYrF3YDWzGOp7CtBTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4yopz51; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZWtqNJI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4yopz51";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZWtqNJI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9EKNY079206
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zaHC1P6aJTyMS1Le9joMlhJCuWTFxPQ+6C1FAgEu8aM=; b=A4yopz51ba7eIhUh
	+zlCY2Fd3QHnGDMa8jD6QDcyTgmmPXGhjIOPBjQKjbIL0BJI6YC6Qc32NcSIS9KI
	5BZflMKAgN76ePJ/RXH33YWiTh2b6k7xGhkD8EDgVila4miqmHIaqm/BFlVkOJNH
	LGRQHmwNotcy1+cZK5apMXSO6LEuMem43wO6rUsDFgESAdX7DhrHoAQoWsmMzoad
	1FBrdPjlV0rjrxdHEPaSlKW3aGfSD9DYyjwXDn7cBVqHx3OckuxhYh097K1c91d2
	ut9AOnoUN6TdLX9M9J4q0NqJ1ef5AXgVwMh2d1wEoIvdBbNsI/2kyLfkrXyzviI5
	7wR1UQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckma8kc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:22:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb98b09d3so31715721cf.2
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779711723; x=1780316523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaHC1P6aJTyMS1Le9joMlhJCuWTFxPQ+6C1FAgEu8aM=;
        b=jZWtqNJIy0y9UrG/msCNbVjnkLsIvJWR0tF5dW6BqGru+9Xi4gHjXZbxeZAq0+n3Dr
         bjpdqHJWUm30bC0C6nRs958wtAAB9Ho9+wa4ZAcv/lF7Yfu4X/Cg0p7i/+a60hQIiZEp
         p/jObsqxkn9otynVVyUx+PT4c+GyySsulBoe9/QsraVvgMwUy9zb009xlXG0eVdIQ0hf
         R47AwMwCFcUxWqJUCSoNxcscLK89N6ECJ9nZYtYUs4kAx/RkANwsubnRC4Bv5YDFsKpP
         TsSyMB+OSYXB8Y9j5uOQUs1Yi44YaWRTNt4lWaaMbJCpEHR44RQV/guDNHzEC6LcBV9V
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711723; x=1780316523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaHC1P6aJTyMS1Le9joMlhJCuWTFxPQ+6C1FAgEu8aM=;
        b=XuQH0d9Q7yHEWw3HwlbS8xi2BxenP4RZwKgs5vmkYHOYw2lUe/kPhIabtp8XIlB/Dg
         qWIIp1n087LUTX0kHwK10Wz1MjqN7K+tZ4dPKaCVwxK8JDTLEYGbm91Y2tKqQJWTRwsm
         sEBJdIg0MViqT8a51PIWQUyiqtKThThlx94JqfeB9qe9GhKMGJ+jpDEIxYhJGLvGddIp
         CruRIkm6pQb7+Vs0bR0e30d22EfP8WTEFw7vRAEf+bfQk8JhGx1HzOMYzZ942AGJTKYL
         eolsBrbSPWwsJc3Rydrcj2Gz4Dk8+LE1e+CP4tm3QpOMtoo73IYJZaWCxZEYUQd6W5y/
         y9cg==
X-Forwarded-Encrypted: i=1; AFNElJ+rsZqKftqCIbX5hfTWi9xwrM0gf0CS8oX1/UwFTWi2l7UMVZz5xndqyI4a5fOFrgG2UkxLEWQz/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAspim69xGeJlXtUqrNLijUav4lNaeJqNNUI6H7+gBJJ+WtyH6
	iYwQOjvmq7HnkGTd6mWDYeDdSHrMtbCKCet33sgxbWCIuD6xfuYroqBdXvgx+5m95DgVIjsoE0l
	KQjTkwmKIovNN9V7z0d+MC4r+ry2480vwBCCFF+srbe0XelHlIm9DgEwqd4sKWA==
X-Gm-Gg: Acq92OGlqtY+X8uDFTIlH1AQzeNw7Oop9B2s06nBKXgQX0+lKdjn/lxTdIVqWVIit56
	2O5WfXJaeOVDgr+nIyRj4Z79whwiCz7Ubs7Cx+bA2ob/+8H8ESiLcym/nviBrgrDCTeAC2VeEMg
	2ElevhbDjVj7WnT/ryKm0lF5bTfomkrj8ZNMQlm48NaiXbsfeA1kUADtHjpI3tLarrZs/WBLVyp
	ym4SR5SCamhTW146jcr47j9j+wNc812Cjx7GfCXFvh3DtBTT8hMmBjhjBn7dmTuUrCJq2Oe0y7g
	V9Kn17RkzQ86uSFIupNcrnekIukqxggrjkjJ+p63mhGMj6tnyLIrUVT3KXpgY2Y9z6wQPUFoub7
	MEgLbHyeSrWRTx2+MwWauZRw3ZY2/7kxeFhSlm9Ie7jkzgQ==
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-516d43c245emr153486381cf.7.1779711723162;
        Mon, 25 May 2026 05:22:03 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-516d43c245emr153486101cf.7.1779711722779;
        Mon, 25 May 2026 05:22:02 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eced0asm396478166b.39.2026.05.25.05.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 05:22:01 -0700 (PDT)
Message-ID: <73e7ea01-d0d4-4ea2-8157-f2f699d64c4d@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:21:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add EPSS L3 scaling support for
 Shikra SoC
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
 <20260524-shikra_epss_l3-v1-2-b1528a436134@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-shikra_epss_l3-v1-2-b1528a436134@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a143eec cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AL6Zp-OlWJ-5pd4xuMwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 2-KRttX1Y4qDvlmA3okeX4auiWSkgX6Q
X-Proofpoint-GUID: 2-KRttX1Y4qDvlmA3okeX4auiWSkgX6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEyNyBTYWx0ZWRfX9kPS/bJol7R4
 prvYLuiFr//m9j4yl8fXIsF8ki2lH9DAE4nIAXtnPsn+qaJa5qC0qV6Mp+FJg5muOycziEJw9g5
 nr3nnT4d+9FHusm0dd6YOuNVC/UV2MWxupRL5Ru54JWOr/78PZZbHGuokbQNo56RzuG7dyrOKGQ
 xW9ha3GhEfhNQop+cK9rDJYuUs574Nj7HmgyrU1V8maDk7xNMzFUXG9NudLQ19VZGoo8VReshAN
 kGkGUhDryZIUZZwZZDq1f1YbQNIuYiZ6l9rmninOm3Ve3UBslCmerS99j8jvCPaNmTnJbMd89wg
 g98zQUeNxqXYHp24sBLgunqbhklrkCl5BuQqgRKrYXvlnGwoSchkZVeTS3QTpQoFyAur4Usg2ne
 3BHbjkcEpcUDpvZQbFykZYvy+qWDAC77aRfVV5ujvMXxgfkW4wm0Q5pM9wlJxfs8IfFG89kjClA
 sHdsoqaO3CfM6EZH+Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250127

On 5/24/26 8:03 PM, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> Qualcomm Shikra SoC.
> 
> The EPSS L3 block on Shikra SoC is similar to existing Qualcomm EPSS/OSM
> L3 providers, but supports only up to 12 frequency lookup table entries.
> Reading beyond the supported LUT entries can expose incorrect frequencies.
> Add shikra-specific EPSS descriptor shikra_epss_l3_perf_state that reuses
> existing EPSS configuration with appropriate LUT entries limit.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
