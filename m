Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478A3546DE
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055084; cv=none; b=Z3e3D5KeJipMXxx6Uu0qHLr2zjEyUSMM/LtbnvqT4vmgDRJIDcH40kPcRrWZ5gttOLLV7lN2KReX40+xTbYNnzs6PtfMvHRARwW770O1u1hccfuUS/oGjxVRhEMOQUhtb2pOEV5BMTHk5Z9mTRCQ/WwKvpYQ0ASQ9tH0DALm9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055084; c=relaxed/simple;
	bh=/ANQLmMYTNsw5cAXpfpErMVI9BrMl/ohHrJG/O+RCu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPweBYMkMZyZeada06fLusuyUa3ZyMgP7KnhdKIsgENcs/3qr4UzalNZM9EGTC6VEsgeEIklS13W48FBHoIQH3Ju0R/RxuBIXscNkTATVa7XnNne3QNoj9iWAUVvcxlXuKRFqqVfcXp3xJw3fy0l0owybyYKF3bRw3H/Un8OGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hN8Fh4qM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDZGFH9e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hN8Fh4qM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDZGFH9e"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342u9O2816802
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 05:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tRF1+DWYpOIMeNUULgNk1GEZQHb11qs8UfEUuTi65So=; b=hN8Fh4qMde/JRZQv
	xsjxCc+4UDMtk4X5ggOzWMSvZ1bUJQBFgGnN4DQt7ySts3GmL+5e2tuPh5NIR2w7
	VJCA/dFpZRK8xuWm/a1YaASNaO+XlXgWnvqfhffmDsKl08GSISkJp0L1pdwc4B0/
	U+TRum3IEtA9ErZKvI5ttM5WaOtSWX1EwwajDMGBhmJktRVgeFj8NyOStDLYFjhZ
	xtJEOHBmS8Hgq98pcxg7NIZQjECOzlLMbBco8pgeukNKaXzwH3snn3NiudNRkAnw
	37ngxwHR7v5xwMTd1HjuZtgdOVbHqo6UoikXk8tA+a+4BNdju1qo+BeLXLA6aGOK
	KW/psQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpbjr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:04:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fc66ee6a4so347347a91.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 22:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055061; x=1783659861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRF1+DWYpOIMeNUULgNk1GEZQHb11qs8UfEUuTi65So=;
        b=CDZGFH9eIRWlf08rNZO60JZzqL4ExVFj9i6dYeuAVabnqVbBW6Tba2K/jpVuhLbjvd
         c2AAle0lEU2u1nWIiSpdiSxzd0F6esB5UbkdkLN3/wX3iOx/9flevZA/yRaU5H3Nxtdu
         FRgh+048klgGqZugVRvnDdkWq7DZC/lO2lVCsG9UP6glmq9sb2QYEXWYuLqAVhABHCzF
         1Dd+edF6dQMcxj7E6VOM1GjAvf+aExZ6ZD/OLBEI0rkN0qOrGc8z7Gk6h3nnShjcYkhM
         dcyI3ebQe/EAKDTOZgkkwK76Kf4EW+ov00tJPRODNDZuXjFOkajjXniqMIAaTZ9qqvuK
         GWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055061; x=1783659861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tRF1+DWYpOIMeNUULgNk1GEZQHb11qs8UfEUuTi65So=;
        b=IZDgWP/vXvdrFVo3a6nvZQHjPDwmQ2aF4/68fNbZsH2v/wTHLe3IOAcEsWz+WMYDRo
         JdnshnGcgfP5lytacEH5upj7gvkGFw/bGWpYiPQvMhkAG3SRGDquygTUammKGEuM37ex
         q6GihQoj5xDVxbmNcbqciwiMvFqF7aXDhTBnrWG9rkHi/a4/8TJuwvvHeNaQyrDbSOAG
         qz9JRtOMwpvh30gxx8BK3UBFeRcgy0x3hoK9jhQdhQKGXujq9qXKEGjW60SCrKwbeB+6
         9pEQ9E8s3ABXSXdog7C5imIeftteT45+LXfYCRWTLnnTApxWRW8bOyqQMdiu5dCPKNEI
         19CA==
