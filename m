From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 04/14] cpufreq: Don't traverse all active policies to find policy for a cpu
Date: Fri,  8 May 2015 11:53:47 +0530
Message-ID: <91b416f7a706ae0cbb5f90168988326793e05001.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34176 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbEHGYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:24:49 -0400
Received: by pdbqa5 with SMTP id qa5so66447614pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:24:49 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

We reach here while adding policy for a CPU and enter into the 'if'
block only if a policy already exists for the CPU.

As cpufreq_cpu_data is set for all policy->related_cpus now, when the
policy is first added, we can use that to find the CPU's policy instead
of traversing the list of all active policies.

Acked-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b60311fe207f..a3eb76969969 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1212,7 +1212,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
-	struct cpufreq_policy *policy, *tpolicy;
+	struct cpufreq_policy *policy;
 	unsigned long flags;
 	bool recover_policy = cpufreq_suspended;
 
@@ -1225,16 +1225,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		return 0;
 
 	/* Check if this CPU already has a policy to manage it */
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
2.4.0

