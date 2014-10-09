From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 06/21] thermal: exynos: Provide thermal_exynos.h file to be
 included in device tree files
Date: Thu, 09 Oct 2014 18:38:42 +0200
Message-ID: <1412872737-624-7-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65353 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbaJIQje (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:39:34 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

This patch is a preparatory patch for being able to read Exynos thermal
configuration from the device tree.

The DTC is not able to interpret enums properly and hence it is necessary
to #define those values explicitly.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c         |  2 +-
 drivers/thermal/samsung/exynos_tmu.h         | 23 +++-------------
 include/dt-bindings/thermal/thermal_exynos.h | 40 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 21 deletions(-)
 create mode 100644 include/dt-bindings/thermal/thermal_exynos.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fa29b95..2f55daa 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -159,7 +159,7 @@ struct exynos_tmu_data {
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
-	enum soc_type soc;
+	int soc;
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index da3009b..a089391 100644
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
@@ -115,8 +98,8 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum calibration_type cal_type;
-	enum soc_type type;
+	u32 cal_type;
+	u32 type;
 	struct freq_clip_table freq_tab[4];
 	unsigned int freq_tab_count;
 };
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
new file mode 100644
index 0000000..5d91d64
--- /dev/null
+++ b/include/dt-bindings/thermal/thermal_exynos.h
@@ -0,0 +1,40 @@
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
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

