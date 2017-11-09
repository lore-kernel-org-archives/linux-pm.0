From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] soc: renesas: rcar-sysc: Keep wakeup sources active during system suspend
Date: Thu,  9 Nov 2017 14:27:02 +0100
Message-ID: <1510234022-29442-4-git-send-email-geert+renesas@glider.be>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:60470 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbdKIN1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 08:27:17 -0500
In-Reply-To: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
Domain and to be used as a wakeup source, it must be kept active during
system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.

Note that this will only affect devices configured as wakeup sources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Integrate "soc: renesas: rcar-sysc: Use GENPD_FLAG_ACTIVE_WAKEUP",
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index c8406e81640f6560..ac4df1c43b2fbdbe 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -224,7 +224,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 
 	if (!(pd->flags & (PD_CPU | PD_SCU))) {
 		/* Enable Clock Domain for I/O devices */
-		genpd->flags |= GENPD_FLAG_PM_CLK;
+		genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 		if (has_cpg_mstp) {
 			genpd->attach_dev = cpg_mstp_attach_dev;
 			genpd->detach_dev = cpg_mstp_detach_dev;
-- 
2.7.4
