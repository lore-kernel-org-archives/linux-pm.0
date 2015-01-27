From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 17/18] cpufreq: Restart governor as soon as possible
Date: Tue, 27 Jan 2015 14:06:23 +0530
Message-ID: <529898a0821ded6de14eb31c457d2f441382e9f5.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45284 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922AbbA0Iho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:44 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so17538050pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:44 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

On cpu hot-unplug, we don't need to wait for POST_DEAD notification to restart
the governor if the policy has atleast one online cpu left. We can restart the
governor right from the DOWN_PREPARE notification instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 59 +++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e03ae1bc96a..bcc042a6221a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1338,7 +1338,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id, cpus;
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct cpufreq_policy *policy;
 
@@ -1379,25 +1379,35 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 				CPUFREQ_NAME_LEN);
 	}
 
-	if (cpu != policy->cpu)
-		return 0;
-
 	if (cpus > 1) {
-		/* Nominate new CPU */
 		down_write(&policy->rwsem);
-		policy->cpu = cpumask_any_but(policy->cpus, cpu);
+		cpumask_clear_cpu(cpu, policy->cpus);
+
+		/* Nominate new CPU */
+		if (cpu == policy->cpu)
+			policy->cpu = cpumask_any(policy->cpus);
 		up_write(&policy->rwsem);
+
+		if (has_target()) {
+			/* Start governor again */
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			if (!ret)
+				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+
+			if (ret)
+				pr_err("%s: Failed to start governor\n", __func__);
+		}
 	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int __cpufreq_remove_dev_finish(struct device *dev,
 				       struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id, cpus;
+	unsigned int cpu = dev->id;
 	int ret;
 	unsigned long flags;
 	struct cpufreq_policy *policy;
@@ -1406,34 +1416,13 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	policy = cpufreq_cpu_get_raw(cpu);
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (!policy) {
-		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
-	}
-
-	down_write(&policy->rwsem);
-	cpus = cpumask_weight(policy->cpus);
-
-	if (cpus > 1)
-		cpumask_clear_cpu(cpu, policy->cpus);
-	up_write(&policy->rwsem);
-
-	/* Not the last cpu of policy, start governor again ? */
-	if (cpus > 1) {
-		if (!has_target())
-			return 0;
-
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
-		if (!ret)
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
-
-		if (ret) {
-			pr_err("%s: Failed to start governor\n", __func__);
-			return ret;
-		}
-
+	/*
+	 * If this isn't the last cpu of policy, we will fail to get policy here
+	 * as the cpumask in policy->cpus is already cleared. Hence we don't
+	 * need to proceed here anymore
+	 */
+	if (!policy)
 		return 0;
-	}
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-- 
2.3.0.rc0.44.ga94655d

