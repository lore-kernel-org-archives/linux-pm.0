From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 1/4] clk: samsung: exynos3250: Add cpu clock configuration
 data and instaniate cpu clock
Date: Thu, 25 Sep 2014 16:05:04 +0900
Message-ID: <1411628707-8496-2-git-send-email-cw00.choi@samsung.com>
References: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, kyungmin.park@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add CPU clock configuration data and instantiate the CPU clock type
for Exynos3250 to support Samsung specific cpu-clock type.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/clk/samsung/clk-cpu.h        |  4 ++++
 drivers/clk/samsung/clk-exynos3250.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 42e1905..1ba31eb 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -13,6 +13,10 @@
 
 #include "clk.h"
 
+#define E3250_CPU_DIV0(apll, pclk_dbg, atb, corem)			\
+		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		((corem) << 4))
+
 #define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
 		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
 		((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 6e6cca3..aa55218 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -19,6 +19,7 @@
 #include <dt-bindings/clock/exynos3250.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 #include "clk-pll.h"
 
 #define SRC_LEFTBUS		0x4200
@@ -793,6 +794,20 @@ static struct samsung_pll_clock exynos3250_plls[nr_plls] __initdata = {
 			UPLL_LOCK, UPLL_CON0, NULL),
 };
 
+static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
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
 static void __init exynos3_core_down_clock(void)
 {
 	unsigned int tmp;
@@ -840,6 +855,10 @@ static void __init exynos3250_cmu_init(struct device_node *np)
 	samsung_clk_register_mux(ctx, mux_clks, ARRAY_SIZE(mux_clks));
 	samsung_clk_register_div(ctx, div_clks, ARRAY_SIZE(div_clks));
 	samsung_clk_register_gate(ctx, gate_clks, ARRAY_SIZE(gate_clks));
+	exynos_register_cpu_clock(ctx, CLK_DIV_CORE2, "armclk",
+			mout_core_p[0], mout_core_p[1], 0x14200,
+			e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
+			CLK_CPU_HAS_DIV1);
 
 	exynos3_core_down_clock();
 
-- 
1.8.0
