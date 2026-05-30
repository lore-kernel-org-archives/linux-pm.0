Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32123CF680
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165732; cv=none; b=aJ18XQxKstrvsQdKVOuJD+PfnoXVOcMNw5Y24uBttPBfw69Al2O8920iLoH/tfq+2TTjpoIeXjCQGsAYRPeCA5MKydmt/mQFcJtzhNptscJCrQXBrBQ+Z5Vn0lMvmy6y0gffGmgBHE9H/UloKY84FS+kUF1i+DH6UeQ54v2NfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165732; c=relaxed/simple;
	bh=NQKSEG4TFwIgghFw3/HPLhZFDgnqaB+NAFGZeq8gBAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NbFub4mmeuLj4Ef8nSbr6WByDJ4PI5I/CJMagibfUeoxSo9hfRMMhF3BaW+1dczdW1bREBp7iDD6z9nKNWVvT4LVQEIhgceOVBoQz4W4jOlyI0SeE4ZmSrybiyO2erfydxg2SZCE71FYTswqSx14lFLkocWkaN0w31PzmK3nMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RpkVeV+I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HOjpr2mz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RpkVeV+I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HOjpr2mz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEPTZL2569597
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QzckrjDhK5JtmL+5NHYbLPDrKVDpefP4B1O+ltvjO+4=; b=RpkVeV+IPQ0M6BKV
	kK7xgr8f4vsMQRtLSW8z3biPSXjFL55kyKhdAjxjmE7QR31ANMZ+3E6SX1zOBAma
	6i4CBgFu5rM+0JG5Rd1tRShShlpGb51v01IK4AZ1q/pG9d1EYfe+LgZf7qIDrv1l
	4r9hGT9ant9YGuTfezJbyXu206BsyVrlhpFbK0UMoj3QaOYTjEX/LVGyWwl87WkY
	hkiBWAQ6LY5JRqxeQGj1D2pdqJEPCfSlpewJRSPLG9KerK85fU8HXnmP6wexWfrX
	A836EABCXgU9sbTVBD4PbBXiJ8MpDx1DIYuxXTy0FFOdI4nO9AiljrD2fcclHAiJ
	qS/Ciw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqfxssm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf0453031aso39769235ad.2
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165729; x=1780770529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzckrjDhK5JtmL+5NHYbLPDrKVDpefP4B1O+ltvjO+4=;
        b=HOjpr2mz4c5gSKF8TEKuavlLcOz6b5iXVAQk5HX18ZtzbU6BmxGkmTr3NmczahwILW
         RghUV65ocOx+Bp1WSt4fOt4+Dt43QLYO9XzzSAdeZ4O34rAt34KrG3nncHSlTaBoLpiD
         ikEbkMzkFov/lltThjNKFcWJbsMf4i/QDbizUqYralb4292wJFzdyKb0D/6R42JqJ66D
         vuEYg7u4/GxQIMFqG+nBIg2GN9D9+fCOlH+46sAqff9jKlqaXFL69rCvlokefIcNYYWi
         Bgi1KPoYOeT5yY9kds+69zIY1adIsH3pgOZJa7aI2vhi9fXkf7UdpHwaEZr/RAkfsdmP
         4IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165729; x=1780770529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QzckrjDhK5JtmL+5NHYbLPDrKVDpefP4B1O+ltvjO+4=;
        b=SS3FtBMoLnNia6BAXR5Y4wQwRrLnVvl54huEpoJaFqV/pKXIR8DE7hrT1yH9snumEg
         X8VMMUi3PyoTaPGOclt8Z+FxN697Vh6NxIRtTyoxLmRh6ZCPLwwlCxIP2BY9z0TjePzT
         JtE1QlN7q5yP1Gql2M9tKUVP07wXD+bxiQeXFRiFsw9ALpB+dkpEfbOVbCVpe++uJ7fr
         9TIvU/wbXaCpV8kYXRFWTZcTAuAyQFIqoX5MXF05loKrYSfjbm2ZFjJqW8CtbCO68QE9
         EnxnyBWbwJ5a/PHQ8ZESDcPMJTxdUowteHOZ7IKFxQ33DdvuvOm9dM3gYx0MoFY1IY3G
         fo5g==
