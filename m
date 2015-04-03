From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/6] clk: samsung: exynos4: add cpu clock configuration data
 and instantiate cpu clock
Date: Fri, 03 Apr 2015 18:43:46 +0200
Message-ID: <1428079429-4252-4-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

With the addition of the new Samsung specific cpu-clock type, the
arm clock can be represented as a cpu-clock type. Add the CPU clock
configuration data and instantiate the CPU clock type for Exynos4210.

Changes by Bartlomiej:
- fixed issue with wrong dividers being setup by Common Clock Framework
  (by an addition of CLK_RECALC_NEW_RATES clock flag to mout_apll clock,
  without this change cpufreq-dt driver showed ~10 mA larger energy
  consumption when compared to cpufreq-exynos one when "performance"
  cpufreq governor was used on Exynos4210 SoC based Origen board), this
  was probably meant to be workarounded by use of CLK_GET_RATE_NOCACHE
  and CLK_DIVIDER_READ_ONLY clock flags in the original patchset (in
  "[PATCH v12 6/6] clk: samsung: remove unused clock aliases and update
  clock flags") but using these flags is not sufficient to fix the issue
  observed
- removed Exynos5250 and Exynos5420 support for now

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 714d6ba..cae2c048 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -19,6 +19,7 @@
 #include <linux/syscore_ops.h>
 
 #include "clk.h"
+#include "clk-cpu.h"
 
 /* Exynos4 clock controller register offsets */
 #define SRC_LEFTBUS		0x4200
@@ -534,7 +535,8 @@ static struct samsung_fixed_factor_clock exynos4x12_fixed_factor_clks[] __initda
 /* list of mux clocks supported in all exynos4 soc's */
 static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX_FA(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
-			CLK_SET_RATE_PARENT, 0, "mout_apll"),
+			CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0,
+			"mout_apll"),
 	MUX(CLK_MOUT_HDMI, "mout_hdmi", mout_hdmi_p, SRC_TV, 0, 1),
 	MUX(0, "mout_mfc1", sclk_evpll_p, SRC_MFC, 4, 1),
 	MUX(0, "mout_mfc", mout_mfc_p, SRC_MFC, 8, 1),
@@ -1378,6 +1380,22 @@ static void __init exynos4x12_core_down_clock(void)
 	__raw_writel(0x0, reg_base + E4X12_PWR_CTRL2);
 }
 
+#define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
+		(((apll) << 24) | ((pclk_dbg) << 20) | ((atb) << 16) |	\
+		((periph) << 12) | ((corem1) << 8) | ((corem0) <<  4))
+#define E4210_CPU_DIV1(hpm, copy)					\
+		(((hpm) << 4) | ((copy) << 0))
+
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
 /* register exynos4 clocks */
 static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc soc)
@@ -1455,6 +1473,10 @@ static void __init exynos4_clk_init(struct device_node *np,
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
-- 
1.7.9.5
