From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 14/21] thermal: exynos: dts: Define default thermal-zones for
 Exynos4
Date: Thu, 09 Oct 2014 18:38:50 +0200
Message-ID: <1412872737-624-15-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58897 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621AbaJIQkH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:40:07 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Trip points corresponding to the one defined in the exynos_tmu_data.c
for Exynos4 have been included.
This thermal-zones attribute is afterwards reused for Exynos4210, Exynos4412
and Exynos5250.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
new file mode 100644
index 0000000..506600a
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Device tree sources for Exynos4 thermal zone
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+  thermal-zones {
+	cpu_thermal: cpu-thermal {
+		thermal-sensors = <&tmu 0>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			cpu_alert0: cpu-alert-0 {
+				temperature = <70000>; /* millicelsius */
+				hysteresis = <10000>; /* millicelsius */
+				type = "active";
+			};
+			cpu_alert1: cpu-alert-1 {
+				temperature = <95000>; /* millicelsius */
+				hysteresis = <10000>; /* millicelsius */
+				type = "active";
+			};
+			cpu_alert2: cpu-alert-2 {
+				temperature = <110000>; /* millicelsius */
+				hysteresis = <10000>; /* millicelsius */
+				type = "active";
+			};
+			cpu_crit0: cpu-crit-0 {
+				temperature = <120000>; /* millicelsius */
+				hysteresis = <0>; /* millicelsius */
+				type = "critical";
+			};
+		};
+		cooling-maps {
+			map0 {
+			    trip = <&cpu_alert0>;
+			};
+			map1 {
+			    trip = <&cpu_alert1>;
+			};
+		};
+	};
+  };
+};
-- 
2.0.0.rc2

