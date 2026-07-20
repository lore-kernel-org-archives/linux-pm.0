Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1253E8359
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544683; cv=none; b=QXpv/HvyLCC6lfAlqfjZYL/EWr3HAPwHDiM4i33/o3QojFv2w4MspIdhtAlVqqlA7ZNnojdrQMANxpRotCzrg4XShkzkrSwxuPZhwAVumaDy4yOWSepni9bcvPfIzlY0714lZ4VwfM6SaU9FzobRRJUmThu9rdszPpxptrp9ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544683; c=relaxed/simple;
	bh=CunTSypJtWlyW28U7WXVoqOPrB/+X5MUi3tMnwngJmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6f72FkYfHNXnlZEJLkdim1HQf/xSgohqGPOL8enKI2VK4I/VWTck+lMOoHzeg/hZDpLro6BGu5AIDa8yL5h+sc0NfCTuMkfLospgjHvQONcEqLfUdS0BkXTFJdNDdzFDDGsL0Pj0rswDXJ0VsaEdBbhwQDzvVnWjFGb5aHWunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eh8V4Cb5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ky1TVczP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eh8V4Cb5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ky1TVczP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vVaj1941262
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=; b=eh8V4Cb5YT57mN+l
	4glzBUnv8Byl8LLMndun/O4Chf9eS4drm1PXIW53H+cGW2m/KTGl4kb9ZPRTo3RE
	Op8IaAcJ9NNhyd7rDL4UDPPg5EfCI5bExPCSbBs7M7RzVOID6OjYWeaEY8YlvNNu
	h+10doGASsX1UlbS+hnzD/spyaiTS6E31+RZ6R+h/m5SUuHvoWy12LQbaEv89ur3
	A1Wmi+cX/wHJaHp6UN78NCl3rY/5yY9RNwP5QYOm+Zd2GzArFLoI0Db/AA7NaN1N
	rCna62tK4gqmu3I1aUJKKbv+wN4Wm1KmGiplzisT+6tskguJo/hJzuuhvEsaTKJq
	1Hmhqw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y08xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so2014491a12.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784544671; x=1785149471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=;
        b=Ky1TVczPkxhbt/B/CYKFxAwmqH8VJXOli2Tx6rYNV16EqRUgpHNvBMyFiwp6kGjjhD
         hPjSmfQCrZgXWn3oDpmWfAJDnQYsAG3YiMlDex+Mmk2owE+MVwi3jiPdlXV3zSSZWhHh
         qkoKB1kz30T/RkR2O4hxgVLMYgqZpgYE1IMQI1omiL6i/W4qemrhMzoMtFrf6anrdtmc
         HWJsFPyewiDIoNJagM8AW1ANZVUQ3et1pQ7HhfKfs0F13fPY+YR+yit54Pl+gts7BEf1
         SkJFlG0ComL1+NfoJmqDJyVjfKzBM++nytubl+tvOI29Pzxu5IQRpLJq8KjozrtT/z9u
         zeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544671; x=1785149471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzzH2CnGNr/JtNcizsYzqX0tKbpUEyxmDzScPNkmqKw=;
        b=kgq32KIRdStGHxESUedPCEhoDEbBO/0XgaplR/qoAGdhQTjLBHr4pAKKYUBZeoariQ
         vcEOvB3Lc53BVjPvi89mRd3z3zyDBcr5hJ4DWbKEDIO6hgHGIKWzFBBDf8NdEoe9I5Fa
         sWM/JZc9upun3U1ZEr7/gRiR5tKR1dbEjrN2z4l3FtyGRT2w9UOOmdcNk3WteU1tj1BM
         P1jDq1OE9XOu+pRoU8XG4HKjfHrK1JslrNefplixc1Sy2r/QfjUlRWop0Q+Qpqpt8pWq
         TjMRjlwLq/6VXG1p+ZQBYsgKZUhP1KOKlKhTicjZf4B1X22mqpjnceTXvT/+1WxRVUVv
         sS/g==
