From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Thu, 16 Mar 2017 23:42:23 +0100
Message-ID: <2084010.4xkKok06Gp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62849 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750899AbdCPWyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 18:54:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On CPU online the cpufreq core restores the previous governor (or
the previous "policy" setting for ->setpolicy drivers), but it does
not restore the min/max limits at the same time, which is confusing,
inconsistent and real pain for users who set the limits and then
suspend/resume the system (using full suspend), in which case the
limits are reset on all CPUs except for the boot one.

Fix this by making cpufreq_init_policy() restore the limits when it
sees that this is CPU online and not initialization from scratch.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -979,6 +979,8 @@ static int cpufreq_init_policy(struct cp
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
 	if (gov) {
+		new_policy.min = policy->user_policy.min;
+		new_policy.max = policy->user_policy.max;
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
 	} else {
@@ -991,11 +993,14 @@ static int cpufreq_init_policy(struct cp
 
 	/* Use the default policy if there is no last_policy. */
 	if (cpufreq_driver->setpolicy) {
-		if (policy->last_policy)
+		if (policy->last_policy) {
 			new_policy.policy = policy->last_policy;
-		else
+			new_policy.min = policy->user_policy.min;
+			new_policy.max = policy->user_policy.max;
+		} else {
 			cpufreq_parse_governor(gov->name, &new_policy.policy,
 					       NULL);
+		}
 	}
 	/* set default policy */
 	return cpufreq_set_policy(policy, &new_policy);
