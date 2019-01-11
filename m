From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: Implement USER constraint
Date: Fri, 11 Jan 2019 14:48:36 +0530
Message-ID: <616457a8af14cb152a85e8e3b2b4c2eb54a38e09.1547197612.git.viresh.kumar@linaro.org>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This implements the FREQ_CONSTRAINT_USER constraint and removes the old
style of doing the same. We just need to update the constraint on any
modifications to scaling_{min|max}_frequency and the freq-constraint
core will call cpufreq's callback which will call cpufreq_set_policy()
eventually.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 62 ++++++++++++++++++-----------------------------
 include/linux/cpufreq.h   |  8 ++----
 2 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 63028612d011..6f66e1261b65 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -685,22 +685,15 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	int ret, temp;							\
-	struct cpufreq_policy new_policy;				\
+	unsigned long min = policy->min, max = policy->max;		\
+	int ret;							\
 									\
-	memcpy(&new_policy, policy, sizeof(*policy));			\
-	new_policy.min = policy->user_policy.min;			\
-	new_policy.max = policy->user_policy.max;			\
-									\
-	ret = sscanf(buf, "%u", &new_policy.object);			\
+	ret = sscanf(buf, "%lu", &object);				\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	temp = new_policy.object;					\
-	ret = cpufreq_set_policy(policy, &new_policy);		\
-	if (!ret)							\
-		policy->user_policy.object = temp;			\
-									\
+	ret = freq_constraint_update(get_cpu_device(policy->cpu),	\
+				     policy->user_fc, min, max);	\
 	return ret ? ret : count;					\
 }
 
@@ -1164,6 +1157,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	if (!IS_ERR(policy->user_fc))
+		freq_constraint_remove(get_cpu_device(policy->cpu),
+				       policy->user_fc);
 	freq_constraint_remove_cpumask_callback(policy->related_cpus);
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1177,9 +1173,6 @@ static void freq_constraint_callback(void *param)
 	struct cpufreq_policy *policy = param;
 	struct cpufreq_policy new_policy = *policy;
 
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
 	down_write(&policy->rwsem);
 	if (policy_is_inactive(policy))
 		goto unlock;
@@ -1249,9 +1242,6 @@ static int cpufreq_online(unsigned int cpu)
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
-
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
@@ -1264,9 +1254,15 @@ static int cpufreq_online(unsigned int cpu)
 			       ret, cpumask_pr_args(policy->cpus));
 			goto out_destroy_policy;
 		}
-	} else {
-		policy->min = policy->user_policy.min;
-		policy->max = policy->user_policy.max;
+
+		policy->user_fc = freq_constraint_add(get_cpu_device(cpu),
+						      FREQ_CONSTRAINT_USER,
+						      policy->min, policy->max);
+		if (IS_ERR(policy->user_fc)) {
+			ret = PTR_ERR(policy->user_fc);
+			pr_err("Failed to add user constraint: %d\n", ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
@@ -2235,13 +2231,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	/*
-	* This check works well when we store new min/max freq attributes,
-	* because new_policy is a copy of policy with one field updated.
-	*/
-	if (new_policy->min > new_policy->max)
-		return -EINVAL;
-
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
@@ -2251,10 +2240,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret) {
 		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
 	} else {
-		if (fc_min > new_policy->min)
-			new_policy->min = fc_min;
-		if (fc_max < new_policy->max)
-			new_policy->max = fc_max;
+		new_policy->min = fc_min;
+		new_policy->max = fc_max;
 	}
 
 	/*
@@ -2356,8 +2343,6 @@ void cpufreq_update_policy(unsigned int cpu)
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
 
 	/*
 	 * BIOS might change freq behind our back
@@ -2401,10 +2386,11 @@ static int cpufreq_boost_set_sw(int state)
 			break;
 		}
 
-		down_write(&policy->rwsem);
-		policy->user_policy.max = policy->max;
-		cpufreq_governor_limits(policy);
-		up_write(&policy->rwsem);
+		ret = freq_constraint_update(get_cpu_device(policy->cpu),
+					     policy->user_fc, policy->min,
+					     policy->max);
+		if (ret)
+			break;
 	}
 
 	return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..62bf33aafc6c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
+#include <linux/freq_constraint.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
@@ -57,11 +58,6 @@ struct cpufreq_cpuinfo {
 	unsigned int		transition_latency;
 };
 
-struct cpufreq_user_policy {
-	unsigned int		min;    /* in kHz */
-	unsigned int		max;    /* in kHz */
-};
-
 struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
@@ -91,7 +87,7 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct cpufreq_user_policy user_policy;
+	struct freq_constraint	*user_fc;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.7.4
