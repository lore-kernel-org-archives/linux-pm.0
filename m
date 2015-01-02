From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/17] cpufreq: get rid of 'tpolicy' from __cpufreq_add_dev()
Date: Fri,  2 Jan 2015 12:34:32 +0530
Message-ID: <066845a4d739d35139621837574e88db6272c907.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41857 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so23691250pab.33
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:36 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There is no need of this separate variable, use 'policy' instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3893c87739d1..3061a5823e3c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1098,7 +1098,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
-	struct cpufreq_policy *policy, *tpolicy;
+	struct cpufreq_policy *policy;
 	unsigned long flags;
 	bool recover_policy = cpufreq_suspended;
 
@@ -1120,10 +1120,10 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	/* Check if this cpu was hot-unplugged earlier and has siblings */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list) {
-		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
+	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
+		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-			ret = cpufreq_add_policy_cpu(tpolicy, cpu, dev);
+			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
 			up_read(&cpufreq_rwsem);
 			return ret;
 		}
-- 
2.2.0

