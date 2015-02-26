From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] arm64: dts: exynos: Add thermal-zones dt node for
 Exynos5433 SoC
Date: Thu, 26 Feb 2015 20:35:21 +0900
Message-ID: <1424950521-6236-4-git-send-email-cw00.choi@samsung.com>
References: <1424950521-6236-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1424950521-6236-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, l.majewski@samsung.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, chanho61.park@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the thermal-zones devicetree node for Exynos5433 SoC.
The thermal-zones has five thermal-zones and then each thermal-zone contains
each thermal-sensor to monitor the temperature of own IP. The {atlas0|apollo}_
thermal zone have the eight trip-points for interrupt method to detect the
over-temperature.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 231 +++++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi     |   1 +
 2 files changed, 232 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
new file mode 100644
index 0000000..7ff7b0e
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -0,0 +1,231 @@
+/*
+ * Device tree sources for Exynos5433 thermal zone
+ *
+ * Copyright (c) 2015 Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+thermal-zones {
+	atlas0_thermal: atlas0-thermal {
+		thermal-sensors = <&tmu_atlas0>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			atlas0_alert_0: atlas0-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_1: atlas0-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_2: atlas0-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_3: atlas0-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_4: atlas0-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_5: atlas0-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_6: atlas0-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+
+	atlas1_thermal: atlas1-thermal {
+		thermal-sensors = <&tmu_atlas1>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			atlas1_alert_0: atlas1-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_1: atlas1-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_2: atlas1-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_3: atlas1-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_4: atlas1-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_5: atlas1-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_6: atlas1-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+
+	g3d_thermal: g3d-thermal {
+		thermal-sensors = <&tmu_g3d>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			g3d_alert_0: g3d-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_1: g3d-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_2: g3d-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_3: g3d-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_4: g3d-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_5: g3d-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_6: g3d-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+
+	};
+
+	apollo_thermal: apollo-thermal {
+		thermal-sensors = <&tmu_apollo>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			apollo_alert_0: apollo-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_1: apollo-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_2: apollo-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_3: apollo-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_4: apollo-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_5: apollo-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_6: apollo-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+
+	isp_thermal: isp-thermal {
+		thermal-sensors = <&tmu_isp>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			isp_alert_0: isp-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_1: isp-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_2: isp-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_3: isp-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_4: isp-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_5: isp-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_6: isp-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index b44ddcc..fbce27d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -964,3 +964,4 @@
 };
 
 #include "exynos5433-pinctrl.dtsi"
+#include "exynos5433-tmu.dtsi"
-- 
1.8.5.5
