Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F044606B
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626356; cv=none; b=MPDFEJ0mtgx1uo2cNXc4l4GFXBD3ZAHpPSgqRWw5w6S5rE6cAPP9mEqzcDpXXt5RvVy0KAy7F7f5Q+Tn89EeQFS16OUt5ZKWFXja38lSzLAy3E8BmxksP7ap4GzmJAzr479Ol0TmVUwvBplFIAvAKl0PCuRssBWdbCwT1GxIA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626356; c=relaxed/simple;
	bh=k+frQNT9gSOjezLDJP/F4RiMfKqWKyQxc25TjbQ2p+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLaYscYCwwNB/MZ/9FPdOsclxWEtvaOmlCdpXFqgRzwj4/YeX21GcEJBXBU3eTIzEODeiJIUhvvtsujsLp8vxqFNwXzsVnY6LK3g+MiywonQzN7k2vEUKwbfrvPhuGLH6rmgQTDmg5kMoqK8QTWYTkNIkm2whYUP7RBBdHVv0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8L6dLv9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3HnnsY9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8L6dLv9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3HnnsY9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L66iJK046421
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nAwcIcDmw3iO32nZvjxYUJMQqhgi6ttqovILEJyu0Ig=; b=f8L6dLv92R+gcx/c
	vGzOcLRaz5d89wji+LdoredEc6rlnrB/e73Nc9yPDbFgymM4PDu0SgHJ+icNMqUR
	ljYLVO0/PM9yhDTnkrW26L4G3R9T5EpGQBXKMU+DmVdqkbkBJFpqXvr1CQ3bKISY
	9+yFr3aXoZPLtT/E3bWtrRmtos8S6ShKCSDNaKhT1PFq/hBngkAvTrTMQuEQsFWI
	muFcdD3bOVtZI25UdB/XO+Gr93h7z1mwsxzlNKaMPv0CbrDIXl5hR4QjGTklypUw
	VBXPNOK8XW8yyAENImJXxe0YwG1LusQBP9mgtcVY8XwBcKIOL9FRdyAw7O6KL6Do
	xKhXBA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5upt0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:32:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so4326898a12.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784626353; x=1785231153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAwcIcDmw3iO32nZvjxYUJMQqhgi6ttqovILEJyu0Ig=;
        b=P3HnnsY93eSB9KfbJNpQu5qO6oC7vg1P3gqDcBObz5Rmq11P3AFQlVNuFPeUfiw6DI
         vzvHUzWR+rj749SLDfoUwPueMiAY5yLGVaNnxtyxI8n7cMbOEoKSpIc5UX7mBdhRM33X
         LupaFzh5p8Ix0qlu33LVRDj943Z5Up8vC5DYYhm4yDU7ZqCCamG7kmMMhmJoGEaLzYLG
         QEgs/cGrtB3ONtyajy1609bkb6UU5xEHl7LM7RT1n1Ce346Mu+8snHnYBF43fz3zR52B
         bqY8CON4CCnlArFWYJ8nzGvXHnhOuxBMdcZGJT7mQaN6kHCNFZxtLU14exrAv+A9mcco
         dgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626353; x=1785231153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nAwcIcDmw3iO32nZvjxYUJMQqhgi6ttqovILEJyu0Ig=;
        b=FN0qf36MAo8Yuq+GVhCGIc+HLfnAyXlpbYi0kqV1flJEzDhM6+j01MLJRT/QIDMudO
         oEMgErVsWhEWdK3mj+OkQR/pai+9fCWPj+5iEsyvbe9GHhWk0X+sPtByv8MLrskEZmab
         bM5iuzDwwscMb/ZdQ/vv1p06JJUq0idWtZYYjjOsxIr6WCTCHUSsA728yPK5FNuw92+/
         TfTJJsXAbYDfKBOm651zqZCwfbRfFPOMne7SMNeQwEC/iKr0+TSlbKoRAzGK8QNJpZcG
         e8Vu5HahoNdZqRvHm1/Gu0OfCW7/QgUE9UNBmBIlIxngNstQbC+o0o24tMCI8R1exDuP
         P7eA==
X-Forwarded-Encrypted: i=1; AHgh+RreAwHxeBkD1m70E5LfLSe87MeqBPIK1ZJjakrV9nEZDT5wcM4XMbks5DWQKcppG8Q3RCdsbBU/Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzBw/5/zb82fVWGkRxsTbaqrJmrSiQEEGewaLTbt/V5yMl5/c
	nNnc3toi9pMwo0qfUNaKGMAUJayQYCh5xTNkX4Icsp21E3XAMcHGbHfYeyxfU2cc8RNDxWYFTbC
	B/cT5YlYCvpazFHCiG4ujkIDbOHGZ/jqbhnpj1/wTSHHvAlSn5sj4s07D45nByg==
