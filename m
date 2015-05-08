From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 12/14] cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
Date: Fri,  8 May 2015 11:53:55 +0530
Message-ID: <43a0644d3ac3b03bebf59d2c46f25543ce0e03f2.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33732 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbEHGZS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:25:18 -0400
Received: by pdbnk13 with SMTP id nk13so66966989pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:25:18 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_policy_put_kobj() is actually part of freeing the policy and can
be called from cpufreq_policy_free() directly instead of a separate
call.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e7f16c4bd041..6f08b70de21f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1198,7 +1198,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
 	unsigned long flags;
 	int cpu;
@@ -1211,6 +1211,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1384,9 +1385,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	cpufreq_policy_put_kobj(policy, recover_policy);
-	cpufreq_policy_free(policy);
-
+	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
 	up_read(&cpufreq_rwsem);
 
@@ -1481,10 +1480,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	/* Free the policy kobjects only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_put_kobj(policy, true);
-
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
@@ -1493,8 +1488,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
+	/* Free the policy only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 
 	return 0;
 }
-- 
2.4.0

