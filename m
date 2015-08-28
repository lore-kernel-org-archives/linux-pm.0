From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] clk: samsung: fix cpu clock's flags checking
Date: Fri, 28 Aug 2015 13:49:35 +0200
Message-ID: <1440762575-21520-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
incorrectly used as a bit numbers.  Fix it.

Tested on Exynos4210 based Origen board and on Exynos5250 based
Arndale board.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Fixes: ddeac8d96 ("clk: samsung: add infrastructure to register cpu clocks")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- added Reviewed-by, Acked-by and Fixes tags (no code changes)

Michael, please apply.  Thank you.

 drivers/clk/samsung/clk-cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 7c1e1f5..2fe37f7 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -164,7 +164,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 * the values for DIV_COPY and DIV_HPM dividers need not be set.
 	 */
 	div0 = cfg_data->div0;
-	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		div1 = cfg_data->div1;
 		if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK)
 			div1 = readl(base + E4210_DIV_CPU1) &
@@ -185,7 +185,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
 		WARN_ON(alt_div >= MAX_DIV);
 
-		if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+		if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 			/*
 			 * In Exynos4210, ATB clock parent is also mout_core. So
 			 * ATB clock also needs to be mantained at safe speed.
@@ -206,7 +206,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	writel(div0, base + E4210_DIV_CPU0);
 	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, DIV_MASK_ALL);
 
-	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		writel(div1, base + E4210_DIV_CPU1);
 		wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
 				DIV_MASK_ALL);
@@ -225,7 +225,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	unsigned long mux_reg;
 
 	/* find out the divider values to use for clock data */
-	if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		while ((cfg_data->prate * 1000) != ndata->new_rate) {
 			if (cfg_data->prate == 0)
 				return -EINVAL;
@@ -240,7 +240,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
 	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
 
-	if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
 		div_mask |= E4210_DIV0_ATB_MASK;
 	}
-- 
1.9.1
