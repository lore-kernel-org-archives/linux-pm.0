Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211517C203
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278660; cv=none; b=TRm/+FxFuoril3TbGLOhbdj5hFk8QqSD7GFLhxX3XB0UZJ490T3Ek0+AWV/7FMh4tU34zH9CDbZ8HAs/DZD3lGirQEItAL6ED6TubnAiNRt6y7Tf8YzLAl65wUYhqF8g2RRK0gKWVhRVfrBgfLGnOVWfXN5s7arVv/fa0EDSkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278660; c=relaxed/simple;
	bh=zu8gupPC5A5PcDFsGHMjuTQqaVyyOo6BMNe0DLfwd9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0hzp8QvI8YRyNijxa6Yg02N4PXY9hwyp7oYmUEnLHAn6MKH+uPdzhJvldJAZlKVyrxAXAo4JW/tFJvGO+xzCDowWP2U7t5pYtwV0yaXAgoTHxciGQSiV4tKcTWNz2x87vUjnBejSVfsoDoRILOiKFqyAbY+PvWdOM04eFHbYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7Rck9f7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bvyjF7K4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7Rck9f7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvyjF7K4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C1a7b2369450
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=; b=e7Rck9f7U7Xk0kkv
	lE7vbK0C70Av4myH8SXXOFIrRwZW7lAtF6vebC9IJDhPEVyU8uEtRk2IC3zqGw0x
	IpplR5sfrZBOs4eh0orYR7xNRLuHT4OJHt6Xr7Y1NVYUCdtBT58UnHiLFfnZ1C/h
	QwROUeCQGGXOrYOuvlWxd2xOjskmMsZXK7GJF4c7kgHYZ1JpoUwo3FFPjpz1q5cV
	04zlWa5Ird4o+I6VnKatdo2gAN045ntui3eIwOjMrnvrDKf+h+eA/PPmXadnq3Pf
	Px5sPC2qfyICLaQRzUUmKc8SwfI/9a0VMWD4G29mgAaQsuZZ2JHiYYpPRcFXUgl8
	16r+QA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fww7ctrxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:30:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so2444161a12.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278656; x=1786883456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=;
        b=bvyjF7K4Rkp2sQzfJFs7torkzKgjrWQvRNCfZSLN0irWZMEm1N+rTpIGKD4xgbB7in
         ex4OZyXyASebu3gGodbgYZI2lBBSX54LIfoRS97PnM99Wpwdtl8HzVvJPTTTdXOY7wro
         XL65uDzoJ7YHRXr5pmSABm3YuoLk9U6UApspfybW/6Y98SlTjdEJfu2io3W31Obq5wtk
         J9RFTU52idc0Pe+NhMTulOg+T30jQ+fQALFZXlcsykJAsF/p2oWDsPMAM+p3Rh99W5KE
         puJPrFv32rcspKdvI3SWqMNChIqSz9PnwpJb0gh+ZOtIXHftb8+6VuJ2uC7wAWzTFxC5
         706A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278656; x=1786883456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=;
        b=OoGDNTDDxm7uqh2+UCcalcCi27S8altrRjYTCQCGe8n4i9B1gTfImx4Y2k5tDFaFBB
         H2quVvk8wTxcLjdhZ7I4KhSP4zrVv4zLmrtLLK/feiros7Ml0groWEwLhHnyEiB+mTbK
         plPEjOe9kVMwbMTYTH3OQVizvh7OEP47khWrb/n1keTPb7VLitlbZXrljE2NBbXyqaKO
         sXNapDE+KzxBS2dcyau0REOSdHQeEmPdeBiDEpWUSWy/qGqUV9pOpSf5EG9eUj+DWf02
         TYD+tJ1ru0yNyHK1/K/o2smkKk3rBDa0+3j9zN2FhdQVS4FDUvTavMmvV11saEPlz/vB
         kTnw==
X-Forwarded-Encrypted: i=1; AHgh+RoUyR+sLRahlh6X57rMllwZTY2ZcLyrPkG9qUzM92dBplByCXCpQ8t3G7WiR7xMUX3DUF/JnVUCeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lb0UD+1jymzzuMbjxLMz8cNCuzzz8FliggBv270uXdmrOYgU
	TGNqS4Tx+H17gjz1o77FKqX8i0LLr36cMFWrmSqRppu+Ir1DaqRxI3W3x3YhJNpYIQ/Q339HJ7W
	GM5p/c/GSKCDb0Gc0ACZjkiWYi2RXcQP9t6ah01e7PpGqa6KXQpmR1fgOlrPqWg==
X-Gm-Gg: AR+sD102fno3BXVABEckbpm+FU+fgXbRHXVM4tJLBf2UkFz2aD4fxJEhXoTdUUpk1DC
	50rpftgQUnhhbDu0+00RyjEr9OD+ciAz6RgY3cQkeMEKQICkAcoH6sSsWFeEYpAZ/o93HsYLaSn
	6Osw2kCnxShTNw8FtvBO0iuAW+kNBHLR9tJjXUskUEDtHtm679KcadvFa1BjtaggfYgWy4fBCT3
	xLGsalkjwgScN6KGGexh9CUJvsQ5mKVMBnEsPARXzn/om1aqk5MIGppt7osgIKsB3cGh0pVTy2p
	FTzIvs1I1+VyDjS508T52WWTQFNS+XZdSQOzDAaYnJ2M9HR2Fnx+5ZLoX7O/rylPSSmuKzdOyOX
	9wqxc3wAG+2vr8fTT2VeVzP3KwTVzsw==
