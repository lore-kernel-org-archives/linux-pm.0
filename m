Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F83D6CCE
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993372; cv=none; b=HEVSsfo632zovIQY9GGGkjECb4iN6Oh9wT1PTYySKX1aPSbVxwqbtwW/M0FvSuus1yfN3zAie2Ji4rxheTFSedoXmzwBFKTky33tdPk1GatswY3QH8YLZC5DE1pXGZPGyD5BlaK1yA7mFa+hdJWNTPnZ3tkvCTf7VwAMCPF2+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993372; c=relaxed/simple;
	bh=nB/zMxB9x6TdcDbMP1nhGGG/kEhO7YibS2cx8eu1P00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLdPhtLrxQwniS/c1Z3l6urp8TApSWbfRl43TWdEgzEC9wl0UgoTPph+pLEpnKpoypoYffpwNUPdgzlJPXHSr9qLUgLokO4x+ktjxt/hz0AopeXdcLqR2ofJ0KWXxhEAaZ6BtTwl0x16veUYy1gRQvmtdQABLYCCw0/G3YhAA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLYg0owq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=STRvWzuA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLYg0owq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STRvWzuA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AmYlF3591674
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 11:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8rXPAj7Jv6FwojH8z1SXt4q+
	7Q7RDsm6ISneeiOt8LY=; b=bLYg0owqoLkCpZVkzD69fgd0iuzReoP3MvXXOj4A
	ngjIaj9SuGtBPq3ki56VbaziiIeqZCLhPWvN/hCcOiEIVXA32lk0FcfBTeKFPIsn
	5uX1OrrlYXpptg2qPu0y/cMBKP9N9oqw7E8kc48KSQB/opp8rMq7Sm2rup3FeZuq
	BnSl/DCkX/dAhwZRWUzCa5+mcGdBZHbJUvpTAIrfJcgs+zH4QCSOcDwn6WHQDxF6
	N/yEoLMe5mCeObQcVi5Vi3K13varJ1EmWEdVK+g5wwqftrQ+eiSC2wBEVqVLgOUu
	trYfZz/0/flAJHyyety6hoGwkhkfHLbLzp9JpGkDNkEBEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9j3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 11:56:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so62833885a.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782993369; x=1783598169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rXPAj7Jv6FwojH8z1SXt4q+7Q7RDsm6ISneeiOt8LY=;
        b=STRvWzuAVvdiGKeGaTXHDSTE1OOERUjyLJFIoubjPAE3TKVyaBGaY0lGhSHyTfRkNx
         lLLfvvux7E/cR4JV4GJxqx0zS5kQ7DgwK15d44nt2U/C/s2UJ6MGCbf+g6xK4jlyAjDF
         lZByAZz37kerCI+tiplgKszlVVvISJsrhZ6Z1kSj6XZ88ULAKlbLrI78CwmQIefZPtzL
         B0o0fjsBHuq9BUdVBUJqvHrfVzX0NVWICNF347G9qxmj1mHP020VrZw8ZbYS5IpKJ6xl
         WF9BhiETZVC/izOPnAWDMW98YQ67evY7FNM38J5m6NceiUj9auT/63zIk7PWG/SMSGh2
         uHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993369; x=1783598169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rXPAj7Jv6FwojH8z1SXt4q+7Q7RDsm6ISneeiOt8LY=;
        b=OGMBLt/Ip0hMIu+j52gBNOFVoU6KKUsO1YFptrvuKcVnELU3GM35hlwS/m+V15PH2R
         kq5Xu8lRyD4tNWJgXzV3MT3SohRjkuuw3NvTb6CyS99tcOPSpXL5yHpBHxMaOTO9AvaD
         /huRLP0YMPqAUzTSJF1Jw4/9FgzV1E/GLxbfodoruXtXQNLFUtNt/VOuvOeZxWigCTsR
         O215FCn8IeukX0OK7Jd/vXztyhgLbLFPUbSRObdEKjVAfeBaLnjdR4eeEbkNREP2XR39
         x4P82PVHM+yXB8JDAbkojbd26YOFxat/sMcuA4RBizd2nycA2ke3Cwg2K57DyL2RhrE1
         EkkA==
X-Forwarded-Encrypted: i=1; AFNElJ+NVHeDx8s8tqUTVDzrum6tfAJXC9LNlGHKsJf5X9CdalOPKHjsrjU3nhDwsEThGuaqQ9aGO9SzwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySO8eHnpPerDJGTG5DQYTDkNyQEfrw0F1V5KeaFYL8YaiAJqae
	xcXeqaj+fpnWstYbM/up5AKLs/J2LkOJwKyi2O6edChz5ElRfRfhPaazw24BaWgkkEzFU5mbJ3J
	bhZj0h2K6v7e4DP9E9M9IP/AcOpS1QDAS+sTJYHeva5FT5cYteTR5Aacs+fUz0w==
X-Gm-Gg: AfdE7cnaXPH/i6RC0pVIIIe5T73k/mD1vxbFXD2HAfApxV7Sgn0EAIgpzQ6GWxoZ9UK
	CjZOtqgpmgiYYlZ9aUQZpvtXiNjn3GD+li1puPIZrT0Ton+XuKbw5dNxYm3HMkko5Gchso4idmq
	jfj3O3oWICGfV7fQAZrFAn0kqifTm6aoa9jA43NZZ1+i2tJbnpDoCWVFHUpD9znCO1IXzvEJsZG
	Kak/tBQ/xSu5CGr9zlGWL3u14lIrarj6TvbousTi8LthqHaMNTQ71OQLR5UNixXufs1fdvGmxyQ
	C+FY1+k3/ErG2fsoU/cDRTkJAj6yp5gtbkzQNYDa723UC7KI8dVFUA0YxmMm1MlQeAWxWwue1Hc
	1u4Epy4SGO7i0216LITGIJfD51DqURHhWNqnXFKmeJJ18E8slBvtxclT58L0N2t9tUZ7Wx7lnIz
	JOoHkADhynXxm4X9HOKUsWzKIQ