X-Forwarded-Encrypted: i=1; AFNElJ9zG1T26AOBVdfFOPz/u13y8rlTWj+rYGa3ArP1vzNyD7kFjA5fzt88BDIMx/nmRmctDGI/qoT+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxClA3yy86EIcOGz1TKPo7JV2Z8c5gzpTDSnfm6CofiD5YpJX6
	ZGYZCBT3Oai0omEMu76eFE/PPoF8c7Ao45IJSrUpj3freZMLF7cqXsvbbvnLSQfIzXWWceOszzr
	Me2dgts3P6uKRFvBR8vlDQW7MTl8ROxX+uDQj2QWBHN+G+nl45jM2VDhwFHhcpg==
X-Gm-Gg: Acq92OEqqvbDBoWVMmpYhLLgqKeqM5ULDP+Id5STh7Zw6rxYP8v7xtNiBLXkQTooZdL
	gPrKmWb2eZKl+00IeD5d797YlhTr0CGpal4JPwdqAyTUaGkjHyE3wgRIAnbiu1cezvwbTKX/2Oc
	hpXDuN6q2jBGqgcAREWF87FcSyaZKaqSvC7BdMIkT1eic07fe/SQFBY903ltwgHA678TwNUzsWL
	7qo033PoaWl2QhbGg7bmPVLJAqV+/R4Sa4Hgr3FJfthe3PDnk5RVJEFi0oAEXBKyY2e76MBF9kC
	rn3FxfcCGJ0plU4ifp2e1dvShQdfR28bVIICPewruciUXcXB2LuOzF9XP34Cb1G/O7CIgVP+ri1
	FT6xmKxjImfHgD8/JFtsSgAXcJZQlH8QzzI1B0OcXMdLwHIs=
X-Received: by 2002:a17:902:cf41:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c0b35deef4mr19990495ad.35.1780165728466;
        Sat, 30 May 2026 11:28:48 -0700 (PDT)
X-Received: by 2002:a17:902:cf41:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c0b35deef4mr19990335ad.35.1780165727987;
        Sat, 30 May 2026 11:28:47 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:47 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:28 +0530
Subject: [PATCH v2 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-10-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=8452;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=NQKSEG4TFwIgghFw3/HPLhZFDgnqaB+NAFGZeq8gBAA=;
 b=WMRNakvy+9LQ40Lx9p9XUl6DoLuyB+PDWixHSvLFTflnWAtq5ftWssWeIHu6mA5YgmYWQIbrN
 vPtP3B54yNKByRyvFm/E1CQgL8Yj0MUqHw/oOyKFu0PUhoBEuCRDIxn
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 5MhdPa6Ii9Q0Hcmzb3yGQvn-20YptaX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX6mvo8Uhu8LfI
 gpkf+WV4zjgaAqe1+RZImzWHikCrB1h1uC/KcjhPHitHk5bRaPXeUwP5rzPsKO0D17osGsWkFxn
 YnzAJ8lNTisPb3YJb75ekDfgX76VUG8q+AWJ33azubhNlPL1cHmvlHC7zNRFiD3i+dHj0uENFHK
 qt4Os8k4Cljw1+lICWWWTrA6azBfPTIq3ZUrDOgr5AFrI11f83j8x+OwZ0JjHI/tfDUvAX1M/mc
 WUJDC7VGOK7hDWI5hNU+wCIgWz4f6Y2DGZ5zKsV3L+AY0KQsQWr4oZrgBOkIzRSR7+6wMolyZ2B
 OghVJo4rMQIrNMdi8bR1olCVnymKkFirYzuiAJ/npG9ldEt166wi+/+27IvAJT1WK+VnPsTyjFa
 0IjyXokyBX8oFp0uG8H9mkWp5hMVrKTLxr5oiCUJ0v/fZuTGpdLazku4HBAcFOsxwH01Gbb92Mg
 +wIWor+X071IraJd84g==
X-Proofpoint-GUID: 5MhdPa6Ii9Q0Hcmzb3yGQvn-20YptaX2
X-Authority-Analysis: v=2.4 cv=Zq/d7d7G c=1 sm=1 tr=0 ts=6a1b2c61 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0EpCGlkTwZhbVQC-sXkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

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
index b112b21b1d79..c2ed0396533a 100644
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
+	firmware-name = "cq2390";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..3bfd0050064f 100644
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
+	firmware-name = "cq2390";
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
index 727809430fd1..95bd797d009d 100644
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
+	firmware-name = "cq2390";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 37e4ec799976..eb08b7199c21 100644
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

