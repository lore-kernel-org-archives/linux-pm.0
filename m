From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 4/4] cpufreq: pxa: convert to clock API
Date: Sat, 15 Oct 2016 21:57:30 +0200
Message-ID: <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As the clock settings have been introduced into the clock pxa drivers,
which are now available to change the CPU clock by themselves, remove
the clock handling from this driver, and rely on pxa clock drivers.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: added !OF Kconfig dependency
---
 drivers/cpufreq/Kconfig.arm      |   2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
 2 files changed, 40 insertions(+), 153 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d89b8afe23b6..1a4f04351f98 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -236,7 +236,7 @@ config ARM_TEGRA124_CPUFREQ
 
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
-	depends on PXA27x || PXA25x
+	depends on (PXA27x || PXA25x) && !OF
 	help
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index ce345bf34d5d..06b024a3e474 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -58,56 +58,40 @@ module_param(pxa27x_maxfreq, uint, 0);
 MODULE_PARM_DESC(pxa27x_maxfreq, "Set the pxa27x maxfreq in MHz"
 		 "(typically 624=>pxa270, 416=>pxa271, 520=>pxa272)");
 
+struct pxa_cpufreq_data {
+	struct clk *clk_core;
+};
+static struct pxa_cpufreq_data  pxa_cpufreq_data;
+
 struct pxa_freqs {
 	unsigned int khz;
-	unsigned int membus;
-	unsigned int cccr;
-	unsigned int div2;
-	unsigned int cclkcfg;
 	int vmin;
 	int vmax;
 };
 
-/* Define the refresh period in mSec for the SDRAM and the number of rows */
-#define SDRAM_TREF	64	/* standard 64ms SDRAM */
-static unsigned int sdram_rows;
-
-#define CCLKCFG_TURBO		0x1
-#define CCLKCFG_FCS		0x2
-#define CCLKCFG_HALFTURBO	0x4
-#define CCLKCFG_FASTBUS		0x8
-#define MDREFR_DB2_MASK		(MDREFR_K2DB2 | MDREFR_K1DB2)
-#define MDREFR_DRI_MASK		0xFFF
-
-#define MDCNFG_DRAC2(mdcnfg) (((mdcnfg) >> 21) & 0x3)
-#define MDCNFG_DRAC0(mdcnfg) (((mdcnfg) >> 5) & 0x3)
-
 /*
  * PXA255 definitions
  */
