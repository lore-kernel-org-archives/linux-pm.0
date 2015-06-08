From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 6/6] cpufreq: Remove cpufreq_update_policy()
Date: Mon,  8 Jun 2015 18:25:32 +0530
Message-ID: <c38fe1849e277bb4c6c8b3c618cfc3a226b595f3.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35606 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbFHM4P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 08:56:15 -0400
Received: by pdbnf5 with SMTP id nf5so104432316pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 05:56:14 -0700 (PDT)
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_update_policy() was kept as a separate routine earlier as it was
handling migration of sysfs directories, which isn't the case anymore.
It is only updating policy->cpu now and is called by a single caller.

The WARN_ON() isn't really required anymore, as we are just updating the
cpu now, not moving the sysfs directories.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f1c3366fb8e..d0497f379e3a 100644
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
@@ -1222,16 +1226,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
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
@@ -1290,15 +1284,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
-- 
2.4.0

