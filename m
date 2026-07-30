Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471742BC5E
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412861; cv=none; b=UML5wGfgmadHsx6NsOY82DdNOmL6tE35AJ6zxtyN9buHkZW0iaF9QfdvpPTUrucMw5sY2cjtjmL2KubhxdC8ETA46hQBIuHzJTpxCTsx6Jo6IUEr0KaQhbuyjudOgmQGSSQERzcx/iiymvd2hfIRwb09UdlU8+ToScXio6nk6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412861; c=relaxed/simple;
	bh=Tsc7wQDPxpMuA7PiwhLxACoaqtU/viagHz+PtFrel10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLZNlCrvkj26s6kgFh6p9Vt6FXYFTGACBwhdpbGYffNz+x4GC7n2aisRHgPY54isjLAAOmVX3bjhkaO+hpQ1oiKC1Zqpn0DHsaeGNVajNM7gvbKzqzGWGxH3f+jjqmDRosoDMVPXOxUQvAqU5I4/D47W9kb/xjOIr+kIAuzZBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S/XO3Am7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePHYbySB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/XO3Am7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePHYbySB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2Pi64191208
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3jmAa6MnovSt1rWApG8LJQ3gczw+AVJrR78kg058v6E=; b=S/XO3Am7LVMkTuTA
	oIpxssAzoaaFjObEOUPb4E90jk0XmEdg/PTM+NYuVjwpnX7WjHI5Ba533ZBJcnuQ
	TpiEJI3C1orjG3cSvBh8jcRt1UiluWM0T+gFkmMMzDs099/403PPG/fK/TVj4w6+
	zlIHzynj+uYOwKH3hXWbVusqd7Rqy7fMoAkivsw6aWPOtUga111wKCy+cZc7KxxF
	fE8Jt8DUsyzT88zaMfgcMfAIiXIxsqSOsinMg5slBxuvwQ3KrfkrckXUlp9uqAYk
	ToZRS1r0Xs/UjH3hr3TZcjQdwlB/b0mchd88aPBRL7pwpwQTSEdVZCGDJ40YN+3B
	m8Xjbw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3tygnaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:00:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so26361265ad.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785412858; x=1786017658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jmAa6MnovSt1rWApG8LJQ3gczw+AVJrR78kg058v6E=;
        b=ePHYbySB+y1vTf6BDZ1G0ZfwFQ5HYy+AViVF9Y6f9z74knszCsJCefniA266BKrb5o
         dzgx4+0MPWyUJbRinN+Z88/3B2Dc0eMWyH5YBMtrfRtQk3oJGNdcTqx4aaNelKNRDPGL
         7SprwHBAtaraABZmepjCJMbBIdsgXlLi2Z3HenBipIjKRn/Qv3PZWqfDiAhUmAVJSIc1
         NN5S183wUDl9XCQApRQzVdKCtBJSOgeZKNpJvuEf2m337jz5gCWSRWZNDKtgX9xRvIiB
         jAuCZx9dRwX9xcXtTl8wfLh+tGOKwuyIRnqKLjnS51aFWzge64on75BGf/QpelutJNxI
         pxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412858; x=1786017658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jmAa6MnovSt1rWApG8LJQ3gczw+AVJrR78kg058v6E=;
        b=grkkFmLRqnYJOS8FA+CgLgQ/Gwtzz/dZVHEPBEzA+udt+H3jn4o+WcOqgkqwehsraA
         erqVvvPJ16On0BObdZbcYSoWIWrCRXay0m+l25HEJvDwh715HKiPoh3mMyNKSMYI2kKX
         c36464vfpXG8OEMEtOt0hOS45ypOiv57f8QeY7fS3rjnt+Tw/Z5ygzMCb7XeJ9tj7nmB
         5Sb/4XiuX3l+jfN/jA4ZXJmSztxXcxA22R/PcagFXoCou7Rk+YTvUKAhfad+uYYSUSNW
         9D31WIZA0C47QreBv53yQZzqJLpDqzy5aXwi1mxKp0oOq8CvN5BRFRgIs5r9PQBWXqzK
         FCWA==