X-Received: by 2002:a05:620a:2b97:b0:92a:f74f:904 with SMTP id af79cd13be357-92e696af821mr1226286785a.1.1782993369545;
        Thu, 02 Jul 2026 04:56:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2b97:b0:92a:f74f:904 with SMTP id af79cd13be357-92e696af821mr1226283885a.1.1782993369079;
        Thu, 02 Jul 2026 04:56:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89dc064sm613173e87.62.2026.07.02.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:56:08 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:56:06 +0300
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
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Message-ID: <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX/IrVIB/E3AFm
 /R7SpFQtlOave4Jky+0mDZe+IhGPYjhDiQ75widIjso11HG9zoiERQisZ8AV8+Cgi/HgV0fWY0r
 iOyUQmd6llNhBw0Nz22rCKADhd210zuncQe5o/qoEJeTkXYWbhe23Fjz1GyxFkEZev+iJVDrvVR
 saGGIrSXgqDpwpHjM1OC37qgtll3gOf3p0sTpQPL42HQmFPmqZ240XSKVepukB1TlhY7QZg8TR4
 tWkDt3uHw08AfrYFAu+2Yt39eICcJbwAvloTxUFJYm6iJJiMrrRkvtvEM4VNhHaeLji1thirUay
 iI8zp/sDpZDiVJUhJilQUMBlk3mis4omejCTMNnoAXG5nJtPm3hjs3Z1rZU2Ok38FeaKy7/wPKh
 y7gdI0BP+8XjsbbpF5xb9hn9DFHYMGAORkO/FHRrA+mdYIQRhfIylZ4Y4RqHG+a58cC+IxY+fR/
 id5FGIlgIbR493aOjXw==
X-Proofpoint-ORIG-GUID: bWZpaxeC5RJpczuA6Yok6ZsGF1fFd7sI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX6LKpmGI4BSCa
 aDwl0ZciKtWfjp8G7X4dIwI89ObhYATSqQuyYnCaoNl4U1dmLWtBtz5QxYWhqTebE6g1fYyq56t
 SlsqVloWQp8R2qHa912tr/cKaiCQ8is=
X-Proofpoint-GUID: bWZpaxeC5RJpczuA6Yok6ZsGF1fFd7sI
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a4651da cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kGXCqVC9NZuRQAUF07cA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

On Thu, Jul 02, 2026 at 03:20:52PM +0530, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, enable per-board with the appropriate PMIC supply
> connections and calibration variant selection.

This is obvious from the patch itself. Don't repeat patch contents, say
something useful.

> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 +++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 +++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 61 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 26 ++++++++++++
>  4 files changed, 123 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index b112b21b1d79..c9409ab0a3f1 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -16,11 +16,19 @@ / {
>  	aliases {
>  		mmc0 = &sdhc_1;
>  		serial0 = &uart0;
> +		serial1 = &uart8;
>  	};
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	wcn3988-pmu {
> +		vddio-supply = <&pm4125_l7>;
> +		vddxo-supply = <&pm4125_l13>;
> +		vddrf-supply = <&pm4125_l10>;
> +		vddch0-supply = <&pm4125_l22>;
> +	};

Is the WiFI/BT chip a part of common schematics or not? Why do you
define power supplies here, while the chip itself is defined in a common
file?

>  };
>  
>  &remoteproc_cdsp {
> @@ -57,3 +65,13 @@ &sdhc_1 {
>  
>  	status = "okay";
>  };
> +
> +&uart8 {
> +	status = "okay";
> +};

Same question.

> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> index d0c48bad704c..4b7be09eb5a5 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> @@ -3,13 +3,74 @@
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> +/ {
> +	wcn3988-pmu {
> +		compatible = "qcom,wcn3988-pmu";
> +
> +		pinctrl-0 = <&sw_ctrl_default>;
> +		pinctrl-names = "default";
> +
> +		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_io: ldo0 {
> +				regulator-name = "vreg_pmu_io";
> +			};
> +
> +			vreg_pmu_xo: ldo1 {
> +				regulator-name = "vreg_pmu_xo";
> +			};
> +
> +			vreg_pmu_rf: ldo2 {
> +				regulator-name = "vreg_pmu_rf";
> +			};
> +
> +			vreg_pmu_ch0: ldo3 {
> +				regulator-name = "vreg_pmu_ch0";
> +			};
> +
> +			vreg_pmu_ch1: ldo4 {
> +				regulator-name = "vreg_pmu_ch1";
> +			};
> +		};
> +	};
> +};
> +
>  &qupv3_0 {
>  	firmware-name = "qcom/shikra/qupv3fw.elf";
>  
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio88";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
>  
> +&uart8 {
> +	bluetooth {
> +		compatible = "qcom,wcn3988-bt";
> +		max-speed = <3200000>;
> +
> +		vddio-supply = <&vreg_pmu_io>;
> +		vddxo-supply = <&vreg_pmu_xo>;
> +		vddrf-supply = <&vreg_pmu_rf>;
> +		vddch0-supply = <&vreg_pmu_ch0>;
> +	};
> +};
> +
> +&wifi {
> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
> +
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "shikra";
> +};

-- 
With best wishes
Dmitry
