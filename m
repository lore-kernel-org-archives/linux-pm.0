From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for r8a7795 I/O devices
Date: Wed,  9 Mar 2016 20:18:41 +0100
Message-ID: <1457551127-21934-6-git-send-email-geert+renesas@glider.be>
References: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:43082 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859AbcCITSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 14:18:51 -0500
In-Reply-To: <1457551127-21934-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>

On R-Car H3, some power areas (e.g. A3VP) contain I/O devices, which are
also part of the CPG/MSSR Clock Domain.  Hook up the CPG/MSSR Clock
Domain attach/detach callbacks to enable power management using module
clocks.

This also allows to support the Clock Domain for devices in the
"always-on" power area.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
v3:
  - Hook up the CPG/MSSR Clock Domain attach/detach callbacks instead of
    using our own copies,

v2:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 28af0b704fc008d2..2d6fbeb481883be7 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -9,6 +9,7 @@
  * for more details.
  */
 
+#include <linux/clk/renesas.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mm.h>
@@ -251,6 +252,15 @@ static void __init rcar_sysc_pd_setup(struct device_node *np,
 		gov = &pm_domain_always_on_gov;
 	}
 
+#ifdef CONFIG_ARCH_R8A7795
+	if (!(pd->flags & (PD_CPU | PD_SCU))) {
+		/* Enable Clock Domain for I/O devices */
+		genpd->flags = GENPD_FLAG_PM_CLK;
+		genpd->attach_dev = cpg_mssr_attach_dev;
+		genpd->detach_dev = cpg_mssr_detach_dev;
+	}
+#endif
+
 	pm_genpd_init(genpd, gov, false);
 	genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
 	genpd->power_off = rcar_sysc_pd_power_off;
-- 
1.9.1

