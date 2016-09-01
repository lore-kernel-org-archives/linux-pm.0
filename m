From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/5] clocks: exynos5433: add runtime pm support
Date: Thu, 01 Sep 2016 15:45:51 +0200
Message-ID: <1472737551-15272-6-git-send-email-m.szyprowski@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add runtime pm support for all clock controller units (CMU), which belongs
to power domains and require special handling during on/off operations.
Typically special values has to be written to MUX registers to change
internal clocks parents to OSC clock before turning power off. During such
operation all clocks, which enters CMU has to be enabled to let MUX to
stabilize. Also for each CMU there is one special parent clock, which has
to be enabled all the time when any access to CMU registers is done.

This patch solves most of the mysterious external abort and freeze issues
caused by a lack of proper parent CMU clock enabled or incorrect turn off
procedure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 462 +++++++++++++++++++++++++++--------
 1 file changed, 363 insertions(+), 99 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index ea1608682d7f..9fb896b56ddf 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -9,9 +9,14 @@
  * Common Clock Framework support for Exynos5443 SoC.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/clock/exynos5433.h>
 
@@ -19,6 +24,37 @@
 #include "clk-cpu.h"
 #include "clk-pll.h"
 
+struct exynos5433_cmu_info {
+	/* total number of clocks with IDs assigned*/
+	unsigned int nr_clk_ids;
+	/* list of pll clocks and respective count */
+	const struct samsung_pll_clock *pll_clks;
+	unsigned int nr_pll_clks;
+	/* list of mux clocks and respective count */
+	const struct samsung_mux_clock *mux_clks;
+	unsigned int nr_mux_clks;
+	/* list of div clocks and respective count */
+	const struct samsung_div_clock *div_clks;
+	unsigned int nr_div_clks;
+	/* list of gate clocks and respective count */
+	const struct samsung_gate_clock *gate_clks;
+	unsigned int nr_gate_clks;
+	/* list of fixed clocks and respective count */
+	const struct samsung_fixed_rate_clock *fixed_clks;
+	unsigned int nr_fixed_clks;
+	/* list of fixed factor clocks and respective count */
+	const struct samsung_fixed_factor_clock *fixed_factor_clks;
+	unsigned int nr_fixed_factor_clks;
+	/* list and number of clocks registers */
+	const unsigned long *clk_regs;
+	unsigned int nr_clk_regs;
+	/* list and number of clocks registers to set before suspend */
+	const struct samsung_clk_reg_dump *suspend_regs;
+	unsigned int nr_suspend_regs;
+	/* name of the parent clock needed for CMU register access */
+	const char *clk_name;
+};
+
 /*
  * Register offset definitions for CMU_TOP
  */
@@ -2333,6 +2369,10 @@ static const unsigned long g2d_clk_regs[] __initconst = {
 	DIV_ENABLE_IP_G2D_SECURE_SMMU_G2D,
 };
 
+static const struct samsung_clk_reg_dump g2d_suspend_regs[] = {
+	{MUX_SEL_G2D0, 0},
+};
+
 /* list of all parent clock list */
 PNAME(mout_aclk_g2d_266_user_p)		= { "oscclk", "aclk_g2d_266", };
 PNAME(mout_aclk_g2d_400_user_p)		= { "oscclk", "aclk_g2d_400", };
@@ -2408,26 +2448,21 @@ static const struct samsung_gate_clock g2d_gate_clks[] __initconst = {
 		DIV_ENABLE_PCLK_G2D_SECURE_SMMU_G2D, 0, 0, 0),
 };
 
-static const struct samsung_cmu_info g2d_cmu_info __initconst = {
+static const struct exynos5433_cmu_info g2d_cmu_info __initconst = {
+	.nr_clk_ids		= G2D_NR_CLK,
 	.mux_clks		= g2d_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(g2d_mux_clks),
 	.div_clks		= g2d_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(g2d_div_clks),
 	.gate_clks		= g2d_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(g2d_gate_clks),
-	.nr_clk_ids		= G2D_NR_CLK,
 	.clk_regs		= g2d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g2d_clk_regs),
+	.suspend_regs		= g2d_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(g2d_suspend_regs),
+	.clk_name		= "aclk_g2d_400",
 };
 
