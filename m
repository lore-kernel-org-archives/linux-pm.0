From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3] thermal: Fix build error of missing devm_ioremap_resource
 on UM
Date: Fri, 04 Mar 2016 10:03:59 +0900
Message-ID: <1457053439-12598-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The devres.o gets linked if HAS_IOMEM is present so on ARCH=um
allyesconfig (COMPILE_TEST) failed on many files with:

drivers/built-in.o: In function `kirkwood_thermal_probe':
kirkwood_thermal.c:(.text+0x390a25): undefined reference to `devm_ioremap_resource'
drivers/built-in.o: In function `exynos_tmu_probe':
exynos_tmu.c:(.text+0x39246b): undefined reference to `devm_ioremap'

The users of devm_ioremap_resource() which are compile-testable should
depend on HAS_IOMEM.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v2:
1. Follow Geert's advice of putting HAS_IOMEM as separate dependency.

Changes since v1:
1. Fix linking error also on TI.
2. Use different approach for HAS_IOMEM dependency. IT is needed only
   for COMPILE_TEST so use && to show that.
---
 drivers/thermal/Kconfig         | 8 ++++++++
 drivers/thermal/samsung/Kconfig | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5e7c97a3f1d8..bc591248144a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -178,6 +178,7 @@ config THERMAL_EMULATION
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
@@ -197,6 +198,7 @@ config IMX_THERMAL
 config SPEAR_THERMAL
 	tristate "SPEAr thermal sensor driver"
 	depends on PLAT_SPEAR || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
@@ -206,6 +208,7 @@ config ROCKCHIP_THERMAL
 	tristate "Rockchip thermal driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  Rockchip thermal driver provides support for Temperature sensor
 	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
@@ -223,6 +226,7 @@ config RCAR_THERMAL
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
@@ -231,6 +235,7 @@ config KIRKWOOD_THERMAL
 config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
 	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
@@ -249,6 +254,7 @@ config DB8500_THERMAL
 config ARMADA_THERMAL
 	tristate "Armada 370/XP thermal management"
 	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on OF
 	help
 	  Enable this option if you want to have support for thermal management
@@ -368,6 +374,7 @@ config INTEL_PCH_THERMAL
 config MTK_THERMAL
 	tristate "Temperature sensor driver for mediatek SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
 	default y
 	help
 	  Enable this option if you want to have support for thermal management
@@ -375,6 +382,7 @@ config MTK_THERMAL
 
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
+depends on HAS_IOMEM
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index e0da3865e060..222e644169f0 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,7 @@
 config EXYNOS_THERMAL
 	tristate "Exynos thermal management unit driver"
 	depends on THERMAL_OF
+	depends on HAS_IOMEM
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
-- 
2.5.0
