From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 09/17] thermal: dts: Default trip points definition for
 Exynos5420 SoCs
Date: Wed, 10 Dec 2014 13:09:48 +0100
Message-ID: <1418213396-743-10-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This code groups in one place default settings of trip points. It is used
in SoCs with multiple instances of TMU sensor.

Separate device tree file prevents from multiple copying of the same data.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 arch/arm/boot/dts/exynos5420-trip-points.dtsi | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi

diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
new file mode 100644
index 0000000..09d6c56
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -0,0 +1,35 @@
+/*
+ * Device tree sources for default Exynos 5420 thermal zone definition
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
+		temperature = <85000>; /* millicelsius */
+		hysteresis = <10000>; /* millicelsius */
+		type = "active";
+	};
+	cpu-alert-1 {
+		temperature = <103000>; /* millicelsius */
+		hysteresis = <10000>; /* millicelsius */
+		type = "active";
+	};
+	cpu-alert-2 {
+		temperature = <110000>; /* millicelsius */
+		hysteresis = <10000>; /* millicelsius */
+		type = "active";
+	};
+	cpu-crit-0 {
+		temperature = <1200000>; /* millicelsius */
+		hysteresis = <0>; /* millicelsius */
+		type = "critical";
+	};
+};
-- 
2.0.0.rc2
