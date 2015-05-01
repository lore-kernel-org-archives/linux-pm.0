From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V3 2/2 linux-next] cpufreq: pxa: make pxa_freqs arrays const
Date: Fri,  1 May 2015 10:34:01 +0200
Message-ID: <1430469241-30556-2-git-send-email-fabf@skynet.be>
References: <1430469241-30556-1-git-send-email-fabf@skynet.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailrelay114.isp.belgacom.be ([195.238.20.141]:16268 "EHLO
	mailrelay114.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750935AbbEAIeP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 04:34:15 -0400
In-Reply-To: <1430469241-30556-1-git-send-email-fabf@skynet.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Viresh Kumar <viresh.kumar@linaro.org>, Fabian Frederick <fabf@skynet.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

pxa255_run_freqs and pxa255_turbo_freqs are only read.
This patch updates arrays declaration, find_freq_tables()
and its callsites.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
Compiled but untested.

 drivers/cpufreq/pxa2xx-cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index fcf6e34..1d99c97 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -86,7 +86,7 @@ static unsigned int sdram_rows;
 /* Use the run mode frequencies for the CPUFREQ_POLICY_PERFORMANCE policy */
 #define CCLKCFG			CCLKCFG_TURBO | CCLKCFG_FCS
 
-static struct pxa_freqs pxa255_run_freqs[] =
+static const struct pxa_freqs pxa255_run_freqs[] =
 {
 	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	           run  turbo PXbus SDRAM */
 	{ 99500,  99500, 0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
@@ -98,7 +98,7 @@ static struct pxa_freqs pxa255_run_freqs[] =
 };
 
 /* Use the turbo mode frequencies for the CPUFREQ_POLICY_POWERSAVE policy */
-static struct pxa_freqs pxa255_turbo_freqs[] =
+static const struct pxa_freqs pxa255_turbo_freqs[] =
 {
 	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	   run  turbo PXbus SDRAM */
 	{ 99500, 99500,  0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
@@ -171,7 +171,7 @@ extern unsigned get_clk_frequency_khz(int info);
 
 #ifdef CONFIG_REGULATOR
 
-static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
+static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
 {
 	int ret = 0;
 	int vmin, vmax;
@@ -211,7 +211,7 @@ static void __init pxa_cpufreq_init_voltages(void) { }
 #endif
 
 static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
-			     struct pxa_freqs **pxa_freqs)
+			     const struct pxa_freqs **pxa_freqs)
 {
 	if (cpu_is_pxa25x()) {
 		if (!pxa255_turbo_table) {
@@ -270,7 +270,7 @@ static unsigned int pxa_cpufreq_get(unsigned int cpu)
 static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct cpufreq_frequency_table *pxa_freqs_table;
-	struct pxa_freqs *pxa_freq_settings;
+	const struct pxa_freqs *pxa_freq_settings;
 	unsigned long flags;
 	unsigned int new_freq_cpu, new_freq_mem;
 	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
@@ -361,7 +361,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 	int i;
 	unsigned int freq;
 	struct cpufreq_frequency_table *pxa255_freq_table;
-	struct pxa_freqs *pxa255_freqs;
+	const struct pxa_freqs *pxa255_freqs;
 
 	/* try to guess pxa27x cpu */
 	if (cpu_is_pxa27x())
-- 
1.9.1

