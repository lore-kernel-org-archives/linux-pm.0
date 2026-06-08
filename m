Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9E2EDD78
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924305; cv=none; b=DBGqTqBDx1S08S0qkvHIh7oTC7RQDitaxFdRAfLl5x16r8h/hsXVJG7UNSZISAphR6OXcG237Z7GLEqsPSzMShihYLeQSoP5s7hVAOaZMkqDLWFwxIffpNRzwY5EIXCtleQ43bDPvBM9LIttdKn7O+PulNvBZO4oLgSRCWs++SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924305; c=relaxed/simple;
	bh=UpWiNiWvCfhK/+y47/tOe6slWfWCxIGegP01oA/xlhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLQ/5/x/kvjdPEaWXzpShuk7ou0X5j+IRfKFFTISyZ2Xofk+ova/uuYUXRikHpbK0DO3EOx3Bpq5+nB0ASiKye7Yf9Lptk2uPRMac+LCk+7rRujD8Nc/6bCzeL7BydOKdrpE7DoAGYOnl7Sqx9WAfKRisrKslmBp0bfwdQBnhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqQU2Fud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlamZLU1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqQU2Fud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlamZLU1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBkiB3454684
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=; b=TqQU2FudxTKxVz6G
	W6A4vjXsN56ymtL4VZGyOlZ7Cdm0a1zamUEXoXuOwbJhv50p5pNF8+Djm3NVSJR6
	ITd5TohAdU2AnReDfMTYwg2mjfY7gZOJpWxSgfsCufRoUZoR2iWdOG1dS9h8cXBV
	Q2B3JbE6w94yr1ngPS9H6qeuGWei1Fa14pjfr3UclRBXSBiOxZ3RYZ6yQq1EE00v
	02qUu9QQ621CEIxcroR+Y1VFwOg9JI6FMOSN95YCi5ioAMFwUrmzWxxMNOtewUi8
	+MdB2dDPtvBh5ugk6X44Y9LIupduc5/RXR73eQYuunX7ex8deSkTPEZXIqFO0kKy
	kJGEAw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0h2bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:11:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so83949085ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924302; x=1781529102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=;
        b=DlamZLU1Xc7ytNCN18Eg95L8JyzzvHxQDGfyob2KdKS8te181mlsXt43GKiv3Gmu0T
         qqzZLK45xoWsBKPC0HucGse/AXHNkbgPQhery+zychLerxMs4jj/vQH64IwyM/4VCv9C
         H77Q8AYv8lwE43m6bwG2gKqyrWKmjfmc+QVzwYiK2aG6AL1NIvuuqOcepOoPH8iCnlqs
         HhuTYU9e102J2rOiaoT/g3DVDPD7e3uuE4wZRTuO4n0n5fQyfLqmAaZOCT0ir2KBmEqt
         ePEPaaV/LXtRC7/rOBdib3iRa0z3sV73HdksYhGZJdTMbRe6S923nTiYxGWkqmZvHbn2
         nXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924302; x=1781529102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=;
        b=qzRNyLTh9o5AUP94vG0AhSE+DxCLmDVMMWr2lY/u8dhVGFdu4flJl4RDB2HJWRE+yk
         WmNJ48f0m3lmlS0+XE63Sn4dj2C7wgekoaKSTCW2g8VqLt0PqNEE1YpUq0YP3ueXIA74
         htc7+ZqSwqwtJLTZ7U7S2ihypiGA/yIj6GPO2CdERj9sacVQ4YhyHY3lbM9lfcOIZBn+
         KurRkDrZ4U839VWWJvSHWw9/PKpZL1XPc08iZxf13rqBUQqs5Xbm01IKS6m4qUVfVdU6
         I5gpxIfRmFfNFIf93sA5ltaiU4MtMh66ttVPribjesj2mOpvOqSL0bmo06AkrNRmIq3b
         ciyg==
X-Forwarded-Encrypted: i=1; AFNElJ+TIfKDII7WLcwbSpZmCT6OdnOlg6FhdTsnaDDvxp1rCjzPvXG6h4ipOe9+UqbGx07aKcpx1VUFBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziGv0+kZt1yR9+1z/NpDPnc1piG5T2VCS5RDybIg8sF03uaxzJ
	kDfpuXp32TKEbYZ7NYLppdKJlA3DNod+FeKw8PBCyTvs+gvOSdNK2IgEDDsrAkWc937nQIuJIeC
	JP4bNTRQRueSpB/ysct3u/8My6mbE+b5NmQpHHT530NTaYzXBpyCc/cnA2AgK0Q==
