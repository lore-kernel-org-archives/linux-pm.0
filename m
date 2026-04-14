Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A43806CE
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158821; cv=none; b=ktvqvkW4BoIEYC3MQtMS6dR0K2oe3M/BoR0ofALdedre4m5vQt4MXaHEqqzFrsj+bvbWMzDRzlF3VAbLVAad4j4imkrdBLL2sTLTBbOidPTTNtxhUxfWH2qDx6UquxkhCT2wl4po9+kHd0pHTKKtCsWwEJuBnast844h0rXuefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158821; c=relaxed/simple;
	bh=93oFKmYp7wHHg9yJdPnYfsIe+IsIeNpLTT4yPZpxlT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWVpzK+EVowqNeanLIlUt5lkHHF+mov0NAXY/+fYCs16I6v65Ua6NhLTQBTzxvHRQJ4FONQ2HbivmJ8/zqM/AX4VXHKSAtTrJKx9s8FSrb67JpUsdD5uxOoiEVhNkf+bCi9E8RNq8AYBpSiWoWbH7jKDFBOtQwkK6+A50ux2bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFUxm4fv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OX4apoed; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFUxm4fv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OX4apoed"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6EWBG2387051
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xSJ7w7ShQoBCDAOFgmsszFWHe8vzZHYcqEZOoHSj/Bk=; b=NFUxm4fvSaB6GSkR
	h5jdRBByJeewET/65y3UAbprGwPta4CQ1HvuCFjdGsqyH7mmZFe2/64ZJzyyjZPw
	/0sWMOyqxVrlczZhvwcK4f3rRyCY6AsRjxrRqsPB0SP5ITwgCwOqvbu47SmTpmI7
	sYgLXgnfB8W1urXOHabnqD1SJbcthUHJUIjues3Ie3Hmfl7V3LcpJRmKkjD2hxWC
	WqmPuKa48RuZH8rwXGvcaSd9hGvUilvHbJh2uJS7vGrk47eDb70UNKtgAoa0lDzv
	EA+/iPenYG9MDnfIvC571VKs6VzCIy/nO5OWdItDEZ69wuVMxFHY+SoaoJr2gwCd
	ZOlN8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86w22n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:26:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4bd8e77dso7721131cf.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776158818; x=1776763618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSJ7w7ShQoBCDAOFgmsszFWHe8vzZHYcqEZOoHSj/Bk=;
        b=OX4apoedPl1jnaVl0NJRfVx3IilxuQB4qOi76wBGK87FBzHUrTkKK9AejCOnJaHg9E
         SPVGtt3jfhdTHRtBN0bs4rZtuU3JqYaKws878r9TK3Zh0kz95QK6o+LXaDlF/oOCDaPi
         sxDPkjHLFDhVdMbhs+MB7Tg15C1xji3gctDzJ7vppL+xIa1TUDKbgLFcqerQ2u+R7/jR
         7z0Pe2sPYP0TRriYXndScBxcxvAfOUCPIgbuXHPEE1eQ2Wo3lZ/2trPt8Z7e9wzd7Wvz
         LUtYa5NtxYFHbGS3Q68xXmpcAcHGSooDg2zFvfXZrqSVj8g6H0eAje4JTHv8y0h5Z8B+
         z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158818; x=1776763618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSJ7w7ShQoBCDAOFgmsszFWHe8vzZHYcqEZOoHSj/Bk=;
        b=ILz12sLmW/lwGyTFH8rlddtTHWs9Q+8SVD4lMQmBnkQVQ6nMgotL19mPPnlfOM+G93
         Du8mgM/h/lifN2lVtWhLvYCrC7ojdf4nIJXS4rQMgPwZxSWBpNbjsUF8c4d56cCYj4DX
         g1Dqt2JunhpxylKl8kuXV5E4MO8WAV3C4COjBEZ51DIi0xZrgbcmW0HrbYdotMUTzqii
         yWj/DxGUvYSv7fn+8ovQAQnv69D3amhfecNYd6WqZeEYcSUq7XujuDQD5fbpJttocGv+
         9y1677citHXYew73Nf3p3MR1S1k5asFiWc1Rxg5I5kc40b3MTVVnzj58snVzuDmXIvqQ
         F3Tw==
