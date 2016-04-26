From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] clk: renesas: cpg-mssr: Use always-on governor for Clock Domain
Date: Tue, 26 Apr 2016 09:09:42 +0200
Message-ID: <1461654582-668-5-git-send-email-geert+renesas@glider.be>
References: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

As a pure Clock Domain does not have the concept of powering the domain
itself, the CPG/MSTP driver does not provide power_off() and power_on()
callbacks.
However, the genpd core may still perform a dummy power down, causing
/sys/kernel/debug/pm_genpd/pm_genpd_summary to report the domain's
status being "off-0".

Use the always-on governor to make sure the domain is never powered
down, and always shows up as "on" in pm_genpd_summary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 0d595311c659a741..210cd744a7a97bbd 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -495,7 +495,7 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	genpd->flags = GENPD_FLAG_PM_CLK;
 	genpd->attach_dev = cpg_mssr_attach_dev;
 	genpd->detach_dev = cpg_mssr_detach_dev;
-	pm_genpd_init(genpd, &simple_qos_governor, false);
+	pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
 	cpg_mssr_clk_domain = pd;
 
 	of_genpd_add_provider_simple(np, genpd);
-- 
1.9.1

