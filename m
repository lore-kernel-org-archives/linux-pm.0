From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH] cpufreq: Fix race between sysfs writes and hotplug/policy update
Date: Sat, 22 Jun 2013 20:02:20 -0700
Message-ID: <1371956540-8830-1-git-send-email-skannan@codeaurora.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The sysfs store ops need to grab the policy write semaphore to avoid race
with hotplug and cpufreq_update_policy() calls. Without this, we could end
up with simultaneous calls to cpufreq_driver->target()

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
There still seem to be race conditions between cpufreq_update_policy() and
the cpufreq hotplug path. But that seems more complicated to fix. So,
leaving that for later.

 drivers/cpufreq/cpufreq.c           |   10 ++++++++++
 drivers/cpufreq/cpufreq_userspace.c |   11 +----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2d53f47..37db7f0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -420,9 +420,13 @@ static ssize_t store_##file_name					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
+	lock_policy_rwsem_write(policy->cpu);				\
+									\
 	ret = __cpufreq_set_policy(policy, &new_policy);		\
 	policy->user_policy.object = policy->object;			\
 									\
+	unlock_policy_rwsem_write(policy->cpu);				\
+									\
 	return ret ? ret : count;					\
 }
 
@@ -480,6 +484,8 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 						&new_policy.governor))
 		return -EINVAL;
 
+	lock_policy_rwsem_write(policy->cpu);
+
 	/* Do not use cpufreq_set_policy here or the user_policy.max
 	   will be wrongly overridden */
 	ret = __cpufreq_set_policy(policy, &new_policy);
@@ -487,6 +493,8 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 	policy->user_policy.policy = policy->policy;
 	policy->user_policy.governor = policy->governor;
 
+	unlock_policy_rwsem_write(policy->cpu);
+
 	if (ret)
 		return ret;
 	else
@@ -572,7 +580,9 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 	if (ret != 1)
 		return -EINVAL;
 
+	lock_policy_rwsem_write(policy->cpu);
 	policy->governor->store_setspeed(policy, freq);
+	unlock_policy_rwsem_write(policy->cpu);
 
 	return count;
 }
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index bbeb9c0..b7dd5b8 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -87,16 +87,7 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 	if (freq > per_cpu(cpu_max_freq, policy->cpu))
 		freq = per_cpu(cpu_max_freq, policy->cpu);
 
-	/*
-	 * We're safe from concurrent calls to ->target() here
-	 * as we hold the userspace_mutex lock. If we were calling
-	 * cpufreq_driver_target, a deadlock situation might occur:
-	 * A: cpufreq_set (lock userspace_mutex) ->
-	 *      cpufreq_driver_target(lock policy->lock)
-	 * B: cpufreq_set_policy(lock policy->lock) ->
-	 *      __cpufreq_governor ->
-	 *         cpufreq_governor_userspace (lock userspace_mutex)
-	 */
+	/* The cpufreq framework holds the lock before calling this op. */
 	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
 
  err:
-- 
1.7.8.3

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
