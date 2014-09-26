From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 3/6] clk: imx: add CPU clock type
Date: Fri, 26 Sep 2014 15:41:01 +0200
Message-ID: <1411738864-26549-3-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39557 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbaIZNlM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:41:12 -0400
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

This implements a virtual clock used to abstract away
all the steps needed in order to change the ARM clock,
so we don't have to push all this clock handling into
the cpufreq driver.

While it will be used for i.MX53 at first it is generic
enough to be used on i.MX6 later on.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- split clk into multiple line
- fix my email address
---
 arch/arm/mach-imx/Makefile  |   2 +-
 arch/arm/mach-imx/clk-cpu.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h     |   4 ++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-cpu.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 23c02932bf84..0e708a9d607d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
 
 imx5-pm-$(CONFIG_PM) += pm-imx5.o
-obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o $(imx5-pm-y)
+obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o clk-cpu.o $(imx5-pm-y)
 
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 			    clk-pfd.o clk-busy.o clk.o \
diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
new file mode 100644
index 000000000000..aa1c345e2a19
--- /dev/null
+++ b/arch/arm/mach-imx/clk-cpu.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2014 Lucas Stach <l.stach@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+
+struct clk_cpu {
+	struct clk_hw	hw;
+	struct clk	*div;
+	struct clk	*mux;
+	struct clk	*pll;
+	struct clk	*step;
+};
+
+static inline struct clk_cpu *to_clk_cpu(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_cpu, hw);
+}
+
+static unsigned long clk_cpu_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_cpu *cpu = to_clk_cpu(hw);
+
+	return clk_get_rate(cpu->div);
+}
+
+static long clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct clk_cpu *cpu = to_clk_cpu(hw);
+
+	return clk_round_rate(cpu->pll, rate);
+}
+
+static int clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_cpu *cpu = to_clk_cpu(hw);
+	int ret;
+
+	/* switch to PLL bypass clock */
+	ret = clk_set_parent(cpu->mux, cpu->step);
+	if (ret)
+		return ret;
+
+	/* reprogram PLL */
+	ret = clk_set_rate(cpu->pll, rate);
+	if (ret) {
+		clk_set_parent(cpu->mux, cpu->pll);
+		return ret;
+	}
+	/* switch back to PLL clock */
+	clk_set_parent(cpu->mux, cpu->pll);
+
+	/* Ensure the divider is what we expect */
+	clk_set_rate(cpu->div, rate);
+
+	return 0;
+}
+
+static const struct clk_ops clk_cpu_ops = {
+	.recalc_rate	= clk_cpu_recalc_rate,
+	.round_rate	= clk_cpu_round_rate,
+	.set_rate	= clk_cpu_set_rate,
+};
+
+struct clk *imx_clk_cpu(const char *name, const char *parent_name,
+		struct clk *div, struct clk *mux, struct clk *pll,
+		struct clk *step)
+{
+	struct clk_cpu *cpu;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
+	if (!cpu)
+		return ERR_PTR(-ENOMEM);
+
+	cpu->div = div;
+	cpu->mux = mux;
+	cpu->pll = pll;
+	cpu->step = step;
+
+	init.name = name;
+	init.ops = &clk_cpu_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	cpu->hw.init = &init;
+
+	clk = clk_register(NULL, &cpu->hw);
+	if (IS_ERR(clk))
+		kfree(cpu);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index d5ba76fee115..5de8b53ec208 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -128,4 +128,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
+struct clk *imx_clk_cpu(const char *name, const char *parent_name,
+		struct clk *div, struct clk *mux, struct clk *pll,
+		struct clk *step);
+
 #endif
-- 
2.1.0

