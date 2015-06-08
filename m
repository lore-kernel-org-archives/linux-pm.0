From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 4/6] cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
Date: Mon,  8 Jun 2015 18:25:30 +0530
Message-ID: <174a053d67dd11bcd7a3ff6ae4226a5b088116d7.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36234 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbbFHM4G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 08:56:06 -0400
Received: by pdjm12 with SMTP id m12so104116182pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 05:56:06 -0700 (PDT)
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
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
index d890804d561f..d3bd85263643 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1203,7 +1203,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
 	unsigned long flags;
 	int cpu;
@@ -1216,6 +1216,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1420,9 +1421,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	cpufreq_policy_put_kobj(policy, recover_policy);
-	cpufreq_policy_free(policy);
-
+	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
 	up_read(&cpufreq_rwsem);
 
@@ -1514,10 +1513,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	/* Free the policy kobjects only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_put_kobj(policy, true);
-
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
@@ -1526,8 +1521,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
+	/* Free the policy only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 
 	return 0;
 }
@@ -1566,8 +1562,7 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 			return 0;
 		}
 
-		cpufreq_policy_put_kobj(policy, true);
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 		return 0;
 	}
 
-- 
2.4.0

