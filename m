From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] cpufreq: exynos: Add new Exynos3250 cpufreq driver
Date: Fri, 18 Apr 2014 11:20:34 +0900
Message-ID: <1397787634-9334-3-git-send-email-cw00.choi@samsung.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add new Exynos3250 cpufreq driver to support DVFS (Dynamic Voltage
Frequency Scaling). Exynos3250 uses the Cortex-A7 dual cores and has a target
speed of 1.0 GHz. Exynos3250 cpufreq driver has range from 100MHz to 1000MHz.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |  11 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/exynos-cpufreq.c     |   4 +-
 drivers/cpufreq/exynos-cpufreq.h     |  17 ++++
 drivers/cpufreq/exynos3250-cpufreq.c | 158 +++++++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/exynos3250-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0e9cce8..8af1bd1 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -28,6 +28,17 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	bool
 
+config ARM_EXYNOS3250_CPUFREQ
+	bool "SAMSUNG EXYNOS3250"
+	depends on SOC_EXYNOS3250 && !ARCH_MULTIPLATFORM
+	default y
+	select ARM_EXYNOS_CPUFREQ
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS3250 SoC based on
+	  Cortex-A7 dual-core.
+
+	  If in doubt, say N.
+
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
 	depends on CPU_EXYNOS4210 && !ARCH_MULTIPLATFORM
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 0dbb963..18260bb 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS3250_CPUFREQ)	+= exynos3250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 8b4bb4a..e72cc60 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -166,7 +166,9 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 	exynos_info->dev = &pdev->dev;
 
-	if (soc_is_exynos4210())
+	if (soc_is_exynos3250())
+		ret = exynos3250_cpufreq_init(exynos_info);
+	else if (soc_is_exynos4210())
 		ret = exynos4210_cpufreq_init(exynos_info);
 	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		ret = exynos4x12_cpufreq_init(exynos_info);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index b72ff10..9c5e491 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -26,6 +26,15 @@ enum cpufreq_level_index {
 		.mps = ((m) << 16 | (p) << 8 | (s)), \
 	}
 
