From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date: Fri, 25 Jan 2019 12:32:21 +0530
Message-ID: <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
driver to register as a cooling device and cool down the platform by
throttling the CPU frequency. In order to be able to auto-register a
cpufreq driver as a cooling device from the cpufreq core, we need access
to code inside cpu_cooling.c which, in turn, accesses code inside
thermal core.

CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
(e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
CONFIG_CPU_FREQ is compiled in. This leads to following error:

drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'

Given that platforms using CPU_THERMAL usually want it compiled-in so it
is available early in boot, make CPU_THERMAL depend on THERMAL being
compiled-in instead of allowing it to be a module.

As a result of this change, get rid of the ugly (!CPU_THERMAL ||
THERMAL) dependency in all cpufreq drivers using CPU_THERMAL.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/Kconfig     | 3 ---
 drivers/cpufreq/Kconfig.arm | 5 -----
 drivers/thermal/Kconfig     | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 608af20a3494..b22e6bba71f1 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -207,8 +207,6 @@ comment "CPU frequency scaling drivers"
 config CPUFREQ_DT
 	tristate "Generic DT based cpufreq driver"
 	depends on HAVE_CLK && OF
-	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
-	depends on !CPU_THERMAL || THERMAL
 	select CPUFREQ_DT_PLATDEV
 	select PM_OPP
 	help
@@ -327,7 +325,6 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
-	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..ca8567c3152c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -29,8 +29,6 @@ config ARM_ARMADA_37XX_CPUFREQ
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
 	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
@@ -38,7 +36,6 @@ config ARM_BIG_LITTLE_CPUFREQ
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
-	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCPI
 	  protocol for CPU power management.
@@ -93,7 +90,6 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MEDIATEK_CPUFREQ
 	tristate "CPU Frequency scaling support for MediaTek SoCs"
 	depends on ARCH_MEDIATEK && REGULATOR
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for MediaTek SoCs.
@@ -233,7 +229,6 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..58bb7d72dc2b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -152,6 +152,7 @@ config CPU_THERMAL
 	bool "generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
+	depends on THERMAL=y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
-- 
2.17.1
