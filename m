From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 12/12] thermal: exynos: remove separate thermal_exynos.h
 header file
Date: Tue, 06 Mar 2018 15:43:55 +0100
Message-ID: <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

thermal_exynos.h is used only by exynos_tmu.c so there is no need
for a separate include file. Also while it remove unused defines.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c         |  5 +++--
 include/dt-bindings/thermal/thermal_exynos.h | 28 ----------------------------
 2 files changed, 3 insertions(+), 30 deletions(-)
 delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d8b9c3e..a16c37d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -36,8 +36,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpu_cooling.h>
 
-#include <dt-bindings/thermal/thermal_exynos.h>
-
 #include "../thermal_core.h"
 
 /* Exynos generic registers */
@@ -169,6 +167,9 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+#define TYPE_ONE_POINT_TRIMMING			0
+#define TYPE_TWO_POINT_TRIMMING			1
+
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
deleted file mode 100644
index 0646500..0000000
--- a/include/dt-bindings/thermal/thermal_exynos.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
- *
- *  Copyright (C) 2014 Samsung Electronics
- *  Lukasz Majewski <l.majewski@samsung.com>
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
- */
-
-#ifndef _EXYNOS_THERMAL_TMU_DT_H
-#define _EXYNOS_THERMAL_TMU_DT_H
-
-#define TYPE_ONE_POINT_TRIMMING 0
-#define TYPE_ONE_POINT_TRIMMING_25 1
-#define TYPE_ONE_POINT_TRIMMING_85 2
-#define TYPE_TWO_POINT_TRIMMING 3
-#define TYPE_NONE 4
-
-#endif /* _EXYNOS_THERMAL_TMU_DT_H */
-- 
1.9.1
