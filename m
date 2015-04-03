From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/6] cpufreq: exynos: remove Exynos4210 specific cpufreq driver
 support
Date: Fri, 03 Apr 2015 18:43:49 +0200
Message-ID: <1428079429-4252-7-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

Exynos4210 based platforms have switched over to use generic
cpufreq driver for cpufreq functionality. So the Exynos
specific cpufreq support for these platforms can be removed.

Changes by Bartlomiej:
- dropped Exynos5250 support removal for now
- updated exynos-cpufreq.[c,h]

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |   11 --
 drivers/cpufreq/Makefile             |    1 -
 drivers/cpufreq/exynos-cpufreq.c     |    5 +-
 drivers/cpufreq/exynos-cpufreq.h     |    9 --
 drivers/cpufreq/exynos4210-cpufreq.c |  184 ----------------------------------
 5 files changed, 1 insertion(+), 209 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..1d7ddc5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -36,17 +36,6 @@ config ARM_EXYNOS_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS4210_CPUFREQ
-	bool "SAMSUNG EXYNOS4210"
-	depends on CPU_EXYNOS4210
-	depends on ARM_EXYNOS_CPUFREQ
-	default y
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS4210
-	  SoC (S5PV310 or S5PC210).
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 26df0ad..cb16319 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
 arm-exynos-cpufreq-y					:= exynos-cpufreq.o
-arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 01ed166..2d78f63 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -144,10 +144,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 	exynos_info->dev = &pdev->dev;
 
