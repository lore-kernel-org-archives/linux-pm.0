From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v11 6/6] clk: samsung: remove unused clock aliases and update
 clock flags
Date: Mon, 20 Oct 2014 17:11:21 +0530
Message-ID: <1413805281-6269-7-git-send-email-thomas.ab@samsung.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21893 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbaJTLbJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 07:31:09 -0400
In-reply-to: <1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com

With some of the Exynos SoCs switched over to use the generic CPUfreq drivers,
the unused clock aliases can be removed. In addition to this, the individual
clock blocks which are now encapsulated with the consolidate CPU clock type
can now be marked with read-only flags.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    |   48 +++++++++++++++++-----------------
 drivers/clk/samsung/clk-exynos5250.c |   19 ++++++++-----
 drivers/clk/samsung/clk-exynos5420.c |   27 ++++++++++++------
 3 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 9af5767..3731fc7 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -578,7 +578,8 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
 	MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
 	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1, 0,
+			CLK_MUX_READ_ONLY),
 	MUX(0, "mout_hpm", mout_core_p4210, SRC_CPU, 20, 1),
 	MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
 	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
@@ -714,15 +715,24 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(0, "div_clkout_rightbus", "mout_clkout_rightbus",
 			CLKOUT_CMU_RIGHTBUS, 8, 6),
 
-	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
-	DIV(0, "div_corem0", "div_core2", DIV_CPU0, 4, 3),
-	DIV(0, "div_corem1", "div_core2", DIV_CPU0, 8, 3),
-	DIV(0, "div_periph", "div_core2", DIV_CPU0, 12, 3),
-	DIV(0, "div_atb", "mout_core", DIV_CPU0, 16, 3),
-	DIV(0, "div_pclk_dbg", "div_atb", DIV_CPU0, 20, 3),
-	DIV(CLK_ARM_CLK, "div_core2", "div_core", DIV_CPU0, 28, 3),
-	DIV(0, "div_copy", "mout_hpm", DIV_CPU1, 0, 3),
-	DIV(0, "div_hpm", "div_copy", DIV_CPU1, 4, 3),
+	DIV_F(0, "div_core", "mout_core", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_corem0", "div_core2", DIV_CPU0, 4, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_corem1", "div_core2", DIV_CPU0, 8, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_periph", "div_core2", DIV_CPU0, 12, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_atb", "mout_core", DIV_CPU0, 16, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_pclk_dbg", "div_atb", DIV_CPU0, 20, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_ARM_CLK, "div_core2", "div_core", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_copy", "mout_hpm", DIV_CPU1, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_hpm", "div_copy", DIV_CPU1, 4, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV(0, "div_clkout_cpu", "mout_clkout_cpu", CLKOUT_CMU_CPU, 8, 6),
 
 	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
@@ -769,7 +779,8 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
 	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
 	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
-	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
 			CLK_SET_RATE_PARENT, 0),
 	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
@@ -1186,17 +1197,10 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 		0),
 };
 
-static struct samsung_clock_alias exynos4_aliases[] __initdata = {
+static struct samsung_clock_alias exynos4x12_aliases[] __initdata = {
 	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
 	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
 	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
-};
-
-static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
-	ALIAS(CLK_SCLK_MPLL, NULL, "mout_mpll"),
-};
-
-static struct samsung_clock_alias exynos4x12_aliases[] __initdata = {
 	ALIAS(CLK_MOUT_MPLL_USER_C, NULL, "mout_mpll"),
 };
 
@@ -1463,8 +1467,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4210_div_clks));
 		samsung_clk_register_gate(ctx, exynos4210_gate_clks,
 			ARRAY_SIZE(exynos4210_gate_clks));
-		samsung_clk_register_alias(ctx, exynos4210_aliases,
-			ARRAY_SIZE(exynos4210_aliases));
 		samsung_clk_register_fixed_factor(ctx,
 			exynos4210_fixed_factor_clks,
 			ARRAY_SIZE(exynos4210_fixed_factor_clks));
@@ -1486,9 +1488,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4x12_fixed_factor_clks));
 	}
 
-	samsung_clk_register_alias(ctx, exynos4_aliases,
-			ARRAY_SIZE(exynos4_aliases));
-
 	exynos4_core_down_clock(soc);
 	exynos4_clk_sleep_init();
 
@@ -1499,6 +1498,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
 		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
 		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
+		exynos4_soc == EXYNOS4210 ? _get_rate("armclk") :
 		_get_rate("div_core2"));
 }
 
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index e19e365..1d958f1 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -291,14 +291,14 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
-					CLK_SET_RATE_PARENT, 0, "mout_apll"),
-	MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
+	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+			CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, 0, CLK_MUX_READ_ONLY),
 
 	/*
 	 * CMU_CORE
 	 */
-	MUX_A(0, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1, "mout_mpll"),
+	MUX(0, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
 
 	/*
 	 * CMU_TOP
@@ -380,9 +380,12 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV_A(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3, "armclk"),
+	DIV_F(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_arm2", "div_arm", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 
 	/*
 	 * CMU_TOP
@@ -848,6 +851,6 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_of_add_provider(np, ctx);
 
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
-			_get_rate("div_arm2"));
+			_get_rate("armclk"));
 }
 CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock", exynos5250_clk_init);
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index d7ef36a..fcf365d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -617,10 +617,14 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
 	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
 
-	MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
-	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
-	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
-	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
+	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+				CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, 0,
+				CLK_MUX_READ_ONLY),
+	MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
+				CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1, 0,
+				CLK_MUX_READ_ONLY),
 
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
 	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
@@ -776,11 +780,16 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 };
 
 static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
-	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
-	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
-	DIV(0, "div_kfc", "mout_kfc", DIV_KFC0, 0, 3),
-	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
+	DIV_F(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "armclk2", "div_arm", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_kfc", "mout_kfc", DIV_KFC0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 
 	DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
 	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
-- 
1.6.6.rc2

