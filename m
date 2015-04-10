From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] 1. Add KNL CPUID to the list of CPUIDs supported by the intel_pstate driver. 2. Add a new cpu_default structure for KNL since KNL has a slightly different mechanism to get turbo pstates from MSRs
Date: Fri, 10 Apr 2015 10:22:18 -0700
Message-ID: <1428686538-10518-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48652 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755607AbbDJRWT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Apr 2015 13:22:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

From: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 872c577..a1dd871 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -614,6 +614,19 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
+static int knl_get_turbo_pstate(void)
+{
+	u64 value;
+	int nont, ret;
+
+	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+	nont = core_get_max_pstate();
+	ret = (((value) >> 8) & 0xFF);
+	if (ret <= nont)
+		ret = nont;
+	return ret;
+}
+
 static struct cpu_defaults core_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
@@ -651,6 +664,23 @@ static struct cpu_defaults byt_params = {
 	},
 };
 
+static struct cpu_defaults knl_params = {
+	.pid_policy = {
+		.sample_rate_ms = 10,
+		.deadband = 0,
+		.setpoint = 97,
+		.p_gain_pct = 20,
+		.d_gain_pct = 0,
+		.i_gain_pct = 0,
+	},
+	.funcs = {
+		.get_max = core_get_max_pstate,
+		.get_min = core_get_min_pstate,
+		.get_turbo = knl_get_turbo_pstate,
+		.set = core_set_pstate,
+	},
+};
+
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
@@ -865,6 +895,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x4e, core_params),
 	ICPU(0x4f, core_params),
 	ICPU(0x56, core_params),
+	ICPU(0x57, knl_params),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
1.9.3

