From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Eliminate intel_pstate_get_base_pstate()
Date: Fri, 15 Feb 2019 13:16:40 +0100
Message-ID: <2580980.jRUbltTAZz@aspire.rjw.lan>
References: <2474712.mvXUDI8C0e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2474712.mvXUDI8C0e@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Chen Yu <y.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is only one caller of intel_pstate_get_base_pstate() and it is
more straightforward to carry out the computation directly in the
caller, so do that and drop intel_pstate_get_base_pstate().

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1447,12 +1447,6 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
-static int intel_pstate_get_base_pstate(struct cpudata *cpu)
-{
-	return global.no_turbo || global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-}
-
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
@@ -1973,7 +1967,8 @@ static void intel_pstate_update_perf_lim
 	if (hwp_active) {
 		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
 	} else {
-		max_state = intel_pstate_get_base_pstate(cpu);
+		max_state = global.no_turbo || global.turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 		turbo_max = cpu->pstate.turbo_pstate;
 	}
 
