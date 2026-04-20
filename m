Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBE3876C0
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676766; cv=none; b=jkCu3U2o/gDuy+jRgE7LGx4ODLOKFuP2NLOxDiXujA29dgopneDF6a6vqp+f6c1ZdAyVJnf47Ny2/uC0Om5Q73QTp3X6gufNYTYOjW5synMYf5PKf7CGNl0oB2HNwIOKuIpRRT0cMwLEgpKIm3vdua4RDv0YGyd+at2GNj6eLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676766; c=relaxed/simple;
	bh=P24EoD5xGnfBeklnl/2IvyFY8qQQprwNDrVurAnpIhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRk91BA6Qaa81kXdOR4xHV+5t+HFZ6Bh8P2w941mRbMy1HqSo9ELyUKEQGaJ3qcWlNcmC6CEvO1QcZhSfN1g7rMjDymrdZLOJulcFUk+4/KmeSvszX7y3XzAz1weL/uKYx7Xrn6UjHT99lPvmn32718Ab2aRXIJBK/5OiIw0Y4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RDFETQzS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C/E611n+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDFETQzS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C/E611n+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97Rv6084489
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 09:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SwwBLlLdW9puTDYK6pG7Oh/PAc0bBf+PodW3Dq7XliM=; b=RDFETQzSXcUq2bv7
	RyThkN5JjMCPrPmRFs+hv8Fj4srbNQ1rRN4AO8432LGQvQCJ3ivfkY6SKvCRMN/1
	V8/jyX1WX7MSALoYRj3YiGN0nryJplTA5hOUUlsRvSoqSV0Z/Epvvf9B9UpHokO2
	o9GaT7+tCgKwhLVFbJZCC8g0rJjbMxDuIrMGGYpuSXBxiJsPzUUrkV0S6H0UZoZ4
	aUh/OwS8fAt6nph1GQ1zKip0XBuwMTIsIBD3NmDH6ggsm9MrwIF1R66F9cbL0vy6
	iedUfJX13DhjFkMW2ji7amhXekLVFHX/CvpTnwp/HYtIJ1BS3q/KBzP+a9yfiZRa
	5ZVZ0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81g1r7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 09:19:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso6282645a91.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676763; x=1777281563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwwBLlLdW9puTDYK6pG7Oh/PAc0bBf+PodW3Dq7XliM=;
        b=C/E611n+IKtYNqzOSAdH6IghtzAzH9azgjlcYZBZJiVF3PYuQW2Q3eFyQ100/bHh2M
         oIOA09BYQbN7NlIR/4M3oUcmDHgnbxFRdVlY0LUTZc4nNImBNbTgdWvr9GEWKolL0cYS
         b7CURaUh7eg0inuOZj9RkK7B0u8oy2YKPMBWe6HMdXT1qZDNebA3HlhnWaJEIgmC/Ai6
         T4p3CB3dBJF3KpewCAEYRFm3VRE9D5OaeopnySqCDuASBcv3c/sKrRBpZPWvwb4I7edZ
         CbLIc0HXjJLtsYI+/62u2ZEaQWIQpnlMxA6Aamr5tDA1lh8Qev3/3cKsIGe26fpwhEY3
         Sg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676763; x=1777281563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwwBLlLdW9puTDYK6pG7Oh/PAc0bBf+PodW3Dq7XliM=;
        b=E/d5zxk5mM9rTYLzhPA080OTFK+Vhj2X5Zp1apWL+6a1zfiLu/JQOTrBmZihY2hIQR
         DgZdZtQbtmpp24uKOlvD5nsdwA1Mv5I3gF9HGQ3y6z+2jgsteVVFxdCFKh1sRf54blHm
         PkLkaugY8RPkivFoqi8sIo8BxBe8cY0tuxBzq70MiGfiGbTC0aWlSZMmKfDiqyUm5P2t
         7b+U0UGB5Uxpy98G1klqCiFT+3yiGvRoId7A4FVipjcEC4uknK8/JkkNLJDwquEzJxvj
         HXlm1FP+K7IBdQY7tov2bomYdGV/EKs9YVz9H9+Fq8LKHuFtxVJ5+EeRuuE8XfSx5850
         0oPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+43AmJQuW/FkguV9EgYWprLpKVLLLDNea0iFqAu6nJvLVqypvvsE3BKcZ+PWqBpCJ8duMwsEL0jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDEIU2zhorJ/0qSHIBowRwtA6q6qPiexCp51AjfACbnj9t1kr
	kafAuuo/kll2lHn84/GC218mzHDDuJCBLE4PoJxaLCwc30oKQNVZwvw1Y8dt7WtEZInCtKUwlon
	YGfYgfiJpIBy/uEyeBzY3OUlFi0e7uvRi7nAEpcVjDhyX6CXgagXXsUggjlqL1g==
