From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v11 1/6] clk: samsung: add infrastructure to register cpu clocks
Date: Mon, 20 Oct 2014 17:11:16 +0530
Message-ID: <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59087 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaJTL3s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 07:29:48 -0400
In-reply-to: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com

The CPU clock provider supplies the clock to the CPU clock domain. The
composition and organization of the CPU clock provider could vary among
Exynos SoCs. A CPU clock provider can be composed of clock mux, dividers
and gates. This patch defines a new clock type for CPU clock provider and
adds infrastructure to register the CPU clock providers for Samsung
platforms.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/clk/samsung/Makefile  |    2 +-
 drivers/clk/samsung/clk-cpu.c |  335 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-cpu.h |   91 +++++++++++
 3 files changed, 427 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 create mode 100644 drivers/clk/samsung/clk-cpu.h

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 6fb4bc6..8909c93 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -2,7 +2,7 @@
 # Samsung Clock specific Makefile
 #
 
-obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
+obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o clk-cpu.o
 obj-$(CONFIG_SOC_EXYNOS3250)	+= clk-exynos3250.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
new file mode 100644
index 0000000..009a21b
--- /dev/null
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -0,0 +1,335 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains the utility function to register CPU clock for Samsung
+ * Exynos platforms. A CPU clock is defined as a clock supplied to a CPU or a
+ * group of CPUs. The CPU clock is typically derived from a hierarchy of clock
+ * blocks which includes mux and divider blocks. There are a number of other
+ * auxiliary clocks supplied to the CPU domain such as the debug blocks and AXI
+ * clock for CPU domain. The rates of these auxiliary clocks are related to the
+ * CPU clock rate and this relation is usually specified in the hardware manual
+ * of the SoC or supplied after the SoC characterization.
+ *
+ * The below implementation of the CPU clock allows the rate changes of the CPU
+ * clock and the corresponding rate changes of the auxillary clocks of the CPU
+ * domain. The platform clock driver provides a clock register configuration
+ * for each configurable rate which is then used to program the clock hardware
+ * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * clocks.
+ *
+ * On a rate change request for the CPU clock, the rate change is propagated
+ * upto the PLL supplying the clock to the CPU domain clock blocks. While the
+ * CPU domain PLL is reconfigured, the CPU domain clocks are driven using an
+ * alternate clock source. If required, the alternate clock source is divided
+ * down in order to keep the output clock rate within the previous OPP limits.
+*/
+
+#include <linux/errno.h>
+#include "clk-cpu.h"
+
+#define E4210_SRC_CPU		0x0
+#define E4210_STAT_CPU		0x200
+#define E4210_DIV_CPU0		0x300
+#define E4210_DIV_CPU1		0x304
+#define E4210_DIV_STAT_CPU0	0x400
+#define E4210_DIV_STAT_CPU1	0x404
+
+#define E4210_DIV0_RATIO0_MASK	0x7
+#define E4210_DIV1_HPM_MASK	(0x7 << 4)
+#define E4210_DIV1_COPY_MASK	(0x7 << 0)
+#define E4210_MUX_HPM_MASK	(1 << 20)
+#define E4210_DIV0_ATB_SHIFT	16
+#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
+
+#define MAX_DIV			8
+#define DIV_MASK		7
+#define DIV_MASK_ALL		0xffffffff
+#define MUX_MASK		7
+
+/*
+ * Helper function to wait until divider(s) have stabilized after the divider
+ * value has changed.
+ */
+static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+
+	do {
+		if (!(readl(div_reg) & mask))
+			return;
+	} while (time_before(jiffies, timeout));
+
+	pr_err("%s: timeout in divider stablization\n", __func__);
+}
+
+/*
+ * Helper function to wait until mux has stabilized after the mux selection
+ * value was changed.
+ */
+static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
+					unsigned long mux_value)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+
+	do {
+		if (((readl(mux_reg) >> mux_pos) & MUX_MASK) == mux_value)
+			return;
+	} while (time_before(jiffies, timeout));
+
+	pr_err("%s: re-parenting mux timed-out\n", __func__);
+}
+
+/* common round rate callback useable for all types of CPU clocks */
+static long exynos_cpuclk_round_rate(struct clk_hw *hw,
+			unsigned long drate, unsigned long *prate)
+{
+	struct clk *parent = __clk_get_parent(hw->clk);
+	*prate = __clk_round_rate(parent, drate);
+	return *prate;
+}
+
+/* common recalc rate callback useable for all types of CPU clocks */
+static unsigned long exynos_cpuclk_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	/*
+	 * The CPU clock output (armclk) rate is the same as its parent
+	 * rate. Although there exist certain dividers inside the CPU
+	 * clock block that could be used to divide the parent clock,
+	 * the driver does not make use of them currently, except during
+	 * frequency transitions.
+	 */
+	return parent_rate;
+}
+
+static const struct clk_ops exynos_cpuclk_clk_ops = {
+	.recalc_rate = exynos_cpuclk_recalc_rate,
+	.round_rate = exynos_cpuclk_round_rate,
+};
+
+/*
+ * Helper function to set the 'safe' dividers for the CPU clock. The parameters
+ * div and mask contain the divider value and the register bit mask of the
+ * dividers to be programmed.
+ */
+static void exynos_set_safe_div(void __iomem *base, unsigned long div,
+					unsigned long mask)
+{
+	unsigned long div0;
+
+	div0 = readl(base + E4210_DIV_CPU0);
+	div0 = (div0 & ~mask) | (div & mask);
+	writel(div0, base + E4210_DIV_CPU0);
+	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, mask);
+}
+
+/* handler for pre-rate change notification from parent clock */
+static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
+	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
+	unsigned long div0, div1 = 0, mux_reg;
+
+	/* find out the divider values to use for clock data */
+	while ((cfg_data->prate * 1000) != ndata->new_rate) {
+		if (cfg_data->prate == 0)
+			return -EINVAL;
+		cfg_data++;
+	}
+
+	/*
+	 * For the selected PLL clock frequency, get the pre-defined divider
+	 * values. If the clock for sclk_hpm is not sourced from apll, then
+	 * the values for DIV_COPY and DIV_HPM dividers need not be set.
+	 */
+	div0 = cfg_data->div0;
+	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+		div1 = cfg_data->div1;
+		if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK)
+			div1 = readl(base + E4210_DIV_CPU1) &
+				(E4210_DIV1_HPM_MASK | E4210_DIV1_COPY_MASK);
+	}
+
+	spin_lock(cpuclk->lock);
+
+	/*
+	 * If the new and old parent clock speed is less than the clock speed
+	 * of the alternate parent, then it should be ensured that at no point
+	 * the armclk speed is more than the old_prate until the dividers are
+	 * set.
+	 */
+	if (alt_prate > ndata->old_rate) {
+		alt_div =  DIV_ROUND_UP(alt_prate, ndata->old_rate) - 1;
+		WARN_ON(alt_div >= MAX_DIV);
+
+		if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+			/*
+			 * In Exynos4210, ATB clock parent is also mout_core. So
+			 * ATB clock also needs to be mantained at safe speed.
+			 */
+			alt_div |= E4210_DIV0_ATB_MASK;
+			alt_div_mask |= E4210_DIV0_ATB_MASK;
+		}
+		exynos_set_safe_div(base, alt_div, alt_div_mask);
+		div0 |= alt_div;
+	}
+
+	/* select sclk_mpll as the alternate parent */
+	mux_reg = readl(base + E4210_SRC_CPU);
+	writel(mux_reg | (1 << 16), base + E4210_SRC_CPU);
+	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 2);
+
+	/* alternate parent is active now. set the dividers */
+	writel(div0, base + E4210_DIV_CPU0);
+	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, DIV_MASK_ALL);
+
+	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+		writel(div1, base + E4210_DIV_CPU1);
+		wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
+				DIV_MASK_ALL);
+	}
+
+	spin_unlock(cpuclk->lock);
+	return 0;
+}
+
+/* handler for post-rate change notification from parent clock */
+static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
+	unsigned long div = 0, div_mask = DIV_MASK;
+	unsigned long mux_reg;
+
+	spin_lock(cpuclk->lock);
+
+	/* select mout_apll as the alternate parent */
+	mux_reg = readl(base + E4210_SRC_CPU);
+	writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
+	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
+
+	if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+		/* find out the divider values to use for clock data */
+		while ((cfg_data->prate * 1000) != ndata->new_rate) {
+			if (cfg_data->prate == 0)
+				return -EINVAL;
+			cfg_data++;
+		}
+
+		div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
+		div_mask |= E4210_DIV0_ATB_MASK;
+	}
+
+	exynos_set_safe_div(base, div, div_mask);
+	spin_unlock(cpuclk->lock);
+	return 0;
+}
+
+/*
+ * This notifier function is called for the pre-rate and post-rate change
+ * notifications of the parent clock of cpuclk.
+ */
+static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct exynos_cpuclk *cpuclk;
+	void __iomem *base;
+	int err = 0;
+
+	cpuclk = container_of(nb, struct exynos_cpuclk, clk_nb);
+	base = cpuclk->ctrl_base;
+
+	if (event == PRE_RATE_CHANGE)
+		err = exynos_cpuclk_pre_rate_change(ndata, cpuclk, base);
+	else if (event == POST_RATE_CHANGE)
+		err = exynos_cpuclk_post_rate_change(ndata, cpuclk, base);
+
+	return notifier_from_errno(err);
+}
+
+/* helper function to register a CPU clock */
+int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
+		unsigned int lookup_id, const char *name, const char *parent,
+		const char *alt_parent, unsigned long offset,
+		const struct exynos_cpuclk_cfg_data *cfg,
+		unsigned long num_cfgs, unsigned long flags)
+{
+	struct exynos_cpuclk *cpuclk;
+	struct clk_init_data init;
+	struct clk *clk;
+	int ret = 0;
+
+	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
+	if (!cpuclk)
+		return -ENOMEM;
+
+	init.name = name;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+	init.ops = &exynos_cpuclk_clk_ops;
+
+	cpuclk->hw.init = &init;
+	cpuclk->ctrl_base = ctx->reg_base + offset;
+	cpuclk->lock = &ctx->lock;
+	cpuclk->flags = flags;
+	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
+
+	cpuclk->alt_parent = __clk_lookup(alt_parent);
+	if (!cpuclk->alt_parent) {
+		pr_err("%s: could not lookup alternate parent %s\n",
+				__func__, alt_parent);
+		ret = -EINVAL;
+		goto free_cpuclk;
+	}
+
+	clk = __clk_lookup(parent);
+	if (!clk) {
+		pr_err("%s: could not lookup parent clock %s\n",
+				__func__, parent);
+		ret = -EINVAL;
+		goto free_cpuclk;
+	}
+
+	ret = clk_notifier_register(clk, &cpuclk->clk_nb);
+	if (ret) {
+		pr_err("%s: failed to register clock notifier for %s\n",
+				__func__, name);
+		goto free_cpuclk;
+	}
+
+	cpuclk->cfg = kmemdup(cfg, sizeof(*cfg) * num_cfgs, GFP_KERNEL);
+	if (!cpuclk->cfg) {
+		pr_err("%s: could not allocate memory for cpuclk data\n",
+				__func__);
+		kfree(cpuclk);
+		ret = -ENOMEM;
+		goto unregister_clk_nb;
+	}
+
+	clk = clk_register(NULL, &cpuclk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register cpuclk %s\n", __func__,	name);
+		ret = PTR_ERR(clk);
+		goto free_cpuclk_data;
+	}
+
+	samsung_clk_add_lookup(ctx, clk, lookup_id);
+	return 0;
+
+free_cpuclk_data:
+	kfree(cpuclk->cfg);
+unregister_clk_nb:
+	clk_notifier_unregister(__clk_lookup(parent), &cpuclk->clk_nb);
+free_cpuclk:
+	kfree(cpuclk);
+	return ret;
+}
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
new file mode 100644
index 0000000..42e1905
--- /dev/null
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for all PLL's in Samsung platforms
+*/
+
+#ifndef __SAMSUNG_CLK_CPU_H
+#define __SAMSUNG_CLK_CPU_H
+
+#include "clk.h"
+
+#define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
+		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
+#define E4210_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | ((copy) << 0))
+
+#define E5250_CPU_DIV0(apll, pclk_dbg, atb, periph, acp, cpud)		\
+		((((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		 ((periph) << 12) | ((acp) << 8) | ((cpud) << 4)))
+#define E5250_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | (copy))
+
+#define E5420_EGL_DIV0(apll, pclk_dbg, atb, cpud)			\
+		((((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		 ((cpud) << 4)))
+#define E5420_KFC_DIV(kpll, pclk, aclk)					\
+		((((kpll) << 24) | ((pclk) << 20) | ((aclk) << 4)))
+
+/**
+ * struct exynos_cpuclk_data: config data to setup cpu clocks.
+ * @prate: frequency of the primary parent clock (in KHz).
+ * @div0: value to be programmed in the div_cpu0 register.
+ * @div1: value to be programmed in the div_cpu1 register.
+ *
+ * This structure holds the divider configuration data for dividers in the CPU
+ * clock domain. The parent frequency at which these divider values are valid is
+ * specified in @prate. The @prate is the frequency of the primary parent clock.
+ * For CPU clock domains that do not have a DIV1 register, the @div1 member
+ * value is not used.
+ */
+struct exynos_cpuclk_cfg_data {
+	unsigned long	prate;
+	unsigned long	div0;
+	unsigned long	div1;
+};
+
+/**
+ * struct exynos_cpuclk: information about clock supplied to a CPU core.
+ * @hw:	handle between CCF and CPU clock.
+ * @alt_parent: alternate parent clock to use when switching the speed
+ *	of the primary parent clock.
+ * @ctrl_base:	base address of the clock controller.
+ * @lock: cpu clock domain register access lock.
+ * @cfg: cpu clock rate configuration data.
+ * @num_cfgs: number of array elements in @cfg array.
+ * @clk_nb: clock notifier registered for changes in clock speed of the
+ *	primary parent clock.
+ * @flags: configuration flags for the CPU clock.
+ *
+ * This structure holds information required for programming the CPU clock for
+ * various clock speeds.
+ */
+struct exynos_cpuclk {
+	struct clk_hw				hw;
+	struct clk				*alt_parent;
+	void __iomem				*ctrl_base;
+	spinlock_t				*lock;
+	const struct exynos_cpuclk_cfg_data	*cfg;
+	const unsigned long			num_cfgs;
+	struct notifier_block			clk_nb;
+	unsigned long				flags;
+
+/* The CPU clock registers has DIV1 configuration register */
+#define CLK_CPU_HAS_DIV1		(1 << 0)
+/* When ALT parent is active, debug clocks need safe divider values */
+#define CLK_CPU_NEEDS_DEBUG_ALT_DIV	(1 << 1)
+};
+
+extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
+			unsigned int lookup_id, const char *name,
+			const char *parent, const char *alt_parent,
+			unsigned long offset,
+			const struct exynos_cpuclk_cfg_data *cfg,
+			unsigned long num_cfgs, unsigned long flags);
+
+#endif /* __SAMSUNG_CLK_CPU_H */
-- 
1.6.6.rc2

