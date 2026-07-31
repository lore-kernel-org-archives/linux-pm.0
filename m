Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251442C50C
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494136; cv=none; b=ssBXa8yadM1cnB626L38TVTJYm/WaLi0Dd885DcIQH4fhjNjXotmtu5rZ4lZfzwL3Kawa6avIZSVGShgLbC8e0PpjyEtved4xjsSzBeVxaZd0T5smR+IU6l7NEVHP+rzxtuOls9GVNmPpxocuNPacx62vcTZEi5f/QtXYm79tnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494136; c=relaxed/simple;
	bh=6vbB4hBh+gusGs6dkiq1dbLEwReBdJNRJzcINxJ4Zro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF5e7GIge7EW/MvTha5emE4QmglG89SubQv7XSG4kpWZEkhJlSnRLdFFHI5ISxa+FdGOW7WUdr0ZBu2hdC4LRePHXL3z79dWQNVY+vhjX7Q+O+W2zLS7vCaHxczlsE37vCt5yecSlL0LOlZaRZA6NAsfYAijGvOPM/AkTy+fkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLLMdFg8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YAL8OAhV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLLMdFg8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YAL8OAhV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC5tE3851005
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RzI0A46DWA9lcb4B8wkaFvT1daqB8HHaBBKVkBGVxPw=; b=XLLMdFg8ADivKXI+
	ahul3iK1j/BaE4hJY3SoU/NXyDrDMaiiJVF/4YTHlWulHG7wV75nNsU7tkOt1b1p
	AbTXrtlGW9l2MEPreBF8qEvdDqb+mCpyta3/XydOTrPwMLomSP6ggaeJM4acWm3h
	Y5skk3LYi2oZfxY3dOcpfQ8+Fp0dPyeBKQcImIbAwuJXDJaWGVLJnbY/ouhzcW7p
	tdLAv8O94IPJwy5J5dG9B504xIKdcspyFjGhGcyHHG9oH2uzEHERJo5MR/oSJz8Y
	Edus5PgtjZc1vbKi66mz3c5inxOI62m8wkaMNBcM70IzS94J7oBi77/OK2cxVBw4
	SXwrpQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsg204cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so2142088a91.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494123; x=1786098923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzI0A46DWA9lcb4B8wkaFvT1daqB8HHaBBKVkBGVxPw=;
        b=YAL8OAhVt5HTyoSaWCP+b3mFBXRTFPxFn+efWMuo1ZtyVkfqtdxX/via2c5bcCawFn
         VHRyR1PynEgNC6RlrK5MdQVScLX06i5kC1NpgIvciCdZBVaBzpMqTxy0Vb3Zb6I/yGL3
         dnwDGBNjl7jkWsrFjG/ws3dLZEPJR1erGmIds7Bl+CQF09iOTn8Pse9sQgHBtvyuBU21
         zOdL9zoQSloS0CZORof/QheoCvosQnOwBdgn8wtqRFI6NSQUdcDZu5HKxtKCJ1C3HyCN
         OhkhRbZmEF3hoaKYKEcpcYlL86HqGE2kPaM9YrfxOGHnhebPk38N0Hb2zXbJdq3/UVFl
         KU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494123; x=1786098923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzI0A46DWA9lcb4B8wkaFvT1daqB8HHaBBKVkBGVxPw=;
        b=Oh4oNGjdp+Hb0t+yQ3ThbYohDEvBpX/lhSScmUuo+3a7eN5/GwQtUl+kdOLHOsGufC
         2ELOdbCTpY5hgxOlxsbbagjxOidjbBtz2wnK+iFK3ep50emkdb9ijCzIZYC5Qs6c6ytx
         Wt5q0J2+jldlyu6oHyZZP8rhKZx5SfCkmREMr3vPoWMbyB3se1iVQ3CDhK5d49hgbmn5
         ubJlDa2TwkoQC6RIfRmAqt9SlZanWiNTGp5ke+APkaM+tg9JSbYFhzYXNquUpOaQ+A+W
         hZucfCb6P/3HiiKjZKjuMyOYvD8wDn0cwhMV4/YFXCsrV6a+tdPUGHosxLXDDKr0jp08
         J9cg==
