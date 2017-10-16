From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/10] [RFC] ravb: Remove obsolete explicit clock handling for WoL
Date: Mon, 16 Oct 2017 15:55:15 +0200
Message-ID: <1508162116-5043-10-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Currently, if Wake-on-LAN is enabled, the EtherAVB device's module clock
is manually kept running during system suspend, to make sure the device
stays active.

Since "soc: renesas: rcar-sysc: Keep wakeup sources active during system
suspend", this workaround is no longer needed.  Hence remove all
explicit clock handling to keep the device active.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before the dependency has landed upstream,
hence the "RFC"!
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fdf30bfa403bf416..11ffccca11d56df5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2218,9 +2218,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	/* Increased clock usage so device won't be suspended */
-	clk_enable(priv->clk);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -2239,9 +2236,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 	if (ret < 0)
 		return ret;
 
-	/* Restore clock usage count */
-	clk_disable(priv->clk);
-
 	return disable_irq_wake(priv->emac_irq);
 }
 
@@ -2289,8 +2283,6 @@ static int __maybe_unused ravb_resume(struct device *dev)
 		 *       this clock dance should be removed.
 		 */
 		clk_disable(priv->clk);
-		clk_disable(priv->clk);
-		clk_enable(priv->clk);
 		clk_enable(priv->clk);
 
 		/* Set reset mode to rearm the WoL logic */
-- 
2.7.4
