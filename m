From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 04/14] cpufreq: Don't traverse all active policies to find policy for a cpu
Date: Mon, 18 May 2015 10:43:27 +0530
Message-ID: <c6b7734ae84c4ff562ad662316a28fe49341516d.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33081 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbERFOF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:05 -0400
Received: by padbw4 with SMTP id bw4so136044311pad.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:05 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index eb0c3a802b14..e6a63d6ba6f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1213,16 +1213,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		return 0;
 
 	/* Check if this CPU already has a policy to manage it */
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_active_policy(policy) {
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

