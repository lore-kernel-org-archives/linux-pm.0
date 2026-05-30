Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA43AB26B
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165727; cv=none; b=PJ15obhyoTy605lRTyjZRTZbqgflKpceS57brhpOafBwJJFdT+7eO6umctNhaNzbi7pkSFScWe1nPIoq6gS3LL+OQqzjDZk88+H/bUovqPPL7lu3/DXse3VeUyW0Sv6bgBWGh6GcBFY8GWYPqIRX51WsihiExH6Vw0OT5sm0MtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165727; c=relaxed/simple;
	bh=o3A84TMZexBM1pwDxo3Kw7jFeLhMLOycNMF3Z9OKaP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nb4m88Pnxy0WUn2Nt81wgG7BPf9IW+/l4cqsPSiUg5EWkJ/7XqkaaWfyebIUquyDojOwRTiGGvYNua4Jr/+hZW6sCZpF1zUgvEU0VVB+wHa6/8c4bjSywRawhqNdnT9bq+R7V8/KnejGznJmkT8h+SIig8PijOllgOKvbVWNO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMCLFRZk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hB7IOxio; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMCLFRZk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hB7IOxio"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOS5O3280285
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOYi9IefuNlSV+Wu7JhS4ObVYHQlqpLnbN4ZIuehJxQ=; b=mMCLFRZkPDoVRWl2
	ch2Ig/UBatS3UDit5h1izHVU+XSBrZtGr7ZjCCFG6g2UhatbbmLLJBfwvzSzvU3Y
	L+u5BnfU4CpsQrQHuPt6Y+OD/NlwCl3ALSQfv8xeDQpP2xqIZAua9kaJ0NdBm4Il
	CcMoEtguWd2ixflz0gJ+zWoN6/zJoQ4yMPJ4S0DQ7m4OmmfhpEgJ51JTuFpolmhg
	koudjlx0fWlAxzYo0OPGbQodE4Tpd+pEkyFcLwSnP5w9tIQD7TdjMzpJwJBtBFyJ
	9+XihNHCyZNuckDs0+tIc8/3CtlgkUAAtyikalSJul3rP3Dvm54pNRnnHfBfqHTt
	ECbq6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f9tvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0bf6904a6so2109475ad.1
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165723; x=1780770523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOYi9IefuNlSV+Wu7JhS4ObVYHQlqpLnbN4ZIuehJxQ=;
        b=hB7IOxiozy2choIbNOws9c8W+pDP3qDiYPKcUcpuI60/sG6SUHYdMXk2rtHK9jYu3F
         gcsYDgz9Bt/CCk22yFHWDzPGfeLztQVnmasfy42T+QP2W7uLRRE6EmAuGAMggoXJu0V8
         wAicndetrSUVnJ9gepm3xTnkHi02wY/U/XRQA5edxPkJ94Nh9h6J6GkvDmqCrJgjiKTp
         9DJZJcOKoQ+Q8gJdFjSslMLFflA0VMu50f4O4F+TngmHbKNGEIV0RDzMKAuFvoXLhFMF
         QA3pLOsolXJGPQj953xe733x9DXtNnzsyuE+kc1j1WdF6+wvXeq8dP2Iz4yAfNWQeVZ+
         A6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165723; x=1780770523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOYi9IefuNlSV+Wu7JhS4ObVYHQlqpLnbN4ZIuehJxQ=;
        b=SATRyP2BCFWkToLvmT4uRJ2wWgyBnJQrGjsocVNZK0pBaJKDXe8WuxBcWCf4Xfq+Zq
         h+WjKQikLS0vG43ySaaNRZtqz1nBcZl2w0L4ro2OoaCGtR0O6nwUibxtWjSKam1yl4/q
         cYdzSxeenSSVsA/kAhBuvX/4x1Zvm1PnHXDOdWFHqQ6U6LOwWYH5BzRejG8jZJ16Da8l
         bzPMub9kJzQbEHbAMHgTtdXNiPCIwvXgpLAfVUxesagaL91TMwyHXoDR8NvTgf7V69ue
         AOv6C6mW6LAAd4lLXrKmDY6ZfPQ0ouQxErdG/COKpx4XNA1N0EWvTHdS3OWp5yEsTrIq
         /ptQ==
X-Forwarded-Encrypted: i=1; AFNElJ89R/uFoPHPg7NTWo84wbR3D0JiHyH9H4rQgGUx/X2NswH6Ac/Rn/iss8HqTjIaVJiJFcAmLoqH0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw298ii81OPq8Xln6NcFv2OSKuwQTr+TQbLGZrD01P80rD1jIM
	4wZYTvMjaA5HhaYzHpBRlPgXzi8Z1/pL17i8JNWl2VQ444OBKGkFGDfYCqDw2Qh/9DpLM8Cob+3
	SZoKOjCux3CZ/9nU7Cb9Udq1T///S68MrDIoQ7QQVuj/WbirdnwYu7ZPAiRwGLA==
