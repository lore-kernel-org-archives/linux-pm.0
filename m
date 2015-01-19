From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 10/18] thermal: dts: Default trip points definition for
 Exynos5420 SoCs
Date: Mon, 19 Jan 2015 12:20:54 +0100
Message-ID: <1421666462-7606-11-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58005 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbASLXP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 06:23:15 -0500
In-reply-to: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

This code groups in one place default settings of trip points. It is used
in SoCs with multiple instances of TMU sensor.

Separate device tree file prevents from multiple copying of the same data.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- None
Changes for v4:
- None
Changes for v5:
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

