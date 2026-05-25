Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E30383997
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713437; cv=none; b=LixjxHsKx7djErt/CtIhhqVQlMGtkW/hfPCbxmbu26VpcXiz1WbWMwZ/OcywmhVbCeUwGk+dpwbb5ssQuE6c05YPNjlqHKriyzUXuh2YrNH7eZGUIm9zrqXl5KAWjweoPQUerV5/0S0IJir3qW03k0i/xVN+n/IS9gPenxVu7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713437; c=relaxed/simple;
	bh=z5Fhpx6IUPSYAgFvZrJUnVUKezx0DwqehwsV2CJ50Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STppwboiqTFR3Rn7Q5hLLL9/wXuVPeFzRA/Tyrv8xtI0vV+/LDfEEfe8F5NjyhCdtDXgO80uBztjkTzp0SsP1vc1HW3RQj2KxMK4r05VSX77x7TIYnpETKAuLdTg8AKPRQne+E4WMqa6UcCGIKey+PxOb+ZukKNTMDcKWUyzf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRA2Hnq5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRA2Hnq5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49048e043e5so20511775e9.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713432; x=1780318232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGd5UlriZ0Fmljc0R8krxuZT/x7hHgGTNiWkLANtVt8=;
        b=zRA2Hnq5l9LGbTHaKibx/EDxnQC9qcH/C7kcl/LreiDc+7g1TiwUnPFzbXUBBvxNlL
         cJxPRHVpxO9QMKXZhSiWhSTQtJlcSpTisnvO/V142nAqlHLIQQxynrQSsKhPiDwKdLX9
         XERUd2bek4BqAVdEcU8WwJep84p+DnTC9myip2dno/PF+ifKCNiCaH8/MIgaBOaJHN3Y
         NeF/qf+pOTZ3rwDXXLRQh4CcpZd7Fj4D8UYHnzG0U+//2Uy7CJpjzChxRqXJbn1LU9Y+
         g3yt0K6wPOXqCvku4phPKI4hMHWRBAd4Ad3AZtWRUM2Ubr1AIJZn1FF+Gi+MGqaJMXQn
         SRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713432; x=1780318232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGd5UlriZ0Fmljc0R8krxuZT/x7hHgGTNiWkLANtVt8=;
        b=mGOLySwIFNFVZbSZNw4jHugy0PzAc/W9lRDFBov2zBbM/JlmEcDXRzHRQ+6XqSuKf1
         pmpZihnVrOSZ0HlVi7H7ySbc+HES2l3BlT8Vim9atJrDHH+UCy3VKZASyJlz23MpO9RA
         1E3V0P/nrbGvlNDEv2Vicn4Gh0wl5eVPxZwlZEPBkyLI4g9PNJWfUw20B7Vv0XITCilt
         F9owiks43g0gEa+XSiZXzM4+40/5+7y57Jiqd+4+nwZuESK8GFAuzzlVbI10rr2h4E1G
         /oAEzUtgiQgwBSP5AYOPvW/DBLlD/0loCq+aexz64Ug71CBqNHfjpcxekSlfTTpU0DlH
         O3qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sldt1sPhykTlqb6Mu7MbQHPl0rdWO4kLZjQ2yHj8ZvYeL8nLeA7GKRx14GGdMHc/vodmurXdFFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wvg1wQvOaNlfEVprkiB9DcwYJwyWG54mwrMM/q0/8XmkeYgn
	r7e6FeAR3/+qupduvyXEUQa8zbxgjtbFosc7ONONkCDBs3J493Gulen7CGOJrATrWdw=
X-Gm-Gg: Acq92OEXVy1ZG/Z2x1NaS/TxRe6iZtYUmiWSfLYwITAuBlHD+I8nuOxs/jvx6tedP5c
	cMqtJTwKBh/zYFymaAX98B0MmtKTHgwWMWtkxRysA6Zo1wdDjstPuwz4wV4Ofzt3nVScy2HCEGJ
	d6UFQAyeN59S4Vn/er6Ay7JSU6PcE0+g6ti0+kFlszWUeIsJ7lqmZzTIX0iP3h+/BMNjZQalxbQ
	kFXamcQN+4IZYtGObZSN5aRDuIBy44svf6OYHFsmAdKLlBk6AXff2cn9qfRwqzJB9MG76LH8knC
	IlRsggiPl0WVIVVltvNxJfdKH54UbYE14r7ufM+cG2IimJwdZNA3NDp92J9Fy6W48Dm7NCcUBtR
	0qdqKnp1LcMw7ej/fV3GCz5UyCgkXSN9kA114HYUe6CoDpT/pReTQMe6qNI++1hr01dYpCZhvuk
	/0D9gTqJh3/Ow8Gr7+m49RcklhmHIpj4JOrWLpT49c+GhLRQRjaSnAoUy1fgM2fthsQg+PP9RFM
	4JfJO5ozR3WY+KNPg==
