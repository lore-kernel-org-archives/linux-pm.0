From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 6/8] clk: samsung: exynos542x: Add the clock id for ACLK
Date: Fri, 15 Apr 2016 15:32:53 +0900
Message-ID: <1460701975-24178-7-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40235 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbcDOGdC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2016 02:33:02 -0400
In-reply-to: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: robh@kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
Bus. This clock should be handled in Bus frequency scaling driver.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 77 ++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index be03ed0fcb6b..92382cef9f90 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -554,8 +554,8 @@ static struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
 };
 
 static struct samsung_div_clock exynos5800_div_clks[] __initdata = {
-	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore", DIV_TOP0, 16, 3),
-
+	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
+			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
 	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
 				DIV_TOP8, 16, 3),
 	DIV(0, "dout_aclkfl1_550_cam", "mout_aclkfl1_550_cam",
@@ -607,8 +607,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 };
 
 static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
-	DIV(0, "dout_aclk400_wcore", "mout_aclk400_wcore_bpll",
-			DIV_TOP0, 16, 3),
+	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
+			"mout_aclk400_wcore_bpll", DIV_TOP0, 16, 3),
 };
 
 static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
@@ -785,31 +785,47 @@ static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
 	DIV(0, "div_kfc", "mout_kfc", DIV_KFC0, 0, 3),
 	DIV(0, "sclk_kpll", "mout_kpll", DIV_KFC0, 24, 3),
 
