From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 17/20] cpufreq: Initialize policy->kobj while allocating policy
Date: Thu, 19 Feb 2015 17:02:19 +0530
Message-ID: <616a114169996c54547a4d9e60c8c003df68b81b.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38548 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbbBSLe3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:29 -0500
Received: by padbj1 with SMTP id bj1so8869934pad.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:29 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

policy->kobj is required to be initialized once in the lifetime of a policy.
Currently we are initializing it from __cpufreq_add_dev() and that doesn't look
to be the best place for doing so as we have to do this on special cases (like:
!recover_policy).

We can initialize it from a more obvious place cpufreq_policy_alloc() and that
will make code look cleaner, specially the error handling part.

The error handling part of __cpufreq_add_dev() was doing almost the same thing
while recover_policy is true or false. Fix that as well by always calling
cpufreq_policy_put_kobj() with an additional parameter to skip notification part
of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 814a8c70e2b1..4fb5041ebfab 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1125,9 +1125,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	return policy;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
+static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
@@ -1139,6 +1140,13 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
+	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
+				   "cpufreq");
+	if (ret) {
+		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		goto err_free_rcpumask;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1146,13 +1154,15 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
 
-	policy->cpu = cpu;
+	policy->cpu = dev->id;
 
 	/* Set this once on allocation */
-	policy->kobj_cpu = cpu;
+	policy->kobj_cpu = dev->id;
 
 	return policy;
 
+err_free_rcpumask:
+	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
 	free_cpumask_var(policy->cpus);
 err_free_policy:
@@ -1161,13 +1171,14 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 {
 	struct kobject *kobj;
 	struct completion *cmp;
 
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_REMOVE_POLICY, policy);
+	if (notify)
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
 
 	down_write(&policy->rwsem);
 	cpufreq_add_remove_dev_symlink(policy, false);
@@ -1245,7 +1256,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
 	if (!policy) {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc(cpu);
+		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
 			goto nomem_out;
 	}
@@ -1276,15 +1287,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		policy->user_policy.min = policy->min;
 		policy->user_policy.max = policy->max;
 
-		/* prepare interface data */
-		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
-					   &dev->kobj, "cpufreq");
-		if (ret) {
-			pr_err("%s: failed to init policy->kobj: %d\n",
-			       __func__, ret);
-			goto err_init_policy_kobj;
-		}
-
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		for_each_cpu(j, policy->related_cpus)
 			per_cpu(cpufreq_cpu_data, j) = policy;
@@ -1376,18 +1378,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 err_out_unregister:
 err_get_freq:
-	if (!recover_policy) {
-		kobject_put(&policy->kobj);
-		wait_for_completion(&policy->kobj_unregister);
-	}
-err_init_policy_kobj:
 	up_write(&policy->rwsem);
 
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	if (recover_policy)
-		cpufreq_policy_put_kobj(policy);
+	cpufreq_policy_put_kobj(policy, recover_policy);
 	cpufreq_policy_free(policy);
 
 nomem_out:
@@ -1486,7 +1482,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	/* Free the policy kobjects only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_put_kobj(policy);
+		cpufreq_policy_put_kobj(policy, true);
 
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
-- 
2.3.0.rc0.44.ga94655d