X-Received: by 2002:a05:6a20:c91c:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cbc0103aedmr21463763637.7.1786278656426;
        Sun, 09 Aug 2026 05:30:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:c91c:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3cbc0103aedmr21463673637.7.1786278655963;
        Sun, 09 Aug 2026 05:30:55 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:30:55 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:59:02 +0530
Subject: [PATCH v8 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-b4-qmi-tmd-v8-6-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=8007;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=zu8gupPC5A5PcDFsGHMjuTQqaVyyOo6BMNe0DLfwd9A=;
 b=dz0OGi088BybR5zzhMHRgn+99FZsBtqLoX4jKx7GoDRSWOptH0nOfIKtSo37nCU5/tPXboV9p
 ZJLN3gGUiXABK6FpXG0USgsQ1OqY1Ss8cDmbe4cWTzBq7suLOkSACrH
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: spWiVoZR9jItB38RYlBlB9EWKVhvTxPo
X-Proofpoint-ORIG-GUID: spWiVoZR9jItB38RYlBlB9EWKVhvTxPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX8zrHbv/XzRY2
 UGn72dwz3WDHg++9d9mHiH9UQWFNE8JU/fUCOMY1ckSYwR6hqYFZQ6lVdUb3e2y1tt6XgMnmsZJ
 puoxlq9hRgCCP5L8pDB2zzK0irw14/SLYRMgoJXVx2OkEn7YcB86gfA9Rm6rfzNtfiBnO8+cwuQ
 21PhYoTyIYp6SE/cDa4Yt97z2IrW+emloc32QZo4nMNBnY7uu3WP+xebUfAI6RCpdqyw2Xhi7Hf
 TNLpn8Jx9TXR9cfZxwCA02F3YvPyi6ofDcQCZb3SDLyThafaGNFT+RVEk6IhTtnx3YKCEezel9q
 gaG7K6EA9jCJiMt4D4w39YqschFd4LHqa691SzscvlYxdLAvQdGJ/rylEFb+5r/c/p5F5BslLoY
 RnHPt+5Pu5cjcrYV8rY38XFZJtcpY72h4jmH3H6077zsSHTupq75RlQeyJa2vDAl7f9iekQYIfa
 gX04/T0DOt2w/wPzHWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX7kh4G1pnNjOg
 X/LuS1ZBMnzP7bdEl1I/Grq28C7U5SLN8XyMt5GhtkczNfQEABN0mop505voQv+8+vKRjlDorDy
 oSjFZRLucFb6IX/Bv16huS59RASrDIk=
X-Authority-Analysis: v=2.4 cv=IPsyzAvG c=1 sm=1 tr=0 ts=6a787301 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JpLBe5vfuqbXlpy2plQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090110

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in lemans.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 105°C.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 125 +++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 3b0539e27b51..2ca14300ec6d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -7773,6 +7774,8 @@ remoteproc_cdsp0: remoteproc@26300000 {
 			qcom,smem-states = <&smp2p_cdsp0_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -7912,6 +7915,8 @@ remoteproc_cdsp1: remoteproc@2a300000 {
 			qcom,smem-states = <&smp2p_cdsp1_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -8760,7 +8765,7 @@ nsp-0-0-0-thermal {
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8772,6 +8777,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
@@ -8780,7 +8793,7 @@ nsp-0-1-0-thermal {
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8792,6 +8805,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
@@ -8800,7 +8821,7 @@ nsp-0-2-0-thermal {
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8812,6 +8833,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-0-thermal {
@@ -8820,7 +8849,7 @@ nsp-1-0-0-thermal {
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8832,6 +8861,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-0-thermal {
@@ -8840,7 +8877,7 @@ nsp-1-1-0-thermal {
 			thermal-sensors = <&tsens2 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8852,6 +8889,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-0-thermal {
@@ -8860,7 +8905,7 @@ nsp-1-2-0-thermal {
 			thermal-sensors = <&tsens2 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8872,6 +8917,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -9014,7 +9067,7 @@ nsp-0-0-1-thermal {
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9026,6 +9079,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
@@ -9034,7 +9095,7 @@ nsp-0-1-1-thermal {
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9046,6 +9107,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
@@ -9054,7 +9123,7 @@ nsp-0-2-1-thermal {
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9066,6 +9135,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-1-thermal {
@@ -9074,7 +9151,7 @@ nsp-1-0-1-thermal {
 			thermal-sensors = <&tsens3 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9086,6 +9163,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-1-thermal {
@@ -9094,7 +9179,7 @@ nsp-1-1-1-thermal {
 			thermal-sensors = <&tsens3 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9106,6 +9191,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-1-thermal {
@@ -9114,7 +9207,7 @@ nsp-1-2-1-thermal {
 			thermal-sensors = <&tsens3 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9126,6 +9219,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 QCOM_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {

-- 
2.34.1

