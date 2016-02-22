From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: Rename __cpufreq_governor() to cpufreq_governor()
Date: Mon, 22 Feb 2016 16:36:43 +0530
Message-ID: <802374523687ba83e5717fbb7ccff140d772108e.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The __ at the beginning of the routine aren't really necessary at all.
Rename it to cpufreq_governor() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3689b4dff967..fa070bf87dd8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -118,8 +118,7 @@ static inline bool has_target(void)
 }
 
 /* internal prototypes */
-static int __cpufreq_governor(struct cpufreq_policy *policy,
-		unsigned int event);
+static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 
 /**
@@ -999,7 +998,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 
 	down_write(&policy->rwsem);
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
 			goto unlock;
@@ -1009,9 +1008,9 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	cpumask_set_cpu(cpu, policy->cpus);
 
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			ret = cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
 		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
@@ -1333,7 +1332,7 @@ static void cpufreq_offline(unsigned int cpu)
 
 	down_write(&policy->rwsem);
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
 	}
@@ -1354,9 +1353,9 @@ static void cpufreq_offline(unsigned int cpu)
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
 			if (!ret)
-				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+				ret = cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
 			if (ret)
 				pr_err("%s: Failed to start governor\n", __func__);
@@ -1370,7 +1369,7 @@ static void cpufreq_offline(unsigned int cpu)
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
 	}
@@ -1586,7 +1585,7 @@ void cpufreq_suspend(void)
 
 	for_each_active_policy(policy) {
 		down_write(&policy->rwsem);
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		up_write(&policy->rwsem);
 
 		if (ret)
@@ -1629,9 +1628,9 @@ void cpufreq_resume(void)
 				policy);
 		} else {
 			down_write(&policy->rwsem);
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
 			if (!ret)
-				__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+				cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 			up_write(&policy->rwsem);
 
 			if (ret)
@@ -1928,8 +1927,7 @@ __weak struct cpufreq_governor *cpufreq_fallback_governor(void)
 	return NULL;
 }
 
-static int __cpufreq_governor(struct cpufreq_policy *policy,
-					unsigned int event)
+static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
 {
 	int ret;
 
@@ -2141,7 +2139,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			/* This can happen due to race with other operations */
 			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
@@ -2149,7 +2147,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			return ret;
 		}
 
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		if (ret) {
 			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
 			       __func__, old_gov->name, ret);
@@ -2159,30 +2157,30 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
-	ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
+	ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
 	if (!ret) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+		ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
 			goto out;
 
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 	}
 
 	/* new governor failed, so re-start old one */
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+		if (cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
 			policy->governor = NULL;
 		else
-			__cpufreq_governor(policy, CPUFREQ_GOV_START);
+			cpufreq_governor(policy, CPUFREQ_GOV_START);
 	}
 
 	return ret;
 
  out:
 	pr_debug("governor: change or update limits\n");
-	return __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	return cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 }
 
 /**
@@ -2285,7 +2283,7 @@ static int cpufreq_boost_set_sw(int state)
 
 			down_write(&policy->rwsem);
 			policy->user_policy.max = policy->max;
-			__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 			up_write(&policy->rwsem);
 		}
 	}
-- 
2.7.1.410.g6faf27b
