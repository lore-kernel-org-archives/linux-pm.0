From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 01/14] thermal: tegra: move tegra thermal files into tegra directory
Date: Tue, 29 Mar 2016 17:16:04 +0800
Message-ID: <1459242964-25089-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:46482 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751338AbcC2JPo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 05:15:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Move Tegra soctherm driver to tegra directory, it's easy to maintain
and add more new function support for Tegra platforms.
This will also help to split soctherm driver into common parts and
chip specific data related parts.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/Kconfig                                     | 12 ++----------
 drivers/thermal/Makefile                                    |  2 +-
 drivers/thermal/tegra/Kconfig                               | 13 +++++++++++++
 drivers/thermal/tegra/Makefile                              |  1 +
 .../thermal/{tegra_soctherm.c => tegra/tegra-soctherm.c}    |  0
 5 files changed, 17 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thermal/tegra/Kconfig
 create mode 100644 drivers/thermal/tegra/Makefile
 rename drivers/thermal/{tegra_soctherm.c => tegra/tegra-soctherm.c} (100%)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc35a24..594748ee106f 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -260,16 +260,6 @@ config ARMADA_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Armada 370 and Armada XP SoC.
 
-config TEGRA_SOCTHERM
-	tristate "Tegra SOCTHERM thermal management"
-	depends on ARCH_TEGRA
-	help
-	  Enable this option for integrated thermal management support on NVIDIA
-	  Tegra124 systems-on-chip. The driver supports four thermal zones
-	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
-	  zones to manage temperatures. This option is also required for the
-	  emergency thermal reset (thermtrip) feature to function.
-
 config DB8500_CPUFREQ_COOLING
 	tristate "DB8500 cpufreq cooling"
 	depends on ARCH_U8500 || COMPILE_TEST
@@ -397,6 +387,8 @@ depends on ARCH_STI && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+source "drivers/thermal/tegra/Kconfig"
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8e9cbc3b5679..d64f7f707702 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -46,6 +46,6 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-$(CONFIG_ST_THERMAL)	+= st/
-obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
+obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
new file mode 100644
index 000000000000..bed898858d02
--- /dev/null
+++ b/drivers/thermal/tegra/Kconfig
@@ -0,0 +1,13 @@
+menu "NVIDIA Tegra thermal drivers"
+depends on ARCH_TEGRA
+
+config TEGRA_SOCTHERM
+	tristate "Tegra SOCTHERM thermal management"
+	help
+	  Enable this option for integrated thermal management support on NVIDIA
+	  Tegra124 systems-on-chip. The driver supports four thermal zones
+	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
+	  zones to manage temperatures. This option is also required for the
+	  emergency thermal reset (thermtrip) feature to function.
+
+endmenu
diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
new file mode 100644
index 000000000000..d4dc4e7f279e
--- /dev/null
+++ b/drivers/thermal/tegra/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra/tegra-soctherm.c
similarity index 100%
rename from drivers/thermal/tegra_soctherm.c
rename to drivers/thermal/tegra/tegra-soctherm.c
-- 
1.9.1

