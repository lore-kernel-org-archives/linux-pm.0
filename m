From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update 2x][PATCH 7/7] cpufreq: Separate CPU device registration from CPU online
Date: Wed, 29 Jul 2015 03:03:44 +0200
Message-ID: <3091538.g8dYBumqSx@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <1739669.kedIsxdRK2@vostro.rjw.lan> <1702607.RH80fBCN6J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46662 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751131AbbG2Agt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 20:36:49 -0400
In-Reply-To: <1702607.RH80fBCN6J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To separate the CPU online interface from the CPU device
registration, split cpufreq_online() out of cpufreq_add_dev()
and make cpufreq_cpu_callback() call the former, while
cpufreq_add_dev() itself will only be used as the CPU device
addition subsystem interface callback.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
---

cpufreq_online() returns an int and cpufreq_add_dev() propagates that to the
caller in this version.

That said I don't agree with using that to defer the platform device probing
in cpufreq-dt.  That's just over the top to me.

---
 drivers/cpufreq/cpufreq.c |   96 +++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1191,36 +1191,15 @@ static void cpufreq_policy_free(struct c
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
+static int cpufreq_online(unsigned int cpu)
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
@@ -1377,6 +1356,35 @@ out_free_policy:
 	return ret;
 }
 
+/**
+ * cpufreq_add_dev - the cpufreq interface for a CPU device.
+ * @dev: CPU device.
+ * @sif: Subsystem interface structure pointer (not used)
+ */
+static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
+{
+	unsigned cpu = dev->id;
+	int ret;
+
+	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
+
+	if (cpu_online(cpu)) {
+		ret = cpufreq_online(cpu);
+	} else {
+		/*
+		 * A hotplug notifier will follow and we will handle it as CPU
+		 * online then.  For now, just create the sysfs link, unless
+		 * there is no policy or the link is already present.
+		 */
+		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+
+		ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
+			? add_cpu_dev_symlink(policy, cpu) : 0;
+	}
+
+	return ret;
+}
+
 static void cpufreq_offline_prepare(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -2340,27 +2348,23 @@ static int cpufreq_cpu_callback(struct n
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