-/* Use the run mode frequencies for the CPUFREQ_POLICY_PERFORMANCE policy */
-#define CCLKCFG			CCLKCFG_TURBO | CCLKCFG_FCS
-
 static const struct pxa_freqs pxa255_run_freqs[] =
 {
-	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	           run  turbo PXbus SDRAM */
-	{ 99500,  99500, 0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
-	{132700, 132700, 0x123, 1,  CCLKCFG, -1, -1},	/* 133,  133,   66,   66  */
-	{199100,  99500, 0x141, 0,  CCLKCFG, -1, -1},	/* 199,  199,   99,   99  */
-	{265400, 132700, 0x143, 1,  CCLKCFG, -1, -1},	/* 265,  265,  133,   66  */
-	{331800, 165900, 0x145, 1,  CCLKCFG, -1, -1},	/* 331,  331,  166,   83  */
-	{398100,  99500, 0x161, 0,  CCLKCFG, -1, -1},	/* 398,  398,  196,   99  */
+	/* CPU   MEMBUS		   run  turbo PXbus SDRAM */
+	{ 99500, -1, -1},	/*  99,   99,   50,   50  */
+	{132700, -1, -1},	/* 133,  133,   66,   66  */
+	{199100, -1, -1},	/* 199,  199,   99,   99  */
+	{265400, -1, -1},	/* 265,  265,  133,   66  */
+	{331800, -1, -1},	/* 331,  331,  166,   83  */
+	{398100, -1, -1},	/* 398,  398,  196,   99  */
 };
 
 /* Use the turbo mode frequencies for the CPUFREQ_POLICY_POWERSAVE policy */
 static const struct pxa_freqs pxa255_turbo_freqs[] =
 {
-	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	   run  turbo PXbus SDRAM */
-	{ 99500, 99500,  0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
-	{199100, 99500,  0x221, 0,  CCLKCFG, -1, -1},	/*  99,  199,   50,   99  */
-	{298500, 99500,  0x321, 0,  CCLKCFG, -1, -1},	/*  99,  287,   50,   99  */
-	{298600, 99500,  0x1c1, 0,  CCLKCFG, -1, -1},	/* 199,  287,   99,   99  */
-	{398100, 99500,  0x241, 0,  CCLKCFG, -1, -1},	/* 199,  398,   99,   99  */
+	/* CPU			   run  turbo PXbus SDRAM */
+	{ 99500, -1, -1},	/*  99,   99,   50,   50  */
+	{199100, -1, -1},	/*  99,  199,   50,   99  */
+	{298500, -1, -1},	/*  99,  287,   50,   99  */
+	{298600, -1, -1},	/* 199,  287,   99,   99  */
+	{398100, -1, -1},	/* 199,  398,   99,   99  */
 };
 
 #define NUM_PXA25x_RUN_FREQS ARRAY_SIZE(pxa255_run_freqs)
@@ -122,47 +106,14 @@ static unsigned int pxa255_turbo_table;
 module_param(pxa255_turbo_table, uint, 0);
 MODULE_PARM_DESC(pxa255_turbo_table, "Selects the frequency table (0 = run table, !0 = turbo table)");
 
-/*
- * PXA270 definitions
- *
- * For the PXA27x:
- * Control variables are A, L, 2N for CCCR; B, HT, T for CLKCFG.
- *
- * A = 0 => memory controller clock from table 3-7,
- * A = 1 => memory controller clock = system bus clock
- * Run mode frequency	= 13 MHz * L
- * Turbo mode frequency = 13 MHz * L * N
- * System bus frequency = 13 MHz * L / (B + 1)
- *
- * In CCCR:
- * A = 1
- * L = 16	  oscillator to run mode ratio
- * 2N = 6	  2 * (turbo mode to run mode ratio)
- *
- * In CCLKCFG:
- * B = 1	  Fast bus mode
- * HT = 0	  Half-Turbo mode
- * T = 1	  Turbo mode
- *
- * For now, just support some of the combinations in table 3-7 of
- * PXA27x Processor Family Developer's Manual to simplify frequency
- * change sequences.
- */
-#define PXA27x_CCCR(A, L, N2) (A << 25 | N2 << 7 | L)
-#define CCLKCFG2(B, HT, T) \
-  (CCLKCFG_FCS | \
-   ((B)  ? CCLKCFG_FASTBUS : 0) | \
-   ((HT) ? CCLKCFG_HALFTURBO : 0) | \
-   ((T)  ? CCLKCFG_TURBO : 0))
-
 static struct pxa_freqs pxa27x_freqs[] = {
-	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0, CCLKCFG2(1, 0, 1),  900000, 1705000 },
-	{156000, 104000, PXA27x_CCCR(1,	 8, 3), 0, CCLKCFG2(1, 0, 1), 1000000, 1705000 },
-	{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, CCLKCFG2(0, 0, 1), 1180000, 1705000 },
-	{312000, 208000, PXA27x_CCCR(1, 16, 3), 1, CCLKCFG2(1, 0, 1), 1250000, 1705000 },
-	{416000, 208000, PXA27x_CCCR(1, 16, 4), 1, CCLKCFG2(1, 0, 1), 1350000, 1705000 },
-	{520000, 208000, PXA27x_CCCR(1, 16, 5), 1, CCLKCFG2(1, 0, 1), 1450000, 1705000 },
-	{624000, 208000, PXA27x_CCCR(1, 16, 6), 1, CCLKCFG2(1, 0, 1), 1550000, 1705000 }
+	{104000,  900000, 1705000 },
+	{156000, 1000000, 1705000 },
+	{208000, 1180000, 1705000 },
+	{312000, 1250000, 1705000 },
+	{416000, 1350000, 1705000 },
+	{520000, 1450000, 1705000 },
+	{624000, 1550000, 1705000 }
 };
 
 #define NUM_PXA27x_FREQS ARRAY_SIZE(pxa27x_freqs)
@@ -241,51 +192,29 @@ static void pxa27x_guess_max_freq(void)
 	}
 }
 
-static void init_sdram_rows(void)
-{
-	uint32_t mdcnfg = __raw_readl(MDCNFG);
-	unsigned int drac2 = 0, drac0 = 0;
-
-	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
-		drac2 = MDCNFG_DRAC2(mdcnfg);
-
-	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
-		drac0 = MDCNFG_DRAC0(mdcnfg);
-
-	sdram_rows = 1 << (11 + max(drac0, drac2));
-}
-
-static u32 mdrefr_dri(unsigned int freq)
-{
-	u32 interval = freq * SDRAM_TREF / sdram_rows;
-
-	return (interval - (cpu_is_pxa27x() ? 31 : 0)) / 32;
-}
-
 static unsigned int pxa_cpufreq_get(unsigned int cpu)
 {
-	return get_clk_frequency_khz(0);
+	struct pxa_cpufreq_data *data = cpufreq_get_driver_data();
+
+	return (unsigned int) clk_get_rate(data->clk_core) / 1000;
 }
 
 static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct cpufreq_frequency_table *pxa_freqs_table;
 	const struct pxa_freqs *pxa_freq_settings;
