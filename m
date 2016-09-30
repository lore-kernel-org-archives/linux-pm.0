From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Clarify comment in get_target_pstate_use_performance()
Date: Fri, 30 Sep 2016 03:13:34 +0200
Message-ID: <2363855.qekOZeIRQI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60288 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752523AbcI3BHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 21:07:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the comment explaining the meaning of the perf_scaled variable
in get_target_pstate_use_performance() more straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1251,10 +1251,11 @@ static inline int32_t get_target_pstate_
 	u64 duration_ns;
 
 	/*
-	 * perf_scaled is the average performance during the last sampling
-	 * period scaled by the ratio of the maximum P-state to the P-state
-	 * requested last time (in percent).  That measures the system's
-	 * response to the previous P-state selection.
+	 * perf_scaled is the ratio of the average P-state during the last
+	 * sampling period to the P-state requested last time (in percent).
+	 *
+	 * That measures the system's response to the previous P-state
+	 * selection.
 	 */
 	max_pstate = cpu->pstate.max_pstate_physical;
 	current_pstate = cpu->pstate.current_pstate;

