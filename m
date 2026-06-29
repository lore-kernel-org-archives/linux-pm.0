Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D141931F
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743941; cv=none; b=ugmeV6IRnvlqai7YL0bJov34ja6N0VKBRzpf3wE0E18j/dmaJ3Kju4uJRRO3G+oivfx2TjfgjIRSGvhVwOGEeXKVYGmv6chL8AzvCo/owF3ex4QfTWn1gYGp/DmQctMYvqzCmT7W9tTqpGDcHS9UzgXYyuJWn//pN56JEI3wUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743941; c=relaxed/simple;
	bh=dJ2JTp6OFiB0mDOUeLX87yYQ+VnXucP5xQ/OK7M2m44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVqQwEHD/UkqqSD/VGkLBBV94LFQpKLNB5+68LN6j4sszL2K7oV1mT61cs0YTJTMZsMieogqGaFGHuYJ1vbLgLmpZAisuT3FhnM0bYT1JxIPblth2tD6X8rA2NOHPheisv8gLsiqlxhfJt3Cv0qQgyW5eVUItxp82SdO5zSfvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NS95HeDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ygz/Ex3y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NS95HeDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ygz/Ex3y"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASrW12601136
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=; b=NS95HeDZbikRVR2L
	CDbdAEuKNbD4Bc/z8M8aR3CAtyBF/pWucf/5uTVV0RFapYgsHjzPYc4FQLV1+t88
	/rIEWdm8GIkJ2Q/EXFtwmym8tJ+hGgo48rfkq4W1YDciQn3HpmwsHP5FRQ4O22Ey
	v9JQJARm571mVhShSfQ0RJhYLw2XEUzSsGXd7lSqDm6QPJh02Vm4sXN99yuSTZf8
	JPTIY2eC5ASHR+FcCF9jq5zv7lkIA3/FVqLyqLj8Cx2U6eBtKCxUCTs7H4LFV+Td
	y3Q54UfP040JuLQM0li7HYENa1p1qNVT6gOKNvgi0iZ171F88OJR1awSjGJDR1R4
	McZEKA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw9bc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 14:38:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7392d893428so66672137.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743939; x=1783348739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=;
        b=Ygz/Ex3yySJCXWmnYA4yiIVVdGT7nZDFwQRJeYDzNFR1hM93TtfBimbbn1khwNBGEj
         ML6M5L/W9lG1OiXrkI77CIpNCxmxTzq7u0x2lvkpnRuZRU+181I6O2KYPvXRKOA9x2g8
         EREgT0S4rVBqGEQ0I7B0kFKtkTvo/v8lL9PykOFrvmX0cL/7YaLlZ001otz0dyOeWeV1
         aU4Y6ui2gOSaBotrvBCWnMLWZnOgNlRIdAiFAduSYaCdnVnnys+rGSqva9nTMQ9/2czL
         gax+4c8dCWlx2+k3f62GxXw5bj3qnArxq7PPlp4cg303ohumvCwcMcI0sEB9CtRd0/Ox
         z/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743939; x=1783348739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9F0ZQvdgCZ175pSXQOqitXo6ftMA07Jyq3N/MCBR0A=;
        b=Ct5ano+E8LAr+v/zjgzFXPre75fuJ2zgPyF5emDiWvdxUKAciws2tOIWdzwUXHlxpj
         6kBOLhT4eLyhXKWi1vhwGxS64sWciyTLgyQ0CT3nWF+cq8oTI2TnCwSEvt+RcFdKr53+
         BxnQ0xBe+OZ4he8floVbUIjq5JPqHQsOH/ItEXBHUQ6ifug1PyBBH20hgZN3SdjGm0+w
         GLiUQGP2RB+OYuV4qqrC60SGX713a4QaJ7L7/QI0APhq4PimhnA6qhguQmp6bFZv/5ua
         Cx4KbgEWuCyIbZCWn4TSfVHuX2FJfDWtCDZ+Z8LZ6vcOCOMhHgtuu2r4lEA35aHetD9I
         ZNSg==
