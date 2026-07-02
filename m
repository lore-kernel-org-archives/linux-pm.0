Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656A3C7E13
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989836; cv=none; b=tYy+eCtgeYMKKDT4/NUzH8Pa9LPzLx7CtEA7iaKnOVv9PYrgprv8PmOspRr40KrydSu6dS2xDsa9Yx3DaBX1KQnN2MHcJ9BJrxjQ0kOofTiO8sB94EwXlOLrdQ1F1OTZK3xMknonrbciQE9usfGrXy7ZU4WqBopD61w6Pg4lz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989836; c=relaxed/simple;
	bh=Ez+V8uwq4c/i2Dw+5MR5FhJDBOScJ2oEbEe6gRFruS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6kJvQcKNjT7jErmlkxbFuFNC0Kcfxlentg+uUQ2A7xkBuqoJ9soWqt3I2lffVL9Jo/LB1DxyV5St8QBmcwkRN3juwanE4xevzc6BbMVQli7ChiV8D0xddfX//MaS2viVyf9JRjzA7q7nPUglIwnrfmgBWUOCpZqocU/WCOPTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njFg64kP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azeM8BV+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njFg64kP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azeM8BV+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AfBkO3592225
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=; b=njFg64kPugC+BVaW
	4eyYIHQCKr+nMWfQntCiodb5M6Aouz4PUuJl/G1hJuRymvbIBvMWaY3O0FlG5WeR
	gitbtwyOQQ7rYrlcQwLlU/6X/HhfVKdmkjkMA6oIfQbLfYA4DBiR1X2ddo+pVeKd
	vuhawQX8vDDu4OlrhZS9x4zaF3hSpQLFsFqUgEVu09Xl5yyN8yDMXO2RNyxJ8pSI
	liqIDkjiwRpJMhJ32KhmXdVQ6Hu68l5L9K91r3hzVjCWHsWtzs9TPKVz9hNd7HP7
	IH1Y1TN+I+4S9+ZwNG1HbfgqJrBp1RyO7qfmVf938FQSM/nIUTOE1Y1cvh+Q0xle
	eOu6Kg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9bj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:57:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21be5bb4so8362401cf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989833; x=1783594633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=;
        b=azeM8BV+JeLn8Ho9UFfUt7DQoWqsXUGN/3UXSa8KA5PXmPFmBu5unIsUFkkQGQK97Y
         oj8tFRWoUU7VIQDsKiGgwr2YuB7n+kBRi7FqQoXmhRzQqU+cdoPLPMHV5vEgN2fPSqj0
         QNpeHPzMkzMyeehk4LeeWJ+0msmmb95dNipMQB8rAD3aUiU0MoqWKZgTD7VA6foraair
         /tHJR47b2EVUGeZpZkkBqFaMAcwIZLmDt8gnil+At7XnOq4uBk8YYwvt70OlPXgZIhoX
         SfAnN+SXmm34kw0374fQi59oNAx54RxfE3OPEbTiRPE/F+DGouQWqLZytDMUSIpv7YhS
         cTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989833; x=1783594633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=;
        b=U1nNWUHpEgXOUrgk+97SD5ELjtvlBlmmZLAGIYgmPK5LMezM6k2iP2rzDENpJt+rJa
         wTKONtd8uEv88zrKIKFKJeCk7tGRd9Z+2FIyy2mWBaKppMZBA6qD2C1Rqq0rOxukIVTS
         h+j8KKBW+5Cz11SB75FbnkaikEtYYcRA47NNdmkkckPh/sw51Wrc2H+KO5Bnh7YF/zl5
         TcOs+/FUMt57HLJC9ThsS1UZT7EqlW2ehGdnFC6u7LcyCVxGcP05faKtWOi1y+yG7WcG
         2wKUZ0N5j44yZMuHRltZIeGti2Wr0cGgJgDYC/X3AXAA4GouqGKXJB7XMJOwmGb50U+n
         U5fg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zquco+qf3ZUkHudfVmizMiUcQ5/yTzhQjWXJMD2+gWJekkncpPgMZzfI7r2gh52Y2BQINw3reQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVt3cNRUbNRe3QiWVT2uzxsFuOMtoYrKkCc/pfBw4iFVnoTTdd
	LED3RCEF+anq68XOY0fY892BXpmjU47qp6Vx3hHrI55aDywOdAK6GK/zxcLirsIAeLWvSUJ74QA
	PwIwabgH+JnzIVmifkDObjICHp25+HJL8HDGYP1JJNVdhaZJ0A7J4/B0V0g9DPg==
