From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 5/5] clk: renesas: rcar-gen3: Restore R clock during resume
Date: Mon, 16 Oct 2017 10:36:54 +0200
Message-ID: <1508143014-11795-6-git-send-email-geert+renesas@glider.be>
References: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508143014-11795-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On R-Car Gen3 systems, PSCI system suspend powers down the SoC, losing
clock configuration.  Register a notifier to save/restore the RCKCR
register during system suspend/resume.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v3:
  - Drop RFC state,
  - Add Tested-by,

v2:
  - New.
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 267b5629e3bdb173..0904886f55015a3b 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -373,18 +373,27 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
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
