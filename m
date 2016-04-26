From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] clk: renesas: cpg-mssr: Postpone call to pm_genpd_init()
Date: Tue, 26 Apr 2016 09:09:41 +0200
Message-ID: <1461654582-668-4-git-send-email-geert+renesas@glider.be>
References: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

All local setup of the generic_pm_domain structure should have been
completed before calling pm_genpd_init().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1f2dc3629f0e02a0..0d595311c659a741 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -493,9 +493,9 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	genpd = &pd->genpd;
 	genpd->name = np->name;
 	genpd->flags = GENPD_FLAG_PM_CLK;
-	pm_genpd_init(genpd, &simple_qos_governor, false);
 	genpd->attach_dev = cpg_mssr_attach_dev;
 	genpd->detach_dev = cpg_mssr_detach_dev;
+	pm_genpd_init(genpd, &simple_qos_governor, false);
 	cpg_mssr_clk_domain = pd;
 
 	of_genpd_add_provider_simple(np, genpd);
-- 
1.9.1
