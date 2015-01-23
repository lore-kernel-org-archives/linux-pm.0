From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 09/18] thermal: exynos: dts: Add default definition of the
 TMU sensor parameter
Date: Fri, 23 Jan 2015 13:10:01 +0100
Message-ID: <1422015010-11918-9-git-send-email-l.majewski@samsung.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
Changes for v5:
- None
Changes for v6:
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
