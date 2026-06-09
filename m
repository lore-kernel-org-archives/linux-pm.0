Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F93F39CE
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000628; cv=none; b=XKeKpZ3l63JoDU+n3GxTHAFG0v2Z4V7oewOF201MldTKv4hjCxdZK7bzHVD+uNFwncgN1JLSzWS6ZK+nxqsAn4VD6hZWaQG7CQ6+uGEvTENFLWRWbfG2kw4H+tDs9u2wJQqwkKTAkfXi4qa9FT2Uinr+2zLiHexm3o5aCLrdFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000628; c=relaxed/simple;
	bh=8WSew3hSpaptpk+MeVkGct4Mo/+dI6jzC6p+5jGzuy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVbA+OOTTdRdGo2zkMw26AE4oolNicfI28/6OUcdNvip9zUI6Qt75twsL7T5R84BwbinvbOgD9aETB45fdcDZC27wTbZ7QIYDZOdexxYHeFFxOOc0OUvKPfYdTexxck0/4OjH5eia7NTVjkIzWsbKeLJZZ8L/G1ZmFaet1r70Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJ+7Lmkx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IDuYf9S9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJ+7Lmkx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IDuYf9S9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599v9eK1869219
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 10:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oPqS4yKwId9kzNQEd8gVilqedOfKFCI5+ugJhmdNjPE=; b=NJ+7LmkxK/J6zt99
	02KJGSE2XdNoGlLg5yfBrNRQhYrG88HuN4HkiPDcnELV50OiU0BUXhswvfGhddBF
	3F5WjtygyPwNMDS4DVgr5KOOaffBgHLbKRy9QtXuVIvqZTMIQnKDr1jf0fLR78cv
	RfFE0PMTXyBVqFjTgjpFM0vpb6kDSh5UgNLS3hAquIm+9jWMjsa2MYDR9LPfdKlK
	RDsxpiQeXWAbeECNu+YUKwXJhwY5dhlvv50fEsIe/2F3JIRvGwwPHt3VtCH0jLFo
	7FbLwFxN7KBECWUyqMxugB360HJlf7kccPxCnYW/bvUXYbS+/7dXvlFRT1nYlGCw
	uMXz6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqggn3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 10:23:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so41024055ad.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781000626; x=1781605426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPqS4yKwId9kzNQEd8gVilqedOfKFCI5+ugJhmdNjPE=;
        b=IDuYf9S9Poy7kMhvkvl1j8OBPyYJ5nouN/br7oWoE+tS/UbGQzDZAPwV3CY8xTSZVa
         WSV3epDEcNkjqbCZ/7WBpRORsSa71er2j703B6rf4+9m44iIT3DOTTrCvpUlB6bh1n3d
         gbDbojj3jRrlEZhNv1CWcxRl8GwaQ9Xy9/BjmQiR36E7p2x7xShj6blVnCbA6AK5Ma+S
         peyLdZ7WjUMBaW3AMZV7Pwa25uP2M0OSq1hezgn/FLvgUi3LYADmfLadYmRDp1CZZuHM
         4hPuAl/RG5BONOz2mHscO2Fg9XF96EG4fuZmLfWl5nacZBapoHmhpHPmJEHLs0t8Onqt
         x3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000626; x=1781605426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPqS4yKwId9kzNQEd8gVilqedOfKFCI5+ugJhmdNjPE=;
        b=IO4BYEaYFMctJNnl0+QcyYgBpZQzTHo1RiUjOHkjBMBSKRxOlCOJp8GHEcRpjKBb+N
         1x7aQFi0uMpk0dX3S3jeOB3ZWadFsI2i1d1yd1Pzjc51Z8Q5ry7ygkcjNgY9qa0g2hPD
         8OQXyeYcEkMRgyR7LMA8SfkzNjtl+n7OiOkoJBd3dDWJDHkhPC3b236IrwBfDlIOmj9l
         w6S7LhuJpV7KKjIC6gF3Lg/WWE+aCgkmfuCqP64DRjeMjqfsmqvmG7WQQ0hqLOmyqdDi
         jUDj1pVYUvarYeIeHTqIpLTwQht8tENvPBg3lCMlmHgc7BfRM96K3I8Q9pQKNGuCenwl
         y8ww==
