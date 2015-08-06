From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 5/6] cpufreq: exynos: remove Exynos4x12 specific cpufreq
 driver support
Date: Thu, 06 Aug 2015 15:41:53 +0200
Message-ID: <1438868514-8814-6-git-send-email-b.zolnierkie@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Exynos4x12 based platforms have switched over to use generic
cpufreq driver for cpufreq functionality.  So the Exynos
specific cpufreq support for these platforms can be removed.

Also once Exynos4x12 based platforms support have been removed
the shared exynos-cpufreq driver is no longer needed and can
be deleted.

Based on the earlier work by Thomas Abraham.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig.arm          |  38 ------
 drivers/cpufreq/Makefile             |   2 -
 drivers/cpufreq/exynos-cpufreq.c     | 236 -----------------------------------
 drivers/cpufreq/exynos-cpufreq.h     |  72 -----------
 drivers/cpufreq/exynos4x12-cpufreq.c | 236 -----------------------------------
 5 files changed, 584 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9ab6388c1..8a24bd8 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,44 +24,6 @@ config ARM_VEXPRESS_SPC_CPUFREQ
           This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
 
-
-config ARM_EXYNOS_CPUFREQ
-	tristate "SAMSUNG EXYNOS CPUfreq Driver"
-	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
-	depends on THERMAL
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
-	  Supported SoC versions are:
-	     Exynos4210, Exynos4212, Exynos4412, and Exynos5250.
-
-	  If in doubt, say N.
-
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
-config ARM_EXYNOS_CPU_FREQ_BOOST_SW
-	bool "EXYNOS Frequency Overclocking - Software"
-	depends on ARM_EXYNOS_CPUFREQ && THERMAL
-	select CPU_FREQ_BOOST_SW
-	select EXYNOS_THERMAL
-	help
-	  This driver supports software managed overclocking (BOOST).
-	  It allows usage of special frequencies for Samsung Exynos
-	  processors if thermal conditions are appropriate.
-
-	  It requires, for safe operation, thermal framework with properly
-	  defined trip points.
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS5440_CPUFREQ
 	tristate "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 6414958..bbc4a9f 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,8 +53,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
