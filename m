Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6A409E0A
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615399; cv=none; b=G8esIoTpU13s8b9HwqqUgsOnNiaalY+Jql/CYIeajZ8Z/k4RgEE1PA/prE5y4IucLJuKYoLUUcp8859IFdX+I8ahif0R4HxBMnZZFNrGnLLXUIUL82UtdFc8xKPOQAsZ9ZCZsz4IL/Ucez70DRkW+ooGYRkTXigSCXkwF/QmHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615399; c=relaxed/simple;
	bh=ZifbSMwbsL6byJybvyJVqhBSYfY+Ur7ZoLWanU+zR6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuVlCL/RSHDbUK2/5JHDPLcUKoM+v/eOAoZ3pFojJ2AFtrxoVN+Krx72OOoJK4wdomJEos9vXv0kVma58vxHdwhPiEYlM+Ram8eTfGmF3/r9/+S5XoulG7u7ebeltzj0iyPlVbD2bTKy8xWXp5V3vtAcS1FBhuG22/RNz53bY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqklPy5Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dhi3aztM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqklPy5Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dhi3aztM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L44C5P534726
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cBQpj5JJuprPEDHJoD7J9a7kieOLqOFIM3U9fFzAGEk=; b=EqklPy5QRQAH5VsW
	4yelLrNi76jaM2bFOmsB7x1TGwfb4eU/+oUvm/bGazaLCfxmVfHMrLW0CmX0/v9S
	tIxYgzLWPZSZNN6sNQdx7/oObeLcY80p+8T9wBZmTb6Yx8eJkd7KYG7esUzmMXDO
	up0k5/zWl7CQ4jQi6YY/qvDF8dd9J5OPUiyTiUOGy/TFuiqUMOSDcJK/Gt6Y0t3/
	rYLHx7R+3wRpTJHuelocpwrf4q7xdiIU/ocTbU2ydXWCUt3zRVmTkc38z7AAY9aE
	gzywo2l9vhPfE8tpw3C8BT5PImuOSwN3QDbfGxw0ezmmN+hsXDhfcaGY4LPA2p9U
	JmYoUg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duggkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so214474355ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615395; x=1785220195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBQpj5JJuprPEDHJoD7J9a7kieOLqOFIM3U9fFzAGEk=;
        b=Dhi3aztMlfmt9T2bpDLw2RgGgRrpw4ctvLlDCKgLouvvkrT8+mmnooMlHCl5u8ynOC
         o6gy0U9zK2KJehADhA/hLjESwFc2rLI2I4yxypJ8g7wFMd6cFdD0KXLE4ikUiv9hkwPs
         WP9aurIHuz1ecs6DZpC3ojvoovwasZzeRDz1uIh91DnAzidMqMl/BkPPe0c/+EQQX774
         o7CLiFJrgek6XzQNFoFC7ln1VTaVW7uPvVVg4WiN562jgTHvVd+E2aynSYChUQ10XS8y
         I3b1VKAjyJTBOq+DbIo/hCZuYseeKQsOXtA5lxMv924TA+yeWZqxOo1JLDDieG99/tIR
         M1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615395; x=1785220195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBQpj5JJuprPEDHJoD7J9a7kieOLqOFIM3U9fFzAGEk=;
        b=DfLxRTZ4sfORb9BwwL4bpJteCnCYa4Z7Z/3qmrPVBFEX41nXIRXEbMkswmUTLh/O3Q
         Uk+3b/giy1rxNo1JTZ7z6RzlFgZQ5PTtL6v/B27fzosxxmJaGudxh2wU0+GTJYkzQb4L
         SooAOpO0Y0WY9tWpqRZ5GHHL4nvuP9TXqycuu2gGFMRXEAahe+N5crgrUpIQOgMmRLkj
         /by38hSVoz+15ogC/PXf/m3YapWp8abNoO2J82wHxveGfnUqPHGZ082Sc3Y6zfIML9Ny
         k5Acc4oFdtn/u+9a7jvIHa7OfdOuGIBYCy9mddPw+AndUm3MRhNGRsFWf+yQLq0vv0hj
         0/yw==
