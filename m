From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Replace recover_policy with new_policy in cpufreq_online()
Date: Wed, 29 Jul 2015 03:08:57 +0200
Message-ID: <2952411.gjDWaFdOqs@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <1702607.RH80fBCN6J@vostro.rjw.lan> <3091538.g8dYBumqSx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64657 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751246AbbG2AmB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 20:42:01 -0400
In-Reply-To: <3091538.g8dYBumqSx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The recover_policy is unsed in cpufreq_online() to indicate whether
a new policy object is created or an existing one is reinitialized.

The "recover" part of the name is slightly confusing (it should be
"reinitialization" rather than "recovery") and the logical not (!)
operator is applied to it in almost all of the checks it is used in,
so replace that variable with a new one called "new_policy" that
will be true in the case of a new policy creation.

While at it, drop one of the labels that is jumped to from only
one spot.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

One extra cleanup on top of https://patchwork.kernel.org/patch/6888751/

---
 drivers/cpufreq/cpufreq.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1194,7 +1194,7 @@ static void cpufreq_policy_free(struct c
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
-	bool recover_policy;
+	bool new_policy;
 	unsigned long flags;
 	unsigned int j;
 	int ret;
@@ -1209,13 +1209,13 @@ static int cpufreq_online(unsigned int c
 			return cpufreq_add_policy_cpu(policy, cpu);
 
 		/* This is the only online CPU for the policy.  Start over. */
-		recover_policy = true;
+		new_policy = false;
 		down_write(&policy->rwsem);
 		policy->cpu = cpu;
 		policy->governor = NULL;
 		up_write(&policy->rwsem);
 	} else {
-		recover_policy = false;
+		new_policy = true;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
@@ -1234,7 +1234,7 @@ static int cpufreq_online(unsigned int c
 
 	down_write(&policy->rwsem);
 
-	if (!recover_policy) {
+	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 		/* Remember CPUs present at the policy creation time. */
@@ -1247,7 +1247,7 @@ static int cpufreq_online(unsigned int c
 	 */
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
-	if (!recover_policy) {
+	if (new_policy) {
 		policy->user_policy.min = policy->min;
 		policy->user_policy.max = policy->max;
 
@@ -1308,7 +1308,7 @@ static int cpufreq_online(unsigned int c
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				     CPUFREQ_START, policy);
 
-	if (!recover_policy) {
+	if (new_policy) {
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
@@ -1324,10 +1324,12 @@ static int cpufreq_online(unsigned int c
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
 		       __func__, cpu, ret);
-		goto out_remove_policy_notify;
+		/* cpufreq_policy_free() will notify based on this */
+		new_policy = false;
+		goto out_exit_policy;
 	}
 
-	if (!recover_policy) {
+	if (new_policy) {
 		policy->user_policy.policy = policy->policy;
 		policy->user_policy.governor = policy->governor;
 	}
@@ -1343,16 +1345,13 @@ static int cpufreq_online(unsigned int c
 
 	return 0;
 
-out_remove_policy_notify:
-	/* cpufreq_policy_free() will notify based on this */
-	recover_policy = true;
 out_exit_policy:
 	up_write(&policy->rwsem);
 
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 out_free_policy:
-	cpufreq_policy_free(policy, recover_policy);
+	cpufreq_policy_free(policy, !new_policy);
 	return ret;
 }
 

