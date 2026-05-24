Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0333065D
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652241; cv=none; b=fgkgRG6dpsFWyAJ3jHZGQYvnGWpjn13AyfUhJm3TIevJUHw4VqhjHS3sFYSgRL4wLfJsgio5+35UvSh3PBBcQAMqLn3S1MVpwMgI7V4hbAK2uvHMJLiaf/MqxvfK5mJRRaS0ntry5QiixmCQbac/xQsXGLLi4kAhxoK0exoKL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652241; c=relaxed/simple;
	bh=y8hzVy6cCcJ93bHvBbe4ds1C+WcIptdu8VcitZODijU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3nhdcLkVN478NYc9vAca0MxFTqA5sxRP4q/G+5dl0r/HBNc6jKT9ArzARtdmUyWgsdmEBqoF7obXw76y8Ct33zTKHSHFwbh44EZzlOT1uUvAWoRjHe7HwiGgsm5dudYchADI03dHizfZMaNxWGBlK/eELyGty5M5AUunA2GfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAZvv0R8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SX0Jr34C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAZvv0R8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SX0Jr34C"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NLaI1T2801844
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=; b=WAZvv0R8javfWBox
	w/OqDYSh3rTqUd5Ado94TOuvX7TesP6frhn2VvAcq1f3CPCwyhnu/OpTUNDOVs1j
	mHJj4BmkKPIEHNnyQjqv0aMvXCy8p/If2wvjzBvCTzJHLjT+bwO23TL3QVhK/FF6
	jWhTtXGSUXgjgW3TE3GFykVnVidf+AVzW6OhUBXd26S0z2QDsFpScof/42cZXmo4
	hb5zY5MjlgDLFBKdmHDGHdQExa1OH71vfdE4BN78i7hjHGZ3VFqOI0N4LV5+V8Hm
	poCcRWO/bSuM/4vwZtlE2C3shPE/9JxirmEAUQGOio5KklnRFnvEXF3tkwQCSz8a
	70LiKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmm9st-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso17989506a91.3
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652238; x=1780257038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=;
        b=SX0Jr34CeCFNPlHQPnOPiUf+KQAlQ673jdflkfR4ABpvZ0fCPWV8n8shsCq2VVNQYG
         KvyXNSpPBG3fohRSB2QPfB8TSu1Oh3Gv2KG5h3Xu7LqyDC6pp3PdglbXdQUjqg7MKDDr
         C1v9hKgVhHEjkJJ7FaF+KQuzu3L6mcuE3qGgSPE22BfdMXmq8OKUAmKh7Mvmeg1OaCxA
         DqGwdfv26xyruvAj6tSucnzCdbI6sTmpa6RBVFmQwZ8arae8UGRgy1tFPj7hBWlkVqp2
         OFF2bF6T0Zk1qxeNGdVFSfsKwa0cQJ2G9zbA3RAaSNwgIUQqLwPYcEfVCAdmjWs4OQpG
         KBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652238; x=1780257038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qeQxQjRAZZ2hYSr+SWxRvaMT5vkjwlopuyhcFv2hw0E=;
        b=Ip3XQRNeRQRuoK2y5obUzd1XoAtcToCjstGVJr6N9R58A+eOoz49VeubOD2HgGnQxf
         /EdplFQucDtdmXHOcNQPSmz7Q/tPa3byFr+dz2IBNAjt4kgNQYFJF55MAwI0bdS5msSn
         NIzRFWrSv+WPqr+Gti4kgcdRmiNfGAsGr/F3NPyEdJDgFRfRoNZdLHV1jbz0InffIkNA
         PYK/eDPIB+rpYFk76RGX5ROlWaXBPvBMNdIUc7tJWbXddx6dkqi9QQny0gyPL2lkPHAA
         RMnvl3lEpxOuxwVjqudBpCHCx69oO1KeFtueZXVplAsGopqDPvSdp0tGg77MB0gpvy7f
         1D0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8AOIS9koeDpDOoe8bZocUL6lq/jMaZPcdIGXM716PfCZdL0EjZa41m6lXNBNJG5Mn6gXJyEDhH9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3R9P01gZk/S81nNtZBWOlXs9N5EcJTgQYgLBgVIJvX6mDF45G
	iEaotRashoWDlwtiCqutN+IBCBDvOLfEdm/qICL+msDCKT4ZazvHVUBnSdVqDjUzpxaNydR32GE
	RRjs4UCtFWAAqg/eZ0vFzVR4Da1AEwWu5nM5NemkEWBapAYhAf93kRsgaYR8U1A==
X-Gm-Gg: Acq92OFwYwrvWQGXM/jiLHGAVhLjY62eUzUPLoyeiGHZR/+Ef3KUCHI/mvzWu4r+K8b
	ncJkgwebC0axWDD1T3ELF+QrtiNgkeWu1yvgzG+ZIAwwXGKxr3hJQ6Ic0tY6wrzG1IxNBar7kyy
	qfXcRww5RRS4WGVcqd4xJCoz0bIElggZFa7Ws4+TQ3miDy1AyZQdhDiQd/xLvXEhjkEZe8Gn/AN
	r/JD8nHWw7yLcTvPRbezwYA0A6QrIBWssj389wuO6Dc3V1WhFgLYbEbXf1OFMnrutJJyDV15fNI
	87MMKCYL3o08nnjnd/bbRXNi6of2sOXjw+aY6nmdwMoPcHL0MIR8rLf5FXFGF6/Qaqep3UPQC3H
	Gle8eNambJOOvplYMR3Apb/O1qby8M5vWI4Wn
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr3848179a91.7.1779652238076;
        Sun, 24 May 2026 12:50:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr3848157a91.7.1779652237499;
        Sun, 24 May 2026 12:50:37 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:17 +0530
Subject: [PATCH 13/16] arm64: dts: qcom: shikra: Enable TSENS and thermal
 zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-shikra-dt-m1-v1-13-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=6253;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=cGxRrrI7UxJhRRdzjLYdr6kVl234MC9MAoygig5zUp0=;
 b=COlXrzf36pdnGoe4SayHJsxe71fdlF/YeDbTQSMd1ttTUxHrSyf4xRtCdak0uP68JKzNuyvrG
 G3fJQ2a/lLdDzNRAaLbAJ59r546oKLtJpJ0aoK0xH+b+V5ybWOEbtja
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXwf2ywPMjBdya
 VYa9aeePdTVu8t/MQPnb407bgvQaMrizqrHfur7PD1D+8wlDXIPwiGY25bZ52tZoyCVLL5hOtJC
 ZUjS1kKB7Tz65ue3usEiW6FYaGcvKRFVlaG52b1fMLD37mJcKjcHniycuUfhxgI3iZr7LBpyroR
 RGlEnei+ap5vjSH+p3VAIn/h+cyq4Vfm60IC2eaOEvWecG4SNp8U/Xgc+F+yEhRuM+R5IznMotG
 AmB4ZXpccpbC1j1HKvJBqtrdePCJrNmpyn9KE24tPstXthveCoG6cVV0oLn2SpYGWdsQTY9rjlq
 QKV4H3HVwnjLfwuMOFUgPszf327hquYFKua9wHxt2HB9U4/teT83YTq/xHn799zxRw6JHArf6o3
 l5Tg4VZGLVe6+AHXe1w0bhfTDeAFbRgUs1NNP9Y5/RyqCqp8NQ0zLRtw1ml/JFhDeIZvx13OcOZ
 5cVmTJD1Q7AYX5N+uaw==
X-Proofpoint-ORIG-GUID: rIyA0ATXlxe4dzfXdMXlwNXRDpdkEkcj
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a13568f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=8VSKil3hnYOHzGXlt_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: rIyA0ATXlxe4dzfXdMXlwNXRDpdkEkcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

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
index 96ec5b5c7203..124d0f05538d 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -982,6 +983,18 @@ spmi_bus: spmi@1c40000 {
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
@@ -2179,6 +2192,260 @@ cpufreq_hw: cpufreq@fd91000 {
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

