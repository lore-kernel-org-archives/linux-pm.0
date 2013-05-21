From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: implement CPU clock scaling
 for CPUFreq
Date: Tue, 21 May 2013 16:07:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305211601180.2863@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Simon Horman <horms@verge.net.au>
List-Id: linux-pm@vger.kernel.org

This patch adds support for the Z-clock on r8a7790 SoCs, which is driving
the Cortex A15 core, and a "cpufreq-cpu0" platform device. Adding an
"operating-points" property to the CPU0 DT node and a regulator, this
patch allows platforms to use the generic cpufreq-cpu0 driver to use
SoC's DVFS capabilities.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2:
1. a typo in the r8a7790 datasheet confused me to implement kick-bit 
handling wrongly, this is fixed in this version
2. patch 3 merged with this one

Same comments, as to v1 of this series, apply.

 arch/arm/mach-shmobile/Kconfig         |    2 +
 arch/arm/mach-shmobile/clock-r8a7790.c |  129 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 3 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0319cf9..97bc6cf 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -60,6 +60,8 @@ config ARCH_R8A7790
 	select ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 53a13b4..0f2aa68 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -47,6 +47,9 @@
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x1000
 
+#define FRQCRB   0xe6150004
+#define FRQCRC   0xe61500e0
+
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR7 0xe615014c
@@ -83,11 +86,132 @@ static struct clk main_clk = {
  * clock ratio of these clock will be updated
  * on r8a7790_clock_init()
  */
+SH_FIXED_RATIO_CLK_SET(pll0_clk,		main_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(pll1_clk,		main_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(pll3_clk,		main_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(lb_clk,			pll1_clk,	1, 1);
 SH_FIXED_RATIO_CLK_SET(qspi_clk,		pll1_clk,	1, 1);
 
+/* If more clocks need to access FRQCRB, we'll have to lock eventually */
+static int frqcr_kick_check(struct clk *clk)
+{
+	return ioread32(clk->mapped_reg) & BIT(31) ? -EBUSY : 0;
+}
+
+static int frqcr_kick_do(struct clk *clk)
+{
+	int i;
+
+	/* set KICK bit in FRQCRB to update hardware setting, check success */
+	iowrite32(ioread32(clk->mapped_reg) | BIT(31), clk->mapped_reg);
+	for (i = 1000; i; i--)
+		if (ioread32(clk->mapped_reg) & BIT(31))
+			cpu_relax();
+		else
+			return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int zclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	void __iomem *frqcrc;
+	int ret;
+	unsigned long step, p_rate;
+	u32 val;
+
+	if (!clk->parent || !__clk_get(clk->parent))
+		return -ENODEV;
+
+	ret = frqcr_kick_check(clk);
+	if (ret < 0)
+		goto done;
+
+	frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
+
+	p_rate = clk_get_rate(clk->parent);
+	if (rate == p_rate) {
+		val = 0;
+	} else {
+		step = DIV_ROUND_CLOSEST(p_rate, 32);
+		val = 32 - rate / step;
+	}
+
+	iowrite32((ioread32(frqcrc) & ~(clk->div_mask << clk->enable_bit)) |
+		  (val << clk->enable_bit), frqcrc);
+
+	ret = frqcr_kick_do(clk);
+
+done:
+	__clk_put(clk->parent);
+	return ret;
+}
+
+static long zclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	/*
+	 * theoretical rate = parent rate * multiplier / 32,
+	 * where 1 <= multiplier <= 32. Therefore we should do
+	 * multiplier = rate * 32 / parent rate
+	 * rounded rate = parent rate * multiplier / 32.
+	 * However, multiplication before division won't fit in 32 bits, so
+	 * we sacrifice some precision by first dividing and then multiplying.
+	 * To find the nearest divisor we calculate both and pick up the best
+	 * one. This avoids 64-bit arithmetics.
+	 */
+	unsigned long step, mul_min, mul_max, rate_min, rate_max;
+
+	rate_max = clk_get_rate(clk->parent);
+
+	/* output freq <= parent */
+	if (rate >= rate_max)
+		return rate_max;
+
+	step = DIV_ROUND_CLOSEST(rate_max, 32);
+	/* output freq >= parent / 32 */
+	if (step >= rate)
+		return step;
+
+	mul_min = rate / step;
+	mul_max = DIV_ROUND_UP(rate, step);
+	rate_min = step * mul_min;
+	if (mul_max == mul_min)
+		return rate_min;
+
+	rate_max = step * mul_max;
+
+	if (rate_max - rate <  rate - rate_min)
+		return rate_max;
+
+	return rate_min;
+}
+
+static unsigned long zclk_recalc(struct clk *clk)
+{
+	void __iomem *frqcrc = FRQCRC - (u32)clk->enable_reg + clk->mapped_reg;
+	unsigned int max = clk->div_mask + 1;
+	unsigned long val = ((ioread32(frqcrc) >> clk->enable_bit) &
+			     clk->div_mask);
+
+	return DIV_ROUND_CLOSEST(clk_get_rate(clk->parent), max) *
+		(max - val);
+}
+
+static struct sh_clk_ops zclk_ops = {
+	.recalc = zclk_recalc,
+	.set_rate = zclk_set_rate,
+	.round_rate = zclk_round_rate,
+};
+
+static struct clk z_clk = {
+	.parent = &pll0_clk,
+	.div_mask = 0x1f,
+	.enable_bit = 8,
+	/* We'll need to access FRQCRB and FRQCRC */
+	.enable_reg = (void __iomem *)FRQCRB,
+	.ops = &zclk_ops,
+};
+
 /* fixed ratio clock */
 SH_FIXED_RATIO_CLK_SET(extal_div2_clk,		extal_clk,	1, 2);
 SH_FIXED_RATIO_CLK_SET(cp_clk,			extal_clk,	1, 2);
@@ -115,11 +239,13 @@ static struct clk *main_clks[] = {
 	&extal_clk,
 	&extal_div2_clk,
 	&main_clk,
+	&pll0_clk,
 	&pll1_clk,
 	&pll1_div2_clk,
 	&pll3_clk,
 	&lb_clk,
 	&qspi_clk,
+	&z_clk,
 	&zg_clk,
 	&zx_clk,
 	&zs_clk,
@@ -213,6 +339,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pll1",		&pll1_clk),
 	CLKDEV_CON_ID("pll1_div2",	&pll1_div2_clk),
 	CLKDEV_CON_ID("pll3",		&pll3_clk),
+	CLKDEV_DEV_ID("cpufreq-cpu0",	&z_clk),
 	CLKDEV_CON_ID("zg",		&zg_clk),
 	CLKDEV_CON_ID("zx",		&zx_clk),
 	CLKDEV_CON_ID("zs",		&zs_clk),
@@ -263,9 +390,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 };
 
+/* "/ 2" is a "fixed divider" - see the "PLL Multiplication Ratio" table */
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
 	extal_clk.rate	= e * 1000 * 1000;			\
 	main_clk.parent	= m;					\
+	SH_CLK_SET_RATIO(&pll0_clk_ratio, p0 / 2, 1);		\
 	SH_CLK_SET_RATIO(&pll1_clk_ratio, p1 / 2, 1);		\
 	if (mode & MD(19))					\
 		SH_CLK_SET_RATIO(&pll3_clk_ratio, p31, 1);	\
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index eeef5f6..49c3166 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -166,6 +166,7 @@ void __init r8a7790_timer_init(void)
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.2.5

