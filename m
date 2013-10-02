From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 01/11] cpufreq: make return type of lock_policy_rwsem_{read|write}() as void
Date: Wed,  2 Oct 2013 14:13:09 +0530
Message-ID: <b361f4df33e414ecd2e8a25959746e84da789d6a.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47625 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab3JBIne (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 04:43:34 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so581355pbc.37
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 01:43:34 -0700 (PDT)
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

lock_policy_rwsem_{read|write}() currently has return type of int but it always
return zero and hence its return type must be void instead. This patch makes its
return type void and fixes all users of it as well.

Reported-by: Jon Medhurst<tixy@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04548f7..eb993d9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -67,13 +67,11 @@ static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
 static DEFINE_PER_CPU(struct rw_semaphore, cpu_policy_rwsem);
 
 #define lock_policy_rwsem(mode, cpu)					\
-static int lock_policy_rwsem_##mode(int cpu)				\
+static void lock_policy_rwsem_##mode(int cpu)				\
 {									\
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);	\
 	BUG_ON(!policy);						\
 	down_##mode(&per_cpu(cpu_policy_rwsem, policy->cpu));		\
-									\
-	return 0;							\
 }
 
 lock_policy_rwsem(read, cpu);
@@ -653,13 +651,12 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
 
 	if (!down_read_trylock(&cpufreq_rwsem))
-		goto exit;
+		return -EINVAL;
 
-	if (lock_policy_rwsem_read(policy->cpu) < 0)
-		goto up_read;
+	lock_policy_rwsem_read(policy->cpu);
 
 	if (fattr->show)
 		ret = fattr->show(policy, buf);
@@ -667,10 +664,8 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		ret = -EIO;
 
 	unlock_policy_rwsem_read(policy->cpu);
-
-up_read:
 	up_read(&cpufreq_rwsem);
-exit:
+
 	return ret;
 }
 
@@ -689,8 +684,7 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!down_read_trylock(&cpufreq_rwsem))
 		goto unlock;
 
-	if (lock_policy_rwsem_write(policy->cpu) < 0)
-		goto up_read;
+	lock_policy_rwsem_write(policy->cpu);
 
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
@@ -699,7 +693,6 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	unlock_policy_rwsem_write(policy->cpu);
 
-up_read:
 	up_read(&cpufreq_rwsem);
 unlock:
 	put_online_cpus();
@@ -1147,7 +1140,7 @@ static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
 	if (ret) {
 		pr_err("%s: Failed to move kobj: %d", __func__, ret);
 
-		WARN_ON(lock_policy_rwsem_write(old_cpu));
+		lock_policy_rwsem_write(old_cpu);
 		cpumask_set_cpu(old_cpu, policy->cpus);
 		unlock_policy_rwsem_write(old_cpu);
 
@@ -1243,7 +1236,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		return -EINVAL;
 	}
 
-	WARN_ON(lock_policy_rwsem_write(cpu));
+	lock_policy_rwsem_write(cpu);
 	cpus = cpumask_weight(policy->cpus);
 
 	if (cpus > 1)
@@ -1466,14 +1459,11 @@ unsigned int cpufreq_get(unsigned int cpu)
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
 
-	if (unlikely(lock_policy_rwsem_read(cpu)))
-		goto out_policy;
+	lock_policy_rwsem_read(cpu);
 
 	ret_freq = __cpufreq_get(cpu);
 
 	unlock_policy_rwsem_read(cpu);
-
-out_policy:
 	up_read(&cpufreq_rwsem);
 
 	return ret_freq;
@@ -1697,14 +1687,12 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 {
 	int ret = -EINVAL;
 
-	if (unlikely(lock_policy_rwsem_write(policy->cpu)))
-		goto fail;
+	lock_policy_rwsem_write(policy->cpu);
 
 	ret = __cpufreq_driver_target(policy, target_freq, relation);
 
 	unlock_policy_rwsem_write(policy->cpu);
 
-fail:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
@@ -1995,10 +1983,7 @@ int cpufreq_update_policy(unsigned int cpu)
 		goto no_policy;
 	}
 
-	if (unlikely(lock_policy_rwsem_write(cpu))) {
-		ret = -EINVAL;
-		goto fail;
-	}
+	lock_policy_rwsem_write(cpu);
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
@@ -2027,7 +2012,6 @@ int cpufreq_update_policy(unsigned int cpu)
 
 	unlock_policy_rwsem_write(cpu);
 
-fail:
 	cpufreq_cpu_put(policy);
 no_policy:
 	return ret;
-- 
1.7.12.rc2.18.g61b472e

