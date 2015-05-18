From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 11/14] cpufreq: Remove cpufreq_update_policy()
Date: Mon, 18 May 2015 10:43:34 +0530
Message-ID: <c9e5903f0ae25290ceed414d610cef8287dab319.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32979 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbERFOc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:32 -0400
Received: by padbw4 with SMTP id bw4so136059384pad.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:32 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() was kept as a separate routine earlier as it was
handling migration of sysfs directories, which isn't done anymore. It is
only updating policy->cpu now and can be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b07a3387f2bc..a16dd26b39f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1108,6 +1108,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	if (likely(policy)) {
 		/* Policy should be inactive here */
 		WARN_ON(!policy_is_inactive(policy));
+
+		down_write(&policy->rwsem);
+		policy->cpu = cpu;
+		up_write(&policy->rwsem);
 	}
 
 	return policy;
@@ -1192,16 +1196,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
-static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
-{
-	if (WARN_ON(cpu == policy->cpu))
-		return;
-
-	down_write(&policy->rwsem);
-	policy->cpu = cpu;
-	up_write(&policy->rwsem);
-}
-
 /**
  * cpufreq_add_dev - add a CPU device
  *
@@ -1260,15 +1254,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 			goto nomem_out;
 	}
 
-	/*
-	 * In the resume path, since we restore a saved policy, the assignment
-	 * to policy->cpu is like an update of the existing policy, rather than
-	 * the creation of a brand new one. So we need to perform this update
-	 * by invoking update_policy_cpu().
-	 */
-	if (recover_policy && cpu != policy->cpu)
-		update_policy_cpu(policy, cpu);
-
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
 	/* call driver. From then on the cpufreq must be able
@@ -1449,11 +1434,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	if (cpu != policy->cpu)
 		return 0;
 
-	if (cpus > 1)
+	if (cpus > 1) {
 		/* Nominate new CPU */
-		update_policy_cpu(policy, cpumask_any_but(policy->cpus, cpu));
-	else if (cpufreq_driver->stop_cpu)
+		down_write(&policy->rwsem);
+		policy->cpu = cpumask_any_but(policy->cpus, cpu);
+		up_write(&policy->rwsem);
+	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
+	}
 
 	return 0;
 }
-- 
2.4.0