X-Gm-Gg: AfdE7cnY1k/RuqMIQi33ddtxV9FjoxTFEJpGMylpq4NFBM7m6T1b6h86jWUzV+gv4gm
	f8lv4l0xJbztAbI0gzEwZRNYZE2P71pmCrgyKFKhITBMcF4niZrpGS/lzioqPu5RnZjw6TVcoTA
	GuY3z+ie1+lGze/M9uLMQEL3LuS7HIPjHwnoRo10Ys9VBc2LyXRf4IgyQNr+HfNkQ/GhPpoUj5o
	xttFi9mVaRkC6COGXdLGhePzvR6l4FgetwEu9h2PiqDyu3lQpvdG+BGkyjb/1s1udqlUPux7Szt
	KkkDujeIdY8m2P/F6Djgkf7pqtI4prmTYn830T8grSFxhCrFeCUY5RMK0O/3mvYc2WmWZB3HZlG
	9AlJ2J3EO+MNHd9iBUEhnOkjFrzpzFgoRlmc=
X-Received: by 2002:a05:6a20:7a9d:b0:3c3:b5db:cd07 with SMTP id adf61e73a8af0-3c3b5dbce30mr13522098637.15.1784626353293;
        Tue, 21 Jul 2026 02:32:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:7a9d:b0:3c3:b5db:cd07 with SMTP id adf61e73a8af0-3c3b5dbce30mr13522068637.15.1784626352810;
        Tue, 21 Jul 2026 02:32:32 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm49420949eec.14.2026.07.21.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:32:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 15:02:04 +0530
Subject: [PATCH v3 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-eliza_evk-v3-3-92b10038f13d@oss.qualcomm.com>
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
In-Reply-To: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784626334; l=4157;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=k+frQNT9gSOjezLDJP/F4RiMfKqWKyQxc25TjbQ2p+Y=;
 b=tX24YS4xWCm2YudzuvZz+9L+TaNDRK9PmGVMeHUk/1qKUeoTWqm9iT2PDwiK3EcHnMcEyQDOx
 u7eXxXZAvgwDvJdc2zacBhVoUtpEUwCcJBP/Vfr3N06jbvbC2OpDtwJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfXw/vwcoxUqBHc
 hj05VvJRn0y0od6hohHDtKXvdL2Vw0Nu2mPVWPifbOqBEj23dcRp76wz7HL9HvmZ3dj+EQf910z
 BTjjHGwYZKFqy0vPd4H2hwwy/OiVenlbi+SIbgm9GXHoN+tvF9JfNGKHxknHPPG93a/Y2pCeZxy
 M6x6WkM/rEJMpsOIXWdaYNMOMaOLgQ5jg3iv7hef4cibuFXO+uB1NMqiyylHvdGhERKbVPSlWXJ
 14rrc0lFcOdi7/bUmXioC8Tt6VtjB/w/AZsUfS5nW4jTmb/JcVp4phIpstXxBb5Lw0LIVOVOjxw
 Kg7pkNq/pCPvc7ELO1REALEatROB/l4jHI6kNwoD2MxyF4NB0ks3OgeSmDon3iUZaeIu4sUZ52U
 N8rxF/cwLz9ehtvKlPs3RyeqQErnRECDZqXhZPwPt07bnUI9/jpHFliGKVPGwz1mZPTW2nUjoaa
 hAiA0TFYf+51VyEtmdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwMCBTYWx0ZWRfX8BBdzk93ykG0
 soOtpRrJQMSY75TBA1dGAF4ATGxZ/80XL29ckHZPfFXI0WrFHd+qy902NVLKXAVh+Rpowbji/7t
 1/2x0ci+VprF/IdkP4GQ/AzplDz3Uao=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f3cb1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: H-ieGy88ggKON6cSZ7EIWqWj-Z4Jvm3Y
X-Proofpoint-ORIG-GUID: H-ieGy88ggKON6cSZ7EIWqWj-Z4Jvm3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210100

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
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index 6d76715ccffb..fb44e7a349a5 100644
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
 
@@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
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
+	/* Same GPIO is used for both PERST# and resx-gpio */
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
index 59b3cf7f168d..cdf5decfef48 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2103,6 +2103,7 @@ opp-16000000-3 {
 
 			};
 			pcie1port0: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

