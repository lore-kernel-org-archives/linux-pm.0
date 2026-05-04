Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436430F7F3
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881459; cv=none; b=MLMKp9Afu/e7Yd+7Ggiu4RvTcodG9IVv3/8cJd4VpadSmIvxB85USimjteWsUaZ/0NPE8eYZ/6OWwDUWaZk/oC1P4PRZOQ3jooEruWOe2G725LbuyF48GKIBhya/dvhPYorzlmSzGcsITeZBr6ZJEG8phoaoWuMju5VtnVHXnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881459; c=relaxed/simple;
	bh=fkLkWCk/YI+XHiiAuuLOJYEbpU7XZUki9L8Z6rL/VCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n8N5Woa99/+eL0hYRBNevR5pppNyJhQqL+TQJ/Y7U5eI5gVfTjMgLznhCGuk1sKbv1bksubdWMQHW/rxZ9c23z/Lr9cA5MGJXyfUUG0E90iImrWH9qpRKHP4wvLFIu2yYEViA54hZwmG4Mmv8Np+k0jpyGF5xLZR83SuaLdZ2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FTaxPjdJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDRAUMJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FTaxPjdJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDRAUMJg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DMwk875812
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 07:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+mLJTsfWKJnPQjXHflzAt17SxY6xVFap91s69pWbPts=; b=FTaxPjdJ/s5sluFa
	qb5j6Cform50ydogtObSy3l/ZPaH1bmYehfrKHJjTdHfMYI4x8VJ8ewyqr7DVBnV
	9TbBos0se34DnlndInMYC9fNIqZtMgIZSRzRUui8VMGzLRk+Nicy7OV/EITqw9pT
	DMCTxK9+cZIPa3E6FjxjEfH5/hMR92MTPkZ9rc4P+3/34daxzcJVuSIbY7hopDpr
	f3t/8OBBacaOJiyOHfsjbPry1aay7ASGjc1yLROgt5VZ/+eTHx2oHMzZPFbJesZx
	bV05efRZnl8hEwzhyk5HndCUvNI9I009ItI1ESOowG7BkEIL+bY0MhSS8SGYuLM0
	8lBaXQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwa1emrcv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 07:57:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50f1b94ac9dso16690431cf.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881457; x=1778486257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mLJTsfWKJnPQjXHflzAt17SxY6xVFap91s69pWbPts=;
        b=TDRAUMJgRP1sRHrj5gjmpEEAp+YcMZgw6rj4sp5+v/N/J0ueEYqZrWmlXga9yt7UqF
         YxTnb3CLiqwN6ANbceQvvfvRyA4R+HAwJ/DpnFCQ08polDXZYAZSBWuynygYQcZtbt/c
         EFjgrrmS3NMREeCjzPRDppsrwpV3GCab/LgCTlPLFSdHFK93RNZYYr8i8rspMvqEVVYq
         tB/i0mwFpGWsbmzW2B+JH15N7+OAq0O1l5j79CQX7mEhqr9L33kT1Gcu2ZiPH3F63RRb
         ezEnaeALh4N1hRB5RDWHu06BmhyyfDfGlnfr4CqOd8m49/UYvh0cREsYtYYj05jtTyNj
         yoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881457; x=1778486257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mLJTsfWKJnPQjXHflzAt17SxY6xVFap91s69pWbPts=;
        b=QpgxPM1efAbXLGM+uDyhwYm/1rnt9SsZmtomYU8Azk3NvyKVOAzEJGq/GXoeVa7WnF
         12eyzi9ZpaioZ6dpJgHLpTwfdOe5wkS4LWOSET3JSqF3F/3Hfk0Dh/jzPWFigWHQGXnL
         nNPjbQVzPySTYmWzhyndpCtQZ/m8Q/fzbSOfYIZNwMKnCgXfA++TFvPuOFOHvciqbpTm
         6+EGsBGBvH1UDPohidv5YRAFjZubkg2xmKMvTLS/nzs237hnGBxmUSLN0Rxg1Qf3SZx9
         26yrdeyHitjEagcY8jkn+6ozZWXhhODD82qk2hbo8eUgDrnBkV/4jwVuWQRX0zGhe9OJ
         Cd5A==
