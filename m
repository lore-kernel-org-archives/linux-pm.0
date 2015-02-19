From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 19/20] cpufreq: Restart governor as soon as possible
Date: Thu, 19 Feb 2015 17:02:21 +0530
Message-ID: <05018c29d0f8802898b096d4d461ef1434b2ae62.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40671 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbBSLeh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:37 -0500
Received: by pdev10 with SMTP id v10so8267285pde.7
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:37 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

On cpu hot-unplug, we don't need to wait for POST_DEAD notification to restart
the governor if the policy has atleast one online cpu left. We can restart the
governor right from the DOWN_PREPARE notification instead.

[ Something similar attempted by Saravana earlier ]

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 58 ++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b6d5d94a0d3b..ffb6700c7195 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1394,8 +1394,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id, cpus;
-	int ret;
+	unsigned int cpu = dev->id;
+	int ret = 0;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1415,26 +1415,33 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	}
 
 	down_write(&policy->rwsem);
-	cpus = cpumask_weight(policy->cpus);
+	cpumask_clear_cpu(cpu, policy->cpus);
 
-	if (has_target() && cpus == 1)
-		strncpy(policy->last_governor, policy->governor->name,
-			CPUFREQ_NAME_LEN);
+	if (policy_is_inactive(policy)) {
+		if (has_target())
+			strncpy(policy->last_governor, policy->governor->name,
+				CPUFREQ_NAME_LEN);
+	} else if (cpu == policy->cpu) {
+		/* Nominate new CPU */
+		policy->cpu = cpumask_any(policy->cpus);
+	}
 	up_write(&policy->rwsem);
 
-	if (cpu != policy->cpu)
-		return 0;
+	/* Start governor again for active policy */
+	if (!policy_is_inactive(policy)) {
+		if (has_target()) {
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			if (!ret)
+				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
-	if (cpus > 1) {
-		/* Nominate new CPU */
-		down_write(&policy->rwsem);
-		policy->cpu = cpumask_any_but(policy->cpus, cpu);
-		up_write(&policy->rwsem);
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
@@ -1442,33 +1449,16 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 {
 	unsigned int cpu = dev->id;
 	int ret;
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
 		return -EINVAL;
 	}
 
-	down_write(&policy->rwsem);
-	cpumask_clear_cpu(cpu, policy->cpus);
-	up_write(&policy->rwsem);
-
-	/* Not the last cpu of policy, start governor again ? */
-	if (!policy_is_inactive(policy)) {
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
+	/* Only proceed for inactive policies */
+	if (!policy_is_inactive(policy))
 		return 0;
-	}
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-- 
2.3.0.rc0.44.ga94655d

