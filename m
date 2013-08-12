From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/31] cpufreq: elanfreq: Covert to light weight ->target() routine
Date: Mon, 12 Aug 2013 23:18:47 +0530
Message-ID: <cdec5c1bb673c7951718e9fa691d08a8e58cf175.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target_old() to newly defined light weight
.target() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/elanfreq.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index cf73815..58f5669 100644
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
-	.target_old	= elanfreq_target,
+	.target		= elanfreq_target,
 	.init		= elanfreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= "elanfreq",
-- 
1.7.12.rc2.18.g61b472e
