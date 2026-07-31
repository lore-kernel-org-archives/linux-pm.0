Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A75427FBF
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494136; cv=none; b=ajanOtLTU7D4srqJsOOqLDUSZJIf4qpn5wuQrkYysLNTwFAEJmWXs3ousv9vRaWkcjXNGPVuNkppqu2vpIdfK4wBHo/0a63g1gjmFs1l1/Sg9h3mGQNopoGxvBI4L+o6edUblXZzB7uwprfZIQ/nZ7TULy3otPxZOIEGsmIlU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494136; c=relaxed/simple;
	bh=zu8gupPC5A5PcDFsGHMjuTQqaVyyOo6BMNe0DLfwd9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YEyw/kzCZIUP2HrTmWluunCGUmB1Nc2VLC6w0dYi0/+JuCmLxbUvBnk1IoiuWcmH78MXdQux2RSS2SUzAXUFJn2NJfr1NnT+bOlCUm0VV5scwesbvklpCNPzO5efkF3ESwQ0UUFcUWPY5F/s2j7E44zlkl4+gGY53DLyYfaQ/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKxMCkrP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U28AMDQI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKxMCkrP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U28AMDQI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC9AQ3851101
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=; b=eKxMCkrPvnwfbLFQ
	7KP6DGZhz7qBb9xh/nukJeLm2zlWAFPwxjh0AtgaoI/430zhNQZa84bPiH1UHseA
	PsOHzjhPsZLrU/cx54ATkCmVi/jOQtd9FfuLEqFOmB+QM+2FRuio8+Hv6kLxM314
	DoGSJjKdbaFyJ8k578/u0XqRzKMjfFfsQrKtcmp/x/ALHTCcFmB4pPxA1a7fhz70
	SjSvHAXYa0m8BvavWi5Od8T73Voc+q9qtkzy/NA47rQgOFejrN4xO+4jBehvugev
	7bNaqg4B6vqMSy6C41/VXyV0Fyo/KOTau/dCBm7PoL9yEi1BxuOPP61r3+29TaAm
	HMFiug==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsg204b0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:35:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1110385a12.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494100; x=1786098900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=;
        b=U28AMDQIPXNPC/ZGwOg3UN1qxOHvKk6H2+BBj+zC/ny7Ytd/Y3QuFCPaHwV1yD4lc3
         a0JQIJbbKhOLU4uLa6femSE4xHdp6RoiRCJ5D9riwKyqdH0lclXiy6zhkaRaR8W+vH/b
         o4zXTxHOYJ2ZtTrrWFFN1JfRepB/osgvKplLn8BODcjmtNXya1AB5Z/F6Ku024MyScDF
         3FcNAz5+xrK7FDq6VJWdvGeBtr71c0X3JuaF9xBbqBQHGDzM10jW48r/WG2f1xVawrfy
         dfpAmeaPqTG7MJRrwMaiSDhcDPltMXGaQ58J/YPrQaOXhrQkUqu+dsJe8yXXvq/hfnx9
         BKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494100; x=1786098900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YD+0nJhg2tipomjvVHvKwH4PnwKW0weQoAtx/YRHdM=;
        b=fopMkDYXfOi9lSPPqpvMzZ0apcRZQigmsFAn0gkSxYkuur1k2zLLd+y/gtk686AukI
         Ujgp7t3wfIhFH3im20tDxbv8gc4U8qdy0uFCf+/EHNCwcHtZpEs543L7N6MSpSRo6zSq
         2PrrWhF3VGjuwIadmMKfCgskxyPoRLnqNDUXDyqwfHEdN/DGK6C2/Vr7zvyfBDFKJ3HB
         4vTQYV8NwHzQvPV7qsXPU5Zv2DEHFfQNBnZxKfCsBATZkUetxV0yqgjRsDAyGlLHKGwh
         JSryGMXJShxLlKuxbr6OqfTqIqZOYTWIed3loxNoLvaD/+xMnAfZ+c+GReSYlZabNCOZ
         6Jpw==