X-Gm-Gg: Acq92OGBI/kg/t+kEsy04+LBiOUEgOpLs+MG3SP2iH4GRct1DE0ZWtmr+511i3Mx3nn
	TKxycWEQcpHYLjJzlF2x+0dJomXJ9ydcgjGVeabCdwql4PEvakBrAkUOEPWUfSdcCnbY4kcxLXa
	4bLczlO/wT/FkHv3rIkeFsniDt9ZbbcBJrgiL72oX+ZbYrihgPWxEkycj33Mje1Vm7FarCxtjzU
	DrOZJfkIi5ZLj6K1QP6ixOKnHd8a6GZbuFCHkKkaWuvVhU99+FLBoKhQVm9nzfO4hH6HS3a0A54
	nWxdMN63kHn58/ITA0/F9wU6F7AVgTcEcmFsr67TpkNoA23nUyy5MtBXfcGI9t0XBF3aXXYNod9
	j7tmfESyQZKiJTSE6dSlQ1/b6zc6Yii0nfpuVIqaZiAJbrEA=
X-Received: by 2002:a17:903:1b4d:b0:2bf:2015:5b93 with SMTP id d9443c01a7336-2bf367d9879mr60480895ad.11.1780165723218;
        Sat, 30 May 2026 11:28:43 -0700 (PDT)
X-Received: by 2002:a17:903:1b4d:b0:2bf:2015:5b93 with SMTP id d9443c01a7336-2bf367d9879mr60480695ad.11.1780165722725;
        Sat, 30 May 2026 11:28:42 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:42 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:27 +0530
Subject: [PATCH v2 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-shikra-dt-m1-v2-9-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=6253;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ojqo87uQxTupglYyK4apEMvmRbEsINf/dsrmTKrIdHk=;
 b=zr4W3m1eSpjcPP4etV3b4+H92DICqQDDEu0Ly3X0o2UHpM7IgQ8FO7ZEobVVbgWszXclqvfMa
 JoejMlECx83A+JWNXCIFzy+Y1G2bwgaVoykQvPDK/2WoiG+IsdlihCW
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: RN_8UcQqUMZ6YcOY0CuBrWCgKJE4DQtW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX+Fb8EExupZ+S
 auy3l/NI9T70b7mY7r5Sv98hs+F1m+/YcrsBytMmn2v/ZduF6kxxDaYcd/jaaFPlsk5t16hhkJ+
 llA30ecls4zcV/gkho6DQkCImBFxfmYobYjj9oGUkt+Z0wIRMixU91qcTTNhQtNq3GAJLIY54pH
 6tarNH8eaIIbSsqRmKuBio+KBlthZSR1U7blhhjO6Sh2Y2KJ9vqqXoxsyX8Apde9X0DrK+JwdP5
 fho1asizhu9bwLO94jK48eTVRkBPUyXC7PkRRk88UDyeihZByG8sYCCC/dja1YdPS9043LVpaoP
 voCL3bUQ6E/kkqO9m2j/vd85g5Df1Lna6n2jVulhtkHd8+dyqHeSerZYYQJ3umFc2ZbOM7YLfDn
 JuRWR0tMy+hr1QhK/FH1z1XLhTioMEvp91ASTG50MFlG4j9FhvMhrD6uw2VBaIVOJrEPZXUH33U
 0+gUelbP2paJyzU24eA==
X-Proofpoint-GUID: RN_8UcQqUMZ6YcOY0CuBrWCgKJE4DQtW
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1b2c5c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RA8m1HTphegElRrk3pgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300199

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

The shikra includes one TSENS instance, with a total of 14 thermal
sensors distributed across various locations on the SoC.

The TSENS max/reset threshold is configured to 120°C in the hardware.
Enable all TSENS instances, and define the thermal zones with a hot trip
at 110°C and critical trip at 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index eaed7c53d4cb..37e4ec799976 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -983,6 +984,18 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		tsens0: thermal-sensor@4411000 {
+			compatible = "qcom,shikra-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x04411000 0x0 0x1000>,
+			      <0x0 0x04410000 0x0 0x1000>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "uplow",
+					  "critical";
+			#qcom,sensors = <14>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -2180,6 +2193,260 @@ cpufreq_hw: cpufreq@fd91000 {
 		};
 	};
 
+	thermal_zones: thermal-zones {
+		aoss0-thermal {
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				aoss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-0-thermal {
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu00-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-1-thermal {
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu01-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-0-thermal {
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu10-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-1-1-thermal {
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu11-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss0-thermal {
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpuss-thermal {
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				gpuss-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		nsp-thermal {
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				nsp-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss0-thermal {
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss0-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mdmss1-thermal {
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mdmss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-thermal {
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				camera-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-thermal {
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				video-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-0-2-thermal {
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpu02-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpuss1-thermal {
+			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				trip-point0 {
+					temperature = <110000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				cpuss1-critical {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 

-- 
2.34.1

