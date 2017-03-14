From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Do not squash policy limits between global ones
Date: Tue, 14 Mar 2017 16:17:10 +0100
Message-ID: <1522654.u1Mi2m9xyD@aspire.rjw.lan>
References: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42335 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750969AbdCNPZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 11:25:04 -0400
In-Reply-To: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

intel_pstate_verify_policy() forces per-policy cpufreq limits to
stay within the global limits set via min/max_perf_pct.

The reason for doing that was the reinitialization of performance
limits in intel_pstate_set_policy() that prevented the max limit from
being set to anything below 100, among other things, eliminated by
commit a240c4aa5d0f (cpufreq: intel_pstate: Do not reinit performance
limits in ->setpolicy).

However, an undesirable side effect of commit a240c4aa5d0f is that
now, after setting scaling_governor to "performance" in the active
mode, the per-policy limits for the CPU in question go to the highest
level and stay there even when it is switched back to "powersave"
later.

As it turns out, some distributions set scaling_governor to
"performance" temporarily for all CPUs to speed-up system
initialization, so that change causes them to misbehave later.

To fix this issue, modify intel_pstate_verify_policy() so that it
doesn't squash per-policy limits within the global ones any
more.

Fixes: a240c4aa5d0f (cpufreq: intel_pstate: Do not reinit performance limits in ->setpolicy)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   11 -----------
 1 file changed, 11 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2196,17 +2196,6 @@ static int intel_pstate_verify_policy(st
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
 		return -EINVAL;
 
-	/* When per-CPU limits are used, sysfs limits are not used */
-	if (!per_cpu_limits) {
-		unsigned int max_freq, min_freq;
-
-		max_freq = policy->cpuinfo.max_freq *
-					perf_limits->max_sysfs_pct / 100;
-		min_freq = policy->cpuinfo.max_freq *
-					perf_limits->min_sysfs_pct / 100;
-		cpufreq_verify_within_limits(policy, min_freq, max_freq);
-	}
-
 	return 0;
 }
 
