Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D3384245
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162231; cv=none; b=W3WP7K1jjmO9Rbs2kh9LdrNRM6UtArxbu5b0FIy0kmFDrebRYhy6Auyrygsvw330fnsv2X4Tp3O8/fD9TwRvcXzafsYjGAyNRvkC761Yy0Vs8VQoP/AgWGZDguZignugrd7AhXUszBCn/+OAuf6v9+sEbIwjq+WIP1jGWIqr3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162231; c=relaxed/simple;
	bh=fRh4ItbB186IfRw1kaI4v63chDGHFy3305Z1NpB1v5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAK00I5nmy40xVekq0UpG12HIMC7jOEuNNBb2eEiQKUTgR+Lq28lzrdtGh97EOQZbetCR9NsAtgHh8H0QigmPgw6pRUOvg94ee9VlCLkAVXJ4CuzDCVCq+kIqVrZKg5TTZfdXUOPp8/fdSY4jczb4JlngEnPqwg951XnmNy7jXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KiA3EOHI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UHl/Xo96; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KiA3EOHI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UHl/Xo96"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlbtE3895555
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O0yoA9H4rYBB8DaII+Kv5pKhjWUCFeYugwOfoue/dp0=; b=KiA3EOHIOxfFr8iQ
	GIfsZwIIAv4VKqeI+GVmRPWUx7CTIcr4LvD2Ot9vAaov3SXKpYWnK9TcntvDDfWo
	a9wA2JUKOVmxCVE+EvkJ/Ly+s2u1AgxOd08iar55D2I7AyOR/cw5X3Vzkfc++S5X
	BB1xvO2C3Mlk1ZH6dCrMD9Jw4NlAMnbPnM3m+mDbHhk6ddyXReD59uvx3/9HMFgv
	a94S2inHParib9RGSBqBAOfCnMpGJuhbTxSMhwHsh/Bl21+P19fDtc+LbQ9QaP4X
	u2XPr59VvwX6rCLuOdktUjhWNZtlOwLx7urHFmLGrjBL0j5VR2HMjpBBgBkyE5WO
	8UrMAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs308c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:23:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee894b3d8so29374705ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162228; x=1785767028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0yoA9H4rYBB8DaII+Kv5pKhjWUCFeYugwOfoue/dp0=;
        b=UHl/Xo96/DTuCwLv/GV9eEGL9x/B0h3XLXZ/uoYDPBJ6XdBZDmYOJQT6gVhu5o2mmZ
         3tZuW0K93bxzbBNakZallsir8VfpH/h17jnuYMDgZGnil0y2OZWw/seAb+Ane861EWtr
         4/pmXQCWjm6x2FWANvUt8AMbsSjGMXsBU3rLaDKwNgsZEfbmbJVeFnqqtjTChCLVqdXc
         eGhrZ+77CffUHzIDKDPdZzOe45dIISOOvIuhIlo+04jMW0Op3wXwaukH4ssVb6vRqDbG
         B39f3cLAIdptda7jKkZWLfpEzKZGH0KsxhnOLMSRVbtYxmbr1wuvMnpPLaGfXWID/MZQ
         3F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162228; x=1785767028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0yoA9H4rYBB8DaII+Kv5pKhjWUCFeYugwOfoue/dp0=;
        b=BmndvKZ/Krru6KyBehU1VurSiJMGZY7RZ9umSc+GmNuyUys1mJ2doEJE6B6gCcHiJf
         6Oti+JlAKDdEKZHN2N7rS4xj1nLfi+qoes4Uk3zi8eNo1Q1qmSHhQk/2YLBhNVn4kGgf
         awF/KZwVJ1/+beUg+JnMXUeO7d1oAknCZXUiS0dCNNQ8bUftSR9TRXSeyABfUoCfDgKU
         j4OP1LzpuBAQLeQvWdihPcj2Q2hUG9yBsdPlaZ5ocas9Pc1h1nlCLAVgsQ99TQb9xzwi
         CFt8X6ihW+BZ8Nx9silXcrxHEiWdD+gJ8/kGb08/CpShslvecec/YhC47HAOM0dvq8/C
         OEIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr893fyUShjJO/7klYVdzrxp8BC5/PXdlSgyWklCqUhVghpAx/H0HdjhvEmEGgVO1p3dFKtZ4q87A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxiNwL1MSKRffG/VX86+RB4UGkKMatc863hzBlY623Kp/zOsU
	yi4WA+xbMwCAlyik1QH1ZWrCK9+aUwW5Yk6cf4PpmIN5umq8Sy0V4fXa1TvVhsoCdQx7rQDGWzW
	xwwIUhdFgxZbfc6F8yXX0/rfSdeoiwcfGscLJeYfgkfET25E3jPtU+F6eH4AqfA==
