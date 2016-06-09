From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Broxton support
Date: Thu,  9 Jun 2016 15:34:41 -0700
Message-ID: <1465511681-6571-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52878 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcFIWdI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jun 2016 18:33:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added Broxton cpu model number. Broxton requires core_params to get
performance limits via MSRs, but it is an Atom platform, which requires
more power optimized algorithm. So the P state selection will use similar
algorithm as other Atom platforms.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e1b7a5e..8a0e405 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1110,6 +1110,26 @@ static struct cpu_defaults knl_params = {
 	},
 };
 
+static struct cpu_defaults bxt_params = {
+	.pid_policy = {
+		.sample_rate_ms = 10,
+		.deadband = 0,
+		.setpoint = 60,
+		.p_gain_pct = 14,
+		.d_gain_pct = 0,
+		.i_gain_pct = 4,
+	},
+	.funcs = {
+		.get_max = core_get_max_pstate,
+		.get_max_physical = core_get_max_pstate_physical,
+		.get_min = core_get_min_pstate,
+		.get_turbo = core_get_turbo_pstate,
+		.get_scaling = core_get_scaling,
+		.get_val = core_get_val,
+		.get_target_pstate = get_target_pstate_use_cpu_load,
+	},
+};
+
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
@@ -1370,6 +1390,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP,	core_params),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_params),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_params),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_params),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.5.5