X-Forwarded-Encrypted: i=1; AHgh+RrAqSBzuKvcM/2yeLo8a5Eq4X0CiW+roarDopJz6EcvXrcHD4XCPLbQ68wULTSupNczg7tjIVpAlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7I/Gdgv1+d99nMALVGcEOK2PS77Ywsvn+xu4F0C92tMJwvhkw
	QycJ/jgk64LH7AwkgybTu6EnDxL12EgQ1ItVRKlB76zYOyVDCiCD2dGdX94+AdMz4kBxwgN3tJN
	i8X6dDWycQJHRiK4go9o7IIPqjrepqmgM9tBxTHPvxYvMi09UDxxQnmubVEl+B1U0jzuEVw==
X-Gm-Gg: AfdE7cnIhiLVdAw30mGfLwZ34Lg/hrUa06o3RzwArDaWHzkA1Kyy0+oHvY0Dx9hzu97
	Iz4QvDTTT/JR13QjEvBa9nyRngnchy2Ea/pOosxytC5uLuYCP3lLwmCtG4MBUP9T9wOta5Olpbr
	bsASQo64L6gmi9TdPjnzxr/mrq2cR/9ry/TAhIKUpeWkhj2q5IAo8xrvONCpTn03MZ1tZM0Vsa/
	idSTGtX7xvNgCzIKaBJDrzTI/jbAS2l6SPL9y0HP9yz3v8DEvOaL2M7h23ARWRfyZuy0HxOa8n1
	mt5hC3LIpPDoLBICmYh7flrD14pwD2kRYM0wKNfu+PY9ELZDPnJKSccrxwQ2jGobmlCEGhkua67
	hPC7RMBTxfFgO7yFLf5zV5S2MH7PAIVN/RXA=
X-Received: by 2002:a05:6102:1607:b0:739:b6bf:bc9e with SMTP id ada2fe7eead31-739b6bfbe2bmr297197137.3.1782743939042;
        Mon, 29 Jun 2026 07:38:59 -0700 (PDT)
X-Received: by 2002:a05:6102:1607:b0:739:b6bf:bc9e with SMTP id ada2fe7eead31-739b6bfbe2bmr297178137.3.1782743938563;
        Mon, 29 Jun 2026 07:38:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69870eac1f5sm1099403a12.2.2026.06.29.07.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:38:57 -0700 (PDT)
Message-ID: <a0a96e9a-2df0-4576-86a1-95683dcef4f4@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
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
        linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX1J1oQ6h9oi1w
 kzK2sBWFQhb6aSD5hbqNHwkhU6JDaKf6Vr3uajePuSg38/pkl1/ri87qr8VIL7KxoyOos5Jx9x8
 F6Sn0cGNiBdJdHvyj8VP+NJuubv2DsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX7S3RG0tBySoq
 YH3F+HbtXtTr1IVAcaZXKKnFtzvmouDbEoBqvqzOb5y3qUqtZlr2EA/qr2cMb3GYTmqofgc7OKh
 43FCtzJ+Uaxh/AcFzQIJll/XcwqszTV+r9v95MR0eo4Uq9ITgXbv9B3KNqzlCKDpglMPPa7OalT
 vvI9S3UQJV8kGl6WzRj4JRUsySkZ5WK767hWAVZ4a4xplVNA+Am4aoMXcY3FrubuVbT61FisBvr
 Pfp+B4SP50fXgVbgR167d4kZjdfTmTiGSgI1p6tVojq+YQa87v+wMK/Xzh+UUA8SGUTQk5J9em4
 9TdJkI7aZn/H/nKg2uUjWpgrqJnoXS5ikNlMusqMArktBm0JoGU6BsTZAa/HZY6bAP/wiDHZvWQ
 oJyKoF0hrbdXmuxmIwHW13wGg1qjwg7z/Lvsr6j2XJCsDYP+WmfGqaFmfRnhZdroL5VmGkCz9yO
 4cVGO/529Q6wMUZYQPg==
X-Proofpoint-GUID: 2XKWNVNoksYT-NP926jLMM6OwfBbyLFZ
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a428384 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=l7gszL_yuYPfzADJGiwA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 2XKWNVNoksYT-NP926jLMM6OwfBbyLFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 219c904fba29..445dd8bb7269 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -1798,6 +1798,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>  			};
>  		};
>  
> +		remoteproc_mpss: remoteproc@6080000 {
> +			compatible = "qcom,shikra-mpss-pas";
> +			reg = <0x0 0x06080000 0x0 0x100>;

0x10_000

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
