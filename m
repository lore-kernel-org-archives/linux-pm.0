From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 2/4] clk: samsung: exynos3250: Update clock flags related to
 CPU to use cpu-clock type
Date: Thu, 25 Sep 2014 16:05:05 +0900
Message-ID: <1411628707-8496-3-git-send-email-cw00.choi@samsung.com>
References: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50367 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaIYHFU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 03:05:20 -0400
In-reply-to: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, kyungmin.park@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>

This patch update clock flags related to CPU with read only flag
to use cpu-clock type.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index aa55218..21e70ed 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -378,8 +378,10 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
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
@@ -467,16 +469,24 @@ static struct samsung_div_clock div_clks[] __initdata = {
 	DIV(CLK_DIV_I2S, "div_i2s", "div_audio", DIV_PERIL5, 8, 6),
 
 	/* DIV_CPU0 */
-	DIV(CLK_DIV_CORE2, "div_core2", "div_core", DIV_CPU0, 28, 3),
-	DIV(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3),
-	DIV(CLK_DIV_PCLK_DBG, "div_pclk_dbg", "div_core2", DIV_CPU0, 20, 3),
-	DIV(CLK_DIV_ATB, "div_atb", "div_core2", DIV_CPU0, 16, 3),
-	DIV(CLK_DIV_COREM, "div_corem", "div_core2", DIV_CPU0, 4, 3),
-	DIV(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3),
+	DIV_F(CLK_DIV_CORE2, "div_core2", "div_core", DIV_CPU0, 28, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_APLL, "div_apll", "mout_apll", DIV_CPU0, 24, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_PCLK_DBG, "div_pclk_dbg", "div_core2", DIV_CPU0, 20, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_ATB, "div_atb", "div_core2", DIV_CPU0, 16, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_COREM, "div_corem", "div_core2", DIV_CPU0, 4, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_CORE, "div_core", "mout_core", DIV_CPU0, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 
 	/* DIV_CPU1 */
-	DIV(CLK_DIV_HPM, "div_hpm", "div_copy", DIV_CPU1, 4, 3),
-	DIV(CLK_DIV_COPY, "div_copy", "mout_hpm", DIV_CPU1, 0, 3),
+	DIV_F(CLK_DIV_HPM, "div_hpm", "div_copy", DIV_CPU1, 4, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
+	DIV_F(CLK_DIV_COPY, "div_copy", "mout_hpm", DIV_CPU1, 0, 3,
+			CLK_GET_RATE_NOCACHE, CLK_DIVIDER_READ_ONLY),
 };
 
 static struct samsung_gate_clock gate_clks[] __initdata = {
-- 
1.8.0

