Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3940C5AE
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756465; cv=none; b=WtOTRb4sPkXXHCL17kmS2uVUB3qiLNGqzZclTzsCcOKm32+q/F+ULgazQiGZbAHqMsIvXu3uJS1WflsQ8/Lpj0RFFfU9052tty1jTo7e45qGywwgU/vSudk1ICPZcDQtr24+hgHn6skHHEssZ/YaSi1g991zbQ1cOpL4U0DjFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756465; c=relaxed/simple;
	bh=CunTSypJtWlyW28U7WXVoqOPrB/+X5MUi3tMnwngJmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLRfZrc3JXtS2I/rCaVsy+CByBqTJZsCynn/oecwv9at3c+H5ulcWk/Ed8HSW0NTh/e6s/aSCdsulfTggvmRwBJCDN/E72tGw1NrZniALuhZ/EDIjFeO2XPdiNcgPx+De2siIlfnWZykplu5Rgi7AdllKMwzVgSoA1cGMOCOxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QT/Pxlhs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NarKMaqb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QT/Pxlhs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NarKMaqb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673B6Dxp3956941
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=; b=QT/PxlhsbnTE8d6+
	HPZmIwqWpIs29chHeIMiVDB3BTP0aY7n7X0qHpjjqtoyuLMxCWq62RhWodXkoW4S
	rQMHNr8SMKBHSYLCGevvHf+xR12dycXFhmNaSF4KFGe4Q8Q2hr6gu3ZwPwtoA+o7
	148fPjuB6w5DBLUKu6k3PxPl2C4VWija/3DRQpQQkKgV8XGjv++TeBDOIiVdZNGt
	bgnXh8CjC12zvlW62/OEaQKairvg3506u7pNMVIcpxhPbbdbkW8hBb/YzJkVvxRH
	Kw2AszpPQ4VZI5QgJT80qJOb0+3JWgOa+sMITpY7VIovdhz+qxm7sTKZl84Eozqj
	rCdWkQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvnh846-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso4698278a91.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756462; x=1786361262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=;
        b=NarKMaqb24wPxR12OdtM08OPpd3aFUDW9dHiYKrUPwk9JktrUImzyEgN7OttTr1nIh
         7E9eJCDrDeCsJQShjOjLzHEMbP8WcFNBvg11QEUGCwmWeq42P2Dsl/JLnUw44GLVEN8v
         Sd0u1bYwV7IjBVgYJgMNBsZKyQV5TIA/cGbb4ZjQ0BnP6FlWfTrFVPA4pTzzmaJzL6Me
         rBPK1nTLY9dNOyivL2knJpJh0qJA7Ap2Gp1c+hU/El9Mq58f330f2CPYcMcQvlrpEISC
         7rU1wtHgavQtern+mF0zHnldxGKpFdg3eVtTWOgubN3L7cG4qjbpHHJFlp6gNcfPKsZr
         gXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756462; x=1786361262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=;
        b=n3yHg9ElVMvYL3L+S2emh5vMAbVmUYJP3FAQhVvnIdlBoOqSMy+E8SyG9OQGAYihHl
         YaVCR3fxPyNpq0YyyHjliNEcsg/fJJyMjooIvpwQzy9E6yybxbOs5yomaPXQMQyMWLW6
         xwsahGtUnblf0zujPDcrvwLNU+9MbUqH2D5GcSKnk0rYiSdjhlsgjRYlT3Yz3FY/SJTR
         bq+quDFnOo/0HVisd36ntactj2m1vH7m5BnrZi8gD+eq6xoYppu7awKNbVsr//nGnCBg
         ySDSKPe5Hlv4Fhs5l27r/RuI9c3TlR4ygtfe4rSq+UctZnfk99PMdhFCxURMUQWs/91X
         dp+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr42YB/emRydimjkpRFOowQ3E7kjzqUWyCDw2gQ6CVhjamDrgVvXV5qWLgL8edJ2hzp9l1P2DXr7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBShU6egGDMJYTrSzeEiJQLP17c2HftU4gW1Ure2T1LFysoeA
	7NAg/s0VL1/Vvv7nyh2BtTVEbqjTv1fOL2ZVQ8PeFmeWNxaYT9HCu+fzwtidG9UxJBtuLSGqoqK
	PbP5rPbyneZdiayGIVLF6UpFoPRcXq7LLbrFlZOj8X2O+MgTM+5X6xstaqu7QOw==
