From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 03/14] cpufreq: Get rid of cpufreq_cpu_data_fallback
Date: Mon, 18 May 2015 10:43:26 +0530
Message-ID: <b3417bcfbb2428dc26a7a106ee26e872cd59dbee.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36261 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbERFOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:01 -0400
Received: by pdfh10 with SMTP id h10so133400077pdf.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:01 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
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
index e899a5446d0e..eb0c3a802b14 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -101,7 +101,6 @@ static LIST_HEAD(cpufreq_governor_list);
  */
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
-static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 DEFINE_MUTEX(cpufreq_governor_lock);
 
@@ -1081,13 +1080,14 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
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
@@ -1383,11 +1383,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -1401,21 +1398,11 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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

