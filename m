From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 5/6] clk: pxa: transfer CPU clock setting from pxa2xx-cpufreq
Date: Mon, 10 Oct 2016 22:09:08 +0200
Message-ID: <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-pm@vger.kernel.org

This is the initial stage to transfer the pxa25x and pxa27x CPU clocks
handling from cpufreq to the clock API. More precisely, the clocks
transferred are :
 - cpll : core pll, known also as the CPU core turbo frequency
 - core : core, known also as the CPU actual frequency, being either the
          CPU core turbo frequency or the CPU core run frequency

This transfer is a prequel to shrink the code in pxa2xx-cpufreq.c, so
that it can become, at least in devicetree builds, the casual cpufreq-dt
driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa.c    | 128 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/pxa/clk-pxa.h    |  56 ++++++++++++++++-
 drivers/clk/pxa/clk-pxa25x.c |  94 ++++++++++++++++++++++++++--
 drivers/clk/pxa/clk-pxa27x.c | 144 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 395 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 29cee9e8d4d9..5c59ca9074c0 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -15,9 +15,18 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 
+#include <mach/pxa2xx-regs.h>
+#include <mach/smemc.h>
+
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
 
+#define KHz 1000
+#define MHz (1000 * 1000)
+
+#define MDREFR_DB2_MASK		(MDREFR_K2DB2 | MDREFR_K1DB2)
+#define MDREFR_DRI_MASK		0xFFF
+
 DEFINE_SPINLOCK(lock);
 
 static struct clk *pxa_clocks[CLK_MAX];
@@ -106,3 +115,122 @@ void __init clk_pxa_dt_common_init(struct device_node *np)
 {
 	of_clk_add_provider(np, of_clk_src_onecell_get, &onecell_data);
 }
+
+void pxa2xx_core_turbo_switch(bool on)
+{
+	unsigned long flags;
+	unsigned int unused, clkcfg;
+
+	local_irq_save(flags);
+
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
+	clkcfg &= ~CLKCFG_TURBO & ~CLKCFG_HALFTURBO;
+	if (on)
+		clkcfg |= CLKCFG_TURBO;
+	clkcfg |= CLKCFG_FCS;
+
+	asm volatile(
+	"	b	2f\n"
+	"	.align	5\n"
+	"1:	mcr	p14, 0, %1, c6, c0, 0\n"
+	"	b	3f\n"
+	"2:	b	1b\n"
+	"3:	nop\n"
+		: "=&r" (unused)
+		: "r" (clkcfg)
+		: );
+
+	local_irq_restore(flags);
+}
+
+void pxa2xx_cpll_change(struct pxa2xx_freq *freq,
+			u32 (*mdrefr_dri)(unsigned int))
+{
+	unsigned int clkcfg = freq->clkcfg;
+	unsigned int unused, preset_mdrefr, postset_mdrefr;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* Calculate the next MDREFR.  If we're slowing down the SDRAM clock
+	 * we need to preset the smaller DRI before the change.	 If we're
+	 * speeding up we need to set the larger DRI value after the change.
+	 */
+	preset_mdrefr = postset_mdrefr = __raw_readl(MDREFR);
+	if ((preset_mdrefr & MDREFR_DRI_MASK) > mdrefr_dri(freq->membus_khz)) {
+		preset_mdrefr = (preset_mdrefr & ~MDREFR_DRI_MASK);
+		preset_mdrefr |= mdrefr_dri(freq->membus_khz);
+	}
+	postset_mdrefr =
+		(postset_mdrefr & ~MDREFR_DRI_MASK) |
+		mdrefr_dri(freq->membus_khz);
+
+	/* If we're dividing the memory clock by two for the SDRAM clock, this
+	 * must be set prior to the change.  Clearing the divide must be done
+	 * after the change.
+	 */
+	if (freq->div2) {
+		preset_mdrefr  |= MDREFR_DB2_MASK;
+		postset_mdrefr |= MDREFR_DB2_MASK;
+	} else {
+		postset_mdrefr &= ~MDREFR_DB2_MASK;
+	}
+
+	/* Set new the CCCR and prepare CLKCFG */
+	writel(freq->cccr, CCCR);
+
+	asm volatile(
+	"	ldr	r4, [%1]\n"
+	"	b	2f\n"
+	"	.align	5\n"
+	"1:	str	%3, [%1]		/* preset the MDREFR */\n"
+	"	mcr	p14, 0, %2, c6, c0, 0	/* set CLKCFG[FCS] */\n"
+	"	str	%4, [%1]		/* postset the MDREFR */\n"
+	"	b	3f\n"
+	"2:	b	1b\n"
+	"3:	nop\n"
+	     : "=&r" (unused)
+	     : "r" (MDREFR), "r" (clkcfg), "r" (preset_mdrefr),
+	       "r" (postset_mdrefr)
+	     : "r4", "r5");
+
+	local_irq_restore(flags);
+}
+
+int pxa2xx_determine_rate(struct clk_rate_request *req,
+			  struct pxa2xx_freq *freqs, int nb_freqs)
+{
+	int i, closest_below = -1, closest_above = -1;
+	unsigned long rate;
+
+	for (i = 0; i < nb_freqs; i++) {
+		rate = freqs[i].cpll_khz * KHz;
+		if (rate == req->rate)
+			break;
+		if (rate < req->min_rate)
+			continue;
+		if (rate > req->max_rate)
+			continue;
+		if (rate <= req->rate)
+			closest_below = i;
+		if ((rate >= req->rate) && (closest_above == -1))
+			closest_above = i;
+	}
+
+	req->best_parent_hw = NULL;
+
+	if (i < nb_freqs)
+		return 0;
+
+	if (closest_below >= 0) {
+		req->rate = freqs[closest_below].cpll_khz * KHz;
+		return 0;
+	}
+
+	if (closest_above >= 0) {
+		req->rate = freqs[closest_above].cpll_khz * KHz;
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index d1de805df867..068092605955 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -13,6 +13,11 @@
 #ifndef _CLK_PXA_
 #define _CLK_PXA_
 
+#define CLKCFG_TURBO		0x1
+#define CLKCFG_FCS		0x2
+#define CLKCFG_HALFTURBO	0x4
+#define CLKCFG_FASTBUS		0x8
+
 #define PARENTS(name) \
 	static const char *const name ## _parents[] __initconst
 #define MUX_RO_RATE_RO_OPS(name, clk_name)			\
@@ -35,10 +40,27 @@
 			NULL, NULL, CLK_GET_RATE_NOCACHE);	\
 	}
 
