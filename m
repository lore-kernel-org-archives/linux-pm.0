Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BD258EE9
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410834; cv=none; b=RAdai/HfYGVrpUazej40RuBjT9Z+3txWWPDL1GtO8ezOFM59SnaDSgx98ts88L3+FRqhLEuMVUKIdn4iNUsvdweRvc74BcAJJ/RFXMk5PK9vKZcwBBbrBBFr0l7ANn6yCfLR9cI32NFropjDJJIyu2464lvyyTM8OkBtwGvFjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410834; c=relaxed/simple;
	bh=AWf85eb0QSlNzPYv6q9u9yu7zgX3NsAuerHIMogSPss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JARW8RzH7zaPe3+NSRSxVpN+KWSqbJozXadrWdtlMTh4YEWn81NyVHUGeSHAFJe0EdSzfNolSipu6MAl2V73Ms1wJ3hXNn1S95qgfzhBzrNFg5GzSYI6XnRENbmr7T8GknXoxuzSLSN9cdNBkFRL6NVsUoo+P+JkpJ9cAnF/ZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pVJ8svju; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G9EJu9LR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVJ8svju";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G9EJu9LR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMqOkY3308011
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D3tYf2/eAHtuLEuWcy+mnZoU
	EmmYpGL4tMPGvZeJPwc=; b=pVJ8svjuSIBbeK1mCVHUpSsiADJzr+9msgjI12Cm
	Vldcpbwq7Rr32+MNDn4X08pE6IrTM3G3qqUPPqYNJyAGEV2IbDnXXH/OfArvqII8
	ZBWT1xWQmSODI+QDx8m9GERASzGCqe9diy/1Am3J5XXPsOnhKVfvpo30c116F+Zy
	T9OWkCYWNOa/5yXy8jQT6+/gUJrbn/ZMurN0VRSlmlipBI7NJNweIwP1fkIxZMGV
	aTaic+kZZ5VFM+hno2T1ruklfQeNjfo3m76RcTaDE5nsgG4tApJtuT0MdEN46RMf
	r6vWyquYFVLhqyTzzRfFXQnqXzmfeS2HVBhHI7ijgSK2/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfsngf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:13:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1b4d961dso4948031cf.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786410826; x=1787015626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3tYf2/eAHtuLEuWcy+mnZoUEmmYpGL4tMPGvZeJPwc=;
        b=G9EJu9LRrTWmME/kwHAcyb1Whaz5gtzLiUty++XDKE23G9+UTgTvhWzUtWwv6hDsiq
         hHaG+igJqGdQysPrNzZvgCwZcXMplCc61mPSwQtiuDNf4T2YX0CzQdq5v6rmSqtrNWyd
         6Mc/e3gUnUA/UyiMaNVBseFy1MHzol8Us1GL2x/vNnRzOumkRNmRVacJZA1fVt73/Bis
         Uqd1LuekiJvJJu2Prn38hAlGFMBkNXvh3a4EZccYnGoZkGY2RSqbh86f71Hr2fWWdALC
         UAlmyfrbnhLulPfQHNlwNH4J42z8dwBHIBYIXtuyqjwZgE625qW8W8CsWS9PoKWcqozu
         zl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786410826; x=1787015626;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3tYf2/eAHtuLEuWcy+mnZoUEmmYpGL4tMPGvZeJPwc=;
        b=dOaN3gvpZnznE4J0J9qzpVumRdrtETx5YXdmOPmzIaaNvtw6SV17wI4ig0n7T3xiIF
         UgTiKXTFTkN+L5TLqwjCut95tXG+jiQHIH3XCurghoeEAXnRpoFTnfWaXjdam7PHgGgI
         D7cr0ImoInIkohf1X7BGifnscVImkCszr+PRDzLUWIxX4g7ISrvq+aPUlqwJ9+pMg/uO
         DJ7CtGIIocif96/V7WYZwemTdl4HOJ0HxPy+GiW8wWLosjo2y3w3+1sUOh/WgqyRzqmI
         BnF/shG6AJY0Mvbk0KYjwQOdu60Jhu7FmWPuwa03bNOeq808sTy6iFMMHTKXuYjUmhrz
         kdzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcTexAU2vggfqqFYSTGA2pG1w8NIa0ORSNgRLcT6Q57mfnlg+vhlPpbMg6aAPG24GHHIjLKhVPGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdRaV9zuBg6vR35CD9pwZF++C4tZ/L0ChiLNh3J7q5/NUNuyQ
	yx3RuL+J40vGciDUM9SAh3ULL5XiCishbsJFrkkPrrFS5KeDm5Ix31QWe5+BY+w2ePtfiYH4Eao
	cgf2XZsuvEyTGnPFSTAjZtQlsHGz6B6zJR+6vrsTT0uSMNv+nCPQ48tUENCm8wg==
