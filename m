From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/14] cpufreq: Get rid of cpufreq_cpu_data_fallback
Date: Fri,  8 May 2015 11:53:46 +0530
Message-ID: <d19f26a81ac12b9da2b11979c3eb5b0e4d04e0d8.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33518 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbEHGYm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:24:42 -0400
Received: by pdbnk13 with SMTP id nk13so66943805pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:24:42 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

We can extract the same information from cpufreq_cpu_data as it is also
available for inactive policies now. And so don't need
cpufreq_cpu_data_fallback anymore.

Also add a WARN_ON() for the case where we try to restore from an active
policy.

Acked-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c802ded03595..b60311fe207f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -113,7 +113,6 @@ static LIST_HEAD(cpufreq_governor_list);
  */
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
-static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
 
@@ -1093,13 +1092,14 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	unsigned long flags;
 
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-
-	policy = per_cpu(cpufreq_cpu_data_fallback, cpu);
-
+	policy = per_cpu(cpufreq_cpu_data, cpu);
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (policy)
+	if (likely(policy)) {
+		/* Policy should be inactive here */
+		WARN_ON(!policy_is_inactive(policy));
 		policy->governor = NULL;
+	}
 
 	return policy;
 }
@@ -1395,11 +1395,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	if (recover_policy) {
-		/* Do not leave stale fallback data behind. */
-		per_cpu(cpufreq_cpu_data_fallback, cpu) = NULL;
+	if (recover_policy)
 		cpufreq_policy_put_kobj(policy);
-	}
 	cpufreq_policy_free(policy);
 
 nomem_out:
@@ -1413,21 +1410,11 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 {
 	unsigned int cpu = dev->id, cpus;
 	int ret;
-	unsigned long flags;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-
 	policy = cpufreq_cpu_get_raw(cpu);
-
-	/* Save the policy somewhere when doing a light-weight tear-down */
-	if (cpufreq_suspended)
-		per_cpu(cpufreq_cpu_data_fallback, cpu) = policy;
-
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
 		return -EINVAL;
-- 
2.4.0

