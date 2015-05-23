From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: (unknown)
Date: Sat, 23 May 2015 09:15:53 +0530
Message-ID: <59ebb79018c6a4d86623614fe3e44a6de8592c6c.1431924457.git.viresh.kumar@linaro.org>
References: <93a0104d11e5f75825672f0c59b8eec76c72d0e0.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34542 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbbEWDqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 23:46:04 -0400
Received: by pdbnk13 with SMTP id nk13so32961815pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2015 20:46:04 -0700 (PDT)
Subject: 
In-Reply-To: <93a0104d11e5f75825672f0c59b8eec76c72d0e0.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Subject: [PATCH V6 10/14] cpufreq: Remove cpufreq_update_policy()

cpufreq_update_policy() was kept as a separate routine earlier as it was
handling migration of sysfs directories, which isn't done anymore. It is
only updating policy->cpu now and can be removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V5->V6:
- Merged v4 9/14, into this one after some updates.
- Keep separate routines to add/remove symlinks.

 drivers/cpufreq/cpufreq.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 663a934259a4..a791fe6920dc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1126,6 +1126,10 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	if (likely(policy)) {
 		/* Policy should be inactive here */
 		WARN_ON(!policy_is_inactive(policy));
+
+		down_write(&policy->rwsem);
+		policy->cpu = cpu;
+		up_write(&policy->rwsem);
 	}
 
 	return policy;
@@ -1210,16 +1214,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
@@ -1278,15 +1272,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -1467,11 +1452,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
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

