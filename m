Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7073BE644
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454487; cv=none; b=nA1Jg5q53nP7C4/ekpf/RZ22DXIiIBvmh4a1NeK3URkUnQARp6dp756ZFWsi3pevLTqnN9ogkFGXKuvYlXWadOeY+T/Km/u69vY2AZ0dPJX1Oki6LmmRkwreSBPlg4Ta1YZk769zRVnk6eBi5yy0UuHYm3vBNryretTXpLb0wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454487; c=relaxed/simple;
	bh=UD2OhGRoOiRQuRu8hyYHXs+pUDM3OGDO2qM5ioTS5r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXlpI3ZDzp0sJWOPr7O0DSoamC4YU6AjIHI7QI7snBrYI/BKJl2VSPloFi440Id0dDkewKl6i2TE4rjuqqaw6J5OPIeIWeU4R/SPNKGb3ovH/az/VJZk3PnNe3fkpRF+NsM+k/l0hG0TkyL40JsssO7iElpJeNUnDMjrlOoVnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eMao1LGA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aeO0vdxi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eMao1LGA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aeO0vdxi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ptIG1641654
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+VxMDfovcPTHc1i48TzmhGmrYWTJq7vT35UvWMuOzM=; b=eMao1LGAfGVaxmB5
	X9pwAUr5On72I3xyLO+PlNjo+tPH9GDaxkifxY/6ZQNyNTqeQ/gf8PdF3aF+Q95V
	Fe0DB4B8B5wwHcMIBJttov5QHsq8naxUPaWM7tlLcnhrim7kNZKF2oTvIPvwAngr
	RZwzgPpuRe3p57smW9bfS7YlJUscIulxXNRqkXONl1WH6ZriTigbE3KtgRvXCivW
	GtYcEOFfw7HeZ9ocyy3ST/2CKa7xNDLS5RTdAeNPx+OMAK6RmSExXYw2EPt/9s2R
	t0GHEkPhl6MWloE4bF+7e3aXHJ5nCKCtXR2lL0w6GmarIFzE9SLYz3Cx9Y7PCJLY
	2MiPKg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj80t77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:21:25 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f6ee26adbso874698e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777454484; x=1778059284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+VxMDfovcPTHc1i48TzmhGmrYWTJq7vT35UvWMuOzM=;
        b=aeO0vdxigr/A5pzPrMBIvejYeCunIrQReYnfDlrTTH0nYnmPQB+8EobQbjKYKgX54L
         +rTqsy9PSUmFLHq4xfJIJ60QCSPkSrhzcAYYffjLolGtzrpbsl0y9Zh961PQQ7KEfDhe
         yYehtxxxj71l7jJK2vyL0EDAFzPXgaJEg4mD/rrHGXq2wyjdlavqQZ3GKAFz8oNbfFEU
         R6bjleQwLIKWWcHJwrcX5fT96ZGAZxfZ0Xd7gr6VseWNxV1zbjbXZpAg4iFdS5Xoyt47
         TYbu5j2RztFB0VR5ctRd01nTczZ+YSDAMHfVWIeEyQfFrEDdvPUOTx8pfx+3XcIM6vcS
         qKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777454484; x=1778059284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+VxMDfovcPTHc1i48TzmhGmrYWTJq7vT35UvWMuOzM=;
        b=GOUEYadIY/CaFBubEimxJDvAltFPU2fr1imG+JWadQ/AM/cTG/+uxBpEOL/O4wAucg
         e5dT/tqDvoM32J9wu4WkZK23U/4bFPI6PdktNUuvi32KUyd7N819/8YK4PYl57Lebi2C
         zu1npJ6JxdM8ZnDthwGfoUDGW3QB4FmJLpG/gHtoG+LumI4mVlCCLHD9n12x2pQEv8Cw
         HBDAPEt+bRKGbNvum7ZBJfyDetuQKd4SJTd+JOxU1Po6g7YWGUmULllkUFiGcqzjskOx
         yLxCE674sk+XUd+8N2E8EkzFTy/bGikdfmz00zsV0TAwRvWEHYZyNISLWizY6Kw8KC1i
         RhzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nMJPrGDHpRfkrr0c0IkKOA6ZRexI9s7/h1znu0Exsvc2YMPlLs3clq1zc0Pwb6Y+Iy0GOagNLYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzULLGXXDFQcFtaN30cCf+h4DyxXJXm2LklJAl5CnIXJy+fqLyk
	0Ph/N1pPKM28UMXB42im5fyfkWk9aeW7U11erEbvxkpacpMQ0LGSihfYo0qw1NcZN3tdJXjBk1X
	XdP1tvW614Jp1C3nUKd9RQFfiWSaNVkz5yy58zSPWrntKQBCOU8vGB9GaQI0vbQ==
