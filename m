From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v12 5/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
Date: Fri, 21 Nov 2014 19:01:21 +0530
Message-ID: <1416576682-5255-6-git-send-email-thomas.ab@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-2-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-3-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-5-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576682-5255-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos4210 and Exynos5250 based platforms have switched over to use generic
cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
drivers for these platforms can be removed.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |   22 ----
 drivers/cpufreq/Makefile             |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c |  184 -----------------------------
 drivers/cpufreq/exynos5250-cpufreq.c |  210 ----------------------------------
 4 files changed, 0 insertions(+), 418 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 83a75dc..701f5ca 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -28,17 +28,6 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	bool
 
-config ARM_EXYNOS4210_CPUFREQ
-	bool "SAMSUNG EXYNOS4210"
-	depends on CPU_EXYNOS4210
-	default y
-	select ARM_EXYNOS_CPUFREQ
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS4210
-	  SoC (S5PV310 or S5PC210).
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
@@ -50,17 +39,6 @@ config ARM_EXYNOS4X12_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS5250_CPUFREQ
-	bool "SAMSUNG EXYNOS5250"
-	depends on SOC_EXYNOS5250
-	default y
-	select ARM_EXYNOS_CPUFREQ
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS5250
-	  SoC.
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS5440_CPUFREQ
 	bool "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 40c53dc..74e55f9 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,9 +52,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
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
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
deleted file mode 100644
index 3eafdc7..0000000
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * Copyright (c) 2010-20122Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS5250 - CPU frequency scaling support
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
-static unsigned int exynos5250_volt_table[] = {
-	1300000, 1250000, 1225000, 1200000, 1150000,
-	1125000, 1100000, 1075000, 1050000, 1025000,
-	1012500, 1000000,  975000,  950000,  937500,
-	925000
-};
-
-static struct cpufreq_frequency_table exynos5250_freq_table[] = {
-	{0, L0, 1700 * 1000},
-	{0, L1, 1600 * 1000},
-	{0, L2, 1500 * 1000},
-	{0, L3, 1400 * 1000},
-	{0, L4, 1300 * 1000},
-	{0, L5, 1200 * 1000},
-	{0, L6, 1100 * 1000},
-	{0, L7, 1000 * 1000},
-	{0, L8,  900 * 1000},
-	{0, L9,  800 * 1000},
-	{0, L10, 700 * 1000},
-	{0, L11, 600 * 1000},
-	{0, L12, 500 * 1000},
-	{0, L13, 400 * 1000},
-	{0, L14, 300 * 1000},
-	{0, L15, 200 * 1000},
-	{0, 0, CPUFREQ_TABLE_END},
-};
-
-static struct apll_freq apll_freq_5250[] = {
-	/*
-	 * values:
-	 * freq
-	 * clock divider for ARM, CPUD, ACP, PERIPH, ATB, PCLK_DBG, APLL, ARM2
-	 * clock divider for COPY, HPM, RESERVED
-	 * PLL M, P, S
-	 */
-	APLL_FREQ(1700, 0, 3, 7, 7, 7, 3, 5, 0, 0, 2, 0, 425, 6, 0),
-	APLL_FREQ(1600, 0, 3, 7, 7, 7, 1, 4, 0, 0, 2, 0, 200, 3, 0),
-	APLL_FREQ(1500, 0, 2, 7, 7, 7, 1, 4, 0, 0, 2, 0, 250, 4, 0),
-	APLL_FREQ(1400, 0, 2, 7, 7, 6, 1, 4, 0, 0, 2, 0, 175, 3, 0),
-	APLL_FREQ(1300, 0, 2, 7, 7, 6, 1, 3, 0, 0, 2, 0, 325, 6, 0),
-	APLL_FREQ(1200, 0, 2, 7, 7, 5, 1, 3, 0, 0, 2, 0, 200, 4, 0),
-	APLL_FREQ(1100, 0, 3, 7, 7, 5, 1, 3, 0, 0, 2, 0, 275, 6, 0),
-	APLL_FREQ(1000, 0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 125, 3, 0),
-	APLL_FREQ(900,  0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 150, 4, 0),
-	APLL_FREQ(800,  0, 1, 7, 7, 4, 1, 2, 0, 0, 2, 0, 100, 3, 0),
-	APLL_FREQ(700,  0, 1, 7, 7, 3, 1, 1, 0, 0, 2, 0, 175, 3, 1),
-	APLL_FREQ(600,  0, 1, 7, 7, 3, 1, 1, 0, 0, 2, 0, 200, 4, 1),
-	APLL_FREQ(500,  0, 1, 7, 7, 2, 1, 1, 0, 0, 2, 0, 125, 3, 1),
-	APLL_FREQ(400,  0, 1, 7, 7, 2, 1, 1, 0, 0, 2, 0, 100, 3, 1),
-	APLL_FREQ(300,  0, 1, 7, 7, 1, 1, 1, 0, 0, 2, 0, 200, 4, 2),
-	APLL_FREQ(200,  0, 1, 7, 7, 1, 1, 1, 0, 0, 2, 0, 100, 3, 2),
-};
-
-static void set_clkdiv(unsigned int div_index)
-{
-	unsigned int tmp;
-
-	/* Change Divider - CPU0 */
-
-	tmp = apll_freq_5250[div_index].clk_div_cpu0;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS5_CLKDIV_CPU0);
-
-	while (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKDIV_STATCPU0)
-	       & 0x11111111)
-		cpu_relax();
-
-	/* Change Divider - CPU1 */
-	tmp = apll_freq_5250[div_index].clk_div_cpu1;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS5_CLKDIV_CPU1);
-
-	while (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKDIV_STATCPU1) & 0x11)
-		cpu_relax();
-}
-
-static void set_apll(unsigned int index)
-{
-	unsigned int tmp;
-	unsigned int freq = apll_freq_5250[index].freq;
-
-	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
-	clk_set_parent(moutcore, mout_mpll);
-
-	do {
-		cpu_relax();
-		tmp = (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKMUX_STATCPU)
-			>> 16);
-		tmp &= 0x7;
-	} while (tmp != 0x2);
-
-	clk_set_rate(mout_apll, freq * 1000);
-
-	/* MUX_CORE_SEL = APLL */
-	clk_set_parent(moutcore, mout_apll);
-
-	do {
-		cpu_relax();
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKMUX_STATCPU);
-		tmp &= (0x7 << 16);
-	} while (tmp != (0x1 << 16));
-}
-
-static void exynos5250_set_frequency(unsigned int old_index,
-				  unsigned int new_index)
-{
-	if (old_index > new_index) {
-		set_clkdiv(new_index);
-		set_apll(new_index);
-	} else if (old_index < new_index) {
-		set_apll(new_index);
-		set_clkdiv(new_index);
-	}
-}
-
-int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
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
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-clock");
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
-	moutcore = clk_get(NULL, "mout_cpu");
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
-	info->pll_safe_idx = L9;
-	info->cpu_clk = cpu_clk;
-	info->volt_table = exynos5250_volt_table;
-	info->freq_table = exynos5250_freq_table;
-	info->set_freq = exynos5250_set_frequency;
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
-	pr_err("%s: failed initialization\n", __func__);
-	return -EINVAL;
-}
-- 
1.6.6.rc2
