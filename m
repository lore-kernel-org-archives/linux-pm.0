From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/18] cpufreq: Stop migrating sysfs files on hotplug
Date: Tue, 27 Jan 2015 14:06:18 +0530
Message-ID: <39d0361947308678774fb5f23f037bd8dd5acdf9.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56870 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884AbbA0Ih0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:26 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so17618194pde.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:26 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

When we hot-unplug a cpu, we remove its sysfs cpufreq directory and if the
outgoing cpu was the owner of policy->kobj earlier then we migrate the sysfs
directory to under another online cpu.

There are few disadvantages this brings:
- Code Complexity
- Slower hotplug/suspend/resume
- sysfs file permissions are reset after all policy->cpus are offlined
- CPUFreq stats history lost after all policy->cpus are offlined
- Special management of sysfs stuff during suspend/resume

To overcome these, this patch modifies the way sysfs directories are managed:
- Select sysfs kobjects owner while initializing policy and don't change it
  during hotplugs. Track it with kobj_cpu created earlier.

- Create symlinks for all related CPUs (can be offline) instead of affected CPUs
  on policy initialization and remove them only when the policy is freed.

- Free policy structure only on the removal of cpufreq-driver and not during
  hotplug/suspend/resume, detected by checking 'struct subsys_interface *'
  (Valid only when called from subsys_interface_unregister() while unregistering
  driver).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 176 ++++++++++++++++++++++------------------------
 1 file changed, 85 insertions(+), 91 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4476471c594e..0e33c63b4a0e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -912,25 +912,36 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
-/* symlink affected CPUs */
-static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
+/* Add/remove symlinks for all related CPUs */
+static int cpufreq_add_remove_dev_symlink(struct cpufreq_policy *policy,
+					  bool add)
 {
 	unsigned int j;
 	int ret = 0;
 
-	for_each_cpu(j, policy->cpus) {
+	for_each_cpu(j, policy->related_cpus) {
 		struct device *cpu_dev;
 
 		if (j == policy->kobj_cpu)
 			continue;
 
-		pr_debug("Adding link for CPU: %u\n", j);
+		pr_debug("%s: %s symlink for CPU: %u\n", __func__,
+			 add ? "Adding" : "Removing", j);
+
 		cpu_dev = get_cpu_device(j);
-		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-					"cpufreq");
-		if (ret)
-			break;
+		if (WARN_ON(!cpu_dev))
+			continue;
+
+		if (add) {
+			ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
+						"cpufreq");
+			if (ret)
+				break;
+		} else {
+			sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+		}
 	}
+
 	return ret;
 }
 
@@ -964,7 +975,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 			return ret;
 	}
 
-	return cpufreq_add_dev_symlink(policy);
+	return cpufreq_add_remove_dev_symlink(policy, true);
 }
 
 static void cpufreq_init_policy(struct cpufreq_policy *policy)
@@ -1026,7 +1037,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 		}
 	}
 
-	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	return 0;
 }
 
 static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
@@ -1046,7 +1057,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	return policy;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(void)
+static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
 {
 	struct cpufreq_policy *policy;
 
@@ -1068,6 +1079,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(void)
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
+	policy->cpu = cpu;
+
+	/* Set this once on allocation */
+	policy->kobj_cpu = cpu;
+
 	return policy;
 
 err_free_cpumask:
@@ -1086,10 +1102,11 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_REMOVE_POLICY, policy);
 
-	down_read(&policy->rwsem);
+	down_write(&policy->rwsem);
+	cpufreq_add_remove_dev_symlink(policy, false);
 	kobj = &policy->kobj;
 	cmp = &policy->kobj_unregister;
-	up_read(&policy->rwsem);
+	up_write(&policy->rwsem);
 	kobject_put(kobj);
 
 	/*
@@ -1109,27 +1126,14 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
-static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
-			     struct device *cpu_dev)
+static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 {
-	int ret;
-
 	if (WARN_ON(cpu == policy->cpu))
-		return 0;
-
-	/* Move kobject to the new policy->cpu */
-	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
-	if (ret) {
-		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
-		return ret;
-	}
+		return;
 
 	down_write(&policy->rwsem);
 	policy->cpu = cpu;
-	policy->kobj_cpu = cpu;
 	up_write(&policy->rwsem);
-
-	return 0;
 }
 
 static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
@@ -1138,7 +1142,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	int ret = -ENOMEM;
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	bool recover_policy = cpufreq_suspended;
+	bool recover_policy = !sif;
 
 	if (cpu_is_offline(cpu))
 		return 0;
