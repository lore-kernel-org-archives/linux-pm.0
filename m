From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 12/14] cpufreq: Initialize policy->kobj while allocating policy
Date: Mon, 18 May 2015 10:43:35 +0530
Message-ID: <a85a378f2a85a4e986834a4cc7414dbc635cc466.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36385 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbERFOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:36 -0400
Received: by pdfh10 with SMTP id h10so133419147pdf.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:36 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

policy->kobj is required to be initialized once in the lifetime of a
policy.  Currently we are initializing it from __cpufreq_add_dev() and
that doesn't look to be the best place for doing so as we have to do
this on special cases (like: !recover_policy).

We can initialize it from a more obvious place cpufreq_policy_alloc()
and that will make code look cleaner, specially the error handling part.

The error handling part of __cpufreq_add_dev() was doing almost the same
thing while recover_policy is true or false. Fix that as well by always
calling cpufreq_policy_put_kobj() with an additional parameter to skip
notification part of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a16dd26b39f1..1137e7942278 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1117,9 +1117,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	return policy;
 }
 
-static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
+static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 {
 	struct cpufreq_policy *policy;
+	int ret;
 
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
@@ -1131,6 +1132,13 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
@@ -1138,13 +1146,15 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
@@ -1153,13 +1163,14 @@ static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
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
@@ -1249,7 +1260,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
 	if (!policy) {
 		recover_policy = false;
-		policy = cpufreq_policy_alloc(cpu);
+		policy = cpufreq_policy_alloc(dev);
 		if (!policy)
 			goto nomem_out;
 	}
@@ -1280,15 +1291,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -1380,18 +1382,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
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
@@ -1490,7 +1486,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	/* Free the policy kobjects only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_put_kobj(policy);
+		cpufreq_policy_put_kobj(policy, true);
 
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
@@ -1538,7 +1534,7 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		if (cpumask_intersects(&mask, cpu_present_mask))
 			return add_remove_cpu_dev_symlink(policy, cpu, false);
 
-		cpufreq_policy_put_kobj(policy);
+		cpufreq_policy_put_kobj(policy, true);
 		cpufreq_policy_free(policy);
 		return 0;
 	}
-- 
2.4.0

