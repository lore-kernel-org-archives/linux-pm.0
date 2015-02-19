From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/20] cpufreq: Don't traverse list of all policies for adding policy for a cpu
Date: Thu, 19 Feb 2015 17:02:12 +0530
Message-ID: <3311b25e3e3f698ad654215d7bf9a1c3613b7d78.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32773 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbBSLeB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:01 -0500
Received: by pabkx10 with SMTP id kx10so8914208pab.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:00 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We reach here while adding policy for a CPU and enter into the 'if' block only
if a policy already exists for the CPU in question. As cpufreq_cpu_data is
filled once and for all now, we can reuse it to find the relevant policy instead
of traversing the list of all policies.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f849b2a33d3e..20d5f4590c4b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1211,7 +1211,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
-	struct cpufreq_policy *policy, *tpolicy;
+	struct cpufreq_policy *policy;
 	unsigned long flags;
 	bool recover_policy = cpufreq_suspended;
 
@@ -1224,16 +1224,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		return 0;
 
 	/* Check if this cpu already has a policy to manage it */
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_active_policy(policy, tpolicy) {
-		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
-			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
-			up_read(&cpufreq_rwsem);
-			return ret;
-		}
+	policy = per_cpu(cpufreq_cpu_data, cpu);
+	if (policy && !policy_is_inactive(policy)) {
+		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
+		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
+		up_read(&cpufreq_rwsem);
+		return ret;
 	}
-	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	/*
 	 * Restore the saved policy when doing light-weight init and fall back
-- 
2.3.0.rc0.44.ga94655d

