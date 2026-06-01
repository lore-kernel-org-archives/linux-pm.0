Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6F378D82
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317631; cv=none; b=YuPpsq+CugfBZ/rpa3JRMKekIOXdS4WYM65HXiE2lWjjYZcp8RiD71Am6k3TH3WC00do+6aX36ZNjmZ1Zfm3OqIlHOSHjSMOxz9R6ukUUEyIZ6GIpoV+XcZUWryQEIUaAiUt9abEuNa1tp1zEZ0AwDDOeyuyaZpZe/ml1+3bxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317631; c=relaxed/simple;
	bh=+4xvN6jPzRNsEI6bBJ+FxzqSF1/BI4dtW8HSpmcwHwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6cGeuu+rmXk1qL99cYdXgan4CalsRJGJaak+g47FSkXV87ZZNbnbaaBKPHsVqXh6uaZtJgLobpG1udUGhK6WlvYnIAczaNS9nzcehov0zAglxqwJyc3SGPKyx2fcoJOuxETMf1aKaYSkvzUcNjgKwQupQ2Acp+ZN0xqQZPZGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xfkdz/iq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/ISekY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xfkdz/iq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/ISekY7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651AxFNH334638
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 12:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/yD0wV2bl/lxzrc2fW+99SQslSGMVWbU97D32Jk++g=; b=Xfkdz/iqeyD9u/6o
	9+9W8V0cJ15P0IHtSF514Ktkgs/HcqtNEhXKQ5x7GhajXuLtwS2DWmFddDEIl9oG
	qmq9NxnEaAkgmyFo8ZlzjFEKNb/otCtX2aAPiA6tPpIfCUq0AG6ePDOFyyBd7KJs
	yd6c+TojxPThAApHR/e5x0bAPL8VALxekMgB6FNz1EfjM24WCYG7l/vmHRrTbcE+
	Q+linwEYAjK8U+NZTWcNOliXZdqJzggWy4HF2vJPlcXbrs/+/qOP2dvhekL77ORG
	rHEaDVHn0k/h/Q3Yu1VoWj2qOTUAa/wSQZVSZBXG/ggfkW+po2WJizFPuKWf1zvr
	CPrlIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh8tfrdg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 12:40:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423efbfb61so942217b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780317619; x=1780922419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/yD0wV2bl/lxzrc2fW+99SQslSGMVWbU97D32Jk++g=;
        b=P/ISekY7ylZOnr6GZbe5kqHtjXMXPHz5+141bAwpAq3hkqEHjMmu4zeCESASodUiqA
         u0sPkMZY8HiLyhJ9gwPpfPT5oYsFaS5wtgnWR1dTz4S6GxYcbA1VzhY0z6/2VDvoW61j
         d+QoWCcG4oNjKtAOS4qT8splwF2/7Vc1X9vqd2LYbyPnwKSY/68JLutkwQ9R/rnue1ns
         45ATcWeQtzTOrIdOrUgA9p849u0wvRmFGGRNk/b4pwjYe6OkpRxR22FupCPVGe7dXfDk
         yIWxKTbiJJQ/ivdMxjJWnDBrnJALxVMH/BZYABIBzey2JA++r6qmf82nfKS2LK8qxz/d
         JBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317619; x=1780922419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/yD0wV2bl/lxzrc2fW+99SQslSGMVWbU97D32Jk++g=;
        b=Dv+ov9sC5+LMjDAEq5wFDVVSiRDFGO+IaQ6pixJqMyyG/OwTO7uwqDXgvzCmcJ2ICe
         FFwDRBbbO8QByUlNimuiqcuszc+yIZfWqcbDg++e39TdVsNBp8v73+rY/6HaA+QFIcM4
         NW1/tUba6UezMDXwpSHkyCeL56UUNHXoZkcyA6RdMcXgv6dDn/Z5jhmjfBi8swFn0HR7
         jFaZ6mpflU2ShS0xguYt6UHUszXC2FjvLDM78Bv7RfF1PKgzGAVZA9b/9K/xAfhBSnuZ
         7OpYnDHcGqQQWB9OGEFaA9IZWYv0cX1rSxYFsEYPSv+wkjJrgz1gQ7643yYA5EaU092+
         iOQw==
X-Forwarded-Encrypted: i=1; AFNElJ93hXVuujEgsaW+kH3kxx2qJdILz/OoCoARWZLtgCQ0GPAtjIZy3cxneswtOthGf/4U37R2lSGX2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUP9iMX68PS513++uHDOoMbII7UgPdBV4/mVvzGQ5ITMAYaiq
	jZC4sWBOBFf1H349lJjBXz7PRq8fcGPsW7SkHAZAPMUCtnkTNO7FDAf7CqaxjNbB4GshHvB2ByY
	Y6rybkKgHKW8W1xX2DxNnRR/+KD0GEVsyI7yaKf53tDilh29MJs+Xf4HQ8k8MUQ==