@@ -1173,7 +1177,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
 	if (!policy) {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc();
+		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			goto nomem_out;
 	} else {
@@ -1189,12 +1193,8 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	 * the creation of a brand new one. So we need to perform this update
 	 * by invoking update_policy_cpu().
 	 */
-	if (recover_policy && cpu != policy->cpu) {
-		WARN_ON(update_policy_cpu(policy, cpu, dev));
-	} else {
-		policy->cpu = cpu;
-		policy->kobj_cpu = cpu;
-	}
+	if (recover_policy && cpu != policy->cpu)
+		update_policy_cpu(policy, cpu);
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
@@ -1378,9 +1378,13 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	cpus = cpumask_weight(policy->cpus);
 	up_read(&policy->rwsem);
 
-	/* Save the policy when doing a light-weight tear-down of last cpu */
+	/*
+	 * Preserve the policy when all policy->cpus are down (cpu == 1).
+	 * But don't preserve it if the driver is actually getting removed
+	 * (sif != NULL).
+	 */
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	if (cpufreq_suspended && cpus == 1)
+	if (!sif && cpus == 1)
 		list_add(&policy->fallback_list, &cpufreq_fallback_list);
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
@@ -1396,29 +1400,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 				CPUFREQ_NAME_LEN);
 	}
 
-	if (cpu != policy->kobj_cpu) {
-		sysfs_remove_link(&dev->kobj, "cpufreq");
-	} else if (cpus > 1) {
-		/* Nominate new CPU */
-		int new_cpu = cpumask_any_but(policy->cpus, cpu);
-		struct device *cpu_dev = get_cpu_device(new_cpu);
-
-		sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
-		ret = update_policy_cpu(policy, new_cpu, cpu_dev);
-		if (ret) {
-			if (sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-					      "cpufreq"))
-				pr_err("%s: Failed to restore kobj link to cpu:%d\n",
-				       __func__, cpu_dev->id);
-			return ret;
-		}
+	if (cpu != policy->cpu)
+		return 0;
 
-		if (!cpufreq_suspended)
-			pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
-				 __func__, new_cpu, cpu);
-	} else if (cpufreq_driver->stop_cpu) {
+	if (cpus > 1)
+		/* Nominate new CPU */
+		update_policy_cpu(policy, cpumask_any_but(policy->cpus, cpu));
+	else if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
-	}
 
 	return 0;
 }
@@ -1447,39 +1436,11 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		cpumask_clear_cpu(cpu, policy->cpus);
 	up_write(&policy->rwsem);
 
-	/* If cpu is last user of policy, free policy */
-	if (cpus == 1) {
-		if (has_target()) {
-			ret = __cpufreq_governor(policy,
-					CPUFREQ_GOV_POLICY_EXIT);
-			if (ret) {
-				pr_err("%s: Failed to exit governor\n",
-				       __func__);
-				return ret;
-			}
-		}
-
-		if (!cpufreq_suspended)
-			cpufreq_policy_put_kobj(policy);
-
-		/*
-		 * Perform the ->exit() even during light-weight tear-down,
-		 * since this is a core component, and is essential for the
-		 * subsequent light-weight ->init() to succeed.
-		 */
-		if (cpufreq_driver->exit)
-			cpufreq_driver->exit(policy);
-
-		/* Remove policy from list of active policies */
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		list_del(&policy->policy_list);
-		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	/* Not the last cpu of policy, start governor again ? */
+	if (cpus > 1) {
+		if (!has_target())
+			return 0;
 
-		if (!cpufreq_suspended)
-			cpufreq_policy_free(policy);
-		else
-			policy->governor = NULL;
-	} else if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
@@ -1488,8 +1449,41 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 			pr_err("%s: Failed to start governor\n", __func__);
 			return ret;
 		}
+
+		return 0;
 	}
 
+	/* If cpu is last user of policy, free policy */
+	if (has_target()) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		if (ret) {
+			pr_err("%s: Failed to exit governor\n", __func__);
+			return ret;
+		}
+	}
+
+	/* Free the policy kobjects only if the driver is getting removed. */
+	if (sif)
+		cpufreq_policy_put_kobj(policy);
+
+	/*
+	 * Perform the ->exit() even during light-weight tear-down,
+	 * since this is a core component, and is essential for the
+	 * subsequent light-weight ->init() to succeed.
+	 */
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	/* Remove policy from list of active policies */
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	list_del(&policy->policy_list);
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+	if (sif)
+		cpufreq_policy_free(policy);
+	else
+		policy->governor = NULL;
+
 	return 0;
 }
 
-- 
2.3.0.rc0.44.ga94655d

