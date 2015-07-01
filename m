From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 1/4] clk: samsung: exynos5250: add cpu clock configuration
 data and instantiate cpu clock
Date: Wed, 01 Jul 2015 15:10:35 +0200
Message-ID: <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

With the addition of the new Samsung specific cpu-clock type, the
arm clock can be represented as a cpu-clock type. Add the CPU clock
configuration data and instantiate the CPU clock type for Exynos5250.

Changes by Bartlomiej:
- split Exynos5250 support from the original patch
- moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c   | 31 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5250.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 70ec3d2..d87f34d 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -19,6 +19,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 #define APLL_LOCK		0x0
 #define APLL_CON0		0x100
@@ -748,6 +749,32 @@ static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
+#define E5250_CPU_DIV0(apll, pclk_dbg, atb, periph, acp, cpud)		\
+		((((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		 ((periph) << 12) | ((acp) << 8) | ((cpud) << 4)))
+#define E5250_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | (copy))
+
+static const struct exynos_cpuclk_cfg_data exynos5250_armclk_d[] __initconst = {
+	{ 1700000, E5250_CPU_DIV0(5, 3, 7, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1600000, E5250_CPU_DIV0(4, 1, 7, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1500000, E5250_CPU_DIV0(4, 1, 7, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1400000, E5250_CPU_DIV0(4, 1, 6, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1300000, E5250_CPU_DIV0(3, 1, 6, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1200000, E5250_CPU_DIV0(3, 1, 5, 7, 7, 2), E5250_CPU_DIV1(2, 0), },
+	{ 1100000, E5250_CPU_DIV0(3, 1, 5, 7, 7, 3), E5250_CPU_DIV1(2, 0), },
+	{ 1000000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  900000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  800000, E5250_CPU_DIV0(2, 1, 4, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  700000, E5250_CPU_DIV0(1, 1, 3, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  600000, E5250_CPU_DIV0(1, 1, 3, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  500000, E5250_CPU_DIV0(1, 1, 2, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  400000, E5250_CPU_DIV0(1, 1, 2, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  300000, E5250_CPU_DIV0(1, 1, 1, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  200000, E5250_CPU_DIV0(1, 1, 1, 7, 7, 1), E5250_CPU_DIV1(2, 0), },
+	{  0 },
+};
+
 static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
@@ -797,6 +824,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_div_clks));
 	samsung_clk_register_gate(ctx, exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
+	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			exynos5250_armclk_d, ARRAY_SIZE(exynos5250_armclk_d),
+			CLK_CPU_HAS_DIV1);
 
 	/*
 	 * Enable arm clock down (in idle) and set arm divider
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 4273891d..8183d1c 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -21,6 +21,7 @@
 #define CLK_FOUT_CPLL		6
 #define CLK_FOUT_EPLL		7
 #define CLK_FOUT_VPLL		8
+#define CLK_ARM_CLK		9
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_CAM_BAYER	128
-- 
1.9.1
