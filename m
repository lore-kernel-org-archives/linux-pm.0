Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B10388E62
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162254; cv=none; b=DZbY0NlYAe0W2DLTpP5RAH1DgkLrEareM4j/PskW09ctMvndvKo1grll7cJxhB9XKJUCMcrhDoCcIUZopLemkC8d5ELhqbk+weFxz/MgejMtffakmKjGNUY9wX0Co5/gR3AIQjL1My53V4z5NDlTmDQIY0Dv322B1mkLQF471ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162254; c=relaxed/simple;
	bh=jIQfZLMSJBzSK/iT0gE1OL6tn5ICoQylSUCAFTgngWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CT4sXiHSyt5TfI0mO5sq80cfCOwCBiDEG6dtxOsUJ6Azdi9ndJb/1Q0LKPMb/673LBFOhkMaACBNCW/jG5TKv7vqNDq4V9USBIr39AcjNB3STq34i+eZuSHyovASrYBVvXzWkP+5nCyKMMLoZsx/rwNOvgQ4gJYzb2A4NZ0lwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QUgQR1M2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ILu0FTve; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QUgQR1M2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILu0FTve"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaVH3414006
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SxnXnJP+PJkcwf4BBFHK6cKCPrcBW1oXNVhH0XSA4z8=; b=QUgQR1M2q1mVbrMg
	BySwJPkUeOUQJVRXBrS0JBARpZjrTcMjds3Bq37bi7R06rLQcfYvAQt8iZXzqlOr
	OBUGADZfQOG4HDk0QhSO/MD+PyTkbXUNSsK+if/XJ0XS+gT81tr2JyZkiKLSuX7g
	E3ZtJ5zKF8ReBHMI6ysjfPF/Wkmj9yz1DaQDsm6HarWUo1T4wBaO/BLgd/Nr0+Sp
	sPx8+cn3/tIIXXusTxmWwRRHfyi3V1Vuh0kEGr1jMAFnlfZVeiLxwKxVknMtRWSi
	mJmKgRmin+tts1ZovrBh3A4SMAh+Rgcnc/G/4hX1cs5+ioA1dHcafWXVe3xhpdfM
	OIVyyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v692d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:24:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso39733475ad.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162249; x=1785767049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxnXnJP+PJkcwf4BBFHK6cKCPrcBW1oXNVhH0XSA4z8=;
        b=ILu0FTvePaP/a81i7bfOK3MpSL2YskWWKbnG4BLxpvxdFSYPAfNAkaOPVbBFUjA4Kn
         08iXnaknNpTuXzeyN5gHl1QH0gIN+/DOAIMfNPAsQVhlUJky94/iym/NoO1ZHhtt5i//
         BaFHF/E4IAs/4kkbW43as2BUxyQp1Y8EpclDIM3Yzyamxq0iIrvyp5ogMC0rbQ9uZ8EC
         QRlTJjLXFziMxhKumJg7c74pZL2CNlTIuc9Vd3kIlkZ6c08apvh5A4ZPEGnYkxobcdO4
         Oi4e2qSkC3Ym1crLnKk8X/m1Q/xMzP7LucwiFZwNEtTgAAoCLqmeQ1TkMzm+LWq/0/GG
         6BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162249; x=1785767049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxnXnJP+PJkcwf4BBFHK6cKCPrcBW1oXNVhH0XSA4z8=;
        b=Ku1fsmyQz8ConT91Apq8aF02pOH8dqC4RW2/zyIMeBOztl7zk/kAFyK+0yBsJsePi/
         ITLB5eagUJwz16cZUQbsvccmd33IGQE6oxh9T9xrdCl4pz/0/jJZKgsbruo1VvzhsfDT
         jrDHKrJAHQESvE/VCTLIL/MnArqNLf2Z3mq+l1ZPjYbeVi76RNPJxeApnOocMU/JrYeX
         6KXIWDV2Z8eb1FdVf7pVryZ1amKnIm9mrujkzLISl+LRsalEw798B8W72M/sCsq8l0y9
         DdAegpq5oKzYjehPTE3UHXWjLN3gmq24Zo+/TEa6ZqKR+jLqVrapeuN0m+Ci0XHLDsPp
         2Kpw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0r1q/GxrMJo8WLxR3FsWmRKPfuqM6zJair6Z1R0sYM56niXT7rIK1Ys2aYYHE0dblCK1lI1oLAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2mmhzQKUIHvVicBQqwhXJ+wPupnKrpdGI3Rc29wEVdrLd8NX
	50Xea3xGU8mXo0RTGT8KQuy/v54/mWndqffKF7MjfVo5Ad37QFgZFs2ZTMcL++VIrAZFiEBsSou
	Eg+V5Z4RoZSUbIoKlZaLDsfWZR4DUgcevj5AJU5K2sMzQWcxYVlb6CTyZpdxT/A==
