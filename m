From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date: Mon, 21 Jan 2019 21:10:26 +0530
Message-ID: <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
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

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
