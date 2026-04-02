Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824637F8BC
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113356; cv=none; b=GKqP/MGkp4bJ5tlG+gC4Mcnwl53WnUxXygh57OpUP3O3Bxef9OuzF+tl4AQNel3sqNS8jmhv0NG9k+fnNOqPWH1oEgQ07FhGdaWVrZLT8W++rQeeG1333W0yn2K28dFfPjPOMGO6Wqy3gqygZ26A/TXZCE+WQ6vm4SpmHZpqCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113356; c=relaxed/simple;
	bh=4rAm94zlKv4kDb9SubQDA9pMcstbhof+gbe9hGaK9J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhlwGbVkTAE7xJfpBIlQcuuq7wUDD/Ex+uA3M1m8q07F5cS2Ow2FRF1sEKqxPJ0JtwqhhtXkbCtAIsxC2FZUiZuxZ3HZc/gIQHjEN+1Lo1Cw4tSQ2o1h/ZKY/2rtpcz5iozW1gS+W86PEQo2BFrSF687AP0yKFXGXdDovCsV0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XU1maPiJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUGtgp3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XU1maPiJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUGtgp3z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326nD9d1965355
	for <linux-pm@vger.kernel.org>; Thu, 2 Apr 2026 07:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTSfHPPS0BXnwzEi2mFmREKzWbgzZnCEHY3P+XzFonA=; b=XU1maPiJpQnGKAo5
	BuCccYOSeWC61DcWtoFQJQ1OaVibb/42p+cq0oZsz0bMaV4d6vv5x6uKKDFpfoBe
	1oSS0qGg9U++NWGvg1wbLJl67H5plS8XIUImy6SzlU70GR7Zca1bpEJm9ovzjdAb
	U2UH3X5kwxQKuOYnLz3S0B9GNFq59vLYqgqVXgPogNvKCn5J8k3KYm/RDWAsf2We
	7670AdV+aMHH706ighwkAjR8oLuxF+7auLvdxZqVgVrqAYLCyEvfGmLUE0tWqC/e
	KywjHIzVkUEd9KNQqiHI3VPC6N+KczstLekxh9w3fiqhj1/j8r8IdP3P9e3Z7crn
	YDhSSw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h1qhh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 07:02:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d96923dd2so540132a91.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775113354; x=1775718154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTSfHPPS0BXnwzEi2mFmREKzWbgzZnCEHY3P+XzFonA=;
        b=eUGtgp3zVxzESmlwLqgMwKg28QLsH5QZ5CQ8e3/Y9J0RQp2tlacsoGsDITq5gjH4Ss
         9naSJBO2czJCT2VRlpSX3Kz3BFm7Xubrb8MV+HhbDOA0bRFhnZ6s4PmJGRwynk8SJ5uO
         duF+JjFGtGw2ND0R4Eo0+N/zG1XNfoNOkq/1z2LKS7kw+ICKL/7B9sKeNHwxf9v5JOrt
         zhPpKhbNWj7tBGDQBviVxuxa5XFIrQCgcroMz5SvUyN91kTVMfaq/BFf5xtLrJbliGBv
         k0OP2Wv6kAskN5y/b5NwzMabi8zE4+rDTmCdHfCTxQv1FfWK4L2r1pCdaxK607z7gHvw
         yQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113354; x=1775718154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTSfHPPS0BXnwzEi2mFmREKzWbgzZnCEHY3P+XzFonA=;
        b=L2K4nDWnwfh/Xp1Fhfo8zBX+6cA+PRS1t1AtewD2kFJkapW2X39wjy9TnG6/WkT7a5
         HbsTYa+xchZi5sE5CcAH5ss9Xm2fq0WsH7TlUJNyt63cRVY1u3KB66QCtn17kfX5tpmm
         EfsRd5MDbF7dcrXd277g+KXVyHvvfysFuC5G/3ZhmmnWJ+8hBgg+2lix8LPkfhDCiGuU
         6LF/yJ/hu+Nn3rPVTSEZ/5APOU9es2l6AakWUNT3wKLWFTWnnxTNBcGVLlhooel4WFyV
         KF5ecLkT59/Nh18cAbB8UgvnjJVdCTbS1AYpdMks2Ihr9Krl/nyeFrAjSuHMmQk0lsJC
         RUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUhaexyQm1KEc28Kjpli+Gb/XD5p2sNbgxcAJ+bdrPQVhLJM9/0cwc0FT5Z3DU4/+pEjYVbOyY9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEKkxB4xdSDnXSHmEjHh5rqn+ZNcVEnFxtY0a2e/bhRYD9gEQ
	ny0RT1l3J0xQOQaScvGHVpHPcYBtqiqozM86DHmo6aRQlJZf2KgNhdPltRNM0Hp+lejvGCk7wQV
	lcuE/3BIeW0ljGJYqNMoLfKR+wLJXXu26wcAqRF9OyK73Y6vP0LnYHSnGWUoaWA==
