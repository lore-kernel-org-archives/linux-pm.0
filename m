From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/18] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Tue, 27 Jan 2015 14:06:11 +0530
Message-ID: <bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54103 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbA0IhA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:00 -0500
Received: by mail-pd0-f179.google.com with SMTP id v10so17550551pde.10
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:36:59 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

History of which governor was used last is common to all CPUs within a policy
and maintaining it per-cpu isn't the best approach for sure.

Apart from wasting memory, this also increases the complexity of managing this
data structure as it has to be updated for all CPUs.

To make that somewhat simpler, lets store this information in a new field
'last_governor' in struct cpufreq_policy and update it on removal of last cpu of
a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 24 ++++++++++++------------
 include/linux/cpufreq.h   |  1 +
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f253cf45f910..4ad1e46891b5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -57,9 +57,6 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
 
-/* This one keeps track of the previously set governor of a removed CPU */
-static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -941,7 +938,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	memcpy(&new_policy, policy, sizeof(*policy));
 
 	/* Update governor of new_policy to the governor used before hotplug */
-	gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
+	gov = find_governor(policy->last_governor);
 	if (gov)
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
@@ -1366,8 +1363,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			return ret;
 		}
 
-		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
-			policy->governor->name, CPUFREQ_NAME_LEN);
+		if (cpus == 1)
+			strncpy(policy->last_governor, policy->governor->name,
+				CPUFREQ_NAME_LEN);
 	}
 
 	if (cpu != policy->cpu) {
@@ -2096,7 +2094,8 @@ EXPORT_SYMBOL_GPL(cpufreq_register_governor);
 
 void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 {
-	int cpu;
+	struct cpufreq_policy *policy;
+	unsigned long flags;
 
 	if (!governor)
 		return;
@@ -2104,12 +2103,13 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 	if (cpufreq_disabled())
 		return;
 
-	for_each_present_cpu(cpu) {
-		if (cpu_online(cpu))
-			continue;
-		if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu), governor->name))
-			strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
+	/* clear last_governor for all fallback policies */
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
+	for_each_fallback_policy(policy) {
+		if (!strcmp(policy->last_governor, governor->name))
+			strcpy(policy->last_governor, "\0");
 	}
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index df6af4cfa26a..e326cddef6db 100644
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
2.3.0.rc0.44.ga94655d

