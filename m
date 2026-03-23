Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79861390217
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262730; cv=none; b=iSl6FGlfMJrp16wm4/09V9+5AniqWPKy8rfJfVpZv4Fy/cMHTb88jL+v5tqY6TLMMG6XMOl+xPXEeMksoXT2jTWjRLw8o8BNv3DKshozckQzCkn6uC1jYJ22A857/SLMveo8VVByjNTC899/rGpqjFoGvDYiZZdY8Z5SwwmHLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262730; c=relaxed/simple;
	bh=bJR3Kdjc1gGye6KW0sXyRoKoFmZCvahO2l+ajWc8zhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPi3E67a00+4DXvZNGgZjY1gr4uxUZB4005cGxEZ7F0cde0Rbgw2inJGK3Naym5rSknzqjA+w+LBi2T6nC6+zcX5qycBa5AvgKGz0j2VWrbo+PSVp95gRJEz9Xft+NANXBtjt5ZoM0DEAcLiOZC7xuUMLs8nkJdgMqFn/w0XosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z69B7kUf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S8LTsdiz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z69B7kUf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S8LTsdiz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NADsrB3539883
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ZjakhbEwfLw9wMFFasNPzd9hrAyej6SVbhyTjALxjo=; b=Z69B7kUfynEEduX5
	9IYnifSRg+Dz29Sb9lwj+PdKV6zxxFWjBK8z3vL8QFviCOo83aL1e/S14fowZOQN
	s9ulyAKEKZ9jw31pyQhXCBDtaElx6EWM/qyGzcGIBYF51wwRviQYA36friTABnhN
	M7GZBL3Eak/88pXzkcPhlfn1VrJ4hA9ocQ0emudIY6611HHqJuTrNkOfflX81MlR
	jQT+v20Th4j+F8h6U9y6RdLETdzWMjT8kaq+fA5iQwCWFro51XWn3AG7mXp96TPM
	3G3PawmF7iyA7U0iypY4aplDsctdj30Vp8ib85Ns6sdqJvnRsoUlSEM4EtT85GyI
	E8Jbpw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k303mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a081737bbso51057196d6.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262727; x=1774867527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZjakhbEwfLw9wMFFasNPzd9hrAyej6SVbhyTjALxjo=;
        b=S8LTsdizo+Ls5rNMYU9aENgQN2rqXETcetHYPgcps8Mpsfrtg7hf+QS7gpDjll8BVr
         TW4a0BrYahCbXjRvE42k0sK4uOYSSKkuVQ4WrFcuWCYcMT6Y5MEwjP4MbdFOAb6QG4eQ
         ueOMO8YPsl/ouQpu4eyI0qTk9ey8mk//8bpe4CShjlbqUYjy7E+9CDAR/cELF3BBGFYJ
         4T1oLrXzY7byglfeHRElLa8uYjzUSNiD5hgkb1eGwuJq0wpOZKNPJ719TTqxsiDSvu3I
         F4jrd1sAOi7r6W2oi38I5HDK4Zs660KS+RHS9usv5Oia5XLdYWkeMcTUgxMrAoUbiiGg
         RmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262727; x=1774867527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZjakhbEwfLw9wMFFasNPzd9hrAyej6SVbhyTjALxjo=;
        b=KJCDuMBPblPKR2GvNYS90uaNwL/oAtd1SPlFkyYAABcJFpNetTL8SX6P7Dqvko3uGP
         lg5dRHXjO4TTRiEgumBFcJWInTg6ZclGjIUW/fUnT+ABmMTX3mzTzLMBZ5KP+H+N9l3y
         141mB7/efhloCIGe9VmbFGHxMGBr1udOrWujpOkFBwyOyJ3LKFNGIgoVVSl0r9XgWWuH
         TGNwytTmPaY28Wh0hpzlVmO1XpOKj5BbtRlKVLRS2P8tNU7/V+4swzXuekxB9qOdvTff
         w6DJtGhMAA9ba6UljjSsnz5wHWmrM0hS+uMbJjqZTuqZyrkiMtRvNLtzlWBrH3hjcL2y
         lx+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmGrmwc7KALAvBnOcbo9Kupw7rsONxWng2dZ9OClSzBDhYn8drlZVnvENEWzwSEELMpkBb7XXWbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45qBAjRUjkvbcoSoVhAZ5NHJ0fbMbUqE6nIPE2Ynq90X2LFIp
	9Zb6l0d2JCb2D8cyvaeABRuN7thFjTwr5+1FQ6sCqUCemPfdPIMP9Aet8NruXPSW2ZuTB9v5uLR
	s0GTWSUN1ZsxPh5cY4fvBZ3/SiyCUCkTmiHy8jTAE2pGnf8WTTDQ8jSHocecoRg==
