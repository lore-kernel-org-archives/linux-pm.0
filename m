From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/5] clk: renesas: cpg-mssr: Restore module clocks during resume
Date: Mon, 16 Oct 2017 10:36:50 +0200
Message-ID: <1508143014-11795-2-git-send-email-geert+renesas@glider.be>
References: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36034 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdJPJIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 05:08:50 -0400
In-Reply-To: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

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

Notes:
  - While this fixes EtherAVB operation after resume from s2ram,
    EtherAVB cannot be used as an actual wake-up source from s2ram, only
    from s2idle, due to PSCI limitations,
  - To avoid overhead on platforms not needing it, the suspend/resume
    code has a build time dependency on sleep and PSCI support, and a
    runtime dependency on PSCI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v3:
  - Drop RFC state,
  - Add Tested-by,
  - Add build and runtime dependencies on PM_SLEEP and PSCI,

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
 drivers/clk/renesas/renesas-cpg-mssr.c | 84 ++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1779b0cc7a2abe9d..15fc8679d3426f3e 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/psci.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 
@@ -106,6 +107,8 @@ static const u16 srcr[] = {
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @smstpcr_saved[].mask: Mask of SMSTPCR[] bits under our control
+ * @smstpcr_saved[].val: Saved values of SMSTPCR[]
  */
 struct cpg_mssr_priv {
 #ifdef CONFIG_RESET_CONTROLLER
@@ -119,6 +122,11 @@ struct cpg_mssr_priv {
 	unsigned int num_core_clks;
 	unsigned int num_mod_clks;
 	unsigned int last_dt_core_clk;
+
+	struct {
+		u32 mask;
+		u32 val;
+	} smstpcr_saved[ARRAY_SIZE(smstpcr)];
 };
 
 
@@ -382,6 +390,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
 	priv->clks[id] = clk;
+	priv->smstpcr_saved[clock->index / 32].mask |= BIT(clock->index % 32);
 	return;
 
 fail:
@@ -700,6 +709,79 @@ static void cpg_mssr_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
+static int cpg_mssr_suspend_noirq(struct device *dev)
+{
+	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
+	unsigned int reg;
+
+	/* This is the best we can do to check for the presence of PSCI */
+	if (!psci_ops.cpu_suspend)
+		return 0;
+
+	/* Save module registers with bits under our control */
+	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
+		if (priv->smstpcr_saved[reg].mask)
+			priv->smstpcr_saved[reg].val =
+				readl(priv->base + SMSTPCR(reg));
+	}
+
+	return 0;
+}
+
+static int cpg_mssr_resume_noirq(struct device *dev)
+{
+	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
+	unsigned int reg, i;
+	u32 mask, oldval, newval;
+
+	/* This is the best we can do to check for the presence of PSCI */
+	if (!psci_ops.cpu_suspend)
+		return 0;
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
+#define DEV_PM_OPS	&cpg_mssr_pm
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
+
 static int __init cpg_mssr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -735,6 +817,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 	if (!clks)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, priv);
 	priv->clks = clks;
 	priv->num_core_clks = info->num_total_core_clks;
 	priv->num_mod_clks = info->num_hw_mod_clks;
@@ -775,6 +858,7 @@ static struct platform_driver cpg_mssr_driver = {
 	.driver		= {
 		.name	= "renesas-cpg-mssr",
 		.of_match_table = cpg_mssr_match,
+		.pm = DEV_PM_OPS,
 	},
 };
 
-- 
2.7.4
