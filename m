From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal zone 0 on Exynos5420
Date: Sat, 11 Feb 2017 22:14:56 +0200
Message-ID: <20170211201456.27974-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Willy WOLFF <willy.mh.wolff@gmail.com>, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-pm@vger.kernel.org

In Odroid XU3 Lite board, the temperature levels reported for thermal
zone 0 were weird. In warm room:
	/sys/class/thermal/thermal_zone0/temp:32000
	/sys/class/thermal/thermal_zone1/temp:51000
	/sys/class/thermal/thermal_zone2/temp:55000
	/sys/class/thermal/thermal_zone3/temp:54000
	/sys/class/thermal/thermal_zone4/temp:51000

Sometimes after booting the value was even equal to ambient temperature
which is highly unlikely to be a real temperature of sensor in SoC.

The thermal sensor's calibration (trimming) is based on fused values.
In case of the board above, the fused values are: 35, 52, 43, 58 and 43
(corresponding to each TMU device).  However driver defined a minimum value
for fused data as 40 and for smaller values it was using a hard-coded 55
instead.  This lead to mapping data from sensor to wrong temperatures
for thermal zone 0.

Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
do not impose any limits on fused values.  Since we do not have any
knowledge about these limits, use 0 as a minimum accepted fused value.
This should essentially allow accepting any reasonable fused value thus
behaving like vendor driver.

The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
exynso4412 with one change - the samsung,tmu_min_efuse_value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Testing on other Exynos542x boards is much appreciated. Especially I
wonder what efuse values are there.
---
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 25 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                 | 10 ++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi

diff --git a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
new file mode 100644
index 000000000000..c8771c660550
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Device tree sources for Exynos5420 TMU sensor configuration
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal_exynos.h>
+
+#thermal-sensor-cells = <0>;
+samsung,tmu_gain = <8>;
+samsung,tmu_reference_voltage = <16>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <55>;
+samsung,tmu_min_efuse_value = <0>;
+samsung,tmu_max_efuse_value = <100>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <85>;
+samsung,tmu_default_temp_offset = <50>;
+samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7dc9dc82afd8..83b3899d228d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -699,7 +699,7 @@
 			interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -708,7 +708,7 @@
 			interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -717,7 +717,7 @@
 			interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -726,7 +726,7 @@
 			interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -735,7 +735,7 @@
 			interrupts = <0 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		sysmmu_g2dr: sysmmu@0x10A60000 {
-- 
2.9.3
