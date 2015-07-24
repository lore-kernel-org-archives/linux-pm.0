From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Sat, 25 Jul 2015 00:17:44 +0200
Message-ID: <11080992.c5Q5Du7n5n@vostro.rjw.lan>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan> <20150724140943.GC16336@linux> <1509688.KKhdi8M36y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63150 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752630AbbGXVu5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 17:50:57 -0400
In-Reply-To: <1509688.KKhdi8M36y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 87549141d516 (cpufreq: Stop migrating sysfs files on
hotplug) there is a problem with CPUs that share cpufreq policy
objects with other CPUs and are initially offline.

Say CPU1 shares a policy with CPU0 which is online and is registered
first.  As part of the registration process, cpufreq_add_dev() is
called for it.  It creates the policy object and a symbolic link
to it from the CPU1's sysfs directory.  If CPU1 is registered
subsequently and it is offline at that time, cpufreq_add_dev() will
attempt to create a symbolic link to the policy object for it, but
that link is present already, so a warning about that will be
triggered.

To avoid that warning, use the observation that cpufreq doesn't
need to care about CPUs that have never been online.  Namely,
make cpufreq use an additional CPU mask for each policy containing
all CPUs using the given policy that have ever been online.  That
mask is initialized when the policy object is populated after its
creation (for the first online CPU using it) and it includes the
policy owner only to start with.

