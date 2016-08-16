From: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 1/8] clk: rockchip: add new clock-type for the ddrclk
Date: Wed, 17 Aug 2016 06:36:22 +0800
Message-ID: <1471386989-9541-2-git-send-email-hl@rock-chips.com>
References: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1471386989-9541-1-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On new rockchip platform(rk3399 etc), there have dcf controller to
do ddr frequency scaling, and this controller will implement in
arm-trust-firmware. We add a special clock-type to handle that.

Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v6:
- none

Changes in v5:
- delete unuse mux_flag
- use div_flag to distinguish sip call and other operate

Changes in v4:
- use arm_smccc_smc() to set/read ddr rate

Changes in v3:
- use sip call to set/read ddr rate

Changes in v2:
- use GENMASK instead val_mask
- use divider_recalc_rate() instead DIV_ROUND_UP_ULL
- cleanup code

Changes in v1:
- none

 drivers/clk/rockchip/Makefile       |   1 +
 drivers/clk/rockchip/clk-ddr.c      | 150 ++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c          |   9 +++
 drivers/clk/rockchip/clk.h          |  33 ++++++++
 include/soc/rockchip/rockchip_sip.h |  27 +++++++
 5 files changed, 220 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-ddr.c
 create mode 100644 include/soc/rockchip/rockchip_sip.h

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index f47a2fa..b5f2c8e 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -8,6 +8,7 @@ obj-y	+= clk-pll.o
 obj-y	+= clk-cpu.o
 obj-y	+= clk-inverter.o
 obj-y	+= clk-mmc-phase.o
