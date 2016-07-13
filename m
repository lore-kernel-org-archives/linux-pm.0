From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Wed, 13 Jul 2016 13:25:25 -0700
Message-ID: <1468441527-23534-2-git-send-email-smuckle@linaro.org>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34295 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbcGMUZr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 16:25:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id fi15so20808038pac.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2016 13:25:46 -0700 (PDT)
In-Reply-To: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

Cpufreq governors may need to know what a particular target frequency
maps to in the driver without necessarily wanting to set the frequency.
Support this operation via a new cpufreq API,
cpufreq_driver_resolve_freq(). This API returns the lowest driver
frequency equal or greater than the target frequency
(CPUFREQ_RELATION_L), subject to any policy (min/max) or driver
limitations. The mapping is also cached in the policy so that a
subsequent fast_switch operation can avoid repeating the same lookup.

The API will call a new cpufreq driver callback, resolve_freq(), if it
has been registered by the driver. Otherwise the frequency is resolved
via cpufreq_frequency_table_target(). Rather than require ->target()
style drivers to provide a resolve_freq() callback it is left to the
caller to ensure that the driver implements this callback if necessary
to use cpufreq_driver_resolve_freq().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 25 +++++++++++++++++++++++++
 include/linux/cpufreq.h   | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 118b4f30a406..b696baeb249d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -492,6 +492,29 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
+/**
+ * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
+ * one.
+ * @target_freq: target frequency to resolve.
+ *
+ * The target to driver frequency mapping is cached in the policy.
+ *
+ * Return: Lowest driver-supported frequency greater than or equal to the
+ * given target_freq, subject to policy (min/max) and driver limitations.
+ */
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq)
+{
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	policy->cached_target_freq = target_freq;
+	if (cpufreq_driver->resolve_freq)
+		return cpufreq_driver->resolve_freq(policy, target_freq);
+	policy->cached_resolved_idx =
+		cpufreq_frequency_table_target(policy, target_freq,
+					       CPUFREQ_RELATION_L);
+	return policy->freq_table[policy->cached_resolved_idx].frequency;
+}
+
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
@@ -2199,6 +2222,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
 
+	policy->cached_target_freq = UINT_MAX;
+
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c6410b1b2490..631ba33bbe9f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -120,6 +120,10 @@ struct cpufreq_policy {
 	bool			fast_switch_possible;
 	bool			fast_switch_enabled;
 
+	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
+	unsigned int cached_target_freq;
+	int cached_resolved_idx;
+
 	/* Synchronization for frequency transitions */
 	bool			transition_ongoing; /* Tracks transition status */
 	spinlock_t		transition_lock;
@@ -270,6 +274,16 @@ struct cpufreq_driver {
 					unsigned int index);
 	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
 				       unsigned int target_freq);
+
+	/*
+	 * Caches and returns the lowest driver-supported frequency greater than
+	 * or equal to the target frequency, subject to any driver limitations.
+	 * Does not set the frequency. Only to be implemented for drivers with
+	 * target().
+	 */
+	unsigned int	(*resolve_freq)(struct cpufreq_policy *policy,
+					unsigned int target_freq);
+
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -501,6 +515,8 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation);
+unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
+					 unsigned int target_freq);
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
-- 
2.7.3