X-Gm-Gg: AeBDiev2gKqw1c2iStSMVWZ7V1PCf0hC/4FeZ/ZFWbVVODIh6T5Pc7jDVmEq0dLh0eM
	jCnoGQMArFk72OwO3QNuPQste7lCx7TvHXSjVLKqAtWZmSRU3KQbz8wS+XBXgJqEKWdGZHAbMhh
	Tb7bYzp+Gi3jaNArR2TS0n/6gQOK4eep4JFndtd+ZFD6lo2dsAbDkLeDuJsofiTw6T1FR0ENEbc
	FvmAsl3nFlaMkLxb4EjCtxIGn0XEsZz6FfZ2iiNFwm5grGRVlgOJH0ZuYjZPQF0KN+9Jvy3RGvc
	BRrdGKqXvTjzl/lOc8iVR6gMjIMY19g0xlqmNzwZ5xyHP0FjbcN/NxWj94/Ie7JtAvz+iwzH0En
	8S2a4rCodJ15dYeEuPNS13vYTX3pJubjRPHDr0vrCFectWObKl1ujhEBDMgATtjR+TdjaP5Oanq
	ivoSSCS3I1WAYUM9bIxzHb/u4PJ5EcDHtjYl498UnG01TbiO4=
X-Received: by 2002:a17:90b:5583:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-36140468a44mr13149853a91.15.1776676762931;
        Mon, 20 Apr 2026 02:19:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5583:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-36140468a44mr13149827a91.15.1776676762522;
        Mon, 20 Apr 2026 02:19:22 -0700 (PDT)
Received: from [10.50.10.19] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm12989529a91.2.2026.04.20.02.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:19:22 -0700 (PDT)
Message-ID: <a4f6b7f5-6566-4c73-9c4f-e43c3cafa75a@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 14:49:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4OSBTYWx0ZWRfXxr3YKz8EmQZ0
 XFhMbw64sgGrPfCP6SxOUFaf8eccMDC/5goZ8OZB5tBs3QggCztkZ2G16QyM3yehYyrcHH7ZkOl
 /MsPwFNd/00rOJOmhSUUDpFcPGO3W8lo2A+X6tobvWKkpwPgQlDFq3VJPhp6bYMVTc7mPQGneW5
 b+egEkuO7tCxC9aovx0GajMPiI8butvYNnnAb74BoIeU3AmyLHOazBHpoVwrRgiB8Pc8/Wok9Ta
 rzm22iv7NGKB7r7uemk2oKsBPj3NqXweADjziLkFHYK/CHiRPHmq+/cPq6v00Fako+BXBxqv2Rd
 BViq1XW9M1wP7EA1hDkqm1EiTvuNSL1huDR/v7INdW+PQ1YuhZuSbn/FA0Jtd210V7ufJo72KWv
 S7wc2EI+0P0yDyo7G5EyPd5HA2qPSSIwuN0LGWo6oCojL0fByFRSRLLqmV2Xe9Q4MniIgPQAb8Q
 Ju2pWkGfKayo66tU8tw==
X-Proofpoint-GUID: RhFtVvHb2EqFzWqZpVdvrQ0YdBG5mwyt
X-Proofpoint-ORIG-GUID: RhFtVvHb2EqFzWqZpVdvrQ0YdBG5mwyt
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e5ef9b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mF-kcvSE2y_lSODwij8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200089

On 4/20/2026 12:24 PM, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Add compatible for Temperature Sensor (TSENS) of Nord SoC with
> a fallback on qcom,tsens-v2.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 7d34ba00e684..e65ebc6f1698 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -58,6 +58,7 @@ properties:
>                - qcom,glymur-tsens
>                - qcom,kaanapali-tsens
>                - qcom,milos-tsens
> +              - qcom,nord-tsens
>                - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens

