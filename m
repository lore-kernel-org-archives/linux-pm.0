Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CB3914E4
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889527; cv=none; b=d2XljtO1iULMCwtae5FJWAXUEUGsTiHbNVCJexrn5x7OFKleXHA49HVQ7VzJS8mmcAjpO7UGRR/kNsR2DtNxwOiRam6G7gh9oDj72cPoonFLZ0ASpb1IgzTqn1kX71qq2OJpEwSi3/ghZGVA4DMBCRL0/HspnqPPMQ4hVZor5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889527; c=relaxed/simple;
	bh=ldfChzN1uSXhCMGPYXDm8BcwE4V0pQzO6G3r6/xavw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkRv++G4uIK98Fsg99HM3y1v4XgocWWFG0M+RsSxZqkiSfkkNJa9/P7KCUv9u+zJyflrztaoO6TgFq7iCeIdp6UMD1FbdLRqxjugGGCxQqrpNusley4IuzV0be5yjP2Txc+vgNPiY/kxYd0xDM3wLK5iqjyC7CSC9BcpX2i7i28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFBnh2mN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFBnh2mN"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfc137464dso631131985a.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774889524; x=1775494324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC6qv58XpG4CW/zjPsDlD07R3yCVlsOVxBcMpliJEEE=;
        b=MFBnh2mNS09vCaZMC0N/A1YnuUsX7cVw2fvGUJuOK8Z+UTFw6Qhm3VS9JBrdM0LA4i
         Kx3DhoVxx8E9rFDA3ZXu9aR6wiOkNZbn/jW48Mssg/bvG/CdJ4PX4RuXqzTJjWycaMcJ
         grOpv1/8+kc9ggp2omuaNkGfRWtm12mlPpOQWkd1cRbW30WxiDtY5Eg8S/JB7VifjzU9
         EACDWhN/ZX8PwXUNsxltBQRwTUSf2BP0HvIZYubQ23l5BKHsPf3zz87jm/8cgILfXb0s
         MkgRH1u0MA4V77LJJF1ROWjNwBIwyHM4opkq/xrKRAZSx1aku4xPJmeNzWAGJ5Lx0+Js
         X0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889524; x=1775494324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HC6qv58XpG4CW/zjPsDlD07R3yCVlsOVxBcMpliJEEE=;
        b=lH3ydfviRWza4CkFjFM+94Ugo8Axms8C/6Y+rSOizmTE24wuHMDGM7NBCmHOCcztpO
         uopnUiG29y+KmmNr4e/tJ9MBmpbso1skI/A7Seb0Y7Fwi4BMis1ADfEXzWsRZB90UXEe
         BPaA+1vDJOZg/Kj5WKIFnTbbzkjsWJwEeull/i28ffGrupbItSLP4SIIKy3T+gEV0/JJ
         SpL73w4Tho7AuoPdoMRzvUql3Z98idJVGQueTVlLdh0NjKzfei5pyo2GqUR5MjfxW1X0
         ntT09/0ctBGurwKO5asH/1HdSBKmM69tieBuPJWFYicNAM3g+4Sb1y0CMeSt0SEu+Pt4
         4dlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpW5icqOGEbIae1ifVpWG0BLXb1d54Es0xMLc1eRU9309vqHlqwnX7bS7LAnHrO2j3ilKItDpMIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3EGY26cuAfhmy7izPIxiIa/oG0EKxwiR0nHcWrJocJ+MdbuT
	1+JNTZA0ur8oroJhrlcAPLHvNCmBux42Jd1+99X+r9oCRIxp6pNh5qor
X-Gm-Gg: ATEYQzw9++lXweKcRmHaXJkbTvm0+Al++Kmv4p8H7FgRa9CAYvp7wOd1OW9zgXavyW0
	FkgIladRUVnOYk07ZlSYvkuHgWtnPuOi8QHnY/lhXFX4w0C7JRwz/fJMRO/glMRGbHcpC+3m4Ml
	Im8bPu8SfSYtIXE0fhgEcNy95Lw+h5tiTAGjEmZnKGhlZR+xFhWcJYpa9E2TOK3SQ7Al2bkf0hI
	2zaSXwKOoz3YMurEqOY1EZXsqWMQ+dHreLKDrz9NA57/rg1BW8lBe6djGaJnliU4eUIjEWzoVjx
	sQnTiO/qh2B0ys1m3SHfXKWQjkcti88d07vTOrfYr2gwseceXGtOnQ0PMYiWJeZKsimFn7iGFYz
	V5evPz7twInEXJipQ4gLl/saJBpskubD128bUIbBPNvQ88Yg01rxbvSkJPGiccCsqX2nkvxKtDs
	lM83ZpFn4UMvFj60JHHz9rlroDQuQwzjh5Zw==
