From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv4 1/4] clk: samsung: exynos3250: Add cpu clock configuration
 data and instaniate cpu clock
Date: Mon, 20 Oct 2014 21:08:39 +0900
Message-ID: <1413806922-22722-2-git-send-email-cw00.choi@samsung.com>
References: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61630 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaJTMIt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 08:08:49 -0400
In-reply-to: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, tomasz.figa@gmail.com
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, kyungmin.park@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>

This patch add CPU clock configuration data and instantiate the CPU clock type
for Exynos3250 to support Samsung specific cpu-clock type.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
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