X-Forwarded-Encrypted: i=1; AFNElJ8/RjcDsvyHLdYELBVUuslIzpkTf80yAiBjhC9MBjW6rncKgBqbwNxidgj3Wnasc+WzNnwnRTa5RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwibD5SD4r/eJkUjm872hsMQ0iQ7tY61yzVsfFnW0Wem/1aUB1q
	GbR37t/9NAwhqfyyM5COpd5EOJ3Q4p5bvlGpabAn2PZRfcEznZTRegmPKcuPJdlGaCUcKhfw2UK
	OY+hf9VcuuyTIAlYlxseRhmw05w48l0PBCUAPRGlcfZWSaXQdnoOKBtFN1P0YZA==
X-Gm-Gg: AeBDiev+Shh3IR9A6K3PleaCc1zHRjKgLR7k+A0Em/DYLqroVkkUvipmmozhYQeOh+3
	+zeRoJcdbJgcYp1UAFiYvmPyzwZ8Nbsgm3t6A0P9qbXv42BVc4CzRXFr3t9RZlxO+bW01ddFfIo
	9d4BK1PI9kx/UJhnGI5KdJOt9PHJsS3QvT3oULvRV/nPoHWkuzZjuZCYJUPd9T++s75/OLZ5NNC
	qbk6L0/KgrZHy5r3cnTocIB24I+bGn3uWAYrM2up+3Zb4Oqw7sN7Hv5IOAtJcVcj5Yf9uMp0LZM
	2QLNERGF4bEmDHN0f4SkBFPedU7csDzrQyXLeJD3H6eGur41YCt9EZjGPDfiC3zcl7w4+9va0ns
	DYU/7ABq6sbVrjNQrlWMctAIP/2X+5cq0TEi1gcn2YzVwQb+6Szwy7d+jwLsh82WJUWJbPUBr6f
	MVkpXicqlJ0S7tew==
X-Received: by 2002:a05:622a:351:b0:50b:5286:f757 with SMTP id d75a77b69052e-50dd5cf408emr165073261cf.4.1776158817709;
        Tue, 14 Apr 2026 02:26:57 -0700 (PDT)
X-Received: by 2002:a05:622a:351:b0:50b:5286:f757 with SMTP id d75a77b69052e-50dd5cf408emr165073061cf.4.1776158817264;
        Tue, 14 Apr 2026 02:26:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6db92792sm371663966b.0.2026.04.14.02.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:26:55 -0700 (PDT)
Message-ID: <a9db0ace-e93c-4d2e-b9fd-b669b0f82d27@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 11:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add RPMh power
 domain for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
 <20260414035909.652992-3-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414035909.652992-3-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wAWAHbpm8qqZFzo4c436fmKHP9l7eO0X
X-Authority-Analysis: v=2.4 cv=HKfz0Itv c=1 sm=1 tr=0 ts=69de0862 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=TW-xpW1wIl9TmZx4k8IA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA4NyBTYWx0ZWRfX2kAL5GAZlAtq
 Z/Uke22oAvpsCYzg7yWiKnaThHYFu4l0q0xsVhwVe1mbONgLLW6sWHKMYlf6aAkfS/pyFRid08u
 2qo/3lviaVrHQOvQhQbHJwt+U5kPELFqfp08hvQ5VALA0n72HiMejIxufJSBg3702XQ0pEE8iyf
 W8RXJa8hr9oPU8dDEHvhFoTWFIgRSvZrQb8tGhKqLSdKT8z1FYAm4lOXFTx/+fW/XyoTSdLSGSU
 ikyW5UnVG60sJZzOuw4GEUrOnbp4uWTVnIRFXRZTqasIHgtKXBPgcLc5saH/Q5fzuzc0SHGt0+s
 wuDDaIvNadQ1tn7kCMtDtwDn+VCA4xC6Yjl/N1hOuRu1Kv8RJOgTYqzqX/KgTHxSTDY4IMeuj7m
 EgblYD9Mnn5Jcjlr4Y6uk0Z2B6SLWCL0Uouzks40riLL7I8NEkz4KEjY7Cvp5JOJOPvw6+kijT4
 9wCReBiCf+MP3crUV6g==
X-Proofpoint-GUID: wAWAHbpm8qqZFzo4c436fmKHP9l7eO0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140087

On 4/14/26 5:59 AM, Shawn Guo wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Document the RPMh power domain for Nord SoC, and add definitions for
> the new power domains present on Nord SoC.
> 
>  - RPMHPD_NSP3: power domain for the 4th NSP subsystem
>  - RPMHPD_GFX1: power domain for the 2nd GFX subsystem
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