X-Received: by 2002:a05:620a:4092:b0:8ca:41af:32d6 with SMTP id af79cd13be357-8d01c84a6fbmr1675670985a.70.1774889523692;
        Mon, 30 Mar 2026 09:52:03 -0700 (PDT)
Received: from localhost ([199.7.157.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02e697689sm548961885a.16.2026.03.30.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:52:03 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v5 2/2] arm64: dts: qcom: sdm670: add thermal zones and thermal devices
Date: Mon, 30 Mar 2026 12:52:37 -0400
Message-ID: <20260330165237.101045-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330165237.101045-1-mailingradian@gmail.com>
References: <20260330165237.101045-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thermal zones to safeguard from overheating to high temperatures,
along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
The temperatures are very high, but should still be safeguard for
devices that do not specify their own thermal zones.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 400 +++++++++++++++++++++++++++
 1 file changed, 400 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index f115bc6e64f3..c5f7655421a3 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -20,6 +20,7 @@
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -62,6 +63,7 @@ cpu0: cpu@0 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_0>;
 			l2_0: l2-cache {
 				compatible = "cache";
@@ -89,6 +91,7 @@ cpu1: cpu@100 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_100>;
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -111,6 +114,7 @@ cpu2: cpu@200 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_200>;
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -133,6 +137,7 @@ cpu3: cpu@300 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_300>;
 			l2_300: l2-cache {
 				compatible = "cache";
@@ -155,6 +160,7 @@ cpu4: cpu@400 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd4>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_400>;
 			l2_400: l2-cache {
 				compatible = "cache";
@@ -177,6 +183,7 @@ cpu5: cpu@500 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd5>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_500>;
 			l2_500: l2-cache {
 				compatible = "cache";
@@ -199,6 +206,7 @@ cpu6: cpu@600 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd6>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_600>;
 			l2_600: l2-cache {
 				compatible = "cache";
@@ -221,6 +229,7 @@ cpu7: cpu@700 {
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			power-domains = <&cpu_pd7>;
 			power-domain-names = "psci";
+			#cooling-cells = <2>;
 			next-level-cache = <&l2_700>;
 			l2_700: l2-cache {
 				compatible = "cache";
@@ -1408,6 +1417,8 @@ gpu: gpu@5000000 {
 			nvmem-cells = <&gpu_speed_bin>;
 			nvmem-cell-names = "speed_bin";
 
+			#cooling-cells = <2>;
+
 			status = "disabled";
 
 			gpu_zap_shader: zap-shader {
@@ -2100,6 +2111,28 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 		};
 
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sdm670-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c263000 0 0x1000>,
+			      <0 0x0c222000 0 0x1000>;
+			interrupts-extended = <&pdc 26 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 28 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+			#qcom,sensors = <13>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sdm670-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c265000 0 0x1000>,
+			      <0 0x0c223000 0 0x1000>;
+			interrupts-extended = <&pdc 27 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 29 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+			#qcom,sensors = <8>;
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm670-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
@@ -2289,5 +2322,372 @@ cpufreq_hw: cpufreq@17d43000 {
 
 			#freq-domain-cells = <1>;
 		};
+
+		lmh_cluster1: lmh@17d70800 {
+			compatible = "qcom,sdm670-lmh", "qcom,sdm845-lmh";
+			reg = <0 0x17d70800 0 0x400>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&cpu6>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@17d78800 {
+			compatible = "qcom,sdm670-lmh", "qcom,sdm845-lmh";
+			reg = <0 0x17d78800 0 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&cpu0>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				aoss0_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				cpu0_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				cpu1_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				cpu2_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				cpu3_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cluster0_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				cluster1_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cpu4_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu5_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				cpu6_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu7_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				gpu0_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				gpu0_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				gpu1_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				aoss1_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		q6-modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				q6_modem_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				mem_crit: trip-point1 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				wlan_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				q6_hvx_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				camera_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		video-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				video_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				modem_crit: trip-point0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
 	};
 };
-- 
2.53.0