X-Gm-Gg: ATEYQzxeNy6dFzt9f2cYzmDRs/GnnafeQbKq++L+XZYsKNZ82V/ztq2MxMBVaIPH3pl
	2YK7PJRvzsweVMv+bDUOhwhng62fFaiIUQw+VXdr6PDNQpj3esEo344hREk9rnFlEhAuQiGbkYU
	+4X+oISvbWUseY/97yS2FFtC+jg0inZCyU4+12G4P58uY18yoyNgtdw1IpF5dSP4VkUlTI9lULX
	7BgK31/GpbjWvAGNUMWl4o3ped5vhRoXeVSuVQviXA44ch5/w6J8ErtVaoFicIVZR/F/tVVekfV
	cDxpHUhsQ2ryDBq+OO+0qQ0ONXyt2u5t2mR5JzuNXm4hlMp/E/Qxqpuqrl1WwakdMPeXY21M1Gt
	iLMxxFrw/2TKCYEcwbaFFoI4SoLLtdislac3SPJYiEI6I2ewKbR8HNan1tF9C1+iVNjFh+FzhNR
	j5f7Y=
X-Received: by 2002:ac8:5a04:0:b0:509:219f:8e34 with SMTP id d75a77b69052e-50b37233ff9mr136812391cf.0.1774262726864;
        Mon, 23 Mar 2026 03:45:26 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:509:219f:8e34 with SMTP id d75a77b69052e-50b37233ff9mr136812151cf.0.1774262726318;
        Mon, 23 Mar 2026 03:45:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668d2a4b390sm3567344a12.28.2026.03.23.03.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:45:24 -0700 (PDT)
Message-ID: <b58ae1d0-d4c3-4b30-8bec-295ebf3b9380@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:45:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] interconnect: qcom: msm8974: expand DEFINE_QNODE
 macros
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-8-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-8-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c119c7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KdZTDNEmWR1w-4yzcOIA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfXzxZJeAUVGbJU
 TyIDZ3fbo0BtlUIXDD7YABnASP7NbPmg0sAe0RzoQvWYr8JBbshqkE6ergRabsA0+ER9KnnwAd3
 lhuuuVdWZ3PvKbUcScFE8LVUqZCh79SDOaLdn8Hj/MExg/+t9hiU4GAilSLml2sQnqgP9WDIRy1
 l7H5O+lAfj+Gla4HdtB9O69kXN0g+Gf3kr7cbSpNncJb2WkBQBHQgpJEK6n/S9V9K/xVcTbMv2X
 dJQAWlyOlRU04OIQrgjvL/fa6QsVlJRXJ+XdTYshWnkc32zWYiQb5AMLEXq9V1ixqR3hXYjbgFi
 417cI64q3D2EAIShH4bTZtu/ql65U1TNAqWUQ+3dPMbnProiVS1Yv+6DbMt4QwBJH8wKeDUtWEx
 EnwBq1x9J+3RAiOsdahOQZy/fmBfRYklkablN6W6HvM4ThFqvBARmKx8Gu9tcI4CT4It5lszAZg
 Up6PStS8TKCmzC6oDAg==
X-Proofpoint-GUID: HTI7VW9glqENRhAduoTTzxMr2FOz7rtf
X-Proofpoint-ORIG-GUID: HTI7VW9glqENRhAduoTTzxMr2FOz7rtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> The rest of Qualcomm Interconnect drivers have stopped using
> DEFINE_QNODE long ago for the sake of readability. Stop using it inside
> the msm8974 interconnect driver too.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I'm not checking that by hand..

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