-arm-exynos-cpufreq-y					:= exynos-cpufreq.o
-arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
deleted file mode 100644
index 567a6ab..0000000
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS - CPU frequency scaling support for EXYNOS series
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/regulator/consumer.h>
-#include <linux/cpufreq.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/cpu_cooling.h>
-#include <linux/cpu.h>
-
-#include "exynos-cpufreq.h"
-
-static struct exynos_dvfs_info *exynos_info;
-static struct thermal_cooling_device *cdev;
-static struct regulator *arm_regulator;
-static unsigned int locking_frequency;
-
-static int exynos_cpufreq_get_index(unsigned int freq)
-{
-	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
-	struct cpufreq_frequency_table *pos;
-
-	cpufreq_for_each_entry(pos, freq_table)
-		if (pos->frequency == freq)
-			break;
-
-	if (pos->frequency == CPUFREQ_TABLE_END)
-		return -EINVAL;
-
-	return pos - freq_table;
-}
-
-static int exynos_cpufreq_scale(unsigned int target_freq)
-{
-	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
-	unsigned int *volt_table = exynos_info->volt_table;
-	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
-	unsigned int arm_volt, safe_arm_volt = 0;
-	unsigned int mpll_freq_khz = exynos_info->mpll_freq_khz;
-	struct device *dev = exynos_info->dev;
-	unsigned int old_freq;
-	int index, old_index;
-	int ret = 0;
-
-	old_freq = policy->cur;
-
-	/*
-	 * The policy max have been changed so that we cannot get proper
-	 * old_index with cpufreq_frequency_table_target(). Thus, ignore
-	 * policy and get the index from the raw frequency table.
-	 */
-	old_index = exynos_cpufreq_get_index(old_freq);
-	if (old_index < 0) {
-		ret = old_index;
-		goto out;
-	}
-
-	index = exynos_cpufreq_get_index(target_freq);
-	if (index < 0) {
-		ret = index;
-		goto out;
-	}
-
-	/*
-	 * ARM clock source will be changed APLL to MPLL temporary
-	 * To support this level, need to control regulator for
-	 * required voltage level
-	 */
-	if (exynos_info->need_apll_change != NULL) {
-		if (exynos_info->need_apll_change(old_index, index) &&
-		   (freq_table[index].frequency < mpll_freq_khz) &&
-		   (freq_table[old_index].frequency < mpll_freq_khz))
-			safe_arm_volt = volt_table[exynos_info->pll_safe_idx];
-	}
-	arm_volt = volt_table[index];
-
-	/* When the new frequency is higher than current frequency */
-	if ((target_freq > old_freq) && !safe_arm_volt) {
-		/* Firstly, voltage up to increase frequency */
-		ret = regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
-		if (ret) {
-			dev_err(dev, "failed to set cpu voltage to %d\n",
-				arm_volt);
-			return ret;
-		}
-	}
-
-	if (safe_arm_volt) {
-		ret = regulator_set_voltage(arm_regulator, safe_arm_volt,
-				      safe_arm_volt);
-		if (ret) {
-			dev_err(dev, "failed to set cpu voltage to %d\n",
-				safe_arm_volt);
-			return ret;
-		}
-	}
-
-	exynos_info->set_freq(old_index, index);
-
-	/* When the new frequency is lower than current frequency */
-	if ((target_freq < old_freq) ||
-	   ((target_freq > old_freq) && safe_arm_volt)) {
-		/* down the voltage after frequency change */
-		ret = regulator_set_voltage(arm_regulator, arm_volt,
-				arm_volt);
-		if (ret) {
-			dev_err(dev, "failed to set cpu voltage to %d\n",
-				arm_volt);
-			goto out;
-		}
-	}
-
-out:
-	cpufreq_cpu_put(policy);
-
-	return ret;
-}
-
-static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
-{
-	return exynos_cpufreq_scale(exynos_info->freq_table[index].frequency);
-}
-
-static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
-{
-	policy->clk = exynos_info->cpu_clk;
-	policy->suspend_freq = locking_frequency;
-	return cpufreq_generic_init(policy, exynos_info->freq_table, 100000);
-}
-
-static struct cpufreq_driver exynos_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= exynos_target,
-	.get		= cpufreq_generic_get,
-	.init		= exynos_cpufreq_cpu_init,
-	.name		= "exynos_cpufreq",
-	.attr		= cpufreq_generic_attr,
-#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
-	.boost_supported = true,
-#endif
-#ifdef CONFIG_PM
-	.suspend	= cpufreq_generic_suspend,
-#endif
-};
-
-static int exynos_cpufreq_probe(struct platform_device *pdev)
-{
-	struct device_node *cpu0;
-	int ret = -EINVAL;
-
-	exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
-	if (!exynos_info)
-		return -ENOMEM;
-
-	exynos_info->dev = &pdev->dev;
-
-	if (of_machine_is_compatible("samsung,exynos4212")) {
-		exynos_info->type = EXYNOS_SOC_4212;
-		ret = exynos4x12_cpufreq_init(exynos_info);
-	} else if (of_machine_is_compatible("samsung,exynos4412")) {
-		exynos_info->type = EXYNOS_SOC_4412;
-		ret = exynos4x12_cpufreq_init(exynos_info);
-	} else {
-		pr_err("%s: Unknown SoC type\n", __func__);
-		ret = -ENODEV;
-	}
-
-	if (ret)
-		goto err_vdd_arm;
-
-	if (exynos_info->set_freq == NULL) {
-		dev_err(&pdev->dev, "No set_freq function (ERR)\n");
-		ret = -EINVAL;
-		goto err_vdd_arm;
-	}
-
-	arm_regulator = regulator_get(NULL, "vdd_arm");
-	if (IS_ERR(arm_regulator)) {
-		dev_err(&pdev->dev, "failed to get resource vdd_arm\n");
-		ret = -EINVAL;
-		goto err_vdd_arm;
-	}
-
-	/* Done here as we want to capture boot frequency */
-	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
-
-	ret = cpufreq_register_driver(&exynos_driver);
-	if (ret)
-		goto err_cpufreq_reg;
-
-	cpu0 = of_get_cpu_node(0, NULL);
-	if (!cpu0) {
-		pr_err("failed to find cpu0 node\n");
-		return 0;
-	}
-
-	if (of_find_property(cpu0, "#cooling-cells", NULL)) {
-		cdev = of_cpufreq_cooling_register(cpu0,
-						   cpu_present_mask);
-		if (IS_ERR(cdev))
-			pr_err("running cpufreq without cooling device: %ld\n",
-			       PTR_ERR(cdev));
-	}
-
-	return 0;
-
-err_cpufreq_reg:
-	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
-	regulator_put(arm_regulator);
-err_vdd_arm:
-	kfree(exynos_info);
-	return ret;
-}
-
-static struct platform_driver exynos_cpufreq_platdrv = {
-	.driver = {
-		.name	= "exynos-cpufreq",
-	},
-	.probe = exynos_cpufreq_probe,
-};
-module_platform_driver(exynos_cpufreq_platdrv);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
deleted file mode 100644
index a359db7..0000000
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS - CPUFreq support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-enum cpufreq_level_index {
-	L0, L1, L2, L3, L4,
-	L5, L6, L7, L8, L9,
-	L10, L11, L12, L13, L14,
-	L15, L16, L17, L18, L19,
-	L20,
-};
-
-enum exynos_soc_type {
-	EXYNOS_SOC_4212,
-	EXYNOS_SOC_4412,
-};
-
-#define APLL_FREQ(f, a0, a1, a2, a3, a4, a5, a6, a7, b0, b1, b2, m, p, s) \
-	{ \
-		.freq = (f) * 1000, \
-		.clk_div_cpu0 = ((a0) | (a1) << 4 | (a2) << 8 | (a3) << 12 | \
-			(a4) << 16 | (a5) << 20 | (a6) << 24 | (a7) << 28), \
-		.clk_div_cpu1 = (b0 << 0 | b1 << 4 | b2 << 8), \
-		.mps = ((m) << 16 | (p) << 8 | (s)), \
-	}
-
-struct apll_freq {
-	unsigned int freq;
-	u32 clk_div_cpu0;
-	u32 clk_div_cpu1;
-	u32 mps;
-};
-
-struct exynos_dvfs_info {
-	enum exynos_soc_type type;
-	struct device	*dev;
-	unsigned long	mpll_freq_khz;
-	unsigned int	pll_safe_idx;
-	struct clk	*cpu_clk;
-	unsigned int	*volt_table;
-	struct cpufreq_frequency_table	*freq_table;
-	void (*set_freq)(unsigned int, unsigned int);
-	bool (*need_apll_change)(unsigned int, unsigned int);
-	void __iomem	*cmu_regs;
-};
-
-#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
-extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
-#else
-static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
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
1.9.1
