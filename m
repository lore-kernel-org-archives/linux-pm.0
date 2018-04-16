From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 12/14] thermal: exynos: remove separate exynos_tmu.h
 header file
Date: Mon, 16 Apr 2018 16:22:19 +0200
Message-ID: <2686175.IEZVfBECIu@amdc3058>
References: <CGME20180416142221eucas1p1ded332b5b69a9f3f1224914e48b28c19@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

exynos_tmu.h is used only by exynos_tmu.c so there is no need
for a separate include file.

Also while at it remove no longer needed cpu_cooling.h include.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Replacement patch for v1.

v2:
- Remove cpu_cooling.h include (as requested by Daniel)
- Add Acked-by from Daniel

 drivers/thermal/samsung/exynos_tmu.c |   17 +++++++++++++-
 drivers/thermal/samsung/exynos_tmu.h |   41 -----------------------------------
 2 files changed, 16 insertions(+), 42 deletions(-)

Index: b/drivers/thermal/samsung/exynos_tmu.c
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.c	2018-04-16 16:13:18.995562674 +0200
+++ b/drivers/thermal/samsung/exynos_tmu.c	2018-04-16 16:13:28.663562918 +0200
@@ -35,7 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-#include "exynos_tmu.h"
+#include <dt-bindings/thermal/thermal_exynos.h>
+
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -173,6 +174,20 @@
 #define EXYNOS_NOISE_CANCEL_MODE		4
 
 #define MCELSIUS	1000
+
+enum soc_type {
+	SOC_ARCH_EXYNOS3250 = 1,
+	SOC_ARCH_EXYNOS4210,
+	SOC_ARCH_EXYNOS4412,
+	SOC_ARCH_EXYNOS5250,
+	SOC_ARCH_EXYNOS5260,
+	SOC_ARCH_EXYNOS5420,
+	SOC_ARCH_EXYNOS5420_TRIMINFO,
+	SOC_ARCH_EXYNOS5433,
+	SOC_ARCH_EXYNOS5440,
+	SOC_ARCH_EXYNOS7,
+};
+
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
 	driver
Index: b/drivers/thermal/samsung/exynos_tmu.h
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.h	2018-04-16 16:13:18.995562674 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/*
- * exynos_tmu.h - Samsung EXYNOS TMU (Thermal Management Unit)
- *
- *  Copyright (C) 2011 Samsung Electronics
- *  Donggeun Kim <dg77.kim@samsung.com>
- *  Amit Daniel Kachhap <amit.daniel@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef _EXYNOS_TMU_H
-#define _EXYNOS_TMU_H
-#include <linux/cpu_cooling.h>
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-enum soc_type {
-	SOC_ARCH_EXYNOS3250 = 1,
-	SOC_ARCH_EXYNOS4210,
-	SOC_ARCH_EXYNOS4412,
-	SOC_ARCH_EXYNOS5250,
-	SOC_ARCH_EXYNOS5260,
-	SOC_ARCH_EXYNOS5420,
-	SOC_ARCH_EXYNOS5420_TRIMINFO,
-	SOC_ARCH_EXYNOS5433,
-	SOC_ARCH_EXYNOS5440,
-	SOC_ARCH_EXYNOS7,
-};
-
-#endif /* _EXYNOS_TMU_H */
