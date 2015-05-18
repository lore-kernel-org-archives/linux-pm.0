From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 13/14] cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
Date: Mon, 18 May 2015 10:43:36 +0530
Message-ID: <9203cdc11b5d3bb62c6a01d12f75cf92bc6a0f00.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34584 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbERFOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:40 -0400
Received: by pabru16 with SMTP id ru16so136140004pab.1
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:40 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_policy_put_kobj() is actually part of freeing the policy and can
be called from cpufreq_policy_free() directly instead of a separate
call.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1137e7942278..b030432cbfad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1189,7 +1189,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
 	unsigned long flags;
 	int cpu;
@@ -1202,6 +1202,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1387,9 +1388,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	cpufreq_policy_put_kobj(policy, recover_policy);
-	cpufreq_policy_free(policy);
-
+	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
 	up_read(&cpufreq_rwsem);
 
@@ -1484,10 +1483,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	/* Free the policy kobjects only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_put_kobj(policy, true);
-
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
@@ -1496,8 +1491,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
+	/* Free the policy only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 
 	return 0;
 }
@@ -1534,8 +1530,7 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		if (cpumask_intersects(&mask, cpu_present_mask))
 			return add_remove_cpu_dev_symlink(policy, cpu, false);
 
-		cpufreq_policy_put_kobj(policy, true);
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 		return 0;
 	}
 
-- 
2.4.0

