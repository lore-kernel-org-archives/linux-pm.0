From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 10/14] cpufreq: Stop migrating sysfs files on hotplug
Date: Mon, 18 May 2015 10:43:33 +0530
Message-ID: <93a0104d11e5f75825672f0c59b8eec76c72d0e0.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33938 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbERFO3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:29 -0400
Received: by pdbnk13 with SMTP id nk13so37920784pdb.1
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:28 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

When we hot-unplug a cpu, we remove its sysfs cpufreq directory and if
the outgoing cpu was the owner of policy->kobj earlier then we migrate
the sysfs directory to under another online cpu.

There are few disadvantages this brings:
- Code Complexity
- Slower hotplug/suspend/resume
- sysfs file permissions are reset after all policy->cpus are offlined
- CPUFreq stats history lost after all policy->cpus are offlined
- Special management of sysfs stuff during suspend/resume

To overcome these, this patch modifies the way sysfs directories are
managed:
- Select sysfs kobjects owner while initializing policy and don't change
  it during hotplugs. Track it with kobj_cpu created earlier.

- Create symlinks for all related CPUs (can be offline) instead of
  affected CPUs on policy initialization and remove them only when the
  policy is freed.

- Free policy structure only on the removal of cpufreq-driver and not
  during hotplug/suspend/resume, detected by checking 'struct
  subsys_interface *' (Valid only when called from
  subsys_interface_unregister() while unregistering driver).

Apart from this, special care is taken to handle physical hoplug of CPUs
as we wouldn't remove sysfs links or remove policies on logical
hotplugs. Physical hotplug happens in the following sequence.

Hot removal:
- CPU is offlined first, ~ 'echo 0 >
  /sys/devices/system/cpu/cpuX/online'
- Then its device is removed along with all sysfs files, cpufreq core
  notified with cpufreq_remove_dev() callback from subsys-interface..

Hot addition:
- First the device along with its sysfs files is added, cpufreq core
  notified with cpufreq_add_dev() callback from subsys-interface..
- CPU is onlined, ~ 'echo 1 > /sys/devices/system/cpu/cpuX/online'

We call the same routines with both hotplug and subsys callbacks, and we
sense physical hotplug with cpu_offline() check in subsys callback. We
can handle most of the stuff with regular hotplug callback paths and
add/remove cpufreq sysfs links or free policy from subsys callbacks.

[ Something similar attempted by Saravana earlier ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 174 +++++++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 79 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b5e883f497dd..b07a3387f2bc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -977,14 +977,15 @@ static inline int add_remove_cpu_dev_symlink(struct cpufreq_policy *policy,
 	return 0;
 }
 
-/* Add/remove symlinks for all affected CPUs */
+/* Add/remove symlinks for all related CPUs */
 static int cpufreq_add_remove_dev_symlink(struct cpufreq_policy *policy,
 					  bool add)
 {
 	unsigned int j;
 	int ret = 0;
 
-	for_each_cpu(j, policy->cpus) {
+	/* Some related CPUs might not be present (physically hotplugged) */
+	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
 		if (j == policy->kobj_cpu)
 			continue;
 
@@ -1092,7 +1093,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 		}
 	}
 
-	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	return 0;
 }
 
 static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
@@ -1112,7 +1113,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	return policy;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(void)
+static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
 {
 	struct cpufreq_policy *policy;
 
@@ -1133,6 +1134,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(void)
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
+	policy->cpu = cpu;
+
+	/* Set this once on allocation */
+	policy->kobj_cpu = cpu;
+
 	return policy;
 
 err_free_cpumask:
@@ -1151,10 +1157,11 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
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
@@ -1185,27 +1192,14 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
 
 /**
@@ -1223,13 +1217,25 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	int ret = -ENOMEM;
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	bool recover_policy = cpufreq_suspended;
-
-	if (cpu_is_offline(cpu))
-		return 0;
+	bool recover_policy = !sif;
 
 	pr_debug("adding CPU %u\n", cpu);
 
+	/*
+	 * Only possible if 'cpu' wasn't physically present earlier and we are
+	 * here from subsys_interface add callback. A hotplug notifier will
+	 * follow and we will handle it like logical CPU hotplug then. For now,
+	 * just create the sysfs link.
+	 */
+	if (cpu_is_offline(cpu)) {
+		policy = per_cpu(cpufreq_cpu_data, cpu);
+		/* No need to create link of the first cpu of a policy */
+		if (!policy)
+			return 0;
+
+		return add_remove_cpu_dev_symlink(policy, cpu, true);
+	}
+
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
 
@@ -1249,7 +1255,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
 	if (!policy) {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc();
+		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			goto nomem_out;
 	}
@@ -1260,12 +1266,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
 
@@ -1444,29 +1446,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			CPUFREQ_NAME_LEN);
 	up_write(&policy->rwsem);
 
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
@@ -1487,32 +1474,11 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	cpumask_clear_cpu(cpu, policy->cpus);
 	up_write(&policy->rwsem);
 
-	/* If cpu is last user of policy, free policy */
-	if (policy_is_inactive(policy)) {
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
+	/* Not the last cpu of policy, start governor again ? */
+	if (!policy_is_inactive(policy)) {
+		if (!has_target())
+			return 0;
 
-		if (!cpufreq_suspended)
-			cpufreq_policy_free(policy);
-	} else if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
@@ -1521,8 +1487,34 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 			pr_err("%s: Failed to start governor\n", __func__);
 			return ret;
 		}
+
+		return 0;
+	}
+
+	/* If cpu is last user of policy, free policy */
+	if (has_target()) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		if (ret) {
+			pr_err("%s: Failed to exit governor\n", __func__);
+			return ret;
+		}
 	}
 
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
+	if (sif)
+		cpufreq_policy_free(policy);
+
 	return 0;
 }
 
@@ -1536,8 +1528,32 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	unsigned int cpu = dev->id;
 	int ret;
 
-	if (cpu_is_offline(cpu))
+	/*
+	 * Only possible if 'cpu' is getting physically removed now. A hotplug
+	 * notifier should have already been called and we just need to remove
+	 * link or free policy here.
+	 */
+	if (cpu_is_offline(cpu)) {
+		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+		struct cpumask mask;
+
+		if (!policy)
+			return 0;
+
+		cpumask_copy(&mask, policy->related_cpus);
+		cpumask_clear_cpu(cpu, &mask);
+
+		/*
+		 * Free policy only if all policy->related_cpus are removed
+		 * physically.
+		 */
+		if (cpumask_intersects(&mask, cpu_present_mask))
+			return add_remove_cpu_dev_symlink(policy, cpu, false);
+
+		cpufreq_policy_put_kobj(policy);
+		cpufreq_policy_free(policy);
 		return 0;
+	}
 
 	ret = __cpufreq_remove_dev_prepare(dev, sif);
 
-- 
2.4.0

