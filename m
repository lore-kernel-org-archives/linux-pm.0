From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v7 1/6] clk: samsung: add infrastructure to register cpu clocks
Date: Mon, 14 Jul 2014 19:08:33 +0530
Message-ID: <1405345118-4269-2-git-send-email-thomas.ab@samsung.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch defines a new clock type for CPU clock provider and adds
infrastructure to register the CPU clock providers for Samsung platforms.
The CPU clock provider supplies the clock to the CPU clock domain. The
composition and organization of the CPU clock provider could vary among
Exynos SoCs and so this new clock type provides a way to encapsulate these
blocks into CPU clock type.

Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Tested-by: Arjun K.V <arjun.kv@samsung.com>
---
 drivers/clk/samsung/Makefile  |    2 +-
 drivers/clk/samsung/clk-cpu.c |  576 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h     |    5 +
 3 files changed, 582 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 69e8177..f4edd31 100644
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
index 0000000..0d62968
--- /dev/null
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -0,0 +1,576 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains the utility functions to register the CPU clocks
+ * for Samsung platforms.
+*/
+
+#include <linux/errno.h>
+#include "clk.h"
+
+#define E4210_SRC_CPU		0x0
+#define E4210_STAT_CPU		0x200
+#define E4210_DIV_CPU0		0x300
+#define E4210_DIV_CPU1		0x304
+#define E4210_DIV_STAT_CPU0	0x400
+#define E4210_DIV_STAT_CPU1	0x404
+
+#define MAX_DIV			8
+#define DIV_MASK		7
+#define DIV_MASK_ALL		0xffffffff
+#define MUX_MASK		7
+
+#define E4210_DIV0_RATIO0_MASK	0x7
+#define E4210_DIV1_HPM_MASK	((0x7 << 4) | (0x7 << 0))
+#define E4210_MUX_HPM_MASK	(1 << 20)
+#define E4210_DIV0_ATB_SHIFT	16
+#define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
+
+#define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
+		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
+#define E4210_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | ((copy) << 0))
+
+#define E5250_CPU_DIV0(apll, pclk_dbg, atb, periph, acp, cpud)		\
+		(((apll << 24) | (pclk_dbg << 20) | (atb << 16) |	\
+		 (periph << 12) | (acp << 8) | (cpud << 4)))
+#define E5250_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | (copy))
+
+#define E5420_EGL_DIV0(apll, pclk_dbg, atb, cpud)			\
+		(((apll << 24) | (pclk_dbg << 20) | (atb << 16) |	\
+		 (cpud << 4)))
+#define E5420_KFC_DIV(kpll, pclk, aclk)					\
+		(((kpll << 24) | (pclk << 20) | (aclk << 4)))
+
+enum cpuclk_type {
+	EXYNOS4210,
+	EXYNOS5250,
+	EXYNOS5420,
+};
+
+/**
+ * struct exynos4210_cpuclk_data: config data to setup cpu clocks.
+ * @prate: frequency of the primary parent clock (in KHz).
+ * @div0: value to be programmed in the div_cpu0 register.
+ * @div1: value to be programmed in the div_cpu1 register.
+ *
+ * This structure holds the divider configuration data for dividers in the CPU
+ * clock domain. The parent frequency at which these divider values are valid is
+ * specified in @prate. The @prate is the frequency of the primary parent clock.
+ * For CPU clock domains that do not have a DIV1 register, the @div1 member
+ * is optional.
+ */
+struct exynos4210_cpuclk_data {
+	unsigned long	prate;
+	unsigned int	div0;
+	unsigned int	div1;
+};
+
+/**
+ * struct exynos_cpuclk: information about clock supplied to a CPU core.
+ * @hw:	handle between CCF and CPU clock.
+ * @alt_parent: alternate parent clock to use when switching the speed
+ *	of the primary parent clock.
+ * @ctrl_base:	base address of the clock controller.
+ * @offset: offset from the ctrl_base address where the CPU clock div/mux
+ *	registers can be accessed.
+ * @lock: cpu clock domain register access lock.
+ * @type: type of the CPU clock.
+ * @data: optional data which the actual instantiation of this clock
+ *	can use.
+ * @clk_nb: clock notifier registered for changes in clock speed of the
+ *	primary parent clock.
+ * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
+ *	of the primary parent clock.
+ * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
+ *	of the primary parent clock.
+ *
+ * This structure holds information required for programming the cpu clock for
+ * various clock speeds.
+ */
+struct exynos_cpuclk {
+	struct clk_hw		hw;
+	struct clk		*alt_parent;
+	void __iomem		*ctrl_base;
+	unsigned long		offset;
+	spinlock_t		*lock;
+	enum cpuclk_type	type;
+	const void		*data;
+	struct notifier_block   clk_nb;
+	int			(*pre_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+	int			(*post_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+};
+
+#define to_exynos_cpuclk_hw(hw) container_of(hw, struct exynos_cpuclk, hw)
+#define to_exynos_cpuclk_nb(nb) container_of(nb, struct exynos_cpuclk, clk_nb)
+
+/**
+ * struct exynos_cpuclk_soc_data: soc specific data for cpu clocks.
+ * @ops: clock operations to be used for this clock.
+ * @offset: optional offset from base of clock controller register base, to
+ *	be used when accessing clock controller registers related to the
+ *	CPU clock.
+ * @data: SoC specific data for cpuclk configuration (optional).
+ * @data_size: size of the data contained in @data member.
+ * @type: type of the CPU clock.
+ * @pre_rate_cb: callback function to handle PRE_RATE_CHANGE notification
+ *	of the primary parent clock.
+ * @post_rate_cb: callback function to handle POST_RATE_CHANGE notification
+ *	of the primary parent clock.
+ *
+ * This structure provides SoC specific data for CPU clocks. Based on
+ * the compatible value of the clock controller node, the value of the
+ * fields in this structure can be populated.
+ */
+struct exynos_cpuclk_soc_data {
+	const struct clk_ops	*ops;
+	unsigned int		offset;
+	const void		*data;
+	const unsigned int	data_size;
+	enum cpuclk_type	type;
+	int			(*pre_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+	int			(*post_rate_cb)(struct clk_notifier_data *,
+					struct exynos_cpuclk *,
+					void __iomem *base);
+};
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
+	return parent_rate;
+}
+
+static const struct clk_ops exynos_cpuclk_clk_ops = {
+	.recalc_rate = exynos_cpuclk_recalc_rate,
+	.round_rate = exynos_cpuclk_round_rate,
+};
+
+/*
+ * Calculates the divider value to be set for deriving drate from prate.
+ * Divider value is actual divider value - 1.
+ */
+static unsigned long _calc_div(unsigned long prate, unsigned long drate)
+{
+	unsigned long div = DIV_ROUND_UP(prate, drate) - 1;
+
+	WARN_ON(div >= MAX_DIV);
+	return div;
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
+	struct exynos_cpuclk *cpuclk = to_exynos_cpuclk_nb(nb);
+	void __iomem *base =  cpuclk->ctrl_base + cpuclk->offset;
+	int err = 0;
+
+	if (event == PRE_RATE_CHANGE)
+		err = cpuclk->pre_rate_cb(ndata, cpuclk, base);
+	else if (event == POST_RATE_CHANGE)
+		err = cpuclk->post_rate_cb(ndata, cpuclk, base);
+
+	return notifier_from_errno(err);
+}
+
+/* helper function to register a cpu clock */
+static int __init exynos_cpuclk_register(struct samsung_clk_provider *ctx,
+		unsigned int lookup_id, const char *name, const char *parent,
+		const char *alt_parent, struct device_node *np,
+		const struct exynos_cpuclk_soc_data *soc_data)
+{
+	struct exynos_cpuclk *cpuclk;
+	struct clk_init_data init;
+	struct clk *clk;
+	void *data;
+	int ret = 0;
+
+	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
+	if (!cpuclk)
+		return -ENOMEM;
+
+	data = kmalloc(soc_data->data_size, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto free_cpuclk;
+	}
+
+	init.name = name;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+	init.ops = soc_data->ops;
+
+	cpuclk->hw.init = &init;
+	cpuclk->ctrl_base = ctx->reg_base;
+	cpuclk->lock = &ctx->lock;
+	cpuclk->offset = soc_data->offset;
+	cpuclk->type = soc_data->type;
+	cpuclk->pre_rate_cb = soc_data->pre_rate_cb;
+	cpuclk->post_rate_cb = soc_data->post_rate_cb;
+	memcpy(data, soc_data->data, soc_data->data_size);
+	cpuclk->data = data;
+
+	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
+	ret = clk_notifier_register(__clk_lookup(parent), &cpuclk->clk_nb);
+	if (ret) {
+		pr_err("%s: failed to register clock notifier for %s\n",
+				__func__, name);
+		goto free_cpuclk_data;
+	}
+
+	cpuclk->alt_parent = __clk_lookup(alt_parent);
+	if (!cpuclk->alt_parent) {
+		pr_err("%s: could not lookup alternate parent %s\n",
+				__func__, alt_parent);
+		ret = -EINVAL;
+		goto unregister_clk_nb;
+	}
+
+	clk = clk_register(NULL, &cpuclk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register cpuclk %s\n", __func__,	name);
+		ret = PTR_ERR(clk);
+		goto unregister_clk_nb;
+	}
+
+	samsung_clk_add_lookup(ctx, clk, lookup_id);
+	return 0;
+
+unregister_clk_nb:
+	clk_notifier_unregister(__clk_lookup(parent), &cpuclk->clk_nb);
+free_cpuclk_data:
+	kfree(cpuclk->data);
+free_cpuclk:
+	kfree(cpuclk);
+	return ret;
+}
+
+/*
+ * Helper function to set the 'safe' dividers for the CPU clock. The parameters
+ * div and mask contain the divider value and the register bit mask of the
+ * dividers to be programmed.
+ */
+static void exynos4210_set_safe_div(void __iomem *base, unsigned long div,
+					unsigned long mask)
+{
+	unsigned long div0;
+
+	div0 = readl(base + E4210_DIV_CPU0);
+	div0 = (div0 & ~mask) | div;
+	writel(div0, base + E4210_DIV_CPU0);
+	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, mask);
+}
+
+/* handler for pre-rate change notification from parent clock */
+static int exynos4210_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos4210_cpuclk_data *cpuclk_data = cpuclk->data;
+	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
+	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
+	unsigned long div0, div1 = 0, mux_reg;
+
+	/* find out the divider values to use for clock data */
+	while ((cpuclk_data->prate * 1000) != ndata->new_rate) {
+		if (cpuclk_data->prate == 0)
+			return -EINVAL;
+		cpuclk_data++;
+	}
+
+	/* For the selected PLL clock frequency, get the pre-defined divider
+	 * values. If the clock for sclk_hpm is not sourced from apll, then
+	 * the values for DIV_COPY and DIV_HPM dividers need not be set.
+	 */
+	div0 = cpuclk_data->div0;
+	if (cpuclk->type != EXYNOS5420) {
+		div1 = cpuclk_data->div1;
+		if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK) {
+			div1 = readl(base + E4210_DIV_CPU1) &
+					E4210_DIV1_HPM_MASK;
+			div1 |= ((cpuclk_data->div1) & ~E4210_DIV1_HPM_MASK);
+		}
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
+		alt_div = _calc_div(alt_prate, ndata->old_rate);
+		if (cpuclk->type == EXYNOS4210) {
+			/*
+			 * In Exynos4210, ATB clock parent is also mout_core. So
+			 * ATB clock also needs to be mantained at safe speed.
+			 */
+			alt_div |= E4210_DIV0_ATB_MASK;
+			alt_div_mask |= E4210_DIV0_ATB_MASK;
+		}
+		exynos4210_set_safe_div(base, alt_div, alt_div_mask);
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
+	if (cpuclk->type != EXYNOS5420) {
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
+static int exynos4210_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
+			struct exynos_cpuclk *cpuclk, void __iomem *base)
+{
+	const struct exynos4210_cpuclk_data *cpuclk_data = cpuclk->data;
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
+	if (cpuclk->type == EXYNOS4210) {
+		/* find out the divider values to use for clock data */
+		while ((cpuclk_data->prate * 1000) != ndata->new_rate) {
+			if (cpuclk_data->prate == 0)
+				return -EINVAL;
+			cpuclk_data++;
+		}
+
+		div |= (cpuclk_data->div0 & E4210_DIV0_ATB_MASK);
+		div_mask |= E4210_DIV0_ATB_MASK;
+	}
+
+	exynos4210_set_safe_div(base, div, div_mask);
+	spin_unlock(cpuclk->lock);
+	return 0;
+}
+
+static const struct exynos4210_cpuclk_data e4210_armclk_d[] __initconst = {
+	{ 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
+	{ 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
+	{  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
+	{  0 },
+};
+
+static const struct exynos4210_cpuclk_data e5250_armclk_d[] __initconst = {
+	{ 1700000, E5250_CPU_DIV0(5, 3, 7, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1600000, E5250_CPU_DIV0(4, 1, 7, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1500000, E5250_CPU_DIV0(4, 1, 7, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1400000, E5250_CPU_DIV0(4, 1, 6, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1300000, E5250_CPU_DIV0(3, 1, 6, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1200000, E5250_CPU_DIV0(3, 1, 5, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1100000, E5250_CPU_DIV0(3, 1, 5, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1000000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  900000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  800000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  700000, E5250_CPU_DIV0(1, 1, 3, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  600000, E5250_CPU_DIV0(1, 1, 3, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  500000, E5250_CPU_DIV0(1, 1, 2, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  400000, E5250_CPU_DIV0(1, 1, 2, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  300000, E5250_CPU_DIV0(1, 1, 1, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  200000, E5250_CPU_DIV0(1, 1, 1, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  0 },
+};
+
+static const struct exynos4210_cpuclk_data e5420_eglclk_d[] __initconst = {
+	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
+	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
+	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
+	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
+	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
+	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
+	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  0 },
+};
+
+static const struct exynos4210_cpuclk_data e5420_kfcclk_d[] __initconst = {
+	{ 1300000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1200000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1100000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1000000, E5420_KFC_DIV(3, 5, 2), },
+	{  900000, E5420_KFC_DIV(3, 5, 2), },
+	{  800000, E5420_KFC_DIV(3, 5, 2), },
+	{  700000, E5420_KFC_DIV(3, 4, 2), },
+	{  600000, E5420_KFC_DIV(3, 4, 2), },
+	{  500000, E5420_KFC_DIV(3, 4, 2), },
+	{  400000, E5420_KFC_DIV(3, 3, 2), },
+	{  300000, E5420_KFC_DIV(3, 3, 2), },
+	{  200000, E5420_KFC_DIV(3, 3, 2), },
+	{  0 },
+};
+
+static const struct exynos_cpuclk_soc_data e4210_clk_soc_data __initconst = {
+	.ops = &exynos_cpuclk_clk_ops,
+	.offset = 0x14200,
+	.data = e4210_armclk_d,
+	.data_size = sizeof(e4210_armclk_d),
+	.type = EXYNOS4210,
+	.pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
+	.post_rate_cb = exynos4210_cpuclk_post_rate_change,
+};
+
+static const struct exynos_cpuclk_soc_data e5250_clk_soc_data __initconst = {
+	.ops = &exynos_cpuclk_clk_ops,
+	.offset = 0x200,
+	.data = e5250_armclk_d,
+	.data_size = sizeof(e5250_armclk_d),
+	.type = EXYNOS5250,
+	.pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
+	.post_rate_cb = exynos4210_cpuclk_post_rate_change,
+};
+
+static const struct exynos_cpuclk_soc_data e5420_clk_soc_data[] __initconst = {
+	{
+		/* Cluster 0 (A15) CPU clock data */
+		.ops = &exynos_cpuclk_clk_ops,
+		.offset = 0x200,
+		.data = e5420_eglclk_d,
+		.data_size = sizeof(e5420_eglclk_d),
+		.type = EXYNOS5420,
+		.pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
+		.post_rate_cb = exynos4210_cpuclk_post_rate_change,
+	}, {
+		/* Cluster 1 (A7) CPU clock data */
+		.ops = &exynos_cpuclk_clk_ops,
+		.offset = 0x28200,
+		.data = e5420_kfcclk_d,
+		.data_size = sizeof(e5420_kfcclk_d),
+		.type = EXYNOS5420,
+		.pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
+		.post_rate_cb = exynos4210_cpuclk_post_rate_change,
+	},
+};
+
+static const struct of_device_id exynos_cpuclk_ids[] __initconst = {
+	{ .compatible = "samsung,exynos4210-clock",
+			.data = &e4210_clk_soc_data, },
+	{ .compatible = "samsung,exynos5250-clock",
+			.data = &e5250_clk_soc_data, },
+	{ .compatible = "samsung,exynos5420-clock",
+			.data = &e5420_clk_soc_data, },
+	{ },
+};
+
+/**
+ * exynos_register_cpu_clock: register cpu clock with ccf.
+ * @ctx: driver context.
+ * @cluster_id: cpu cluster number to which this clock is connected.
+ * @lookup_id: cpuclk clock output id for the clock controller.
+ * @name: the name of the cpu clock.
+ * @parent: name of the parent clock for cpuclk.
+ * @alt_parent: name of the alternate clock parent.
+ * @np: device tree node pointer of the clock controller.
+ */
+int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
+		unsigned int cluster_id, unsigned int lookup_id,
+		const char *name, const char *parent,
+		const char *alt_parent, struct device_node *np)
+{
+	const struct of_device_id *match;
+	const struct exynos_cpuclk_soc_data *data = NULL;
+
+	if (!np)
+		return -EINVAL;
+
+	match = of_match_node(exynos_cpuclk_ids, np);
+	if (!match)
+		return -EINVAL;
+
+	data = match->data;
+	data += cluster_id;
+	return exynos_cpuclk_register(ctx, lookup_id, name, parent,
+			alt_parent, np, data);
+}
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 92131f9..0e05ee9 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -374,4 +374,9 @@ extern struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
 			const unsigned long *rdump,
 			unsigned long nr_rdump);
 
+extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
+			unsigned int cluster_id, unsigned int lookup_id,
+			const char *name, const char *parent,
+			const char *alt_parent, struct device_node *np);
+
 #endif /* __SAMSUNG_CLK_H */
-- 
1.7.9.5