-static void __init exynos5433_cmu_g2d_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &g2d_cmu_info);
-}
-
-CLK_OF_DECLARE(exynos5433_cmu_g2d, "samsung,exynos5433-cmu-g2d",
-		exynos5433_cmu_g2d_init);
-
 /*
  * Register offset definitions for CMU_DISP
  */
@@ -2492,6 +2527,14 @@ static const unsigned long disp_clk_regs[] __initconst = {
 	CLKOUT_CMU_DISP_DIV_STAT,
 };
 
+static const struct samsung_clk_reg_dump disp_suspend_regs[] = {
+	{MUX_SEL_DISP0, 0},
+	{MUX_SEL_DISP1, 0},
+	{MUX_SEL_DISP2, 0},
+	{MUX_SEL_DISP3, 0},
+	{MUX_SEL_DISP4, 0},
+};
+
 /* list of all parent clock list */
 PNAME(mout_disp_pll_p)			= { "oscclk", "fout_disp_pll", };
 PNAME(mout_sclk_dsim1_user_p)		= { "oscclk", "sclk_dsim1_disp", };
@@ -2821,7 +2864,8 @@ static const struct samsung_gate_clock disp_gate_clks[] __initconst = {
 			"div_sclk_decon_eclk_disp", ENABLE_SCLK_DISP, 2, 0, 0),
 };
 
-static const struct samsung_cmu_info disp_cmu_info __initconst = {
+static const struct exynos5433_cmu_info disp_cmu_info __initconst = {
+	.nr_clk_ids		= DISP_NR_CLK,
 	.pll_clks		= disp_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(disp_pll_clks),
 	.mux_clks		= disp_mux_clks,
@@ -2834,19 +2878,13 @@ static const struct samsung_cmu_info disp_cmu_info __initconst = {
 	.nr_fixed_clks		= ARRAY_SIZE(disp_fixed_clks),
 	.fixed_factor_clks	= disp_fixed_factor_clks,
 	.nr_fixed_factor_clks	= ARRAY_SIZE(disp_fixed_factor_clks),
-	.nr_clk_ids		= DISP_NR_CLK,
 	.clk_regs		= disp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(disp_clk_regs),
+	.suspend_regs		= disp_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(disp_suspend_regs),
+	.clk_name		= "aclk_disp_333",
 };
 
-static void __init exynos5433_cmu_disp_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &disp_cmu_info);
-}
-
-CLK_OF_DECLARE(exynos5433_cmu_disp, "samsung,exynos5433-cmu-disp",
-		exynos5433_cmu_disp_init);
-
 /*
  * Register offset definitions for CMU_AUD
  */
@@ -2881,6 +2919,11 @@ static const unsigned long aud_clk_regs[] __initconst = {
 	ENABLE_IP_AUD1,
 };
 
+static const struct samsung_clk_reg_dump aud_suspend_regs[] = {
+	{MUX_SEL_AUD0, 0},
+	{MUX_SEL_AUD1, 0},
+};
+
 /* list of all parent clock list */
 PNAME(mout_aud_pll_user_aud_p)	= { "oscclk", "fout_aud_pll", };
 PNAME(mout_sclk_aud_pcm_p)	= { "mout_aud_pll_user", "ioclk_audiocdclk0",};
@@ -2995,7 +3038,8 @@ static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
 			ENABLE_SCLK_AUD1, 0, CLK_IGNORE_UNUSED, 0),
 };
 
-static const struct samsung_cmu_info aud_cmu_info __initconst = {
+static const struct exynos5433_cmu_info aud_cmu_info __initconst = {
+	.nr_clk_ids		= AUD_NR_CLK,
 	.mux_clks		= aud_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(aud_mux_clks),
 	.div_clks		= aud_div_clks,
@@ -3004,19 +3048,12 @@ static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
 	.fixed_clks		= aud_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
-	.nr_clk_ids		= AUD_NR_CLK,
 	.clk_regs		= aud_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
+	.suspend_regs		= aud_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(aud_suspend_regs),
 };
 
-static void __init exynos5433_cmu_aud_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &aud_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_aud, "samsung,exynos5433-cmu-aud",
-		exynos5433_cmu_aud_init);
-
-
 /*
  * Register offset definitions for CMU_BUS{0|1|2}
  */
