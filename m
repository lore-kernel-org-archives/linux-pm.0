From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 03/13] soc: renesas: rcar-sysc: Make rcar_sysc_init() init the PM domains
Date: Tue, 28 Jun 2016 16:10:32 +0200
Message-ID: <1467123042-8468-4-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49242 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbcF1OKt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 10:10:49 -0400
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Let rcar_sysc_init() trigger initialization of the SYSC PM domains from
DT if called before the early_initcall.
On failure, it falls back to mapping the passed register block, as
before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 59a8152681a59a5c..68d6856c9d3cd192 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -164,15 +164,6 @@ static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 	return false;
 }
 
-void __iomem *rcar_sysc_init(phys_addr_t base)
-{
-	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
-	if (!rcar_sysc_base)
-		panic("unable to ioremap R-Car SYSC hardware block\n");
-
-	return rcar_sysc_base;
-}
-
 struct rcar_sysc_pd {
 	struct generic_pm_domain genpd;
 	struct rcar_sysc_ch ch;
@@ -328,6 +319,9 @@ static int __init rcar_sysc_pd_init(void)
 	unsigned int i;
 	int error;
 
+	if (rcar_sysc_base)
+		return 0;
+
 	np = of_find_matching_node_and_match(NULL, rcar_sysc_matches, &match);
 	if (!np)
 		return -ENODEV;
@@ -405,3 +399,11 @@ out_put:
 	return error;
 }
 early_initcall(rcar_sysc_pd_init);
+
+void __iomem * __init rcar_sysc_init(phys_addr_t base)
+{
+	if (rcar_sysc_pd_init())
+		rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+
+	return rcar_sysc_base;
+}
-- 
1.9.1