X-Gm-Gg: AR+sD13pkp6WIJvlrCE6CXtM7TihmGFwb/NnTBaxOQaq8Jrsyeg2V0zgUD3dL7TcJuO
	seCDlm//1qCLcnOvibMkilsTiYJyItjSibkEJx5/Ugj2XCq3lKv+cmAJeyWsfCtVpeo4QmQ+Ny4
	zSOC6NVxdtjq+GgoZr4ATOy2fsWeuVGEm4hyHwYWg9gG9yB/zXiIRK1jTJzWKcWdxAZQA7dCQ9x
	Q1sP5CUr9CCFEu+a3YyGYQAQ/PlRQgjzIXQywMscKrCxy4bolpwRfJCiHAF+Y/ABbSkm24TBij3
	ryJ7X8bpX4NQwyR08Qb49YTa07ARFizjnbYGBZ4Fo/KwLJL6vnb3RjYgonyPonQCfnSJGk+wZzn
	LG67TBk9wqYUq+LElV/CpY4ORE3F7bg==
X-Received: by 2002:a17:903:fa3:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2cfde795b79mr79412845ad.9.1785162249233;
        Mon, 27 Jul 2026 07:24:09 -0700 (PDT)
X-Received: by 2002:a17:903:fa3:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2cfde795b79mr79412435ad.9.1785162248644;
        Mon, 27 Jul 2026 07:24:08 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:24:08 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:26 +0530
Subject: [PATCH v6 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-b4-qmi-tmd-v6-9-973cd3a226af@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=4870;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=nMWjqE9gYPP4NRs2/TABP+g2MZuRidiDIRPtjcqunkI=;
 b=DgrzZ8hAzRKF14a5SEFAe1US5PjxLhbcECKfFtFavD3UVHyYFqK4sGlveVDNk/BxMmHD9i0lB
 +ZsWZA/kzYjBTnwf5znnfKgAFK5ePO44FbeNbwUKdhbyvQ/IKi447Dm
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX9PFH89isgQhU
 qAeJbHTUn/E6HWouyBC0Xv+iJz7P1/zzrGfjPVzI9QOAKlRoLOx0ir2FdSl63tqq5s4dAtREM46
 2XKvLt0ZyhU25hTOfjyowEYiykF/OAM=
X-Proofpoint-GUID: T-T2AnlrdiAuETNhJCI8bLq7nnqW-6Hp
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a676a09 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ND7YSEQ52W-Uskv0B9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: T-T2AnlrdiAuETNhJCI8bLq7nnqW-6Hp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX7BgKfTJVUK8V
 fA/Vlu4qW6wRqSqGSEUfompZukW9K6u69G552hHdYhrmJ+JcSI1/H4S3KLvIsliBYx3SQrNqonN
 pmG/KyhPbP2kTVO1XKdGKo4Sl6koLMdgZA8sGI5W4V11A/RTWPqoQBF7Cd/0yaslQeSI6FIvDj3
 saCOQhbx7++elxxttEaborVWTUrqPdqap9hdZHayexB/DuM2S3nN06RaXmOeawOPLbeafopD/Gb
 jNlM/6qMi07ZzKPezwbyY8FYeNw8Q35sAzlX+jAM1U2LiwV4xubAuwk7B89nyXeO69Y60L4OjMI
 YQby4QDvrI07nf5Hhngvpy1hVE81Hx0y/Wou7Ou38wIXFtogiUIUhru7969w39VeNrfoFfPzoEa
 pEUBYe9Wd/gC/tVqR2oG/613pFnjlJ3++/uYiwTt7VaD8DbjKq4+LQTn+XgMCBZ0dAzrO2tyEih
 Im96GK52BL7VXpYRtNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270136

From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in hamoa.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 95°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 9fa86bb6438e..a146be1cb5fb 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -1684,4 +1684,36 @@ trip-point0 {
 			};
 		};
 	};
+
+	nsp0-thermal {
+		trips {
+			trip-point1 {
+				temperature = <105000>;
+			};
+		};
+	};
+
+	nsp1-thermal {
+		trips {
+			trip-point1 {
+				temperature = <105000>;
+			};
+		};
+	};
+
+	nsp2-thermal {
+		trips {
+			trip-point1 {
+				temperature = <105000>;
+			};
+		};
+	};
+
+	nsp3-thermal {
+		trips {
+			trip-point1 {
+				temperature = <105000>;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 09527dcf9576..ba453c8ca80d 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -23,6 +23,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -8971,6 +8972,8 @@ remoteproc_cdsp: remoteproc@32300000 {
 
 			status = "disabled";
 
+			#cooling-cells = <3>;
+
 			glink-edge {
 				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
 							     IPCC_MPROC_SIGNAL_GLINK_QMP
@@ -9558,6 +9561,7 @@ aoss0-critical {
 		};
 
 		thermal_nsp0: nsp0-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 1>;
 
 			trips {
@@ -9567,15 +9571,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp0_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp0-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp1: nsp1-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 2>;
 
 			trips {
@@ -9585,15 +9604,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp1_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp1-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp2: nsp2-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 3>;
 
 			trips {
@@ -9603,15 +9637,30 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp2_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp2-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp2_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_nsp3: nsp3-thermal {
+			polling-delay-passive = <200>;
 			thermal-sensors = <&tsens3 4>;
 
 			trips {
@@ -9621,12 +9670,26 @@ trip-point0 {
 					type = "hot";
 				};
 
+				nsp3_alert0: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp3-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp3_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		thermal_gpuss_0: gpuss-0-thermal {

-- 
2.34.1

