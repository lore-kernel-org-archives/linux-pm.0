From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 7/7] cpufreq: Separate CPU device registration from CPU online
Date: Mon, 27 Jul 2015 23:55:35 +0200
Message-ID: <1702607.RH80fBCN6J@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <3874727.Jpay9zgokc@vostro.rjw.lan> <1739669.kedIsxdRK2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44450 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754525AbbG0V2l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 17:28:41 -0400
In-Reply-To: <1739669.kedIsxdRK2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To separate the CPU online interface from the CPU device
registration, split cpufreq_online() out of cpufreq_add_dev()
and make cpufreq_cpu_callback() call the former, while
cpufreq_add_dev() itself will only be used as the CPU device
addition subsystem interface callback.

While at it, notice that the return value of sif->add_dev() is
ignored in bus_probe_device(), so (the new) cpufreq_add_dev()
doesn't need to bother with returning anything different from 0
and cpufreq_online() may be a void function.

Moreover, since the return value of cpufreq_add_policy_cpu() is
going to be ignored now too, make a void function of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
---
 drivers/cpufreq/cpufreq.c |  121 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1056,19 +1056,19 @@ static int cpufreq_init_policy(struct cp
 	return cpufreq_set_policy(policy, &new_policy);
 }
 
-static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
+static void cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 {
-	int ret = 0;
+	int ret;
 
 	/* Has this CPU been taken care of already? */
 	if (cpumask_test_cpu(cpu, policy->cpus))
-		return 0;
+		return;
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
+			return;
 		}
 	}
 
@@ -1081,13 +1081,9 @@ static int cpufreq_add_policy_cpu(struct
 		if (!ret)
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
-		if (ret) {
+		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
-			return ret;
-		}
 	}
-
-	return 0;
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
@@ -1191,44 +1187,24 @@ static void cpufreq_policy_free(struct c
 	kfree(policy);
 }
 
-/**
- * cpufreq_add_dev - add a CPU device
- *
- * Adds the cpufreq interface for a CPU device.
- *
- * The Oracle says: try running cpufreq registration/unregistration concurrently
- * with with cpu hotplugging and all hell will break loose. Tried to clean this
- * mess up, but more thorough testing is needed. - Mathieu
- */
-static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
+static void cpufreq_online(unsigned int cpu)
 {
-	unsigned int j, cpu = dev->id;
-	int ret;
 	struct cpufreq_policy *policy;
-	unsigned long flags;
 	bool recover_policy;
+	unsigned long flags;
+	unsigned int j;
+	int ret;
 
-	pr_debug("adding CPU %u\n", cpu);
-
-	if (cpu_is_offline(cpu)) {
-		/*
-		 * Only possible if we are here from the subsys_interface add
-		 * callback.  A hotplug notifier will follow and we will handle
-		 * it as CPU online then.  For now, just create the sysfs link,
-		 * unless there is no policy or the link is already present.
-		 */
-		policy = per_cpu(cpufreq_cpu_data, cpu);
-		return policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
-			? add_cpu_dev_symlink(policy, cpu) : 0;
-	}
+	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
 
 	/* Check if this CPU already has a policy to manage it */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (policy) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
-		if (!policy_is_inactive(policy))
-			return cpufreq_add_policy_cpu(policy, cpu);
-
+		if (!policy_is_inactive(policy)) {
+			cpufreq_add_policy_cpu(policy, cpu);
+			return;
+		}
 		/* This is the only online CPU for the policy.  Start over. */
 		recover_policy = true;
 		down_write(&policy->rwsem);
@@ -1239,7 +1215,7 @@ static int cpufreq_add_dev(struct device
 		recover_policy = false;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
-			return -ENOMEM;
+			return;
 	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
@@ -1362,7 +1338,7 @@ static int cpufreq_add_dev(struct device
 
 	pr_debug("initialization complete\n");
 
-	return 0;
+	return;
 
 out_remove_policy_notify:
 	/* cpufreq_policy_free() will notify based on this */
@@ -1374,7 +1350,34 @@ out_exit_policy:
 		cpufreq_driver->exit(policy);
 out_free_policy:
 	cpufreq_policy_free(policy, recover_policy);
-	return ret;
+}
+
+/**
+ * cpufreq_add_dev - the cpufreq interface for a CPU device.
+ * @dev: CPU device.
+ * @sif: Subsystem interface structure pointer (not used)
+ */
+static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
+{
+	unsigned cpu = dev->id;
+
+	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
+
+	if (cpu_online(cpu)) {
+		cpufreq_online(cpu);
+	} else {
+		/*
+		 * A hotplug notifier will follow and we will handle it as CPU
+		 * online then.  For now, just create the sysfs link, unless
+		 * there is no policy or the link is already present.
+		 */
+		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+
+		if (policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus))
+			WARN_ON(add_cpu_dev_symlink(policy, cpu));
+	}
+
+	return 0;
 }
 
 static void cpufreq_offline_prepare(unsigned int cpu)
@@ -2340,27 +2343,23 @@ static int cpufreq_cpu_callback(struct n
 					unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
-	struct device *dev;
 
-	dev = get_cpu_device(cpu);
-	if (dev) {
-		switch (action & ~CPU_TASKS_FROZEN) {
-		case CPU_ONLINE:
-			cpufreq_add_dev(dev, NULL);
-			break;
-
-		case CPU_DOWN_PREPARE:
-			cpufreq_offline_prepare(cpu);
-			break;
-
-		case CPU_POST_DEAD:
-			cpufreq_offline_finish(cpu);
-			break;
-
-		case CPU_DOWN_FAILED:
-			cpufreq_add_dev(dev, NULL);
-			break;
-		}
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_ONLINE:
+		cpufreq_online(cpu);
+		break;
+
+	case CPU_DOWN_PREPARE:
+		cpufreq_offline_prepare(cpu);
+		break;
+
+	case CPU_POST_DEAD:
+		cpufreq_offline_finish(cpu);
+		break;
+
+	case CPU_DOWN_FAILED:
+		cpufreq_online(cpu);
+		break;
 	}
 	return NOTIFY_OK;
 }

