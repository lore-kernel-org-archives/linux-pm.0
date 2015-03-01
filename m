From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v8 10/18] clk: tegra: Initialize PLL_X before CCLK_G to ensure it has a parent
Date: Sun,  1 Mar 2015 14:44:33 +0200
Message-ID: <1425213881-5262-11-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:54504 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbbCAMtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 Mar 2015 07:49:00 -0500
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>

This patch moves the initialization of PLL_X to be slightly before
that of CCLK_G. This ensures that at boot, CCLK_G will immediately
have a parent and the common clock framework can determine its
clock rate correctly.

Without this patch, calling clk_put on CCLK_G could cause the CCF
to set its rate to zero, hanging the system.

Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
v8:
- Added

 drivers/clk/tegra/clk-tegra-super-gen4.c | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index f1f4410..c5ea9ee 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -104,6 +104,32 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
 	struct clk *clk;
 	struct clk **dt_clk;
 
+	/*
+	 * Register PLL_X first so that CCLK_G has a parent at registration
+	 * time. This ensures that the common clock framework knows CCLK_G's
+	 * rate.
+	 */
+
+#if defined(CONFIG_ARCH_TEGRA_114_SOC) || defined(CONFIG_ARCH_TEGRA_124_SOC)
+	/* PLLX */
+	dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
+	if (!dt_clk)
+		return;
+
+	clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
+			pmc_base, CLK_IGNORE_UNUSED, params, NULL);
+	*dt_clk = clk;
+
+	/* PLLX_OUT0 */
+
+	dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
+	if (!dt_clk)
+		return;
+	clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
+					CLK_SET_RATE_PARENT, 1, 2);
+	*dt_clk = clk;
+#endif
+
 	/* CCLKG */
 	dt_clk = tegra_lookup_dt_id(tegra_clk_cclk_g, tegra_clks);
 	if (dt_clk) {
@@ -127,25 +153,5 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
 	}
 
 	tegra_sclk_init(clk_base, tegra_clks);
-
-#if defined(CONFIG_ARCH_TEGRA_114_SOC) || defined(CONFIG_ARCH_TEGRA_124_SOC)
-	/* PLLX */
-	dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x, tegra_clks);
-	if (!dt_clk)
-		return;
-
-	clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
-			pmc_base, CLK_IGNORE_UNUSED, params, NULL);
-	*dt_clk = clk;
-
-	/* PLLX_OUT0 */
-
-	dt_clk = tegra_lookup_dt_id(tegra_clk_pll_x_out0, tegra_clks);
-	if (!dt_clk)
-		return;
-	clk = clk_register_fixed_factor(NULL, "pll_x_out0", "pll_x",
-					CLK_SET_RATE_PARENT, 1, 2);
-	*dt_clk = clk;
-#endif
 }
 
-- 
2.3.0

