From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 16/20] cpufreq: Remove cpufreq_update_policy()
Date: Thu, 19 Feb 2015 17:02:18 +0530
Message-ID: <ae3e163724f0399ed4f41a396a21399f7f5161cf.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36841 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbbBSLe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:26 -0500
Received: by pabkq14 with SMTP id kq14so8893002pab.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:25 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() was kept as a separate routine earlier as it was
handling migration of sysfs directories, which isn't done anymore. It is only
updating policy->cpu now and can be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 29cb952960fa..814a8c70e2b1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1116,6 +1116,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	if (likely(policy)) {
 		/* Policy should be inactive here */
 		WARN_ON(!policy_is_inactive(policy));
+
+		down_write(&policy->rwsem);
+		policy->cpu = cpu;
+		up_write(&policy->rwsem);
 	}
 
 	return policy;
@@ -1200,16 +1204,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
@@ -1256,15 +1250,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -1445,11 +1430,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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
2.3.0.rc0.44.ga94655d

