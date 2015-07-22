From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cpufreq: Remove cpufreq_rwsem
Date: Wed, 22 Jul 2015 12:25:30 +0200
Message-ID: <1437560730-31756-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38449 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077AbbGVMr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 08:47:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

cpufreq_rwsem was introduced in commit 6eed9404ab3c4 ("cpufreq: Use
rwsem for protecting critical sections) in order to replace
try_module_get() on the cpu-freq driver. That try_module_get() worked
well until the refcount was so heavily used that module removal became
more or less impossible.

Though when looking at the various (undocumented) protection
mechanisms in that code, the randomly sprinkeled around cpufreq_rwsem
locking sites are superfluous.

The policy, which is acquired in cpufreq_cpu_get() and released in
cpufreq_cpu_put() is sufficiently protected already.

  cpufreq_cpu_get(cpu)
    /* Protects against concurrent driver removal */
    read_lock_irqsave(&cpufreq_driver_lock, flags);
    policy = per_cpu(cpufreq_cpu_data, cpu);
    kobject_get(&policy->kobj);
    read_unlock_irqrestore(&cpufreq_driver_lock, flags);

The reference on the policy serializes versus module unload already:

  cpufreq_unregister_driver()
    subsys_interface_unregister()
      __cpufreq_remove_dev_finish()
        per_cpu(cpufreq_cpu_data) = NULL;
	cpufreq_policy_put_kobj()

If there is a reference held on the policy, i.e. obtained prior to the
unregister call, then cpufreq_policy_put_kobj() will wait until that
reference is dropped. So once subsys_interface_unregister() returns
there is no policy pointer in flight and no new reference can be
obtained. So that rwsem protection is useless.

The other usage of cpufreq_rwsem in show()/store() of the sysfs
interface is redundant as well because sysfs already does the proper
kobject_get()/put() pairs.

That leaves CPU hotplug versus module removal. The current
down_write() around the write_lock() in cpufreq_unregister_driver() is
silly at best as it protects actually nothing.

The trivial solution to this is to prevent hotplug across
cpufreq_unregister_driver completely.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/cpufreq.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 26063afb3eba..3562a124b971 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -112,12 +112,6 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
-/*
- * rwsem to guarantee that cpufreq driver module doesn't unload during critical
- * sections
- */
-static DECLARE_RWSEM(cpufreq_rwsem);
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -277,10 +271,6 @@ EXPORT_SYMBOL_GPL(cpufreq_generic_get);
  * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
  * freed as that depends on the kobj count.
  *
- * It also takes a read-lock of 'cpufreq_rwsem' and doesn't put it back if a
- * valid policy is found. This is done to make sure the driver doesn't get
- * unregistered while the policy is being used.
- *
  * Return: A valid policy on success, otherwise NULL on failure.
  */
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
@@ -291,9 +281,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	if (WARN_ON(cpu >= nr_cpu_ids))
 		return NULL;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return NULL;
-
 	/* get the cpufreq driver */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
@@ -306,9 +293,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy)
-		up_read(&cpufreq_rwsem);
-
 	return policy;
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -320,13 +304,10 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
  *
  * This decrements the kobject reference count incremented earlier by calling
  * cpufreq_cpu_get().
- *
- * It also drops the read-lock of 'cpufreq_rwsem' taken at cpufreq_cpu_get().
  */
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {
 	kobject_put(&policy->kobj);
-	up_read(&cpufreq_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -851,9 +832,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return -EINVAL;
-
 	down_read(&policy->rwsem);
 
 	if (fattr->show)
@@ -862,7 +840,6 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		ret = -EIO;
 
 	up_read(&policy->rwsem);
-	up_read(&cpufreq_rwsem);
 
 	return ret;
 }
@@ -879,9 +856,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!cpu_online(policy->cpu))
 		goto unlock;
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		goto unlock;
-
 	down_write(&policy->rwsem);
 
 	/* Updating inactive policies is invalid, so avoid doing that. */
@@ -897,8 +871,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 unlock_policy_rwsem:
 	up_write(&policy->rwsem);
-
-	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
 
@@ -1267,17 +1239,15 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpu_is_offline(cpu))
 		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
 
-	if (!down_read_trylock(&cpufreq_rwsem))
-		return 0;
-
 	/* Check if this CPU already has a policy to manage it */
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (policy && !policy_is_inactive(policy)) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
 		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
-		up_read(&cpufreq_rwsem);
 		return ret;
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	/*
 	 * Restore the saved policy when doing light-weight init and fall back
@@ -1396,8 +1366,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 
-	up_read(&cpufreq_rwsem);
-
 	/* Callback for handling stuff after policy is ready */
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
@@ -1415,8 +1383,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 err_set_policy_cpu:
 	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
-	up_read(&cpufreq_rwsem);
-
 	return ret;
 }
 
@@ -2586,19 +2552,20 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 
 	pr_debug("unregistering driver %s\n", driver->name);
 
+	/* Protect against concurrent cpu hotplug */
+	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	if (cpufreq_boost_supported())
 		cpufreq_sysfs_remove_file(&boost.attr);
 
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
-	down_write(&cpufreq_rwsem);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	cpufreq_driver = NULL;
 
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	up_write(&cpufreq_rwsem);
+	put_online_cpus();
 
 	return 0;
 }
-- 
2.1.4

