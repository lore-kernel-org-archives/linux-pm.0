Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C112390C8D
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405185; cv=none; b=LKwsDsWmZ22230/DX6yeioh0+JQYdP9i9fBP8m2+mpCfDOKMg72QGxeMvnsQCFAk8RfEHgP/4wjOh+tq/2T4K/7b3dXT4DtzdGqz9YrR4GxciXtqHWIdiXenpjYOPZFAOPxuQ5Yq5jBXaXs0Ia4gHQFv5rsPnqMS+VMemxvqhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405185; c=relaxed/simple;
	bh=/llQCS6pGh9dzFZ5T7BDBvUoJgmWYaUQqEjy0LtdONs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPe06eOuFgMAErm5gnqpuvxgTppBCWeJ5F9us11y2DUmIoyrieG7oyxQwjUZTSMT2MMROshxfu+uTHwTjNWFN1vZGXWcYDDDHI84pCc3806n1qFogBVhf8odvFsxbPAS/CP6nZoyTb7jS6obwpoSJqmVVOl8LATZynIyZRoBe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASzfYM21; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MITdsOAM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASzfYM21";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MITdsOAM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAmoAW2389981
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 12:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MauuKByl3R3mgdXO5KE6ixTOvkVLunuz2WZywxaS9PY=; b=ASzfYM21NEeawwfd
	s3SHXxARCk1h0vH9lKY30KzOpzpT6L0RSCR5TwwxSPwvLCprkTGIUyeTD3A9cew1
	YjEui5GcEYU5dorIVGR7pAXQVVwm9Q2MYHNfdmEqv+JRYIx1ibxLopE6MfMeSDW5
	DIjtPAJoyvLCk7BHNCZ0cnxCTyMsRWkXQUiNV5jY+bpvFCdmRWMJhU+mWS/GnTm8
	UDi0Qq8R/9TUhWIc8dzps+XVd5S4jLIUrZGT/Y7ZQvV1EAVFO4KulEu467mtfw28
	tKSh9p2rr45ynAinkw9uSK2r1aZbigMLSSu0WWZuRerCvfxdK7UlW2ScZD4UWyIB
	cI//vw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m89ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 12:33:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090f7cee3eso11851231cf.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773405182; x=1774009982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MauuKByl3R3mgdXO5KE6ixTOvkVLunuz2WZywxaS9PY=;
        b=MITdsOAM7BMtpl8FA04SOBo/5WYh9fWn4bAl2iS+IO5zpA+nztzS5tgc+LZ57CeOJL
         OJTh7u5FZSBdXWVUdnnYDvorWXSRopGu/ZCO0clJXSFFNHeTVqFOeOA/XfXPKFsbv5sC
         NiXS5eOF3sv2iiOMxcMq7AOqoZPon/6JddsTqMD/TkWiqIeiOywIbkqZGm6wJnezogdg
         KZ1w1bmFQzofgWj0blqU1Jvqsw3ZG0V1Iw+5cPQBFjI6OqrQJtogzJb1CiGBHLiafxNE
         OElhtN8s1fwI15y6qCYHlqxcpzVqHetbn0Q8el4/2DFrODxVuTAirLcJPoGVQlisqych
         gazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405182; x=1774009982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MauuKByl3R3mgdXO5KE6ixTOvkVLunuz2WZywxaS9PY=;
        b=m+S6/ymVPi1VL/tpejTYur2c07hL2IzU5eSXpJqswJHD6Hv7MMRo66zfXN1Fcqn/tK
         Hee73i5EoONZbSSmhvBquoGU4m8q+v9+A5z5UXLY+BRSFZ8OUAD5oFNjWm32oC+GuRfj
         LkmBjGxPxcY5jqyt1Q68EJ1uqHJ11E2ByA0TXcIaO9FVtF/NTajYCNtXI8URgVlgDE/C
         cIA5Xm8MsyVOr5sGv7Z/vgOe30gNwZ69kvObdamrvpBVoabISH9KUV/UaT406mblK53K
         S4nwx3+gN3C6NR+fYV5T8qgitOBKtJpEJcrr5ZSxJKwm8C+iruw2nKD8UnR3Zur199B8
         BtAA==