+obj-y	+= clk-ddr.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
 
 obj-y	+= clk-rk3036.o
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
new file mode 100644
index 0000000..7dbe8bff
--- /dev/null
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
+ * Author: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <soc/rockchip/rockchip_sip.h>
+
+#include "clk.h"
+
+struct rockchip_ddrclk {
+	struct clk_hw	hw;
+	void __iomem	*reg_base;
+	int		mux_offset;
+	int		mux_shift;
+	int		mux_width;
+	int		div_shift;
+	int		div_width;
+	int		ddr_flag;
+	spinlock_t	*lock;
+};
+
+#define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk, hw)
+
+static int rockchip_ddrclk_set_rate(struct clk_hw *hw, unsigned long drate,
+				    unsigned long prate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	unsigned long flags;
+	struct arm_smccc_res res;
+
+	spin_lock_irqsave(ddrclk->lock, flags);
+	if (ddrclk->ddr_flag == ROCKCHIP_DDRCLK_SIP) {
+		arm_smccc_smc(SIP_DRAM_FREQ, drate, 0, CONFIG_DRAM_SET_RATE,
+			      0, 0, 0, 0, &res);
+		return res.a0;
+	}
+	spin_unlock_irqrestore(ddrclk->lock, flags);
+
+	return 0;
+}
+
+static unsigned long
+rockchip_ddrclk_recalc_rate(struct clk_hw *hw,
+			    unsigned long parent_rate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	struct arm_smccc_res res;
+
+	if (ddrclk->ddr_flag == ROCKCHIP_DDRCLK_SIP) {
+		arm_smccc_smc(SIP_DRAM_FREQ, 0, 0, CONFIG_DRAM_GET_RATE,
+			      0, 0, 0, 0, &res);
+		return res.a0;
+	}
+
+	return 0;
+}
+
+static long clk_ddrclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	return rate;
+}
+
+static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	u32 val;
+
+	val = clk_readl(ddrclk->reg_base +
+			ddrclk->mux_offset) >> ddrclk->mux_shift;
+	val &= GENMASK(ddrclk->mux_width - 1, 0);
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static const struct clk_ops rockchip_ddrclk_ops = {
+	.recalc_rate = rockchip_ddrclk_recalc_rate,
+	.set_rate = rockchip_ddrclk_set_rate,
+	.round_rate = clk_ddrclk_round_rate,
+	.get_parent = rockchip_ddrclk_get_parent,
+};
+
+struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
+					 const char *const *parent_names,
+					 u8 num_parents, int mux_offset,
+					 int mux_shift, int mux_width,
+					 int div_shift, int div_width,
+					 int ddr_flag, void __iomem *reg_base,
+					 spinlock_t *lock)
+{
+	struct rockchip_ddrclk *ddrclk;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	ddrclk = kzalloc(sizeof(*ddrclk), GFP_KERNEL);
+	if (!ddrclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.ops = &rockchip_ddrclk_ops;
+
+	init.flags = flags;
+	init.flags |= CLK_SET_RATE_NO_REPARENT;
+	init.flags |= CLK_GET_RATE_NOCACHE;
+
+	ddrclk->reg_base = reg_base;
+	ddrclk->lock = lock;
+	ddrclk->hw.init = &init;
+	ddrclk->mux_offset = mux_offset;
+	ddrclk->mux_shift = mux_shift;
+	ddrclk->mux_width = mux_width;
+	ddrclk->div_shift = div_shift;
+	ddrclk->div_width = div_width;
+	ddrclk->ddr_flag = ddr_flag;
+
+	clk = clk_register(NULL, &ddrclk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register ddrclk %s\n", __func__,	name);
+		goto free_ddrclk;
+	}
+
+	return clk;
+
+free_ddrclk:
+	kfree(ddrclk);
+
+	return NULL;
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 1f1c74f..99baa5d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -484,6 +484,15 @@ void __init rockchip_clk_register_branches(
 				list->gate_offset, list->gate_shift,
 				list->gate_flags, flags, &ctx->lock);
 			break;
+		case branch_ddrc:
+			clk = rockchip_clk_register_ddrclk(
+				list->name, list->flags,
+				list->parent_names, list->num_parents,
+				list->muxdiv_offset, list->mux_shift,
+				list->mux_width, list->div_shift,
+				list->div_width, list->div_flags,
+				ctx->reg_base, &ctx->lock);
+			break;
 		}
 
 		/* none of the cases above matched */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 3747de5..62c67f2 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -112,6 +112,12 @@ struct clk;
 #define RK3399_PMU_CLKGATE_CON(x)	((x) * 0x4 + 0x100)
 #define RK3399_PMU_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
 
+/*
+ * for COMPOSITE_DDRCLK div_flag
+ * it means set use sip call to set ddr clock in bl31
+ */
+#define ROCKCHIP_DDRCLK_SIP		0x01
+
 enum rockchip_pll_type {
 	pll_rk3036,
 	pll_rk3066,
@@ -281,6 +287,14 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift);
 
+struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
+					 const char *const *parent_names,
+					 u8 num_parents, int mux_offset,
+					 int mux_shift, int mux_width,
+					 int div_shift, int div_width,
+					 int ddr_flags, void __iomem *reg_base,
+					 spinlock_t *lock);
+
 #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
 
 struct clk *rockchip_clk_register_inverter(const char *name,
@@ -299,6 +313,7 @@ enum rockchip_clk_branch_type {
 	branch_mmc,
 	branch_inverter,
 	branch_factor,
+	branch_ddrc,
 };
 
 struct rockchip_clk_branch {
@@ -488,6 +503,24 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
+#define COMPOSITE_DDRCLK(_id, cname, pnames, f, mo, ms, mw,	\
+			 ds, dw, df)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_ddrc,			\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset  = mo,                           \
+		.mux_shift      = ms,                           \
+		.mux_width      = mw,                           \
+		.div_shift      = ds,                           \
+		.div_width      = dw,                           \
+		.div_flags	= df,				\
+		.gate_offset    = -1,                           \
+	}
+
 #define MUX(_id, cname, pnames, f, o, s, w, mf)			\
 	{							\
 		.id		= _id,				\
diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
new file mode 100644
index 0000000..422ea36
--- /dev/null
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Author: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#ifndef __SOC_ROCKCHIP_SIP_H
+#define __SOC_ROCKCHIP_SIP_H
+
+#define SIP_DRAM_FREQ		0x82000008
+#define CONFIG_DRAM_INIT	0x00
+#define CONFIG_DRAM_SET_RATE	0x01
+#define CONFIG_DRAM_ROUND_RATE	0x02
+#define CONFIG_DRAM_SET_AT_SR	0x03
+#define CONFIG_DRAM_GET_BW	0x04
+#define CONFIG_DRAM_GET_RATE	0x05
+#define CONFIG_DRAM_CLR_IRQ	0x06
+#define CONFIG_DRAM_SET_PARAM	0x07
+
+#endif
-- 
2.6.6
