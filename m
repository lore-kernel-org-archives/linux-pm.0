From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 18/20] cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
Date: Thu, 19 Feb 2015 17:02:20 +0530
Message-ID: <65c0b236942cb4710e0dbdff3efef906b9625f08.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40409 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbBSLee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:34 -0500
Received: by paceu11 with SMTP id eu11so8850036pac.7
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:33 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_policy_put_kobj() is actually part of freeing the policy and can be
called from cpufreq_policy_free() directly instead of a separate call.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4fb5041ebfab..b6d5d94a0d3b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1197,7 +1197,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
 	unsigned long flags;
 	int cpu;
@@ -1210,6 +1210,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1383,9 +1384,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	cpufreq_policy_put_kobj(policy, recover_policy);
-	cpufreq_policy_free(policy);
-
+	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
 	up_read(&cpufreq_rwsem);
 
@@ -1480,10 +1479,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	/* Free the policy kobjects only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_put_kobj(policy, true);
-
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
@@ -1492,8 +1487,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
+	/* Free the policy only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 	else
 		policy->governor = NULL;
 
-- 
2.3.0.rc0.44.ga94655d

