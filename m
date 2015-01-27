From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/18] cpufreq: Remove cpufreq_update_policy()
Date: Tue, 27 Jan 2015 14:06:20 +0530
Message-ID: <aa18ca4088734878e7cfc07eb0c984317b367512.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59863 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924AbbA0Ihe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:34 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so17615629pdj.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:33 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() was kept as a separate routine earlier as it was
handling migration of sysfs directories, which isn't done anymore. It is only
updating policy->cpu now and can be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8b110a50c22e..fde0a75f9692 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1058,6 +1058,12 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	if (policy) {
+		down_write(&policy->rwsem);
+		policy->cpu = cpu;
+		up_write(&policy->rwsem);
+	}
+
 	return policy;
 }
 
@@ -1130,16 +1136,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
 static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id;
@@ -1185,15 +1181,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
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
@@ -1401,11 +1388,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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