X-Forwarded-Encrypted: i=1; AHgh+RphE0qbjRaCjAVaTnfqv03AsvOR3ecsy+TDvo6FN5HSrJziEeGPdLTpXouquxCspv5QZT7l4v05+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyey8B2zReEBr2A/ZU8Xggaaj13UliHHsOvLcTrvm8UQaoX7ou
	JdEK+daU+p15bhXX1mYYdPKYDpq8J/naIX49gi6t0eFNdWY/xBhFu3/6/dCBSyoYWPCwmPGmvkf
	XomAZbQZZPWEZEJoRdX376cD+L4wjdhYZ2AmxK9qVehSR03PZEStqIqYeye0aEA==
X-Gm-Gg: AR+sD11VptMTGy+829icKfI43I24DCEVTcP50GMf6a7Hufv7ZiM+2m4qkpgy9IZfZ/v
	OfebKXUQkJaYuTD+T3d3csKAivAUuzGnewZIFvcuY/l7A9VjYPT8J1weKjcb1lIlUmV9J5INx4o
	oaUCVicnVDV68n8gCwWNU7QLNWnvMl5RJ/O30g5naE2O7GMN0H46/G2mLdRNAbTnLZXzraV7DS6
	j9UqcL5yfi3LLDMk/OLek3s0IC00eMDQPxelLiDGMu/R4IilMZMiw5G53str82YWN6D1KSSnEM6
	xszXXKDPM/G5sLGZU1axOQm4zAQ8X68ORj8pPMc9SbLL/1DO4cyTVB9u/TgMjN407ges4Rn2aOw
	kXIeJsr1onVEvKX8eGMqDF6b69bpLkgvPR4I=
X-Received: by 2002:a17:90a:dfcf:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-38f9bda5a9cmr1929403a91.7.1785412852856;
        Thu, 30 Jul 2026 05:00:52 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcf:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-38f9bda5a9cmr1929360a91.7.1785412852085;
        Thu, 30 Jul 2026 05:00:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13f9a041e36sm7822776c88.7.2026.07.30.05.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:00:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 17:30:17 +0530
Subject: [PATCH v7 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
In-Reply-To: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785412836; l=3456;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Tsc7wQDPxpMuA7PiwhLxACoaqtU/viagHz+PtFrel10=;
 b=q+5IE4q9UIMGP4y4lcHq3YE0+Be6IHm6AS6m7QLqFaNalNkrmN1QZMULGAKD7fwv1A+shi+bG
 fBH5DHaBbuzDDqfB+a40PMrl7GqvXSKGUQZe7Ne2DskxPdFKTIzPnC8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: WNS8G5fFd0-y-HKyUWqPe5o4jvxiv0A6
X-Authority-Analysis: v=2.4 cv=JZOMa0KV c=1 sm=1 tr=0 ts=6a6b3cfa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX65XqkgSB2PTN
 x8tMVLMQGaTiddYGAwl9z9xPuCR7gHwaE7AFhX27G19oKQrjRsWKBNB9gtDHn3mHOuHZtNsIiZX
 A1ZAefF5sHoZkTkoOi8Ltab/jgpu+VQxJYq0Km2bm4RO9vMqTA1vmzizo7RdBYP43EVGOOsO4mY
 FwQcPTpQIQWdQmFWJ1g7u8kQY91c8uUD4bdy11xodDEBHlodwlbr+V6sXh6/pvbe1fsh6DKOVRt
 ZClKyekgoUoD1T5y+Xz56DhLjCGN3iGdL3yKphXDA13QTiUQBvqSqwCvES3ImPWhcoRBzx0rfbh
 LdKAhjFVPgbBEd+r/X10ypD+CrPsQpC2SxLigjcGebPceO5oXbb7LKAW/cFk0Bee/C2SJDjUNrr
 NwDdDtfIHhS554QQTnNDrsW6pDoW3YhAfaNHaHLx+RvKTLlNp9bOZ2LCmzXlitbzlcZVR39CKb5
 +QPAlCRDQDzjxUp7CPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX9E0HDhZEIjY0
 0rD4nuv5399q87+LDhHcy94EBHPrN/Kt4Q2vIbDMDHebIP4J3DfaV+Behjgpj8PtBqAzDVXK1MH
 eh4JB8aAQCf0CGNggZuTy1278PCrTHw=
X-Proofpoint-ORIG-GUID: WNS8G5fFd0-y-HKyUWqPe5o4jvxiv0A6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300090

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
 1 file changed, 116 insertions(+)

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

-- 
2.34.1