X-Gm-Gg: AfdE7cmgCTigo11/xPp6laNRs70pnbpQgdZ1r/pPHL757UbfxjLg9HLYe+/lnTrrZEH
	DGfwq2uydGex3JQcsIyicuQVROAwH1ynXG2Zn24IhzX5xgI7As3REM2GqDn7mOBWlQejQONdfmF
	oCxqsd/4jeV9QyBddK5DbzSwgnMt/ua0TzP/Bf+xmmNlzUsb2wOVDruq0htYi2y26aL7lwIYMtf
	ykRhS/xmtHnao5xybky3vgmmMQhYf2BMF1cL7uyGp7xUkQblSoZR1czT8et1asBoccXgYrqM2ha
	J9Czd/rLyyHEcmAAD0VPSuWg3jj0/P5XMD8+tbR9Oqr8IYfltdz9b/fLNHPcdodtwuaLnxBGru6
	hJ2lfgbWPuJCUXRp0s9ET2G/1Q4biccMrh+Y=
X-Received: by 2002:a05:622a:487:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c268fabd0mr41784231cf.0.1782989833642;
        Thu, 02 Jul 2026 03:57:13 -0700 (PDT)
X-Received: by 2002:a05:622a:487:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c268fabd0mr41784091cf.0.1782989833236;
        Thu, 02 Jul 2026 03:57:13 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628d632sm110467266b.31.2026.07.02.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:57:12 -0700 (PDT)
Message-ID: <ab3d2bbf-2b20-43d9-b940-757450c82ae2@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] arm64: dts: qcom: shikra: add WiFi node support
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX8AW2letqyOcH
 V9wXvlrsJm7TuIlzxYSSAOvvIyarSsbqxfUntVBHhdWI46qZ6BH/rQ/lMdJes676VZyIJ3ClTAP
 kEmc7JI+iQjhMKYr+8iGW665iG5tVcvMQRGwjFzck0mn9gOephKrag5wFX88eav9cfXz6F6NAVN
 lSxNTKiZ+G7fL1s0PjtHqhklkS+C9YEeiLwQ6TyewwY56aUscqixQRIIOGVD7EVqxqfqLrHrvxj
 shoSazvj9LvQwEApQzwhbNITcgxbyQtawwSRMUfLLx7Xb8UD/KdDkk0fYC+J6jEptPdYWK2x8Ba
 M4qMgfhx2bDI0yO8aBcD9aB4ciSBV8rOzY5nxLFP9eqcuvpLlHEaK69ObBMfwW9T7hO1Ri2JuZg
 v8wGpfvB1Kgf6vUmBeAnKo/S0tuxGojPTCoQFruZgDVcBS5hYRUaO/aWfm0sp6/hLhX1Eum5oTL
 REN72UtRtgaQSZN79Mg==
X-Proofpoint-ORIG-GUID: SKX8nxZeH4amxgbr3WSGWicvXTTinbDP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX62PObLsXnrco
 zw5hpCxP077WEWn0zqaRI/gwcuyjUgh4uLrqDQvdui6yxda35lQTAWelmCwGtZqcIkbbR2XTEA6
 lWYG+IUuAI5JkDy0c1S0bZS3XdV74O8=
X-Proofpoint-GUID: SKX8nxZeH4amxgbr3WSGWicvXTTinbDP
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46440a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=NKnFMAUvp7LoSZ-z84cA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Introduce the WiFi hardware description in shikra.dtsi, including
> register space, interrupts, IOMMU configuration and reserved memory.
> The node is kept disabled by default and is intended to be enabled
> by board-specific device trees.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
