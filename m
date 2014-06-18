From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 1/3] clk: samsung: cpu: Add support for cpu clocks of
 Exynos3250
Date: Wed, 18 Jun 2014 17:40:00 +0900
Message-ID: <1403080802-2794-2-git-send-email-cw00.choi@samsung.com>
References: <1403080802-2794-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1403080802-2794-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: t.figa@samsung.com, kgene.kim@samsung.com, thomas.ab@samsung.com, viresh.kumar@linaro.org, mturquette@linaro.org, shawn.guo@linaro.org
Cc: kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch add support for a new clock type for Exynos3250 CPU clock provider
and modify little difference of DIV_CPU0 between Exynos4 and Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index c40f7b5..0d5a4d6 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -31,6 +31,10 @@
 #define E4210_DIV0_ATB_SHIFT	16
 #define E4210_DIV0_ATB_MASK	(DIV_MASK << E4210_DIV0_ATB_SHIFT)
 
+#define E3250_CPU_DIV0(apll, pclk_dbg, atb, corem)			\
+		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		((corem) <<  4))
+
 #define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
 		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
 		((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
@@ -50,6 +54,7 @@
 		(((kpll << 24) | (pclk << 20) | (aclk << 4)))
 
 enum cpuclk_type {
+	EXYNOS3250,
 	EXYNOS4210,
 	EXYNOS5250,
 	EXYNOS5420,
@@ -426,6 +431,20 @@ static int exynos4210_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	return 0;
 }
 
+static const struct exynos4210_cpuclk_data e3250_armclk_d[] __initconst = {
+	{ 1000000, E3250_CPU_DIV0(1, 7, 4, 1), E4210_CPU_DIV1(7, 7), },
+	{  900000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  800000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  700000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  600000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  500000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  400000, E3250_CPU_DIV0(1, 7, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  300000, E3250_CPU_DIV0(1, 5, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  200000, E3250_CPU_DIV0(1, 3, 3, 1), E4210_CPU_DIV1(7, 7), },
+	{  100000, E3250_CPU_DIV0(1, 1, 1, 1), E4210_CPU_DIV1(7, 7), },
+	{  0 },
+};
+
 static const struct exynos4210_cpuclk_data e4210_armclk_d[] __initconst = {
 	{ 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
 	{ 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
@@ -493,6 +512,16 @@ static const struct exynos4210_cpuclk_data e5420_kfcclk_d[] __initconst = {
 	{  0 },
 };
 
+static const struct exynos_cpuclk_soc_data e3250_clk_soc_data __initconst = {
+	.ops = &exynos_cpuclk_clk_ops,
+	.offset = 0x14200,
+	.data = e3250_armclk_d,
+	.data_size = sizeof(e3250_armclk_d),
+	.type = EXYNOS3250,
+	.pre_rate_cb = exynos4210_cpuclk_pre_rate_change,
+	.post_rate_cb = exynos4210_cpuclk_post_rate_change,
+};
+
 static const struct exynos_cpuclk_soc_data e4210_clk_soc_data __initconst = {
 	.ops = &exynos_cpuclk_clk_ops,
 	.offset = 0x14200,
@@ -536,6 +565,8 @@ static const struct exynos_cpuclk_soc_data e5420_clk_soc_data[] __initconst = {
 };
 
 static const struct of_device_id exynos_cpuclk_ids[] __initconst = {
+	{ .compatible = "samsung,exynos3250-cmu",
+			.data = &e3250_clk_soc_data, },
 	{ .compatible = "samsung,exynos4210-clock",
 			.data = &e4210_clk_soc_data, },
 	{ .compatible = "samsung,exynos5250-clock",
-- 
1.8.0
