From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: Create links for offline CPUs that got added earlier
Date: Thu, 23 Jul 2015 13:43:19 +0530
Message-ID: <7e3b8b132812be7d8b80b065517d115a121b3c48.1437639021.git.viresh.kumar@linaro.org>
References: <20150723060938.GD5322@linux>
 <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36594 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbGWINf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 04:13:35 -0400
Received: by pdjr16 with SMTP id r16so156025029pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2015 01:13:34 -0700 (PDT)
In-Reply-To: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
In-Reply-To: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
References: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

If subsys callback ->add_dev() is called for an offline CPU, before its
policy is allocated, we will miss adding its sysfs symlink.

Fix this by tracking such CPUs in a separate mask.

Fixes: 9b07109f06a1 ("cpufreq: Fix double addition of sysfs links")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 74 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 84504ae3fb38..d01cad993fa7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,6 +31,12 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
+/*
+ * CPUs that were offline when a request to allocate policy was issued, symlinks
+ * for them should be created once the policy is available for them.
+ */
+cpumask_t linked_cpus_pending;
+
 static LIST_HEAD(cpufreq_policy_list);
 
 static inline bool policy_is_inactive(struct cpufreq_policy *policy)
@@ -938,6 +944,47 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
+static int cpufreq_add_symlink(struct cpufreq_policy *policy,
+			       struct device *dev)
+{
+	int ret, cpu = dev->id;
+
+	dev_dbg(dev, "%s: Adding symlink for CPU: %u\n", __func__, cpu);
+	ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	if (ret) {
+		dev_err(dev, "%s: Failed to create link (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	/* Track CPUs for which sysfs links are created */
+	cpumask_set_cpu(cpu, policy->linked_cpus);
+	return 0;
+}
+
+/*
+ * Create symlinks for CPUs which are already added via subsys callbacks (and
+ * were offline then), before the policy was created.
+ */
+static int cpufreq_add_pending_symlinks(struct cpufreq_policy *policy)
+{
+	struct cpumask mask;
+	int cpu, ret;
+
+	cpumask_and(&mask, policy->related_cpus, &linked_cpus_pending);
+
+	if (cpumask_empty(&mask))
+		return 0;
+
+	for_each_cpu(cpu, &mask) {
+		ret = cpufreq_add_symlink(policy, get_cpu_device(cpu));
+		if (ret)
+			return ret;
+		cpumask_clear_cpu(cpu, &linked_cpus_pending);
+	}
+
+	return 0;
+}
+
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 				     struct device *dev)
 {
@@ -968,7 +1015,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 			return ret;
 	}
 
-	return 0;
+	return cpufreq_add_pending_symlinks(policy);
 }
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
@@ -1170,24 +1217,21 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* sysfs links are only created on subsys callback */
 	if (sif && policy) {
-		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
-		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
-		if (ret) {
-			dev_err(dev, "%s: Failed to create link (%d)\n",
-				__func__, ret);
+		ret = cpufreq_add_symlink(policy, dev);
+		if (ret)
 			return ret;
-		}
-
-		/* Track CPUs for which sysfs links are created */
-		cpumask_set_cpu(cpu, policy->linked_cpus);
 	}
 
 	/*
 	 * A hotplug notifier will follow and we will take care of rest
 	 * of the initialization then.
 	 */
-	if (cpu_is_offline(cpu))
+	if (cpu_is_offline(cpu)) {
+		/* symlink should be added for this CPU later */
+		if (!policy)
+			cpumask_set_cpu(cpu, &linked_cpus_pending);
 		return 0;
+	}
 
 	/* Check if this CPU already has a policy to manage it */
 	if (policy && !policy_is_inactive(policy)) {
@@ -1440,8 +1484,10 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 	int ret;
 
-	if (!policy)
+	if (!policy) {
+		cpumask_clear_cpu(cpu, &linked_cpus_pending);
 		return 0;
+	}
 
 	if (cpu_online(cpu)) {
 		ret = __cpufreq_remove_dev_prepare(dev, sif);
@@ -2533,10 +2579,14 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	/* Protect against concurrent cpu hotplug */
 	get_online_cpus();
+
 	subsys_interface_unregister(&cpufreq_interface);
 	if (cpufreq_boost_supported())
 		cpufreq_sysfs_remove_file(&boost.attr);
 
+	if (WARN_ON(!cpumask_empty(&linked_cpus_pending)))
+		cpumask_clear(&linked_cpus_pending);
+
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-- 
2.4.0

