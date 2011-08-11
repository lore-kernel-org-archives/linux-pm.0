From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/4] ARM: EXYNOS4: Support for generic I/O power
 domains on EXYNOS4210
Date: Thu, 11 Aug 2011 13:55:15 +0900
Message-ID: <4E4360B3.7030804__17773.3689467006$1313038619$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Use the generic power domains support to implement support for
power domain on EXYNOS4210.

I refer to the following patch to implement what configure
the clock-gating control register for block to turn off/on:
http://git.infradead.org/users/kmpark/linux-2.6-samsung/commit/39a81876d034dcbdc2a4c4c4b847b3b49e38870c

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig                      |    1 +
 arch/arm/mach-exynos4/Makefile                     |    1 +
 arch/arm/mach-exynos4/include/mach/pm-exynos4210.h |   52 ++++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h    |    8 +
 arch/arm/mach-exynos4/pm-exynos4210.c              |  189 ++++++++++++++++++++
 5 files changed, 251 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
 create mode 100644 arch/arm/mach-exynos4/pm-exynos4210.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 64baca7..8d5e876 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -12,6 +12,7 @@ if ARCH_EXYNOS4
 config CPU_EXYNOS4210
 	bool
 	select S3C_PL330_DMA
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index b7fe1d7..97c31ce 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= pm-exynos4210.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h b/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
new file mode 100644
index 0000000..e36425a
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
@@ -0,0 +1,52 @@
+/* linux/arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
+ *
+ * Exynos4210 Power management support
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PM_EXYNOS4210_H
+#define PM_EXYNOS4210_H
+
+#include <linux/pm_domain.h>
+
+struct platform_device;
+
+struct exynos4210_pm_domain {
+	struct generic_pm_domain genpd;
+
+	const char *name;
+	void __iomem *base;
+	u32 clkgate_mask;
+	int boot_on;
+};
+
+static inline struct exynos4210_pm_domain *to_exynos4210_pd(
+		struct generic_pm_domain *pd)
+{
+	return container_of(pd, struct exynos4210_pm_domain, genpd);
+}
+
+#ifdef CONFIG_PM
+extern struct exynos4210_pm_domain exynos4210_pd_mfc;
+extern struct exynos4210_pm_domain exynos4210_pd_g3d;
+extern struct exynos4210_pm_domain exynos4210_pd_lcd0;
+extern struct exynos4210_pm_domain exynos4210_pd_lcd1;
+extern struct exynos4210_pm_domain exynos4210_pd_tv;
+extern struct exynos4210_pm_domain exynos4210_pd_cam;
+extern struct exynos4210_pm_domain exynos4210_pd_gps;
+
+extern void exynos4210_init_pm_domain(struct exynos4210_pm_domain *exynos4210_pd);
+extern void exynos4210_add_device_to_domain(struct exynos4210_pm_domain *exynos4210_pd,
+				struct platform_device *pdev);
+#else
+#define exynos4210_init_pm_domain(pd) do { } while(0)
+#define exynos4210_add_device_to_domain(pd, pdev) do { } while(0)
+#endif /* CONFIG_PM */
+
+#endif /* PM_EXYNOS4210_H */
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index d493fdb..0d1c9ec 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -183,6 +183,14 @@
 #define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
 #define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 << S5P_CLKDIV_BUS_GPLR_SHIFT)
 
+#define S5P_CLKGATE_BLOCK_CAM		(1 << 0)
+#define S5P_CLKGATE_BLOCK_TV		(1 << 1)
+#define S5P_CLKGATE_BLOCK_MFC		(1 << 2)
+#define S5P_CLKGATE_BLOCK_G3D		(1 << 3)
+#define S5P_CLKGATE_BLOCK_LCD0		(1 << 4)
+#define S5P_CLKGATE_BLOCK_LCD1		(1 << 5)
+#define S5P_CLKGATE_BLOCK_GPS		(1 << 7)
+
 /* Compatibility defines and inclusion */
 
 #include <mach/regs-pmu.h>