X-Gm-Gg: AR+sD107vF3csgy71ZsfN5PKFUm+0ebHyz/imhQFS7bCalzihyLQFUIu5zPTUCC7wqB
	rGgsmy7bAGY+4MHjrSVObupDcPGyBr5/8+9ws3Z32ZkDT1jUeFbGHGXXVWUL6vU7CJUd8GfhiVx
	X9S6xncgbSHP6TwfXXvaIGNA9ZnDb8RTjg0ICj8uNPH0QOeLjYx4VGvgsZdAN9JS4Of3lkwdcoy
	QaKi0580Bd+8MeLS2vsl95GhKPyyG6M3VdwWLzJ8Mv9g7N9L0tY2gQTly04AghORZ8TpkyAtd2x
	kJ3mXDFvIK1a8pXjaNRrv+5h/MVVNO3+a311SfxzlkBAkPXDuX8LYbEzphhUoHytP58rn3Ho1QQ
	w5oRwu17xE4JFQEgPiZQyuqQEaHB+nC4QFkzpq4cqtQnIy8bL08b/V9uj5DniGwzm7nM6tel7h9
	za5noH7eCczxAHfw==
X-Received: by 2002:a05:622a:1188:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52d513ed4f2mr24907361cf.9.1786410825561;
        Mon, 10 Aug 2026 18:13:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1188:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52d513ed4f2mr24906831cf.9.1786410825039;
        Mon, 10 Aug 2026 18:13:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b304fd26b6sm2383277e87.10.2026.08.10.18.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:13:42 -0700 (PDT)
Date: Tue, 11 Aug 2026 04:13:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
Message-ID: <wjzyvt7q4vpirxclbwexrhsmcoi23hmsqbjjpfto26ofci23t7@uufz7ilar4qk>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CWfGrXx9soCVnBwCKsncy8sK8SRyD0w2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNyBTYWx0ZWRfXxaszJo7X/Ml4
 HE0WlB9EB/6YJ/dRCTtdbqOFOdgf9q1kkrzoyRJxV5Nr+ev6XoYPS3h1bT9tRuVbtTj+rfNurWM
 0Brme4O2CBbda/Cakppy2QRQvbBAYdU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNyBTYWx0ZWRfX+zl2WIf6/XZy
 ouqyN1pfgXicf6RQX8FA7LqR4SXq/HyX7UrRstN0FHSnDT3EhiFbAvc3IuOLbcrVi7v+3VKo5i9
 H9cnDieoKVaEWd5BLH039LB6a6KTbQZhZSVW3gwBi0HaCQ24zO065ipbm9MvKmaT8Z/wPFnUgpz
 4QPPpNZdGf3/6WL2o6PdVGu3YM4hGqRZfIQFEsOrtzgInI9ZUgJDnz+RE12eWAkUJ60DVCRFbId
 +kE0CwNp3Uj++6LgswdaeO/ee/Aib/h24jn/sCLO3/D6X2M6P/PzzEAkkKBr4MGtAAHQUWo2+xl
 Bub+RyPcMTudS5GALhoQljz135xNa9nSeH5OL7/Z510cMBNNrnjqcRkpN+pH4MwkRvsXFpuK6OG
 7NpDylP6U03fe9NgqPGTIcOCdUAeQwnHfT053e2YsfHzv2JHWRr3O3ABQ3qbpT/oziQMPjkRBpe
 +32t2fuoQSMEdzCq/Vw==
X-Proofpoint-GUID: CWfGrXx9soCVnBwCKsncy8sK8SRyD0w2
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7a774f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=rgZLYYEoq7CJKua39D8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110007

On Sun, Aug 09, 2026 at 12:57:14PM +0530, Hardeep Sharma wrote:
> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
> 
> Peripherals included in this initial set:
>   - Single Cortex-A7 CPU with PSCI idle states
>   - RPMh RSC with clock controller, power domains, and BCM voter
>   - GCC (Global Clock Controller)
>   - TLMM pin controller (110 GPIOs)
>   - Interconnect (aggre-noc, cnoc-main)
>   - GENI UART console (QUP SE3)
>   - SMEM, hardware spinlocks (TCSR mutex)

This is pretty limited without any storage. Does it NAND?

> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  arch/arm/boot/dts/qcom/Makefile          |   1 +
>  arch/arm/boot/dts/qcom/qcom-kuno-idp.dts |  25 ++
>  arch/arm/boot/dts/qcom/qcom-kuno.dtsi    | 423 +++++++++++++++++++++++++++++++
>  3 files changed, 449 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 026d5b682b2b..7327a7b8180e 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-ipq8064-rb3011.dtb \
> +	qcom-kuno-idp.dtb \
>  	qcom-msm8226-microsoft-dempsey.dtb \
>  	qcom-msm8226-microsoft-makepeace.dtb \
>  	qcom-msm8226-microsoft-moneypenny.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts b/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts
> new file mode 100644
> index 000000000000..c2f6650d3fe6
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-kuno.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Kuno IDP";
> +	compatible = "qcom,kuno-idp", "qcom,kuno";
> +
> +	aliases {
> +		serial0 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/qcom/qcom-kuno.dtsi b/arch/arm/boot/dts/qcom/qcom-kuno.dtsi
> new file mode 100644
> index 000000000000..073dda34e188
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-kuno.dtsi
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dt-bindings/clock/qcom,kuno-gcc.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom,rpmhpd.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&intc>;
> +
> +	pcie_phy: clock-100000000 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <100000000>;
> +		#clock-cells = <0>;
> +	};

Is it not provided by the PHY?

> +
> +	sleep_clk: clock-32000 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	xo_board: clock-38400000 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <38400000>;
> +		#clock-cells = <0>;
> +	};

Move them to /clocks/, rename nodes to xo-board and sleep-clk.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&little_cpu_sleep_0>, <&little_cpu_sleep_1>;
> +			power-domains = <&cpu_pd0>;
> +			power-domain-names = "psci";
> +		};
> +	};
> +
> +	domain-idle-states {
> +		cluster_sleep_0: cluster-sleep-0 {
> +			compatible = "domain-idle-state";
> +			idle-state-name = "cx-min";
> +			entry-latency-us = <750>;
> +			exit-latency-us = <2350>;
> +			min-residency-us = <9144>;
> +			arm,psci-suspend-param = <0x40000008>;

Non-OSI?

> +		};
> +	};

Should be a part of the cpu node.

> +
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-kuno", "qcom,scm";
> +		};
> +	};
> +
> +	idle-states {

Move to /cpu/

> +		entry-method = "psci";
> +
> +		little_cpu_sleep_0: cpu-sleep-0 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "standalone-pc";
> +			entry-latency-us = <350>;
> +			exit-latency-us = <450>;
> +			min-residency-us = <1774>;
> +			arm,psci-suspend-param = <0x40000003>;
> +			local-timer-stop;
> +		};
> +
> +		little_cpu_sleep_1: cpu-sleep-1 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "pc";
> +			entry-latency-us = <550>;
> +			exit-latency-us = <750>;
> +			min-residency-us = <6700>;
> +			arm,psci-suspend-param = <0x40000004>;
> +			local-timer-stop;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +
> +		cpu_pd0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&cluster_pd>;
> +		};
> +
> +		cluster_pd: power-domain-cluster {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cluster_sleep_0>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		quickboot@82100000 {
> +			reg = <0x82100000 0x100000>;
> +			no-map;
> +		};
> +
> +		aop-image@82200000 {
> +			reg = <0x82200000 0x20000>;
> +			no-map;
> +		};
> +
> +		aop-cmd-db@82220000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x82220000 0x20000>;
> +			no-map;
> +		};
> +
> +		aop-config@82240000 {
> +			reg = <0x82240000 0x20000>;
> +			no-map;
> +		};
> +
> +		uefi-log@82260000 {
> +			reg = <0x82260000 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa-fw@82270000 {
> +			reg = <0x82270000 0x10000>;
> +			no-map;
> +		};
> +
> +		smem@82280000 {
> +			compatible = "qcom,smem";
> +			reg = <0x82280000 0xc0000>;
> +			hwlocks = <&tcsr_mutex 3>;
> +			no-map;
> +		};
> +
> +		tme-crashdump@82340000 {
> +			reg = <0x82340000 0x40000>;
> +			no-map;
> +		};
> +
> +		tme-log@82380000 {
> +			reg = <0x82380000 0x4000>;
> +			no-map;
> +		};
> +
> +		access-control-db@82384000 {
> +			reg = <0x82384000 0x40000>;
> +			no-map;
> +		};
> +
> +		secdata@823c4000 {
> +			reg = <0x823c4000 0x1000>;
> +			no-map;
> +		};
> +
> +		modem-efs@823c5000 {
> +			reg = <0x823c5000 0x10000>;
> +			no-map;
> +		};

Modem memory, but no MSS power domain?

> +
> +		cpucp-fw@82400000 {
> +			reg = <0x82400000 0x80000>;
> +			no-map;
> +		};
> +

-- 
With best wishes
Dmitry
