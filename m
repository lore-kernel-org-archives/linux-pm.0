From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v12 2/6] clk: samsung: add cpu clock configuration data and
 instantiate cpu clock
Date: Fri, 21 Nov 2014 19:01:18 +0530
Message-ID: <1416576682-5255-3-git-send-email-thomas.ab@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-2-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576682-5255-2-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

With the addition of the new Samsung specific cpu-clock type, the
arm clock can be represented as a cpu-clock type. Add the CPU clock
configuration data and instantiate the CPU clock type for Exynos4210,
Exynos5250 and Exynos5420.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c      |   15 ++++++++++
 drivers/clk/samsung/clk-exynos5250.c   |   25 +++++++++++++++++
 drivers/clk/samsung/clk-exynos5420.c   |   45 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5250.h |    1 +
 include/dt-bindings/clock/exynos5420.h |    2 +
 5 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 940f028..9af5767 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -19,6 +19,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 /* Exynos4 clock controller register offsets */
 #define SRC_LEFTBUS		0x4200
@@ -1354,6 +1355,16 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 			VPLL_LOCK, VPLL_CON0, NULL),
 };
 
+static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
+	{ 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
+	{ 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
+	{  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
+	{  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
+	{  0 },
+};
+
 static void __init exynos4_core_down_clock(enum exynos4_soc soc)
 {
 	unsigned int tmp;
@@ -1457,6 +1468,10 @@ static void __init exynos4_clk_init(struct device_node *np,
 		samsung_clk_register_fixed_factor(ctx,
 			exynos4210_fixed_factor_clks,
 			ARRAY_SIZE(exynos4210_fixed_factor_clks));
+		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_core_p4210[0], mout_core_p4210[1], 0x14200,
+			e4210_armclk_d, ARRAY_SIZE(e4210_armclk_d),
+			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
 	} else {
 		samsung_clk_register_mux(ctx, exynos4x12_mux_clks,
 			ARRAY_SIZE(exynos4x12_mux_clks));
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 70ec3d2..e19e365 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -19,6 +19,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 #define APLL_LOCK		0x0
 #define APLL_CON0		0x100
@@ -748,6 +749,26 @@ static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
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
@@ -797,6 +818,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_div_clks));
 	samsung_clk_register_gate(ctx, exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
+	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			exynos5250_armclk_d, ARRAY_SIZE(exynos5250_armclk_d),
+			CLK_CPU_HAS_DIV1);
 
 	/*
 	 * Enable arm clock down (in idle) and set arm divider
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 848d602..d7ef36a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -19,6 +19,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 #define APLL_LOCK		0x0
 #define APLL_CON0		0x100
@@ -1245,6 +1246,43 @@ static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 		KPLL_CON0, NULL),
 };
 
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
@@ -1309,6 +1347,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
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
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 4273891..8183d1c 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -21,6 +21,7 @@
 #define CLK_FOUT_CPLL		6
 #define CLK_FOUT_EPLL		7
 #define CLK_FOUT_VPLL		8
+#define CLK_ARM_CLK		9
 
 /* gate for special clocks (sclk) */
 #define CLK_SCLK_CAM_BAYER	128
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 8dc0913..ec0af64 100644
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
1.6.6.rc2