-#define RATE_RO_OPS(name, clk_name)			\
+#define RATE_RO_OPS(name, clk_name)				\
+	static struct clk_hw name ## _rate_hw;			\
+	static struct clk_ops name ## _rate_ops = {		\
+		.recalc_rate = name ## _get_rate,		\
+	};							\
+	static struct clk * __init clk_register_ ## name(void)	\
+	{							\
+		return clk_register_composite(NULL, clk_name,	\
+			name ## _parents,			\
+			ARRAY_SIZE(name ## _parents),		\
+			NULL, NULL,				\
+			&name ## _rate_hw, &name ## _rate_ops,	\
+			NULL, NULL, CLK_GET_RATE_NOCACHE);	\
+	}
+
+#define RATE_OPS(name, clk_name)				\
 	static struct clk_hw name ## _rate_hw;			\
 	static struct clk_ops name ## _rate_ops = {		\
 		.recalc_rate = name ## _get_rate,		\
+		.set_rate = name ## _set_rate,			\
+		.determine_rate = name ## _determine_rate,	\
 	};							\
 	static struct clk * __init clk_register_ ## name(void)	\
 	{							\
@@ -50,6 +72,24 @@
 			NULL, NULL, CLK_GET_RATE_NOCACHE);	\
 	}
 
+#define MUX_OPS(name, clk_name, flags)				\
+	static struct clk_hw name ## _mux_hw;			\
+	static struct clk_ops name ## _mux_ops = {		\
+		.get_parent = name ## _get_parent,		\
+		.set_parent = name ## _set_parent,		\
+		.determine_rate = name ## _determine_rate,	\
+	};							\
+	static struct clk * __init clk_register_ ## name(void)	\
+	{							\
+		return clk_register_composite(NULL, clk_name,	\
+			name ## _parents,			\
+			ARRAY_SIZE(name ## _parents),		\
+			&name ## _mux_hw, &name ## _mux_ops,	\
+			NULL, NULL,				\
+			NULL, NULL,				\
+			CLK_GET_RATE_NOCACHE | flags); \
+	}
+
 /*
  * CKEN clock type
  * This clock takes it source from 2 possible parents :
@@ -95,6 +135,14 @@ struct desc_clk_cken {
 	PXA_CKEN(dev_id, con_id, name, parents, 1, 1, 1, 1,		\
 		 NULL, cken_reg, cken_bit, flag)
 
+struct pxa2xx_freq {
+	unsigned int cpll_khz;
+	unsigned int membus_khz;
+	unsigned int cccr;
+	unsigned int div2;
+	unsigned int clkcfg;
+};
+
 static int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
 {
 	return 0;
@@ -105,4 +153,10 @@ extern void clkdev_pxa_register(int ckid, const char *con_id,
 extern int clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks);
 void clk_pxa_dt_common_init(struct device_node *np);
 
+void pxa2xx_core_turbo_switch(bool on);
+void pxa2xx_cpll_change(struct pxa2xx_freq *freq,
+			u32 (*mdrefr_dri)(unsigned int));
+int pxa2xx_determine_rate(struct clk_rate_request *req,
+			  struct pxa2xx_freq *freqs,  int nb_freqs);
+
 #endif
diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index 6a3009eec830..22f89d2f35cc 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <mach/pxa2xx-regs.h>
+#include <mach/smemc.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
@@ -30,6 +31,17 @@ enum {
 	PXA_CORE_TURBO,
 };
 
+#define PXA25x_CLKCFG(T)			\
+	(CLKCFG_FCS |				\
+	 ((T) ? CLKCFG_TURBO : 0))
+#define PXA25x_CCCR(N2, M, L) (N2 << 7 | M << 5 | L)
+
+#define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
+#define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
+
+/* Define the refresh period in mSec for the SDRAM and the number of rows */
+#define SDRAM_TREF	64	/* standard 64ms SDRAM */
+
 /*
  * Various clock factors driven by the CCCR register.
  */
@@ -48,6 +60,34 @@ static const char * const get_freq_khz[] = {
 	"core", "run", "cpll", "memory"
 };
 
+static int get_sdram_rows(void)
+{
+	static int sdram_rows;
+	unsigned int drac2 = 0, drac0 = 0;
+	u32 mdcnfg;
+
+	if (sdram_rows)
+		return sdram_rows;
+
+	mdcnfg = __raw_readl(MDCNFG);
+
+	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
+		drac2 = MDCNFG_DRAC2(mdcnfg);
+
+	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
+		drac0 = MDCNFG_DRAC0(mdcnfg);
+
+	sdram_rows = 1 << (11 + max(drac0, drac2));
+	return sdram_rows;
+}
+
+static u32 mdrefr_dri(unsigned int freq_khz)
+{
+	u32 interval = freq_khz * SDRAM_TREF / get_sdram_rows();
+
+	return interval / 32;
+}
+
 /*
  * Get the clock frequency as reflected by CCCR and the turbo flag.
  * We assume these values have been applied via a fcs.
@@ -139,6 +179,15 @@ static struct desc_clk_cken pxa25x_clocks[] __initdata = {
 			     clk_pxa25x_memory_parents, 0),
 };
 
+static struct pxa2xx_freq pxa25x_freqs[] = {
+	/* CPU  MEMBUS  CCCR                  DIV2 CCLKCFG      */
+	{ 99500, 99500, PXA25x_CCCR(2,  1, 1),  1, PXA25x_CLKCFG(1)},
+	{199100, 99500, PXA25x_CCCR(4,  1, 1),  0, PXA25x_CLKCFG(1)},
+	{298500, 99500, PXA25x_CCCR(6,  1, 1),  0, PXA25x_CLKCFG(1)},
+	{298600, 99500, PXA25x_CCCR(2,  1, 16), 0, PXA25x_CLKCFG(1)},
+	{398100, 99500, PXA25x_CCCR(4,  2, 1),  0, PXA25x_CLKCFG(1)},
+};
+
 static u8 clk_pxa25x_core_get_parent(struct clk_hw *hw)
 {
 	unsigned long clkcfg;
@@ -151,13 +200,24 @@ static u8 clk_pxa25x_core_get_parent(struct clk_hw *hw)
 	return PXA_CORE_RUN;
 }
 
