From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v7 3/6] clk: exynos: use cpu-clock provider type to represent arm clock
Date: Mon, 14 Jul 2014 19:08:35 +0530
Message-ID: <1405345118-4269-4-git-send-email-thomas.ab@samsung.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53833 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbaGNNjM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 09:39:12 -0400
In-Reply-To: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com

From: Thomas Abraham <thomas.ab@samsung.com>

Register cpu clocks using the new cpu-clock provider type for exynos platforms.
The differnt clock blocks that are now encapsulated within the cpu-clock can be
marked with read-only attribute.

Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Tested-by: Arjun K.V <arjun.kv@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c      |   25 +++++++++++++++++--------
 drivers/clk/samsung/clk-exynos5250.c   |   16 +++++++++++-----
 drivers/clk/samsung/clk-exynos5420.c   |   32 +++++++++++++++++++++++---------
 include/dt-bindings/clock/exynos5250.h |    1 +
 include/dt-bindings/clock/exynos5420.h |    2 ++
 5 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 75573a4..10f1818 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -471,7 +471,8 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
 	MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
 	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1, 0,
+			CLK_MUX_READ_ONLY),
 	MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
 	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
 	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
@@ -530,7 +531,8 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(0, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
 	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_DMC, 12, 1),
 	MUX(CLK_SCLK_VPLL, "sclk_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
-	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
+	MUX_F(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1, 0,
+			CLK_MUX_READ_ONLY),
 	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
 	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
 	MUX(CLK_MOUT_FIMC2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
@@ -572,8 +574,10 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 
 /* list of divider clocks supported in all exynos4 soc's */
 static struct samsung_div_clock exynos4_div_clks[] __initdata = {
-	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
-	DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),
+	DIV_F(0, "div_core", "mout_core", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(0, "div_core2", "div_core", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
 	DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
 	DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
@@ -619,8 +623,10 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
 	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
 	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
-	DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
-	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
+	DIV_F(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
 			CLK_SET_RATE_PARENT, 0),
 	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
@@ -1016,7 +1022,6 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 
 static struct samsung_clock_alias exynos4_aliases[] __initdata = {
 	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
-	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
 	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
 };
 
@@ -1255,6 +1260,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4210_gate_clks));
 		samsung_clk_register_alias(ctx, exynos4210_aliases,
 			ARRAY_SIZE(exynos4210_aliases));
+		exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk",
+			mout_core_p4210[0], mout_core_p4210[1], np);
 	} else {
 		samsung_clk_register_mux(ctx, exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
@@ -1264,6 +1271,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4x12_gate_clks));
 		samsung_clk_register_alias(ctx, exynos4x12_aliases,
 			ARRAY_SIZE(exynos4x12_aliases));
+		exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk",
+			mout_core_p4x12[0], mout_core_p4x12[1], np);
 	}
 
 	samsung_clk_register_alias(ctx, exynos4_aliases,
@@ -1278,7 +1287,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
 		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
 		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
-		_get_rate("arm_clk"));
+		_get_rate("armclk"));
 }
 
 
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 5861183..2f78bb0 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -292,7 +292,8 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	 */
 	MUX_FA(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 					CLK_SET_RATE_PARENT, 0, "mout_apll"),
-	MUX_A(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
+	MUX_FA(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1,
+			0, CLK_MUX_READ_ONLY, "mout_cpu"),
 
 	/*
 	 * CMU_CORE
@@ -379,9 +380,12 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
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
@@ -797,6 +801,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_div_clks));
 	samsung_clk_register_gate(ctx, exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
+	exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk", mout_cpu_p[0],
+			mout_cpu_p[1], np);
 
 	/*
 	 * Enable arm clock down (in idle) and set arm divider
@@ -823,6 +829,6 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_of_add_provider(np, ctx);
 
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
-			_get_rate("div_arm2"));
+			_get_rate("armclk"));
 }
 CLK_OF_DECLARE(exynos5250_clk, "samsung,exynos5250-clock", exynos5250_clk_init);
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 95f83be..6103e01 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -587,10 +587,14 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
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
@@ -746,11 +750,16 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
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
@@ -1280,6 +1289,11 @@ static void __init exynos5x_clk_init(struct device_node *np,
 				ARRAY_SIZE(exynos5800_gate_clks));
 	}
 
+	exynos_register_cpu_clock(ctx, 0, CLK_ARM_CLK, "armclk",
+		mout_cpu_p[0], mout_cpu_p[1], np);
+	exynos_register_cpu_clock(ctx, 1, CLK_KFC_CLK, "kfcclk",
+		mout_kfc_p[0], mout_kfc_p[1], np);
+
 	exynos5420_clk_sleep_init();
 
 	samsung_clk_of_add_provider(np, ctx);
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index be6e97c..d3565be 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -21,6 +21,7 @@
 #define CLK_FOUT_CPLL		6
 #define CLK_FOUT_EPLL		7
 #define CLK_FOUT_VPLL		8
+#define CLK_ARM_CLK		12
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_CAM_BAYER	128
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 21d51ae..6fce074 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -25,6 +25,8 @@
 #define CLK_FOUT_MPLL		10
 #define CLK_FOUT_BPLL		11
 #define CLK_FOUT_KPLL		12
+#define CLK_ARM_CLK		13
+#define CLK_KFC_CLK		14
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_UART0		128
-- 
1.7.9.5

