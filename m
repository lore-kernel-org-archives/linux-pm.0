Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D63C8737
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222412; cv=none; b=GFxjV+6lR/IBXGCSMZQAuJQBHxZmhbKB1VXaD8+OTctrxmXHLWd6dh6H2Aad/Z2Sxr5XnkK7deB65+7sRIPG9Dff7ufSG9QbxrJ4m5OFI6nNir+bFbIcLdopTNvmLv/tz81QfXtDfavo6VHwltV3RsixBz/iFC5YL5uXaNxTojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222412; c=relaxed/simple;
	bh=ztQ16TX6JHl54CQY4JeUYC4JsypCSsLL05RbsKPqIws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MC8Tg2PJt4AfPV0eIVYiUvhy3nwhrIfJ0fEZbapK0D+xxCUc17dGHz6kXIm3/9qiiqRqX4QhzFad7QFwogLy15IZFRMV6ZtHqjE1bLncdjZDViaonhxbIk88BKe+4mJbmNryzyhzpsaMdW3F5A7I2Kcyhy/RweVwWxcyKOLWGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWeeAcUo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHiK6BpQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWeeAcUo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHiK6BpQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3abGE1527468
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=; b=SWeeAcUol5xJAz26
	r8ulz9Sgh5SBnp0vE1DBMVS993SqTFczhq/hbNu9SNtzN0kQOZPssJyFJzxD7Px2
	jzU3H410c0i+N5AXHxAimx52fWgD9D1Rk+aZVsFrVZwD+FEU1zw6hziDgw581TFB
	J3o8O43dvV+18FIjJ5FIFq2Bivbq6MnCKRayfFLAQ23KKsie4bliEqaD4b9PDn/E
	e0STmsK7VU5qI/Yt98gm9saoI9KkK9tzmnZRuMAgjxgXIbdrnykb4DdcOr8FQTHa
	4OLwI8vgWsyuouQ813VlLiaaP62KWE2RUvA0zb1JvRT1i6mwrhGL9ChEx4ksMRV0
	iqS3mg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8awmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:06:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so6369013a12.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785222403; x=1785827203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=;
        b=KHiK6BpQ2v8iDrO/WcMK5fkUsCXrl7Dr4unM4WxU94LJlaShuzjQFLpzajGGLf2Nlr
         LIE20D9wGkoV5yHr+F0EyIBZmn+wB6pXjdHYuZ8hU9pABjU6hbHKJAmukIhrrFxdC3Gq
         /uGMdAB4f6qGIbraCyPrJ5Zlh0E9sK8iPGKff9qcvjb0BOgVqJQfOl35ZbhwSf57tqQp
         mhJHMjXPqTGiTkEKc/XyKBHg72cCe31ZciCp/VGyAbnJos5BS8jaGwhEDLAXI1j8QaB6
         dYuq8U2Cth0XEGgqZRPEx3W9msbv3/LrENj7Bx8cQvjDpP+FLq8BZMcpzwjpA7t2DTIS
         i5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785222403; x=1785827203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TCd8VYlfoTqCZXBNdcc0rSBVEIa1+gKOgOniEJSCGo=;
        b=EGGBBG38D3PHNHLJ+7wzDeocEQYI7NgRxLWrxs4Xn6q1z8y40W+hbl4kb6Ipm47QVs
         xFUr4ok6DLxxuwpG4mZDKc6Rzxqeam3u/HwiwvxZLQKtHRuYNq4aO7gISIRLt8s6vRHQ
         B8hOCGDGz1DX9ND8JLWXuYuDG90XlBgnJqTTn84mwuYiX13QJJi4WpCppx+ZguGioOAc
         ZuJ13+z4JDW7hYAwhksxjyiPCjHC1srX/WGAU1sWQmQv6Nz2NYKVYGZsfLmpRCNpzMhm
         jSU3lxEGW6qP4h+6fq7IOpFArWqWI9GEcaRFD3akFC4+DWHVTG0pf32ZcTYOArExIk0h
         /B7g==