X-Gm-Gg: Acq92OH2uJybGuQyNLTblwlt+Sm5uTBLwdC3oTAeRkwPpUbwLk15tH09E8vIWN6Z65O
	pl1YammFJZOVJzHCXJc9W+tEdWPy6Q39DlSqw4EZIz9dUQYJF0CPOO2mYmSYr4XnQR9Sk4ARxy4
	6yKlp0NHtO1HHTSiYAcdZtCJUVItVfW2KmkNdn+wwp7k7hHiT7OJNNGCPyNZDVJKzmfLSF2lW2I
	+J5vlgFS2b+qODmvsWoDvMFRJuLoX81yhW8hJBlFaEGvymyVKWQLwqFhdI3TSZUiQh6aYrBWsB3
	DB2M7vZxzJRra8avUg0KBv1+9mZFBU168k6/zGOoxgXkNWDtkzqOmVjHtH37P724aBmFRXlF4CW
	XPREM1V/Yogz41hGRguXfXcd8R6Hg5TpCzrjeMNXg31xB3zQ=
X-Received: by 2002:a17:903:1b43:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c1e85aad69mr180111005ad.29.1780924301544;
        Mon, 08 Jun 2026 06:11:41 -0700 (PDT)
X-Received: by 2002:a17:903:1b43:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c1e85aad69mr180110305ad.29.1780924301033;
        Mon, 08 Jun 2026 06:11:41 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:40 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:30 +0530
Subject: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=8452;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UpWiNiWvCfhK/+y47/tOe6slWfWCxIGegP01oA/xlhE=;
 b=GHxQLKYvkE3nSrVSY4+OCTeKQs7zY1hXAL2zERAWQMMWBnsiy1mTgRB9eM3y9Pv92y4LBiZca
 89QoD9p3eywCxRIzz6uTDDkypNkDsOnK5oTyjtdlWDeapyDF4DCWVOr
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX49f959HNZmBB
 v7Y4lI6vD0R59EheXR8dwpE/fdCC148JUWsRRp2ACHPS3SnRk20lBFI4QbNAzxAfDq/Nsx0zsYJ
 5hhjSnb6wEPeZfRJVjDOSfxe1zilBrVeqyjdNKkZEP4wkgqN1u7zZE8ImzdFbyjMPJxOhQxuYa8
 mLJMQwi/RWwepkjnhE9rHLa+HJfZigQiZwnfuU/bdt+b9IvIE8oaRRCg0HzAooix2xJcBWNAWNh
 EN9/ISyjThIl2mN0WQTgspBuNAATVrbtysNHRF1SkKGbmj1zLpBqqum77qPLPs6LLMPE1JhIxsM
 2oDV7Zyy0n1Di53jKHt9QSSmRP0W2a1udcay3SBb8QyZciR/KVjdafX/xM2dNb8AHbZk9LcVPy7
 fUUaTiZE0Q8AEaKkFsXsk6LsF825mS5EreSr5kVad91CXEQTngS7vNIurfv5QUBb2DmnjkoVYo7
 3/u/41R+zDCNeTmEcFw==
X-Proofpoint-ORIG-GUID: IihJ5Rs5pmww126pStLZC2W7KFwq0iBD
X-Proofpoint-GUID: IihJ5Rs5pmww126pStLZC2W7KFwq0iBD
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a26bf8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0EpCGlkTwZhbVQC-sXkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124

Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
EVK boards using the WCN3988 combo chip.

For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
board-specific regulator supplies across CQM, CQS and IQS Shikra
EVK boards.

For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
with register space, interrupts, IOMMU configuration and reserved
memory. The node is kept disabled by default and enabled per-board
with the appropriate PMIC supply connections and calibration variant
selection.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
 5 files changed, 223 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..683b5245923b 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -16,11 +16,48 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
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
 
 &remoteproc_cdsp {
@@ -57,3 +94,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
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
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..26ff8007a819 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -16,11 +16,48 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
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
 
 &remoteproc_cdsp {
@@ -57,3 +94,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
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
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 8b03d4eafa6d..a79f44aff968 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -8,7 +8,22 @@ &qupv3_0 {
 	status = "okay";
 };
 
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio88";
+		function = "gpio";
+		bias-pull-down;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
 
+&uart8 {
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..fd691d53a0fa 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -16,11 +16,56 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
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
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
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
 
 &remoteproc_cdsp {
@@ -57,3 +102,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
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
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index c1f25ce89bb1..6bac6ebac8da 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2064,6 +2064,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1