@@ -3218,6 +3255,10 @@ static const unsigned long g3d_clk_regs[] __initconst = {
 	CLK_STOPCTRL,
 };
 
+static const struct samsung_clk_reg_dump g3d_suspend_regs[] = {
+	{MUX_SEL_G3D, 0},
+};
+
 /* list of all parent clock list */
 PNAME(mout_aclk_g3d_400_p)	= { "mout_g3d_pll", "aclk_g3d_400", };
 PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll", };
@@ -3279,7 +3320,8 @@ static const struct samsung_gate_clock g3d_gate_clks[] __initconst = {
 			ENABLE_SCLK_G3D, 0, 0, 0),
 };
 
-static const struct samsung_cmu_info g3d_cmu_info __initconst = {
+static const struct exynos5433_cmu_info g3d_cmu_info __initconst = {
+	.nr_clk_ids		= G3D_NR_CLK,
 	.pll_clks		= g3d_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(g3d_pll_clks),
 	.mux_clks		= g3d_mux_clks,
@@ -3288,18 +3330,13 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
 	.gate_clks		= g3d_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
-	.nr_clk_ids		= G3D_NR_CLK,
 	.clk_regs		= g3d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
+	.suspend_regs		= g3d_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(g3d_suspend_regs),
+	.clk_name		= "aclk_g3d_400",
 };
 
-static void __init exynos5433_cmu_g3d_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &g3d_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_g3d, "samsung,exynos5433-cmu-g3d",
-		exynos5433_cmu_g3d_init);
-
 /*
  * Register offset definitions for CMU_GSCL
  */
@@ -3338,6 +3375,12 @@ static const unsigned long gscl_clk_regs[] __initconst = {
 	ENABLE_IP_GSCL_SECURE_SMMU_GSCL2,
 };
 
+static const struct samsung_clk_reg_dump gscl_suspend_regs[] = {
+	{MUX_SEL_GSCL, 0},
+	{ENABLE_ACLK_GSCL, 0xfff},
+	{ENABLE_PCLK_GSCL, 0xff},
+};
+
 /* list of all parent clock list */
 PNAME(aclk_gscl_111_user_p)	= { "oscclk", "aclk_gscl_111", };
 PNAME(aclk_gscl_333_user_p)	= { "oscclk", "aclk_gscl_333", };
@@ -3424,23 +3467,19 @@ static const struct samsung_gate_clock gscl_gate_clks[] __initconst = {
 		ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL2, 0, 0, 0),
 };
 
-static const struct samsung_cmu_info gscl_cmu_info __initconst = {
+static const struct exynos5433_cmu_info gscl_cmu_info __initconst = {
+	.nr_clk_ids		= GSCL_NR_CLK,
 	.mux_clks		= gscl_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(gscl_mux_clks),
 	.gate_clks		= gscl_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(gscl_gate_clks),
-	.nr_clk_ids		= GSCL_NR_CLK,
 	.clk_regs		= gscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(gscl_clk_regs),
+	.suspend_regs		= gscl_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(gscl_suspend_regs),
+	.clk_name		= "aclk_gscl_111",
 };
 
-static void __init exynos5433_cmu_gscl_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &gscl_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_gscl, "samsung,exynos5433-cmu-gscl",
-		exynos5433_cmu_gscl_init);
-
 /*
  * Register offset definitions for CMU_APOLLO
  */
@@ -3966,6 +4005,11 @@ static const unsigned long mscl_clk_regs[] __initconst = {
 	ENABLE_IP_MSCL_SECURE_SMMU_JPEG,
 };
 
