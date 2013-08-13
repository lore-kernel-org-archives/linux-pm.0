From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/35] cpufreq: elanfreq: Covert to light weight ->target_index() routine
Date: Tue, 13 Aug 2013 19:02:25 +0530
Message-ID: <0a825b2230fe4609d1d50b9e18515ab983867232.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
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
index fe7053c..0d133a7 100644
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
@@ -238,7 +210,7 @@ __setup("elanfreq=", elanfreq_setup);
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
