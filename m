From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: Restore policy min/max limits on CPU online
Date: Fri, 17 Mar 2017 18:44:27 +0100
Message-ID: <2046616.ZgG7lPIpjH@aspire.rjw.lan>
References: <2084010.4xkKok06Gp@aspire.rjw.lan> <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com> <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43567 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751187AbdCQRve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 13:51:34 -0400
In-Reply-To: <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Restore policy min/max limits on CPU online

On CPU online the cpufreq core restores the previous governor (or
the previous "policy" setting for ->setpolicy drivers), but it does
not restore the min/max limits at the same time, which is confusing,
inconsistent and real pain for users who set the limits and then
suspend/resume the system (using full suspend), in which case the
limits are reset for all CPUs except for the boot one (on systems
with one CPU per policy, which means the vast majority of laptops,
for example).

Fix this by making cpufreq_online() restore the limits when it
sees that this is CPU online and not initialization from scratch.

Also move the governor restoration code to the place where the limits
are restored for consistency.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Here it goes for completeness:

-> v2: Avoid code duplication by adding a helper function for copying values.

---
 drivers/cpufreq/cpufreq.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -969,6 +969,13 @@ __weak struct cpufreq_governor *cpufreq_
 	return NULL;
 }
 
+static void policy_copy_user_min_max(struct cpufreq_policy *to,
+				     struct cpufreq_policy *from)
+{
+	to->min = from->user_policy.min;
+	to->max = from->user_policy.max;
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -979,6 +986,7 @@ static int cpufreq_init_policy(struct cp
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
 	if (gov) {
+		policy_copy_user_min_max(&new_policy, policy);
 		pr_debug("Restoring governor %s for cpu %d\n",
 				policy->governor->name, policy->cpu);
 	} else {
@@ -991,11 +999,13 @@ static int cpufreq_init_policy(struct cp
 
 	/* Use the default policy if there is no last_policy. */
 	if (cpufreq_driver->setpolicy) {
-		if (policy->last_policy)
+		if (policy->last_policy) {
 			new_policy.policy = policy->last_policy;
-		else
+			policy_copy_user_min_max(&new_policy, policy);
+		} else {
 			cpufreq_parse_governor(gov->name, &new_policy.policy,
 					       NULL);
+		}
 	}
 	/* set default policy */
 	return cpufreq_set_policy(policy, &new_policy);
@@ -2263,8 +2273,7 @@ void cpufreq_update_policy(unsigned int
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
+	policy_copy_user_min_max(&new_policy, policy);
 
 	/*
 	 * BIOS might change freq behind our back
