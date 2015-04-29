From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t by structure
Date: Wed, 29 Apr 2015 21:32:59 +0200
Message-ID: <1430335980-9765-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

typedef is not really useful here. Replace it by structure
to improve readability.typedef should only be used in some cases.
(See Documentation/CodingStyle Chapter 5 for details).

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2: verbose changelog.

 drivers/cpufreq/pxa2xx-cpufreq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index e24269a..fcf6e34 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -56,7 +56,7 @@ module_param(pxa27x_maxfreq, uint, 0);
 MODULE_PARM_DESC(pxa27x_maxfreq, "Set the pxa27x maxfreq in MHz"
 		 "(typically 624=>pxa270, 416=>pxa271, 520=>pxa272)");
 
-typedef struct {
+struct pxa_freqs {
 	unsigned int khz;
 	unsigned int membus;
 	unsigned int cccr;
@@ -64,7 +64,7 @@ typedef struct {
 	unsigned int cclkcfg;
 	int vmin;
 	int vmax;
-} pxa_freqs_t;
+};
 
 /* Define the refresh period in mSec for the SDRAM and the number of rows */
 #define SDRAM_TREF	64	/* standard 64ms SDRAM */
@@ -86,7 +86,7 @@ static unsigned int sdram_rows;
 /* Use the run mode frequencies for the CPUFREQ_POLICY_PERFORMANCE policy */
 #define CCLKCFG			CCLKCFG_TURBO | CCLKCFG_FCS
 
-static pxa_freqs_t pxa255_run_freqs[] =
+static struct pxa_freqs pxa255_run_freqs[] =
 {
 	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	           run  turbo PXbus SDRAM */
 	{ 99500,  99500, 0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
@@ -98,7 +98,7 @@ static pxa_freqs_t pxa255_run_freqs[] =
 };
 
 /* Use the turbo mode frequencies for the CPUFREQ_POLICY_POWERSAVE policy */
-static pxa_freqs_t pxa255_turbo_freqs[] =
+static struct pxa_freqs pxa255_turbo_freqs[] =
 {
 	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	   run  turbo PXbus SDRAM */
 	{ 99500, 99500,  0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
@@ -153,7 +153,7 @@ MODULE_PARM_DESC(pxa255_turbo_table, "Selects the frequency table (0 = run table
    ((HT) ? CCLKCFG_HALFTURBO : 0) | \
    ((T)  ? CCLKCFG_TURBO : 0))
 
-static pxa_freqs_t pxa27x_freqs[] = {
+static struct pxa_freqs pxa27x_freqs[] = {
 	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0, CCLKCFG2(1, 0, 1),  900000, 1705000 },
 	{156000, 104000, PXA27x_CCCR(1,	 8, 3), 0, CCLKCFG2(1, 0, 1), 1000000, 1705000 },
 	{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, CCLKCFG2(0, 0, 1), 1180000, 1705000 },
@@ -171,7 +171,7 @@ extern unsigned get_clk_frequency_khz(int info);
 
 #ifdef CONFIG_REGULATOR
 
-static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
+static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
 {
 	int ret = 0;
 	int vmin, vmax;
@@ -202,7 +202,7 @@ static void __init pxa_cpufreq_init_voltages(void)
 	}
 }
 #else
-static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
+static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
 {
 	return 0;
 }
@@ -211,7 +211,7 @@ static void __init pxa_cpufreq_init_voltages(void) { }
 #endif
 
 static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
-			     pxa_freqs_t **pxa_freqs)
+			     struct pxa_freqs **pxa_freqs)
 {
 	if (cpu_is_pxa25x()) {
 		if (!pxa255_turbo_table) {
@@ -270,7 +270,7 @@ static unsigned int pxa_cpufreq_get(unsigned int cpu)
 static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct cpufreq_frequency_table *pxa_freqs_table;
-	pxa_freqs_t *pxa_freq_settings;
+	struct pxa_freqs *pxa_freq_settings;
 	unsigned long flags;
 	unsigned int new_freq_cpu, new_freq_mem;
 	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
@@ -361,7 +361,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 	int i;
 	unsigned int freq;
 	struct cpufreq_frequency_table *pxa255_freq_table;
-	pxa_freqs_t *pxa255_freqs;
+	struct pxa_freqs *pxa255_freqs;
 
 	/* try to guess pxa27x cpu */
 	if (cpu_is_pxa27x())
-- 
1.9.1