X-Received: by 2002:a05:600c:8599:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-490424acb4cmr187576005e9.8.1779713432460;
        Mon, 25 May 2026 05:50:32 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:31 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 25 May 2026 12:50:24 +0000
Subject: [PATCH v5 4/5] arm64: dts: exynos: gs101: Add thermal management
 unit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-acpm-tmu-v5-4-85fde739752e@linaro.org>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
In-Reply-To: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=7065;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=z5Fhpx6IUPSYAgFvZrJUnVUKezx0DwqehwsV2CJ50Xs=;
 b=3kUfL+Zlfc10wC65GccpAO0ZPOAehBJ+CwGSYYMwyBlA4abF5mKa9zhEwrLJ/e2DuOv0D9zzK
 x9O1Mlwz+gUBKJp3v8i5DgWGhBfDRSqnCqBTzSTS4H5kch6hq6l7za7
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the Thermal Management Unit (TMU) support for the Google GS101 SoC.

Describe the TMU using a consolidated SoC node that includes memory
resources for interrupt identification and a phandle to the ACPM IPC
interface for functional control.

Define thermal zones for the little, mid, and big CPU clusters, including
associated trip points and cooling-device maps to enable thermal
mitigation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi | 136 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi     |  18 +++
 2 files changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi
new file mode 100644
index 000000000000..b27d1a539ec2
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Google GS101 TMU configurations device tree source
+ *
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		cpucl2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 0>;
+
+			trips {
+				big_switch_on: big-switch-on {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				big_mitigate: big-mitigate {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				big_hot: big-hot {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				big_critical: big-critical {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&big_mitigate>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpucl1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 1>;
+
+			trips {
+				mid_switch_on: mid-switch-on {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				mid_mitigate: mid-mitigate {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				mid_hot: mid-hot {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				mid_critical: mid-critical {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+				     trip = <&mid_mitigate>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			       };
+			};
+		};
+
+		cpucl0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu_top 2>;
+
+			trips {
+				little_switch_on: little-switch-on {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				little_mitigate: little-mitigate {
+					temperature = <90000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				little_hot: little-hot {
+					temperature = <100000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+
+				little_critical: little-critical {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&little_mitigate>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 86933f22647b..b6866ef99fb3 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -74,6 +74,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -86,6 +87,7 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -98,6 +100,7 @@ cpu2: cpu@200 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -110,6 +113,7 @@ cpu3: cpu@300 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&ananke_cpu_sleep>;
 			capacity-dmips-mhz = <250>;
@@ -122,6 +126,7 @@ cpu4: cpu@400 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -134,6 +139,7 @@ cpu5: cpu@500 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL1>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&enyo_cpu_sleep>;
 			capacity-dmips-mhz = <620>;
@@ -146,6 +152,7 @@ cpu6: cpu@600 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -158,6 +165,7 @@ cpu7: cpu@700 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
 			clocks = <&acpm_ipc GS101_CLK_ACPM_DVFS_CPUCL2>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			cpu-idle-states = <&hera_cpu_sleep>;
 			capacity-dmips-mhz = <1024>;
@@ -639,6 +647,15 @@ watchdog_cl1: watchdog@10070000 {
 			status = "disabled";
 		};
 
+		tmu_top: thermal-sensor@100a0000 {
+			compatible = "google,gs101-tmu-top";
+			reg = <0x100a0000 0x800>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+			interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+			samsung,acpm-ipc = <&acpm_ipc>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		trng: rng@10141400 {
 			compatible = "google,gs101-trng",
 				     "samsung,exynos850-trng";
@@ -1862,3 +1879,4 @@ timer {
 };
 
 #include "gs101-pinctrl.dtsi"
+#include "gs101-tmu.dtsi"

-- 
2.54.0.746.g67dd491aae-goog