diff --git a/arch/arm/mach-exynos4/pm-exynos4210.c b/arch/arm/mach-exynos4/pm-exynos4210.c
new file mode 100644
index 0000000..d43c37f
--- /dev/null
+++ b/arch/arm/mach-exynos4/pm-exynos4210.c
@@ -0,0 +1,189 @@
+/* linux/arch/arm/mach-exynos4/pm-exynos4210.c
+ *
+ * Exynos4210 Power management support
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pm.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/io.h>
+
+#include <mach/regs-clock.h>
+#include <mach/pm-exynos4210.h>
+
+#ifdef CONFIG_PM
+static DEFINE_SPINLOCK(clkgate_block_lock);
+
+static int pd_power_down(struct generic_pm_domain *genpd)
+{
+	struct exynos4210_pm_domain *exynos4210_pd = to_exynos4210_pd(genpd);
+	u32 timeout;
+
+	/* Disable the power of power-domain */
+	__raw_writel(0, exynos4210_pd->base);
+
+	/* Wait max 1ms */
+	timeout = 10;
+	while (__raw_readl(exynos4210_pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
+		if (timeout == 0) {
+			printk(KERN_ERR "Power domain %s disable failed.\n",
+				exynos4210_pd->name);
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		udelay(100);
+	}
+
+	/* Configure the clock-gating control register for block to turn off */
+	if (exynos4210_pd->clkgate_mask) {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&clkgate_block_lock, flags);
+		reg = __raw_readl(S5P_CLKGATE_BLOCK);
+		reg &= ~exynos4210_pd->clkgate_mask;
+		__raw_writel(reg, S5P_CLKGATE_BLOCK);
+		spin_unlock_irqrestore(&clkgate_block_lock, flags);
+	}
+
+	return 0;
+}
+
+static int pd_power_up(struct generic_pm_domain *genpd)
+{
+	struct exynos4210_pm_domain *exynos4210_pd = to_exynos4210_pd(genpd);
+	u32 timeout;
+
+	/* Enable power domain */
+	__raw_writel(S5P_INT_LOCAL_PWR_EN, exynos4210_pd->base);
+
+	/* Wait max 1ms */
+	timeout = 10;
+	while ((__raw_readl(exynos4210_pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN)
+		!= S5P_INT_LOCAL_PWR_EN) {
+		if (timeout == 0) {
+			printk(KERN_ERR "Power domain %s enable failed.\n",
+				exynos4210_pd->name);
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		udelay(100);
+	}
+
+	/* Configure the clock-gating control register for block to turn on */
+	if (exynos4210_pd->clkgate_mask) {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&clkgate_block_lock, flags);
+		reg = __raw_readl(S5P_CLKGATE_BLOCK);
+		reg |= exynos4210_pd->clkgate_mask;
+		__raw_writel(reg, S5P_CLKGATE_BLOCK);
+		spin_unlock_irqrestore(&clkgate_block_lock, flags);
+	}
+
+	return 0;
+}
+
+static bool pd_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
+void exynos4210_init_pm_domain(struct exynos4210_pm_domain *exynos4210_pd)
+{
+	struct generic_pm_domain *genpd;
+
+	if (!exynos4210_pd)
+		return;
+
+	genpd = &exynos4210_pd->genpd;
+
+	pm_genpd_init(genpd, NULL, false);
+	genpd->stop_device = pm_clk_suspend;
+	genpd->start_device = pm_clk_resume;
+	genpd->active_wakeup = pd_active_wakeup;
+	genpd->power_off = pd_power_down;
+	genpd->power_on = pd_power_up;
+
+	if (exynos4210_pd->boot_on)
+		pd_power_up(&exynos4210_pd->genpd);
+}
+
+void exynos4210_add_device_to_domain(struct exynos4210_pm_domain *exynos4210_pd,
+				struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	if (!exynos4210_pd || !pdev)
+		return;
+
+	if (!dev->power.subsys_data) {
+		pm_clk_init(dev);
+		pm_clk_add(dev, NULL);
+	}
+	pm_genpd_add_device(&exynos4210_pd->genpd, dev);
+}
+
+struct exynos4210_pm_domain exynos4210_pd_mfc = {
+	.name		= "PD_MFC",
+	.base		= S5P_PMU_MFC_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_MFC,
+	.boot_on	= 0,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_g3d = {
+	.name		= "PD_G3D",
+	.base		= S5P_PMU_G3D_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_G3D,
+	.boot_on	= 0,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_lcd0 = {
+	.name		= "PD_LCD0",
+	.base		= S5P_PMU_LCD0_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_LCD0,
+	.boot_on	= 1,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_lcd1 = {
+	.name		= "PD_LCD1",
+	.base		= S5P_PMU_LCD1_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_LCD1,
+	.boot_on	= 0,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_tv = {
+	.name		= "PD_TV",
+	.base		= S5P_PMU_TV_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_TV,
+	.boot_on	= 0,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_cam = {
+	.name		= "PD_CAM",
+	.base		= S5P_PMU_CAM_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_CAM,
+	.boot_on	= 0,
+};
+
+struct exynos4210_pm_domain exynos4210_pd_gps = {
+	.name		= "PD_GPS",
+	.base		= S5P_PMU_GPS_CONF,
+	.clkgate_mask	= S5P_CLKGATE_BLOCK_GPS,
+	.boot_on	= 0,
+};
+
+#endif	/* CONFIG_PM */
-- 
1.7.0.4
