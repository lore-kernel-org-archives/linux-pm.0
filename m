From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 14/14] arm64: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Mon, 16 Apr 2018 12:12:05 +0200
Message-ID: <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
 .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
 5 files changed, 6 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi

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
