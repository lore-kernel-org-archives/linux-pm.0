From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 02/18] thermal: exynos: Provide thermal_exynos.h file to be
 included in device tree files
Date: Fri, 23 Jan 2015 13:09:55 +0100
Message-ID: <1422015010-11918-3-git-send-email-l.majewski@samsung.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch is a preparatory patch to be able to read Exynos thermal
configuration from the device tree.

It turned out that DTC is not able to interpret enums properly and hence
it is necessary to #define those values explicitly.

For this reason the ./include/dt-bindings/thermal/thermal_exynos.h file
has been introduced.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- Restore 'enum soc_type type' since TMU sensor type will be extracted from
  device tree compatible
Changes for v4:
- None
Changes for v5:
- None
Changes for v6:
- None
---
 drivers/thermal/samsung/exynos_tmu.h         | 12 +++---------
 include/dt-bindings/thermal/thermal_exynos.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index da3009b..7f880d2 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -26,14 +26,6 @@
 
 #include "exynos_thermal_common.h"
 
-enum calibration_type {
-	TYPE_ONE_POINT_TRIMMING,
-	TYPE_ONE_POINT_TRIMMING_25,
-	TYPE_ONE_POINT_TRIMMING_85,
-	TYPE_TWO_POINT_TRIMMING,
-	TYPE_NONE,
-};
-
 enum soc_type {
 	SOC_ARCH_EXYNOS3250 = 1,
 	SOC_ARCH_EXYNOS4210,
@@ -44,6 +36,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5440,
 };
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 /**
  * struct exynos_tmu_platform_data
@@ -115,8 +108,9 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum calibration_type cal_type;
 	enum soc_type type;
+	u32 cal_type;
+	u32 cal_mode;
 	struct freq_clip_table freq_tab[4];
 	unsigned int freq_tab_count;
 };
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
new file mode 100644
index 0000000..0646500
--- /dev/null
+++ b/include/dt-bindings/thermal/thermal_exynos.h
@@ -0,0 +1,28 @@
+/*
+ * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
+ *
+ *  Copyright (C) 2014 Samsung Electronics
+ *  Lukasz Majewski <l.majewski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _EXYNOS_THERMAL_TMU_DT_H
+#define _EXYNOS_THERMAL_TMU_DT_H
+
+#define TYPE_ONE_POINT_TRIMMING 0
+#define TYPE_ONE_POINT_TRIMMING_25 1
+#define TYPE_ONE_POINT_TRIMMING_85 2
+#define TYPE_TWO_POINT_TRIMMING 3
+#define TYPE_NONE 4
+
+#endif /* _EXYNOS_THERMAL_TMU_DT_H */
-- 
2.0.0.rc2
