From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent transition delays
Date: Tue, 11 Apr 2017 00:20:41 +0200
Message-ID: <71055380.gdY33coAtF@aspire.rjw.lan>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2407280.n9qVSLCrF5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50541 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751275AbdDJW0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 18:26:37 -0400
In-Reply-To: <2407280.n9qVSLCrF5@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Brendan Jackman <brendan.jackman@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the schedutil governor take the initial (default) value of the
rate_limit_us sysfs attribute from the (new) transition_delay_us
policy parameter (to be set by the scaling driver).

That will allow scaling drivers to make schedutil use smaller default
values of rate_limit_us and reduce the default average time interval
between consecutive frequency changes.

Make intel_pstate set transition_delay_us to 500.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a replacement for https://patchwork.kernel.org/patch/9671831/

---
 drivers/cpufreq/intel_pstate.c   |    2 ++
 include/linux/cpufreq.h          |    7 +++++++
 kernel/sched/cpufreq_schedutil.c |   15 ++++++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -120,6 +120,13 @@ struct cpufreq_policy {
 	bool			fast_switch_possible;
 	bool			fast_switch_enabled;
 
+	/*
+	 * Preferred average time interval between consecutive invocations of
+	 * the driver to set the frequency for this policy.  To be set by the
+	 * scaling driver (0, which is the default, means no preference).
+	 */
+	unsigned int		transition_delay_us;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	int cached_resolved_idx;
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -491,7 +491,6 @@ static int sugov_init(struct cpufreq_pol
 {
 	struct sugov_policy *sg_policy;
 	struct sugov_tunables *tunables;
-	unsigned int lat;
 	int ret = 0;
 
 	/* State should be equivalent to EXIT */
@@ -530,10 +529,16 @@ static int sugov_init(struct cpufreq_pol
 		goto stop_kthread;
 	}
 
-	tunables->rate_limit_us = LATENCY_MULTIPLIER;
-	lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-	if (lat)
-		tunables->rate_limit_us *= lat;
+	if (policy->transition_delay_us) {
+		tunables->rate_limit_us = policy->transition_delay_us;
+	} else {
+		unsigned int lat;
+
+		tunables->rate_limit_us = LATENCY_MULTIPLIER;
+		lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+		if (lat)
+			tunables->rate_limit_us *= lat;
+	}
 
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -41,6 +41,7 @@
 #define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
+#define INTEL_CPUFREQ_TRANSITION_DELAY		500
 
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
@@ -2237,6 +2238,7 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
+	policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