X-Gm-Gg: AR+sD11/YC3deVkIJXf1i9tkgZeARdXBUVcHo++HgO9eusTm6lEk8VolLCC1/Pzb1VE
	9FQWN0nIXuYhCRoVfwbfDJl13w3baO7oycybwyeHbF74OzWXZLVUnmtDrI39pBdlzciDB/o598t
	sRswnEoe7y5ceYueKQau30dUS0nd1ZuiHZvWkeHBBZ3zNYmxW9Qm5Pqqiyg2VMXxRTaMFMTz5HJ
	JIUQRsEmFeMqM1wwvvAyM63QltWUAKEKgwEdBjJPwg/0agxmrF+w9dzVZPcKd8XUuZP6wq1g4Os
	Ezsyr2o5SOdV1Ef0sQIk9tyCAF0kZsFit2r3ty4UxTpgLmQSNAStQ9b+h2k1LZ+r558945Ad/g8
	fZagQmHxLIuCIsr4=
X-Received: by 2002:a17:90b:564f:b0:387:e0cb:7ee with SMTP id 98e67ed59e1d1-38fbc53c3e3mr9013886a91.34.1785756462230;
        Mon, 03 Aug 2026 04:27:42 -0700 (PDT)
X-Received: by 2002:a17:90b:564f:b0:387:e0cb:7ee with SMTP id 98e67ed59e1d1-38fbc53c3e3mr9013843a91.34.1785756461807;
        Mon, 03 Aug 2026 04:27:41 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:40 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:38 +0530
Subject: [PATCH RESEND v7 09/10] arm64: dts: qcom: shikra: Enable WiFi/BT
 on SoMs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-9-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=5005;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=CunTSypJtWlyW28U7WXVoqOPrB/+X5MUi3tMnwngJmA=;
 b=It/GTH/EKVzIUP4fnGsDWO6heucVI5qpmOMRu+Ni2KtdeleNk+mSPYKtMF11zOG1+DfLyBX8M
 VEgdR9HdazZDFZ72Kh2bx7tx4jN6v/miM3lEs9dET2kSi1Vdft+ayvq
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a707b2f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4qNR6o1dbhOseOkXa0AA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: DRsic8_TEBzqklSx7ICON3hXiBEmzrqn
X-Proofpoint-ORIG-GUID: DRsic8_TEBzqklSx7ICON3hXiBEmzrqn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX5pdU793QqZp8
 1WNzxvYnGg8gDOKUjxEk4i/enH3NLeFIDP8sLLrbG9HUdWyeee9BotkIAbbz9A0TjsqrshX8Npa
 BVzR5E6XdXe7JcTHuGNvL0siz7MHZD+tm9ROZBGlEFm7E5vlqjFrGr+HclcsFGtsZN15tXzDNgx
 uO0w4+pu2h/YJISzEXtAs9qNORcQ4AKyVv6DeTIJfuFDxDeTdTbTxONiDm8g1d3ZawFPj5lNZK0
 XBs4We5sD31cxdpXw1RGdUE9ga5lFmmBpOs+ICDuAo/GSPt7cPRHmWb0xYz7n9WqnVE4+CWJb54
 Y5N5JPeYtEdNQCe0FoWnXrgzPtbtzBeNSpI8lt1bUyYZ8d9mZWThqNh5cFmOOvqAma/o7R92AUx
 T2KvGJpB9n5b6tfMSjKDUvGeKJAZfj+dYtdGqCJgzXfa45T//h2WUvAOnM1QReLKuiicp1nYs5P
 pD8l3wpIO5n7AfZBndw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX3UQY+8n7PBZ+
 glHQWrmn9v6jsTTwW7ueBSW68nAVd57Lkjugvzjw1g14nz0tmiBD2ZWNAhC/Ut17WXO+u8nIHth
 b/LmJio/UCgF6V6rMvReXK62DeprtmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

Shikra SoM cards include WCN3988 WiFi/Bluetooth chip, with supplies
provided by on-card PMICs. Enable both interfaces and provide the
required supply and calibration data.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 74 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 82 ++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index dc3861489f64..2fff5fe9f6d2 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -11,6 +11,10 @@
 #include "pm8005.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -27,6 +31,42 @@ key-volume-up {
 			linux,can-disable;
 		};
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &pm4125_gpios {
@@ -154,3 +194,37 @@ pm4125_l22: l22 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio88";
+		function = "gpio";
+		bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index 73945bf42112..657a14ca9606 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -10,6 +10,10 @@
 #include "pm8150.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-key {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -26,6 +30,50 @@ key-volume-up {
 			linux,can-disable;
 		};
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "wcn_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &pm8150_gpios {
@@ -168,3 +216,37 @@ pm8150_l18: l18 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio88";
+		function = "gpio";
+		bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};

-- 
2.34.1

