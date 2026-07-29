Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA924D90DE
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336547; cv=none; b=CDxbAgaFaIRpaTALaehDViR0RXosCirl5Sejl+csR2JzvnMyEuWNXxSFHmB8VpO+D0x+7nkXW9hK+cIG5Sv5HLXg/yUymvy/GwlcrT5sHH+dku/lzmGMBwe/v4nyl5xbDa83YSCPYF0/59zKja/RSoRHj9+TZ0rQLRYi4jKF/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336547; c=relaxed/simple;
	bh=8YiMtSuh4BfBK3qYh405vLQxKxkhfI7wwld/xuAucUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0IcxCKk363QvGSsxNk10tUcC9nNhsMn7LR0FfokqluHClqb8LJje2y8vkGOxoysmXtnATl9W0ZcMcwfu8cmfhkCNVWnnDD+BBMyN3rvzDuyPHoKLRrWjIxGDmda1T6ZcjLYm3cLf5Ro1OEQU4FBV1daE1akQBxwc/pd+Wmx/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nTeXqDk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J2ndEmqA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTeXqDk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2ndEmqA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEMakS2298596
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60s6D5MtCz4cooqulyMlBVX9wvH1KukN9e/LaVTeXNM=; b=nTeXqDk5DwKLahHu
	aAngEKFotqIWsgcFGO/qbHMP2DdQ7FYED2zKN1mNOkXCpj+wMynpXjMqt5746Z1D
	BkuJ1OFXEtU+6Yqj3KCYgFghh2Sx41jM+AlHcjECvjw+2yZVqKdKadUNiUC3u+Hu
	0maf4KADalwphLuS2WRjscnuQUEI7RCSqzdnE3jUamykuSHrQx4lGl5qPDL9OQMQ
	6DePLF+Bvpx9RM6UK87+mf7ANnRcU67OtsgCxYhkHob4NsvJzlbKjnUkMaej8/BW
	t1zEwqs9IfIj927OXYyZ0dphU4G8mk0hBRiYdfhs9OfYE5D41TzH2iG9gp8Yf/F6
	QX250Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr68ut3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:49:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so1682637a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785336543; x=1785941343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60s6D5MtCz4cooqulyMlBVX9wvH1KukN9e/LaVTeXNM=;
        b=J2ndEmqA+fkgUekLDr6ZeGeZ+A1+7kIDUfplNdOyXotuPaG9vHL8JxjwKNP1mzalYC
         HgXOWXI9Yr21WrPe5O6zEUx1bdylI1PokRObxQfxPyHnrEaONaHPY2X1goGGl1tNu6k3
         wTL535td+bwPC1ASYmdBGkehssGA80hscYS4Mp+FhBIcbkxnIIqw7Ny7ANjp96ejLVgS
         ruCAZhSXYyjEgkujUS4Q+elUFt3OKfDkFP/2tZ5OMucbH9VHljlmslVaRKkix2WOjjP+
         myz+B7Pxx+XK0YOMj8m0tMznquBUVE75GhXrcLjGjcR2DmMKyDrjU665CLl8v/tTPv/s
         1Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336543; x=1785941343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60s6D5MtCz4cooqulyMlBVX9wvH1KukN9e/LaVTeXNM=;
        b=nxACIR0qJ/J4qbU8j1rPYzWaAMX//tel2NSGxBN96TWznSd+UauF3P//5c5DpJJ54E
         TK69hppLyXG+zHN/nIlrbVG+VGMxv5+/ajCNacx+26T2E+iPqGyLXVyQ26mDrO8uYmF3
         O7UcNp1hAZN+yPu3I9GBSedFTt/p54l3TF2dxBvIQ0nzX/xMAF0ilpXRVuNbH3Aa4QGY
         R2TiMYtjyiA5LDSOy3G3h3aXm+M5RB0IK4QrtEB77WnNfEqjueY5TQiKAemq5+DdDq4A
         kE90RH+NC7VKA2Uhr58IKh51MgGcErnwjOxiXQQ8PWG2c4BkkGA0aDxlvZBfJdYJMQXH
         kYTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLeuKZKnKeVCtEHf3HxrqozYmaXYlGKmFuX0aPkByIPuvBr3QhEqYX2VaAbPj78MnpNBnjYNWaug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iNmDOe0aHTVugRh+YzvmXW/lGOxRFwIubnE44jA/D/JZzCVJ
	KRXEF7uFJNwAfcAr/M0SlCnOI+mXezmlaytZIEN9fwRUrzriCThDa+899GA3RPfia5cq2dT6yFm
	QCpIGA1RanFvWqGt7TlLrebMO9KVTlDY/b0Upv/W1h8AIPZJ6dsQddgx/SOmenA==
