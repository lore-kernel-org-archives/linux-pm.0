From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 05/14] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Mon, 18 May 2015 10:43:28 +0530
Message-ID: <ac40cca6f5a60141e386e0b588402680987e3de1.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34823 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbERFOJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:09 -0400
Received: by pdea3 with SMTP id a3so132290506pde.2
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:09 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

History of which governor was used last is common to all CPUs within a
policy and maintaining it per-cpu isn't the best approach for sure.

Apart from wasting memory, this also increases the complexity of
managing this data structure as it has to be updated for all CPUs.

To make that somewhat simpler, lets store this information in a new
field 'last_governor' in struct cpufreq_policy and update it on removal
of last cpu of a policy.

As a side-effect it also solves an old problem, consider a system with
two clusters 0 & 1. And there is one policy per cluster.

Cluster 0: CPU0 and 1.
Cluster 1: CPU2 and 3.

- CPU2 is first brought online, and governor is set to performance
  (default as cpufreq_cpu_governor wasn't set).
- Governor is changed to ondemand.
- CPU2 is taken offline and cpufreq_cpu_governor is updated for CPU2.
- CPU3 is brought online.
- Because cpufreq_cpu_governor wasn't set for CPU3, the default governor
  performance is picked for CPU3.

This patch fixes the bug as we now have a single variable to update for
policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 30 +++++++++++++++---------------
 include/linux/cpufreq.h   |  1 +
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e6a63d6ba6f1..16275ba6428e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -104,9 +104,6 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
 
-/* This one keeps track of the previously set governor of a removed CPU */
-static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -1017,7 +1014,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	memcpy(&new_policy, policy, sizeof(*policy));
 
 	/* Update governor of new_policy to the governor used before hotplug */
-	gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
+	gov = find_governor(policy->last_governor);
 	if (gov)
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
@@ -1411,14 +1408,15 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			pr_err("%s: Failed to stop governor\n", __func__);
 			return ret;
 		}
-
-		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
-			policy->governor->name, CPUFREQ_NAME_LEN);
 	}
 
-	down_read(&policy->rwsem);
+	down_write(&policy->rwsem);
 	cpus = cpumask_weight(policy->cpus);
-	up_read(&policy->rwsem);
+
+	if (has_target() && cpus == 1)
+		strncpy(policy->last_governor, policy->governor->name,
+			CPUFREQ_NAME_LEN);
+	up_write(&policy->rwsem);
 
 	if (cpu != policy->cpu) {
 		sysfs_remove_link(&dev->kobj, "cpufreq");
@@ -2135,7 +2133,8 @@ EXPORT_SYMBOL_GPL(cpufreq_register_governor);
 
 void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 {
-	int cpu;
+	struct cpufreq_policy *policy;
+	unsigned long flags;
 
 	if (!governor)
 		return;
@@ -2143,12 +2142,13 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 	if (cpufreq_disabled())
 		return;
 
-	for_each_present_cpu(cpu) {
-		if (cpu_online(cpu))
-			continue;
-		if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu), governor->name))
-			strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
+	/* clear last_governor for all inactive policies */
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
+	for_each_inactive_policy(policy) {
+		if (!strcmp(policy->last_governor, governor->name))
+			strcpy(policy->last_governor, "\0");
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888c1f47..48e37c07eb84 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,6 +80,7 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	bool			governor_enabled; /* governor start/stop flag */
+	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
-- 
2.4.0

