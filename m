From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 02/17] thermal: exynos: Provide thermal_exynos.h file to be
 included in device tree files
Date: Wed, 10 Dec 2014 13:09:41 +0100
Message-ID: <1418213396-743-3-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61116 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaLJMK4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 07:10:56 -0500
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

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
---
 drivers/thermal/samsung/exynos_tmu.c         |  2 +-
 drivers/thermal/samsung/exynos_tmu.h         | 24 +++---------------
 include/dt-bindings/thermal/thermal_exynos.h | 37 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 21 deletions(-)
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 32ac366..936d16f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -144,7 +144,7 @@ struct exynos_tmu_data {
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
-	enum soc_type soc;
+	int soc;
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index da3009b..03ebdd0 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -26,24 +26,7 @@
 
 #include "exynos_thermal_common.h"
 
-enum calibration_type {
-	TYPE_ONE_POINT_TRIMMING,
-	TYPE_ONE_POINT_TRIMMING_25,
-	TYPE_ONE_POINT_TRIMMING_85,
-	TYPE_TWO_POINT_TRIMMING,
-	TYPE_NONE,
-};
-
-enum soc_type {
-	SOC_ARCH_EXYNOS3250 = 1,
-	SOC_ARCH_EXYNOS4210,
-	SOC_ARCH_EXYNOS4412,
-	SOC_ARCH_EXYNOS5250,
-	SOC_ARCH_EXYNOS5260,
-	SOC_ARCH_EXYNOS5420,
-	SOC_ARCH_EXYNOS5420_TRIMINFO,
-	SOC_ARCH_EXYNOS5440,
-};
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 /**
  * struct exynos_tmu_platform_data
@@ -115,8 +98,9 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum calibration_type cal_type;
-	enum soc_type type;
+	u32 cal_type;
+	u32 cal_mode;
+	u32 type;
 	struct freq_clip_table freq_tab[4];
 	unsigned int freq_tab_count;
 };
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
new file mode 100644
index 0000000..85789be
--- /dev/null
+++ b/include/dt-bindings/thermal/thermal_exynos.h
@@ -0,0 +1,37 @@
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
+#define SOC_ARCH_EXYNOS3250 1
+#define SOC_ARCH_EXYNOS4210 2
+#define SOC_ARCH_EXYNOS4412 3
+#define SOC_ARCH_EXYNOS5250 4
+#define SOC_ARCH_EXYNOS5260 5
+#define SOC_ARCH_EXYNOS5420_TRIMINFO 6
+#define SOC_ARCH_EXYNOS5420 7
+#define SOC_ARCH_EXYNOS5440 8
+
+#endif /* _EXYNOS_THERMAL_TMU_DT_H */
-- 
2.0.0.rc2