X-Forwarded-Encrypted: i=1; AHgh+RqvzoQKQpLQbf9SyHL8TrVbywi9W0WRGhCPtK19D0D/tNhHGG8SeLpPOPtQU6jAZtU5zAHpjQrYcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxubByz2wPjI2t0vpSHfVe6Pr62/qhxAXeKuT+GSi0YPOBIfU3E
	KpVfHd0mq99jZXg+c+eZCoB5/DmoR0zcCN99dnSKwJ0URFZPalvY/6pHum79///jxnoUAlItbHw
	ZZNPrHTD7WVPKU1kh1fbbZNG8encbOXGQCnmV+mC7CoAo4zGtE1WiwZUTAH5rgcauY19kfg==
X-Gm-Gg: AfdE7cmglQ/IZKbANbHhEyMjLutkLKA9yyQYQ2W4H7lSqwX/Q76xUJETYlvsfMDpTAt
	0rcQ1Ak4vbKSZ0uZS+f2Unwy6djUxYAmrR/e8ZyTeTuk9DmCrOwUduZjH/4VkT1SICXgbe7jjVV
	4X7hwFybRWbXmuetGlelNfLiKceOUDfyocIo5LLuTX3/i24zyOtGw+8DQj92rCJlytaZCsgJgQp
	T6W3EhpGRXFkEoCqrjKYfywuwfF2T0BTxKOqoplbo5qgEc4iefPlaf5bO9yVtiTDcPcXPWpFtce
	oIw7n3ebg5dZ+AcVTogyCTf/S31Xaeyysxrf8G+9SVGeHn24RuI/lq8SJjDKds4hjY33XWQmwei
	ek4C0LcJhiHD7RqqdDxb6nZbC5fhICABudQqFgAX+
X-Received: by 2002:a17:90b:350a:b0:380:f389:4477 with SMTP id 98e67ed59e1d1-380f3894634mr5483637a91.6.1783055061094;
        Thu, 02 Jul 2026 22:04:21 -0700 (PDT)
X-Received: by 2002:a17:90b:350a:b0:380:f389:4477 with SMTP id 98e67ed59e1d1-380f3894634mr5483568a91.6.1783055060540;
        Thu, 02 Jul 2026 22:04:20 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:04:20 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:09 +0530
Subject: [PATCH v4 06/10] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-qmi-tmd-v4-6-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=11455;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=/ANQLmMYTNsw5cAXpfpErMVI9BrMl/ohHrJG/O+RCu4=;
 b=lXDS1j5CSHe3cFT8bf1k+0XAJzpw6SFwoj8v9N3WjoIPO+L38uMhKVGW6DvDCIXfdzhQSCg95
 LeSMGaJQ2CaB9NGbLc9GNuK5N6+T8Xc0OE5EDs5avOLQruIr71rQ6au
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX/KKiEz8KInAh
 gNX+Tp/vfomtV9WRnp2/CBIAffYZJ5sJ9qm8E0aN3bvRE5ZpCroaEoY0oZUAKu2scER8tPbqDl1
 79ySTENuG+/r5BVfE0jFQfyO2iYiKmc=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a4742d6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=c9_L0O-3IDTAyDT5DigA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX8XrwqWeBEVaO
 Cxtlp+jyt1JmL3hkPKF4Mj6HEB5o91SdKJ5AgzcD+bmrTQmbEDEnHPLq60utqN1gB63gvML0YSO
 6pV13mCqQvtq154Pg8sfecClNxQk9nMMnMc8Q1zVGI5oxCeuE+9JeViBAgXp3SqJ9T4fOhm/752
 97bWhmHeIymLNHwOFzW0oe2ugT/tKVu8L2Bwz0F4DTXKPfNtl4ihysFCoaedC9Ohqx6TPKW5Sx9
 VkyeX53gLJmcpZb0rgohBVmkuaiUFeVbxICsdxFWrPCfHKUeUVlZxJvndxW6kUIj5MTVUUWvwls
 f6Zwk1fSGUfPdpmhu5l/jhCwthsBig8S3UNhkPCbMKIftxTH0LPGMv7wGfPPzvoNlhpv9bScJcm
 ltqk/FkHgZFAa+vtkZBxfKk4XksjpFh0hnmIij167QkCmdeQ8JXnmVIujc7vxInvnbNOKMSANGx
 H71pzMqZVAGGJjUMsYg==
