From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 1/5] clk: renesas: cpg-mssr: Restore module clocks during resume
Date: Thu, 29 Jun 2017 15:25:16 +0200
Message-ID: <1498742720-2713-2-git-send-email-geert+renesas@glider.be>
References: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51268 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdF2NZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 09:25:24 -0400
In-Reply-To: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
clock register state is lost.  Note that as the boot loader skips most
initialization after system resume, clock register state differs from
the state encountered during normal system boot, too.

Hence after s2ram, some operations may fail because module clocks are
disabled, while drivers expect them to be still enabled.  E.g. EtherAVB
fails when Wake-on-LAN has been enabled using "ethtool -s eth0 wol g":

    ravb e6800000.ethernet eth0: failed to switch device to config mode
    ravb e6800000.ethernet eth0: device will be stopped after h/w processes are done.
    ravb e6800000.ethernet eth0: failed to switch device to config
    PM: Device e6800000.ethernet failed to resume: error -110

In addition, some module clocks that were disabled by
clk_disable_unused() may have been re-enabled, wasting power.

To fix this, restore all bits of the SMSTPCR registers that represent
clocks under control of Linux.

Note that while this fixes EtherAVB operation after resume from s2ram,
EtherAVB cannot be used as an actual wake-up source from s2ram, only
from s2idle, due to PSCI limitations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Tested-by, Reviewed-by,
  - Mark cpg_mssr_resume_noirq __maybe_unused to kill warning if PM=n,
  - Move shadow register updates inside the RMW spinlock to protect
    against concurrent updates of multiple MSTP clocks in the same bank,
    just like for the actual registers,
  - Add more comments,
  - Save registers in suspend_noirq instead of constantly updating
    shadow registers
  - Let smstpcr_saved[].mask represent all clocks under our control, not
    just the ones we ever changed.  As clk_disable_unused() doesn't
    touch clocks that are not enabled, such clocks were not marked for
    restore, and thus may stay enabled after resume (resume state is
    different from boot state, as the boot loader disables some clocks
    during normal boot),
  - Drop Tested-by, Reviewed-by, as the code has changed substantially.
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1f607c806f9b9ec3..d27738521dc9a8bb 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -106,6 +106,8 @@ static const u16 srcr[] = {
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @smstpcr_saved[].mask: Mask of SMSTPCR[] bits under our control
+ * @smstpcr_saved[].val: Saved values of SMSTPCR[]
  */
 struct cpg_mssr_priv {
 #ifdef CONFIG_RESET_CONTROLLER
@@ -119,6 +121,11 @@ struct cpg_mssr_priv {
 	unsigned int num_core_clks;
 	unsigned int num_mod_clks;
 	unsigned int last_dt_core_clk;
+
+	struct {
+		u32 mask;
+		u32 val;
+	} smstpcr_saved[ARRAY_SIZE(smstpcr)];
 };
 
 
@@ -382,6 +389,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
 	priv->clks[id] = clk;
+	priv->smstpcr_saved[clock->index / 32].mask |= BIT(clock->index % 32);
 	return;
 
 fail:
@@ -723,6 +731,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 	if (!clks)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, priv);
 	priv->clks = clks;
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
@@ -759,10 +768,70 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cpg_mssr_suspend_noirq(struct device *dev)
+{
+	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
+	unsigned int reg;
+
+	/* Save module registers with bits under our control */
+	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
+		if (priv->smstpcr_saved[reg].mask)
+			priv->smstpcr_saved[reg].val =
+				readl(priv->base + SMSTPCR(reg));
+	}
+	return 0;
+}
+
+static __maybe_unused int cpg_mssr_resume_noirq(struct device *dev)
+{
+	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
+	unsigned int reg, i;
+	u32 mask, oldval, newval;
+
+	/* Restore module clocks */
+	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
+		mask = priv->smstpcr_saved[reg].mask;
+		if (!mask)
+			continue;
+
+		oldval = readl(priv->base + SMSTPCR(reg));
+		newval = oldval & ~mask;
+		newval |= priv->smstpcr_saved[reg].val & mask;
+		if (newval == oldval)
+			continue;
+
+		writel(newval, priv->base + SMSTPCR(reg));
+
+		/* Wait until enabled clocks are really enabled */
+		mask &= ~priv->smstpcr_saved[reg].val;
+		if (!mask)
+			continue;
+
+		for (i = 1000; i > 0; --i) {
+			oldval = readl(priv->base + MSTPSR(reg));
+			if (!(oldval & mask))
+				break;
+			cpu_relax();
+		}
+
+		if (!i)
+			dev_warn(dev, "Failed to enable SMSTP %p[0x%x]\n",
+				 priv->base + SMSTPCR(reg), oldval & mask);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops cpg_mssr_pm = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cpg_mssr_suspend_noirq,
+				      cpg_mssr_resume_noirq)
+};
+
 static struct platform_driver cpg_mssr_driver = {
 	.driver		= {
 		.name	= "renesas-cpg-mssr",
 		.of_match_table = cpg_mssr_match,
+		.pm = &cpg_mssr_pm,
 	},
 };
 
-- 
2.7.4
