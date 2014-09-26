From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 2/6] clk: imx5: add step clock, used when reprogramming PLL1
Date: Fri, 26 Sep 2014 15:41:00 +0200
Message-ID: <1411738864-26549-2-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39601 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbaIZNla (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:41:30 -0400
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

This is the bypass clock used to feed the ARM partition
while we reprogram PLL1 to another rate.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c    | 9 ++++++++-
 include/dt-bindings/clock/imx5-clock.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 72d65214223e..aafccf4b47c2 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -125,6 +125,8 @@ static const char *mx53_spdif_xtal_sel[] = { "osc", "ckih", "ckih2", "pll4_sw",
 static const char *spdif_sel[] = { "pll1_sw", "pll2_sw", "pll3_sw", "spdif_xtal_sel", };
 static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
 static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
+static const char *step_sels[] = { "lp_apm", };
+static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
 
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -193,7 +195,9 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_USB_PHY_PODF]	= imx_clk_divider("usb_phy_podf", "usb_phy_pred", MXC_CCM_CDCDR, 0, 3);
 	clk[IMX5_CLK_USB_PHY_SEL]	= imx_clk_mux("usb_phy_sel", MXC_CCM_CSCMR1, 26, 1,
 						usb_phy_sel_str, ARRAY_SIZE(usb_phy_sel_str));
-	clk[IMX5_CLK_CPU_PODF]		= imx_clk_divider("cpu_podf", "pll1_sw", MXC_CCM_CACRR, 0, 3);
+	clk[IMX5_CLK_STEP_SEL]		= imx_clk_mux("step_sel", MXC_CCM_CCSR, 7, 2, step_sels, ARRAY_SIZE(step_sels));
+	clk[IMX5_CLK_CPU_PODF_SEL]	= imx_clk_mux("cpu_podf_sel", MXC_CCM_CCSR, 2, 1, cpu_podf_sels, ARRAY_SIZE(cpu_podf_sels));
+	clk[IMX5_CLK_CPU_PODF]		= imx_clk_divider("cpu_podf", "cpu_podf_sel", MXC_CCM_CACRR, 0, 3);
 	clk[IMX5_CLK_DI_PRED]		= imx_clk_divider("di_pred", "pll3_sw", MXC_CCM_CDCDR, 6, 3);
 	clk[IMX5_CLK_IIM_GATE]		= imx_clk_gate2("iim_gate", "ipg", MXC_CCM_CCGR0, 30);
 	clk[IMX5_CLK_UART1_IPG_GATE]	= imx_clk_gate2("uart1_ipg_gate", "ipg", MXC_CCM_CCGR1, 6);
@@ -551,6 +555,9 @@ static void __init mx53_clocks_init(struct device_node *np)
 	/* move can bus clk to 24MHz */
 	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
 
+	/* make sure step clock is running from 24MHz */
+	clk_set_parent(clk[IMX5_CLK_STEP_SEL], clk[IMX5_CLK_LP_APM]);
+
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
 	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index 5f2667ecd98e..1a36ff4ace1e 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -198,6 +198,8 @@
 #define IMX5_CLK_OCRAM			186
 #define IMX5_CLK_SAHARA_IPG_GATE	187
 #define IMX5_CLK_SATA_REF		188
-#define IMX5_CLK_END			189
+#define IMX5_CLK_STEP_SEL		189
+#define IMX5_CLK_CPU_PODF_SEL		190
+#define IMX5_CLK_END			191
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
2.1.0

