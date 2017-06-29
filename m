From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 5/5] clk: renesas: rcar-gen3: Restore R clock during resume
Date: Thu, 29 Jun 2017 15:25:20 +0200
Message-ID: <1498742720-2713-6-git-send-email-geert+renesas@glider.be>
References: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1498742720-2713-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On R-Car Gen3 systems, PSCI system suspend powers down the SoC, losing
clock configuration.  Register a notifier to save/restore the RCKCR
register during system suspend/resume.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/clk/renesas/clk-div6.c      |  6 +++---
 drivers/clk/renesas/rcar-gen3-cpg.c | 13 +++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 6bc9469e769d035c..151336d2ba59e689 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -180,8 +180,8 @@ static const struct clk_ops cpg_div6_clock_ops = {
 	.set_rate = cpg_div6_clock_set_rate,
 };
 
-static int cpg_div6_clock_resume(struct notifier_block *nb,
-				 unsigned long action, void *data)
+static int cpg_div6_clock_notifier_call(struct notifier_block *nb,
+					unsigned long action, void *data)
 {
 	struct div6_clock *clock = container_of(nb, struct div6_clock, nb);
 
@@ -288,7 +288,7 @@ struct clk * __init cpg_div6_register(const char *name,
 		goto free_parents;
 
 	if (notifiers) {
-		clock->nb.notifier_call = cpg_div6_clock_resume;
+		clock->nb.notifier_call = cpg_div6_clock_notifier_call;
 		raw_notifier_chain_register(notifiers, &clock->nb);
 	}
 
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 1abbf1d6d0a0c889..949116f4222226f5 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -378,18 +378,27 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN3_R:
 		if (cpg_quirks & RCKCR_CKSEL) {
+			struct cpg_simple_notifier *csn;
+
+			csn = kzalloc(sizeof(*csn), GFP_KERNEL);
+			if (!csn)
+				return ERR_PTR(-ENOMEM);
+
+			csn->reg = base + CPG_RCKCR;
+
 			/*
 			 * RINT is default.
 			 * Only if EXTALR is populated, we switch to it.
 			 */
-			value = readl(base + CPG_RCKCR) & 0x3f;
+			value = readl(csn->reg) & 0x3f;
 
 			if (clk_get_rate(clks[cpg_clk_extalr])) {
 				parent = clks[cpg_clk_extalr];
 				value |= BIT(15);
 			}
 
-			writel(value, base + CPG_RCKCR);
+			writel(value, csn->reg);
+			cpg_simple_notifier_register(notifiers, csn);
 			break;
 		}
 
-- 
2.7.4