X-Gm-Gg: AeBDievAzm3RiGVgcWvGymW0PghAZbT0as7+gb85OXb+hJVKo5cBg9oXP8Bg0QWF+ev
	O6gnLkD9KDKdb6gmUc9tTSpxiq4zOv5lCmqQHG1AYjnh5HogkkLj3aaiSzmM9PQtzsUt0XRC0XL
	yBOOMcnBr49+mnYSKBV9/jCvF1XhiZQaAwDLAmMK4e+iffru2Ufu/ImFWTxwAkGOUgWJBW7GYD9
	D12vPDKNjofVQPKFlYx1RnlejTQ/HnEqnjzb+cIjVljRW4b4UgbPPEnfgLKomnEeszKXxGDzrTZ
	x2wuUHu4zpwekKlhN+U31aNBhag/iZ0tadEaqw5XA5lXG99TYBt0CMRGMnj6/Msa+RmlSRXRSMw
	Ilz13bREzh9aXBYE21Szvjo2/uuyA5pR7pVK7oAmwhPe/pZd3NA==
X-Received: by 2002:a17:90b:57c6:b0:35d:997c:8ebc with SMTP id 98e67ed59e1d1-35dc6fae436mr5587922a91.19.1775113353842;
        Thu, 02 Apr 2026 00:02:33 -0700 (PDT)
X-Received: by 2002:a17:90b:57c6:b0:35d:997c:8ebc with SMTP id 98e67ed59e1d1-35dc6fae436mr5587895a91.19.1775113353382;
        Thu, 02 Apr 2026 00:02:33 -0700 (PDT)
Received: from [10.217.216.245] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba330dd0sm3580166a91.0.2026.04.02.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 00:02:33 -0700 (PDT)
Message-ID: <720ba567-6763-45d3-9ad2-6acc4c1a6e73@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 12:32:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Hawi
 SoC
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69ce148a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ImS790WZ534UxHvqx5kA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: _rUoBSd_cTIqo-O2RBaCo7eRlNW2Yz72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MSBTYWx0ZWRfX6t+ez/pMaTKD
 LfNUQlx0N+ndxIK6DinP2AC4EQZh2CP3H0GXZlXqcUxM03u3tLghOLXj1kMeF1UBFQqKmzfNIBj
 lo/7ji6lTKSd+9avzopM7uFUj8u0jK2bNPuagkOj7+XbXDktBCisl2v5R2ci/2J8lK4q42FrCl4
 iI30Yi36sJdx30flVRsc8Fgfzt50fFcMW6L2FhZzBRmMST+YkkTxsAX95lUtFJjGniCYcyhDtT9
 S8aJOwtDxqPCdLxAXnbhnjSSRwNZwUG5uLGvWQM++yXmmlEV+QMQM3TfTzg5FOH1Lz05iT5voVp
 qzZ0hxupqHH/G1nduaoBIcQehruo6IhBVNMq9SGEplIvsgoXS2PdJ7k0FiVY2tY1Z8TAe3Rg0pf
 t3RGN09k6vRfE7MGUMiV/KJNrK7eG3qEUkfWjMpAd6S/PI/khyzmExHqACNXDBxjx6WGYuA5JkS
 qx8fM76YMfPNOcJOCpg==
X-Proofpoint-GUID: _rUoBSd_cTIqo-O2RBaCo7eRlNW2Yz72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020061



On 4/1/2026 2:45 PM, Fenglin Wu wrote:
> Add the RPMh power domains required for the Hawi SoC. This includes
> new definitions for domains supplying specific hardware components:
> - DCX: supplies VDD_DISP
> - GBX: supplies VDD_GFX_BX
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 19849703be4a..f5ae2a63765d 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -102,11 +102,21 @@ static struct rpmhpd cx_ao_w_mx_parent = {
>  	.res_name = "cx.lvl",
>  };
>  

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das

