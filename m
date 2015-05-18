From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 02/14] cpufreq: Don't clear cpufreq_cpu_data and policy list for inactive policies
Date: Mon, 18 May 2015 10:43:25 +0530
Message-ID: <752c0ce6e975112cdd05e9b5a4fa48345154ba83.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34953 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbERFN5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:13:57 -0400
Received: by pacwv17 with SMTP id wv17so136011549pac.2
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:13:57 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Now that we can check policy->cpus to find if policy is active or not,
we don't need to clean cpufreq_cpu_data and delete policy from the list
on light weight tear down of policies (like in suspend).

To make it consistent and clean, set cpufreq_cpu_data for all related
CPUs when the policy is first created and clean it only while it is
freed.

Also update cpufreq_cpu_get_raw() to check if cpu is part of
policy->cpus mask, so that we don't end up getting policies for offline
CPUs.

In order to make sure that no users of 'policy' are using an inactive
policy, use cpufreq_cpu_get_raw() instead of directly accessing
cpufreq_cpu_data.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 79 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 74d9fcbbe4f9..e899a5446d0e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -239,10 +239,18 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
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
@@ -253,12 +261,6 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
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
@@ -292,7 +294,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	if (cpufreq_driver) {
 		/* get the CPU */
-		policy = per_cpu(cpufreq_cpu_data, cpu);
+		policy = cpufreq_cpu_get_raw(cpu);
 		if (policy)
 			kobject_get(&policy->kobj);
 	}
@@ -1042,7 +1044,6 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 				  unsigned int cpu, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 
 	/* Has this CPU been taken care of already? */
 	if (cpumask_test_cpu(cpu, policy->cpus))
@@ -1057,13 +1058,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
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
@@ -1154,6 +1149,17 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
 
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
@@ -1275,12 +1281,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -1339,11 +1345,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
 
@@ -1367,11 +1373,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
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
@@ -1407,7 +1408,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
-	policy = per_cpu(cpufreq_cpu_data, cpu);
+	policy = cpufreq_cpu_get_raw(cpu);
 
 	/* Save the policy somewhere when doing a light-weight tear-down */
 	if (cpufreq_suspended)
@@ -1465,15 +1466,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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
@@ -1481,12 +1476,11 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
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
@@ -1508,11 +1502,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
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
2.4.0

