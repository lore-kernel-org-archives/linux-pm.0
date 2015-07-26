From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Sun, 26 Jul 2015 02:28:36 +0200
Message-ID: <2161701.diIE0m8ocR@vostro.rjw.lan>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan> <20150725130002.GC1691@linux> <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63448 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754997AbbGZABq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2015 20:01:46 -0400
In-Reply-To: <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

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

To avoid that warning, make cpufreq use an additional CPU mask
containing related CPUs that are actually present for each policy
object.  That mask is initialized when the policy object is populated
after its creation (for the first online CPU using it) and it includes
CPUs from the "policy CPUs" mask returned by the cpufreq driver's
->init() callback that are physically present at that time.  Symbolic
links to the policy are created only for the CPUs in that mask.

If cpufreq_add_dev() is invoked for an offline CPU, it checks the
new mask and only creates the symlink if the CPU was not in it (the
CPU is added to the mask at the same time).

In turn, cpufreq_remove_dev() drops the given CPU from the new mask,
removes its symlink to the policy object and returns, unless it is
the CPU owning the policy object.  In that case, the policy object
is moved to a new CPU's sysfs directory or deleted if the CPU being
removed was the last user of the policy.

While at it, notice that cpufreq_remove_dev() can't fail, because
its return value is ignored, so make it ignore return values from
__cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
and prevent these functions from aborting on errors returned by
__cpufreq_governor().  Also drop the now unused sif argument from
them.

Fixes: 87549141d516 (cpufreq: Stop migrating sysfs files on hotplug)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Russell King <linux@arm.linux.org.uk>
---

This goes back to the https://patchwork.kernel.org/patch/6856011/
idea, but has a couple of bugs fixed and goes a it further with
cleaning things up.

---
 drivers/cpufreq/cpufreq.c |  108 +++++++++++++++++++++++-----------------------
 include/linux/cpufreq.h   |    1 
 2 files changed, 56 insertions(+), 53 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -62,6 +62,7 @@ struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
+	cpumask_var_t		real_cpus; /* Related and present */
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1002,7 +1002,7 @@ static int cpufreq_add_dev_symlink(struc
 	int ret = 0;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
+	for_each_cpu(j, policy->real_cpus) {
 		if (j == policy->kobj_cpu)
 			continue;
 
@@ -1019,7 +1019,7 @@ static void cpufreq_remove_dev_symlink(s
 	unsigned int j;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
+	for_each_cpu(j, policy->real_cpus) {
 		if (j == policy->kobj_cpu)
 			continue;
 
@@ -1163,11 +1163,14 @@ static struct cpufreq_policy *cpufreq_po
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
+	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
+		goto err_free_rcpumask;
+
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
 				   "cpufreq");
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_rcpumask;
+		goto err_free_real_cpus;
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1184,6 +1187,8 @@ static struct cpufreq_policy *cpufreq_po
 
 	return policy;
 
+err_free_real_cpus:
+	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
@@ -1234,6 +1239,7 @@ static void cpufreq_policy_free(struct c
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	cpufreq_policy_put_kobj(policy, notify);
+	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1258,14 +1264,17 @@ static int cpufreq_add_dev(struct device
 
 	pr_debug("adding CPU %u\n", cpu);
 
-	/*
-	 * Only possible if 'cpu' wasn't physically present earlier and we are
-	 * here from subsys_interface add callback. A hotplug notifier will
-	 * follow and we will handle it like logical CPU hotplug then. For now,
-	 * just create the sysfs link.
-	 */
-	if (cpu_is_offline(cpu))
-		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
+	if (cpu_is_offline(cpu)) {
+		/*
+		 * Only possible if we are here from the subsys_interface add
+		 * callback.  A hotplug notifier will follow and we will handle
+		 * it as CPU online then.  For now, just create the sysfs link,
+		 * unless there is no policy or the link is already present.
+		 */
+		policy = per_cpu(cpufreq_cpu_data, cpu);
+		return policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
+			? add_cpu_dev_symlink(policy, cpu) : 0;
+	}
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
@@ -1307,6 +1316,10 @@ static int cpufreq_add_dev(struct device
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
+	/* Remember which CPUs have been present at the policy creation time. */
+	if (!recover_policy)
+		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
+
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1420,8 +1433,7 @@ nomem_out:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static int __cpufreq_remove_dev_prepare(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret = 0;
@@ -1437,10 +1449,8 @@ static int __cpufreq_remove_dev_prepare(
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret) {
+		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
-		}
 	}
 
 	down_write(&policy->rwsem);
@@ -1473,8 +1483,7 @@ static int __cpufreq_remove_dev_prepare(
 	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static int __cpufreq_remove_dev_finish(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret;
@@ -1492,10 +1501,8 @@ static int __cpufreq_remove_dev_finish(s
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
@@ -1506,10 +1513,6 @@ static int __cpufreq_remove_dev_finish(s
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
-	/* Free the policy only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_free(policy, true);
-
 	return 0;
 }
 
@@ -1521,42 +1524,41 @@ static int __cpufreq_remove_dev_finish(s
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
+	if (cpu_online(cpu)) {
+		__cpufreq_remove_dev_prepare(dev);
+		__cpufreq_remove_dev_finish(dev);
+	}
 
-		/*
-		 * Free policy only if all policy->related_cpus are removed
-		 * physically.
-		 */
-		if (cpumask_intersects(&mask, cpu_present_mask)) {
-			remove_cpu_dev_symlink(policy, cpu);
-			return 0;
-		}
+	cpumask_clear_cpu(cpu, policy->real_cpus);
 
+	if (cpumask_empty(policy->real_cpus)) {
 		cpufreq_policy_free(policy, true);
 		return 0;
 	}
 
-	ret = __cpufreq_remove_dev_prepare(dev, sif);
+	if (cpu != policy->kobj_cpu) {
+		remove_cpu_dev_symlink(policy, cpu);
+	} else {
+		/*
+		 * The CPU owning the policy object is going away.  Move it to
+		 * another suitable CPU.
+		 */
+		unsigned int new_cpu = cpumask_first(policy->real_cpus);
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
@@ -2395,11 +2397,11 @@ static int cpufreq_cpu_callback(struct n
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

