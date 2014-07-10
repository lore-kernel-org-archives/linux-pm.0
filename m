From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 18:11:44 +0530
Message-ID: <1eff59d9b51f8ade67bc1cf9f10683f9463ec9f6.1404996041.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37259 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbaGJMl5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 08:41:57 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so11113737pad.13
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2014 05:41:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>, Stable <stable@vger.kernel.org>

This is only relevant to implementations with multiple clusters, where clusters
have separate clock lines but all CPUs within a cluster share it.

Consider a dual cluster platform with 2 cores per cluster. During suspend we
start offlining CPUs from 1 to 3. When CPU2 is remove, policy->kobj would be
moved to CPU3 and when CPU3 goes down we wouldn't free policy or its kobj.

Now on resume, we will get CPU2 before CPU3 and will call __cpufreq_add_dev().
We will recover the old policy and update policy->cpu from 3 to 2 from
update_policy_cpu().

But the kobj is still tied to CPU3 and wasn't moved to CPU2. We wouldn't create
a link for CPU2, but would try that while bringing CPU3 online. Which will
report errors as CPU3 already has kobj assigned to it.

This bug got introduced with commit 42f921a, which overlooked this scenario.

To fix this, lets move kobj to the new policy->cpu while bringing first CPU of a
cluster back. We already have update_policy_cpu() routine which can be updated
with this change. That would get rid of the cpufreq_nominate_new_policy_cpu() as
update_policy_cpu() is also called on CPU removal.

To achieve that we add another parameter to update_policy_cpu() as cpu_dev is
present with both the callers.

Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed to come back after resume")
Cc: Stable <stable@vger.kernel.org> # 3.13+
Reported-by: Bu Yitian <ybu@qti.qualcomm.com>
Reported-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2: Move kobject_move() call to update_policy_cpu(), which makes
cpufreq_nominate_new_policy_cpu() almost empty. So we remove it completely.

@Yitian: Sorry, but you need to test this again as there were enough
modifications in V2.

 drivers/cpufreq/cpufreq.c | 73 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 62259d2..c81d9ec6 100644
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
@@ -1154,7 +1166,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	 * by invoking update_policy_cpu().
 	 */
 	if (recover_policy && cpu != policy->cpu)
-		update_policy_cpu(policy, cpu);
+		WARN_ON(update_policy_cpu(policy, cpu, dev));
 	else
 		policy->cpu = cpu;
 
@@ -1307,38 +1319,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
-		down_write(&policy->rwsem);
-		cpumask_set_cpu(old_cpu, policy->cpus);
-		up_write(&policy->rwsem);
-
-		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-					"cpufreq");
-
-		return -EINVAL;
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
 
@@ -1378,14 +1363,28 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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
+			/*
+			 * To supress compilation warning about return value of
+			 * sysfs_create_link().
+			 */
+			int temp;
+
+			/* Create link again if we failed. */
+			temp = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
+						 "cpufreq");
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