X-Gm-Gg: AR+sD115V8CPCXvXILbd8HzTBPg7QsnDN1fYjLnTMs+I147FId67/ei7TNLg9SvoTTY
	aX0saupEL3up/XsZvdIOPGv/HFK+OmejK3U2oCe+eop/rmDI7eNtxXgumZMC1D/6ZlcpBTZpTih
	Qcj5T4QNemsBwvNIW7TrH0rn/HKmRQdh6mu5nAGcG+O4dx7Xd5nTIfKPl2M+6Q3MxnDHM4tJ1YC
	6P01vDM9XPGEia8sbQHF3zk1SfuzychvF1tef2jCVUViquwUVliEBxAmtl1LdPqm9uIMV5G3UWd
	qyKNZpCGeXcUZAhfzdDFf2R/pGjADP7hqwdRIzxLWW6I8+4FphuL0g/LyemumMJ2Scq6WPk+Pf7
	KPCPuqJhp5Qxuiw6w5Ru8q+yBImrfXA==
X-Received: by 2002:a17:903:32d0:b0:2cf:4504:feb5 with SMTP id d9443c01a7336-2cfde85f6acmr92077405ad.31.1785162227501;
        Mon, 27 Jul 2026 07:23:47 -0700 (PDT)
X-Received: by 2002:a17:903:32d0:b0:2cf:4504:feb5 with SMTP id d9443c01a7336-2cfde85f6acmr92077055ad.31.1785162227031;
        Mon, 27 Jul 2026 07:23:47 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:46 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:23 +0530
Subject: [PATCH v6 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-b4-qmi-tmd-v6-6-973cd3a226af@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=7944;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=fRh4ItbB186IfRw1kaI4v63chDGHFy3305Z1NpB1v5E=;
 b=EfXJ3U/yfA81NFGbJb2c4Ral2c2rHm9FNK2Y6mfGVlCzeTpBsilTRKHGvqoQAt3onvDtZOxUT
 rd+6XEjO8oFBY0kRbqvnK2XtlDYnKegI+iqFP9tNUnsiXxsZGUlSqlM
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX3gDXwDmyRtDs
 DPmSERopysHw/w8JcLeBc5dZKRgNQlqeZpLXyDuzy4pX7zNJwRfMWwmzI1R8XQxV8VvEhWKtMJy
 CMbCmPHARWsrLzrhUJkYC/NvKooL63SFevYFaSrH5FmB7nmBU4LFz1IgaG+YSsEdEhr/X9tstcJ
 DcbQsb2OorkhKO+h3X993/gEh+A7n3wKVKkGUaljW/Tw7DGJ5UndFJ5RNzrccgMzqPhQdcWFqAB
 Faf3oJMnUaWN1qxflnLnp3jjKET2kIZ/Qkd8En85EnBxJOxLQfC1aokHXa5/JdWgIOaje81vvAe
 HU12xaOT0/XnuRk2Drg1Ei/qtBsnpewxuBzmRVTdedc/hFjfva/fCLa5V3LcCwTdS/HFCeU7dHW
 pOf0HLR1DehF1kuwG0gKXVB5+rTtPhwMLVHo2IfDssZkfQlxp2Ai0/KHyI7/UrxtQa+jZiQ3ryn
 mN2XYaQm1KTf8sBjBwQ==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a6769f4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cnwIH0_uZE9cE6M6O2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 2sgoMTOO6LjxK6llxZLt42a1nBKA2Zos
X-Proofpoint-GUID: 2sgoMTOO6LjxK6llxZLt42a1nBKA2Zos
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX70pkNJdjhFuP
 1guXpwZBDv0rB6WTRiCgtbhKwjVd/003SmbpDesQ04Qom5f2aeYtcTr5AcU2pgtXTt4isa+P/Gv
 bHc8d++631omDn8DCZYKTQgCnqJ+x1c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in lemans.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 105°C.

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

