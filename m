From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix up iowait_boost computation
Date: Mon, 11 Mar 2019 12:57:25 +0100
Message-ID: <2396291.FVDonix7jd@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b8bd1581aa61 ("cpufreq: intel_pstate: Rework iowait
boosting to be less aggressive") the handling of the case when
the SCHED_CPUFREQ_IOWAIT flag is set again after a few iterations of
intel_pstate_update_util() is a bit inconsistent, because the
new value of cpu->iowait_boost may be lower than ONE_EIGHTH_FP
if it was set before, but has not dropped down to zero just yet.

Fix that up by ensuring that the new value of cpu->iowait_boost
will always be at least ONE_EIGHTH_FP then.

Fixes: b8bd1581aa61 ("cpufreq: intel_pstate: Rework iowait boosting to be less aggressive")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1806,7 +1806,7 @@ static void intel_pstate_update_util(str
 		/* Start over if the CPU may have been idle. */
 		if (delta_ns > TICK_NSEC) {
 			cpu->iowait_boost = ONE_EIGHTH_FP;
-		} else if (cpu->iowait_boost) {
+		} else if (cpu->iowait_boost >= ONE_EIGHTH_FP) {
 			cpu->iowait_boost <<= 1;
 			if (cpu->iowait_boost > int_tofp(1))
 				cpu->iowait_boost = int_tofp(1);