+static const struct samsung_clk_reg_dump mscl_suspend_regs[] = {
+	{MUX_SEL_MSCL0, 0},
+	{MUX_SEL_MSCL1, 0},
+};
+
 /* list of all parent clock list */
 PNAME(mout_sclk_jpeg_user_p)		= { "oscclk", "sclk_jpeg_mscl", };
 PNAME(mout_aclk_mscl_400_user_p)	= { "oscclk", "aclk_mscl_400", };
@@ -4068,25 +4112,21 @@ static const struct samsung_gate_clock mscl_gate_clks[] __initconst = {
 			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
 };
 
-static const struct samsung_cmu_info mscl_cmu_info __initconst = {
+static const struct exynos5433_cmu_info mscl_cmu_info __initconst = {
+	.nr_clk_ids		= MSCL_NR_CLK,
 	.mux_clks		= mscl_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(mscl_mux_clks),
 	.div_clks		= mscl_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(mscl_div_clks),
 	.gate_clks		= mscl_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(mscl_gate_clks),
-	.nr_clk_ids		= MSCL_NR_CLK,
 	.clk_regs		= mscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mscl_clk_regs),
+	.suspend_regs		= mscl_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(mscl_suspend_regs),
+	.clk_name		= "aclk_mscl_400",
 };
 
-static void __init exynos5433_cmu_mscl_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &mscl_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_mscl, "samsung,exynos5433-cmu-mscl",
-		exynos5433_cmu_mscl_init);
-
 /*
  * Register offset definitions for CMU_MFC
  */
@@ -4116,6 +4156,10 @@ static const unsigned long mfc_clk_regs[] __initconst = {
 	ENABLE_IP_MFC_SECURE_SMMU_MFC,
 };
 
+static const struct samsung_clk_reg_dump mfc_suspend_regs[] = {
+	{MUX_SEL_MFC, 0},
+};
+
 PNAME(mout_aclk_mfc_400_user_p)		= { "oscclk", "aclk_mfc_400", };
 
 static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
@@ -4176,25 +4220,21 @@ static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static const struct samsung_cmu_info mfc_cmu_info __initconst = {
+static const struct exynos5433_cmu_info mfc_cmu_info __initconst = {
+	.nr_clk_ids		= MFC_NR_CLK,
 	.mux_clks		= mfc_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(mfc_mux_clks),
 	.div_clks		= mfc_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(mfc_div_clks),
 	.gate_clks		= mfc_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(mfc_gate_clks),
-	.nr_clk_ids		= MFC_NR_CLK,
 	.clk_regs		= mfc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
+	.suspend_regs		= mfc_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(mfc_suspend_regs),
+	.clk_name		= "aclk_mfc_400",
 };
 
-static void __init exynos5433_cmu_mfc_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &mfc_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_mfc, "samsung,exynos5433-cmu-mfc",
-		exynos5433_cmu_mfc_init);
-
 /*
  * Register offset definitions for CMU_HEVC
  */
@@ -4224,6 +4264,10 @@ static const unsigned long hevc_clk_regs[] __initconst = {
 	ENABLE_IP_HEVC_SECURE_SMMU_HEVC,
 };
 
+static const struct samsung_clk_reg_dump hevc_suspend_regs[] = {
+	{MUX_SEL_HEVC, 0},
+};
+
 PNAME(mout_aclk_hevc_400_user_p)	= { "oscclk", "aclk_hevc_400", };
 
 static const struct samsung_mux_clock hevc_mux_clks[] __initconst = {
@@ -4286,25 +4330,21 @@ static const struct samsung_gate_clock hevc_gate_clks[] __initconst = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static const struct samsung_cmu_info hevc_cmu_info __initconst = {
+static const struct exynos5433_cmu_info hevc_cmu_info __initconst = {
+	.nr_clk_ids		= HEVC_NR_CLK,
 	.mux_clks		= hevc_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(hevc_mux_clks),
 	.div_clks		= hevc_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(hevc_div_clks),
 	.gate_clks		= hevc_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(hevc_gate_clks),
-	.nr_clk_ids		= HEVC_NR_CLK,
 	.clk_regs		= hevc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(hevc_clk_regs),
+	.suspend_regs		= hevc_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(hevc_suspend_regs),
+	.clk_name		= "aclk_hevc_400",
 };
 
-static void __init exynos5433_cmu_hevc_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &hevc_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_hevc, "samsung,exynos5433-cmu-hevc",
-		exynos5433_cmu_hevc_init);
-
 /*
  * Register offset definitions for CMU_ISP
  */
@@ -4338,6 +4378,10 @@ static const unsigned long isp_clk_regs[] __initconst = {
 	ENABLE_IP_ISP3,
 };
 
+static const struct samsung_clk_reg_dump isp_suspend_regs[] = {
+	{MUX_SEL_ISP, 0},
+};
+
 PNAME(mout_aclk_isp_dis_400_user_p)	= { "oscclk", "aclk_isp_dis_400", };
 PNAME(mout_aclk_isp_400_user_p)		= { "oscclk", "aclk_isp_400", };
 
@@ -4539,25 +4583,21 @@ static const struct samsung_gate_clock isp_gate_clks[] __initconst = {
 			0, CLK_IGNORE_UNUSED, 0),
 };
 
