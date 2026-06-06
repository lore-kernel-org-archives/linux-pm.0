Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288E20010A
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749915; cv=none; b=PpMS0ZskeK4yjMshU+kIejz4jKPupJF29fwlV3ao2zOVoDDy47yjzHuHHKlkr967E9wlmhDaJcMwN0FRQ/SIEEolCh9zV8QCy7EmzkRG2/tg3FV58ZIzNqbd6JShwcW80Qs8cqCuVDMJhQmdkyM9vps9CwfFmVnwWDBUMk5/jaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749915; c=relaxed/simple;
	bh=K68tMINi2G3OI0ChZxfuj1urjtUiH+lzOo+T78XmCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRyMw1lzQc9cQk9+5ApF309t+Zc1fLn+bZrmK4lWUQ+XG2+l5TtYJafzPjum/a5aFS29YrFhXwljQhfa4is8U+JCco9Wb08HFxXyRq6LQ9GeNewtPyQurVsxJ+qMhzZjUc7t464yooJceO/5LO/5Pr3yTQhRABSYpjOFXnOCg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnXrRivV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q3wAXqFL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnXrRivV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3wAXqFL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BEMBk1232239
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 12:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k0Zfj0JL9fJm1GBJRF2u8tqA
	CoUoyKzIe8SPekuri94=; b=WnXrRivVOHXfEHyccUS+Zke59A9InMTU5cBoEXqy
	hCK/wfinQmCz8oMHkjHo0PZorfiLoAqk4UCPq2wSbbkIij3afQ8lPXhHuVk6JPLK
	Duu+HK6RamVSIhhoi3RJwVd+0VMif6kSdW7tBTocq/LngXbc6wrZCIMhG+HK3ioe
	GJv/ylBUQOS81ykQuVM/4aPYWw5gpaiFRDSErZ1bb0dL4I1JXsuCjKj0PtDgIfyB
	dofNIvqN495qyWbxWjrXG6BBemvOwq2qBAIqj9H803uUAuboR8Hs0sW0N/YutNr4
	HTrxzROIivJLHOGC/qs1h7jV0Mh/xyu9JEZZteRq0g2lgQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgrugw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 12:45:12 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963907b1ddeso3143160241.2
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749912; x=1781354712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0Zfj0JL9fJm1GBJRF2u8tqACoUoyKzIe8SPekuri94=;
        b=Q3wAXqFLDAPaOO63rcJCRRDCLw2eGji4zmjLj/JMcJ9XUA1Ldv+pksnZhwST7guZmj
         c3RMJis3UjZYLcSYhTAZAGrpsQSyPEQ7mLG05GusAHfbq1xQi92Yc3XctQ3Q7E2Zw8d3
         PBYjmAQKTEn4p1oPjNq2aRYoJxCOHOLySfoPwmv5ve3XoNpTXditzFbjHUD1KfA1typz
         sI9pMApOWFIWMaa388GDM8GbQdDmSfGwqnDELLiT3JGxeyJizgpWobWVo/G2nqoGBYN9
         iVvNTRpSDLitUi8BnQ2ELO8E6Zx/CSncCmvJi6Ll1aJOpoDHR+zGNV8/BU8wRR8pdu06
         838A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749912; x=1781354712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0Zfj0JL9fJm1GBJRF2u8tqACoUoyKzIe8SPekuri94=;
        b=gjF6AX5OrfoIF2nZ32wPJynu4+RGck3IuHxVSxyciHeahXJLNRWaEG2JRz13Wx9jg5
         VVJ6WsX0JVex/66gg+6ONgX2zwCx7jKOam52WsokI43mo1xsaPEefvfmWY6ziKfZsWkH
         9cCOmtZZt4RU4vTrmEBTO3P8bNC3SH5zB979OdAYVfQ57LkWDzbU/++d8/Dz1Obr+S4+
         9Yp7kOWuvrfW60hfeq8t8QThkiqm16hVW3EKcfGq9+UjczZWKyBJYtRKzGsYv0L9qrvm
         M29xBBNe9H6roabhDqj3aP8HjmbydpARGPiIZ61FgRkN70csvp6UgK55ouQ1mMEi3FRm
         LaZg==
X-Forwarded-Encrypted: i=1; AFNElJ9yRk0raLjQo1PuoQ9KoR4SsJPogZtnQDqk9Em3BX5kNJ7FhVWWFc+1DX/YUG+6Kfd8DeaOlfmppg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQqCvT9pxgF25Oax/VK2CXpOAC0ChAwQW12ERZu3Inca/z+7H
	bxK/+Cyku5UaJMS/WDn7P6L2HIBA3efvNek5o4n6aA9uV8ICoD0AISlW0GeEpSMBREo94rqzLRb
	0HX1abibfWxuDa4OWRTHRmh7+/9YXodgxLqHxsec0QW8SV7fZflPCA5GwmK+PpA==