-static unsigned long clk_pxa25x_core_get_rate(struct clk_hw *hw,
-					      unsigned long parent_rate)
+static int clk_pxa25x_core_set_parent(struct clk_hw *hw, u8 index)
 {
-	return parent_rate;
+	if (index > PXA_CORE_TURBO)
+		return -EINVAL;
+
+	pxa2xx_core_turbo_switch(index == PXA_CORE_TURBO);
+
+	return 0;
+}
+
+static int clk_pxa25x_core_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	return __clk_mux_determine_rate(hw, req);
 }
+
 PARENTS(clk_pxa25x_core) = { "run", "cpll" };
-MUX_RO_RATE_RO_OPS(clk_pxa25x_core, "core");
+MUX_OPS(clk_pxa25x_core, "core", CLK_SET_RATE_PARENT);
 
 static unsigned long clk_pxa25x_run_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
@@ -184,8 +244,32 @@ static unsigned long clk_pxa25x_cpll_get_rate(struct clk_hw *hw,
 
 	return m * l * n2 * parent_rate / 2;
 }
+
+static int clk_pxa25x_cpll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	return pxa2xx_determine_rate(req, pxa25x_freqs,
+				     ARRAY_SIZE(pxa25x_freqs));
+}
+
+static int clk_pxa25x_cpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pxa25x_freqs); i++)
+		if (pxa25x_freqs[i].cpll_khz * KHz == rate)
+			break;
+
+	if (i >= ARRAY_SIZE(pxa25x_freqs))
+		return -EINVAL;
+
+	pxa2xx_cpll_change(&pxa25x_freqs[i], mdrefr_dri);
+
+	return 0;
+}
 PARENTS(clk_pxa25x_cpll) = { "osc_3_6864mhz" };
