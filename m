From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Avoid redundant initialization of local vars
Date: Fri, 15 Feb 2019 13:15:32 +0100
Message-ID: <2991330.GCSuaqJzpc@aspire.rjw.lan>
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

After commit 1a4fe38add8b ("cpufreq: intel_pstate: Remove max/min
fractions to limit performance") the initial value of the pstate local
variable in intel_pstate_max_within_limits() and the initial value of
the max_pstate local variable in intel_pstate_prepare_request() are
both immediately discarded, so initialize both these variables to
their target values upfront.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1473,11 +1473,9 @@ static void intel_pstate_set_min_pstate(
 
 static void intel_pstate_max_within_limits(struct cpudata *cpu)
 {
-	int pstate;
+	int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
 
 	update_turbo_state();
-	pstate = intel_pstate_get_base_pstate(cpu);
-	pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
 	intel_pstate_set_pstate(cpu, pstate);
 }
 
@@ -1715,11 +1713,9 @@ static inline int32_t get_target_pstate(
 
 static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
 {
-	int max_pstate = intel_pstate_get_base_pstate(cpu);
-	int min_pstate;
+	int min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
+	int max_pstate = max(min_pstate, cpu->max_perf_ratio);
 
-	min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
-	max_pstate = max(min_pstate, cpu->max_perf_ratio);
 	return clamp_t(int, pstate, min_pstate, max_pstate);
 }
 
