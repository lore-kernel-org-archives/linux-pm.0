From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: Separate CPU device removal from CPU online
Date: Thu, 23 Jul 2015 02:04:06 +0200
Message-ID: <15986005.VczafT3nkj@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64128 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750779AbbGVXiq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 19:38:46 -0400
In-Reply-To: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To separate the CPU online interface from the CPU device removal
one, split cpufreq_dev_online() out of cpufreq_add_dev() and make
cpufreq_cpu_callback() call the former, while the latter will only
be used as the CPU device removal subsystem interface callback.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |  109 +++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 53 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1177,45 +1177,14 @@ static void cpufreq_policy_free(struct c
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
+static int cpufreq_dev_online(struct device *dev, bool recover_policy)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 	unsigned long flags;
-	bool recover_policy = !sif;
 
-	pr_debug("adding CPU %u\n", cpu);
-
-	/* sysfs links are only created on subsys callback */
-	if (sif && policy) {
-		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
-		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
-		if (ret) {
-			dev_dbg(dev, "%s: Failed to create link (%d)\n",
-				__func__, ret);
-			return ret;
-		}
-
-		/* Track CPUs for which sysfs links are created */
-		cpumask_set_cpu(cpu, policy->linked_cpus);
-	}
-
-	/*
-	 * A hotplug notifier will follow and we will take care of rest
-	 * of the initialization then.
-	 */
-	if (cpu_is_offline(cpu))
-		return 0;
+	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
@@ -1376,6 +1345,36 @@ out_release_rwsem:
 	return ret;
 }
 
+/**
+ * cpufreq_add_dev - add a cpufreq interface to a CPU device.
+ * @dev: CPU device to add the interface to.
+ * @sif: Subsystem interface pointer.
+ */
+static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
+{
+	unsigned int cpu = dev->id;
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+
+	pr_debug("%s: adding CPU %u\n", __func__, cpu);
+
+	if (policy && policy->kobj_cpu != cpu) {
+		int ret;
+
+		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
+		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+		if (ret) {
+			dev_dbg(dev, "%s: Failed to create link (%d)\n",
+				__func__, ret);
+			return ret;
+		}
+
+		/* Track CPUs for which sysfs links are created */
+		cpumask_set_cpu(cpu, policy->linked_cpus);
+	}
+
+	return cpu_online(cpu) ? cpufreq_dev_online(dev, false) : 0;
+}
+
 static void cpufreq_offline_prepare(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -2344,31 +2343,35 @@ unlock:
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
+static void cpufreq_cpu_online(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (dev)
+		cpufreq_dev_online(dev, true);
+}
+
 static int cpufreq_cpu_callback(struct notifier_block *nfb,
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
+		cpufreq_cpu_online(cpu);
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
+		cpufreq_cpu_online(cpu);
+		break;
 	}
 	return NOTIFY_OK;
 }

