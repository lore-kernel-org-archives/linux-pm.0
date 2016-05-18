From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/6] cpufreq: governor: Create cpufreq_policy_apply_limits()
Date: Wed, 18 May 2016 17:55:31 +0530
Message-ID: <6f25deee2fff9e5f5081e457d606d85d670fa7ed.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Create a new helper to avoid code duplication across governors.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 7 +------
 include/linux/cpufreq.h            | 8 ++++++++
 kernel/sched/cpufreq_schedutil.c   | 9 +--------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 45ca5aff88b2..10cf91cadb97 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -551,12 +551,7 @@ static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
 	mutex_lock(&policy_dbs->timer_mutex);
-
-	if (policy->max < policy->cur)
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
-	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
-
+	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->timer_mutex);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index fe4c48b0fa40..2c0c5177f3e1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -493,6 +493,14 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
+static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
+{
+	if (policy->max < policy->cur)
+		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+	else if (policy->min > policy->cur)
+		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+}
+
 /* Governor attribute set */
 struct gov_attr_set {
 	struct kobject kobj;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4035765deafc..7699f88234ce 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -465,14 +465,7 @@ static int sugov_limits(struct cpufreq_policy *policy)
 
 	if (!policy->fast_switch_enabled) {
 		mutex_lock(&sg_policy->work_lock);
-
-		if (policy->max < policy->cur)
-			__cpufreq_driver_target(policy, policy->max,
-						CPUFREQ_RELATION_H);
-		else if (policy->min > policy->cur)
-			__cpufreq_driver_target(policy, policy->min,
-						CPUFREQ_RELATION_L);
-
+		cpufreq_policy_apply_limits(policy);
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-- 
2.7.1.410.g6faf27b
