From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 2/7] clk: samsung: exynos5420: add cpu clock configuration
 data and instantiate cpu clock
Date: Tue, 15 Dec 2015 18:33:16 +0100
Message-ID: <1450200801-24539-3-git-send-email-b.zolnierkie@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

With the addition of the new Samsung specific cpu-clock type, the
arm clock can be represented as a cpu-clock type. Add the CPU clock
configuration data and instantiate the CPU clock type for Exynos5420.

Changes by Bartlomiej:
- split Exynos5420 support from the original patches
- moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   | 58 ++++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/exynos5420.h |  2 ++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 389af3c..2a92546 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -18,6 +18,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 #define APLL_LOCK		0x0
 #define APLL_CON0		0x100
@@ -616,9 +617,11 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
 	MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
 
-	MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
+	MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
-	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
+	MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
+	      CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
 	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
 	MUX(0, "mout_aclk200", mout_group1_p, SRC_TOP0, 8, 2),
@@ -1246,6 +1249,50 @@ static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 		KPLL_CON0, NULL),
 };
 
+#define E5420_EGL_DIV0(apll, pclk_dbg, atb, cpud)			\
+		((((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		 ((cpud) << 4)))
+
+static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[] __initconst = {
+	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
+	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
+	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
+	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
+	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
+	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
+	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
+	{  0 },
+};
+
+#define E5420_KFC_DIV(kpll, pclk, aclk)					\
+		((((kpll) << 24) | ((pclk) << 20) | ((aclk) << 4)))
+
+static const struct exynos_cpuclk_cfg_data exynos5420_kfcclk_d[] __initconst = {
+	{ 1300000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1200000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1100000, E5420_KFC_DIV(3, 5, 2), },
+	{ 1000000, E5420_KFC_DIV(3, 5, 2), },
+	{  900000, E5420_KFC_DIV(3, 5, 2), },
+	{  800000, E5420_KFC_DIV(3, 5, 2), },
+	{  700000, E5420_KFC_DIV(3, 4, 2), },
+	{  600000, E5420_KFC_DIV(3, 4, 2), },
+	{  500000, E5420_KFC_DIV(3, 4, 2), },
+	{  400000, E5420_KFC_DIV(3, 3, 2), },
+	{  300000, E5420_KFC_DIV(3, 3, 2), },
+	{  200000, E5420_KFC_DIV(3, 3, 2), },
+	{  0 },
+};
+
 static const struct of_device_id ext_clk_match[] __initconst = {
 	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
 	{ },
@@ -1310,6 +1357,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
 				ARRAY_SIZE(exynos5800_gate_clks));
 	}
 
+	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+		mout_cpu_p[0], mout_cpu_p[1], 0x200,
+		exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
+	exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
+		mout_kfc_p[0], mout_kfc_p[1], 0x28200,
+		exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0);
+
 	exynos5420_clk_sleep_init();
 
 	samsung_clk_of_add_provider(np, ctx);
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 99da0d1..dde9664 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -25,6 +25,8 @@
 #define CLK_FOUT_MPLL		10
 #define CLK_FOUT_BPLL		11
 #define CLK_FOUT_KPLL		12
+#define CLK_ARM_CLK		13
+#define CLK_KFC_CLK		14
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_UART0		128
-- 
1.9.1