X-Forwarded-Encrypted: i=1; AFNElJ8ac4yNsL3NrkBmhrTvGw/bSrkdX7gPKh8ul3wS0YGygjWL6xBSOdOZBQ6h//Z41O4khHVq8PG5Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOh/RiuxdM2tpMobhpo4F3Nj6xlD3WZigJI35r0GMC7kTkJ8rg
	SlIY9IkBaDYwgU1Xy0s+EvCZB/mejULhS6K5Xqwrh1PSy+9/9kNvuF1KQ04rBSSxrRzVKreAffF
	6D0KcnzeafLRaAa/vRlYDykJZILrUyXJ/WchUDkk+H9l1kgP4zLehIIkoa/kHDQ==
X-Gm-Gg: AeBDietBloDf+KvW/3g/aWqOYhqAbp6J3erD+SPyHND8FzmUpgio5N3IbuBNkcw35Hg
	al6vmYrCHBs7YdWigNHUdHpC1Msk6HWYAxIQHAoQZWRSYkKeA0A00bR+5OD9NPjfftI3J5CTTfH
	XTOakykKgHeeFQwhULzGkj+VdiISaZndjMQKdLecnHyjUgPWl2PhXovuO2CwXkXbMCoXVnJUV5i
	HKDIvx91GI0pD7W/Y+IymdDQjE8IeffPQyiC37AKNqpnSw5yAHV9GFa/WBckmUcSYW7/KXfEf/9
	t1/AK0R5XpVE6am8YzbcEicHoZQHhu6hbX2lQDvROPqczkW3Q8t5+i3egt/xuhl+OrjeZHPbAkI
	xhKrA+cB9/gl11p5ibdXGQRoAxRZmgup1On0GajRP0lXDF16f/XzXWS3FegRN6A82ciTBO1a4zz
	QccFVx0K5EfR6h4Q==
X-Received: by 2002:ac8:5f47:0:b0:50e:df3b:80 with SMTP id d75a77b69052e-5104bfad6a0mr92704771cf.8.1777881456751;
        Mon, 04 May 2026 00:57:36 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:50e:df3b:80 with SMTP id d75a77b69052e-5104bfad6a0mr92704531cf.8.1777881456317;
        Mon, 04 May 2026 00:57:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88473402sm3013016a12.29.2026.05.04.00.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:57:35 -0700 (PDT)
Message-ID: <aa237c49-4b41-4d5a-9ce0-79d09b07408a@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:57:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: interconnect: qcom,sm6115: Drop
 incorrect children if:then: block
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260503161653.60785-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260503161653.60785-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260503161653.60785-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _InwjUtER-lxVNBlgZx4naoAImaPRZpa
X-Proofpoint-GUID: _InwjUtER-lxVNBlgZx4naoAImaPRZpa
X-Authority-Analysis: v=2.4 cv=e7U2j6p/ c=1 sm=1 tr=0 ts=69f85171 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xbrUrHjBRW7Kf-CKWG0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NSBTYWx0ZWRfXxPcwMLFNCvFB
 GzhvqIGXVarYlb5b6EyP/ny0QjSDGxk3aDl46+K84wfJnLddz0G4oQYkEd1aFBVgh/CEdJ3Jzge
 jaXsEv6PGBmRWv1rk1FyjV8jWc0cn00bcazXCetldYy3LJrDOxCMZ8/ALxvZ0UN78WHvigiY5ID
 9nFhxZa1cXVMGL8k7M9pOAcOCyblB6CqZGPb4lsnLKGv+jmNIPLcXpGLTzcl1iRrAj0y8YvmncF
 Se0gD134PLSOM9vnzt5bVDwrqta9Xp9O+oYXT1R+A08ET15QXf9zs4kZClJXanS+Pd3qvxqDMob
 33I9aPmY9kIz+dhsKXqhWVfnDD682uQHrLydNBw54PPQJPJETojQoaZFUaGVjUuelm/Z9LJ2C2d
 vbxasCzxi5bU2tYviquYdjRoeiyoXRiH/2dMTZXr2JfiP+lRmTNAzzRahsavKN6ByoHPxTb/NKw
 xqpQczX5iNdkVamOLmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040085

On 5/3/26 6:16 PM, Krzysztof Kozlowski wrote:
> This binding has children, so any if:then: block restricting them,
> cannot be defined in top-level allOf:if:then:properties:, because it
> simply does not match these children.  The block, if it was useful,
> should be defined within patternProperties for the children, however
> since child nodes do not have clocks at all, there is little point in
> disallowing them in the first place.
> 
> Remove completely redundant and ineffective piece of code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Good find, this wasn't obvious

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
