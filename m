From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 11/35] cpufreq: e_powersaver: Covert to light weight ->target_index() routine
Date: Tue, 13 Aug 2013 19:02:24 +0530
Message-ID: <3c28e02820bf453e6584eeb9e7cdd46cbb200c7c.1376392602.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/e_powersaver.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index a8cbbd0..60cd576 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -168,12 +168,9 @@ postchange:
 	return err;
 }
 
-static int eps_target(struct cpufreq_policy *policy,
-			       unsigned int target_freq,
-			       unsigned int relation)
+static int eps_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct eps_cpu_data *centaur;
-	unsigned int newstate = 0;
 	unsigned int cpu = policy->cpu;
 	unsigned int dest_state;
 	int ret;
@@ -182,16 +179,8 @@ static int eps_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 	centaur = eps_cpu[cpu];
 
-	if (unlikely(cpufreq_frequency_table_target(policy,
-			&eps_cpu[cpu]->freq_table[0],
-			target_freq,
-			relation,
-			&newstate))) {
-		return -EINVAL;
-	}
-
 	/* Make frequency transition */
-	dest_state = centaur->freq_table[newstate].driver_data & 0xffff;
+	dest_state = centaur->freq_table[index].driver_data & 0xffff;
 	ret = eps_set_state(centaur, policy, dest_state);
 	if (ret)
 		printk(KERN_ERR "eps: Timeout!\n");
@@ -419,7 +408,7 @@ static int eps_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver eps_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= eps_target,
+	.target_index	= eps_target,
 	.init		= eps_cpu_init,
 	.exit		= eps_cpu_exit,
 	.get		= eps_get,
-- 
1.7.12.rc2.18.g61b472e
