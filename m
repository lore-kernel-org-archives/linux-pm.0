From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/5] cpufreq: Add QoS requests for userspace constraints
Date: Thu, 21 Feb 2019 16:59:31 +0530
Message-ID: <be0b3a7637fba0d02fdc0571133cd01edd34fb0e.1550748118.git.viresh.kumar@linaro.org>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, Qais.Yousef@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This implements QoS requests to manage userspace configuration of min
and max frequency.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 93 +++++++++++++++++++--------------------
 include/linux/cpufreq.h   |  8 +---
 2 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d615bf35ac00..403e4540aea7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -686,23 +686,15 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	int ret, temp;							\
-	struct cpufreq_policy new_policy;				\
+	unsigned long val;						\
+	int ret;							\
 									\
-	memcpy(&new_policy, policy, sizeof(*policy));			\
-	new_policy.min = policy->user_policy.min;			\
-	new_policy.max = policy->user_policy.max;			\
-									\
-	ret = sscanf(buf, "%u", &new_policy.object);			\
+	ret = sscanf(buf, "%lu", &val);					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	temp = new_policy.object;					\
-	ret = cpufreq_set_policy(policy, &new_policy);		\
-	if (!ret)							\
-		policy->user_policy.object = temp;			\
-									\
-	return ret ? ret : count;					\
+	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
+	return ret && ret != 1 ? ret : count;				\
 }
 
 store_one(scaling_min_freq, min);
@@ -1089,10 +1081,6 @@ static void cpufreq_update_freq_work(struct work_struct *work)
 		container_of(work, struct cpufreq_policy, req_work);
 	struct cpufreq_policy new_policy = *policy;
 
-	/* We should read constraint values from QoS layer */
-	new_policy.min = 0;
-	new_policy.max = UINT_MAX;
-
 	down_write(&policy->rwsem);
 
 	if (!policy_is_inactive(policy))
@@ -1193,6 +1181,12 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_min_qos_notifier;
 	}
 
+	policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+				       GFP_KERNEL);
+	if (!policy->min_freq_req)
+		goto err_max_qos_notifier;
+
+	policy->max_freq_req = policy->min_freq_req + 1;
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1204,6 +1198,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_max_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
@@ -1239,6 +1236,10 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(policy->max_freq_req);
+	dev_pm_qos_remove_request(policy->min_freq_req);
+	kfree(policy->min_freq_req);
+
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -1316,16 +1317,30 @@ static int cpufreq_online(unsigned int cpu)
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
+		struct device *dev = get_cpu_device(cpu);
 
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
 		}
-	} else {
-		policy->min = policy->user_policy.min;
-		policy->max = policy->user_policy.max;
+
+		ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
+					     DEV_PM_QOS_MIN_FREQUENCY,
+					     policy->min);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add min-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
+
+		ret = dev_pm_qos_add_request(dev, policy->max_freq_req,
+					     DEV_PM_QOS_MAX_FREQUENCY,
+					     policy->max);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add max-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
@@ -2315,7 +2330,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_governor *old_gov;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2323,20 +2337,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	/*
-	* This check works well when we store new min/max freq attributes,
-	* because new_policy is a copy of policy with one field updated.
-	*/
-	if (new_policy->min > new_policy->max)
-		return -EINVAL;
-
-	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
-	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
-
-	if (min > new_policy->min)
-		new_policy->min = min;
-	if (max < new_policy->max)
-		new_policy->max = max;
+	/* Start with min/max as seen by QoS framework */
+	new_policy->min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	new_policy->max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
@@ -2425,10 +2428,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
  * @cpu: CPU to re-evaluate the policy for.
  *
  * Update the current frequency for the cpufreq policy of @cpu and use
- * cpufreq_set_policy() to re-apply the min and max limits saved in the
- * user_policy sub-structure of that policy, which triggers the evaluation
- * of policy notifiers and the cpufreq driver's ->verify() callback for the
- * policy in question, among other things.
+ * cpufreq_set_policy() to re-apply the min and max limits, which triggers the
+ * evaluation of policy notifiers and the cpufreq driver's ->verify() callback
+ * for the policy in question, among other things.
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
@@ -2453,8 +2455,6 @@ void cpufreq_update_policy(unsigned int cpu)
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
 
 	cpufreq_set_policy(policy, &new_policy);
 
@@ -2485,10 +2485,9 @@ static int cpufreq_boost_set_sw(int state)
 			break;
 		}
 
-		down_write(&policy->rwsem);
-		policy->user_policy.max = policy->max;
-		cpufreq_governor_limits(policy);
-		up_write(&policy->rwsem);
+		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
+		if (ret)
+			break;
 	}
 
 	return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f8f48d8a9b52..fc167a982c64 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -57,11 +57,6 @@ struct cpufreq_cpuinfo {
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
@@ -92,7 +87,8 @@ struct cpufreq_policy {
 					 * called, but you're in IRQ context */
 	struct work_struct	req_work;
 
-	struct cpufreq_user_policy user_policy;
+	struct dev_pm_qos_request *min_freq_req;
+	struct dev_pm_qos_request *max_freq_req;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.21.0.rc0.269.g1a574e7a288b
