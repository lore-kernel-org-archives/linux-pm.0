From: <Yuantian.Tang@freescale.com>
Subject: [PATCH] cpufreq: Fix the driver can not be unloaded issue
Date: Wed, 24 Apr 2013 16:28:12 +0800
Message-ID: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:47981
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757563Ab3DXJJH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2013 05:09:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, Tang Yuantian <yuantian.tang@freescale.com>, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <yuantian.tang@freescale.com>

The driver compiled as a module can not be unloaded if there
are more than one cpu in policy->cpus. That's caused by
cpufreq_cpu_get() in cpufreq_add_dev_symlink(); It keep increasing
the module reference count.
This patch splites the module and policy reference count. It keeps
the module reference count unchanged and uses the policy reference
count to track the resource.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/cpufreq/cpufreq.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a6f6595..86abee5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -154,26 +154,22 @@ static struct cpufreq_policy *__cpufreq_cpu_get(unsigned int cpu, bool sysfs)
 	if (!driver)
 		goto err_out_unlock;
 
-	if (!try_module_get(driver->owner))
-		goto err_out_unlock;
-
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	/* get the CPU */
 	data = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!data)
-		goto err_out_put_module;
+		goto err_out_read_unlock;
 
 	if (!sysfs && !kobject_get(&data->kobj))
-		goto err_out_put_module;
+		goto err_out_read_unlock;
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	rcu_read_unlock();
 	return data;
 
-err_out_put_module:
-	module_put(driver->owner);
+err_out_read_unlock:
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 err_out_unlock:
 	rcu_read_unlock();
@@ -199,9 +195,6 @@ static void __cpufreq_cpu_put(struct cpufreq_policy *data, bool sysfs)
 {
 	if (!sysfs)
 		kobject_put(&data->kobj);
-	rcu_read_lock();
-	module_put(rcu_dereference(cpufreq_driver)->owner);
-	rcu_read_unlock();
 }
 
 void cpufreq_cpu_put(struct cpufreq_policy *data)
@@ -1076,7 +1069,6 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
 	unsigned long flags;
 	struct cpufreq_policy *data;
 	struct cpufreq_driver *driver;
-	struct kobject *kobj;
 	struct completion *cmp;
 	struct device *cpu_dev;
 	bool has_target;
@@ -1157,10 +1149,8 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
 			__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
 
 		lock_policy_rwsem_read(cpu);
-		kobj = &data->kobj;
 		cmp = &data->kobj_unregister;
 		unlock_policy_rwsem_read(cpu);
-		kobject_put(kobj);
 
 		/* we need to make sure that the underlying kobj is actually
 		 * not referenced anymore by anybody before we proceed with
-- 
1.8.0


