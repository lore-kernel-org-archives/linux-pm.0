From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 6/8] cpufreq: Drop 'freq_table' argument of __target_index()
Date: Fri,  3 Jun 2016 10:58:50 +0530
Message-ID: <8a338cbe37e80bd569d41136e9ba78c927e4429d.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It is already present as part of the policy and so no need to pass it
from the caller. Also, 'freq_table' is guaranteed to be valid in this
function and so no need to check it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e68611a67bd9..30f05dd5c872 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1852,14 +1852,17 @@ static int __target_intermediate(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int __target_index(struct cpufreq_policy *policy,
-			  struct cpufreq_frequency_table *freq_table, int index)
+static int __target_index(struct cpufreq_policy *policy, int index)
 {
 	struct cpufreq_freqs freqs = {.old = policy->cur, .flags = 0};
 	unsigned int intermediate_freq = 0;
+	unsigned int newfreq = policy->freq_table[index].frequency;
 	int retval = -EINVAL;
 	bool notify;
 
+	if (newfreq == policy->cur)
+		return 0;
+
 	notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
 	if (notify) {
 		/* Handle switching to intermediate frequency */
@@ -1874,7 +1877,7 @@ static int __target_index(struct cpufreq_policy *policy,
 				freqs.old = freqs.new;
 		}
 
-		freqs.new = freq_table[index].frequency;
+		freqs.new = newfreq;
 		pr_debug("%s: cpu: %d, oldfreq: %u, new freq: %u\n",
 			 __func__, policy->cpu, freqs.old, freqs.new);
 
@@ -1911,7 +1914,6 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	struct cpufreq_frequency_table *freq_table;
 	int index, retval;
 
 	if (cpufreq_disabled())
@@ -1941,12 +1943,6 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	freq_table = policy->freq_table;
-	if (unlikely(!freq_table)) {
-		pr_err("%s: Unable to find freq_table\n", __func__);
-		return -EINVAL;
-	}
-
 	retval = cpufreq_frequency_table_target(policy, target_freq, relation,
 						&index);
 	if (unlikely(retval)) {
@@ -1954,10 +1950,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		return retval;
 	}
 
-	if (freq_table[index].frequency == policy->cur)
-		return 0;
-
-	return __target_index(policy, freq_table, index);
+	return __target_index(policy, index);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-- 
2.7.1.410.g6faf27b
