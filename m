From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] Thermal: drivers/thermal/Kconfig refactor
Date: Thu, 15 Nov 2012 15:01:57 +0800
Message-ID: <1352962917.2080.9.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24106 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145Ab2KOHCA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Nov 2012 02:02:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Amit Kachhap <amit.kachhap@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>, patches@linaro.org

drivers/thermal/Kconfig refactor.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig |  103 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

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
1.7.9.5



