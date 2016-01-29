From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/9] ARM: pxa: define clock registers as __iomem
Date: Fri, 29 Jan 2016 15:06:25 +0100
Message-ID: <1454076396-3563101-2-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We should not dereference registers as pointers, so use readl/writel
instead for these registers.

The clock registers are accessed in multiple files, so we have to
change them all at once.

I stumbled over these registers while looking at something unrelated.
There are in fact other registers with the same problem, but I did
not try to address those at this point.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/gumstix.c                  |  6 ++---
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h |  8 +++----
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |  2 +-
 arch/arm/mach-pxa/zeus.c                     |  2 +-
 drivers/clk/pxa/clk-pxa25x.c                 | 12 +++++-----
 drivers/clk/pxa/clk-pxa27x.c                 | 34 ++++++++++++++--------------
 drivers/clk/pxa/clk-pxa3xx.c                 |  3 +--
 drivers/cpufreq/pxa2xx-cpufreq.c             |  2 +-
 8 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 6815a9357774..9c5b2fb054f9 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -139,14 +139,14 @@ static void gumstix_setup_bt_clock(void)
 {
 	int timeout = 500;
 
-	if (!(OSCC & OSCC_OOK))
+	if (!(readl(OSCC) & OSCC_OOK))
 		pr_warn("32kHz clock was not on. Bootloader may need to be updated\n");
 	else
 		return;
 
-	OSCC |= OSCC_OON;
+	writel(readl(OSCC) | OSCC_OON, OSCC);
 	do {
-		if (OSCC & OSCC_OOK)
+		if (readl(OSCC) & OSCC_OOK)
 			break;
 		udelay(1);
 	} while (--timeout);
diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
index f1dd62946b36..5537d5601d70 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
@@ -134,10 +134,10 @@
 /*
  * PXA2xx specific Core clock definitions
  */
-#define CCCR		__REG(0x41300000)  /* Core Clock Configuration Register */
-#define CCSR		__REG(0x4130000C)  /* Core Clock Status Register */
-#define CKEN		__REG(0x41300004)  /* Clock Enable Register */
-#define OSCC		__REG(0x41300008)  /* Oscillator Configuration Register */
+#define CCCR		io_p2v(0x41300000)  /* Core Clock Configuration Register */
+#define CCSR		io_p2v(0x4130000C)  /* Core Clock Status Register */
+#define CKEN		io_p2v(0x41300004)  /* Clock Enable Register */
+#define OSCC		io_p2v(0x41300008)  /* Oscillator Configuration Register */
 
 #define CCCR_N_MASK	0x0380	/* Run Mode Frequency to Turbo Mode Frequency Multiplier */
 #define CCCR_M_MASK	0x0060	/* Memory Frequency to Run Mode Frequency Multiplier */
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
index f4d48d20754e..888bf7ade15a 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
@@ -18,7 +18,7 @@
 /*
  * Oscillator Configuration Register (OSCC)
  */
-#define OSCC           __REG(0x41350000)  /* Oscillator Configuration Register */
+#define OSCC           io_p2v(0x41350000)  /* Oscillator Configuration Register */
 
 #define OSCC_PEN       (1 << 11)       /* 13MHz POUT */
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 515b7ddda8aa..3b94ecfb9426 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -910,7 +910,7 @@ static void __init zeus_map_io(void)
 	PMCR = PSPR = 0;
 
 	/* enable internal 32.768Khz oscillator (ignore OSCC_OOK) */
-	OSCC |= OSCC_OON;
+	writel(readl(OSCC) | OSCC_OON, OSCC);
 
 	/* Some clock cycles later (from OSCC_ON), programme PCFR (OPDE...).
 	 * float chip selects and PCMCIA */
diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index b7747229db9a..a9353cd4ce17 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -84,7 +84,7 @@ unsigned int pxa25x_get_clk_frequency_khz(int info)
 static unsigned long clk_pxa25x_memory_get_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	unsigned long cccr = CCCR;
+	unsigned long cccr = readl(CCCR);
 	unsigned int m = M_clk_mult[(cccr >> 5) & 0x03];
 
 	return parent_rate / m;
@@ -99,7 +99,7 @@ PARENTS(pxa25x_osc3) = { "osc_3_6864mhz", "osc_3_6864mhz" };
 #define PXA25X_CKEN(dev_id, con_id, parents, mult, div,			\
 		    bit, is_lp, flags)					\
 	PXA_CKEN(dev_id, con_id, bit, parents, mult, div, mult, div,	\
-		 is_lp,  &CKEN, CKEN_ ## bit, flags)
+		 is_lp,  CKEN, CKEN_ ## bit, flags)
 #define PXA25X_PBUS95_CKEN(dev_id, con_id, bit, mult_hp, div_hp, delay)	\
 	PXA25X_CKEN(dev_id, con_id, pxa25x_pbus95_parents, mult_hp,	\
 		    div_hp, bit, NULL, 0)
@@ -112,10 +112,10 @@ PARENTS(pxa25x_osc3) = { "osc_3_6864mhz", "osc_3_6864mhz" };
 
 #define PXA25X_CKEN_1RATE(dev_id, con_id, bit, parents, delay)		\
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
-		       &CKEN, CKEN_ ## bit, 0)
+		       CKEN, CKEN_ ## bit, 0)
 #define PXA25X_CKEN_1RATE_AO(dev_id, con_id, bit, parents, delay)	\
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
-		       &CKEN, CKEN_ ## bit, CLK_IGNORE_UNUSED)
+		       CKEN, CKEN_ ## bit, CLK_IGNORE_UNUSED)
 
 static struct desc_clk_cken pxa25x_clocks[] __initdata = {
 	PXA25X_PBUS95_CKEN("pxa2xx-mci.0", NULL, MMC, 1, 5, 0),
@@ -162,7 +162,7 @@ MUX_RO_RATE_RO_OPS(clk_pxa25x_core, "core");
 static unsigned long clk_pxa25x_run_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
-	unsigned long cccr = CCCR;
+	unsigned long cccr = readl(CCCR);
 	unsigned int n2 = N2_clk_mult[(cccr >> 7) & 0x07];
 
 	return (parent_rate / n2) * 2;
@@ -173,7 +173,7 @@ RATE_RO_OPS(clk_pxa25x_run, "run");
 static unsigned long clk_pxa25x_cpll_get_rate(struct clk_hw *hw,
 	unsigned long parent_rate)
 {
-	unsigned long clkcfg, cccr = CCCR;
+	unsigned long clkcfg, cccr = readl(CCCR);
 	unsigned int l, m, n2, t;
 
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 5b82d30baf9f..fc2abf97edd7 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -85,7 +85,7 @@ unsigned int pxa27x_get_clk_frequency_khz(int info)
 
 bool pxa27x_is_ppll_disabled(void)
 {
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	return ccsr & (1 << CCCR_PPDIS_BIT);
 }
@@ -93,7 +93,7 @@ bool pxa27x_is_ppll_disabled(void)
 #define PXA27X_CKEN(dev_id, con_id, parents, mult_hp, div_hp,		\
 		    bit, is_lp, flags)					\
 	PXA_CKEN(dev_id, con_id, bit, parents, 1, 1, mult_hp, div_hp,	\
-		 is_lp,  &CKEN, CKEN_ ## bit, flags)
+		 is_lp,  CKEN, CKEN_ ## bit, flags)
 #define PXA27X_PBUS_CKEN(dev_id, con_id, bit, mult_hp, div_hp, delay)	\
 	PXA27X_CKEN(dev_id, con_id, pxa27x_pbus_parents, mult_hp,	\
 		    div_hp, bit, pxa27x_is_ppll_disabled, 0)
@@ -106,10 +106,10 @@ PARENTS(pxa27x_membus) = { "lcd_base", "lcd_base" };
 
 #define PXA27X_CKEN_1RATE(dev_id, con_id, bit, parents, delay)		\
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
-		       &CKEN, CKEN_ ## bit, 0)
+		       CKEN, CKEN_ ## bit, 0)
 #define PXA27X_CKEN_1RATE_AO(dev_id, con_id, bit, parents, delay)	\
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
-		       &CKEN, CKEN_ ## bit, CLK_IGNORE_UNUSED)
+		       CKEN, CKEN_ ## bit, CLK_IGNORE_UNUSED)
 
 static struct desc_clk_cken pxa27x_clocks[] __initdata = {
 	PXA27X_PBUS_CKEN("pxa2xx-uart.0", NULL, FFUART, 2, 42, 1),
@@ -151,7 +151,7 @@ static unsigned long clk_pxa27x_cpll_get_rate(struct clk_hw *hw,
 	unsigned long clkcfg;
 	unsigned int t, ht;
 	unsigned int l, L, n2, N;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
 	t  = clkcfg & (1 << 0);
@@ -171,8 +171,8 @@ static unsigned long clk_pxa27x_lcd_base_get_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
 	unsigned int l, osc_forced;
-	unsigned long ccsr = CCSR;
-	unsigned long cccr = CCCR;
+	unsigned long ccsr = readl(CCSR);
+	unsigned long cccr = readl(CCCR);
 
 	l  = ccsr & CCSR_L_MASK;
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
@@ -193,7 +193,7 @@ static unsigned long clk_pxa27x_lcd_base_get_rate(struct clk_hw *hw,
 static u8 clk_pxa27x_lcd_base_get_parent(struct clk_hw *hw)
 {
 	unsigned int osc_forced;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	if (osc_forced)
@@ -222,7 +222,7 @@ static unsigned long clk_pxa27x_core_get_rate(struct clk_hw *hw,
 {
 	unsigned long clkcfg;
 	unsigned int t, ht, b, osc_forced;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
@@ -242,7 +242,7 @@ static u8 clk_pxa27x_core_get_parent(struct clk_hw *hw)
 {
 	unsigned long clkcfg;
 	unsigned int t, ht, b, osc_forced;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	if (osc_forced)
@@ -263,7 +263,7 @@ MUX_RO_RATE_RO_OPS(clk_pxa27x_core, "core");
 static unsigned long clk_pxa27x_run_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 	unsigned int n2 = (ccsr & CCSR_N2_MASK) >> CCSR_N2_SHIFT;
 
 	return (parent_rate / n2) * 2;
@@ -285,7 +285,7 @@ static unsigned long clk_pxa27x_system_bus_get_rate(struct clk_hw *hw,
 {
 	unsigned long clkcfg;
 	unsigned int b, osc_forced;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
@@ -302,7 +302,7 @@ static unsigned long clk_pxa27x_system_bus_get_rate(struct clk_hw *hw,
 static u8 clk_pxa27x_system_bus_get_parent(struct clk_hw *hw)
 {
 	unsigned int osc_forced;
-	unsigned long ccsr = CCSR;
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	if (osc_forced)
@@ -318,8 +318,8 @@ static unsigned long clk_pxa27x_memory_get_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
 	unsigned int a, l, osc_forced;
-	unsigned long cccr = CCCR;
-	unsigned long ccsr = CCSR;
+	unsigned long cccr = readl(CCCR);
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	a = cccr & (1 << CCCR_A_BIT);
@@ -337,8 +337,8 @@ static unsigned long clk_pxa27x_memory_get_rate(struct clk_hw *hw,
 static u8 clk_pxa27x_memory_get_parent(struct clk_hw *hw)
 {
 	unsigned int osc_forced, a;
-	unsigned long cccr = CCCR;
-	unsigned long ccsr = CCSR;
+	unsigned long cccr = readl(CCCR);
+	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	a = cccr & (1 << CCCR_A_BIT);
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 4af4eed5f89f..ea679718601c 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -334,8 +334,7 @@ static void __init pxa3xx_base_clocks_init(void)
 	clk_register_clk_pxa3xx_system_bus();
 	clk_register_clk_pxa3xx_ac97();
 	clk_register_clk_pxa3xx_smemc();
-	clk_register_gate(NULL, "CLK_POUT", "osc_13mhz", 0,
-			  (void __iomem *)&OSCC, 11, 0, NULL);
+	clk_register_gate(NULL, "CLK_POUT", "osc_13mhz", 0, OSCC, 11, 0, NULL);
 	clkdev_pxa_register(CLK_OSTIMER, "OSTIMER0", NULL,
 			    clk_register_fixed_factor(NULL, "os-timer0",
 						      "osc_13mhz", 0, 1, 4));
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 096377232747..46fee1539cc8 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -319,7 +319,7 @@ static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 	local_irq_save(flags);
 
 	/* Set new the CCCR and prepare CCLKCFG */
-	CCCR = pxa_freq_settings[idx].cccr;
+	writel(pxa_freq_settings[idx].cccr, CCCR);
 	cclkcfg = pxa_freq_settings[idx].cclkcfg;
 
 	asm volatile("							\n\
-- 
2.7.0
