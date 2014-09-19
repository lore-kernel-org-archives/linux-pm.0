From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4/5] arm: imx53: clk: add ARM clock
Date: Fri, 19 Sep 2014 18:16:20 +0200
Message-ID: <1411143381-10516-5-git-send-email-l.stach@pengutronix.de>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48941 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbaISQQ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 12:16:29 -0400
In-Reply-To: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@pengutronix.de

The ARM clock is a virtual clock feeding the ARM partition of
the SoC. It controls multiple other clocks to ensure the right
sequencing when cpufreq changes the CPU clock rate.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c    | 5 +++++
 include/dt-bindings/clock/imx5-clock.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index aafccf4b47c2..0f7e536147cb 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -541,6 +541,11 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_CKO2]		= imx_clk_gate2("cko2", "cko2_podf", MXC_CCM_CCOSR, 24);
 	clk[IMX5_CLK_SPDIF_XTAL_SEL]	= imx_clk_mux("spdif_xtal_sel", MXC_CCM_CSCMR1, 2, 2,
 						mx53_spdif_xtal_sel, ARRAY_SIZE(mx53_spdif_xtal_sel));
+	clk[IMX5_CLK_ARM]		= imx_clk_cpu("arm", "cpu_podf",
+						clk[IMX5_CLK_CPU_PODF],
+						clk[IMX5_CLK_CPU_PODF_SEL],
+						clk[IMX5_CLK_PLL1_SW],
+						clk[IMX5_CLK_STEP_SEL]);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index 1a36ff4ace1e..f4b7478e23c8 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -200,6 +200,7 @@
 #define IMX5_CLK_SATA_REF		188
 #define IMX5_CLK_STEP_SEL		189
 #define IMX5_CLK_CPU_PODF_SEL		190
-#define IMX5_CLK_END			191
+#define IMX5_CLK_ARM			191
+#define IMX5_CLK_END			192
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
2.1.0

