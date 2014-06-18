From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 2/3] clk: samsung: exynos3250: Use cpu-clock provider type to
 support cpufreq
Date: Wed, 18 Jun 2014 17:40:01 +0900
Message-ID: <1403080802-2794-3-git-send-email-cw00.choi@samsung.com>
References: <1403080802-2794-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1403080802-2794-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: t.figa@samsung.com, kgene.kim@samsung.com, thomas.ab@samsung.com, viresh.kumar@linaro.org, mturquette@linaro.org, shawn.guo@linaro.org
Cc: kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch use cpu-clock provider type to support cpufreq for Exynos3250. The
clock-exynos3250.c didn't add separate 'arm_clk' divider for 'div_core2'.
The 'div_core2' can be represented as a cpu-clock type and then use 'div_core2'
directly to change cpu clock.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 775a4ee..60ce369 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -357,8 +357,10 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 	MUX(CLK_MOUT_MPLL_USER_C, "mout_mpll_user_c", mout_mpll_user_p,
 	    SRC_CPU, 24, 1),
 	MUX(CLK_MOUT_HPM, "mout_hpm", mout_hpm_p, SRC_CPU, 20, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1),
-	MUX(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p, SRC_CPU, 16, 1, 0,
+			CLK_MUX_READ_ONLY),
+	MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
 };
 
 static struct samsung_div_clock div_clks[] __initdata = {
@@ -447,11 +449,13 @@ static struct samsung_div_clock div_clks[] __initdata = {
 
 	/* DIV_CPU0 */
 	DIV(CLK_DIV_CORE2, "div_core2", "div_core", DIV_CPU0, 28, 3),
-	DIV(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_F(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV(CLK_DIV_PCLK_DBG, "div_pclk_dbg", "div_core2", DIV_CPU0, 20, 3),
 	DIV(CLK_DIV_ATB, "div_atb", "div_core2", DIV_CPU0, 16, 3),
 	DIV(CLK_DIV_COREM, "div_corem", "div_core2", DIV_CPU0, 4, 3),
-	DIV(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3),
+	DIV_F(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 
 	/* DIV_CPU1 */
 	DIV(CLK_DIV_HPM, "div_hpm", "div_copy", DIV_CPU1, 4, 3),
@@ -820,6 +824,8 @@ static void __init exynos3_cmu_init(struct device_node *np,
 	samsung_clk_register_mux(ctx, mux_clks, ARRAY_SIZE(mux_clks));
 	samsung_clk_register_div(ctx, div_clks, ARRAY_SIZE(div_clks));
 	samsung_clk_register_gate(ctx, gate_clks, ARRAY_SIZE(gate_clks));
+	exynos_register_cpu_clock(ctx, 0, CLK_DIV_CORE2, "armclk",
+				mout_core_p[0], mout_core_p[1], np);
 
 	if (soc == EXYNOS3472) {
 		samsung_clk_register_mux(ctx, exynos3472_mux_clks,
-- 
1.8.0