X-Forwarded-Encrypted: i=1; AHgh+RpL5LAQQP5aBRNvqyqiGBaV0p6KJXbIYWGLagNvHWV61BFK5jBxOzwSgPVknEcAzpylvzw2gzGhGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LnXByiOtCK9seEprQdV+L/pjQVoPfQyDXHgzOhxI7zDistrm
	IX0WjSPiE8stAeuxsTnIXsbHQHMEvYhb2a2P9k0nXWunFZG4Z8zRH48W1pU6jagBVnF4yvgIqhS
	QxfqykIFve1hCWT0mmgHa+tJ3WILrlXSDJvIJmwEL7C4yGw/0WiVjI6ES8VUhHg==
X-Gm-Gg: AR+sD12DkiSJ2/b4UgOmEbvU/NUDmJ6grNVisUolE3otC8pXgyG/eDD7r3tFLqYY0R+
	akjlTzTNep8KSsIhGc8Tv42rn2Zjw7npjoQa7O6O5s39M5knaGBGxs04c+ttRkUeTL57343JBe1
	V9vZWqkoDcwWcSaOlzPwmQWH2W3WAFcuTIVrI9Ad+6MJosISYVaFIxQWyK/IBONr21du1BDd4Cd
	RWiMkYaqbfCuSPqxep5LyzsJUyi5gRJACVvJhfOht5aReYtQV0GljUCSy54FfyPt5UO8I+a/LeI
	Vd9lktO1umWqsNN1V1qwYQGv4PQpEdPyOdkKImV3LDehzdFK/O1w9TSYdjeOVQhQ+aHHciPCBse
	NS5WF9Owamigo4YcPoHgmDLbyDoAuiw==
X-Received: by 2002:a17:903:13c6:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cf348686a0mr183194785ad.19.1784615394566;
        Mon, 20 Jul 2026 23:29:54 -0700 (PDT)
X-Received: by 2002:a17:903:13c6:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cf348686a0mr183194465ad.19.1784615394071;
        Mon, 20 Jul 2026 23:29:54 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:29:53 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:59:02 +0530
Subject: [PATCH v5 5/9] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-b4-qmi-tmd-v5-5-99620e07f505@oss.qualcomm.com>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
In-Reply-To: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=13045;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=ZifbSMwbsL6byJybvyJVqhBSYfY+Ur7ZoLWanU+zR6c=;
 b=cv1nNNK+Ow/xYBvH2Re5AaOymssxAIRJyPP4IzMDpVMBsdrOYbiF3Ux+VCNLnrTrbae02rTez
 u/kXa+jxmEPBX/1Ty0kohCScwsnBxLOUeo+9k/4FvXXpzaglettn4Gs
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: inccMA1D_HF1fCFwLvgMu7TRO7I7fMcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX5AVr/Jdz8nKH
 9z6FyL/bIRFlzw2X7dJm8/9C4sp4vz0ANzAbpmty9p2I52Ablws0t3fOuy7OLegF6xOCuid3aaI
 GoiyoAfFvho1lCzxc3VvxOJz4848V+qJVH9J5k54ULwb+/xjtbKp619XOT2WKuUj1bwMz3qPpmx
 HK5a/sn16lDGk+gBIST0cSpFpiJa/VtgE6uG4wKjFAmkvALJKLcYaZxJbT+DrL0+uVImnYgeu2Y
 Yh8Qdmjd3AvTVAyvgaQqGaUSZCF+zu5pebXyV38mr/pzTNai2NU4twQZ+lBuZ9MjQdQ3zJmAVoc
 453Qvvvz1VVWAOP6UYddq2h14q+C+9sLw9TweRFlYG/kZqE95goxkwab138lQQC4nKhuwKZQ5v9
 dITh09zTOzyCk3mb/KHyvEkPM6VHr/c4GAkxtjJX7I/3I3t+KKdJMmmnK4+/ydJN5pwpDXJ75Nm
 zHU3NxK6pACiaVH74sw==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f11e3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZbsVDflEkj9MvQmDaakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: inccMA1D_HF1fCFwLvgMu7TRO7I7fMcL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfXwWmKhZVxnQ3M
 kk2ojl2aL7B99LUfMLbbmFfrNTyNHXEiYozA2kwfxrPJU0fbK5eYrhudkdCBMi1IE2rJwQ1K5bP
 CintIVT8jx/CtkGC/VV0XF93vO+1gco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210065

Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
when it reaches high temperatures in kodiak.

Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
for modem when it reaches to 95°C.