-	unsigned long flags;
-	unsigned int new_freq_cpu, new_freq_mem;
-	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
+	struct pxa_cpufreq_data *data = cpufreq_get_driver_data();
+	unsigned int new_freq_cpu;
 	int ret = 0;
 
 	/* Get the current policy */
 	find_freq_tables(&pxa_freqs_table, &pxa_freq_settings);
 
 	new_freq_cpu = pxa_freq_settings[idx].khz;
-	new_freq_mem = pxa_freq_settings[idx].membus;
 
 	if (freq_debug)
-		pr_debug("Changing CPU frequency to %d Mhz, (SDRAM %d Mhz)\n",
-			 new_freq_cpu / 1000, (pxa_freq_settings[idx].div2) ?
-			 (new_freq_mem / 2000) : (new_freq_mem / 1000));
+		pr_debug("Changing CPU frequency from %d Mhz to %d Mhz\n",
+			 policy->cur / 1000,  new_freq_cpu / 1000);
 
 	if (vcc_core && new_freq_cpu > policy->cur) {
 		ret = pxa_cpufreq_change_voltage(&pxa_freq_settings[idx]);
@@ -293,53 +222,7 @@ static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 			return ret;
 	}
 
-	/* Calculate the next MDREFR.  If we're slowing down the SDRAM clock
-	 * we need to preset the smaller DRI before the change.	 If we're
-	 * speeding up we need to set the larger DRI value after the change.
-	 */
-	preset_mdrefr = postset_mdrefr = __raw_readl(MDREFR);
-	if ((preset_mdrefr & MDREFR_DRI_MASK) > mdrefr_dri(new_freq_mem)) {
-		preset_mdrefr = (preset_mdrefr & ~MDREFR_DRI_MASK);
-		preset_mdrefr |= mdrefr_dri(new_freq_mem);
-	}
-	postset_mdrefr =
-		(postset_mdrefr & ~MDREFR_DRI_MASK) | mdrefr_dri(new_freq_mem);
-
-	/* If we're dividing the memory clock by two for the SDRAM clock, this
-	 * must be set prior to the change.  Clearing the divide must be done
-	 * after the change.
-	 */
-	if (pxa_freq_settings[idx].div2) {
-		preset_mdrefr  |= MDREFR_DB2_MASK;
-		postset_mdrefr |= MDREFR_DB2_MASK;
-	} else {
-		postset_mdrefr &= ~MDREFR_DB2_MASK;
-	}
-
-	local_irq_save(flags);
-
-	/* Set new the CCCR and prepare CCLKCFG */
-	writel(pxa_freq_settings[idx].cccr, CCCR);
-	cclkcfg = pxa_freq_settings[idx].cclkcfg;
-
-	asm volatile("							\n\
-		ldr	r4, [%1]		/* load MDREFR */	\n\
-		b	2f						\n\
-		.align	5						\n\
-1:									\n\
-		str	%3, [%1]		/* preset the MDREFR */	\n\
-		mcr	p14, 0, %2, c6, c0, 0	/* set CCLKCFG[FCS] */	\n\
-		str	%4, [%1]		/* postset the MDREFR */ \n\
-									\n\
-		b	3f						\n\
-2:		b	1b						\n\
-3:		nop							\n\
-	  "
-		     : "=&r" (unused)
-		     : "r" (MDREFR), "r" (cclkcfg),
-		       "r" (preset_mdrefr), "r" (postset_mdrefr)
-		     : "r4", "r5");
-	local_irq_restore(flags);
+	clk_set_rate(data->clk_core, new_freq_cpu * 1000);
 
 	/*
 	 * Even if voltage setting fails, we don't report it, as the frequency
@@ -369,8 +252,6 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 
 	pxa_cpufreq_init_voltages();
 
-	init_sdram_rows();
-
 	/* set default policy and cpuinfo */
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 
@@ -429,11 +310,17 @@ static struct cpufreq_driver pxa_cpufreq_driver = {
 	.init	= pxa_cpufreq_init,
 	.get	= pxa_cpufreq_get,
 	.name	= "PXA2xx",
+	.driver_data = &pxa_cpufreq_data,
 };
 
 static int __init pxa_cpu_init(void)
 {
 	int ret = -ENODEV;
+
+	pxa_cpufreq_data.clk_core = clk_get_sys(NULL, "core");
+	if (IS_ERR(pxa_cpufreq_data.clk_core))
+		return PTR_ERR(pxa_cpufreq_data.clk_core);
+
 	if (cpu_is_pxa25x() || cpu_is_pxa27x())
 		ret = cpufreq_register_driver(&pxa_cpufreq_driver);
 	return ret;
-- 
2.1.4