+#define APLL_FREQ_EXYNOS3(f, a0, a1, a2, a3, a4, a5, b0, b1, b2, m, p, s) \
+	{ \
+		.freq = (f) * 1000, \
+		.clk_div_cpu0 = ((a0) | (a1) << 4 |  (a2) << 16 | (a3) << 20 | \
+			(a4) << 24 | (a5) << 28), \
+		.clk_div_cpu1 = (b0 << 0 | b1 << 4 | b2 << 8), \
+		.mps = ((m) << 16 | (p) << 8 | (s)), \
+	}
+
 struct apll_freq {
 	unsigned int freq;
 	u32 clk_div_cpu0;
@@ -44,6 +53,14 @@ struct exynos_dvfs_info {
 	bool (*need_apll_change)(unsigned int, unsigned int);
 };
 
+#ifdef CONFIG_ARM_EXYNOS3250_CPUFREQ
+extern int exynos3250_cpufreq_init(struct exynos_dvfs_info *);
+#else
+static inline int exynos3250_cpufreq_init(struct exynos_dvfs_info *info)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
 extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
 #else
diff --git a/drivers/cpufreq/exynos3250-cpufreq.c b/drivers/cpufreq/exynos3250-cpufreq.c
new file mode 100644
index 0000000..71f72b8
--- /dev/null
+++ b/drivers/cpufreq/exynos3250-cpufreq.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS3250 - CPU frequency scaling support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/cpufreq.h>
+
+#include "exynos-cpufreq.h"
+
+static struct clk *cpu_clk;
+static struct clk *mout_core;
+static struct clk *mout_mpll;
+static struct clk *mout_apll;
+
+static unsigned int exynos3250_volt_table[] = {
+	1050000, 1050000, 1000000, 950000, 900000,
+	900000,   900000,  900000, 900000, 900000,
+};
+
+static struct cpufreq_frequency_table exynos3250_freq_table[] = {
+	{0, L0, 1000 * 1000},
+	{0, L1,  900 * 1000},
+	{0, L2,  800 * 1000},
+	{0, L3,  700 * 1000},
+	{0, L4,  600 * 1000},
+	{0, L5,  500 * 1000},
+	{0, L6,  400 * 1000},
+	{0, L7,  300 * 1000},
+	{0, L8,  200 * 1000},
+	{0, L9,  100 * 1000},
+	{0, 0, CPUFREQ_TABLE_END},
+};
+
+static struct apll_freq apll_freq_3250[] = {
+	/*
+	 * values:
+	 * freq
+	 * clock divider for CORE, COREM, ATB, PCLK_DBG, APLL, CORE2
+	 * clock divider for COPY, HPM, RESERVED
+	 * PLL M, P, S
+	 */
+	APLL_FREQ_EXYNOS3(1000, 0, 1, 4, 7, 1, 0, 7, 7, 0, 250, 3, 1),
+	APLL_FREQ_EXYNOS3(900,  0, 1, 3, 7, 1, 0, 7, 7, 0, 300, 4, 1),
+	APLL_FREQ_EXYNOS3(800,  0, 1, 3, 7, 1, 0, 7, 7, 0, 200, 3, 1),
+	APLL_FREQ_EXYNOS3(700,  0, 1, 3, 7, 1, 0, 7, 7, 0, 175, 3, 1),
+	APLL_FREQ_EXYNOS3(600,  0, 1, 3, 7, 1, 0, 7, 7, 0, 400, 4, 2),
+	APLL_FREQ_EXYNOS3(500,  0, 1, 3, 7, 1, 0, 7, 7, 0, 250, 3, 2),
+	APLL_FREQ_EXYNOS3(400,  0, 1, 3, 7, 1, 0, 7, 7, 0, 200, 3, 2),
+	APLL_FREQ_EXYNOS3(300,  0, 1, 3, 5, 1, 0, 7, 7, 0, 400, 4, 3),
+	APLL_FREQ_EXYNOS3(200,  0, 1, 3, 3, 1, 0, 7, 7, 0, 200, 3, 3),
+	APLL_FREQ_EXYNOS3(100,  0, 1, 1, 1, 1, 0, 7, 7, 0, 200, 3, 4),
+};
+
+static void exynos3250_set_clkdiv(unsigned int div_index)
+{
+	unsigned int tmp;
+
+	/* Change Divider - CPU0 */
+	tmp = apll_freq_3250[div_index].clk_div_cpu0;
+
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
+
+	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU) & 0x11111111)
+		cpu_relax();
+
+	/* Change Divider - CPU1 */
+	tmp = apll_freq_3250[div_index].clk_div_cpu1;
+
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
+
+	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU1) & 0x111)
+		cpu_relax();
+}
+
+static void exynos3250_set_apll(unsigned int index)
+{
+	unsigned int tmp, freq = apll_freq_3250[index].freq * 1000;
+	struct clk *clk;
+
+	clk = clk_get_parent(mout_apll);
+
+	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
+	clk_set_parent(mout_core, mout_mpll);
+	do {
+		cpu_relax();
+		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
+			>> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
+		tmp &= 0x7;
+	} while (tmp != 0x2);
+
+	clk_set_rate(clk, freq);
+
+	/* MUX_CORE_SEL = APLL */
+	clk_set_parent(mout_core, mout_apll);
+	do {
+		cpu_relax();
+		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
+		tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
+	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
+}
+
+static void exynos3250_set_frequency(unsigned int old_index,
+				  unsigned int new_index)
+{
+	if (old_index > new_index) {
+		exynos3250_set_clkdiv(new_index);
+		exynos3250_set_apll(new_index);
+	} else if (old_index < new_index) {
+		exynos3250_set_apll(new_index);
+		exynos3250_set_clkdiv(new_index);
+	}
+}
+
+int exynos3250_cpufreq_init(struct exynos_dvfs_info *info)
+{
+	unsigned long rate;
+
+	cpu_clk = devm_clk_get(info->dev, "div_core2");
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	mout_core = devm_clk_get(info->dev, "mout_core");
+	if (IS_ERR(mout_core))
+		return PTR_ERR(mout_core);
+
+	mout_mpll = devm_clk_get(info->dev, "mout_mpll_user_c");
+	if (IS_ERR(mout_mpll))
+		return PTR_ERR(mout_mpll);
+	rate = clk_get_rate(mout_mpll) / 1000;
+
+	mout_apll = devm_clk_get(info->dev, "mout_apll");
+	if (IS_ERR(mout_apll))
+		return PTR_ERR(mout_apll);
+
+	info->mpll_freq_khz = rate;
+	info->pll_safe_idx = L2;
+	info->cpu_clk = cpu_clk;
+
+	info->volt_table = exynos3250_volt_table;
+	info->freq_table = exynos3250_freq_table;
+	info->set_freq = exynos3250_set_frequency;
+
+	return 0;
+}
+EXPORT_SYMBOL(exynos3250_cpufreq_init);
-- 
1.8.0

