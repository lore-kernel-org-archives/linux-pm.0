Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D533C063C
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491460; cv=none; b=Rlvqz9Cu6mIk6+neqA2lCeYD2jpxmrlsoGC1UiKOfZhCQkIi81EtpsbOLvnyooZrTLicR+ec77j2IAXPvrtaqmXq+Z5AfxPc7F3ReCFV+s1SftSuW7/bP6iGqGvNlTPBSku5qvJEaGCRB6FIrGv1c0Z5MemQtLe2Sh4A1//rnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491460; c=relaxed/simple;
	bh=kjUp38+rZsebDdPzQoG333l/YriQXg1AGNOnuiL62m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jrt9OK+6q57w3Uv6YbVJ/jNi8WbBBz+lgeSI/ISY7DtfyLzopFl5FhulQXtbe6pl3to2FbAD395fIXnNXc7iLfRQs+0CxF5LYPV83DgFCtuyp4giWwLDcMKWediXUVjrzVDcu2aELydhKYRZt5p0JoPIvT9CG2DqoMFkJrit9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldXcBAFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgUR90Bu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldXcBAFc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgUR90Bu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842aSA1491302
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=; b=ldXcBAFc1oy7BVaQ
	geQkDdR5GzBJVn3t0Nk41ejVG1bHWSqhuqrAGTkDgHs1qPjRfKyXXqh2qrRVIwvC
	gkQeZs6QFhP9zw/5o2IVLebqtuDF15A+l2zKygmvx0tsWa5czjc9UslGuQKNbkTF
	8meMx8TZekhY8yk0CzZQEF0Fm1Ohh0ixQ0Zwi91UmJSfc89o8Xtup8c9GFENSZNB
	xncFEJVU47zPSpNdvrpVhBwWl9Y2QnSyaWC+6y3lB+VtItvIL+1arBj1bhZIwK7L
	n1igPF5MlyfXkWHS/C1HOK2aCSYnTnfdywIDg729yhmT8HrttxB4HHnBWLRwkN48
	dXvajQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g99pm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 06:17:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9667280edeso459975a12.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491457; x=1784096257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=;
        b=OgUR90BuP/t9MltAnt2PQYUg3Cuas4TBmSyTh+X7Wzuv8hyk4X/ezDhN9UB77h77bh
         wiKDtq5U2iTzgPSisW7GC8Mo4DjYP9m+sWVbpXgFJVRUSz7BJFdn585ZssliPu7zovSK
         jpthgJn29lFkQfI/Sp8K176QV9o3QiwQlUcG9xA88+Azt9Q1mWwxPCh8oeNDSoMSDQBZ
         mYiDis5sGEplsxDCdy2JvUq8K3Lhlfkr0aaZ5bVLMoSoAiM6kTxg41Mmfs5d/OqQwQv7
         QXU8QPvSxqAPZwl+yyKdp3EO6vn1TiWOQ6VMsWgA0WtPwPtWpn1vheiSlwnCH1ZYhT8+
         gGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491457; x=1784096257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InvKQYryfFOrhTSliTwFdO7Bo44w0fLxACXlIQp7TTk=;
        b=OKWtZ2Wk3B95GeDR5g8f6m0Kc6tOBaTpzTtuIPWEmJPKyeVtWT+JkznZvYZ20KhTFN
         jPz5pYzut5wJPRj13AaJ4uKdYKfoO+PSsxZY9TjlRYeWAzmgfdX+ccLZ/GMULp2QSdET
         9VCvZaVCM5NNCJXyYP9J9vmsIpV6MPBYjUrK07ep84P12N81j1m9g98UyBhs6We9fSro
         uqnDcyXTajfch/dyyv5x2LoW38unD1mvO+jMh8Q+GlvPlKxBjYjfIIALIgOiKACmLtXQ
         7vr2+PE5zQxbdn9Z9djdlQMxwFbpsJ1CMzRDRR4iEl85K8JEe82U+dvK0vTPS/u95P6l
         w29Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr6uQEDzc6+zp9AfEsn3UbT2+kA/IGyCVXnEPzRMoj5i7kySfAfSv2cBPaKwHFku3bq30HrlT5AUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxonmyEUbLUXoHsb0PW2pJlBveh8lVfdxvnmQg/ZzHqwZlaQZ02
	iYGhbt6VB8fMMguLankErb7zqI+gFNSM90CMvHRdWbIHVHL9y/OKYB0Vh9QFdkBB1Q/X93ZAe7d
	UNM96XGc7pqxBPJyk4LIFyxe921oyHYzLAgDLBsvNxOxFLLvxuXrZ391hqi9ldQ==
X-Gm-Gg: AfdE7ckoURD6eErxPPoOdh50n8d4rq76WU1QYYlpSk8ji/sXIJypJIOsCMvl/VG4FA6
	dYRgBskQ8IXUyXrrw5lXmGwefjh8UeKxAvTi3jq9+lI/4O0R8OXAwEYbcFImtElypPiHlOXChuw
	CGbkF3qnQANOHi1h+Ahs7RklfSDfY+fNdD6v7bHofGhke1/emVvFcLfx4ZNpucwNVhEtWOBtxU2
	6QTQbUpY0E68hjzBPpgqNz3w+bdcKsrAYuQecgAnzZAxr95MFSBBqGCrfGJWKOrhkwgXy2maIAc
	Ly4hocXI4kit7ui/jo2WXLdO1yOtpG0Om5JMgrdDr5iA5sKw2mB64YAz+mrcIAfkUQ1RmWH5Hp4
	yJMS4D3Y8338PCBZrOad2grrUwoAea3XpFyO0ds0obqgH9A==
