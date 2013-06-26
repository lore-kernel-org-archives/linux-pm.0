From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/3] ARM: EXYNOS: move cpuidle driver to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:13:47 +0200
Message-ID: <1372241627-22695-4-git-send-email-b.zolnierkie@samsung.com>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

While at it:
- remove "common.h" include
- remove wrong comment about file path

Tested on Exynos4210 (Universal C210 board).

Cc: Jaecheol Lee <jc.lee@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Makefile    |  1 -
 arch/arm/mach-exynos/cpuidle.c   | 95 ----------------------------------------
 drivers/cpuidle/Makefile         |  3 ++
 drivers/cpuidle/cpuidle-exynos.c | 92 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 96 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-exynos.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index b09b027..0f91c7a 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
 
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
 
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
deleted file mode 100644
index d6e5115..0000000
--- a/arch/arm/mach-exynos/cpuidle.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/* linux/arch/arm/mach-exynos4/cpuidle.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/time.h>
-
-#include <asm/proc-fns.h>
-#include <asm/cpuidle.h>
-#include <mach/regs-clock.h>
-
-#include "common.h"
-
-static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
-
-static struct cpuidle_driver exynos4_idle_driver = {
-	.name			= "exynos4_idle",
-	.owner			= THIS_MODULE,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE,
-	},
-	.state_count = 1,
-	.safe_state_index = 0,
-};
-
-static void __init exynos5_core_down_clk(void)
-{
-	unsigned int tmp;
-
-	/*
-	 * Enable arm clock down (in idle) and set arm divider
-	 * ratios in WFI/WFE state.
-	 */
-	tmp = PWR_CTRL1_CORE2_DOWN_RATIO | \
-	      PWR_CTRL1_CORE1_DOWN_RATIO | \
-	      PWR_CTRL1_DIV2_DOWN_EN	 | \
-	      PWR_CTRL1_DIV1_DOWN_EN	 | \
-	      PWR_CTRL1_USE_CORE1_WFE	 | \
-	      PWR_CTRL1_USE_CORE0_WFE	 | \
-	      PWR_CTRL1_USE_CORE1_WFI	 | \
-	      PWR_CTRL1_USE_CORE0_WFI;
-	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
-
-	/*
-	 * Enable arm clock up (on exiting idle). Set arm divider
-	 * ratios when not in idle along with the standby duration
-	 * ratios.
-	 */
-	tmp = PWR_CTRL2_DIV2_UP_EN	 | \
-	      PWR_CTRL2_DIV1_UP_EN	 | \
-	      PWR_CTRL2_DUR_STANDBY2_VAL | \
-	      PWR_CTRL2_DUR_STANDBY1_VAL | \
-	      PWR_CTRL2_CORE2_UP_RATIO	 | \
-	      PWR_CTRL2_CORE1_UP_RATIO;
-	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
-}
-
-int __init exynos4_init_cpuidle(void)
-{
-	int cpu_id, ret;
-	struct cpuidle_device *device;
-
-	if (soc_is_exynos5250())
-		exynos5_core_down_clk();
-
-	ret = cpuidle_register_driver(&exynos4_idle_driver);
-	if (ret) {
-		printk(KERN_ERR "CPUidle failed to register driver\n");
-		return ret;
-	}
-
-	for_each_online_cpu(cpu_id) {
-		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
-		device->cpu = cpu_id;
-
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "CPUidle register device failed\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 0d8bd55..37c6178 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -6,4 +6,7 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
+ifeq ($(CONFIG_ARCH_EXYNOS),y)
+	obj-y += cpuidle-exynos.o
+endif
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
new file mode 100644
index 0000000..1c592d2
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/time.h>
+
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
+#include <mach/regs-clock.h>
+
+static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
+
+static struct cpuidle_driver exynos4_idle_driver = {
+	.name			= "exynos4_idle",
+	.owner			= THIS_MODULE,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE,
+	},
+	.state_count = 1,
+	.safe_state_index = 0,
+};
+
+static void __init exynos5_core_down_clk(void)
+{
+	unsigned int tmp;
+
+	/*
+	 * Enable arm clock down (in idle) and set arm divider
+	 * ratios in WFI/WFE state.
+	 */
+	tmp = PWR_CTRL1_CORE2_DOWN_RATIO | \
+	      PWR_CTRL1_CORE1_DOWN_RATIO | \
+	      PWR_CTRL1_DIV2_DOWN_EN	 | \
+	      PWR_CTRL1_DIV1_DOWN_EN	 | \
+	      PWR_CTRL1_USE_CORE1_WFE	 | \
+	      PWR_CTRL1_USE_CORE0_WFE	 | \
+	      PWR_CTRL1_USE_CORE1_WFI	 | \
+	      PWR_CTRL1_USE_CORE0_WFI;
+	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
+
+	/*
+	 * Enable arm clock up (on exiting idle). Set arm divider
+	 * ratios when not in idle along with the standby duration
+	 * ratios.
+	 */
+	tmp = PWR_CTRL2_DIV2_UP_EN	 | \
+	      PWR_CTRL2_DIV1_UP_EN	 | \
+	      PWR_CTRL2_DUR_STANDBY2_VAL | \
+	      PWR_CTRL2_DUR_STANDBY1_VAL | \
+	      PWR_CTRL2_CORE2_UP_RATIO	 | \
+	      PWR_CTRL2_CORE1_UP_RATIO;
+	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
+}
+
+int __init exynos4_init_cpuidle(void)
+{
+	int cpu_id, ret;
+	struct cpuidle_device *device;
+
+	if (soc_is_exynos5250())
+		exynos5_core_down_clk();
+
+	ret = cpuidle_register_driver(&exynos4_idle_driver);
+	if (ret) {
+		printk(KERN_ERR "CPUidle failed to register driver\n");
+		return ret;
+	}
+
+	for_each_online_cpu(cpu_id) {
+		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
+		device->cpu = cpu_id;
+
+		ret = cpuidle_register_device(device);
+		if (ret) {
+			printk(KERN_ERR "CPUidle register device failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
-- 
1.8.2.3
