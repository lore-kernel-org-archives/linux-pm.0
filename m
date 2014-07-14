From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v7 2/6] clk: samsung: register exynos5420 apll/kpll configuration data
Date: Mon, 14 Jul 2014 19:08:34 +0530
Message-ID: <1405345118-4269-3-git-send-email-thomas.ab@samsung.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

Register the PLL configuration data for APLL and KPLL on Exynos5420. This
configuration data table specifies PLL coefficients for supported PLL
clock speeds when a 24MHz clock is supplied as the input clock source
for these PLLs.

Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Tested-by: Arjun K.V <arjun.kv@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index cc14ac8..95f83be 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1169,6 +1169,28 @@ static struct samsung_gate_clock exynos5x_gate_clks[] __initdata = {
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
 };
 
+static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] = {
+	PLL_35XX_RATE(2000000000, 250, 3, 0),
+	PLL_35XX_RATE(1900000000, 475, 6, 0),
+	PLL_35XX_RATE(1800000000, 225, 3, 0),
+	PLL_35XX_RATE(1700000000, 425, 6, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
+	PLL_35XX_RATE(1500000000, 250, 4, 0),
+	PLL_35XX_RATE(1400000000, 175, 3, 0),
+	PLL_35XX_RATE(1300000000, 325, 6, 0),
+	PLL_35XX_RATE(1200000000, 200, 2, 1),
+	PLL_35XX_RATE(1100000000, 275, 3, 1),
+	PLL_35XX_RATE(1000000000, 250, 3, 1),
+	PLL_35XX_RATE(900000000,  150, 2, 1),
+	PLL_35XX_RATE(800000000,  200, 3, 1),
+	PLL_35XX_RATE(700000000,  175, 3, 1),
+	PLL_35XX_RATE(600000000,  200, 2, 2),
+	PLL_35XX_RATE(500000000,  250, 3, 2),
+	PLL_35XX_RATE(400000000,  200, 3, 2),
+	PLL_35XX_RATE(300000000,  200, 2, 3),
+	PLL_35XX_RATE(200000000,  200, 3, 3),
+};
+
 static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
@@ -1222,6 +1244,12 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5x_fixed_rate_ext_clks),
 			ext_clk_match);
+
+	if (_get_rate("fin_pll") == 24 * MHZ) {
+		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+	}
+
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(ctx, exynos5x_fixed_rate_clks,
-- 
1.7.9.5
