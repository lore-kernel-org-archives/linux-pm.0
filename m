From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 2/7] clk: exynos5420: Add aliases for clocks used by devfreq
Date: Wed, 16 Jul 2014 00:04:12 +0530
Message-ID: <1405449252-26226-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-3-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42141 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbaGOSe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:34:26 -0400
In-Reply-To: <1400779322-4410-3-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

From: "Arjun.K.V" <arjun.kv@samsung.com>

Devfreq does not support DT-based lookup of these peripheral clocks,
so add aliases for them.

Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   73 ++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index a4e6cc7..10f2287 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -554,21 +554,25 @@ struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
 	MUX_A(0, "mout_aclk400_mscl", mout_group1_p,
 				SRC_TOP0, 4, 2, "aclk400_mscl"),
-	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
-	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
-
+	MUX_A(0, "mout_aclk400_wcore", mout_group1_p,
+				SRC_TOP0, 16, 2, "aclk400_wcore"),
+	MUX_A(0, "mout_aclk100_noc", mout_group1_p,
+				SRC_TOP0, 20, 2, "aclk100_noc"),
 	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
 	MUX(0, "mout_aclk333_432_isp", mout_group4_p,
 				SRC_TOP1, 4, 2),
 	MUX(0, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
-	MUX(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2),
+	MUX_A(0, "mout_aclk266", mout_group1_p, SRC_TOP1, 20, 2, "aclk266"),
 	MUX(0, "mout_aclk333", mout_group1_p, SRC_TOP1, 28, 2),
 
-	MUX(0, "mout_aclk400_disp1", mout_group1_p, SRC_TOP2, 4, 2),
+	MUX_A(0, "mout_aclk400_disp1", mout_group1_p,
+				SRC_TOP2, 4, 2, "aclk400_disp1"),
 	MUX(0, "mout_aclk333_g2d", mout_group1_p, SRC_TOP2, 8, 2),
 	MUX(0, "mout_aclk266_g2d", mout_group1_p, SRC_TOP2, 12, 2),
-	MUX(0, "mout_aclk300_jpeg", mout_group1_p, SRC_TOP2, 20, 2),
-	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
+	MUX_A(0, "mout_aclk300_jpeg", mout_group1_p,
+				SRC_TOP2, 20, 2, "aclk300_jpeg"),
+	MUX_A(0, "mout_aclk300_disp1", mout_group1_p,
+				SRC_TOP2, 24, 2, "aclk300_disp1"),
 	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
 
 	MUX(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2),
@@ -577,8 +581,8 @@ struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 };
 
 struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
-			DIV_TOP0, 16, 3),
+	DIV_A(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
+			DIV_TOP0, 16, 3, "aclk400_wcore_d"),
 };
 
 static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
@@ -593,12 +597,15 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
-	MUX(0, "mout_aclk200_fsys2", mout_group1_p, SRC_TOP0, 12, 2),
-	MUX(0, "mout_pclk200_fsys", mout_group1_p, SRC_TOP0, 24, 2),
-	MUX(0, "mout_aclk200_fsys", mout_group1_p, SRC_TOP0, 28, 2),
+	MUX_A(0, "mout_aclk200_fsys2", mout_group1_p,
+		SRC_TOP0, 12, 2, "aclk200_fsys2"),
+	MUX_A(0, "mout_pclk200_fsys", mout_group1_p,
+		SRC_TOP0, 24, 2, "pclk200_fsys"),
+	MUX_A(0, "mout_aclk200_fsys", mout_group1_p,
+		SRC_TOP0, 28, 2, "aclk200_fsys"),
 
-	MUX(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2),
-	MUX(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2),
+	MUX_A(0, "mout_aclk66", mout_group1_p, SRC_TOP1, 8, 2, "aclk66"),
+	MUX_A(0, "mout_aclk166", mout_group1_p, SRC_TOP1, 24, 2, "aclk166"),
 
 	MUX(0, "mout_aclk_g3d", mout_group5_p, SRC_TOP2, 16, 1),
 
@@ -651,14 +658,14 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_user_aclk300_gscl", mout_user_aclk300_gscl_p,
 			SRC_TOP5, 28, 1),
 
-	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX_A(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1, "mout_mpll"),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
 	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
-	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
+	MUX_A(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1, "mout_ipll"),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX(0, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1),
-	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
-	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
+	MUX_A(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1, "mout_dpll"),
+	MUX_A(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1, "mout_cpll"),
 
 	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
 			SRC_TOP10, 0, 1),
@@ -753,29 +760,36 @@ static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
 	DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
-	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
+	DIV_A(0, "dout_aclk400_mscl", "mout_aclk400_mscl",
+			DIV_TOP0, 4, 3, "aclk400_mscl_d"),
 	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
-	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
-	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
-	DIV(0, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
-	DIV(0, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
+	DIV_A(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2",
+			DIV_TOP0, 12, 3, "aclk200_fsys2_d"),
+	DIV_A(0, "dout_aclk100_noc", "mout_aclk100_noc",
+			DIV_TOP0, 20, 3, "aclk100_noc_d"),
+	DIV_A(0, "dout_pclk200_fsys", "mout_pclk200_fsys",
+			DIV_TOP0, 24, 3, "pclk200_fsys_d"),
+	DIV_A(0, "dout_aclk200_fsys", "mout_aclk200_fsys",
+			DIV_TOP0, 28, 3, "aclk200_fsys_d"),
 
 	DIV(0, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
 			DIV_TOP1, 0, 3),
 	DIV(0, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
 			DIV_TOP1, 4, 3),
-	DIV(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
+	DIV_A(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6, "aclk66_d"),
 	DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
 			DIV_TOP1, 16, 3),
-	DIV(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
-	DIV(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
+	DIV_A(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3, "aclk266_d"),
+	DIV_A(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3, "aclk166_d"),
 	DIV(0, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
 
 	DIV(0, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
 	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
 	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
-	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV(0, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
+	DIV_A(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg",
+			DIV_TOP2, 20, 3, "aclk300_jpeg_d"),
+	DIV_A(0, "dout_aclk300_disp1", "mout_aclk300_disp1",
+			DIV_TOP2, 24, 3, "aclk300_disp1_d"),
 	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
@@ -784,7 +798,8 @@ static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
 	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
 	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
 	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
-	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1", DIV_TOP2, 4, 3),
+	DIV_A(0, "dout_aclk400_disp1", "mout_aclk400_disp1",
+			DIV_TOP2, 4, 3, "aclk400_disp1_d"),
 
 	/* Audio Block */
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-- 
1.7.9.5