X-Received: by 2002:a05:6a21:a49:b0:3c0:b3f7:e5eb with SMTP id adf61e73a8af0-3c0bce18b33mr1228419637.9.1783491457264;
        Tue, 07 Jul 2026 23:17:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:a49:b0:3c0:b3f7:e5eb with SMTP id adf61e73a8af0-3c0bce18b33mr1228375637.9.1783491456796;
        Tue, 07 Jul 2026 23:17:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm17028221eec.7.2026.07.07.23.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:17:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:47:17 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
In-Reply-To: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491443; l=4100;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kjUp38+rZsebDdPzQoG333l/YriQXg1AGNOnuiL62m0=;
 b=G61ADCIY1Ze5+lv7CZtLAmL/rg7NSYIdGZe0glTwXeTJ3e1hJuMMhAtvqTpf1CVKN0Eo1m6OV
 ehcDpjAkQ/4DMDFp8tUeYKQWQLvlYdg6gZ+9qkcyv/n9QcDtEUPI085
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX3zg8M+ZmlAWa
 B1GHobut8pD86vsXVZ0GASYZh5ngi7Dl1Zs79KYpvy5jp5QzHK2I+yJduALF4Z0iolKEFtJdnwY
 hpGRLf8GCIF9XzQwM1IGhImXIWEePAE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX1lauSFOgxT+Z
 XT6/O0wkP13+KPezexvu2eMDLNxlYDdsNEaTBWdwE9LS/Zmtw/aJdPnV5FK0y6JPqSTg8ZJQZuD
 bc5O7ti9CBcQl2KUmjMHziQkbUCwKGUivurMSVWTBCRizMZALbWc5jEVi3o8MEoCIwGlR9sba49
 er9GZZp3wOlTFLkzQX/+mV7fRf6yFMC9WIpF/9v0CHtW93xELrzFZS7MsqimIVaKEMX0t8sPIHL
 qq6+uU0OdI2d4np+RnMkNxdUglhFV04L27H/2G1EWt2OHaWj4W3XSlVsem5nYjSh4Plt/DQESnG
 PYoDUV0ycY+WnOBGh1gLpef5iL0eBpJpeBi/x8ZvmKGEZDnlxAqJ+93IysJg0Zn/fekLRWDLGBQ
 HgjSfuMLWdyHoscP5CA5sHiTzQV0r/KKwQeEilG1/PhJ3aUl7u67/GdNLYpxXhUkP6f3iknahrV
 oIu9WA6E0O99jpwI9GQ==
X-Proofpoint-ORIG-GUID: HFJk-jPfqfM2TwzDEOD-A-PHedWzItQ_
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4deb82 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: HFJk-jPfqfM2TwzDEOD-A-PHedWzItQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056

The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
PCIe switch. Enable PCIe1 and its QMP PHY nodes.

TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.

Override the base iommu-map with the expanded set covering all the
switch's downstream ports (0x1400-0x1408 SID range).

The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
from the PCIe controller.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index 6d76715ccffb..e099b7c8c371 100644
--- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
@@ -12,6 +12,26 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	vreg_0p9: regulator-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_0P9";
+
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_1p8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_1P8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vreg_pcie_m_3p3: regulator-3p3 {
 		compatible = "regulator-fixed";
 
@@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
 	};
 };
 
+&pcie1 {
+	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
+		    <0x100 &apps_smmu 0x1401 0x1>,
+		    <0x208 &apps_smmu 0x1402 0x1>,
+		    <0x210 &apps_smmu 0x1403 0x1>,
+		    <0x218 &apps_smmu 0x1404 0x1>,
+		    <0x300 &apps_smmu 0x1405 0x1>,
+		    <0x400 &apps_smmu 0x1406 0x1>,
+		    <0x500 &apps_smmu 0x1407 0x1>,
+		    <0x501 &apps_smmu 0x1408 0x1>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l1k>;
+	vdda-pll-supply = <&vreg_l3k>;
+
+	status = "okay";
+};
+
+&pcie1port0 {
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+
+	tc9563: pcie@0,0 {
+		compatible = "pci1179,0623";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		device_type = "pci";
+		ranges;
+		bus-range = <0x2 0xff>;
+
+		vddc-supply = <&vreg_0p9>;
+		vdd18-supply = <&vreg_1p8>;
+		vdd09-supply = <&vreg_0p9>;
+		vddio1-supply = <&vreg_1p8>;
+		vddio2-supply = <&vreg_1p8>;
+		vddio18-supply = <&vreg_1p8>;
+
+		i2c-parent = <&i2c4 0x77>;
+
+		resx-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		pcie@1,0 {
+			reg = <0x20800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x3 0xff>;
+		};
+
+		pcie@2,0 {
+			reg = <0x21000 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x4 0xff>;
+		};
+
+		pcie@3,0 {
+			reg = <0x21800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges;
+			bus-range = <0x5 0xff>;
+
+			pci@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pci@0,1 {
+				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+		};
+	};
+};
+
 &uart13 {
 	compatible = "qcom,geni-debug-uart";
 
diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index cce65e18f979..363cabc5f55c 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2102,6 +2102,7 @@ opp-16000000-3 {
 
 			};
 			pcie1port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

