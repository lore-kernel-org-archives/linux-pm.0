From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 2/5] clk: renesas: cpg-mssr: Add support to restore core clocks during resume
Date: Thu, 29 Jun 2017 15:25:17 +0200
Message-ID: <1498742720-2713-3-git-send-email-geert+renesas@glider.be>
References: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51266 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbdF2NZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 09:25:24 -0400
In-Reply-To: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car Gen3 systems, PSCI system suspend powers down the SoC, possibly
losing clock configuration.  Hence add a notifier chain that can be used
by core clocks to save/restore clock state during system suspend/resume.

The implementation of the actual clock state save/restore operations is
clock-specific, and to be registered with the notifier chain in the SoC
or family-specific cpg_mssr_info.cpg_clk_register() callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/clk/renesas/rcar-gen2-cpg.c    |  7 +++----
 drivers/clk/renesas/rcar-gen2-cpg.h    |  6 +++---
 drivers/clk/renesas/rcar-gen3-cpg.c    |  3 ++-
 drivers/clk/renesas/rcar-gen3-cpg.h    |  3 ++-
 drivers/clk/renesas/renesas-cpg-mssr.c | 12 +++++++++++-
 drivers/clk/renesas/renesas-cpg-mssr.h |  3 ++-
 6 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen2-cpg.c b/drivers/clk/renesas/rcar-gen2-cpg.c
index 123b1e622179308e..feb14579a71b3bf4 100644
--- a/drivers/clk/renesas/rcar-gen2-cpg.c
+++ b/drivers/clk/renesas/rcar-gen2-cpg.c
@@ -262,10 +262,9 @@ static unsigned int cpg_pll0_div __initdata;
 static u32 cpg_mode __initdata;
 
 struct clk * __init rcar_gen2_cpg_clk_register(struct device *dev,
-					       const struct cpg_core_clk *core,
-					       const struct cpg_mssr_info *info,
-					       struct clk **clks,
-					       void __iomem *base)
+	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
+	struct clk **clks, void __iomem *base,
+	struct raw_notifier_head *notifiers)
 {
 	const struct clk_div_table *table = NULL;
 	const struct clk *parent;
diff --git a/drivers/clk/renesas/rcar-gen2-cpg.h b/drivers/clk/renesas/rcar-gen2-cpg.h
index 9eba07ff8b11e20e..020a3baad0154231 100644
--- a/drivers/clk/renesas/rcar-gen2-cpg.h
+++ b/drivers/clk/renesas/rcar-gen2-cpg.h
@@ -34,9 +34,9 @@ struct rcar_gen2_cpg_pll_config {
 };
 
 struct clk *rcar_gen2_cpg_clk_register(struct device *dev,
-				       const struct cpg_core_clk *core,
-				       const struct cpg_mssr_info *info,
-				       struct clk **clks, void __iomem *base);
+	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
+	struct clk **clks, void __iomem *base,
+	struct raw_notifier_head *notifiers);
 int rcar_gen2_cpg_init(const struct rcar_gen2_cpg_pll_config *config,
 		       unsigned int pll0_div, u32 mode);
 
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 3dee900522b703bd..5367944c4ab8491d 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -272,7 +272,8 @@ static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
 
 struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
-	struct clk **clks, void __iomem *base)
+	struct clk **clks, void __iomem *base,
+	struct raw_notifier_head *notifiers)
 {
 	const struct clk *parent;
 	unsigned int mult = 1;
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 073be54b5d038ae3..f4ecadaf41f226b4 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -35,7 +35,8 @@ struct rcar_gen3_cpg_pll_config {
 
 struct clk *rcar_gen3_cpg_clk_register(struct device *dev,
 	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
-	struct clk **clks, void __iomem *base);
+	struct clk **clks, void __iomem *base,
+	struct raw_notifier_head *notifiers);
 int rcar_gen3_cpg_init(const struct rcar_gen3_cpg_pll_config *config,
 		       unsigned int clk_extalr, u32 mode);
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index d27738521dc9a8bb..ab12b2ec61a3c041 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -106,6 +106,7 @@ static const u16 srcr[] = {
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @notifiers: Notifier chain to save/restore clock state for system resume
  * @smstpcr_saved[].mask: Mask of SMSTPCR[] bits under our control
  * @smstpcr_saved[].val: Saved values of SMSTPCR[]
  */
@@ -122,6 +123,7 @@ struct cpg_mssr_priv {
 	unsigned int num_mod_clks;
 	unsigned int last_dt_core_clk;
 
+	struct raw_notifier_head notifiers;
 	struct {
 		u32 mask;
 		u32 val;
@@ -311,7 +313,8 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 	default:
 		if (info->cpg_clk_register)
 			clk = info->cpg_clk_register(dev, core, info,
-						     priv->clks, priv->base);
+						     priv->clks, priv->base,
+						     &priv->notifiers);
 		else
 			dev_err(dev, "%s has unsupported core clock type %u\n",
 				core->name, core->type);
@@ -736,6 +739,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
 	priv->last_dt_core_clk = info->last_dt_core_clk;
+	RAW_INIT_NOTIFIER_HEAD(&priv->notifiers);
 
 	for (i = 0; i < nclks; i++)
 		clks[i] = ERR_PTR(-ENOENT);
@@ -779,6 +783,9 @@ static int cpg_mssr_suspend_noirq(struct device *dev)
 			priv->smstpcr_saved[reg].val =
 				readl(priv->base + SMSTPCR(reg));
 	}
+
+	/* Save core clocks */
+	raw_notifier_call_chain(&priv->notifiers, PM_EVENT_SUSPEND, NULL);
 	return 0;
 }
 
@@ -788,6 +795,9 @@ static __maybe_unused int cpg_mssr_resume_noirq(struct device *dev)
 	unsigned int reg, i;
 	u32 mask, oldval, newval;
 
+	/* Restore core clocks */
+	raw_notifier_call_chain(&priv->notifiers, PM_EVENT_RESUME, NULL);
+
 	/* Restore module clocks */
 	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
 		mask = priv->smstpcr_saved[reg].mask;
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index 43d7c7f6832df0b2..c86dc91b0a0facde 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -127,7 +127,8 @@ struct cpg_mssr_info {
 	struct clk *(*cpg_clk_register)(struct device *dev,
 					const struct cpg_core_clk *core,
 					const struct cpg_mssr_info *info,
-					struct clk **clks, void __iomem *base);
+					struct clk **clks, void __iomem *base,
+					struct raw_notifier_head *notifiers);
 };
 
 extern const struct cpg_mssr_info r8a7743_cpg_mssr_info;
-- 
2.7.4
