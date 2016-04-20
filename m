From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for I/O devices
Date: Wed, 20 Apr 2016 14:02:40 +0200
Message-ID: <1461153766-750-6-git-send-email-geert+renesas@glider.be>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:56937 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbcDTMCo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 08:02:44 -0400
In-Reply-To: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car H3, some power areas (e.g. A3VP) contain I/O devices, which are
also part of the CPG/MSSR Clock Domain.
On all R-Car SoCs, devices in the "always-on" PM Domain are part of the
Clock Domain served by the CPG/MSSR or CPG/MSTP driver.

Hook up the CPG/MSTP or CPG/MSSR Clock Domain attach/detach callbacks to
enable power management using module clocks. Which callback to hook up
depends on the presence of device nodes compatible with
"renesas,cpg-mstp-clocks". This clears the path for a future migration
from the CPG/MSTP to the CPG/MSSR driver on R-Car H1 and
Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - Add Reviewed-by,
  - Rebased,

v5:
  - Revert v4 changes,
  - Use either the cpg_mssr_*() or cpg_mstp_*() callbacks,
  - Drop dependency on r8a7795, as this is used for the "always-on" PM
    Domain on R-Car H1 and Gen2, too,

v4:
  - Remove the explicit dependency on the CPG/MSSR driver by forwarding
    the attach/detach callbacks to the parent PM Domain.
    If deemed reusable, rcar_sysc_{at,de}tach_dev() can be moved to
    common genpd code later.

v3:
  - Hook up the CPG/MSSR Clock Domain attach/detach callbacks instead of
    using our own copies,

v2:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 4e760d63f2abd93f..0d49a25de740fbf8 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -9,6 +9,7 @@
  * for more details.
  */
 
+#include <linux/clk/renesas.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mm.h>
@@ -217,6 +218,8 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	return rcar_sysc_power_up(&pd->ch);
 }
 
+static bool has_cpg_mstp;
+
 static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
@@ -248,6 +251,18 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		gov = &pm_domain_always_on_gov;
 	}
 
+	if (!(pd->flags & (PD_CPU | PD_SCU))) {
+		/* Enable Clock Domain for I/O devices */
+		genpd->flags = GENPD_FLAG_PM_CLK;
+		if (has_cpg_mstp) {
+			genpd->attach_dev = cpg_mstp_attach_dev;
+			genpd->detach_dev = cpg_mstp_detach_dev;
+		} else {
+			genpd->attach_dev = cpg_mssr_attach_dev;
+			genpd->detach_dev = cpg_mssr_detach_dev;
+		}
+	}
+
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
@@ -294,6 +309,9 @@ static int __init rcar_sysc_pd_init(void)
 
 	info = match->data;
 
+	has_cpg_mstp = of_find_compatible_node(NULL, NULL,
+					       "renesas,cpg-mstp-clocks");
+
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_warn("%s: Cannot map regs\n", np->full_name);
-- 
1.9.1

