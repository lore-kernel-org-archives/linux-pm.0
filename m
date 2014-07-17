From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 4/4] cpufreq: move policy kobj from update_policy_cpu()
Date: Thu, 17 Jul 2014 10:48:28 +0530
Message-ID: <ce7159132a9be4ae54524a2f73fea0b11fb41a83.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:55364 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaGQFUN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 01:20:13 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so1604417qgd.12
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 22:20:12 -0700 (PDT)
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>

We are calling kobject_move() from two separate places currently and both these
places share another routine update_policy_cpu() which is handling everything
around updating policy->cpu. Moving ownership of policy->kobj also lies under
the role of update_policy_cpu() routine and must handled from there.

So, Lets move kobject_move() to update_policy_cpu() and get rid of
cpufreq_nominate_new_policy_cpu() as it doesn't have anything significant left.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 71 ++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ec25ca6..d9fdedd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1076,10 +1076,20 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
-static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
+static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
+			     struct device *cpu_dev)
 {
+	int ret;
+
 	if (WARN_ON(cpu == policy->cpu))
-		return;
+		return 0;
+
+	/* Move kobject to the new policy->cpu */
+	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
+	if (ret) {
+		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
+		return ret;
+	}
 
 	down_write(&policy->rwsem);
 
@@ -1090,6 +1100,8 @@ static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_UPDATE_POLICY_CPU, policy);
+
+	return 0;
 }
 
 static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
@@ -1153,12 +1165,10 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	 * the creation of a brand new one. So we need to perform this update
 	 * by invoking update_policy_cpu().
 	 */
-	if (recover_policy && cpu != policy->cpu) {
-		update_policy_cpu(policy, cpu);
-		WARN_ON(kobject_move(&policy->kobj, &dev->kobj));
-	} else {
+	if (recover_policy && cpu != policy->cpu)
+		WARN_ON(update_policy_cpu(policy, cpu, dev));
+	else
 		policy->cpu = cpu;
-	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
@@ -1309,35 +1319,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return __cpufreq_add_dev(dev, sif);
 }
 
-static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
-					   unsigned int old_cpu)
-{
-	struct device *cpu_dev;
-	int ret;
-
-	/* first sibling now owns the new sysfs dir */
-	cpu_dev = get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
-
-	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
-	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
-	if (ret) {
-		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
-
-		if (sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq"))
-			pr_err("%s: Failed to restore kobj link to cpu:%d\n",
-			       __func__, cpu_dev->id);
-
-		return ret;
-	}
-
-	return cpu_dev->id;
-}
-
 static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id, cpus;
-	int new_cpu, ret;
+	int ret;
 	unsigned long flags;
 	struct cpufreq_policy *policy;
 
@@ -1377,14 +1363,23 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	if (cpu != policy->cpu) {
 		sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
-		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu);
-		if (new_cpu >= 0) {
-			update_policy_cpu(policy, new_cpu);
+		/* Nominate new CPU */
+		int new_cpu = cpumask_any_but(policy->cpus, cpu);
+		struct device *cpu_dev = get_cpu_device(new_cpu);
 
-			if (!cpufreq_suspended)
-				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
-					 __func__, new_cpu, cpu);
+		sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+		ret = update_policy_cpu(policy, new_cpu, cpu_dev);
+		if (ret) {
+			if (sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
+					      "cpufreq"))
+				pr_err("%s: Failed to restore kobj link to cpu:%d\n",
+				       __func__, cpu_dev->id);
+			return ret;
 		}
+
+		if (!cpufreq_suspended)
+			pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
+				 __func__, new_cpu, cpu);
 	} else if (cpufreq_driver->stop_cpu && cpufreq_driver->setpolicy) {
 		cpufreq_driver->stop_cpu(policy);
 	}
-- 
2.0.0.rc2

