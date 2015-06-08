From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 5/6] cpufreq: Restart governor as soon as possible
Date: Mon,  8 Jun 2015 18:25:31 +0530
Message-ID: <5802c619494ba09e5c7621722e5a0778519c6a98.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34878 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbFHM4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 08:56:11 -0400
Received: by pacyx8 with SMTP id yx8so59942654pac.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 05:56:10 -0700 (PDT)
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

On cpu hot-unplug, we don't need to wait for POST_DEAD notification to
restart the governor if the policy has atleast one online cpu left. We
can restart the governor right from the DOWN_PREPARE notification
instead.

[ Something similar attempted by Saravana earlier ]

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 59 +++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d3bd85263643..5f1c3366fb8e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1431,8 +1431,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id, cpus;
-	int ret;
+	unsigned int cpu = dev->id;
+	int ret = 0;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1452,23 +1452,33 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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
 
-	if (cpus > 1)
-		/* Nominate new CPU */
-		update_policy_cpu(policy, cpumask_any_but(policy->cpus, cpu));
-	else if (cpufreq_driver->stop_cpu)
+			if (ret)
+				pr_err("%s: Failed to start governor\n", __func__);
+		}
+	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int __cpufreq_remove_dev_finish(struct device *dev,
@@ -1476,33 +1486,16 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
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
2.4.0

