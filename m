From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 26/34] Refactor drivers/thermal/Kconfig
Date: Sun,  2 Dec 2012 22:45:00 +0800
Message-ID: <1354459508-3707-26-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2LBOpt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:49 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig |  103 +++++++++++++++++++++++------------------------
 1 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 266c15e..937a23d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -13,15 +13,62 @@ menuconfig THERMAL
 	  All platforms with ACPI thermal support can use this driver.
 	  If you want this support, you should say Y or M here.
 
+if THERMAL
+
 config THERMAL_HWMON
 	bool
-	depends on THERMAL
 	depends on HWMON=y || HWMON=THERMAL
 	default y
 
+choice
+	prompt "Default Thermal governor"
+	default THERMAL_DEFAULT_GOV_STEP_WISE
+	help
+	  This option sets which thermal governor shall be loaded at
+	  startup. If in doubt, select 'step_wise'.
+
+config THERMAL_DEFAULT_GOV_STEP_WISE
+	bool "step_wise"
+	select STEP_WISE
+	help
+	  Use the step_wise governor as default. This throttles the
+	  devices one step at a time.
+
+config THERMAL_DEFAULT_GOV_FAIR_SHARE
+	bool "fair_share"
+	select FAIR_SHARE
+	help
+	  Use the fair_share governor as default. This throttles the
+	  devices based on their 'contribution' to a zone. The
+	  contribution should be provided through platform data.
+
+config THERMAL_DEFAULT_GOV_USER_SPACE
+	bool "user_space"
+	select USER_SPACE
+	help
+	  Select this if you want to let the user space manage the
+	  lpatform thermals.
+
+endchoice
+
+config FAIR_SHARE
+	bool "Fair-share thermal governor"
+	help
+	  Enable this to manage platform thermals using fair-share governor.
+
+config STEP_WISE
+	bool "Step_wise thermal governor"
+	help
+	  Enable this to manage platform thermals using a simple linear
+
+config USER_SPACE
+	bool "User_space thermal governor"
+	help
+	  Enable this to let the user space manage the platform thermals.
+
 config CPU_THERMAL
 	bool "generic cpu cooling support"
-	depends on THERMAL && CPU_FREQ
+	depends on CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
 	  This implements the generic cpu cooling mechanism through frequency
@@ -33,7 +80,6 @@ config CPU_THERMAL
 
 config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
-	depends on THERMAL
 	depends on PLAT_SPEAR
 	depends on OF
 	help
@@ -42,7 +88,6 @@ config SPEAR_THERMAL
 
 config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
-	depends on THERMAL
 	depends on ARCH_SHMOBILE
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
@@ -50,57 +95,11 @@ config RCAR_THERMAL
 
 config EXYNOS_THERMAL
 	tristate "Temperature sensor on Samsung EXYNOS"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
+	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
 	select CPU_FREQ_TABLE
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS series of SoC.
 
-config FAIR_SHARE
-	bool "Fair-share thermal governor"
-	depends on THERMAL
-	help
-	  Enable this to manage platform thermals using fair-share governor.
-
-config STEP_WISE
-	bool "Step_wise thermal governor"
-	depends on THERMAL
-	help
-	  Enable this to manage platform thermals using a simple linear
-
-config USER_SPACE
-	bool "User_space thermal governor"
-	depends on THERMAL
-	help
-	  Enable this to let the user space manage the platform thermals.
-
-choice
-	prompt "Default Thermal governor"
-	depends on THERMAL
-	default THERMAL_DEFAULT_GOV_STEP_WISE
-	help
-	  This option sets which thermal governor shall be loaded at
-	  startup. If in doubt, select 'step_wise'.
-
-config THERMAL_DEFAULT_GOV_STEP_WISE
-	bool "step_wise"
-	select STEP_WISE
-	help
-	  Use the step_wise governor as default. This throttles the
-	  devices one step at a time.
-
-config THERMAL_DEFAULT_GOV_FAIR_SHARE
-	bool "fair_share"
-	select FAIR_SHARE
-	help
-	  Use the fair_share governor as default. This throttles the
-	  devices based on their 'contribution' to a zone. The
-	  contribution should be provided through platform data.
 
-config THERMAL_DEFAULT_GOV_USER_SPACE
-	bool "user_space"
-	select USER_SPACE
-	help
-	  Select this if you want to let the user space manage the
-	  platform thermals.
-endchoice
+endif
-- 
1.7.7.6

