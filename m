From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 05/13] soc: renesas: rcar-sysc: Improve SYSC interrupt config in legacy wrapper
Date: Tue, 28 Jun 2016 16:10:34 +0200
Message-ID: <1467123042-8468-6-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49232 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbcF1OKt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 10:10:49 -0400
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Align SYSC interrupt configuration in the legacy wrapper with the DT
version:
  - Mask SYSC interrupt sources before enabling them (doesn't matter
    much as they're disabled at the GIC level anyway),
  - Make sure not to clear reserved SYSCIMR bits that were set before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v5:
  - Add Reviewed-by,

v4:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 22f0d646225c444e..65c8e1eb90c09bb3 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -402,12 +402,25 @@ early_initcall(rcar_sysc_pd_init);
 
 void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
 {
+	u32 syscimr;
+
 	if (!rcar_sysc_pd_init())
 		return;
 
 	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
 
-	/* enable all interrupt sources, but do not use interrupt handler */
+	/*
+	 * Mask all interrupt sources to prevent the CPU from receiving them.
+	 * Make sure not to clear reserved bits that were set before.
+	 */
+	syscimr = ioread32(rcar_sysc_base + SYSCIMR);
+	syscimr |= syscier;
+	pr_debug("%s: syscimr = 0x%08x\n", __func__, syscimr);
+	iowrite32(syscimr, rcar_sysc_base + SYSCIMR);
+
+	/*
+	 * SYSC needs all interrupt sources enabled to control power.
+	 */
+	pr_debug("%s: syscier = 0x%08x\n", __func__, syscier);
 	iowrite32(syscier, rcar_sysc_base + SYSCIER);
-	iowrite32(0, rcar_sysc_base + SYSCIMR);
 }
-- 
1.9.1

