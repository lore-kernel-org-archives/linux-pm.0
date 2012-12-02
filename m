From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 32/34] thermal: cpu cooling: allow module builds
Date: Sun,  2 Dec 2012 22:45:06 +0800
Message-ID: <1354459508-3707-32-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52515 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab2LBOp6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:58 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>

From: Eduardo Valentin <eduardo.valentin@ti.com>

As thermal drivers can be built as modules and also
the thermal framework itself, building cpu cooling
only as built-in can cause linking errors. For instance:
* Generic Thermal sysfs driver
*
Generic Thermal sysfs driver (THERMAL) [M/n/y/?] m
  generic cpu cooling support (CPU_THERMAL) [N/y/?] (NEW) y

with the following drive:
CONFIG_OMAP_BANDGAP=m

generates:
ERROR: "cpufreq_cooling_unregister" [drivers/staging/omap-thermal/omap-thermal.ko] undefined!
ERROR: "cpufreq_cooling_register" [drivers/staging/omap-thermal/omap-thermal.ko] undefined!

This patch changes cpu cooling driver to allow it
to be built as module.

Reported-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Reviewed-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig     |    2 +-
 include/linux/cpu_cooling.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d96da07..8636fae 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -67,7 +67,7 @@ config USER_SPACE
 	  Enable this to let the user space manage the platform thermals.
 
 config CPU_THERMAL
-	bool "generic cpu cooling support"
+	tristate "generic cpu cooling support"
 	depends on CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index b30cc79c..40b4ef5 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -29,7 +29,7 @@
 #define CPUFREQ_COOLING_START		0
 #define CPUFREQ_COOLING_STOP		1
 
-#ifdef CONFIG_CPU_THERMAL
+#if defined(CONFIG_CPU_THERMAL) || defined(CONFIG_CPU_THERMAL_MODULE)
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
-- 
1.7.7.6

