From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/6] cpufreq: exynos: remove Exynos4x12 specific cpufreq driver
 support
Date: Fri, 10 Apr 2015 19:59:02 +0200
Message-ID: <1428688742-15578-7-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14134 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216AbbDJSAJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 14:00:09 -0400
In-reply-to: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Exynos4x12 based platforms have switched over to use generic
cpufreq driver for cpufreq functionality. So the Exynos
specific cpufreq support for these platforms can be removed.

Based on the earlier work by Thomas Abraham.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |   11 --
 drivers/cpufreq/Makefile             |    1 -
 drivers/cpufreq/exynos-cpufreq.c     |    8 +-
 drivers/cpufreq/exynos-cpufreq.h     |   21 ---
 drivers/cpufreq/exynos4x12-cpufreq.c |  236 ----------------------------------
 5 files changed, 1 insertion(+), 276 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 78cb0b9..1e2c40c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -36,17 +36,6 @@ config ARM_EXYNOS_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS4X12_CPUFREQ
-	bool "SAMSUNG EXYNOS4x12"
-	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
-	depends on ARM_EXYNOS_CPUFREQ
-	default y
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS4X12
-	  SoC (EXYNOS4212 or EXYNOS4412).
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS5250_CPUFREQ
 	bool "SAMSUNG EXYNOS5250"
 	depends on SOC_EXYNOS5250
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index cb16319..337160f 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
 arm-exynos-cpufreq-y					:= exynos-cpufreq.o
-arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index e48d4f1..39764f9 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -141,13 +141,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 	exynos_info->dev = &pdev->dev;
 
-	if (of_machine_is_compatible("samsung,exynos4212")) {
-		exynos_info->type = EXYNOS_SOC_4212;
-		ret = exynos4x12_cpufreq_init(exynos_info);
-	} else if (of_machine_is_compatible("samsung,exynos4412")) {
-		exynos_info->type = EXYNOS_SOC_4412;
-		ret = exynos4x12_cpufreq_init(exynos_info);
-	} else if (of_machine_is_compatible("samsung,exynos5250")) {
+	if (of_machine_is_compatible("samsung,exynos5250")) {
 		exynos_info->type = EXYNOS_SOC_5250;
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index bf03d7e..785bab8 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -18,8 +18,6 @@ enum cpufreq_level_index {
 };
 
 enum exynos_soc_type {
-	EXYNOS_SOC_4212,
-	EXYNOS_SOC_4412,
 	EXYNOS_SOC_5250,
 };
 
@@ -51,14 +49,6 @@ struct exynos_dvfs_info {
 	void __iomem	*cmu_regs;
 };
 
-#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
-extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
-#else
-static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	return -EOPNOTSUPP;
-}
-#endif
 #ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
 extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
 #else
@@ -68,17 +58,6 @@ static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 }
 #endif
 
