From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/18] cpufreq: Reuse policy list instead of per-cpu variable 'cpufreq_cpu_data'
Date: Tue, 27 Jan 2015 14:06:12 +0530
Message-ID: <f3c1c9e77b044ec1f39b3a80f42cde45bb258f39.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40573 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbbA0IhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:04 -0500
Received: by mail-pd0-f177.google.com with SMTP id y13so17567723pdi.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:03 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Managing a per-cpu variable (cpufreq_cpu_data) for keeping track of policy
structures is a bit overdone. Apart from wasting some bytes of memory to save
these pointers for each cpu, it also makes the code much more complex.

It would be much better if we have a single place which needs updates on
addition/removal of a policy.

We already have a list of active-policies and that can be used instead of this
per-cpu variable.

Lets do it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 124 ++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 66 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4ad1e46891b5..7f947287ba46 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -49,11 +49,9 @@ static LIST_HEAD(cpufreq_governor_list);
 
 /**
  * The "cpufreq driver" - the arch- or hardware-dependent low
- * level driver of CPUFreq support, and its spinlock. This lock
- * also protects the cpufreq_cpu_data array.
+ * level driver of CPUFreq support, and its spinlock.
  */
 static struct cpufreq_driver *cpufreq_driver;
-static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
 
@@ -157,6 +155,54 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 
+/* Only for cpufreq core internal use */
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+
+	for_each_policy(policy)
+		if (cpumask_test_cpu(cpu, policy->cpus))
+			return policy;
+
+	return NULL;
+}
+
+struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = NULL;
+	unsigned long flags;
+
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	if (!down_read_trylock(&cpufreq_rwsem))
+		return NULL;
+
+	/* get the cpufreq driver */
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
+
+	if (cpufreq_driver) {
+		policy = cpufreq_cpu_get_raw(cpu);
+		if (policy)
+			kobject_get(&policy->kobj);
+	}
+
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+	if (!policy)
+		up_read(&cpufreq_rwsem);
+
+	return policy;
+}
+EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
+
+void cpufreq_cpu_put(struct cpufreq_policy *policy)
+{
+	kobject_put(&policy->kobj);
+	up_read(&cpufreq_rwsem);
+}
+EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
+
 /*
  * This is a generic cpufreq init() routine which can be used by cpufreq
  * drivers of SMP systems. It will do following:
@@ -190,7 +236,7 @@ EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
 unsigned int cpufreq_generic_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
 
 	if (!policy || IS_ERR(policy->clk)) {
 		pr_err("%s: No %s associated to cpu: %d\n",
@@ -202,49 +248,6 @@ unsigned int cpufreq_generic_get(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_get);
 
-/* Only for cpufreq core internal use */
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
-{
-	return per_cpu(cpufreq_cpu_data, cpu);
-}
-
-struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = NULL;
-	unsigned long flags;
-
-	if (cpu >= nr_cpu_ids)
-		return NULL;
-
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
-	/* get the cpufreq driver */
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
-
-	if (cpufreq_driver) {
-		/* get the CPU */
-		policy = per_cpu(cpufreq_cpu_data, cpu);
-		if (policy)
-			kobject_get(&policy->kobj);
-	}
-
-	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
-	return policy;
-}
-EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
-
-void cpufreq_cpu_put(struct cpufreq_policy *policy)
-{
-	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
-}
-EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
-
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
@@ -964,7 +967,6 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 				  unsigned int cpu, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
@@ -975,13 +977,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 	}
 
 	down_write(&policy->rwsem);
-
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-
 	cpumask_set_cpu(cpu, policy->cpus);
-	per_cpu(cpufreq_cpu_data, cpu) = policy;
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	up_write(&policy->rwsem);
 
 	if (has_target()) {
@@ -1105,7 +1101,7 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 
 static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
-	unsigned int j, cpu = dev->id;
+	unsigned int cpu = dev->id;
 	int ret = -ENOMEM;
 	struct cpufreq_policy *policy;
 	unsigned long flags;
@@ -1202,8 +1198,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_cpu(j, policy->cpus)
-		per_cpu(cpufreq_cpu_data, j) = policy;
+	list_add(&policy->policy_list, &cpufreq_policy_list);
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
@@ -1265,10 +1260,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 				CPUFREQ_CREATE_POLICY, policy);
 	}
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	list_add(&policy->policy_list, &cpufreq_policy_list);
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	cpufreq_init_policy(policy);
 
 	if (!recover_policy) {
@@ -1292,8 +1283,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 err_out_unregister:
 err_get_freq:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_cpu(j, policy->cpus)
-		per_cpu(cpufreq_cpu_data, j) = NULL;
+	list_del(&policy->policy_list);
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	if (!recover_policy) {
@@ -1340,7 +1330,10 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
 
-	policy = per_cpu(cpufreq_cpu_data, cpu);
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
+	policy = cpufreq_cpu_get_raw(cpu);
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
 		return -EINVAL;
@@ -1404,7 +1397,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	struct cpufreq_policy *policy;
 
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	policy = per_cpu(cpufreq_cpu_data, cpu);
+	policy = cpufreq_cpu_get_raw(cpu);
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	if (!policy) {
@@ -1460,7 +1453,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	return 0;
 }
 
-- 
2.3.0.rc0.44.ga94655d

