From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v5 3/9] ARM: EXYNOS: Move pmu specific headers under
 "linux/soc/samsung"
Date: Fri, 13 Nov 2015 14:59:37 +0530
Message-ID: <1447406983-27835-4-git-send-email-pankaj.dubey@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pm@vger.kernel.org

Moving Exynos PMU specific header file into "include/linux/soc/samsung"
thus updated affected files under "mach-exynos" to use new location of
these header files.

Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c                                       | 2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                                  | 2 +-
 arch/arm/mach-exynos/platsmp.c                                      | 2 +-
 arch/arm/mach-exynos/pm.c                                           | 4 ++--
 arch/arm/mach-exynos/pmu.c                                          | 6 +++---
 arch/arm/mach-exynos/suspend.c                                      | 4 ++--
 {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h    | 6 +++---
 .../regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h       | 6 +++---
 8 files changed, 16 insertions(+), 16 deletions(-)
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4ffb90e..5d68ce8 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/irqchip.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -31,7 +32,6 @@
 
 #include "common.h"
 #include "mfc.h"
-#include "regs-pmu.h"
 
 void __iomem *pmu_base_addr;
 
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 5697819..f086bf6 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -16,13 +16,13 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
 #include <asm/mcpm.h>
 #include <asm/smp_plat.h>
 
-#include "regs-pmu.h"
 #include "common.h"
 
 #define EXYNOS5420_CPUS_PER_CLUSTER	4
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 98a2c0c..d5caf30 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -30,7 +31,6 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 
 extern void exynos4_secondary_startup(void);
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 9c1506b..b9b9186 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -18,6 +18,8 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #include <asm/firmware.h>
 #include <asm/smp_scu.h>
@@ -29,8 +31,6 @@
 #include <plat/pm-common.h>
 
 #include "common.h"
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index d40f7e9..3974f52 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -17,10 +17,10 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 
-#include <asm/cputype.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
+#include <asm/cputype.h>
 
 #define PMU_TABLE_END	(-1U)
 
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 21abd9b..d02f7c3 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -23,6 +23,8 @@
 #include <linux/of_address.h>
 #include <linux/err.h>
 #include <linux/regulator/machine.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -36,8 +38,6 @@
 #include <plat/pm-common.h>
 
 #include "common.h"
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
 
 #define REG_TABLE_END (-1U)
 
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
similarity index 81%
rename from arch/arm/mach-exynos/exynos-pmu.h
rename to include/linux/soc/samsung/exynos-pmu.h
index a2ab0d5..e2e9de1 100644
--- a/arch/arm/mach-exynos/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -9,8 +9,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __EXYNOS_PMU_H
-#define __EXYNOS_PMU_H
+#ifndef __LINUX_SOC_EXYNOS_PMU_H
+#define __LINUX_SOC_EXYNOS_PMU_H
 
 enum sys_powerdown {
 	SYS_AFTR,
@@ -21,4 +21,4 @@ enum sys_powerdown {
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 
-#endif /* __EXYNOS_PMU_H */
+#endif /* __LINUX_SOC_EXYNOS_PMU_H */
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
similarity index 99%
rename from arch/arm/mach-exynos/regs-pmu.h
rename to include/linux/soc/samsung/exynos-regs-pmu.h
index 5e4f4c2..d30186e 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -9,8 +9,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_REGS_PMU_H
-#define __ASM_ARCH_REGS_PMU_H __FILE__
+#ifndef __LINUX_SOC_EXYNOS_REGS_PMU_H
+#define __LINUX_SOC_EXYNOS_REGS_PMU_H __FILE__
 
 #define S5P_CENTRAL_SEQ_CONFIGURATION		0x0200
 
@@ -690,4 +690,4 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
-#endif /* __ASM_ARCH_REGS_PMU_H */
+#endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
-- 
2.4.5
