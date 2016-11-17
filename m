From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Avoid using inactive policies
Date: Thu, 17 Nov 2016 16:08:25 +0100
Message-ID: <2600582.kqN5q7nCq0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45490 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbcKQRr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 12:47:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two places in the cpufreq core in which low-level driver
callbacks may be invoked for an inactive cpufreq policy, which isn't
guaranteed to work in general.  Both are due to possible races with
CPU offline.

First, in cpufreq_get(), the policy may become inactive after
the check against policy->cpus in cpufreq_cpu_get() and before
policy->rwsem is acquired, in which case using the policy going
forward may not be correct.

Second, an analogous situation is possible in cpufreq_update_policy().

Avoid using inactive policies by adding policy_is_inactive() checks
to the code in the above places.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1526,7 +1526,10 @@ unsigned int cpufreq_get(unsigned int cp
 
 	if (policy) {
 		down_read(&policy->rwsem);
-		ret_freq = __cpufreq_get(policy);
+
+		if (!policy_is_inactive(policy))
+			ret_freq = __cpufreq_get(policy);
+
 		up_read(&policy->rwsem);
 
 		cpufreq_cpu_put(policy);
@@ -2265,6 +2268,9 @@ int cpufreq_update_policy(unsigned int c
 
 	down_write(&policy->rwsem);
 
+	if (policy_is_inactive(policy))
+		goto unlock;
+
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
 	new_policy.min = policy->user_policy.min;

