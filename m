From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 02/11] soc: renesas: rcar-sysc: Improve rcar_sysc_power() debug info
Date: Wed, 13 Apr 2016 16:44:23 +0200
Message-ID: <1460558672-10290-3-git-send-email-geert+renesas@glider.be>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:43671 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121AbcDMOoe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 10:44:34 -0400
In-Reply-To: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Print requested power domain state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v5:
  - No changes,

v4:
  - No changes,

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

