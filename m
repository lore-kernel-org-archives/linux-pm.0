From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 157/228] cpufreq: elanfreq: Convert to light weight ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:43 +0530
Message-ID: <47f3f56316c9848750e1dc3328348391b1aa645f.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index d91a645..4ab4153 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -105,20 +105,8 @@ static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
 }
 
 
-/**
- *	elanfreq_set_cpu_frequency: Change the CPU core frequency
- *	@cpu: cpu number
- *	@freq: frequency in kHz
- *
- *	This function takes a frequency value and changes the CPU frequency
- *	according to this. Note that the frequency has to be checked by
- *	elanfreq_validatespeed() for correctness!
- *
- *	There is no return value.
- */
-
-static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int state)
+static int elanfreq_target(struct cpufreq_policy *policy,
+			    unsigned int state)
 {
 	struct cpufreq_freqs    freqs;
 
@@ -162,25 +150,9 @@ static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
 	local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-
-static int elanfreq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target(policy, &elanfreq_table[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
-	elanfreq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
-
-
 /*
  *	Module init and exit code
  */
@@ -237,7 +209,7 @@ __setup("elanfreq=", elanfreq_setup);
 static struct cpufreq_driver elanfreq_driver = {
 	.get		= elanfreq_get_cpu_frequency,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= elanfreq_target,
+	.target_index	= elanfreq_target,
 	.init		= elanfreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= "elanfreq",
-- 
1.7.12.rc2.18.g61b472e
