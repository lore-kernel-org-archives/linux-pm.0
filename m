From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 20/20] cpufreq: Add support for physical hoplug of CPUs
Date: Thu, 19 Feb 2015 17:02:22 +0530
Message-ID: <c2e04a64ef88bbffe2117717a7cf877791ab798f.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45626 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbBSLel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:41 -0500
Received: by pablf10 with SMTP id lf10so8797014pab.12
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:40 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, Srivatsa Bhat <srivatsa@mit.edu>

It is possible to physically hotplug the CPUs and it happens in this sequence.

Hot removal:
- CPU is offlined first, ~ 'echo 0 > /sys/devices/system/cpu/cpuX/online'
- Then its device is removed along with all sysfs files, cpufreq core notified
  with cpufreq_remove_dev() callback from subsys-interface..

Hot addition:
- First the device along with its sysfs files is added, cpufreq core notified
  with cpufreq_add_dev() callback from subsys-interface..
- CPU is onlined, ~ 'echo 1 > /sys/devices/system/cpu/cpuX/online'

This needs to be handled specially as current code isn't taking care of this
case. Because we will hit the same routines with both hotplug and subsys
callbacks, we can handle most of the stuff with regular hotplug callback paths.
We only need to take care of adding/removing cpufreq sysfs links or freeing
policy from subsys callbacks.

And that can be sensed easily as cpu would be offline in those cases. This patch
adds special code in those paths to take care of policy and its links.

cpufreq_add_remove_dev_symlink() is also broken into another routine
add_remove_cpu_dev_symlink() to reuse code at several places.

Cc: Srivatsa Bhat <srivatsa@mit.edu>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 87 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ffb6700c7195..3213d81a822c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -972,6 +972,26 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
+static inline int add_remove_cpu_dev_symlink(struct cpufreq_policy *policy,
+					     int cpu, bool add)
+{
+	struct device *cpu_dev;
+
+	pr_debug("%s: %s symlink for CPU: %u\n", __func__,
+		 add ? "Adding" : "Removing", cpu);
+
+	cpu_dev = get_cpu_device(cpu);
+	if (WARN_ON(!cpu_dev))
+		return 0;
+
+	if (add)
+		return sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
+					 "cpufreq");
+
+	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+	return 0;
+}
+
 /* Add/remove symlinks for all related CPUs */
 static int cpufreq_add_remove_dev_symlink(struct cpufreq_policy *policy,
 					  bool add)
@@ -979,27 +999,14 @@ static int cpufreq_add_remove_dev_symlink(struct cpufreq_policy *policy,
 	unsigned int j;
 	int ret = 0;
 
-	for_each_cpu(j, policy->related_cpus) {
-		struct device *cpu_dev;
-
+	/* Some related CPUs might not be present (physically hotplugged) */
+	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
 		if (j == policy->kobj_cpu)
 			continue;
 
-		pr_debug("%s: %s symlink for CPU: %u\n", __func__,
-			 add ? "Adding" : "Removing", j);
-
-		cpu_dev = get_cpu_device(j);
-		if (WARN_ON(!cpu_dev))
-			continue;
-
-		if (add) {
-			ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-						"cpufreq");
-			if (ret)
-				break;
-		} else {
-			sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
-		}
+		ret = add_remove_cpu_dev_symlink(policy, j, add);
+		if (ret)
+			break;
 	}
 
 	return ret;
@@ -1233,11 +1240,23 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	unsigned long flags;
 	bool recover_policy = !sif;
 
-	if (cpu_is_offline(cpu))
-		return 0;
-
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
 
@@ -1496,8 +1515,32 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
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
+		/* Prepare mask similar to related-cpus without this 'cpu' */
+		cpumask_copy(&mask, policy->related_cpus);
+		cpumask_clear_cpu(cpu, &mask);
+
+		/*
+		 * Remove link if few CPUs are still present physically, else
+		 * free policy when all are gone.
+		 */
+		if (cpumask_intersects(&mask, cpu_present_mask))
+			return add_remove_cpu_dev_symlink(policy, cpu, false);
+
+		cpufreq_policy_free(policy, true);
 		return 0;
+	}
 
 	ret = __cpufreq_remove_dev_prepare(dev, sif);
 
-- 
2.3.0.rc0.44.ga94655d