X-Gm-Gg: Acq92OFyXfJV1wAWradU2dncSRv4idojx9wvz2h5agFxZ8IEsbbzuUNFYIszgSIcqN1
	1e8CZ2MWsv7DcEzliDB28I25lpxJezGZNiajZPzFPIr0qBpRXvi1b4jTTCnpxcn/mZAG5/VQCB8
	v/3JkvYxPXfFGtdOPFlHeXgGuHl+olI8gZNeVeQCdDwREDtrGvIjtmF5FZ6gVa7o98VABeF3/ez
	fvzyGYq0mzupq4nZkqOErfg2lIT+sp8X8oChZO/sVroPXxw95HvMbjbvXqsUsKDJl/SNzDdalmP
	QdhluAquYWOwAACQL30EkS2tSOXAbujFsYp62so/SdsJJWjYWyjVxoPVSAbO70ZldMxKJn6Gul+
	3G1yYBdM8oR7C+fHBUsev2dx1mYoKb/x2QZrBXEIr6CGFtG6AmF0ielVZSoZX/bNrGO8buiA+v8
	25w54ZxG9IcPdtH7WLixnCRfC7ykckhsNQfHfYXN6Ta0fLNA==
X-Received: by 2002:a05:6102:390d:b0:62f:3e1d:a55a with SMTP id ada2fe7eead31-6fefc010ba0mr4361681137.2.1780749911838;
        Sat, 06 Jun 2026 05:45:11 -0700 (PDT)
X-Received: by 2002:a05:6102:390d:b0:62f:3e1d:a55a with SMTP id ada2fe7eead31-6fefc010ba0mr4361660137.2.1780749911306;
        Sat, 06 Jun 2026 05:45:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abd6cbe6sm31249471fa.0.2026.06.06.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:45:10 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:45:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Message-ID: <j2l7ijr56b33uru53wiyhjkd66pxusxopr4c7xmztlqfnztha3@xp6ciwnngcv2>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a241658 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ApsqoLzXgo-ls-ZfnbwA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: K1f_A9utkmcSwvB5eFGd9fiQ_5iM8cb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfX9kAgkwxEXNZQ
 iDsEkRV70YcMiBw7ZlrAI4lSqbfR/lEoff+DxwU4CkQKiRNr9C3PybPop4C7sHdvSh3rX5WpeUv
 A/F/rufpl+kHF2KCygq+SmEs5lIK+mift/NzX3DnsREJEsosUnTNNqzljCL3T7vNeLyWePLyuGt
 tYtsPMMzlU03m5uVoox8ccxTkw2EMCDX1Cb4C1alAGrRrhVrU96hkOnH7tgYIjOEa/PU9+CvLJC
 7fU2vOmiuvl1BGThrZzAHATYkWOZWYkzz4rvNeSslcaU9Zp1CCKjYYOGVETt0+qJxo10gKQX19k
 oA7Gl/QFbFEB/HttVQwfxjvgnSta5DKDgkKv1daSz7Lkl1cgzTfTaIwBfCsVog5muhJjkpWfPfJ
 Irg9MgaJskahig7sdgyuZ/SEoU3TKMCsL1oPeGtV1N54hcju5HYLi3bPtGKXxVsCmDVlG8Lh+t1
 Gttk9xewV5FgoTp56aQ==
X-Proofpoint-ORIG-GUID: K1f_A9utkmcSwvB5eFGd9fiQ_5iM8cb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060127

On Mon, Jun 01, 2026 at 06:25:12PM +0530, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> with register space, interrupts, IOMMU configuration and reserved
> memory. The node is kept disabled by default and enabled per-board
> with the appropriate PMIC supply connections and calibration variant
> selection.
> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
>  5 files changed, 223 insertions(+)
> 
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";

firmware-name = "shikra";

> +
> +	status = "okay";
> +};
> +

[...]

> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
> +	qcom,calibration-variant = "Shikra_EVK";

I hope this means that calibration files are common across the boards.

> +	firmware-name = "cq2390";

firmware-name = "shikra";

> +
> +	status = "okay";
> +};


[...]

> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";

firmware-name = "shikra";
> +
> +	status = "okay";
> +};

-- 
With best wishes
Dmitry