X-Forwarded-Encrypted: i=1; AFNElJ/az/lg0DGBejC1WsiIQYYL+oBAVcw3HYY7pqZ2O9q1vMssUyTpoawIa/Oimn6NJluUZvSzuDp/sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SqOhjzOSfSP1LfsAn9gdyYQPdflaUXc6L9XmMeGe2nDP47Ov
	4HYK+xRpiwSxYVSce/od7IaVvqiakD2viTSqZJDIWf0zOsUpm00UogQYwoaunn0GfklEQXyW1em
	rmzvGbKt2VyzytwGX4vmDcy3u62v/KY4oD+KL7+J+hjCbiKFLdJVyUVjqxZ0ReQ==
X-Gm-Gg: Acq92OEtU7KWsPKrktvEqV4yqZqqpDtxoHZGbHS//YirZFHy0HysI0n7rlqnG6IASzE
	PQDg89cnbpuuCQc4OvhI8TvN0OXxFm4DXaQBrKIo0m6OrndSh+oivPZeq8AyXV5hNIoi1MrfDYu
	examKZTQyUO4kH84OY/nhOSh5mGv2qVosW22PH93Q1zJKoMnN/kCmchAJ4g2gC6saOWOZLSU1QL
	Co7YUFdYJFXaBtO/PwMKCnC9M53gobC3kbpgzRyFA/XcDf4UttPcvpB01L6ivgm7oe0FkSSMh/n
	DSU1+5PTD/oTVmMpyto3dodJBiYognnBTNRJympmGgBSO16B+RiLU0uIexMkeUd9A6oKgEO7c8E
	YwBrgyj65ZTgVItQAn9ol5BwN4mVnduDcw5IMtsFW4ryzrFnnqevmo7/oF7EgoQ==
X-Received: by 2002:a17:903:230f:b0:2bd:9b0e:b43a with SMTP id d9443c01a7336-2c1ec7a81e2mr157908655ad.7.1781000626330;
        Tue, 09 Jun 2026 03:23:46 -0700 (PDT)
X-Received: by 2002:a17:903:230f:b0:2bd:9b0e:b43a with SMTP id d9443c01a7336-2c1ec7a81e2mr157908305ad.7.1781000625736;
        Tue, 09 Jun 2026 03:23:45 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2a4a64e22sm14738915ad.61.2026.06.09.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:23:45 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 15:53:00 +0530
Subject: [PATCH v3 5/8] arm64: dts: qcom: lemans: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-qmi-tmd-v3-5-291a2ff4c634@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
In-Reply-To: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781000588; l=7485;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=8WSew3hSpaptpk+MeVkGct4Mo/+dI6jzC6p+5jGzuy8=;
 b=W0G5bCMvhjAOgHa+lvuelaFUBBAf3sgOnY30RtmbzjoA4/r6cr3vWejESvTf+aWqf02B9rkyt
 FDVCDOYAoqEAGxRNNLuL6sDKMe3x+Q+rEA2d+/DarjcWg4mKfRzLUJl
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NyBTYWx0ZWRfXxGf7py2lTb6E
 KKeF/jW8wV8eA2HcZEvRKUbBPtgoPA7zFtBYxkdUtvBSbK2h87I0Fv+4qSu6Ewtxrg1xC3wV33d
 +rThewrXV7Jd/I7qY0NnERMMCqiNN4RfrZBGl6rNhGHR15wGyB7KLnptaiBqb/C5Qz+KDZEBPIL
 M3vUXMsJpG3W9QIa9/k5OCbZ69pXvjz5Rwm2cqV+l3dhm/vsUJU0mBaAcUy+s5kRIz7AaVlMYfj
 xMDMAaIyI0cWSj71A4AxwBzdv3gl5e57HLICI1clLarpcLuVn4stw3x6eVLhcqTlkRJWdyWKuKg
 zvwRju0ZgKtQiwcbptT3AkNCwKjxtYJWh8onJFgpEXfidMGqCWaluLAQ7nVbb8hyfUGK20I5zWJ
 2WyhT/BvLuJna3pP5JOtm1oJl7TlcFx6YkSpnMnTc7gn37Xp8wiv3AHvbzKnaGk5sL3NIkFtJ80
 K5WHOPvCXA4t9iy9Pbw==
