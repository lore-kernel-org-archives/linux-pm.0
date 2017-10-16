From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 4/5] clk: renesas: rcar-gen3: Restore SDHI clocks during resume
Date: Mon, 16 Oct 2017 10:36:53 +0200
Message-ID: <1508143014-11795-5-git-send-email-geert+renesas@glider.be>
References: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36040 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdJPJIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 05:08:50 -0400
In-Reply-To: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car Gen3 systems, PSCI system suspend powers down the SoC, losing
clock configuration.  Register a notifier to save/restore SDHI clock
registers during system suspend/resume.

This is implemented using the cpg_simple_notifier abstraction, which can
be reused for others clocks that just need to save/restore a single
register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v3:
  - Drop RFC state,
  - Add Tested-by,
  - Rebased,

v2:
  - New.
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 63 +++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 139985257003bfad..267b5629e3bdb173 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -29,6 +30,36 @@
 #define CPG_PLL2CR		0x002c
 #define CPG_PLL4CR		0x01f4
 
+struct cpg_simple_notifier {
+	struct notifier_block nb;
+	void __iomem *reg;
+	u32 saved;
+};
+
+static int cpg_simple_notifier_call(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	struct cpg_simple_notifier *csn =
+		container_of(nb, struct cpg_simple_notifier, nb);
+
+	switch (action) {
+	case PM_EVENT_SUSPEND:
+		csn->saved = readl(csn->reg);
+		return NOTIFY_OK;
+
+	case PM_EVENT_RESUME:
+		writel(csn->saved, csn->reg);
+		return NOTIFY_OK;
+	}
+	return NOTIFY_DONE;
+}
+
+static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
+					 struct cpg_simple_notifier *csn)
+{
+	csn->nb.notifier_call = cpg_simple_notifier_call;
+	raw_notifier_chain_register(notifiers, &csn->nb);
+}
 
 /*
  * SDn Clock
@@ -55,8 +86,8 @@ struct sd_div_table {
 
 struct sd_clock {
 	struct clk_hw hw;
-	void __iomem *reg;
 	const struct sd_div_table *div_table;
+	struct cpg_simple_notifier csn;
 	unsigned int div_num;
 	unsigned int div_min;
 	unsigned int div_max;
@@ -97,12 +128,12 @@ static const struct sd_div_table cpg_sd_div_table[] = {
 static int cpg_sd_clock_enable(struct clk_hw *hw)
 {
 	struct sd_clock *clock = to_sd_clock(hw);
-	u32 val = readl(clock->reg);
+	u32 val = readl(clock->csn.reg);
 
 	val &= ~(CPG_SD_STP_MASK);
 	val |= clock->div_table[clock->cur_div_idx].val & CPG_SD_STP_MASK;
 
-	writel(val, clock->reg);
+	writel(val, clock->csn.reg);
 
 	return 0;
 }
@@ -111,14 +142,14 @@ static void cpg_sd_clock_disable(struct clk_hw *hw)
 {
 	struct sd_clock *clock = to_sd_clock(hw);
 
-	writel(readl(clock->reg) | CPG_SD_STP_MASK, clock->reg);
+	writel(readl(clock->csn.reg) | CPG_SD_STP_MASK, clock->csn.reg);
 }
 
 static int cpg_sd_clock_is_enabled(struct clk_hw *hw)
 {
 	struct sd_clock *clock = to_sd_clock(hw);
 
-	return !(readl(clock->reg) & CPG_SD_STP_MASK);
+	return !(readl(clock->csn.reg) & CPG_SD_STP_MASK);
 }
 
 static unsigned long cpg_sd_clock_recalc_rate(struct clk_hw *hw,
@@ -170,10 +201,10 @@ static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	clock->cur_div_idx = i;
 
-	val = readl(clock->reg);
+	val = readl(clock->csn.reg);
 	val &= ~(CPG_SD_STP_MASK | CPG_SD_FC_MASK);
 	val |= clock->div_table[i].val & (CPG_SD_STP_MASK | CPG_SD_FC_MASK);
-	writel(val, clock->reg);
+	writel(val, clock->csn.reg);
 
 	return 0;
 }
@@ -188,8 +219,8 @@ static const struct clk_ops cpg_sd_clock_ops = {
 };
 
 static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
-					       void __iomem *base,
-					       const char *parent_name)
+	void __iomem *base, const char *parent_name,
+	struct raw_notifier_head *notifiers)
 {
 	struct clk_init_data init;
 	struct sd_clock *clock;
@@ -207,12 +238,12 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	clock->reg = base + core->offset;
+	clock->csn.reg = base + core->offset;
 	clock->hw.init = &init;
 	clock->div_table = cpg_sd_div_table;
 	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
 
-	sd_fc = readl(clock->reg) & CPG_SD_FC_MASK;
+	sd_fc = readl(clock->csn.reg) & CPG_SD_FC_MASK;
 	for (i = 0; i < clock->div_num; i++)
 		if (sd_fc == (clock->div_table[i].val & CPG_SD_FC_MASK))
 			break;
@@ -233,8 +264,13 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 
 	clk = clk_register(NULL, &clock->hw);
 	if (IS_ERR(clk))
-		kfree(clock);
+		goto free_clock;
+
+	cpg_simple_notifier_register(notifiers, &clock->csn);
+	return clk;
 
+free_clock:
+	kfree(clock);
 	return clk;
 }
 
@@ -332,7 +368,8 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		break;
 
 	case CLK_TYPE_GEN3_SD:
-		return cpg_sd_clk_register(core, base, __clk_get_name(parent));
+		return cpg_sd_clk_register(core, base, __clk_get_name(parent),
+					   notifiers);
 
 	case CLK_TYPE_GEN3_R:
 		if (cpg_quirks & RCKCR_CKSEL) {
-- 
2.7.4
