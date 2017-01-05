From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Remove policy create/remove notifiers
Date: Thu,  5 Jan 2017 10:17:27 +0530
Message-ID: <aa506a09afc758a615c952b9b53fd1e311409b14.1483591640.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35064 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdAEEri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2017 23:47:38 -0500
Received: by mail-pg0-f54.google.com with SMTP id i5so170634722pgh.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2017 20:47:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Those were added by:

commit fcd7af917abb ("cpufreq: stats: handle cpufreq_unregister_driver()
and suspend/resume properly")

but aren't used anymore since:

commit 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular").

Remove them. Also remove the redundant parameter to the respective
routines.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 16 +++++-----------
 include/linux/cpufreq.h   |  2 --
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cc475eff90b3..53268bebdf1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1078,15 +1078,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
 {
 	struct kobject *kobj;
 	struct completion *cmp;
 
-	if (notify)
-		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-					     CPUFREQ_REMOVE_POLICY, policy);
-
 	down_write(&policy->rwsem);
 	cpufreq_stats_free_table(policy);
 	kobj = &policy->kobj;
@@ -1104,7 +1100,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
+static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
 	unsigned long flags;
 	int cpu;
@@ -1117,7 +1113,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	cpufreq_policy_put_kobj(policy, notify);
+	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
@@ -1244,8 +1240,6 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_exit_policy;
 
 		cpufreq_stats_create_table(policy);
-		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-				CPUFREQ_CREATE_POLICY, policy);
 
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		list_add(&policy->policy_list, &cpufreq_policy_list);
@@ -1282,7 +1276,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 out_free_policy:
-	cpufreq_policy_free(policy, !new_policy);
+	cpufreq_policy_free(policy);
 	return ret;
 }
 
@@ -1403,7 +1397,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	remove_cpu_dev_symlink(policy, dev);
 
 	if (cpumask_empty(policy->real_cpus))
-		cpufreq_policy_free(policy, true);
+		cpufreq_policy_free(policy);
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 30feeb34963e..0183986b3ba6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -416,8 +416,6 @@ static inline void cpufreq_resume(void) {}
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
 #define CPUFREQ_START			(2)
-#define CPUFREQ_CREATE_POLICY		(3)
-#define CPUFREQ_REMOVE_POLICY		(4)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.7.1.410.g6faf27b