X-Forwarded-Encrypted: i=1; AJvYcCXcSUmQ4vndjjT0Q5g6ZD9jQSqsT6fBZvrTtbEcMpse3msJWxlmPJzftt/8cLQwaYWM9OGVe63cDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvd/fyhp1Dz3usdMfgkc11Xu6G9vxjkXY5qZjG6Q/P8qM6oAAE
	Q39rtG6Vj5v3e2WXefHd8zeG8I5SY8T1uCEiI4OJxpHG3Xc/UuGzGI06svHldnt768gmpav+lAo
	kOZ8EYelnYvBWJECLr6VQPq3dJlVcSv3yNBbIS2LHLpzlpMHbYFesIhaJe3hIhQ==
X-Gm-Gg: ATEYQzw4JQ6BCQpVxMMyVauMCOWfSP87MvfjEie8+QRDt02Fn8acm7x5VcncIAL9Yvf
	21i1u0ed0wNFGfup+4kLXY5qYobEYOyJhSFZvYycmfw/4raRBeMSzKoxNsF85j1pD47SDdsnZ+N
	P1585mn0iVuWYHmXisR87GWpgUu9difqxWaakUC5O2BZqPm2L06k5tPPuBno2sqxBpsefQ6vlpx
	gUYkFlEiEGCtftZZMRrr4YaxdHlfTJMvGpfuX524swgzgn+ns/MphGrZGC4Y8scxJUrDZYVnyKi
	T5mMqtoWbI1x1UwGOH0mXetBTYm4cXwZyZQxAhZifPpxJU5AMGhHCqVa5y8+QqWtiIsF8vHEosG
	me8n73ptl9z22cIX4ehV7zTPeQI/YaAUOpQI3peqvQ620ISuO6G8LNISXjb0G9nQXn1jLSFiYN8
	vIwBc=
X-Received: by 2002:a05:622a:1307:b0:509:38b0:c44b with SMTP id d75a77b69052e-50957df284fmr30142261cf.5.1773405182599;
        Fri, 13 Mar 2026 05:33:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1307:b0:509:38b0:c44b with SMTP id d75a77b69052e-50957df284fmr30141701cf.5.1773405182070;
        Fri, 13 Mar 2026 05:33:02 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cdb6936sm42858266b.37.2026.03.13.05.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:33:01 -0700 (PDT)
Message-ID: <50ba3ee3-061e-42ab-bddc-86be1766cfff@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:32:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: talos: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
 <20260311103548.1823044-4-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260311103548.1823044-4-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w4lddyF8IMbn3nR0nZOqdgBXRsrZxPPq
X-Proofpoint-GUID: w4lddyF8IMbn3nR0nZOqdgBXRsrZxPPq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5OSBTYWx0ZWRfX2SOogXR9vEiq
 gfDJJyuMe7W3c7EstPDCiBqFCjK8Yj+uL+z4/DUAMh472HbcxV4B5UYzWa01NFLyC/pnOMgErbg
 +JMY8H0B5TAbK159V5RV1NmJQcjEzzZV5HLKeitCqFHlbg/qDHN7xc/XJ8QrLs+Znu9L+PJ+uWK
 9MliWAw6z42nds4WMNZ05LxKylDM7tsRAmjFD27ZgPorcACz/edtMSq0j+sZ8O2pT5kdtG2nUuY
 ct1ABW5eVi3a5aWm5KZDsbQ/1Hz8ebeKWpORaKKpZhw4bGJ/dZJpBI8lJhydircThdShBkggbTk
 tS8sU2/noIHNQsHallXV1m+U2zK5jCu4a6gfEyt/UbqYvYuZEoqyi7Z9JrP/54JT4qTr3gnmWXM
 7PBz1b/Mbn02OwyElCST7BkH7bCaV1pPTiVIqzTkNhMDXH5sqKVCOX5+rMd3BJK2ZK/JvskJ6kI
 uAGvCMeg96HFHpgCtFw==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b403ff cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QD8XKuxi8VSVazGx0XQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130099

On 3/11/26 11:35 AM, Odelu Kukatla wrote:
> Add clocks which need to be enabled for configuring QoS on
> talos SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
