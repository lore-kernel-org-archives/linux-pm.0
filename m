From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Thu, 23 Mar 2017 15:24:46 -0600
Message-ID: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbdCWVYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 17:24:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, pprakash@codeaurora.org

Adds an additional code path within cpufreq_online to create sysfs
symlinks for cpus that are bought onilne for the first time after
completion of boot.

With maxcpus=N kernel parameter, it is possible to bring additional
cpus online after boot. In these cases per-cpu "cpufreq" symlinks
are not being created during registration as policy may not exist
for the cpus that were offline during boot.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/cpufreq/cpufreq.c | 63 +++++++++++++++++++++++++++++++++++------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5dbdd26..e7d8ad5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -62,6 +62,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
  * also protects the cpufreq_cpu_data array.
  */
 static struct cpufreq_driver *cpufreq_driver;
+static cpumask_var_t cpufreq_real_cpus; /* mask of real/registered CPUs  */
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
@@ -1048,14 +1049,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
-	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
-		goto err_free_rcpumask;
-
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_real_cpus;
+		goto err_free_rcpumask;
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1068,8 +1066,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
-err_free_real_cpus:
-	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
@@ -1116,7 +1112,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	cpufreq_policy_put_kobj(policy);
-	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1181,8 +1176,16 @@ static int cpufreq_online(unsigned int cpu)
 		policy->user_policy.max = policy->max;
 
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		for_each_cpu(j, policy->related_cpus)
+		for_each_cpu(j, policy->related_cpus) {
+			/* Setup sysfs links only for real CPUs */
+			if (cpumask_test_cpu(j, cpufreq_real_cpus)) {
+				ret = add_cpu_dev_symlink(policy,
+							get_cpu_device(j));
+				if (ret)
+					goto out_delete_symlinks;
+			}
 			per_cpu(cpufreq_cpu_data, j) = policy;
+		}
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	} else {
 		policy->min = policy->user_policy.min;
@@ -1270,6 +1273,13 @@ static int cpufreq_online(unsigned int cpu)
 
 	return 0;
 
+out_delete_symlinks:
+	for_each_cpu(j, policy->related_cpus) {
+		if (per_cpu(cpufreq_cpu_data, j) &&
+			cpumask_test_cpu(j, cpufreq_real_cpus))
+			remove_cpu_dev_symlink(policy, get_cpu_device(j));
+		per_cpu(cpufreq_cpu_data, j) = NULL;
+	}
 out_exit_policy:
 	up_write(&policy->rwsem);
 
@@ -1301,14 +1311,22 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 			return ret;
 	}
 
-	/* Create sysfs link on CPU registration */
+	if (cpumask_test_and_set_cpu(cpu, cpufreq_real_cpus))
+		return 0;
+
+	/*
+	 * sysfs links will be created on CPU registration <OR>
+	 * if a CPU was offline during registration (when maxcpus=N is used)
+	 * then sysfs links will be created when a new policy is created in
+	 * cpufreq_online
+	 */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
+	if (!policy)
 		return 0;
 
 	ret = add_cpu_dev_symlink(policy, dev);
 	if (ret) {
-		cpumask_clear_cpu(cpu, policy->real_cpus);
+		cpumask_clear_cpu(cpu, cpufreq_real_cpus);
 		cpufreq_offline(cpu);
 	}
 
@@ -1384,7 +1402,7 @@ static int cpufreq_offline(unsigned int cpu)
  */
 static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id;
+	unsigned int cpu = dev->id, i;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy)
@@ -1393,11 +1411,14 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpu_online(cpu))
 		cpufreq_offline(cpu);
 
-	cpumask_clear_cpu(cpu, policy->real_cpus);
-	remove_cpu_dev_symlink(policy, dev);
+	if (cpumask_test_and_clear_cpu(cpu, cpufreq_real_cpus))
+		remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus))
-		cpufreq_policy_free(policy);
+	for_each_cpu(i, policy->related_cpus) {
+		if (cpumask_test_cpu(i, cpufreq_real_cpus))
+			return;
+	}
+	cpufreq_policy_free(policy);
 }
 
 /**
@@ -2530,6 +2551,9 @@ static int __init cpufreq_core_init(void)
 	if (cpufreq_disabled())
 		return -ENODEV;
 
+	if (!zalloc_cpumask_var(&cpufreq_real_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 
@@ -2537,5 +2561,12 @@ static int __init cpufreq_core_init(void)
 
 	return 0;
 }
+
+static void __exit cpufreq_core_exit(void)
+{
+	free_cpumask_var(cpufreq_real_cpus);
+}
+
 module_param(off, int, 0444);
 core_initcall(cpufreq_core_init);
+module_exit(cpufreq_core_exit);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 87165f0..86e0bd5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -66,7 +66,6 @@ struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
-	cpumask_var_t		real_cpus; /* Related and present */
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
