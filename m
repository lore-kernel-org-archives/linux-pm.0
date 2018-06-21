From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Thu, 21 Jun 2018 12:35:30 +0200
Message-ID: <8551504.8D13YNfR1X@amdc3058>
References: <CGME20180621103531eucas1p15ccaf3a2069fe5a188daaeb8e2a29a93@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- rebased against current -next kernel

 arch/arm/boot/dts/exynos3250.dtsi                 |    2 +-
 arch/arm/boot/dts/exynos4.dtsi                    |    2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi |   20 --------------------
 arch/arm/boot/dts/exynos5250.dtsi                 |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi                 |    8 ++++----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi |   21 ---------------------
 arch/arm/boot/dts/exynos5420.dtsi                 |   10 +++++-----
 7 files changed, 12 insertions(+), 53 deletions(-)

Index: b/arch/arm/boot/dts/exynos3250.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos3250.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos3250.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -242,7 +242,7 @@
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
Index: b/arch/arm/boot/dts/exynos4.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos4.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -735,7 +735,7 @@
 			reg = <0x100C0000 0x100>;
 			interrupts = <2 4>;
 			status = "disabled";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		jpeg_codec: jpeg-codec@11840000 {
Index: b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos4412 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
Index: b/arch/arm/boot/dts/exynos5250.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5250.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5250.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -301,7 +301,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata: sata@122f0000 {
Index: b/arch/arm/boot/dts/exynos5410.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5410.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5410.dtsi	2018-06-21 12:17:32.091322153 +0200
@@ -93,7 +93,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -102,7 +102,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -111,7 +111,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -120,7 +120,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		mmc_0: mmc@12200000 {
Index: b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5420 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <0>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
Index: b/arch/arm/boot/dts/exynos5420.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5420.dtsi	2018-06-21 12:17:32.107322153 +0200
+++ b/arch/arm/boot/dts/exynos5420.dtsi	2018-06-21 12:17:32.095322153 +0200
@@ -738,7 +738,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -747,7 +747,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -756,7 +756,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -765,7 +765,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -774,7 +774,7 @@
 			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sysmmu_g2dr: sysmmu@10a60000 {
