From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Simplify cpufreq_can_do_remote_dvfs()
Date: Fri, 04 Aug 2017 14:57:39 +0200
Message-ID: <1957547.1DvPFJ11E3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53917 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752151AbdHDNFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 09:05:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The if () in cpufreq_can_do_remote_dvfs() is superfluous, so drop
it and simply return the value of the expression under it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the current linux-next.

---
 include/linux/cpufreq.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -578,11 +578,8 @@ static inline bool cpufreq_can_do_remote
 	 * - dvfs_possible_from_any_cpu flag is set
 	 * - the local and remote CPUs share cpufreq policy
 	 */
-	if (policy->dvfs_possible_from_any_cpu ||
-	    cpumask_test_cpu(smp_processor_id(), policy->cpus))
-		return true;
-
-	return false;
+	return policy->dvfs_possible_from_any_cpu ||
+		cpumask_test_cpu(smp_processor_id(), policy->cpus);
 }
 
 /*********************************************************************
