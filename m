From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 02/10] clk: renesas: cpg-mssr: Keep wakeup sources active during system suspend
Date: Mon, 16 Oct 2017 15:55:08 +0200
Message-ID: <1508162116-5043-3-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If a device is part of the CPG/MSSR Clock Domain and to be used as a
wakeup source, it must be kept active during system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core.

Hence provide an .active_wakeup() callback that always returns true.
Note that this will only affect devices configured as wakeup sources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index e580a5e6346c2533..de534896f596168c 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -481,6 +481,11 @@ void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 		pm_clk_destroy(dev);
 }
 
+static bool cpg_mssr_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
 static int __init cpg_mssr_add_clk_domain(struct device *dev,
 					  const unsigned int *core_pm_clks,
 					  unsigned int num_core_pm_clks)
@@ -501,6 +506,7 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	genpd = &pd->genpd;
 	genpd->name = np->name;
 	genpd->flags = GENPD_FLAG_PM_CLK;
+	genpd->dev_ops.active_wakeup = cpg_mssr_active_wakeup;
 	genpd->attach_dev = cpg_mssr_attach_dev;
 	genpd->detach_dev = cpg_mssr_detach_dev;
 	pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
-- 
2.7.4