X-Forwarded-Encrypted: i=1; AHgh+RqVcdczMFgG8VL7627FA1VGM/dI0G/nJmo+7fnot5bRpatg5M4tDRKqmBIWsUBD2WBeE+H4jrLQsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zYtRF4YCULwnslmCt2pMOoPn86ujLhAcdXc9S83n9wAe0fAI
	LVykli/VXddFsYSw9Fh5/JwWVMoqjOJkISatChTF28OiOjuNasu42yD462vAHY+XyExVf+pWv5M
	fmCHFSCsxH4vwXX8PSmhY1NSa0fZcmH1V9Qi0FutgJsq9zSNDi7IrOFIcyQSqKA==
X-Gm-Gg: AR+sD11GrXMtbLWiXpDM+DCUMc36njSLJi1jNSr5kO+4ht9OjJ78uKe4/ERzx24X8FU
	m4Yryl20vt99Tu8crz75j1y0lKvo+OAZnU+7KdTyleKuB5GmpWhYChRb2bJXHVmO4aPnMye0q6J
	mpwrsuKcZEIC5YhcWBqSBpluSj3kXkNKBT2gCGYxDSTUToSGJUqWTMRSqz3T0QBHs5I52rHCCCz
	RZWo2z7kMQH83yFbLbGeIlUcTZg4Cm3m0s2k357zcdbwo/EaIXsDtGgvvHgitqtttN/UA0T3hCx
	BuSelM1nxMbblXQ5WfumgVhEUU7908hrKqYQreGznyREhBP1Uz4AZlzGzUlejWlCsnJ/fTo5h82
	6HC4aWBy3uqh0rPamAR75V6bjUyqL8g==
X-Received: by 2002:a17:90b:4f84:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38fb11546efmr1413735a91.17.1785494122598;
        Fri, 31 Jul 2026 03:35:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4f84:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38fb11546efmr1413709a91.17.1785494122124;
        Fri, 31 Jul 2026 03:35:22 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:35:21 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:49 +0530
Subject: [PATCH v7 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
In-Reply-To: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=4850;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=T+LWXFgO37ykz7QFpFuPZJtNbUg0dFqDmwyZszrZ564=;
 b=47uwe6oyRw031WnV6NYULJm0jnaGNFw+LCko0f0PXsOYCU6NZluyF6bsO0NLfe/h4g2oopfYG
 g/kAXu7Q8vZB7aMI46Nv3DlPoweO4Ra3EQXFfVXom718Oe/Hf9G+a0C
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX0/8S4JJxF9kN
 poVIU7lb6jra0QRjM7dY/DqS88dgw4emo1CJnm75AlJpgxHM+dxwQGeIV7R9M8jCfvzhaQ/PhBe
 iwaHDDjs1jElylSyqAUXmz2WdhInJYo=
X-Authority-Analysis: v=2.4 cv=Yvk/gYYX c=1 sm=1 tr=0 ts=6a6c7a6b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ND7YSEQ52W-Uskv0B9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX7HtKF8o5gB19
 YtzuOsUy4yZ7oJv/GkhcvGRFdlrspLVHjQWb7ONmO2OA6CTggXvoH9e0qu5bnqxQMtauVQpfmHG
 qGb1u/b+8xX2f4e0wfl1NyxB541cbD7j3wiZqFK1+vkl7pYoHr2dE/K37lOBOI+FNTV1F7Zm3kh
 YIMtGu+zdzXCyyG7MpouMwrfjt2FZfmXlIdgk0AbqaZxgtR/dpqb3xLk67eWngxsVRZTRGhpu6a
 c7Z5lUbWrSLlrmj3u3J8diR8Q7d7w9jM33EvuakIU4/yMELF6mgBJkvLxRGubHNhnXO3aY0ZrbN
 DSVMt0Aets41iDxDkUNw2TO8EUoTyDIMLCMkYBEamR2zuUBLRkokO6EfjiIr03jKjJNwB8H1DQw
 J8037KHIZGYRi0RMl2Va7+GM1V99tRCc3iHsicMQaJfOCAHdWnrh3Nrudc2cW4smvCZOyvDHEsk
 8cJQRk4FR8E4LHi8sSA==
X-Proofpoint-ORIG-GUID: 9IUETRQWeBo4UrMnwAjrmjvDkcXa1YAK
X-Proofpoint-GUID: 9IUETRQWeBo4UrMnwAjrmjvDkcXa1YAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in hamoa.

Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.

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

