From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: create link to policy only for registered CPUs
Date: Fri,  9 Sep 2016 15:24:14 +0530
Message-ID: <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36570 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbcIIJyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 05:54:20 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so27978609pfb.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 02:54:20 -0700 (PDT)
In-Reply-To: <20160819110032.GM1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If a cpufreq driver is registered very early in the boot stage (e.g.
registered from postcore_initcall()), then cpufreq core may generate
kernel warnings for it.

In this case, the CPUs are registered as devices with the kernel only
after the cpufreq driver is registered, while the CPUs were brought
online way before that. And by the time cpufreq_add_dev() gets called,
the cpu device isn't stored in the per-cpu variable (cpu_sys_devices,)
which is read by get_cpu_device().

And so cpufreq core fails to get device for the CPU, for which
cpufreq_add_dev() was called in the first place and we will hit a
WARN_ON(!cpu_dev).

Even if we reuse the 'dev' parameter passed to cpufreq_add_dev() to
avoid that warning, there might be other CPUs online that share the
policy with the cpu for which cpufreq_add_dev() is called. And
eventually get_cpu_device() will return NULL for them as well, and we
will hit the same WARN_ON() again.

In order to fix these issues, change cpufreq core to create links to the
policy for a cpu only when cpufreq_add_dev() is called for that CPU.

Reuse the 'real_cpus' mask to track that as well.

Note that cpufreq_remove_dev() already handles removal of the links for
individual CPUs and cpufreq_add_dev() has aligned with that now.

Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 89 +++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 61 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 13fb589b6d2c..3a64136bf21b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -916,58 +916,18 @@ static struct kobj_type ktype_cpufreq = {
 	.release	= cpufreq_sysfs_release,
 };
 
-static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
+static int add_cpu_dev_symlink(struct cpufreq_policy *policy,
+			       struct device *dev)
 {
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
+	dev_dbg(dev, "%s: Adding symlink\n", __func__);
+	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 }
 
-static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
+static void remove_cpu_dev_symlink(struct cpufreq_policy *policy,
+				   struct device *dev)
 {
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
-	for_each_cpu(j, policy->real_cpus) {
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
-	for_each_cpu(j, policy->real_cpus)
-		remove_cpu_dev_symlink(policy, j);
+	dev_dbg(dev, "%s: Removing symlink\n", __func__);
+	sysfs_remove_link(&dev->kobj, "cpufreq");
 }
 
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
@@ -999,7 +959,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 			return ret;
 	}
 
-	return cpufreq_add_dev_symlink(policy);
+	return 0;
 }
 
 __weak struct cpufreq_governor *cpufreq_default_governor(void)
@@ -1129,7 +1089,6 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 
 	down_write(&policy->rwsem);
 	cpufreq_stats_free_table(policy);
-	cpufreq_remove_dev_symlink(policy);
 	kobj = &policy->kobj;
 	cmp = &policy->kobj_unregister;
 	up_write(&policy->rwsem);
@@ -1211,8 +1170,8 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
-		/* Remember CPUs present at the policy creation time. */
-		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
+		/* Clear mask of registered CPUs */
+		cpumask_clear(policy->real_cpus);
 	}
 
 	/*
@@ -1327,6 +1286,8 @@ static int cpufreq_online(unsigned int cpu)
 	return ret;
 }
 
+static void cpufreq_offline(unsigned int cpu);
+
 /**
  * cpufreq_add_dev - the cpufreq interface for a CPU device.
  * @dev: CPU device.
@@ -1336,22 +1297,28 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	struct cpufreq_policy *policy;
 	unsigned cpu = dev->id;
+	int ret;
 
 	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
 
-	if (cpu_online(cpu))
-		return cpufreq_online(cpu);
+	if (cpu_online(cpu)) {
+		ret = cpufreq_online(cpu);
+		if (ret)
+			return ret;
+	}
 
-	/*
-	 * A hotplug notifier will follow and we will handle it as CPU online
-	 * then.  For now, just create the sysfs link, unless there is no policy
-	 * or the link is already present.
-	 */
+	/* Create sysfs link on CPU registration */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
 		return 0;
 
-	return add_cpu_dev_symlink(policy, cpu);
+	ret = add_cpu_dev_symlink(policy, dev);
+	if (ret) {
+		cpumask_clear_cpu(cpu, policy->real_cpus);
+		cpufreq_offline(cpu);
+	}
+
+	return ret;
 }
 
 static void cpufreq_offline(unsigned int cpu)
@@ -1432,7 +1399,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		cpufreq_offline(cpu);
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
-	remove_cpu_dev_symlink(policy, cpu);
+	remove_cpu_dev_symlink(policy, dev);
 
 	if (cpumask_empty(policy->real_cpus))
 		cpufreq_policy_free(policy, true);
-- 
2.7.1.410.g6faf27b