-RATE_RO_OPS(clk_pxa25x_cpll, "cpll");
+RATE_OPS(clk_pxa25x_cpll, "cpll");
 
 static void __init pxa25x_register_core(void)
 {
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 9fb40e884999..2bf450bbdc5a 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -17,6 +17,8 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 
+#include <mach/smemc.h>
+
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
 
@@ -45,11 +47,52 @@ enum {
 	PXA_MEM_RUN,
 };
 
+#define PXA27x_CLKCFG(B, HT, T)			\
+	(CLKCFG_FCS |				\
+	 ((B)  ? CLKCFG_FASTBUS : 0) |		\
+	 ((HT) ? CLKCFG_HALFTURBO : 0) |	\
+	 ((T)  ? CLKCFG_TURBO : 0))
+#define PXA27x_CCCR(A, L, N2) (A << 25 | N2 << 7 | L)
+
+#define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
+#define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
+
+/* Define the refresh period in mSec for the SDRAM and the number of rows */
+#define SDRAM_TREF	64	/* standard 64ms SDRAM */
+
 static const char * const get_freq_khz[] = {
 	"core", "run", "cpll", "memory",
 	"system_bus"
 };
 
+static int get_sdram_rows(void)
+{
+	static int sdram_rows;
+	unsigned int drac2 = 0, drac0 = 0;
+	u32 mdcnfg;
+
+	if (sdram_rows)
+		return sdram_rows;
+
+	mdcnfg = __raw_readl(MDCNFG);
+
+	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
+		drac2 = MDCNFG_DRAC2(mdcnfg);
+
+	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
+		drac0 = MDCNFG_DRAC0(mdcnfg);
+
+	sdram_rows = 1 << (11 + max(drac0, drac2));
+	return sdram_rows;
+}
+
+static u32 mdrefr_dri(unsigned int freq_khz)
+{
+	u32 interval = freq_khz * SDRAM_TREF / get_sdram_rows();
+
+	return (interval - 31) / 32;
+}
+
 /*
  * Get the clock frequency as reflected by CCSR and the turbo flag.
  * We assume these values have been applied via a fcs.
@@ -145,6 +188,42 @@ static struct desc_clk_cken pxa27x_clocks[] __initdata = {
 
 };
 
+/*
+ * PXA270 definitions
+ *
+ * For the PXA27x:
+ * Control variables are A, L, 2N for CCCR; B, HT, T for CLKCFG.
+ *
+ * A = 0 => memory controller clock from table 3-7,
+ * A = 1 => memory controller clock = system bus clock
+ * Run mode frequency	= 13 MHz * L
+ * Turbo mode frequency = 13 MHz * L * N
+ * System bus frequency = 13 MHz * L / (B + 1)
+ *
+ * In CCCR:
+ * A = 1
+ * L = 16	  oscillator to run mode ratio
+ * 2N = 6	  2 * (turbo mode to run mode ratio)
+ *
+ * In CCLKCFG:
+ * B = 1	  Fast bus mode
+ * HT = 0	  Half-Turbo mode
+ * T = 1	  Turbo mode
+ *
+ * For now, just support some of the combinations in table 3-7 of
+ * PXA27x Processor Family Developer's Manual to simplify frequency
+ * change sequences.
+ */
+static struct pxa2xx_freq pxa27x_freqs[] = {
+	{104000, 104000, PXA27x_CCCR(1,  8, 2), 0, PXA27x_CLKCFG(1, 0, 1) },
+	{156000, 104000, PXA27x_CCCR(1,  8, 3), 0, PXA27x_CLKCFG(1, 0, 1) },
+	{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, PXA27x_CLKCFG(0, 0, 1) },
+	{312000, 208000, PXA27x_CCCR(1, 16, 3), 1, PXA27x_CLKCFG(1, 0, 1) },
+	{416000, 208000, PXA27x_CCCR(1, 16, 4), 1, PXA27x_CLKCFG(1, 0, 1) },
+	{520000, 208000, PXA27x_CCCR(1, 16, 5), 1, PXA27x_CLKCFG(1, 0, 1) },
+	{624000, 208000, PXA27x_CCCR(1, 16, 6), 1, PXA27x_CLKCFG(1, 0, 1) },
+};
+
 static unsigned long clk_pxa27x_cpll_get_rate(struct clk_hw *hw,
 	unsigned long parent_rate)
 {
@@ -164,8 +243,33 @@ static unsigned long clk_pxa27x_cpll_get_rate(struct clk_hw *hw,
 
 	return N;
 }
+
+
+static int clk_pxa27x_cpll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	return pxa2xx_determine_rate(req, pxa27x_freqs,
+				     ARRAY_SIZE(pxa27x_freqs));
+}
+
+static int clk_pxa27x_cpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pxa27x_freqs); i++)
+		if (pxa27x_freqs[i].cpll_khz * KHz == rate)
+			break;
+
+	if (i >= ARRAY_SIZE(pxa27x_freqs))
+		return -EINVAL;
+
+	pxa2xx_cpll_change(&pxa27x_freqs[i], mdrefr_dri);
+	return 0;
+}
+
 PARENTS(clk_pxa27x_cpll) = { "osc_13mhz" };
