From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Clean up after performance governor changes
Date: Thu, 29 Jun 2017 01:47:56 +0200
Message-ID: <4550329.lZWPcKkG2D@aspire.rjw.lan>
References: <5158983.ihgooJZPke@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54844 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbdF1X5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 19:57:21 -0400
In-Reply-To: <5158983.ihgooJZPke@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 82b4e03e01bc (intel_pstate: skip scheduler hook when in
"performance" mode) get_target_pstate_use_performance() and
get_target_pstate_use_cpu_load() are never called if scaling_governor
is "performance", so drop the CPUFREQ_POLICY_PERFORMANCE checks from
them as they will never trigger anyway.

Moreover, the documentation needs to be updated to reflect the change
made by the above commit, so do that too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    6 ++----
 drivers/cpufreq/intel_pstate.c                |    6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1612,9 +1612,6 @@ static inline int32_t get_target_pstate_
 	int32_t busy_frac, boost;
 	int target, avg_pstate;
 
-	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE)
-		return cpu->pstate.turbo_pstate;
-
 	busy_frac = div_fp(sample->mperf, sample->tsc);
 
 	boost = cpu->iowait_boost;
@@ -1651,9 +1648,6 @@ static inline int32_t get_target_pstate_
 	int32_t perf_scaled, max_pstate, current_pstate, sample_ratio;
 	u64 duration_ns;
 
-	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE)
-		return cpu->pstate.turbo_pstate;
-
 	/*
 	 * perf_scaled is the ratio of the average P-state during the last
 	 * sampling period to the P-state requested last time (in percent).
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -157,10 +157,8 @@ Without HWP, this P-state selection algo
 the processor model and platform configuration.
 
 It selects the maximum P-state it is allowed to use, subject to limits set via
-``sysfs``, every time the P-state selection computations are carried out by the
-driver's utilization update callback for the given CPU (that does not happen
-more often than every 10 ms), but the hardware configuration will not be changed
-if the new P-state is the same as the current one.
+``sysfs``, every time the driver configuration for the given CPU is updated
+(e.g. via ``sysfs``).
 
 This is the default P-state selection algorithm if the
 :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
