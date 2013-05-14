From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V4 05/30] thermal: exynos: Rename exynos_thermal.c to exynos_tmu.c
Date: Tue, 14 May 2013 15:28:35 +0530
Message-ID: <1368525540-15034-6-git-send-email-amit.daniel@samsung.com>
References: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch renames exynos_thermal.c to exynos_tmu.c. This change is needed as
this file now just contains exynos tmu driver related codes and thermal zone
or cpufreq cooling registration related changes are not there anymore.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/Makefile                   |    6 +++---
 .../samsung/{exynos_thermal.c => exynos_tmu.c}     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/thermal/samsung/{exynos_thermal.c => exynos_tmu.c} (99%)

diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index 6227d4f..22528d6 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -1,6 +1,6 @@
 #
 # Samsung thermal specific Makefile
 #
-obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_soc_thermal.o
-exynos_soc_thermal-y				:= exynos_thermal.o
-exynos_soc_thermal-$(CONFIG_EXYNOS_THERMAL_CORE) += exynos_thermal_common.o
+obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
+exynos_thermal-y				:= exynos_tmu.o
+exynos_thermal-$(CONFIG_EXYNOS_THERMAL_CORE)	+= exynos_thermal_common.o
diff --git a/drivers/thermal/samsung/exynos_thermal.c b/drivers/thermal/samsung/exynos_tmu.c
similarity index 99%
rename from drivers/thermal/samsung/exynos_thermal.c
rename to drivers/thermal/samsung/exynos_tmu.c
index 228a4dc..5948f3c 100644
--- a/drivers/thermal/samsung/exynos_thermal.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1,5 +1,5 @@
 /*
- * exynos_thermal.c - Samsung EXYNOS TMU (Thermal Management Unit)
+ * exynos_tmu.c - Samsung EXYNOS TMU (Thermal Management Unit)
  *
  *  Copyright (C) 2011 Samsung Electronics
  *  Donggeun Kim <dg77.kim@samsung.com>
-- 
1.7.1
