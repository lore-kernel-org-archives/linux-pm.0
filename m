From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
Date: Mon, 03 Nov 2014 09:23:00 +0530
Message-ID: <1414986790-11940-3-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17850 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbaKCEAo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Nov 2014 23:00:44 -0500
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Sangbeom Kim <sbkim73@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
to "drivers/mfd". This driver is mainly used for setting misc bits of
register from PMU IP of Exynos SoC which will be required to configure
before Suspend/Resume. Currently all these settings are done in
"arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC support,
there is a need of DT based implementation of PMU driver.

This driver uses already existing DT binding information.

CC: Sangbeom Kim <sbkim73@samsung.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
CC: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/Makefile                      |    2 +-
 drivers/mfd/Kconfig                                |    9 +++++++++
 drivers/mfd/Makefile                               |    1 +
 .../mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c  |    0
 5 files changed, 12 insertions(+), 1 deletion(-)
 rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 96d56ab..c2aef3f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -25,6 +25,7 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
+	select MFD_EXYNOS_PMU
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index bcefb54..b91b382 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cbdb109..619a9ba 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1323,6 +1323,15 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_EXYNOS_PMU
+	tristate "Support Exynos Power Management Unit"
+	depends on ARM || ARM64
+	help
+	  Exynos SoC have Power Management Unit (PMU) which controls power and
+	  operation state of Exynos SoC in two different ways. This driver
+	  provides implementation of PMU driver and provides basic functionality
+	  required during these operation state.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8e679d6..33489b4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_EXYNOS_PMU)	+= exynos-pmu.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/arch/arm/mach-exynos/pmu.c b/drivers/mfd/exynos-pmu.c
similarity index 100%
rename from arch/arm/mach-exynos/pmu.c
rename to drivers/mfd/exynos-pmu.c
-- 
1.7.9.5

