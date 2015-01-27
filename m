From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/18] cpufreq: Initialize policy->kobj while allocating policy
Date: Tue, 27 Jan 2015 14:06:21 +0530
Message-ID: <96534b5472118c3f6efcdfb6d9df8d306fddffc9.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36354 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922AbbA0Ihi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:38 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so17194245pac.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:37 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

policy->kobj is required to be initialized once in the lifetime of a policy
while its allocated. Currently we are initializing it from __cpufreq_add_dev()
and that doesn't look to be the best place for doing so as we have to do this on
special cases (like: !recover_policy).

We can initialize it from a more obvious place cpufreq_policy_alloc() and that
will make code look cleaner, specially the error handling part.

The error handling part of __cpufreq_add_dev() was doing almost the same thing
while recover_policy is true or false. Fix that as well by always calling
cpufreq_policy_put_kobj() with an additional parameter to skip some steps.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fde0a75f9692..4a97d7428d25 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1067,9 +1067,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	return policy;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
+static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
@@ -1081,6 +1082,13 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
 	INIT_LIST_HEAD(&policy->fallback_list);
 	init_rwsem(&policy->rwsem);
@@ -1089,13 +1097,15 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
@@ -1104,13 +1114,14 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
@@ -1171,7 +1182,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
 	if (!policy) {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc(cpu);
+		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
 			goto nomem_out;
 	} else {
@@ -1206,15 +1217,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (!recover_policy) {
 		policy->user_policy.min = policy->min;
 		policy->user_policy.max = policy->max;
-
-		/* prepare interface data */
-		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
-					   &dev->kobj, "cpufreq");
-		if (ret) {
-			pr_err("%s: failed to init policy->kobj: %d\n",
-			       __func__, ret);
-			goto err_init_policy_kobj;
-		}
 	}
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
@@ -1305,19 +1307,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_del(&policy->policy_list);
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
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
@@ -1452,7 +1447,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	/* Free the policy kobjects only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_put_kobj(policy);
+		cpufreq_policy_put_kobj(policy, true);
 
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
-- 
2.3.0.rc0.44.ga94655d

