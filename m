From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/10] [RFC] clk: renesas: cpg-mssr: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Mon, 16 Oct 2017 15:55:13 +0200
Message-ID: <1508162116-5043-8-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:59314 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdJPNz2 (ORCPT
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
 drivers/clk/renesas/renesas-cpg-mssr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index de534896f596168c..99699b715d7cf2de 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -481,11 +481,6 @@ void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 		pm_clk_destroy(dev);
 }
 
-static bool cpg_mssr_active_wakeup(struct device *dev)
-{
-	return true;
-}
-
 static int __init cpg_mssr_add_clk_domain(struct device *dev,
 					  const unsigned int *core_pm_clks,
 					  unsigned int num_core_pm_clks)
@@ -505,8 +500,7 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 
 	genpd = &pd->genpd;
 	genpd->name = np->name;
-	genpd->flags = GENPD_FLAG_PM_CLK;
-	genpd->dev_ops.active_wakeup = cpg_mssr_active_wakeup;
+	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = cpg_mssr_attach_dev;
 	genpd->detach_dev = cpg_mssr_detach_dev;
 	pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
-- 
2.7.4
