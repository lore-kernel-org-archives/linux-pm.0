From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 4/8] clk: samsung: exynos4: Add divider clock id for memory
 bus frequency
Date: Thu, 08 Jan 2015 10:40:53 +0900
Message-ID: <1420681257-3078-5-git-send-email-cw00.choi@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the divider clock id for Exynos4 memory bus frequency.
The clock id is used fo DVFS (Dynamic Voltage/Frequency Scaling)
feature of exynos memory bus frequency.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c   | 10 +++++-----
 include/dt-bindings/clock/exynos4.h |  7 ++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 88e8c6b..51462e8 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -703,12 +703,12 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 
 /* list of divider clocks supported in all exynos4 soc's */
 static struct samsung_div_clock exynos4_div_clks[] __initdata = {
-	DIV(0, "div_gdl", "mout_gdl", DIV_LEFTBUS, 0, 3),
+	DIV(CLK_DIV_GDL, "div_gdl", "mout_gdl", DIV_LEFTBUS, 0, 3),
 	DIV(0, "div_gpl", "div_gdl", DIV_LEFTBUS, 4, 3),
 	DIV(0, "div_clkout_leftbus", "mout_clkout_leftbus",
 			CLKOUT_CMU_LEFTBUS, 8, 6),
 
-	DIV(0, "div_gdr", "mout_gdr", DIV_RIGHTBUS, 0, 3),
+	DIV(CLK_DIV_GDR, "div_gdr", "mout_gdr", DIV_RIGHTBUS, 0, 3),
 	DIV(0, "div_gpr", "div_gdr", DIV_RIGHTBUS, 4, 3),
 	DIV(0, "div_clkout_rightbus", "mout_clkout_rightbus",
 			CLKOUT_CMU_RIGHTBUS, 8, 6),
@@ -781,10 +781,10 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 			CLK_SET_RATE_PARENT, 0),
 	DIV(0, "div_clkout_top", "mout_clkout_top", CLKOUT_CMU_TOP, 8, 6),
 
-	DIV(0, "div_acp", "mout_dmc_bus", DIV_DMC0, 0, 3),
+	DIV(CLK_DIV_ACP, "div_acp", "mout_dmc_bus", DIV_DMC0, 0, 3),
 	DIV(0, "div_acp_pclk", "div_acp", DIV_DMC0, 4, 3),
 	DIV(0, "div_dphy", "mout_dphy", DIV_DMC0, 8, 3),
-	DIV(0, "div_dmc", "mout_dmc_bus", DIV_DMC0, 12, 3),
+	DIV(CLK_DIV_DMC, "div_dmc", "mout_dmc_bus", DIV_DMC0, 12, 3),
 	DIV(0, "div_dmcd", "div_dmc", DIV_DMC0, 16, 3),
 	DIV(0, "div_dmcp", "div_dmcd", DIV_DMC0, 20, 3),
 	DIV(0, "div_pwi", "mout_pwi", DIV_DMC1, 8, 4),
@@ -829,7 +829,7 @@ static struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
 	DIV_F(CLK_DIV_MCUISP1, "div_mcuisp1", "div_mcuisp0", E4X12_DIV_ISP1,
 						8, 3, CLK_GET_RATE_NOCACHE, 0),
 	DIV(CLK_SCLK_FIMG2D, "sclk_fimg2d", "mout_g2d", DIV_DMC1, 0, 4),
-	DIV(0, "div_c2c", "mout_c2c", DIV_DMC1, 4, 3),
+	DIV(CLK_DIV_C2C, "div_c2c", "mout_c2c", DIV_DMC1, 4, 3),
 	DIV(0, "div_c2c_aclk", "div_c2c", DIV_DMC1, 12, 3),
 };
 
diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
index 34fe28c..c4b1676 100644
--- a/include/dt-bindings/clock/exynos4.h
+++ b/include/dt-bindings/clock/exynos4.h
@@ -262,8 +262,13 @@
 #define CLK_DIV_MCUISP1		453 /* Exynos4x12 only */
 #define CLK_DIV_ACLK200		454 /* Exynos4x12 only */
 #define CLK_DIV_ACLK400_MCUISP	455 /* Exynos4x12 only */
+#define CLK_DIV_ACP		456
+#define CLK_DIV_DMC		457
+#define CLK_DIV_C2C		458 /* Exynos4x12 only */
+#define CLK_DIV_GDL		459
+#define CLK_DIV_GDR		460
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		456
+#define CLK_NR_CLKS		461
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_4_H */
-- 
1.8.5.5
