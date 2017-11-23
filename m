From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/4] cpufreq: Fix governor module removal race
Date: Thu, 23 Nov 2017 14:27:07 +0100
Message-ID: <16997374.L1f6Qxgytn@aspire.rjw.lan>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan> <2007526.uAUpsoPmOG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64801 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752683AbdKWN1a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Nov 2017 08:27:30 -0500
In-Reply-To: <2007526.uAUpsoPmOG@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is possible to remove a cpufreq governor module after
cpufreq_parse_governor() has returned success in
store_scaling_governor() and before cpufreq_set_policy()
acquires a reference to it, because the governor list is
not protected during that period and nothing prevents the
governor from being unregistered then.

Prevent that from happening by acquiring an extra reference
to the governor module temporarily in cpufreq_parse_governor(),
under cpufreq_governor_mutex, and dropping it in
store_scaling_governor(), when cpufreq_set_policy() returns.

Note that the second cpufreq_parse_governor() call site is fine,
because it only cares about the policy member of new_policy.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Drop changes to clear policy->governor in
       cpufreq_parse_governor() in the cpufreq_driver->setpolicy set
       case, as that field should always be NULL then.

---
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -633,6 +633,8 @@ static int cpufreq_parse_governor(char *
 
 			t = find_governor(str_governor);
 		}
+		if (t && !try_module_get(t->owner))
+			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 
@@ -766,6 +768,10 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
 