-	DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
-	DIV(0, "dout_aclk400_mscl", "mout_aclk400_mscl", DIV_TOP0, 4, 3),
-	DIV(0, "dout_aclk200", "mout_aclk200", DIV_TOP0, 8, 3),
-	DIV(0, "dout_aclk200_fsys2", "mout_aclk200_fsys2", DIV_TOP0, 12, 3),
-	DIV(0, "dout_aclk100_noc", "mout_aclk100_noc", DIV_TOP0, 20, 3),
-	DIV(0, "dout_pclk200_fsys", "mout_pclk200_fsys", DIV_TOP0, 24, 3),
-	DIV(0, "dout_aclk200_fsys", "mout_aclk200_fsys", DIV_TOP0, 28, 3),
-
-	DIV(0, "dout_aclk333_432_gscl", "mout_aclk333_432_gscl",
-			DIV_TOP1, 0, 3),
-	DIV(0, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
-			DIV_TOP1, 4, 3),
-	DIV(0, "dout_aclk66", "mout_aclk66", DIV_TOP1, 8, 6),
-	DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
-			DIV_TOP1, 16, 3),
-	DIV(0, "dout_aclk266", "mout_aclk266", DIV_TOP1, 20, 3),
-	DIV(0, "dout_aclk166", "mout_aclk166", DIV_TOP1, 24, 3),
-	DIV(0, "dout_aclk333", "mout_aclk333", DIV_TOP1, 28, 3),
-
-	DIV(0, "dout_aclk333_g2d", "mout_aclk333_g2d", DIV_TOP2, 8, 3),
-	DIV(0, "dout_aclk266_g2d", "mout_aclk266_g2d", DIV_TOP2, 12, 3),
-	DIV(0, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2, 16, 3),
-	DIV(0, "dout_aclk300_jpeg", "mout_aclk300_jpeg", DIV_TOP2, 20, 3),
-	DIV(0, "dout_aclk300_disp1", "mout_aclk300_disp1", DIV_TOP2, 24, 3),
-	DIV(0, "dout_aclk300_gscl", "mout_aclk300_gscl", DIV_TOP2, 28, 3),
+	DIV(CLK_DOUT_ACLK400_ISP, "dout_aclk400_isp", "mout_aclk400_isp",
+			DIV_TOP0, 0, 3),
+	DIV(CLK_DOUT_ACLK400_MSCL, "dout_aclk400_mscl", "mout_aclk400_mscl",
+			DIV_TOP0, 4, 3),
+	DIV(CLK_DOUT_ACLK200, "dout_aclk200", "mout_aclk200",
+			DIV_TOP0, 8, 3),
+	DIV(CLK_DOUT_ACLK200_FSYS2, "dout_aclk200_fsys2", "mout_aclk200_fsys2",
+			DIV_TOP0, 12, 3),
+	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
+			DIV_TOP0, 20, 3),
+	DIV(CLK_DOUT_PCLK200_FSYS, "dout_pclk200_fsys", "mout_pclk200_fsys",
+			DIV_TOP0, 24, 3),
+	DIV(CLK_DOUT_ACLK200_FSYS, "dout_aclk200_fsys", "mout_aclk200_fsys",
+			DIV_TOP0, 28, 3),
+	DIV(CLK_DOUT_ACLK333_432_GSCL, "dout_aclk333_432_gscl",
+			"mout_aclk333_432_gscl", DIV_TOP1, 0, 3),
+	DIV(CLK_DOUT_ACLK333_432_ISP, "dout_aclk333_432_isp",
+			"mout_aclk333_432_isp", DIV_TOP1, 4, 3),
+	DIV(CLK_DOUT_ACLK66, "dout_aclk66", "mout_aclk66",
+			DIV_TOP1, 8, 6),
+	DIV(CLK_DOUT_ACLK333_432_ISP0, "dout_aclk333_432_isp0",
+			"mout_aclk333_432_isp0", DIV_TOP1, 16, 3),
+	DIV(CLK_DOUT_ACLK266, "dout_aclk266", "mout_aclk266",
+			DIV_TOP1, 20, 3),
+	DIV(CLK_DOUT_ACLK166, "dout_aclk166", "mout_aclk166",
+			DIV_TOP1, 24, 3),
+	DIV(CLK_DOUT_ACLK333, "dout_aclk333", "mout_aclk333",
+			DIV_TOP1, 28, 3),
+
+	DIV(CLK_DOUT_ACLK333_G2D, "dout_aclk333_g2d", "mout_aclk333_g2d",
+			DIV_TOP2, 8, 3),
+	DIV(CLK_DOUT_ACLK266_G2D, "dout_aclk266_g2d", "mout_aclk266_g2d",
+			DIV_TOP2, 12, 3),
+	DIV(CLK_DOUT_ACLK_G3D, "dout_aclk_g3d", "mout_aclk_g3d", DIV_TOP2,
+			16, 3),
+	DIV(CLK_DOUT_ACLK300_JPEG, "dout_aclk300_jpeg", "mout_aclk300_jpeg",
+			DIV_TOP2, 20, 3),
+	DIV(CLK_DOUT_ACLK300_DISP1, "dout_aclk300_disp1",
+			"mout_aclk300_disp1", DIV_TOP2, 24, 3),
+	DIV(CLK_DOUT_ACLK300_GSCL, "dout_aclk300_gscl", "mout_aclk300_gscl",
+			DIV_TOP2, 28, 3),
 
 	/* DISP1 Block */
 	DIV(0, "dout_fimd1", "mout_fimd1_final", DIV_DISP10, 0, 4),
@@ -817,7 +833,8 @@ static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
 	DIV(0, "dout_dp1", "mout_dp1", DIV_DISP10, 24, 4),
 	DIV(CLK_DOUT_PIXEL, "dout_hdmi_pixel", "mout_pixel", DIV_DISP10, 28, 4),
 	DIV(0, "dout_disp1_blk", "aclk200_disp1", DIV2_RATIO0, 16, 2),
-	DIV(0, "dout_aclk400_disp1", "mout_aclk400_disp1", DIV_TOP2, 4, 3),
+	DIV(CLK_DOUT_ACLK400_DISP1, "dout_aclk400_disp1",
+			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
 
 	/* Audio Block */
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
-- 
1.9.1

