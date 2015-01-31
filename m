From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 1/1] cpufreq: exynos: allow modular build
Date: Sat, 31 Jan 2015 14:59:42 -0400
Message-ID: <1422730782-13055-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44263 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbAaTBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jan 2015 14:01:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

The exynos cpufreq driver code recently gained a dependency on the
cooling code, which may be a loadable module. This breaks an ARM
allmodconfig build:

drivers/built-in.o: In function `exynos_cpufreq_probe':
:(.text+0x1748e8): undefined reference to `of_cpufreq_cooling_register'

To avoid this problem, change cpufreq Kconfig to allow the drivers
to be loadable modules as well and enforce a dependency on the
thermal module.

This change, in order to allow module builds on this cpufreq
driver, properly constructs the driver into a single module,
instead of several modules. The change also keeps the proper
platform dependency, and therefore, it wont load in platforms
that are not supposed to be loaded. The user will be able to
build the support for all platforms, or select which platforms
(s)he wants (as originally), except that now it can be a module,
instead.

Besides, it will still keep the driver only on those configs
that expect it to be on. And it won't compile/load on platforms
that it is not supposed to. It brings the config ARM_EXYNOS_CPU_FREQ_BOOST_SW
closer to this driver, so it looks better in the menuconfig.

We intentionally change ARM_EXYNOS5440_CPUFREQ to be tristate too, to
avoid future troubles.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Fixes: e725d26c4857 ("cpufreq: exynos: Use device tree to determine if cpufreq cooling should be registered")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 44 ++++++++++++++++++++++++++------------------
 drivers/cpufreq/Makefile    |  9 +++++----
 2 files changed, 31 insertions(+), 22 deletions(-)
---
Changes from V1:
- Instead of having several modules, the driver now is constructed by several
files into a single module, depending on config.
- The patch does not change existing user defconfigs.

If no objections, I will include this in into my -fixes branch.

Cheers,

Eduardo Valentin


diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3..1b06fc4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -26,13 +26,21 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 
 
 config ARM_EXYNOS_CPUFREQ
-	bool
+	tristate "SAMSUNG EXYNOS CPUfreq Driver"
+	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
+	depends on THERMAL
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
+	  Supported SoC versions are:
+	     Exynos4210, Exynos4212, Exynos4412, and Exynos5250.
+
+	  If in doubt, say N.
 
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
 	depends on CPU_EXYNOS4210
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4210
 	  SoC (S5PV310 or S5PC210).
@@ -42,8 +50,8 @@ config ARM_EXYNOS4210_CPUFREQ
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4X12
 	  SoC (EXYNOS4212 or EXYNOS4412).
@@ -53,28 +61,14 @@ config ARM_EXYNOS4X12_CPUFREQ
 config ARM_EXYNOS5250_CPUFREQ
 	bool "SAMSUNG EXYNOS5250"
 	depends on SOC_EXYNOS5250
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS5440_CPUFREQ
-	bool "SAMSUNG EXYNOS5440"
-	depends on SOC_EXYNOS5440
-	depends on HAVE_CLK && OF
-	select PM_OPP
-	default y
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS5440
-	  SoC. The nature of exynos5440 clock controller is
-	  different than previous exynos controllers so not using
-	  the common exynos framework.
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 	bool "EXYNOS Frequency Overclocking - Software"
 	depends on ARM_EXYNOS_CPUFREQ && THERMAL
@@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 
 	  If in doubt, say N.
 
+config ARM_EXYNOS5440_CPUFREQ
+	tristate "SAMSUNG EXYNOS5440"
+	depends on SOC_EXYNOS5440
+	depends on HAVE_CLK && OF
+	select PM_OPP
+	default y
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS5440
+	  SoC. The nature of exynos5440 clock controller is
+	  different than previous exynos controllers so not using
+	  the common exynos framework.
+
+	  If in doubt, say N.
+
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0..b26e2bf 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,10 +51,11 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
+arm-exynos-cpufreq-y					:= exynos-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
-- 
2.1.3