-RATE_RO_OPS(clk_pxa27x_cpll, "cpll");
+RATE_OPS(clk_pxa27x_cpll, "cpll");
 
 static unsigned long clk_pxa27x_lcd_base_get_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
@@ -217,25 +321,6 @@ static void __init pxa27x_register_plls(void)
 	clk_register_fixed_factor(NULL, "ppll_312mhz", "osc_13mhz", 0, 24, 1);
 }
 
-static unsigned long clk_pxa27x_core_get_rate(struct clk_hw *hw,
-					      unsigned long parent_rate)
-{
-	unsigned long clkcfg;
-	unsigned int ht, osc_forced;
-	unsigned long ccsr = readl(CCSR);
-
-	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
-	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
-	ht = clkcfg & (1 << 2);
-
-	if (osc_forced)
-		return parent_rate;
-	if (ht)
-		return parent_rate / 2;
-	else
-		return parent_rate;
-}
-
 static u8 clk_pxa27x_core_get_parent(struct clk_hw *hw)
 {
 	unsigned long clkcfg;
@@ -254,8 +339,25 @@ static u8 clk_pxa27x_core_get_parent(struct clk_hw *hw)
 		return PXA_CORE_TURBO;
 	return PXA_CORE_RUN;
 }
+
+static int clk_pxa27x_core_set_parent(struct clk_hw *hw, u8 index)
+{
+	if (index > PXA_CORE_TURBO)
+		return -EINVAL;
+
+	pxa2xx_core_turbo_switch(index == PXA_CORE_TURBO);
+
+	return 0;
+}
+
+static int clk_pxa27x_core_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	return __clk_mux_determine_rate(hw, req);
+}
+
 PARENTS(clk_pxa27x_core) = { "osc_13mhz", "run", "cpll" };
-MUX_RO_RATE_RO_OPS(clk_pxa27x_core, "core");
+MUX_OPS(clk_pxa27x_core, "core", CLK_SET_RATE_PARENT);
 
 static unsigned long clk_pxa27x_run_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
-- 
2.1.4