-#define EXYNOS4_CLKSRC_CPU			0x14200
-#define EXYNOS4_CLKMUX_STATCPU			0x14400
-
-#define EXYNOS4_CLKDIV_CPU			0x14500
-#define EXYNOS4_CLKDIV_CPU1			0x14504
-#define EXYNOS4_CLKDIV_STATCPU			0x14600
-#define EXYNOS4_CLKDIV_STATCPU1			0x14604
-
-#define EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT	(16)
-#define EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)
-
 #define EXYNOS5_APLL_LOCK			0x00000
 #define EXYNOS5_APLL_CON0			0x00100
 #define EXYNOS5_CLKMUX_STATCPU			0x00400
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
deleted file mode 100644
index 9e78a85..0000000
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4X12 - CPU frequency scaling support
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
-static unsigned int exynos4x12_volt_table[] = {
-	1350000, 1287500, 1250000, 1187500, 1137500, 1087500, 1037500,
-	1000000,  987500,  975000,  950000,  925000,  900000,  900000
-};
-
-static struct cpufreq_frequency_table exynos4x12_freq_table[] = {
-	{CPUFREQ_BOOST_FREQ, L0, 1500 * 1000},
-	{0, L1, 1400 * 1000},
-	{0, L2, 1300 * 1000},
-	{0, L3, 1200 * 1000},
-	{0, L4, 1100 * 1000},
-	{0, L5, 1000 * 1000},
-	{0, L6,  900 * 1000},
-	{0, L7,  800 * 1000},
-	{0, L8,  700 * 1000},
-	{0, L9,  600 * 1000},
-	{0, L10, 500 * 1000},
-	{0, L11, 400 * 1000},
-	{0, L12, 300 * 1000},
-	{0, L13, 200 * 1000},
-	{0, 0, CPUFREQ_TABLE_END},
-};
-
-static struct apll_freq *apll_freq_4x12;
-
-static struct apll_freq apll_freq_4212[] = {
-	/*
-	 * values:
-	 * freq
-	 * clock divider for CORE, COREM0, COREM1, PERIPH, ATB, PCLK_DBG, APLL, CORE2
-	 * clock divider for COPY, HPM, RESERVED
-	 * PLL M, P, S
-	 */
-	APLL_FREQ(1500, 0, 3, 7, 0, 6, 1, 2, 0, 6, 2, 0, 250, 4, 0),
-	APLL_FREQ(1400, 0, 3, 7, 0, 6, 1, 2, 0, 6, 2, 0, 175, 3, 0),
-	APLL_FREQ(1300, 0, 3, 7, 0, 5, 1, 2, 0, 5, 2, 0, 325, 6, 0),
-	APLL_FREQ(1200, 0, 3, 7, 0, 5, 1, 2, 0, 5, 2, 0, 200, 4, 0),
-	APLL_FREQ(1100, 0, 3, 6, 0, 4, 1, 2, 0, 4, 2, 0, 275, 6, 0),
-	APLL_FREQ(1000, 0, 2, 5, 0, 4, 1, 1, 0, 4, 2, 0, 125, 3, 0),
-	APLL_FREQ(900,  0, 2, 5, 0, 3, 1, 1, 0, 3, 2, 0, 150, 4, 0),
-	APLL_FREQ(800,  0, 2, 5, 0, 3, 1, 1, 0, 3, 2, 0, 100, 3, 0),
-	APLL_FREQ(700,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 175, 3, 1),
-	APLL_FREQ(600,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 200, 4, 1),
-	APLL_FREQ(500,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 125, 3, 1),
-	APLL_FREQ(400,  0, 2, 4, 0, 3, 1, 1, 0, 3, 2, 0, 100, 3, 1),
-	APLL_FREQ(300,  0, 2, 4, 0, 2, 1, 1, 0, 3, 2, 0, 200, 4, 2),
-	APLL_FREQ(200,  0, 1, 3, 0, 1, 1, 1, 0, 3, 2, 0, 100, 3, 2),
-};
-
-static struct apll_freq apll_freq_4412[] = {
-	/*
-	 * values:
-	 * freq
-	 * clock divider for CORE, COREM0, COREM1, PERIPH, ATB, PCLK_DBG, APLL, CORE2
-	 * clock divider for COPY, HPM, CORES
-	 * PLL M, P, S
-	 */
-	APLL_FREQ(1500, 0, 3, 7, 0, 6, 1, 2, 0, 6, 0, 7, 250, 4, 0),
-	APLL_FREQ(1400, 0, 3, 7, 0, 6, 1, 2, 0, 6, 0, 6, 175, 3, 0),
-	APLL_FREQ(1300, 0, 3, 7, 0, 5, 1, 2, 0, 5, 0, 6, 325, 6, 0),
-	APLL_FREQ(1200, 0, 3, 7, 0, 5, 1, 2, 0, 5, 0, 5, 200, 4, 0),
-	APLL_FREQ(1100, 0, 3, 6, 0, 4, 1, 2, 0, 4, 0, 5, 275, 6, 0),
-	APLL_FREQ(1000, 0, 2, 5, 0, 4, 1, 1, 0, 4, 0, 4, 125, 3, 0),
-	APLL_FREQ(900,  0, 2, 5, 0, 3, 1, 1, 0, 3, 0, 4, 150, 4, 0),
-	APLL_FREQ(800,  0, 2, 5, 0, 3, 1, 1, 0, 3, 0, 3, 100, 3, 0),
-	APLL_FREQ(700,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 3, 175, 3, 1),
-	APLL_FREQ(600,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 2, 200, 4, 1),
-	APLL_FREQ(500,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 2, 125, 3, 1),
-	APLL_FREQ(400,  0, 2, 4, 0, 3, 1, 1, 0, 3, 0, 1, 100, 3, 1),
-	APLL_FREQ(300,  0, 2, 4, 0, 2, 1, 1, 0, 3, 0, 1, 200, 4, 2),
-	APLL_FREQ(200,  0, 1, 3, 0, 1, 1, 1, 0, 3, 0, 0, 100, 3, 2),
-};
-
-static void exynos4x12_set_clkdiv(unsigned int div_index)
-{
-	unsigned int tmp;
-
-	/* Change Divider - CPU0 */
-
-	tmp = apll_freq_4x12[div_index].clk_div_cpu0;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU);
-
-	while (__raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU)
-	       & 0x11111111)
-		cpu_relax();
-
-	/* Change Divider - CPU1 */
-	tmp = apll_freq_4x12[div_index].clk_div_cpu1;
-
-	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU1);
-
-	do {
-		cpu_relax();
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU1);
-	} while (tmp != 0x0);
-}
-
-static void exynos4x12_set_apll(unsigned int index)
-{
-	unsigned int tmp, freq = apll_freq_4x12[index].freq;
-
-	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
-	clk_set_parent(moutcore, mout_mpll);
-
-	do {
-		cpu_relax();
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
-		cpu_relax();
-		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU);
-		tmp &= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
-	} while (tmp != (0x1 << EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
-}
-
-static void exynos4x12_set_frequency(unsigned int old_index,
-				  unsigned int new_index)
-{
-	if (old_index > new_index) {
-		exynos4x12_set_clkdiv(new_index);
-		exynos4x12_set_apll(new_index);
-	} else if (old_index < new_index) {
-		exynos4x12_set_apll(new_index);
-		exynos4x12_set_clkdiv(new_index);
-	}
-}
-
-int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
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
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4412-clock");
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
-	if (info->type == EXYNOS_SOC_4212)
-		apll_freq_4x12 = apll_freq_4212;
-	else
-		apll_freq_4x12 = apll_freq_4412;
-
-	info->mpll_freq_khz = rate;
-	/* 800Mhz */
-	info->pll_safe_idx = L7;
-	info->cpu_clk = cpu_clk;
-	info->volt_table = exynos4x12_volt_table;
-	info->freq_table = exynos4x12_freq_table;
-	info->set_freq = exynos4x12_set_frequency;
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

