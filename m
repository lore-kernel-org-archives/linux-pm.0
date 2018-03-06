From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 10/12] ARM: dts: remove no longer needed samsung thermal
 properties
Date: Tue, 06 Mar 2018 15:43:53 +0100
Message-ID: <1520347435-22970-11-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144511epcas2p1c1c00d0bdea1e329d2d3d5583f135437@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi                   |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                      |  2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi   | 20 --------------------
 arch/arm/boot/dts/exynos5250.dtsi                   |  2 +-
 arch/arm/boot/dts/exynos5410.dtsi                   |  8 ++++----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi   | 21 ---------------------
 arch/arm/boot/dts/exynos5420.dtsi                   | 10 +++++-----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi   | 20 --------------------
 arch/arm/boot/dts/exynos5440.dtsi                   |  6 +++---
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
 .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
 14 files changed, 21 insertions(+), 142 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 0a5f989..d6e014f 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -227,7 +227,7 @@
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 909a9f2..ca1921d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -736,7 +736,7 @@
 			reg = <0x100C0000 0x100>;
 			interrupts = <2 4>;
 			status = "disabled";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		jpeg_codec: jpeg-codec@11840000 {
diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
deleted file mode 100644
index 489b58c..0000000
--- a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
+++ /dev/null
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
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index bb4180e..6b7654c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -282,7 +282,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata: sata@122f0000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 55509c6..b8b68ec 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
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
diff --git a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
deleted file mode 100644
index fbc77cb..0000000
--- a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
+++ /dev/null
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
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2f3cb2a..85d8656 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -722,7 +722,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -731,7 +731,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -740,7 +740,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -749,7 +749,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -758,7 +758,7 @@
 			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sysmmu_g2dr: sysmmu@0x10A60000 {
diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
deleted file mode 100644
index 0421c3d..0000000
--- a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5440 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <5>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <0x5d2d>;
-samsung,tmu_min_efuse_value = <16>;
-samsung,tmu_max_efuse_value = <76>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <70>;
-samsung,tmu_default_temp_offset = <25>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f3abecc4..a6323a4 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -234,7 +234,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmuctrl_1: tmuctrl@16011c {
@@ -243,7 +243,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmuctrl_2: tmuctrl@160120 {
@@ -252,7 +252,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata@210000 {
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
deleted file mode 100644
index f080357..0000000
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5433 TMU sensor configuration
- *
- * Copyright (c) 2016 Jonghwa Lee <jonghwa3.lee@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <23>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <150>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_mux_addr = <6>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
deleted file mode 100644
index cccae66..0000000
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5433 TMU sensor configuration
- *
- * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <150>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index c0231d0..c414a27 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -637,7 +637,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU0>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -648,7 +648,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU0>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -659,7 +659,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-g3d-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -670,7 +670,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -681,7 +681,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
deleted file mode 100644
index 4849471..0000000
--- a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos7 TMU sensor configuration
- *
- * Copyright (c) 2016 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <9>;
-samsung,tmu_reference_voltage = <17>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <15>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ad9dce6..8834879 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -589,7 +589,7 @@
 			clocks = <&clock_peris PCLK_TMU>,
 				 <&clock_peris SCLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos7-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		thermal-zones {
-- 
1.9.1
