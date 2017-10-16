From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/5] clk: renesas: div6: Restore clock state during resume
Date: Mon, 16 Oct 2017 10:36:52 +0200
Message-ID: <1508143014-11795-4-git-send-email-geert+renesas@glider.be>
References: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36008 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdJPJIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 05:08:50 -0400
In-Reply-To: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car Gen3 systems, PSCI system suspend powers down the SoC, losing
clock configuration.  Register an (optional) notifier to restore the
DIV6 clock state during system resume.

As DIV6 clocks can be picky w.r.t. modifying multiple register fields at
once, restore is not implemented by blindly restoring the register
value, but by using the existing cpg_div6_clock_{en,dis}able() helpers.

Note that this does not yet support DIV6 clocks with multiple parents,
which do not exist on R-Car Gen3 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v3:
  - Drop RFC state,
  - Add Tested-by,

v2:
  - New.
---
 drivers/clk/renesas/clk-div6.c         | 38 ++++++++++++++++++++++++++++++++--
 drivers/clk/renesas/clk-div6.h         |  3 ++-
 drivers/clk/renesas/renesas-cpg-mssr.c |  3 ++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 3e0040c0ac87a14b..151336d2ba59e689 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -14,8 +14,10 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 
 #include "clk-div6.h"
@@ -32,6 +34,7 @@
  * @src_shift: Shift to access the register bits to select the parent clock
  * @src_width: Number of register bits to select the parent clock (may be 0)
  * @parents: Array to map from valid parent clocks indices to hardware indices
+ * @nb: Notifier block to save/restore clock state for system resume
  */
 struct div6_clock {
 	struct clk_hw hw;
@@ -40,6 +43,7 @@ struct div6_clock {
 	u32 src_shift;
 	u32 src_width;
 	u8 *parents;
+	struct notifier_block nb;
 };
 
 #define to_div6_clock(_hw) container_of(_hw, struct div6_clock, hw)
@@ -176,6 +180,29 @@ static const struct clk_ops cpg_div6_clock_ops = {
 	.set_rate = cpg_div6_clock_set_rate,
 };
 
+static int cpg_div6_clock_notifier_call(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct div6_clock *clock = container_of(nb, struct div6_clock, nb);
+
+	switch (action) {
+	case PM_EVENT_RESUME:
+		/*
+		 * TODO: This does not yet support DIV6 clocks with multiple
+		 * parents, as the parent selection bits are not restored.
+		 * Fortunately so far such DIV6 clocks are found only on
+		 * R/SH-Mobile SoCs, while the resume functionality is only
+		 * needed on R-Car Gen3.
+		 */
+		if (__clk_get_enable_count(clock->hw.clk))
+			cpg_div6_clock_enable(&clock->hw);
+		else
+			cpg_div6_clock_disable(&clock->hw);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
 
 /**
  * cpg_div6_register - Register a DIV6 clock
@@ -183,11 +210,13 @@ static const struct clk_ops cpg_div6_clock_ops = {
  * @num_parents: Number of parent clocks of the DIV6 clock (1, 4, or 8)
  * @parent_names: Array containing the names of the parent clocks
  * @reg: Mapped register used to control the DIV6 clock
+ * @notifiers: Optional notifier chain to save/restore state for system resume
  */
 struct clk * __init cpg_div6_register(const char *name,
 				      unsigned int num_parents,
 				      const char **parent_names,
-				      void __iomem *reg)
+				      void __iomem *reg,
+				      struct raw_notifier_head *notifiers)
 {
 	unsigned int valid_parents;
 	struct clk_init_data init;
@@ -258,6 +287,11 @@ struct clk * __init cpg_div6_register(const char *name,
 	if (IS_ERR(clk))
 		goto free_parents;
 
+	if (notifiers) {
+		clock->nb.notifier_call = cpg_div6_clock_notifier_call;
+		raw_notifier_chain_register(notifiers, &clock->nb);
+	}
+
 	return clk;
 
 free_parents:
@@ -301,7 +335,7 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	for (i = 0; i < num_parents; i++)
 		parent_names[i] = of_clk_get_parent_name(np, i);
 
-	clk = cpg_div6_register(clk_name, num_parents, parent_names, reg);
+	clk = cpg_div6_register(clk_name, num_parents, parent_names, reg, NULL);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register %s DIV6 clock (%ld)\n",
 		       __func__, np->name, PTR_ERR(clk));
diff --git a/drivers/clk/renesas/clk-div6.h b/drivers/clk/renesas/clk-div6.h
index 567b31d2bfa5269c..da4807299dda735b 100644
--- a/drivers/clk/renesas/clk-div6.h
+++ b/drivers/clk/renesas/clk-div6.h
@@ -2,6 +2,7 @@
 #define __RENESAS_CLK_DIV6_H__
 
 struct clk *cpg_div6_register(const char *name, unsigned int num_parents,
-			      const char **parent_names, void __iomem *reg);
+			      const char **parent_names, void __iomem *reg,
+			      struct raw_notifier_head *notifiers);
 
 #endif
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 485dce00a562d919..e3d03ffea4bc2fd6 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -303,7 +303,8 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 
 		if (core->type == CLK_TYPE_DIV6P1) {
 			clk = cpg_div6_register(core->name, 1, &parent_name,
-						priv->base + core->offset);
+						priv->base + core->offset,
+						&priv->notifiers);
 		} else {
 			clk = clk_register_fixed_factor(NULL, core->name,
 							parent_name, 0,
-- 
2.7.4
