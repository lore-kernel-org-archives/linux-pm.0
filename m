From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] Revert "cpufreq: postfix policy directory with the first CPU in related_cpus"
Date: Thu,  3 Mar 2016 14:51:33 +0530
Message-ID: <eb862848df536cb2921945cca690161014c84750.1456996795.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33383 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbcCCJVz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 04:21:55 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so11653244pad.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 01:21:54 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

This reverts commit 3510fac45492 ("cpufreq: postfix policy directory
with the first CPU in related_cpus").

Earlier, the policy->kobj was added to the kobject core, before ->init()
callback was called for the cpufreq drivers. Which allowed those drivers
to add or remove, driver dependent, sysfs files/directories to the same
kobj from their ->init() and ->exit() callbacks.

That isn't possible anymore after commit 3510fac45492 got applied.

Now, there is no other clean alternative that people can adopt.

Its better to revert the earlier commit to allow cpufreq drivers to
create/remove sysfs files from ->init() and ->exit() callbacks.
---
@Rafael:

This is required current to get below patch modified and submitted.
http://marc.info/?l=linux-pm&m=145672798408786&w=2

 drivers/cpufreq/cpufreq.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6e9a829247ae..9113c8adf898 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1043,6 +1043,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
+	int ret;
 
 	if (WARN_ON(!dev))
 		return NULL;
@@ -1060,7 +1061,13 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
-	kobject_init(&policy->kobj, &ktype_cpufreq);
+	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
+				   cpufreq_global_kobject, "policy%u", cpu);
+	if (ret) {
+		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		goto err_free_real_cpus;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1071,6 +1078,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_free_real_cpus:
+	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
@@ -1175,16 +1184,6 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 		/* Remember CPUs present at the policy creation time. */
 		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
-
-		/* Name and add the kobject */
-		ret = kobject_add(&policy->kobj, cpufreq_global_kobject,
-				  "policy%u",
-				  cpumask_first(policy->related_cpus));
-		if (ret) {
-			pr_err("%s: failed to add policy->kobj: %d\n", __func__,
-			       ret);
-			goto out_exit_policy;
-		}
 	}
 
 	/*
-- 
2.7.1.410.g6faf27b

