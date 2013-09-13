From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 171/228] cpufreq: pxa: Convert to light weight
 ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:57 +0530
Message-ID: <90a04e89554fc0e07e9354f1bc165c52aaeef2be.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, Eric Miao <eric.y.miao@gmail.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 13 ++-----------
 drivers/cpufreq/pxa3xx-cpufreq.c | 17 +++--------------
 2 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 29aca57..183bc13 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -267,14 +267,11 @@ static unsigned int pxa_cpufreq_get(unsigned int cpu)
 	return get_clk_frequency_khz(0);
 }
 
-static int pxa_set_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct cpufreq_frequency_table *pxa_freqs_table;
 	pxa_freqs_t *pxa_freq_settings;
 	struct cpufreq_freqs freqs;
-	unsigned int idx;
 	unsigned long flags;
 	unsigned int new_freq_cpu, new_freq_mem;
 	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
@@ -283,12 +280,6 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	/* Get the current policy */
 	find_freq_tables(&pxa_freqs_table, &pxa_freq_settings);
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, pxa_freqs_table,
-					   target_freq, relation, &idx)) {
-		return -EINVAL;
-	}
-
 	new_freq_cpu = pxa_freq_settings[idx].khz;
 	new_freq_mem = pxa_freq_settings[idx].membus;
 	freqs.old = policy->cur;
@@ -448,7 +439,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver pxa_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= pxa_set_target,
+	.target_index = pxa_set_target,
 	.init	= pxa_cpufreq_init,
 	.exit	= cpufreq_generic_exit,
 	.get	= pxa_cpufreq_get,
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 47fbee4..132e37d 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -155,24 +155,16 @@ static unsigned int pxa3xx_cpufreq_get(unsigned int cpu)
 	return pxa3xx_get_clk_frequency_khz(0);
 }
 
-static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct pxa3xx_freq_info *next;
 	struct cpufreq_freqs freqs;
 	unsigned long flags;
-	int idx;
 
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, pxa3xx_freqs_table,
-				target_freq, relation, &idx))
-		return -EINVAL;
-
-	next = &pxa3xx_freqs[idx];
+	next = &pxa3xx_freqs[index];
 
 	freqs.old = policy->cur;
 	freqs.new = next->cpufreq_mhz * 1000;
@@ -181,9 +173,6 @@ static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
 			freqs.old / 1000, freqs.new / 1000,
 			(freqs.old == freqs.new) ? " (skipped)" : "");
 
-	if (freqs.old == target_freq)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	local_irq_save(flags);
@@ -225,7 +214,7 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver pxa3xx_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= pxa3xx_cpufreq_set,
+	.target_index	= pxa3xx_cpufreq_set,
 	.init		= pxa3xx_cpufreq_init,
 	.exit		= cpufreq_generic_exit,
 	.get		= pxa3xx_cpufreq_get,
-- 
1.7.12.rc2.18.g61b472e
