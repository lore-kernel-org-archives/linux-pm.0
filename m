From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 3/4] clk: shmobile: Add Renesas Module Standby and Software Reset driver
Date: Tue, 22 Sep 2015 17:44:05 +0200
Message-ID: <1442936646-30362-4-git-send-email-geert+renesas@glider.be>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a driver for the Renesas Module Standby and Software Reset module
found in several Renesas SoCs.

This driver is based on the existing R-Car MSTP driver, and is intended
to replace it.
The existing driver is limited to Module Standby, and has bindings that
are difficult to extend to more register sets for e.g. reset control.

For now this supports R-Car M2 (r8a7791) only.

TODO:
  - Extend to other SoCs, notably R-Car H3 (r8a7795),
  - Implement module reset handling,
  - Write binding documentation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-mssr.c | 365 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/shmobile.h    |   2 +
 2 files changed, 367 insertions(+)
 create mode 100644 drivers/clk/shmobile/clk-mssr.c

diff --git a/drivers/clk/shmobile/clk-mssr.c b/drivers/clk/shmobile/clk-mssr.c
new file mode 100644
index 0000000000000000..d38a80f8548d8335
--- /dev/null
+++ b/drivers/clk/shmobile/clk-mssr.c
@@ -0,0 +1,365 @@
+/*
+ * Renesas Module Standby and Software Reset
+ *
+ * Based on clk-mstp.c
+ *
+ * Copyright (C) 2013 Ideas On Board SPRL
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/shmobile.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+
+/*
+ * MSTP clocks. We can't use standard gate clocks as we need to poll on the
+ * status register when enabling the clock.
+ */
+
+/*
+ * Module Standby and Software Reset register offets.
+ *
+ * If the registers exist, these are valid for SH-Mobile, R-Mobile,
+ * R-Car Gen 2, R-Car Gen 3.
+ * These are NOT valid for R-Car Gen1 and RZ/A1!
+ */
+
+/*
+ * Module stop status register offsets
+ */
+
+static const u16 mstpsr[] = {
+	0x030, 0x038, 0x040, 0x048, 0x04C, 0x03C, 0x1C0, 0x1C4,
+	0x9A0, 0x9A4, 0x9A8, 0x9AC,
+};
+
+#define	MSTPSR(i)	mstpsr[i]
+
+
+/*
+ * System module stop control register offsets
+ */
+
+static const u16 smstpcr[] = {
+	0x130, 0x134, 0x138, 0x13C, 0x140, 0x144, 0x148, 0x14C,
+	0x990, 0x994, 0x998, 0x99C,
+};
+
+#define	SMSTPCR(i)	smstpcr[i]
+
+
+/*
+ * Software reset register offsets
+ */
+
+static const u16 srcr[] = {
+	0x0A0, 0x0A8, 0x0B0, 0x0B8, 0x0BC, 0x0C4, 0x1C8, 0x1CC,
+	0x920, 0x924, 0x928, 0x92C,
+};
+
+#define	SRCR(i)		srcr[i]
+
+
+/* Realtime module stop control register offsets */
+#define RMSTPCR(i)	(smstpcr[i] - 0x20)
+
+/* Modem module stop control register offsets (r8a73a4) */
+#define MMSTPCR(i)	(smstpcr[i] + 0x20)
+
+/* Software reset clearing register offsets */
+#define	SRSTCLR(i)	(0x940 + (i) * 4)
+
+
+#define MSTP_MAX_CLOCKS		(ARRAY_SIZE(smstpcr) * 32)
+
+
+/**
+ * struct mssr_group - Module standby and software reset group
+ *
+ * @data: clocks in this group
+ * @base: CPG/MSSR register block base address
+ * @lock: protects writes to SMSTPCR
+ */
+struct mssr_group {
+	struct clk_onecell_data data;
+	void __iomem *base;
+	spinlock_t lock;
+	// TODO Add reset controller data
+};
+
+/**
+ * struct mstp_clock - MSTP gating clock
+ * @hw: handle between common and hardware-specific interfaces
+ * @index: MSTP clock number
+ * @group: MSTP clocks group
+ */
+struct mstp_clock {
+	struct clk_hw hw;
+	u32 index;
+	struct mssr_group *group;
+};
+
+#define to_mstp_clock(_hw) container_of(_hw, struct mstp_clock, hw)
+
+static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
+{
+	struct mstp_clock *clock = to_mstp_clock(hw);
+	struct mssr_group *group = clock->group;
+	unsigned int reg = clock->index / 32;
+	unsigned int bit = clock->index % 32;
+	u32 bitmask = BIT(bit);
+	unsigned long flags;
+	unsigned int i;
+	u32 value;
+
+	spin_lock_irqsave(&group->lock, flags);
+
+	value = clk_readl(group->base + SMSTPCR(reg));
+	if (enable)
+		value &= ~bitmask;
+	else
+		value |= bitmask;
+	clk_writel(value, group->base + SMSTPCR(reg));
+
+	spin_unlock_irqrestore(&group->lock, flags);
+
+	if (!enable)
+		return 0;
+
+	for (i = 1000; i > 0; --i) {
+		if (!(clk_readl(group->base + MSTPSR(reg)) &
+		      bitmask))
+			break;
+		cpu_relax();
+	}
+
+	if (!i) {
+		pr_err("%s: failed to enable %p[%d]\n", __func__,
+		       group->base + SMSTPCR(reg), bit);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cpg_mstp_clock_enable(struct clk_hw *hw)
+{
+	return cpg_mstp_clock_endisable(hw, true);
+}
+
+static void cpg_mstp_clock_disable(struct clk_hw *hw)
+{
+	cpg_mstp_clock_endisable(hw, false);
+}
+
+static int cpg_mstp_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mstp_clock *clock = to_mstp_clock(hw);
+	struct mssr_group *group = clock->group;
+	u32 value;
+
+	value = clk_readl(group->base + MSTPSR(clock->index / 32));
+
+	return !(value & BIT(clock->index % 32));
+}
+
+static const struct clk_ops cpg_mstp_clock_ops = {
+	.enable = cpg_mstp_clock_enable,
+	.disable = cpg_mstp_clock_disable,
+	.is_enabled = cpg_mstp_clock_is_enabled,
+};
+
+static struct clk * __init
+cpg_mstp_clock_register(const char *name, const char *parent_name,
+			unsigned int index, struct mssr_group *group)
+{
+	struct clk_init_data init;
+	struct mstp_clock *clock;
+	struct clk *clk;
+
+	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &cpg_mstp_clock_ops;
+	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clock->index = index;
+	clock->group = group;
+	clock->hw.init = &init;
+
+	clk = clk_register(NULL, &clock->hw);
+
+	if (IS_ERR(clk))
+		kfree(clock);
+
+	return clk;
+}
+
+static void __init cpg_mssr_init(struct device_node *np)
+{
+	struct mssr_group *group;
+	struct clk **clks;
+	unsigned int i;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	clks = kmalloc_array(MSTP_MAX_CLOCKS, sizeof(*clks), GFP_KERNEL);
+	if (group == NULL || clks == NULL) {
+		kfree(group);
+		kfree(clks);
+		return;
+	}
+
+	spin_lock_init(&group->lock);
+	group->data.clks = clks;
+
+	group->base = of_iomap(np, 0);
+
+	if (group->base == NULL) {
+		pr_err("%s: failed to remap CPG/MSSR\n", __func__);
+		kfree(group);
+		kfree(clks);
+		return;
+	}
+
+	for (i = 0; i < MSTP_MAX_CLOCKS; ++i)
+		clks[i] = ERR_PTR(-ENOENT);
+
+	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
+		const char *parent_name;
+		const char *name;
+		u32 clkidx;
+		int ret;
+
+		/* Skip clocks with no name. */
+		ret = of_property_read_string_index(np, "clock-output-names",
+						    i, &name);
+		if (ret < 0 || strlen(name) == 0)
+			continue;
+
+		parent_name = of_clk_get_parent_name(np, i);
+		ret = of_property_read_u32_index(np, "clock-indices", i,
+						 &clkidx);
+		if (parent_name == NULL || ret < 0)
+			break;
+
+		if (clkidx >= MSTP_MAX_CLOCKS) {
+			pr_err("%s: invalid clock %s %s index %u)\n",
+			       __func__, np->name, name, clkidx);
+			continue;
+		}
+
+		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
+						       clkidx, group);
+		if (!IS_ERR(clks[clkidx])) {
+			group->data.clk_num = max(group->data.clk_num,
+						  clkidx + 1);
+		} else {
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clks[clkidx]));
+		}
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
+
+	// TODO Register reset controller
+}
+CLK_OF_DECLARE(cpg_mssr, "renesas,r8a7791-cpg-mssr", cpg_mssr_init);
+
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+static int cpg_mssr_attach_dev(struct generic_pm_domain *domain,
+			       struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args clkspec;
+	struct clk *clk;
+	int i = 0;
+	int error;
+
+	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
+					   &clkspec)) {
+		if (of_device_is_compatible(clkspec.np,
+					    "renesas,r8a7791-cpg-mssr"))
+			goto found;
+
+		of_node_put(clkspec.np);
+		i++;
+	}
+
+	return 0;
+
+found:
+	clk = of_clk_get_from_provider(&clkspec);
+	of_node_put(clkspec.np);
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	error = pm_clk_create(dev);
+	if (error) {
+		dev_err(dev, "pm_clk_create failed %d\n", error);
+		goto fail_put;
+	}
+
+	error = pm_clk_add_clk(dev, clk);
+	if (error) {
+		dev_err(dev, "pm_clk_add_clk %pC failed %d\n", clk, error);
+		goto fail_destroy;
+	}
+
+	return 0;
+
+fail_destroy:
+	pm_clk_destroy(dev);
+fail_put:
+	clk_put(clk);
+	return error;
+}
+
+static void cpg_mssr_detach_dev(struct generic_pm_domain *domain,
+				struct device *dev)
+{
+	if (!list_empty(&dev->power.subsys_data->clock_list))
+		pm_clk_destroy(dev);
+}
+
+void __init cpg_mssr_add_clk_domain(struct device_node *np)
+{
+	struct generic_pm_domain *pd;
+	u32 ncells;
+
+	if (of_property_read_u32(np, "#power-domain-cells", &ncells)) {
+		pr_warn("%s lacks #power-domain-cells\n", np->full_name);
+		return;
+	}
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return;
+
+	pd->name = np->name;
+
+	pd->flags = GENPD_FLAG_PM_CLK;
+	pm_genpd_init(pd, &simple_qos_governor, false);
+	pd->attach_dev = cpg_mssr_attach_dev;
+	pd->detach_dev = cpg_mssr_detach_dev;
+
+	of_genpd_add_provider_simple(np, pd);
+}
+#endif /* !CONFIG_PM_GENERIC_DOMAINS_OF */
diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
index 95357cdde185d518..2e1dccd424da0d89 100644
--- a/include/linux/clk/shmobile.h
+++ b/include/linux/clk/shmobile.h
@@ -27,8 +27,10 @@ void r8a7779_clocks_init(u32 mode);
 void cpg_mstp_add_clk_domain(struct device_node *np);
 int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev);
 void cpg_mstp_detach_dev(struct generic_pm_domain *domain, struct device *dev);
+void cpg_mssr_add_clk_domain(struct device_node *np);
 #else
 static inline void cpg_mstp_add_clk_domain(struct device_node *np) {}
+static inline void cpg_mssr_add_clk_domain(struct device_node *np) {}
 #endif
 
 #endif
-- 
1.9.1