X-Forwarded-Encrypted: i=1; AHgh+RqP28AnXeOaLc7gAcN5se08Q4Jyt6pTA2yJYmZa1NYOUqpQ2TIcJlcFaMbeeXmPHX0KKTIi/k4klQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjwID8oaINKDyhI/ZDhz7CMCYrHxxng8ezK7TADnGzHrh6+Dw
	c1EKviO9C00PI8KMZj51Bx2Yqt6zgD4xIz2Z9zSQo/0o9ne43Av4FTlbeuRbkp/awYA/r1zzTs6
	WVfMipfvbOTgk7U5bUazjpx4bjgU0KUXp1URjXsQnTTy+J3Kb/vZB895NncuhZg==
X-Gm-Gg: AfdE7ckFB32oEmaYmshUdy7DxwG38epJVOx+OZG6XM+7TYDFw77x2lFFRi17ERqtqN7
	w7sI3huz4F1Imh5+sBp/fcskskB14GTqNSvXSlrjhbauZUzNeUXt7s1zgFT6Pv8zXbrSB3g8IA3
	fxZE035YMci1PaOss0lMRjW7DgB70uGpH5BcGZPCgniOPGYHW2tP/+SFU91iEkNEOC4OjQs5/WX
	LPyCq1tky+4Z+KMyu3VejaTy1oQlDCmLYIOgWrcXF+AOFUDm605jAfpIRLuFPzlSiZYeMEiyVKP
	glbSCZmU3q7GATcnVh2GtvZrSAoKvTRx7OUDBhLswjO95PF2zHawi/C/ooGp6iKPEqP4BA3SI9K
	h61QbNcPs+uRChak=
X-Received: by 2002:a05:6300:48:b0:3c3:994f:b4f5 with SMTP id adf61e73a8af0-3c3ad67a262mr14617137637.28.1784544670859;
        Mon, 20 Jul 2026 03:51:10 -0700 (PDT)
X-Received: by 2002:a05:6300:48:b0:3c3:994f:b4f5 with SMTP id adf61e73a8af0-3c3ad67a262mr14617107637.28.1784544670423;
        Mon, 20 Jul 2026 03:51:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm4343368a12.0.2026.07.20.03.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:51:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:19:25 +0530
Subject: [PATCH v7 09/10] arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-shikra-dt-m1-v7-9-7dc99100c6dd@oss.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
In-Reply-To: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784544606; l=5005;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=CunTSypJtWlyW28U7WXVoqOPrB/+X5MUi3tMnwngJmA=;
 b=cS46fBy5usUVCxNMIxKqU9RxEHeFsSaRgq1zpwyiGe7TQ5hHMbXR0zEEijy/85OH1f4ztCnfU
 HohMX2GHSzoBbH4+ArnCzOIt4pk/ig8OSEdHOTQ7Z1R/bZaMTfNHeeB
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfX0lVdCh/EYKrr
 uzGVllQFtxCAv/EB5kKSpZ/xRBtBrHhwH0MYYXRrGi+SKyAbM04ODzWr7WGyU2wF4MfWORF12G9
 AoTMd9mPzOznz++0B5nAGZN/swHh0MU=
X-Proofpoint-GUID: UmvalctAKKQ3b2VFQnhVgQEldWZv5saK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfXyPBaYxA4rq1w
 oXr/Kc0cpefZ992GFgxjXW1rX+Wm67b6s0LdNGnBg1q3gKKJdl+lYaRQ8oKwEUx53CYdTrdVTbY
 tiNiV5AvWfAlYyKcDp4PyYjveqzZWpTebiV8uUbzhB2xeTdMADB+PMiHi/D0Oklt3aaHQpuKhQR
 yY5rmRWuaM76LWiyUN647+HSCJ41SZ+9NK8KAF0aURUgXd6gazGMErwT0dNT65ke2VcmUnuNJ89
 eLaFMrilBOpimanSRjITc38n3zLkFgf98t2pw0XkVZRabC8mysLCl5OWGNoaFGBpG1l++B6id9o
 jBSstQtlKaO76k7T/aneDAU2inPDLvDwndeAJ36HL97tipAoTDtmDzIXOs36hCKremP8/KLktoy
 guf4RfZizm4+NEq1MOsLYL0Z2EX26A8+hQqeflRl48xNZ7TaTTMeUoVs7pk2PSKFrNsiBKRdtrj
 AApoZlAS5YZDZiNPUeg==
X-Proofpoint-ORIG-GUID: UmvalctAKKQ3b2VFQnhVgQEldWZv5saK
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5dfd9f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4qNR6o1dbhOseOkXa0AA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200120

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