X-Forwarded-Encrypted: i=1; AHgh+RoLKkRIlyXr63W77wBDIBiv31T/c2KxVXBOhQ/dv4xY8buM9cH4Eyri6BIBvNinCiAhLsf3jvCtGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJGTcoH+jBy7h9tLZuws5Ju/0db+33Pm/x/q/+FlUIVOsr10H
	3dvnkcBSzZh3rcp9eCU2ZVcz0jzPf0zuYSks+0TeJb3CPob9hFqjV3PrzA6ErVfUyu5UdiHtz1t
	RP+iyBf3b4nJd+trU35zwS5vEBckK5exzWzCpU9VKxFxXDYw8bnQdGgsW/uIdxQ==
X-Gm-Gg: AR+sD12wMiz8Iu3B4PFzBGKf5dDqEsRymtOfmxTxLe3HYtBzFG15KyEZQa+QxRFjjiG
	4R6aJFhbkP5wZb1e+92WunxdL+Upxy/HWRkSW7sqmGEon2jqcqvYRxi7efL1UncOhfGlAPhFHZK
	oX/xwff+n5oUy8Lu3Ink45ciBNY3RoeMt3HMMOmBag+s3DNnb/ksJdFOOmQtYu+7gMm0XBUH5ES
	rOs6HFFYVsfqWuVc71j5vxQ/XUiCAfAsjB5PIbJRSX2VWemQ7PIloyzwOWwKy8HXnvO/AsAbTEV
	whevZfaWYxiZ4R7bQ6J9wxS61BxJn2VY/p5K8G+IKTNRtbJE3jZ0h2cBUR/3P3ZbWQmjEvJ1TJi
	A4jv8xdwh/Y+4/DEpdXauis1j52pEBw==
X-Received: by 2002:a05:6a20:72a8:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c91b1fa5ccmr1486198637.33.1785494100139;
        Fri, 31 Jul 2026 03:35:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a8:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c91b1fa5ccmr1486155637.33.1785494099682;
        Fri, 31 Jul 2026 03:34:59 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:59 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:46 +0530
Subject: [PATCH v7 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-b4-qmi-tmd-v7-6-3befd44403d5@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=8007;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=zu8gupPC5A5PcDFsGHMjuTQqaVyyOo6BMNe0DLfwd9A=;
 b=bqVA7apPugofHDMXHIlxYAXSKEGTOtlFaOfDqZA9Tz/LzoH8PDwtoONXVi3CChVOLbAT9NgEf
 6UiH2mxtaH6AZZjPSxRINsy20hVYDP06iGhnPRZYBH2STYZ+KwiNgiz
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfXxW5VVwLvJ1D4
 u1y1q3YaAwSY32uOrf4CAZ5rBDIFZ6ufGTFt4jfcZoNAvxGAJftnGW9ka86e0/JzPJmmat8dgm+
 utUXoKMi4WTTqmEQ23c7fFLneIfsI7E=
X-Authority-Analysis: v=2.4 cv=Yvk/gYYX c=1 sm=1 tr=0 ts=6a6c7a55 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JpLBe5vfuqbXlpy2plQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfXysO4JrmXrQ86
 lVBJTctiVr1zRo+AHCj8nrW+zjsPpLsOBMvHFwmNb5x/vjI/mxGSiiAh3TRagX6J/Ubd/t+VGo4
 rKdITvuAUIQZ+Wjhzt74Q4idZP6jZ4V4zr9fIZcDFz8igFhqmfNi4Wfl6wDhJdC98pLz7IeEjGU
 XVsiHuZpRvQSRp41SHRbPcue0YJAMM9K2XDWeKB7QvUtUZwiB0R6HDaHRJb+wOMraQCvTRbUYR2
 79uzpFP75I3gKARpTwXnKng8CqYB3M0cG1y9emglKL/eNLB9atYoR1YIKoBwBoAiGBnCs8d7CIF
 QgLsGF3ulEKyV2UmhhqnBf3RIAY3qu2s/+G6MiTphpLfpu/eGWxiEHYWuftezAj8C+tQm0OFBEm
 pdq+T9eh0NGRyAQY1UjYTEEoMfNVmRxJqLR/BgbTbslqvig61+tsfsPWotnKJJ5YuXNxRWQdKPw
 sXLmZKW3txmw4QzOAqA==
X-Proofpoint-ORIG-GUID: xe-RCraW_NNVDN2KNJdYAn0gSvZ6Zs6a
X-Proofpoint-GUID: xe-RCraW_NNVDN2KNJdYAn0gSvZ6Zs6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

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