X-Gm-Gg: AR+sD11w+kVIW8NKRcpyqXXeR8ohK82LbcvLmhhbES5VJrjybIBluUtPysV+i9slchj
	w6NRy/SJx60ePV9lEGObWcedtztL1xnn5OCgOMNonkfO3kDLCRMq96XnXMHZkcNDbGOdFJQYOst
	QPQjTbpFC+FIOwtVZmqZzMUb8kbSTb5npmX/h+lNDj3ohHPQKZCq77GMU9GhbQDXh5ADBEliMkv
	07qB82ejIy1i729dh7i9WiOCZu/ljHfRxSj1i/XQ5HzMQoY0J8qIQR/VLPbkirfuWgYewnjQj30
	V5ipulnoDxMGfu3MxEXtBk/E/fXKMmiLUgtIOYUXu/CqkGDoJJz+BQ7+DYcbSpZFWi6HZ8RbQD0
	1Zss8h6wv545ARYTYlcsCxvwqLplSSM/2Mvs=
X-Received: by 2002:a17:90b:3b41:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-38f6a30c840mr6874031a91.5.1785336543075;
        Wed, 29 Jul 2026 07:49:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3b41:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-38f6a30c840mr6874002a91.5.1785336542636;
        Wed, 29 Jul 2026 07:49:02 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm19515456eec.22.2026.07.29.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:49:02 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:18:37 +0530
Subject: [PATCH v5 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-eliza_evk-v5-2-41790a5a24de@oss.qualcomm.com>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
In-Reply-To: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785336526; l=3928;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8YiMtSuh4BfBK3qYh405vLQxKxkhfI7wwld/xuAucUc=;
 b=6Ecw8mvBmnNkQoDELuXj6NTxOg1GgP4mZzK+WKVqoJ4IVGfTQmsttJn42AtcRAzi9Zj09aCht
 mAL9Jhvs0oTBUjdD4q8+ae5WsndfKvBudrknJzy9KDmB9dM53ub2woJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX/rQQTPbDoAAB
 zcGniSHTXdh2rcTe1bvWg7KSlnglhIo+e8FWs/tPF78S0Ah3lWwIMBjnseglRnDxV/weQFOq6W6
 i6F0XjX7+JJZBNfIbemrJsSDqa7J/W07lxJEP4UZJ9W5ROx4yHx3LEdy0nJTTuP9mbPlfzNcdbT
 pGWDi4qFzECI7/bB/EIHBkbFoeXkhvC3Tt+urYjsL/HXH08FU646pJSOb+HQV7y4UesmJnG8ovE
 xDgk0hL2KwzyUD3dAizem2AEH9wHQzNdSjUMWgbBUTjVRTSCpEVtQpdw5ULeSO1tawi3KLCoaF2
 w+yy0jyHp0+LZjdwdoEAvq6IIIZvwzBaqa8gv+fC5eDS6rjkDEaBsJstV7DhRE7KuoryIP8wnc1
 fvSpr7YS7N7CRRzu4vHCK/u3ZHIQRNtDF2F/b+TldchtzgNDqJFNIKqHjLMZY3U77kg4A3+Jaxr
 ef10d9hFTqjMq6h1P1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX0CX5+5Y+vOEz
 KbBQTI5yAiAn5nFFzRe4TjX1Y1qC/NYMHlvJIzcsP0gMQHhZtshScFeb1eh1bOGBRDHt7Qjw90f
 K6q0sEfAmQOj0ZKuxdUuvUAOU4jRGOM=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a12e0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: tvM0OIH7hOND2hCdSCmeqQAhI7lk6Wf8
X-Proofpoint-GUID: tvM0OIH7hOND2hCdSCmeqQAhI7lk6Wf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

The Eliza EVK board features an M.2 E key connector connected to PCIe0.
Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
via a TCA9538 I/O expander on I2C4.

The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
device connected over UART. Model the connector using the
pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
the respective interfaces.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 116 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index e47b24f8b827..b35fffb50976 100644
--- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
@@ -11,6 +11,92 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_pcie_m_3p3: regulator-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vreg_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio_expander1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	connector-0 {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&vreg_pcie_m_3p3>;
+		w-disable1-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&m2_w_disable1>, <&m2_w_disable2>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcieport0_ep>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&uart5_ep>;
+				};
+			};
+		};
+	};
+};
+
+&i2c4 {
+	pinctrl-0 = <&qup_i2c4_data_clk>;
+	pinctrl-names = "default";
+
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	gpio_expander1: gpio@3c {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3c>;
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1k>;
+	vdda-pll-supply = <&vreg_l3k>;
+
+	status = "okay";
+};
+
+&pcie0_port0 {
+	wake-gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcieport0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &uart13 {
@@ -18,3 +104,33 @@ &uart13 {
 
 	status = "okay";
 };
+
+&uart5 {
+	status = "okay";
+
+	port {
+		uart5_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
+	};
+};
+
+&pm8550vs_g_gpios {
+	m2_w_disable2: m2-w-disable2-state {
+		pins = "gpio4";
+		function = "normal";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <2>;
+	};
+};
+
+&tlmm {
+	m2_w_disable1: m2-w-disable1-state {
+		pins = "gpio35";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index a54a956531e5..c99bcccae00c 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -1909,6 +1909,7 @@ opp-8000000-3 {
 			};
 
 			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

