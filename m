From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 02/11] soc: renesas: rcar-sysc: Improve rcar_sysc_power() debug info
Date: Wed,  9 Mar 2016 20:18:38 +0100
Message-ID: <1457551127-21934-3-git-send-email-geert+renesas@glider.be>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Print requested power domain state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index d59bcdf78f0b56ba..9ba5fd15c53bf9b9 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
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