X-Proofpoint-ORIG-GUID: gJxuwdS76dD3f-fWNPP84PA4b7wAB9VG
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27e9b2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=01plALVR7p8jgSNDLXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gJxuwdS76dD3f-fWNPP84PA4b7wAB9VG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090097

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in lemans.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 126 +++++++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 353a6e6fd3ac..c55f95318707 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7777,6 +7777,9 @@ remoteproc_cdsp0: remoteproc@26300000 {
 			qcom,smem-states = <&smp2p_cdsp0_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <2>;
+			tmd-names = "cdsp_sw";
+
 			status = "disabled";
 
 			glink-edge {
@@ -7916,6 +7919,9 @@ remoteproc_cdsp1: remoteproc@2a300000 {
 			qcom,smem-states = <&smp2p_cdsp1_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <2>;
+			tmd-names = "cdsp_sw";
+
 			status = "disabled";
 
 			glink-edge {
@@ -8764,7 +8770,7 @@ nsp-0-0-0-thermal {
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8776,6 +8782,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
@@ -8784,7 +8798,7 @@ nsp-0-1-0-thermal {
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8796,6 +8810,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
@@ -8804,7 +8826,7 @@ nsp-0-2-0-thermal {
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8816,6 +8838,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-0-thermal {
@@ -8824,7 +8854,7 @@ nsp-1-0-0-thermal {
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8836,6 +8866,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-0-thermal {
@@ -8844,7 +8882,7 @@ nsp-1-1-0-thermal {
 			thermal-sensors = <&tsens2 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8856,6 +8894,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-0-thermal {
@@ -8864,7 +8910,7 @@ nsp-1-2-0-thermal {
 			thermal-sensors = <&tsens2 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -8876,6 +8922,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -9018,7 +9072,7 @@ nsp-0-0-1-thermal {
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
-				trip-point0 {
+				nsp_0_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9030,6 +9084,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
@@ -9038,7 +9100,7 @@ nsp-0-1-1-thermal {
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
-				trip-point0 {
+				nsp_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9050,6 +9112,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
@@ -9058,7 +9128,7 @@ nsp-0-2-1-thermal {
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
-				trip-point0 {
+				nsp_0_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9070,6 +9140,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp0 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-0-1-thermal {
@@ -9078,7 +9156,7 @@ nsp-1-0-1-thermal {
 			thermal-sensors = <&tsens3 8>;
 
 			trips {
-				trip-point0 {
+				nsp_1_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9090,6 +9168,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-1-1-thermal {
@@ -9098,7 +9184,7 @@ nsp-1-1-1-thermal {
 			thermal-sensors = <&tsens3 9>;
 
 			trips {
-				trip-point0 {
+				nsp_1_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9110,6 +9196,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-1-2-1-thermal {
@@ -9118,7 +9212,7 @@ nsp-1-2-1-thermal {
 			thermal-sensors = <&tsens3 10>;
 
 			trips {
-				trip-point0 {
+				nsp_1_2_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <5000>;
 					type = "passive";
@@ -9130,6 +9224,14 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_1_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp1 THERMAL_NO_LIMIT
+							 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {

-- 
2.34.1

