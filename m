From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/12] thermal: exynos: remove separate exynos_tmu.h header
 file
Date: Tue, 06 Mar 2018 15:43:52 +0100
Message-ID: <1520347435-22970-10-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144507epcas2p2bcff1b5d29b84d248fcb153e4af63c16@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

exynos_tmu.h is used only by exynos_tmu.c so there is no need
for a separate include file.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++-
 drivers/thermal/samsung/exynos_tmu.h | 41 ------------------------------------
 2 files changed, 17 insertions(+), 42 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ab5062b..d8b9c3e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -34,8 +34,10 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/cpu_cooling.h>
+
+#include <dt-bindings/thermal/thermal_exynos.h>
 
-#include "exynos_tmu.h"
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -173,6 +175,20 @@
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
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
deleted file mode 100644
index 8f56f86..0000000
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ /dev/null
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
-- 
1.9.1
