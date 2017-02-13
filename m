From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: PATCH] cpufreq: Do not clear real_cpus mask on policy init
Date: Mon, 13 Feb 2017 13:44:57 +0100
Message-ID: <11448597.UpH3K2oSNs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49648 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750903AbdBMMtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 07:49:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If new_policy is set in cpufreq_online(), the policy object has just
been created and its real_cpus mask has been zeroed on allocation,
and the driver's ->init() callback should not touch it.

It doesn't need to be cleared again, so don't do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1166,8 +1166,6 @@ static int cpufreq_online(unsigned int c
 	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
-		/* Clear mask of registered CPUs */
-		cpumask_clear(policy->real_cpus);
 	}
 
 	/*

