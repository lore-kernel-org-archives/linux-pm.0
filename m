From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:51 +0530
Message-ID: <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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
index b831f1463227..05ac0ea25c49 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -29,6 +29,18 @@ static const struct of_device_id machines[] = {
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
 	{ .compatible = "rockchip,rk3066a", },
 	{ .compatible = "rockchip,rk3066b", },
-- 
2.7.1.410.g6faf27b
