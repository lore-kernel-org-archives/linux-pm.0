From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] clk: samsung: exynos4412: add cpu clock configuration data
 for Exynos4412 Prime
Date: Thu, 29 Dec 2016 14:36:50 +0100
Message-ID: <1483018611-27998-2-git-send-email-b.zolnierkie@samsung.com>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161229133728epcas5p1e7d700c4404684f9574e2251d836061c@epcas5p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add cpu clock configuration data for Exynos4412 Prime SoC
(it supports additional PLL rates & CPU frequencies).

Based on Hardkernel's kernel for ODROID-X2/U2/U3 boards.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index faab9b3..e40b775 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1298,6 +1298,8 @@ static void __init exynos4_clk_register_finpll(struct samsung_clk_provider *ctx)
 };
 
 static const struct samsung_pll_rate_table exynos4x12_apll_rates[] __initconst = {
+	PLL_35XX_RATE(1704000000, 213, 3, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
 	PLL_35XX_RATE(1500000000, 250, 4, 0),
 	PLL_35XX_RATE(1400000000, 175, 3, 0),
 	PLL_35XX_RATE(1300000000, 325, 6, 0),
@@ -1421,6 +1423,8 @@ static void __init exynos4x12_core_down_clock(void)
 		(((cores) << 8) | ((hpm) << 4) | ((copy) << 0))
 
 static const struct exynos_cpuclk_cfg_data e4412_armclk_d[] __initconst = {
+	{ 1704000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(7, 0, 7), },
+	{ 1600000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(7, 0, 6), },
 	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(7, 0, 6), },
 	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4412_CPU_DIV1(6, 0, 6), },
 	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4412_CPU_DIV1(6, 0, 5), },
-- 
1.9.1