X-Proofpoint-ORIG-GUID: rlyrPAX-fUlDpNRJ0ULBohpBHlPpxJc9
X-Proofpoint-GUID: rlyrPAX-fUlDpNRJ0ULBohpBHlPpxJc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030045

Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
when it reaches high temperatures in kodiak.

Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
for modem when it reaches to 95°C.

Since the remoteproc_mpss node doesn't exist on non modem boards, the
cooling-maps that reference it cause DT compilation errors. To fix that
remove inherited mdmss cooling-map nodes.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++++++++++++++++++-
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  17 +++
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +++
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +++
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +++
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +++
 7 files changed, 231 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615..d6fbafae6d3e 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7280.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,qmi-tmd.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -3427,6 +3428,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -4787,6 +4790,8 @@ remoteproc_cdsp: remoteproc@a300000 {
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -4906,6 +4911,7 @@ compute-cb@14 {
 					};
 				};
 			};
+
 		};
 
 		usb_1: usb@a600000 {
@@ -7716,6 +7722,8 @@ map0 {
 		};
 
 		nspss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -7725,15 +7733,31 @@ nspss0_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nspss1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -7743,12 +7767,26 @@ nspss1_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {
@@ -7787,7 +7825,9 @@ ddr_crit: ddr-crit {
 			};
 		};
 
-		mdmss0-thermal {
+		mdmss0_thermal: mdmss0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -7797,15 +7837,37 @@ mdmss0_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss0_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_MODEM
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
@@ -7815,15 +7877,37 @@ mdmss1_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss1_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_MODEM
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
@@ -7833,15 +7917,37 @@ mdmss2_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss2_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_MODEM
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
@@ -7851,12 +7957,32 @@ mdmss3_alert0: trip-point0 {
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
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_PA
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&mdmss3_alert1>;
+					cooling-device = <&remoteproc_mpss QCOM_MODEM_TMD_MODEM
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		camera0-thermal {
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index bb5a42b038f1..400d128132fc 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -24,6 +24,23 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 37a3b51323ce..187bc2899191 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -25,6 +25,23 @@
 /delete-node/ &rmtfs_mem;
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
+
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 /delete-node/ &video_mem;
 /delete-node/ &wlan_ce_mem;
 /delete-node/ &wpss_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
index a5ad796cb65d..1e190ed18ae5 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts
@@ -22,6 +22,23 @@
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &mpss_mem;
+
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
index f47efca42d48..8e8dd4efd8c0 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts
@@ -23,6 +23,23 @@
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
 /delete-node/ &ipa_fw_mem;
+
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &remoteproc_wpss;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index b721a8546800..1e9d7e7b5fa2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -26,8 +26,25 @@ &ipa {
 	status = "okay";
 };
 
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
+	/delete-property/ #cooling-cells;
 	reg = <0 0x04080000 0 0x10000>, <0 0x04180000 0 0x48>;
 	reg-names = "qdsp6", "rmb";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
index 3ebc915f0dc2..6642076f62c4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi
@@ -7,6 +7,22 @@
 
 /* WIFI SKUs save 256M by not having modem/mba/rmtfs memory regions defined. */
 
+&mdmss0_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss1_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss2_thermal {
+	/delete-node/ cooling-maps;
+};
+
+&mdmss3_thermal {
+	/delete-node/ cooling-maps;
+};
+
 /delete-node/ &mpss_mem;
 /delete-node/ &remoteproc_mpss;
 /delete-node/ &rmtfs_mem;

-- 
2.34.1

