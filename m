From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/20] cpufreq: Don't clear cpufreq_cpu_data and policy list for inactive policies
Date: Thu, 19 Feb 2015 17:02:10 +0530
Message-ID: <7bf6a7ce048290ec871c608883f9c9908adc5345.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34881 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbBSLdx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:53 -0500
Received: by padfa1 with SMTP id fa1so8896278pad.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:53 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Now that we can check policy->cpus to find if policy is active or not, we don't
need to clean cpufreq_cpu_data and delete policy from the list on light weight
tear down of policies (like in suspend).

To make it consistent and clean, set cpufreq_cpu_data for all related CPUs when
the policy is first created and clean it only while it is freed.

Also update cpufreq_cpu_get_raw() to check if cpu is part of policy->cpus mask,
so that we don't end up getting policies for unmanaged CPUs.

In order to make sure that no users of 'policy' are using an inactive policy,
use cpufreq_cpu_get_raw() instead of directly accessing cpufreq_cpu_data.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 79 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e728c796c327..e27b2a7bd9b3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -250,10 +250,18 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
-unsigned int cpufreq_generic_get(unsigned int cpu)
+/* Only for cpufreq core internal use */
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
+	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
+}
+
+unsigned int cpufreq_generic_get(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+
 	if (!policy || IS_ERR(policy->clk)) {
 		pr_err("%s: No %s associated to cpu: %d\n",
 		       __func__, policy ? "clk" : "policy", cpu);
@@ -264,12 +272,6 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_get);
 
-/* Only for cpufreq core internal use */
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
-{
-	return per_cpu(cpufreq_cpu_data, cpu);
-}
-
 /**
  * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
  *
@@ -303,7 +305,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	if (cpufreq_driver) {
 		/* get the CPU */
-		policy = per_cpu(cpufreq_cpu_data, cpu);
+		policy = cpufreq_cpu_get_raw(cpu);
 		if (policy)
 			kobject_get(&policy->kobj);
 	}
@@ -1053,7 +1055,6 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 				  unsigned int cpu, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 
 	/* Is cpu already managed ? */
 	if (cpumask_test_cpu(cpu, policy->cpus))
@@ -1068,13 +1069,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 	}
 
 	down_write(&policy->rwsem);
-
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-
 	cpumask_set_cpu(cpu, policy->cpus);
-	per_cpu(cpufreq_cpu_data, cpu) = policy;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	up_write(&policy->rwsem);
 
 	if (has_target()) {
@@ -1165,6 +1160,17 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
 
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
+	unsigned long flags;
+	int cpu;
+
+	/* Remove policy from list */
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	list_del(&policy->policy_list);
+
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(cpufreq_cpu_data, cpu) = NULL;
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1286,12 +1292,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 			       __func__, ret);
 			goto err_init_policy_kobj;
 		}
-	}
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_cpu(j, policy->cpus)
-		per_cpu(cpufreq_cpu_data, j) = policy;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		for_each_cpu(j, policy->related_cpus)
+			per_cpu(cpufreq_cpu_data, j) = policy;
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
 		policy->cur = cpufreq_driver->get(policy->cpu);
@@ -1350,11 +1356,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 			goto err_out_unregister;
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
-	}
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	list_add(&policy->policy_list, &cpufreq_policy_list);
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		list_add(&policy->policy_list, &cpufreq_policy_list);
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	}
 
 	cpufreq_init_policy(policy);
 
@@ -1378,11 +1384,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 err_out_unregister:
 err_get_freq:
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_cpu(j, policy->cpus)
-		per_cpu(cpufreq_cpu_data, j) = NULL;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	if (!recover_policy) {
 		kobject_put(&policy->kobj);
 		wait_for_completion(&policy->kobj_unregister);
@@ -1418,7 +1419,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
-	policy = per_cpu(cpufreq_cpu_data, cpu);
+	policy = cpufreq_cpu_get_raw(cpu);
 
 	/* Save the policy somewhere when doing a light-weight tear-down */
 	if (cpufreq_suspended)
@@ -1476,15 +1477,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 static int __cpufreq_remove_dev_finish(struct device *dev,
 				       struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id, cpus;
+	unsigned int cpu = dev->id;
 	int ret;
-	unsigned long flags;
-	struct cpufreq_policy *policy;
-
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	policy = per_cpu(cpufreq_cpu_data, cpu);
-	per_cpu(cpufreq_cpu_data, cpu) = NULL;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
@@ -1492,12 +1487,11 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	}
 
 	down_write(&policy->rwsem);
-	cpus = cpumask_weight(policy->cpus);
 	cpumask_clear_cpu(cpu, policy->cpus);
 	up_write(&policy->rwsem);
 
 	/* If cpu is last user of policy, free policy */
-	if (cpus == 1) {
+	if (policy_is_inactive(policy)) {
 		if (has_target()) {
 			ret = __cpufreq_governor(policy,
 					CPUFREQ_GOV_POLICY_EXIT);
@@ -1519,11 +1513,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		if (cpufreq_driver->exit)
 			cpufreq_driver->exit(policy);
 
-		/* Remove policy from list of active policies */
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		list_del(&policy->policy_list);
-		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 		if (!cpufreq_suspended)
 			cpufreq_policy_free(policy);
 	} else if (has_target()) {
-- 
2.3.0.rc0.44.ga94655d

