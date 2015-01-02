From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/17] cpufreq: get rid of CONFIG_{HOTPLUG_CPU|SMP} mess
Date: Fri,  2 Jan 2015 12:34:31 +0530
Message-ID: <dda29d27d5ed0c47cacbb2f599c55bf095f1d693.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50159 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:32 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so23378311pde.29
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:32 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

These are messing up more than the benefit they provide. It isn't a lot of code
anyway, that we will compile without them.

Kill them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9595107477a6..3893c87739d1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -957,7 +957,6 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 				  unsigned int cpu, struct device *dev)
 {
@@ -995,7 +994,6 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 
 	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 }
-#endif
 
 static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 {
@@ -1100,19 +1098,15 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy, *tpolicy;
 	unsigned long flags;
 	bool recover_policy = cpufreq_suspended;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct cpufreq_policy *tpolicy;
-#endif
 
 	if (cpu_is_offline(cpu))
 		return 0;
 
 	pr_debug("adding CPU %u\n", cpu);
 
-#ifdef CONFIG_SMP
 	/* check whether a different CPU already registered this
 	 * CPU because it is in the same boat. */
 	policy = cpufreq_cpu_get(cpu);
@@ -1120,12 +1114,10 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		cpufreq_cpu_put(policy);
 		return 0;
 	}
-#endif
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
 
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list) {
@@ -1137,7 +1129,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		}
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-#endif
 
 	/*
 	 * Restore the saved policy when doing light-weight init and fall back
-- 
2.2.0

