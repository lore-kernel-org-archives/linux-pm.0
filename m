From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 6/9] cpufreq: shmobile: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:44 +0530
Message-ID: <79f9216705870417483bad374e6ff5ee7b4d267c.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/common.h      |  7 -------
 arch/arm/mach-shmobile/cpufreq.c     | 19 -------------------
 drivers/cpufreq/cpufreq-dt-platdev.c | 12 ++++++++++++
 4 files changed, 12 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/cpufreq.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index a65c80ac9009..c9ea0e6ff4f9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -38,7 +38,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 5464b7a75e30..3b562d87826d 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -25,16 +25,9 @@ static inline int shmobile_suspend_init(void) { return 0; }
 static inline void shmobile_smp_apmu_suspend_init(void) { }
 #endif
 
-#ifdef CONFIG_CPU_FREQ
-int shmobile_cpufreq_init(void);
-#else
-static inline int shmobile_cpufreq_init(void) { return 0; }
-#endif
-
 static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
-	shmobile_cpufreq_init();
 }
 
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
deleted file mode 100644
index 634d701c56a7..000000000000
--- a/arch/arm/mach-shmobile/cpufreq.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * CPUFreq support code for SH-Mobile ARM
- *
- *  Copyright (C) 2014 Gaku Inami
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/platform_device.h>
-
-#include "common.h"
-
-int __init shmobile_cpufreq_init(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-	return 0;
-}
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 75fa921d8540..4b94fe3427f9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -29,6 +29,18 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos5800", },
 #endif
 
+	{ .compatible = "renesas,emev2", },
+	{ .compatible = "renesas,r7s72100", },
+	{ .compatible = "renesas,r8a73a4", },
+	{ .compatible = "renesas,r8a7740", },
+	{ .compatible = "renesas,r8a7778", },
+	{ .compatible = "renesas,r8a7779", },
+	{ .compatible = "renesas,r8a7790", },
+	{ .compatible = "renesas,r8a7791", },
+	{ .compatible = "renesas,r8a7793", },
+	{ .compatible = "renesas,r8a7794", },
+	{ .compatible = "renesas,sh73a0", },
+
 	{ .compatible = "rockchip,rk2928", },
 	{ .compatible = "rockchip,rk3036", },
 	{ .compatible = "rockchip,rk3066a", },
-- 
2.7.1.410.g6faf27b