-static const struct samsung_cmu_info isp_cmu_info __initconst = {
+static const struct exynos5433_cmu_info isp_cmu_info __initconst = {
+	.nr_clk_ids		= ISP_NR_CLK,
 	.mux_clks		= isp_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(isp_mux_clks),
 	.div_clks		= isp_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(isp_div_clks),
 	.gate_clks		= isp_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(isp_gate_clks),
-	.nr_clk_ids		= ISP_NR_CLK,
 	.clk_regs		= isp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(isp_clk_regs),
+	.suspend_regs		= isp_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(isp_suspend_regs),
+	.clk_name		= "aclk_isp_400",
 };
 
-static void __init exynos5433_cmu_isp_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &isp_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_isp, "samsung,exynos5433-cmu-isp",
-		exynos5433_cmu_isp_init);
-
 /*
  * Register offset definitions for CMU_CAM0
  */
@@ -4621,6 +4661,15 @@ static const unsigned long cam0_clk_regs[] __initconst = {
 	ENABLE_IP_CAM02,
 	ENABLE_IP_CAM03,
 };
+
+static const struct samsung_clk_reg_dump cam0_suspend_regs[] = {
+	{MUX_SEL_CAM00, 0},
+	{MUX_SEL_CAM01, 0},
+	{MUX_SEL_CAM02, 0},
+	{MUX_SEL_CAM03, 0},
+	{MUX_SEL_CAM04, 0},
+};
+
 PNAME(mout_aclk_cam0_333_user_p)	= { "oscclk", "aclk_cam0_333", };
 PNAME(mout_aclk_cam0_400_user_p)	= { "oscclk", "aclk_cam0_400", };
 PNAME(mout_aclk_cam0_552_user_p)	= { "oscclk", "aclk_cam0_552", };
@@ -5014,7 +5063,8 @@ static const struct samsung_gate_clock cam0_gate_clks[] __initconst = {
 			ENABLE_SCLK_CAM0, 0, 0, 0),
 };
 
-static const struct samsung_cmu_info cam0_cmu_info __initconst = {
+static const struct exynos5433_cmu_info cam0_cmu_info __initconst = {
+	.nr_clk_ids		= CAM0_NR_CLK,
 	.mux_clks		= cam0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(cam0_mux_clks),
 	.div_clks		= cam0_div_clks,
@@ -5023,18 +5073,13 @@ static const struct samsung_cmu_info cam0_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(cam0_gate_clks),
 	.fixed_clks		= cam0_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(cam0_fixed_clks),
-	.nr_clk_ids		= CAM0_NR_CLK,
 	.clk_regs		= cam0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cam0_clk_regs),
+	.suspend_regs		= cam0_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(cam0_suspend_regs),
+	.clk_name		= "aclk_cam0_400",
 };
 
-static void __init exynos5433_cmu_cam0_init(struct device_node *np)
-{
-	samsung_cmu_register_one(np, &cam0_cmu_info);
-}
-CLK_OF_DECLARE(exynos5433_cmu_cam0, "samsung,exynos5433-cmu-cam0",
-		exynos5433_cmu_cam0_init);
-
 /*
  * Register offset definitions for CMU_CAM1
  */
