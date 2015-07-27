From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/7] cpufreq: Drop cpufreq_policy_restore()
Date: Mon, 27 Jul 2015 16:03:47 +0200
Message-ID: <1831805.k1h8RcvUky@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <3874727.Jpay9zgokc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47091 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750803AbbG0Nm7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 09:42:59 -0400
In-Reply-To: <3874727.Jpay9zgokc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that when cpufreq_policy_restore() is called, its per-CPU
cpufreq_cpu_data variable has been already dereferenced and if that
variable is not NULL, the policy local pointer in cpufreq_add_dev()
contains its value.

Therefore it is not necessary to dereference it again and the
policy pointer can be used directly.  Moreover, if that pointer
is not NULL, the policy is inactive (or the previous check would
have made us return from cpufreq_add_dev()) so the restoration
code from cpufreq_policy_restore() can be moved to that point
in cpufreq_add_dev().

Do that and drop cpufreq_policy_restore().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   44 +++++++++++---------------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1092,28 +1092,6 @@ static int cpufreq_add_policy_cpu(struct
 	return 0;
 }
 
-static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-	unsigned long flags;
-
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	policy = per_cpu(cpufreq_cpu_data, cpu);
-	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
-	if (likely(policy)) {
-		/* Policy should be inactive here */
-		WARN_ON(!policy_is_inactive(policy));
-
-		down_write(&policy->rwsem);
-		policy->cpu = cpu;
-		policy->governor = NULL;
-		up_write(&policy->rwsem);
-	}
-
-	return policy;
-}
-
 static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 {
 	struct cpufreq_policy *policy;
@@ -1226,7 +1204,7 @@ static int cpufreq_add_dev(struct device
 	int ret = -ENOMEM;
 	struct cpufreq_policy *policy;
 	unsigned long flags;
-	bool recover_policy = !sif;
+	bool recover_policy;
 
 	pr_debug("adding CPU %u\n", cpu);
 
@@ -1244,18 +1222,18 @@ static int cpufreq_add_dev(struct device
 
 	/* Check if this CPU already has a policy to manage it */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (policy && !policy_is_inactive(policy)) {
+	if (policy) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
-		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
-		return ret;
-	}
+		if (!policy_is_inactive(policy))
+			return cpufreq_add_policy_cpu(policy, cpu, dev);
 
-	/*
-	 * Restore the saved policy when doing light-weight init and fall back
-	 * to the full init if that fails.
-	 */
-	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
-	if (!policy) {
+		/* This is the only online CPU for the policy.  Start over. */
+		recover_policy = true;
+		down_write(&policy->rwsem);
+		policy->cpu = cpu;
+		policy->governor = NULL;
+		up_write(&policy->rwsem);
+	} else {
 		recover_policy = false;
 		policy = cpufreq_policy_alloc(dev);
 		if (!policy)

