From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: EXYNOS: always register TMU driver with core thermal
 framework
Date: Fri, 04 Oct 2013 14:38:25 +0200
Message-ID: <2244251.cWS1a83qbK@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29159 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3JDMib (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 08:38:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

There is little sense in having separate config option for
registering EXYNOS TMU driver with the core thermal framework.
Fix it by integrating EXYNOS_THERMAL_CORE config option with
EXYNOS_THERMAL one.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/Kconfig                 | 14 +++-----------
 drivers/thermal/samsung/Makefile                |  2 +-
 drivers/thermal/samsung/exynos_thermal_common.h | 12 ------------
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f760389..04eabee 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -5,14 +5,6 @@ config EXYNOS_THERMAL
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
 	  the TMU, reports temperature and handles cooling action if defined.
-	  This driver uses the Exynos core thermal APIs and TMU configuration
-	  data from the supported SoCs.
-
-config EXYNOS_THERMAL_CORE
-	bool "Core thermal framework support for EXYNOS SOCs"
-	depends on EXYNOS_THERMAL
-	help
-	  If you say yes here you get support for EXYNOS TMU
-	  (Thermal Management Unit) common registration/unregistration
-	  functions to the core thermal layer and also to use the generic
-	  CPU cooling APIs.
+	  This driver uses the Exynos core thermal APIs, TMU configuration data
+	  from the supported SoCs, common registration/unregistration functions
+	  to the core thermal layer and also the generic CPU cooling APIs.
diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index c09d830..a829107 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,4 +4,4 @@
 obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
 exynos_thermal-y				:= exynos_tmu.o
 exynos_thermal-y				+= exynos_tmu_data.o
-exynos_thermal-$(CONFIG_EXYNOS_THERMAL_CORE)	+= exynos_thermal_common.o
+exynos_thermal-y				+= exynos_thermal_common.o
diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/drivers/thermal/samsung/exynos_thermal_common.h
index 3eb2ed9..8681679 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.h
+++ b/drivers/thermal/samsung/exynos_thermal_common.h
@@ -88,20 +88,8 @@ struct thermal_sensor_conf {
 	struct device *dev;
 };
 
-/*Functions used exynos based thermal sensor driver*/
-#ifdef CONFIG_EXYNOS_THERMAL_CORE
 void exynos_unregister_thermal(struct thermal_sensor_conf *sensor_conf);
 int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf);
 void exynos_report_trigger(struct thermal_sensor_conf *sensor_conf);
-#else
-static inline void
-exynos_unregister_thermal(struct thermal_sensor_conf *sensor_conf) { return; }
 
-static inline int
-exynos_register_thermal(struct thermal_sensor_conf *sensor_conf) { return 0; }
-
-static inline void
-exynos_report_trigger(struct thermal_sensor_conf *sensor_conf) { return; }
-
-#endif /* CONFIG_EXYNOS_THERMAL_CORE */
 #endif /* _EXYNOS_THERMAL_COMMON_H */
-- 
1.8.2.3