X-Forwarded-Encrypted: i=1; AHgh+RqsQErorTjsbSljBlM9KRC2y514HZ/0M0+uZZdr+aYFjril14W11fgQJMT48OlJvRgPu55bf9HKcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLnlqZi3zDxFJmh3Eus4pKMVmYpYg9KsWvMXNwecofL2ffRIu
	u34iSBGZ4+PXrJOcGXGaOhy4e1/9+kbq92D2Wo/tOxlNrzYT5WPM/uKPkmotb93GF1xc5l2bo6I
	L+2DjimjTeWweJsjYTLdnX/VVKJ1ivM4rR+p+FUSMkschGe56cKqeGghC6BBhhg==
X-Gm-Gg: AR+sD136UjKDZyfcREKgzZkWTlttQFf+g4kF/QppruE4X7c3CChoIf6ORcrhvKSONkg
	v7eWZfbavZpik35uc8aQxLAKI3ZiMWii9/xG1J1APMo7c3l36MjEYjCnc50Qdv9aTcwrtASCX1m
	R8H/oPPthsIUKgR4SsPwS4NjdfffZMrEnHINBnI/24yeyYuxQFRgagwEA154Kcd3F0jKVatOIH5
	b4tRkACGolTUniSYj0OJEbfZ8/fTya7lkw+RZILsVha0DFKQ+lT2pW/wc8+5+fMbvW2HybQXxOh
	C5oTADeh0oFeyrjAAW6CBpBiii19J9aXY7759GRoIRLYY6f48WW4LjnrT42werLvGBCRbmgCdkJ
	A3SPmD7+9hBTByWhRFcqdOZG9bZLMe1VCqMY=
X-Received: by 2002:a05:6a21:4c08:b0:3c3:becb:b705 with SMTP id adf61e73a8af0-3c8ac70867dmr1644493637.27.1785222402420;
        Tue, 28 Jul 2026 00:06:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c08:b0:3c3:becb:b705 with SMTP id adf61e73a8af0-3c8ac70867dmr1644465637.27.1785222402077;
        Tue, 28 Jul 2026 00:06:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm59846776eec.4.2026.07.28.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:06:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 12:36:14 +0530
Subject: [PATCH v4 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-eliza_evk-v4-2-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
In-Reply-To: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785222387; l=3855;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ztQ16TX6JHl54CQY4JeUYC4JsypCSsLL05RbsKPqIws=;
 b=ft8+vXMn50lEQEsDtLGBhzcEEzdnjDtxFzWjldrrO7WSn5IRCWqIrXDOYxRJ2OL17b1aEuvlE
 5DBhczmkwD5APCmScKYY+S4Hr2q3rjmvPDnKV8QiBKj72dE2BCyAp4m
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX1csXvaBiBkOY
 sKhJouH78Bd4/+cNYV56mjc2ABn7FEwuxslZ3rduw40mlYGAJKY3HC2KEZQOGnpP+xsyTtbtHJI
 dPd/0Ya2w7rpI8PsIws/WU98CZIfJn+ZvoRv9oW+ZA55+cho8oRFt0x3iHfzgXj7dVX7qx02nbN
 p7cofHY/SJFmxO8YGsiC1cICx7JETnQmFlh1Wuzvb/JDJOjJMxvJhlxkdu0eMPEawlL9OMFkY9/
 i88UuXc69csH4aT7mm+6/a6Sp+likF1KKp1kLxvudQtMYZkxCGM9Gl13450/SvLqCuM5PwjwSeB
 crjVQRZrlfVI6VYme96KVal5Os0CNKM912sXeyA3ncqvJ6atymnqrfT/ilnWdEhWOIjvkr58DkC
 KHEmfKbWzu2btM38aOi8nKFvtQTEfnERPifkmB4q9cQ9UMbFVojzDHDCav+qJgTWx/OQRp2lMHB
 t6hlnPUuHDOh31bTQyg==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a685503 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Mjza_P4Ac13qa23Tghng2c3a2igAB6oQ
X-Proofpoint-GUID: Mjza_P4Ac13qa23Tghng2c3a2igAB6oQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX1fNDIwm3omUS
 exbOx9n+J+Tgx/pVqSkujix2qAxubP3rojmR7G1i5vP+cLxzCNL4KmCjGWudp9Bd4pXaTEp1au1
 psxuXy2dCMFdS+yPTll2A7QXCczkrw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061

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

