From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/18] cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
Date: Tue, 27 Jan 2015 14:06:22 +0530
Message-ID: <ae271775e524be0be8a2bc887deed71a7fabc78f.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54017 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922AbbA0Ihl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:41 -0500
Received: by mail-pd0-f175.google.com with SMTP id fl12so17606074pdb.6
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:41 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Both cpufreq_policy_put_kobj() and cpufreq_policy_free() are always called
together, cpufreq_policy_put_kobj() followed by cpufreq_policy_free().

cpufreq_policy_put_kobj() is actually part of freeing policy and so can be
called from cpufreq_policy_free().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4a97d7428d25..0e03ae1bc96a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1140,8 +1140,9 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1312,9 +1313,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	cpufreq_policy_put_kobj(policy, recover_policy);
-	cpufreq_policy_free(policy);
-
+	cpufreq_policy_free(policy, recover_policy);
 nomem_out:
 	up_read(&cpufreq_rwsem);
 
@@ -1445,10 +1444,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	/* Free the policy kobjects only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_put_kobj(policy, true);
-
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
@@ -1462,8 +1457,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	list_del(&policy->policy_list);
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	/* Free the policy only if the driver is getting removed. */
 	if (sif)
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 	else
 		policy->governor = NULL;
 
-- 
2.3.0.rc0.44.ga94655d