X-Gm-Gg: Acq92OGnjpYJjxIJeSYtBsOndXS2ivwJBpiOFfy6p9xjhZVu5R7irgrn9+dNzzTN9tY
	oAjwWrxPwJcH5ORnSJmNBlh+i5xa3r5MrX1lmiVZHaWOQpv1Kl2XOlT9WQ5Usu1MEUZ05phaK/W
	GvwPjYOyiLFcdtM80C3TqOhfg8inJY/E3MCUlAab73diANs1psoN86qH2L/v5upqbFgHisZzz1/
	udFAaYtopGW1WRbBDmjGZzAHjbNM6FtOy4w6aaozv5TujGTDb1mcB/pb5ob4j+TOVeEgd9I3qxC
	EWOs3mFSDuGA6dwCec+jaHB2aukuOuSihAPM+bsxpbn0HYsCiFJUFsOIALXPVFB5aheV6ibMdUY
	mdGrJh78sBnab1a6ml2FZm/tbr4bCUu2ZDkyyaL9sUWE16dIQg9ji5dZR3ZcQ
X-Received: by 2002:a05:6a00:987:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-8422534302fmr10319757b3a.4.1780317619419;
        Mon, 01 Jun 2026 05:40:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:987:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-8422534302fmr10319723b3a.4.1780317618859;
        Mon, 01 Jun 2026 05:40:18 -0700 (PDT)
Received: from [10.219.56.230] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842222e2394sm8411523b3a.2.2026.06.01.05.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:40:18 -0700 (PDT)
Message-ID: <db343bab-c274-437b-8042-3508b85cdc2b@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:10:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] arm64: dts: qcom: Add QUPv3 configuration for
 Shikra
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
 <20260530-shikra-dt-m1-v2-3-6bb581035d13@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-3-6bb581035d13@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yvUvUfcRs0_QqATH0R2srfHVuOKnlBtu
X-Proofpoint-ORIG-GUID: yvUvUfcRs0_QqATH0R2srfHVuOKnlBtu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyNiBTYWx0ZWRfX4pRT8++ff953
 dm96QGYgBmfhE+S6mispCkTaORIXSOluUkqr1PY/E9CEmjrehU2KGM2MPayAhhGeUif5gzBsUy/
 txUv9wIl90R+rcKrqcH/CflvWMQmfkIz5ILgBRQsKzyJFu5xTjNBhGJrdV4CYBl6C3SJ7jNBQWo
 53722a/0+W/4PWqSLbqhadjjdc7A6VqHzEZpxyDpQFlWporu70AzsDwZ5nIYuE/KLK0iSnUKxkl
 E3OupLqJoRtof8j00X5WBeguiAHaVzYFz/OsYuZy6HCOzv2wNfJyL3yMV2ierrpThN22r8UgIwD
 VPD6zmQdvdZfwz2XAvwmQUS0qToZhgB3X2V9eBzJmX0T31h2s3+ZWCs24JpAWymHqFAaBEoBHhM
 z5QZS0132LcRKYa9hiPBypcq2sNrP1M1sAbRvB92wc9o+vR1ACpEo/ql1WmBtQmdAveyCuVz0bY
 Jmk+c+vDAyJejrIWfGA==
X-Authority-Analysis: v=2.4 cv=P4YKQCAu c=1 sm=1 tr=0 ts=6a1d7db4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5iICPckp_3-IrkfDOHUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010126

On 5/30/2026 11:57 PM, Komal Bajaj wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>
>
> Add device tree support for QUPv3 serial engine protocols on Shikra.
> Shikra has 10 QUP serial engines under a single QUP wrapper, all with
> support of GPI DMA engines.
>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/shikra.dtsi | 951 +++++++++++++++++++++++++++++++++++
>   1 file changed, 951 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index a4334d99c1f3..2751b4f89678 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/clock/qcom,rpmcc.h>
>   #include <dt-bindings/clock/qcom,shikra-gcc.h>
>   #include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
>   #include <dt-bindings/interconnect/qcom,rpm-icc.h>
>   #include <dt-bindings/interconnect/qcom,shikra.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -348,6 +349,161 @@ tlmm: pinctrl@500000 {
>   			gpio-ranges = <&tlmm 0 0 165>;
>   			wakeup-parent = <&mpm>;
>   
> +			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
> +				/* SDA, SCL */
> +				pins = "gpio2", "gpio3";
> +				function = "qup0_se0";
> +				drive-strength = <2>;
> +				bias-pull-up;

[...]

>   
> +		gpi_dma0: dma-controller@4a00000 {
> +			compatible = "qcom,shikra-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0x0 0x04a00000 0x0 0x60000>;
> +
> +			interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 512 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 514 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 515 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 516 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 522 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 526 IRQ_TYPE_LEVEL_HIGH>;

Ignore this series.
Missed updating interrupt cells to 4. Will fix this in next revision.

Thanks
Komal

> +
> +			dma-channels = <16>;
> +			dma-channel-mask = <0xff>;
> +			#dma-cells = <3>;
> +

[...]