-	if (of_machine_is_compatible("samsung,exynos4210")) {
-		exynos_info->type = EXYNOS_SOC_4210;
-		ret = exynos4210_cpufreq_init(exynos_info);
-	} else if (of_machine_is_compatible("samsung,exynos4212")) {
+	if (of_machine_is_compatible("samsung,exynos4212")) {
 		exynos_info->type = EXYNOS_SOC_4212;
 		ret = exynos4x12_cpufreq_init(exynos_info);
 	} else if (of_machine_is_compatible("samsung,exynos4412")) {
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index fe5a105..bf03d7e 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -18,7 +18,6 @@ enum cpufreq_level_index {
 };
 
 enum exynos_soc_type {
-	EXYNOS_SOC_4210,
 	EXYNOS_SOC_4212,
 	EXYNOS_SOC_4412,
 	EXYNOS_SOC_5250,
@@ -52,14 +51,6 @@ struct exynos_dvfs_info {
 	void __iomem	*cmu_regs;
 };
 
-#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
-extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
-#else
-static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	return -EOPNOTSUPP;
-}
-#endif
 #ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
 extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
 #else
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
deleted file mode 100644
index 843ec82..0000000
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4210 - CPU frequency scaling support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/cpufreq.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include "exynos-cpufreq.h"
-
-static struct clk *cpu_clk;
-static struct clk *moutcore;
-static struct clk *mout_mpll;
-static struct clk *mout_apll;
-static struct exynos_dvfs_info *cpufreq;
-
-static unsigned int exynos4210_volt_table[] = {
-	1250000, 1150000, 1050000, 975000, 950000,
-};
-
-static struct cpufreq_frequency_table exynos4210_freq_table[] = {
-	{0, L0, 1200 * 1000},
-	{0, L1, 1000 * 1000},
-	{0, L2,  800 * 1000},
-	{0, L3,  500 * 1000},
-	{0, L4,  200 * 1000},
-	{0, 0, CPUFREQ_TABLE_END},
-};
-
-static struct apll_freq apll_freq_4210[] = {
-	/*
-	 * values:
-	 * freq
-	 * clock divider for CORE, COREM0, COREM1, PERIPH, ATB, PCLK_DBG, APLL, RESERVED
-	 * clock divider for COPY, HPM, RESERVED
-	 * PLL M, P, S
-	 */
-	APLL_FREQ(1200, 0, 3, 7, 3, 4, 1, 7, 0, 5, 0, 0, 150, 3, 1),
-	APLL_FREQ(1000, 0, 3, 7, 3, 4, 1, 7, 0, 4, 0, 0, 250, 6, 1),
-	APLL_FREQ(800,  0, 3, 7, 3, 3, 1, 7, 0, 3, 0, 0, 200, 6, 1),
-	APLL_FREQ(500,  0, 3, 7, 3, 3, 1, 7, 0, 3, 0, 0, 250, 6, 2),
-	APLL_FREQ(200,  0, 1, 3, 1, 3, 1, 0, 0, 3, 0, 0, 200, 6, 3),
-};
-
-static void exynos4210_set_clkdiv(unsigned int div_index)
-{
-	unsigned int tmp;
-
-	/* Change Divider - CPU0 */
-
-	tmp = apll_freq_4210[div_index].clk_div_cpu0;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU);
-
-	do {
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU);
-	} while (tmp & 0x1111111);
-
-	/* Change Divider - CPU1 */
-
-	tmp = apll_freq_4210[div_index].clk_div_cpu1;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU1);
-
-	do {
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU1);
-	} while (tmp & 0x11);
-}
-
-static void exynos4210_set_apll(unsigned int index)
-{
-	unsigned int tmp, freq = apll_freq_4210[index].freq;
-
-	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
-	clk_set_parent(moutcore, mout_mpll);
-
-	do {
-		tmp = (__raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU)
-			>> EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
-		tmp &= 0x7;
-	} while (tmp != 0x2);
-
-	clk_set_rate(mout_apll, freq * 1000);
-
-	/* MUX_CORE_SEL = APLL */
-	clk_set_parent(moutcore, mout_apll);
-
-	do {
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU);
-		tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
-	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
-}
-
-static void exynos4210_set_frequency(unsigned int old_index,
-				     unsigned int new_index)
-{
-	if (old_index > new_index) {
-		exynos4210_set_clkdiv(new_index);
-		exynos4210_set_apll(new_index);
-	} else if (old_index < new_index) {
-		exynos4210_set_apll(new_index);
-		exynos4210_set_clkdiv(new_index);
-	}
-}
-
-int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	struct device_node *np;
-	unsigned long rate;
-
-	/*
-	 * HACK: This is a temporary workaround to get access to clock
-	 * controller registers directly and remove static mappings and
-	 * dependencies on platform headers. It is necessary to enable
-	 * Exynos multi-platform support and will be removed together with
-	 * this whole driver as soon as Exynos gets migrated to use
-	 * cpufreq-dt driver.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-clock");
-	if (!np) {
-		pr_err("%s: failed to find clock controller DT node\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	info->cmu_regs = of_iomap(np, 0);
-	if (!info->cmu_regs) {
-		pr_err("%s: failed to map CMU registers\n", __func__);
-		return -EFAULT;
-	}
-
-	cpu_clk = clk_get(NULL, "armclk");
-	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
-
-	moutcore = clk_get(NULL, "moutcore");
-	if (IS_ERR(moutcore))
-		goto err_moutcore;
-
-	mout_mpll = clk_get(NULL, "mout_mpll");
-	if (IS_ERR(mout_mpll))
-		goto err_mout_mpll;
-
-	rate = clk_get_rate(mout_mpll) / 1000;
-
-	mout_apll = clk_get(NULL, "mout_apll");
-	if (IS_ERR(mout_apll))
-		goto err_mout_apll;
-
-	info->mpll_freq_khz = rate;
-	/* 800Mhz */
-	info->pll_safe_idx = L2;
-	info->cpu_clk = cpu_clk;
-	info->volt_table = exynos4210_volt_table;
-	info->freq_table = exynos4210_freq_table;
-	info->set_freq = exynos4210_set_frequency;
-
-	cpufreq = info;
-
-	return 0;
-
-err_mout_apll:
-	clk_put(mout_mpll);
-err_mout_mpll:
-	clk_put(moutcore);
-err_moutcore:
-	clk_put(cpu_clk);
-
-	pr_debug("%s: failed initialization\n", __func__);
-	return -EINVAL;
-}
-- 
1.7.9.5
