From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: remove policy from cpufreq_policy_list in system suspend
Date: Tue, 20 Aug 2013 12:08:23 +0530
Message-ID: <e49dd43e4c09592d818ba8c5fc252df60607d0db.1376979090.git.viresh.kumar@linaro.org>
References: <cover.1376979090.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35114 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3HTGkF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 02:40:05 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so26929pdi.14
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2013 23:40:05 -0700 (PDT)
In-Reply-To: <cover.1376979090.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376979090.git.viresh.kumar@linaro.org>
References: <cover.1376979090.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_policy_list is a list of active policies. We do remove policies from
this list when all CPUs belonging to that policy are removed. But during suspend
we don't really free a policy struct as it will be used again during resume. And
so we didn't remove it from cpufreq_policy_list as well..

This is incorrect. We are saying this policy isn't valid anymore and must not be
referenced (though we haven't freed it), but it can still be used by code that
iterates over cpufreq_policy_list.

Lets remove policy from this list even in case of suspend as well.. Similarly we
must add it back whenever the first cpu belonging to that policy turns up.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fedc842..0302121 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -950,12 +950,6 @@ err_free_policy:
 
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	list_del(&policy->policy_list);
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1069,12 +1063,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		ret = cpufreq_add_dev_interface(policy, dev);
 		if (ret)
 			goto err_out_unregister;
-
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		list_add(&policy->policy_list, &cpufreq_policy_list);
-		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
 
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	list_add(&policy->policy_list, &cpufreq_policy_list);
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 	cpufreq_init_policy(policy);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
@@ -1280,6 +1274,11 @@ static int __cpufreq_remove_dev(struct device *dev,
 		if (cpufreq_driver->exit)
 			cpufreq_driver->exit(policy);
 
+		/* Remove policy from list of active policies */
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		list_del(&policy->policy_list);
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 		if (!frozen)
 			cpufreq_policy_free(policy);
 	} else {
-- 
1.7.12.rc2.18.g61b472e