@@ -5081,6 +5126,12 @@ static const unsigned long cam1_clk_regs[] __initconst = {
 	ENABLE_IP_CAM12,
 };
 
+static const struct samsung_clk_reg_dump cam1_suspend_regs[] = {
+	{MUX_SEL_CAM10, 0},
+	{MUX_SEL_CAM11, 0},
+	{MUX_SEL_CAM12, 0},
+};
+
 PNAME(mout_sclk_isp_uart_user_p)	= { "oscclk", "sclk_isp_uart_cam1", };
 PNAME(mout_sclk_isp_spi1_user_p)	= { "oscclk", "sclk_isp_spi1_cam1", };
 PNAME(mout_sclk_isp_spi0_user_p)	= { "oscclk", "sclk_isp_spi0_cam1", };
@@ -5387,7 +5438,8 @@ static const struct samsung_gate_clock cam1_gate_clks[] __initconst = {
 			ENABLE_SCLK_CAM1, 0, 0, 0),
 };
 
-static const struct samsung_cmu_info cam1_cmu_info __initconst = {
+static const struct exynos5433_cmu_info cam1_cmu_info __initconst = {
+	.nr_clk_ids		= CAM1_NR_CLK,
 	.mux_clks		= cam1_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(cam1_mux_clks),
 	.div_clks		= cam1_div_clks,
@@ -5396,14 +5448,226 @@ static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(cam1_gate_clks),
 	.fixed_clks		= cam1_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(cam1_fixed_clks),
-	.nr_clk_ids		= CAM1_NR_CLK,
 	.clk_regs		= cam1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cam1_clk_regs),
+	.suspend_regs		= cam1_suspend_regs,
+	.nr_suspend_regs	= ARRAY_SIZE(cam1_suspend_regs),
+	.clk_name		= "aclk_cam1_400",
+};
+
+
+struct exynos5433_cmu_data {
+	struct samsung_clk_provider ctx;
+
+	struct samsung_clk_reg_dump *clk_save;
+	unsigned int nr_clk_save;
+	const struct samsung_clk_reg_dump *clk_suspend;
+	unsigned int nr_clk_suspend;
+
+	struct clk *clk;
+	struct clk **pclks;
+	int nr_pclks;
+};
+
+static int exynos5433_cmu_suspend(struct device *dev)
+{
+	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
+	int i;
+
+	samsung_clk_save(data->ctx.reg_base, data->clk_save,
+			 data->nr_clk_save);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_enable(data->pclks[i]);
+
+	samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
+			    data->nr_clk_suspend);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_disable(data->pclks[i]);
+
+	clk_disable(data->clk);
+
+	return 0;
+}
+
+static int exynos5433_cmu_resume(struct device *dev)
+{
+	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
+	int i;
+
+	clk_enable(data->clk);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_enable(data->pclks[i]);
+
+	samsung_clk_restore(data->ctx.reg_base, data->clk_save,
+			    data->nr_clk_save);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_disable(data->pclks[i]);
+
+	return 0;
+}
+
+static int __init exynos5433_cmu_probe(struct platform_device *pdev)
+{
+	const struct exynos5433_cmu_info *info;
+	struct exynos5433_cmu_data *data;
+	struct samsung_clk_provider *ctx;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *reg_base;
+	struct clk **clk_table;
+	int i;
+
+	info = of_device_get_match_data(dev);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	ctx = &data->ctx;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(dev, res);
+	if (!reg_base) {
+		dev_err(dev, "failed to map registers\n");
+		return -ENOMEM;
+	}
+
+	clk_table = devm_kcalloc(dev, info->nr_clk_ids, sizeof(struct clk *),
+				 GFP_KERNEL);
+	if (!clk_table) {
+		dev_err(dev, "could not allocate clock lookup table\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < info->nr_clk_ids; ++i)
+		clk_table[i] = ERR_PTR(-ENOENT);
+
+	ctx->clk_data.clks = clk_table;
+	ctx->clk_data.clk_num = info->nr_clk_ids;
+	ctx->reg_base = reg_base;
+	ctx->dev = dev;
+	spin_lock_init(&ctx->lock);
+
+	data->clk_save = samsung_clk_alloc_reg_dump(info->clk_regs,
+						    info->nr_clk_regs);
+	data->nr_clk_save = info->nr_clk_regs;
+	data->clk_suspend = info->suspend_regs;
+	data->nr_clk_suspend = info->nr_suspend_regs;
+	data->nr_pclks = of_count_phandle_with_args(dev->of_node, "clocks",
+						    "#clock-cells");
+	if (data->nr_pclks > 0) {
+		data->pclks = devm_kcalloc(dev, sizeof(struct clk *),
+					   data->nr_pclks, GFP_KERNEL);
+
+		for (i = 0; i < data->nr_pclks; i++) {
+			struct clk *clk = of_clk_get(dev->of_node, i);
+
+			if (IS_ERR(clk))
+				return PTR_ERR(clk);
+			data->pclks[i] = clk;
+		}
+	}
+
+	/*
+	 * Prepare all parent clocks here to avoid potential deadlock caused
+	 * by global clock "prepare lock" grabbed by runtime pm callbacks
+	 * from pm workers.
+	 */
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_prepare(data->pclks[i]);
+
+	if (info->pll_clks)
+		samsung_clk_register_pll(ctx, info->pll_clks, info->nr_pll_clks,
+					 reg_base);
+	if (info->mux_clks)
+		samsung_clk_register_mux(ctx, info->mux_clks,
+					 info->nr_mux_clks);
+	if (info->div_clks)
+		samsung_clk_register_div(ctx, info->div_clks,
+					 info->nr_div_clks);
+	if (info->gate_clks)
+		samsung_clk_register_gate(ctx, info->gate_clks,
+					  info->nr_gate_clks);
+	if (info->fixed_clks)
+		samsung_clk_register_fixed_rate(ctx, info->fixed_clks,
+						info->nr_fixed_clks);
+	if (info->fixed_factor_clks)
+		samsung_clk_register_fixed_factor(ctx, info->fixed_factor_clks,
+						  info->nr_fixed_factor_clks);
+
+	if (info->clk_name)
+		data->clk = clk_get(dev, info->clk_name);
+	clk_prepare_enable(data->clk);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	platform_set_drvdata(pdev, data);
+	samsung_clk_of_add_provider(dev->of_node, ctx);
+
+	return 0;
+}
+
+static const struct of_device_id exynos5433_cmu_of_match[] = {
+	{
+		.compatible = "samsung,exynos5433-cmu-aud",
+		.data = &aud_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-cam0",
+		.data = &cam0_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-cam1",
+		.data = &cam1_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-disp",
+		.data = &disp_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-g2d",
+		.data = &g2d_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-g3d",
+		.data = &g3d_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-gscl",
+		.data = &gscl_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-mfc",
+		.data = &mfc_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-hevc",
+		.data = &hevc_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-isp",
+		.data = &isp_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-mscl",
+		.data = &mscl_cmu_info,
+	}, {
+	},
+};
+
+static const struct dev_pm_ops exynos5433_cmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos5433_cmu_suspend, exynos5433_cmu_resume,
+			   NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
+};
+
+static struct platform_driver exynos5433_cmu_driver = {
+	.driver	= {
+		.name = "exynos5433-cmu",
+		.of_match_table = exynos5433_cmu_of_match,
+		.suppress_bind_attrs = true,
+		.pm = &exynos5433_cmu_pm_ops,
+	},
+	.probe = exynos5433_cmu_probe,
 };
 
-static void __init exynos5433_cmu_cam1_init(struct device_node *np)
+static int __init exynos5433_cmu_init(void)
 {
-	samsung_cmu_register_one(np, &cam1_cmu_info);
+	return platform_driver_register(&exynos5433_cmu_driver);
 }
-CLK_OF_DECLARE(exynos5433_cmu_cam1, "samsung,exynos5433-cmu-cam1",
-		exynos5433_cmu_cam1_init);
+core_initcall(exynos5433_cmu_init);
-- 
1.9.1

