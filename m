From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 08/17] thermal: exynos: dts: Add default definition of the
 TMU sensor parameter
Date: Fri, 16 Jan 2015 12:30:52 +0100
Message-ID: <1421407861-25099-9-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50514 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbbAPLcT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 06:32:19 -0500
In-reply-to: <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Exynos 4 and 5 family of SoCs uses almost identical TMU sensor to measure the
on chip temperature. For this reason it is possible to group TMU configuration
parameters in one dts file.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- "samsung,tmu_" prefix for TMU specific properties has been added
Changes for v4:
- None

---
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi

diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
new file mode 100644
index 0000000..e3f7934
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
@@ -0,0 +1,24 @@
+/*
+ * Device tree sources for Exynos4412 TMU sensor configuration
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
+samsung,tmu_gain = <8>;
+samsung,tmu_reference_voltage = <16>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <55>;
+samsung,tmu_min_efuse_value = <40>;
+samsung,tmu_max_efuse_value = <100>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <85>;
+samsung,tmu_default_temp_offset = <50>;
+samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
-- 
2.0.0.rc2

