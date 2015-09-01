From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/6] cpufreq: intel-pstate: Use separate max pstate for scaling
Date: Tue,  1 Sep 2015 04:53:58 -0700
Message-ID: <1441108441-3388-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1441108441-3388-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20686 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940AbbIALzQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Sep 2015 07:55:16 -0400
In-Reply-To: <1441108441-3388-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Systems with configurable TDP have multiple max non turbo p state. Intel
P state uses max non turbo P state for scaling. But using the real max
non turbo p state causes underestimation of next P state. So using
the physical max non turbo P state as before for scaling.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6260cc7..e92a59f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -77,6 +77,7 @@ struct pstate_data {
 	int	current_pstate;
 	int	min_pstate;
 	int	max_pstate;
+	int	max_pstate_physical;
 	int	scaling;
 	int	turbo_pstate;
 	u64	turbo_ratio_limit;
@@ -127,6 +128,7 @@ struct pstate_adjust_policy {
 
 struct pstate_funcs {
 	int (*get_max)(void);
+	int (*get_max_physical)(void);
 	int (*get_min)(void);
 	int (*get_turbo)(void);
 	int (*get_scaling)(void);
@@ -600,6 +602,14 @@ static int core_get_min_pstate(void)
 	return (value >> 40) & 0xFF;
 }
 
+static int core_get_max_pstate_physical(void)
+{
+	u64 value;
+
+	rdmsrl(MSR_PLATFORM_INFO, value);
+	return (value >> 8) & 0xFF;
+}
+
 static int core_get_max_pstate(void)
 {
 	u64 tar;
@@ -742,6 +752,7 @@ static struct cpu_defaults core_params = {
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
 		.get_min = core_get_min_pstate,
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
@@ -762,6 +773,7 @@ static struct cpu_defaults byt_params = {
 	},
 	.funcs = {
 		.get_max = byt_get_max_pstate,
+		.get_max_physical = byt_get_max_pstate,
 		.get_min = byt_get_min_pstate,
 		.get_turbo = byt_get_turbo_pstate,
 		.set = byt_set_pstate,
@@ -781,6 +793,7 @@ static struct cpu_defaults knl_params = {
 	},
 	.funcs = {
 		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
 		.get_min = core_get_min_pstate,
 		.get_turbo = knl_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
@@ -835,6 +848,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
 	cpu->pstate.max_pstate = pstate_funcs.get_max();
+	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
 	if (pstate_funcs.get_turbo_ratio_limit &&
@@ -856,7 +870,8 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 
 	sample->freq = fp_toint(
 		mul_fp(int_tofp(
-			cpu->pstate.max_pstate * cpu->pstate.scaling / 100),
+			cpu->pstate.max_pstate_physical *
+			cpu->pstate.scaling / 100),
 			core_pct));
 
 	sample->core_pct_busy = (int32_t)core_pct;
@@ -924,7 +939,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 	 * specified pstate.
 	 */
 	core_busy = cpu->sample.core_pct_busy;
-	max_pstate = int_tofp(cpu->pstate.max_pstate);
+	max_pstate = int_tofp(cpu->pstate.max_pstate_physical);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
 
@@ -1211,6 +1226,7 @@ static void copy_pid_params(struct pstate_adjust_policy *policy)
 static void copy_cpu_funcs(struct pstate_funcs *funcs)
 {
 	pstate_funcs.get_max   = funcs->get_max;
+	pstate_funcs.get_max_physical = funcs->get_max_physical;
 	pstate_funcs.get_min   = funcs->get_min;
 	pstate_funcs.get_turbo = funcs->get_turbo;
 	pstate_funcs.get_scaling = funcs->get_scaling;
-- 
2.4.3

