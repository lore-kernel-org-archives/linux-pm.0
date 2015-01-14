From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 12/16] thermal: dts: exynos: Trip points and sensor
 configuration data for Exynos5440
Date: Wed, 14 Jan 2015 14:41:10 +0100
Message-ID: <1421242874-3425-13-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This commit provides information about Exynos5440 device configuration.
Previously this information was available in exynos_tmu_data.c file.
Now it is available in the device tree.
Such approach allows reusing some common code for thermal.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- "type" property removed
- "samsung,tmu_" prefix for TMU specific properties has been added

---
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 24 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi     | 25 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi

diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
new file mode 100644
index 0000000..7b2fba0
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
@@ -0,0 +1,24 @@
+/*
+ * Device tree sources for Exynos5440 TMU sensor configuration
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
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
+samsung,tmu_gain = <5>;
+samsung,tmu_reference_voltage = <16>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <0x5d2d>;
+samsung,tmu_min_efuse_value = <16>;
+samsung,tmu_max_efuse_value = <76>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <70>;
+samsung,tmu_default_temp_offset = <25>;
+samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5440-trip-points.dtsi b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
new file mode 100644
index 0000000..48adfa8
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Device tree sources for default Exynos5440 thermal zone definition
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+polling-delay-passive = <0>;
+polling-delay = <0>;
+trips {
+	cpu-alert-0 {
+		temperature = <100000>; /* millicelsius */
+		hysteresis = <0>; /* millicelsius */
+		type = "active";
+	};
+	cpu-crit-0 {
+		temperature = <1050000>; /* millicelsius */
+		hysteresis = <0>; /* millicelsius */
+		type = "critical";
+	};
+};
-- 
2.0.0.rc2