At the same time, cpufreq_add_dev() is modified to ignore offline
CPUs (the only case it can see an offline CPU is when that CPU has
never been online, so cpufreq doesn't need to care about it).  Also,
if it is invoked for a CPU having a policy already, it checks if
that CPU has gone online for the first time and creates a symbolic
link to the policy for it if that's the case.  The CPU is then added
to the new mask of CPUs that have been online at least once.

In turn, cpufreq_remove_dev() drops the given CPU from the new mask.
If the mask turns out to be empty at that point, the policy object is
not needed any more, so it is deleted.  Otherwise, the CPU's symlink
to the policy object is removed, unless that's the CPU owning the
policy object.  In that case, the policy object is moved to the sysfs
directory of another CPU using the same policy.

While at it, notice that cpufreq_remove_dev() can't fail, because
its return value is ignored, so make it ignore return values from
__cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
and prevent these functions from aborting on errors returned by
__cpufreq_governor().  Also, drop the now unused sif argument from
them.

Fixes: 87549141d516 (cpufreq: Stop migrating sysfs files on hotplug)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Russell King <linux@arm.linux.org.uk>
---

Replacement for https://patchwork.kernel.org/patch/6856011/

---
 drivers/cpufreq/cpufreq.c |  195 ++++++++++++++++------------------------------
 include/linux/cpufreq.h   |    1 
 2 files changed, 73 insertions(+), 123 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -62,6 +62,7 @@ struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
+	cpumask_var_t		managed_cpus; /* CPUs that have ever been online */
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -966,67 +966,6 @@ void cpufreq_sysfs_remove_file(const str
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
-static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
-{
-	struct device *cpu_dev;
-
-	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
-
-	if (!policy)
-		return 0;
-
-	cpu_dev = get_cpu_device(cpu);
-	if (WARN_ON(!cpu_dev))
-		return 0;
-
-	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
-}
-
-static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
-{
-	struct device *cpu_dev;
-
-	pr_debug("%s: Removing symlink for CPU: %u\n", __func__, cpu);
-
-	cpu_dev = get_cpu_device(cpu);
-	if (WARN_ON(!cpu_dev))
-		return;
-
-	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
-}
-
-/* Add/remove symlinks for all related CPUs */
-static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
-{
-	unsigned int j;
-	int ret = 0;
-
-	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
-		if (j == policy->kobj_cpu)
-			continue;
-
-		ret = add_cpu_dev_symlink(policy, j);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
-{
-	unsigned int j;
-
-	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
-		if (j == policy->kobj_cpu)
-			continue;
-
-		remove_cpu_dev_symlink(policy, j);
-	}
-}
-
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 				     struct device *dev)
 {
@@ -1051,13 +990,10 @@ static int cpufreq_add_dev_interface(str
 	if (ret)
 		return ret;
 
-	if (cpufreq_driver->bios_limit) {
+	if (cpufreq_driver->bios_limit)
 		ret = sysfs_create_file(&policy->kobj, &bios_limit.attr);
-		if (ret)
-			return ret;
-	}
 
-	return cpufreq_add_dev_symlink(policy);
+	return ret;
 }
 
 static void cpufreq_init_policy(struct cpufreq_policy *policy)
@@ -1151,6 +1087,7 @@ static struct cpufreq_policy *cpufreq_po
 static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 {
 	struct cpufreq_policy *policy;
+	unsigned int cpu = dev->id;
 	int ret;
 
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
@@ -1163,11 +1100,14 @@ static struct cpufreq_policy *cpufreq_po
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
+	if (!zalloc_cpumask_var(&policy->managed_cpus, GFP_KERNEL))
+		goto err_free_rcpumask;
+
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
 				   "cpufreq");
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_rcpumask;
+		goto err_free_managed_cpus;
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1177,13 +1117,17 @@ static struct cpufreq_policy *cpufreq_po
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
-	policy->cpu = dev->id;
+	policy->cpu = cpu;
 
 	/* Set this once on allocation */
-	policy->kobj_cpu = dev->id;
+	policy->kobj_cpu = cpu;
+	/* Add the "kobject" CPU to the "managed" mask. */
+	cpumask_set_cpu(cpu, policy->managed_cpus);
 
 	return policy;
 
+err_free_managed_cpus:
+	free_cpumask_var(policy->managed_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
@@ -1204,7 +1148,6 @@ static void cpufreq_policy_put_kobj(stru
 					     CPUFREQ_REMOVE_POLICY, policy);
 
 	down_write(&policy->rwsem);
-	cpufreq_remove_dev_symlink(policy);
 	kobj = &policy->kobj;
 	cmp = &policy->kobj_unregister;
 	up_write(&policy->rwsem);
@@ -1234,6 +1177,7 @@ static void cpufreq_policy_free(struct c
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	cpufreq_policy_put_kobj(policy, notify);
+	free_cpumask_var(policy->managed_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1259,24 +1203,34 @@ static int cpufreq_add_dev(struct device
 	pr_debug("adding CPU %u\n", cpu);
 
 	/*
-	 * Only possible if 'cpu' wasn't physically present earlier and we are
-	 * here from subsys_interface add callback. A hotplug notifier will
-	 * follow and we will handle it like logical CPU hotplug then. For now,
-	 * just create the sysfs link.
+	 * Only possible if we are here from the subsys_interface add callback,
+	 * so if the CPU is offline now, it has never been online.  Ignore it.
 	 */
 	if (cpu_is_offline(cpu))
-		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
+		return 0;
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
 
 	/* Check if this CPU already has a policy to manage it */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (policy && !policy_is_inactive(policy)) {
+	if (policy) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
-		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
-		up_read(&cpufreq_rwsem);
-		return ret;
+		/*
+		 * If this is the first time the CPU is going online, link it to
+		 * the policy and mark it as "managed".
+		 */
+		if (!cpumask_test_cpu(cpu, policy->managed_cpus)) {
+			ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+			if (ret)
+				goto out;
+
+			cpumask_set_cpu(cpu, policy->managed_cpus);
+		}
+		if (!policy_is_inactive(policy)) {
+			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
+			goto out;
+		}
 	}
 
 	/*
@@ -1288,7 +1242,7 @@ static int cpufreq_add_dev(struct device
 		recover_policy = false;
 		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
-			goto nomem_out;
+			goto out;
 	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
@@ -1414,14 +1368,13 @@ err_get_freq:
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
 	cpufreq_policy_free(policy, recover_policy);
-nomem_out:
+out:
 	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static int __cpufreq_remove_dev_prepare(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret = 0;
@@ -1437,10 +1390,8 @@ static int __cpufreq_remove_dev_prepare(
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret) {
+		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
-		}
 	}
 
 	down_write(&policy->rwsem);
@@ -1473,8 +1424,7 @@ static int __cpufreq_remove_dev_prepare(
 	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static int __cpufreq_remove_dev_finish(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret;
@@ -1492,10 +1442,8 @@ static int __cpufreq_remove_dev_finish(s
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		if (ret) {
+		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
-			return ret;
-		}
 	}
 
 	/*
@@ -1506,10 +1454,6 @@ static int __cpufreq_remove_dev_finish(s
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
-	/* Free the policy only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_free(policy, true);
-
 	return 0;
 }
 
@@ -1521,42 +1465,47 @@ static int __cpufreq_remove_dev_finish(s
 static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id;
-	int ret;
-
-	/*
-	 * Only possible if 'cpu' is getting physically removed now. A hotplug
-	 * notifier should have already been called and we just need to remove
-	 * link or free policy here.
-	 */
-	if (cpu_is_offline(cpu)) {
-		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-		struct cpumask mask;
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
-		if (!policy)
-			return 0;
+	if (!policy)
+		return 0;
 
-		cpumask_copy(&mask, policy->related_cpus);
-		cpumask_clear_cpu(cpu, &mask);
+	/* Nothing to do if the CPU has never been online. */
+	if (!cpumask_test_and_clear_cpu(cpu, policy->managed_cpus))
+		return 0;
 
-		/*
-		 * Free policy only if all policy->related_cpus are removed
-		 * physically.
-		 */
-		if (cpumask_intersects(&mask, cpu_present_mask)) {
-			remove_cpu_dev_symlink(policy, cpu);
-			return 0;
-		}
+	if (cpu_online(cpu)) {
+		__cpufreq_remove_dev_prepare(dev);
+		__cpufreq_remove_dev_finish(dev);
+	}
 
+	/*
+	 * If all of the CPUs using this policy that have ever been online go
+	 * away, we don't need the policy any more, so delete it.
+	 */
+	if (cpumask_empty(policy->managed_cpus)) {
 		cpufreq_policy_free(policy, true);
 		return 0;
 	}
 
-	ret = __cpufreq_remove_dev_prepare(dev, sif);
+	if (cpu != policy->kobj_cpu) {
+		sysfs_remove_link(&dev->kobj, "cpufreq");
+	} else {
+		/*
+		 * The CPU owning the policy object is going away.  Move it to
+		 * another suitable CPU.
+		 */
+		unsigned int new_cpu = cpumask_first(policy->managed_cpus);
+		struct device *new_dev = get_cpu_device(new_cpu);
+
+		dev_dbg(dev, "%s: Moving policy object to CPU%u\n", __func__, new_cpu);
 
-	if (!ret)
-		ret = __cpufreq_remove_dev_finish(dev, sif);
+		sysfs_remove_link(&new_dev->kobj, "cpufreq");
+		policy->kobj_cpu = new_cpu;
+		WARN_ON(kobject_move(&policy->kobj, &new_dev->kobj));
+	}
 
-	return ret;
+	return 0;
 }
 
 static void handle_update(struct work_struct *work)
@@ -2395,11 +2344,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev, NULL);
+			__cpufreq_remove_dev_prepare(dev);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev, NULL);
+			__cpufreq_remove_dev_finish(dev);
 			break;
 
 		case CPU_DOWN_FAILED:

