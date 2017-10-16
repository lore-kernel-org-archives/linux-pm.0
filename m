From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/10] [RFC] soc: renesas: rcar-sysc: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Mon, 16 Oct 2017 15:55:14 +0200
Message-ID: <1508162116-5043-9-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58702 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752977AbdJPNz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 09:55:28 -0400
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own "always true" callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before "PM / Domain: Enable genpd users to
specify default active wakeup behavior" has landed upstream, hence the
"RFC".
---
 drivers/soc/renesas/rcar-sysc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index beb8b483a62abaca..ac4df1c43b2fbdbe 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -194,11 +194,6 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 
 static bool has_cpg_mstp;
 
-static bool rcar_sysc_pd_active_wakeup(struct device *dev)
-{
-	return true;
-}
-
 static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
@@ -229,8 +224,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 
 	if (!(pd->flags & (PD_CPU | PD_SCU))) {
 		/* Enable Clock Domain for I/O devices */
-		genpd->flags |= GENPD_FLAG_PM_CLK;
-		genpd->dev_ops.active_wakeup = rcar_sysc_pd_active_wakeup;
+		genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 		if (has_cpg_mstp) {
 			genpd->attach_dev = cpg_mstp_attach_dev;
 			genpd->detach_dev = cpg_mstp_detach_dev;
-- 
2.7.4
