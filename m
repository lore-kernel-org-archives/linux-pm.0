From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent latency multupliers
Date: Mon, 10 Apr 2017 02:10:46 +0200
Message-ID: <2407280.n9qVSLCrF5@aspire.rjw.lan>
References: <3498238.liCqOyIkGA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64026 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752726AbdDJASB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Apr 2017 20:18:01 -0400
In-Reply-To: <3498238.liCqOyIkGA@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the schedutil governor compute the initial (default) value of
the rate_limit_us sysfs attribute by multiplying the transition
latency by a multiplier depending on the policy and set by the
scaling driver (instead of using a constant for this purpose).

That will allow scaling drivers to make schedutil use smaller default
values of rate_limit_us and reduce the default average time interval
between consecutive frequency changes.

Make intel_pstate use the opportunity to reduce the rate limit
somewhat.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c        |    1 +
 drivers/cpufreq/intel_pstate.c   |    2 ++
 include/linux/cpufreq.h          |    8 ++++++++
 kernel/sched/cpufreq_schedutil.c |    2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1072,6 +1072,7 @@ static struct cpufreq_policy *cpufreq_po
 	init_waitqueue_head(&policy->transition_wait);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
+	policy->latency_multiplier = LATENCY_MULTIPLIER;
 
 	policy->cpu = cpu;
 	return policy;
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -120,6 +120,14 @@ struct cpufreq_policy {
 	bool			fast_switch_possible;
 	bool			fast_switch_enabled;
 
+	/*
+	 * Multiplier to apply to the transition latency to obtain the preferred
+	 * average time interval between consecutive invocations of the driver
+	 * to set the frequency for this policy.  Initialized by the core to the
+	 * LATENCY_MULTIPLIER value.
+	 */
+	unsigned int		latency_multiplier;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	int cached_resolved_idx;
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -530,7 +530,7 @@ static int sugov_init(struct cpufreq_pol
 		goto stop_kthread;
 	}
 
-	tunables->rate_limit_us = LATENCY_MULTIPLIER;
+	tunables->rate_limit_us = policy->latency_multiplier;
 	lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
 	if (lat)
 		tunables->rate_limit_us *= lat;
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -41,6 +41,7 @@
 #define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
+#define INTEL_CPUFREQ_LATENCY_MULTIPLIER	250
 
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
@@ -2237,6 +2238,7 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
+	policy->latency_multiplier = INTEL_CPUFREQ_LATENCY_MULTIPLIER;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
