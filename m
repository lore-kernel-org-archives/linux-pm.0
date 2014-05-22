From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH RFC v2 1/7] clk: exynos5250: add aliases for clocks used by devfreq
Date: Thu, 22 May 2014 22:51:56 +0530
Message-ID: <1400779322-4410-2-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51725 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaEVRWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:22:24 -0400
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: kesavan.abhilash@gmail.com

From: Andrew Bresticker <abrestic@chromium.org>

Devfreq does not support DT-based lookup of these peripheral clocks,
so add aliases for them.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 8848859..be2d7d8 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -202,6 +202,11 @@ PNAME(mout_aclk400_p)	= { "mout_aclk400_g3d_mid", "mout_gpll" };
 PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
 PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
 PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
+PNAME(mout_aclk300_disp1_p) = { "mout_aclk300_disp1_mid",
+				"mout_aclk300_disp1_mid1" };
+PNAME(mout_aclk300_gscl_p) = { "mout_aclk300_gscl_mid",
+				"mout_aclk300_gscl_mid1" };
+PNAME(mout_aclk300_gscl_mid1_p) = { "mout_vpll", "mout_cpll" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -278,9 +283,17 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	 */
 	MUX(0, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
 	MUX(0, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
+	MUX(0, "mout_aclk300_disp1_mid", mout_aclk200_p, SRC_TOP0, 14, 1),
+	MUX(0, "mout_aclk300_disp1", mout_aclk300_disp1_p, SRC_TOP0, 15, 1),
 	MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
 	MUX(0, "mout_aclk400_g3d_mid", mout_aclk200_p, SRC_TOP0, 20, 1),
+	MUX(0, "mout_aclk300_gscl_mid", mout_aclk200_p, SRC_TOP0, 24, 1),
+	MUX(0, "mout_aclk300_gscl", mout_aclk300_gscl_p, SRC_TOP0, 25, 2),
 
+	MUX(0, "mout_aclk300_disp1_mid1", mout_aclk300_gscl_mid1_p,
+					SRC_TOP1, 8, 1),
+	MUX(0, "mout_aclk300_gscl_mid1", mout_aclk300_gscl_mid1_p,
+					SRC_TOP1, 12, 1),
 	MUX(0, "mout_aclk400_g3d", mout_aclk400_p, SRC_TOP1, 28, 1),
 
 	MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
@@ -357,13 +370,17 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	 * CMU_TOP
 	 */
 	DIV(0, "div_aclk66", "div_aclk66_pre", DIV_TOP0, 0, 3),
-	DIV(0, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3),
-	DIV(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
-	DIV(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
-	DIV(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
+	DIV_A(0, "div_aclk166", "mout_aclk166", DIV_TOP0, 8, 3, "aclk166_d"),
+	DIV_A(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3, "aclk200_d"),
+	DIV_A(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3, "aclk266_d"),
+	DIV_A(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3, "aclk333_d"),
 	DIV(0, "div_aclk400_g3d", "mout_aclk400_g3d", DIV_TOP0,
 							24, 3),
+	DIV_A(0, "div_aclk300_disp1", "mout_aclk300_disp1",
+					DIV_TOP0, 28, 3, "aclk300_disp1_d"),
 
+	DIV_A(0, "div_aclk300_gscl", "mout_aclk300_gscl",
+					DIV_TOP1, 12, 3, "aclk300_gscl_d"),
 	DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
 
 	DIV(0, "div_cam_bayer", "mout_cam_bayer", DIV_GSCL, 12, 4),
-- 
1.7.9.5