Add polling-delay-passive so the governor periodically evaluates
the zone during passive cooling and steps up cooling levels when
temperature stabilizes below the next trip.

Since the remoteproc_mpss node doesn't exist on non modem boards, the
cooling-maps that reference it cause DT compilation errors. To fix that
remove inherited mdmss cooling-map nodes.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++++++++++++++++++-
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  29 +++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   1 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  29 +++++
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  29 +++++
 .../boot/dts/qcom/qcs6490-vicharak-axon-mini.dts   |  29 +++++
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  29 +++++
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  28 +++++
 8 files changed, 304 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 7e73348fe0d0..df5099023b77 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -30,6 +30,7 @@
 #include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/thermal/qcom,qmi-tmd.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3431,6 +3432,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -4803,6 +4806,8 @@ remoteproc_cdsp: remoteproc@a300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -4922,6 +4927,7 @@ compute-cb@14 {
 					};
 				};
 			};
+
 		};
 
 		usb_1: usb@a600000 {
@@ -7732,6 +7738,8 @@ map0 {
 		};
 
 		nspss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -7741,15 +7749,31 @@ nspss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss0_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss0_crit: nspss0-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss0_alert1>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nspss1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -7759,12 +7783,26 @@ nspss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				nspss1_alert1: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nspss1_crit: nspss1-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nspss1_alert1>;
+					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {
@@ -7803,7 +7841,9 @@ ddr_crit: ddr-crit {
 			};
 		};
 
-		mdmss0-thermal {
+		mdmss0_thermal: mdmss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -7813,15 +7853,37 @@ mdmss0_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss0_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss0_crit: mdmss0-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&mdmss0_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss0_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		mdmss1-thermal {
+		mdmss1_thermal: mdmss1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -7831,15 +7893,37 @@ mdmss1_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss1_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss1_crit: mdmss1-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&mdmss1_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss1_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		mdmss2-thermal {
+		mdmss2_thermal: mdmss2-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -7849,15 +7933,37 @@ mdmss2_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss2_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss2_crit: mdmss2-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&mdmss2_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss2_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		mdmss3-thermal {
+		mdmss3_thermal: mdmss3-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -7867,12 +7973,32 @@ mdmss3_alert0: trip-point0 {
 					type = "hot";
 				};
 
+				mdmss3_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				mdmss3_crit: mdmss3-crit {
 					temperature = <110000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&mdmss3_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss3_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		camera0-thermal {
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index 82ebd88f9aba..befd3f908ce5 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -24,6 +24,35 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index e9a932c90d14..48751bc2265d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -25,6 +25,7 @@
 /delete-node/ &rmtfs_mem;
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
+
 /delete-node/ &video_mem;
 /delete-node/ &wlan_ce_mem;
 /delete-node/ &wpss_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
index c8eed8ba93f5..041a02a03d1c 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
@@ -22,6 +22,35 @@
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &mpss_mem;
+
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
index d8a9a7e47bdc..764c9dab046e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
@@ -23,6 +23,35 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts b/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
index 4f2e0109f49b..2a49f07ceed1 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-vicharak-axon-mini.dts
@@ -25,6 +25,35 @@
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &mpss_mem;
+
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index ac89724ee099..ccb13d2fa5c0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -28,8 +28,37 @@ &ipa {
 	status = "okay";
 };
 
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
+	/delete-property/ #cooling-cells;
 	reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
 	reg-names = "qdsp6", "rmb";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
index 3ebc915f0dc2..87b8ed5d1893 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
@@ -7,6 +7,34 @@
 
 /* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
 
+&mdmss0_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss1_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss2_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
+&mdmss3_thermal {
+	cooling-maps {
+		/delete-node/ map0;
+		/delete-node/ map1;
+	};
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &rmtfs_mem;

-- 
2.34.1