X-Gm-Gg: AeBDievG8OOWLoRLYqwhRB9lwhl1heoFblBytvynYtUgtiL5hoGXuMr6YSK52MEY3Ye
	CuUnLzsnDSh0lDmCo5uz7ap8kJ+uayWKal2tI+avt80BztNTNu6L8k5NV4hK+bPGbRkTihwRL5S
	ZDU++d8tMiDJHMj2BOV9g8WQVbBcaH/rarjrOAtc+hOTFhOGpiSWwN5spzPs51yQx7blvGElcB2
	W/G7ErWLO0KF1w48IYDbna+WG6NY1iZr5rT68C71+90kFVi8b4JlD306e8RYfJRvnuD4gpCrOK5
	9AgFy5uCsu0J7KX23QZELwzXi36jtxNqlbE/ARATvT2bUzhbXwkCeY3vIt1C6d7dwhYGGnh2R3c
	xjYJNSAxfUIXe7f9h13ygPrCCHh9wHcVT//n1S4dyVFzEWk7r/AoOZKUm0h57//NV/d4PRiOSPY
	hyvaY4V6NERLsy7Q==
X-Received: by 2002:a05:6122:2a50:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-573a294c552mr1851423e0c.0.1777454484399;
        Wed, 29 Apr 2026 02:21:24 -0700 (PDT)
X-Received: by 2002:a05:6122:2a50:b0:567:4293:8d38 with SMTP id 71dfb90a1353d-573a294c552mr1851417e0c.0.1777454484002;
        Wed, 29 Apr 2026 02:21:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb98543bf48sm65502366b.41.2026.04.29.02.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:21:23 -0700 (PDT)
Message-ID: <d4962403-4e54-466e-baaa-6bbe28707c5f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: Restrict drivers per ARM/ARM64
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
 <20260428-interconnect-qcom-clean-arm64-v1-2-e6bc3f7832db@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-interconnect-qcom-clean-arm64-v1-2-e6bc3f7832db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ikX_N2vQ-hAy3GCkzj5GnrbM9Aw-EOm7
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1cd95 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pmW9M_d3okJ3YB8kds8A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: ikX_N2vQ-hAy3GCkzj5GnrbM9Aw-EOm7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5MyBTYWx0ZWRfX7kIuvC02K81o
 J0SttPTX/sfWm1BWi9bu7aagh+xng47c0K3eX26es1/Jo5hE96uXz6voLlghwoyJB+g52y2yW0f
 SY1O0ldQiA0BVognW05wXbW6pWvCuL84Bflh9+VVpcN1zw1FqSvtsuS+aFpwW0WBmkqGmabskdK
 jiiYCUgnZe2dIlC1hAHYuzvfd1SnkDnYjP/wCaOfDGfcC3HE7FgE6XTAVkKJBc6PWlAliju7rYA
 +DIj9w6X3Fz0D7rIfOoVdu1iRhPo30uOyi+9bams/wnrcT9qB9T7zdd4og2lrutl34YltECyZ0i
 /+KFgGJWDZbC/EfZTapApXp0uBWedNoXEJBoXvSK0UwIPEGwCDZTfyITwdCGYKRZzv75X5O4go5
 FtJYqbRSV22Dngovm32PXrbBVAk/LK5eeM14U5NWyk1nRl2A4I1YsYhm0t0za2gWiNGS2JCPH6K
 jevQNZpm524Fd2Yx1ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290093

On 4/28/26 7:32 PM, Krzysztof Kozlowski wrote:
> There is no point to allow selecting core SoC drivers like interconnects
> for Qualcomm ARMv7 SoCs when building ARM64 kernel, and vice versa.
> 
> This makes kernel configuration more difficult as many do not remember
> the Qualcomm SoCs model names/numbers and their properties like
> architecture.  No features should be lost because:
> 1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
> 2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
