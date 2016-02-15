From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 03/11] soc: renesas: Improve rcar_sysc_power() debug info
Date: Mon, 15 Feb 2016 22:16:52 +0100
Message-ID: <1455571020-18968-4-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Print requested power domain state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/soc/renesas/pm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
index bc605d9fbc6ce79c..cc684e9cc8db5d1c 100644
--- a/drivers/soc/renesas/pm-rcar.c
+++ b/drivers/soc/renesas/pm-rcar.c
@@ -128,7 +128,7 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
  out:
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
 
-	pr_debug("sysc power domain %d: %08x -> %d\n",
+	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
 		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
 	return ret;
 }
-- 
1.9.1
