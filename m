From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Fix the FSB feq for Airmont
Date: Mon,  9 Nov 2015 17:30:57 -0800
Message-ID: <1447119057-10759-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1447119057-10759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48264 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbbKJBbw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 20:31:52 -0500
In-Reply-To: <1447119057-10759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Stephane Gasparini <stephane.gasparini@linux.intel.com>

Include the Airmont support in the get_scaling function.

There are two flavors of Atom cores to be supported by intel_pstate,
Silvermont and Airmont, so make the driver distinguish between them by
adding separate frequency tables.
Separate the cpu defaults params for each of them and match the CPU IDs
against them as appropriate.

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 57 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f4d7427..c1eb509 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -738,20 +738,35 @@ static void atom_set_pstate(struct cpudata *cpudata, int pstate)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
-#define ATOM_BCLK_FREQS 5
-static int atom_freq_table[ATOM_BCLK_FREQS] = { 833, 1000, 1333, 1167, 800};
-
-static int atom_get_scaling(void)
+static int silvermont_get_scaling(void)
 {
 	u64 value;
 	int i;
+	/* Defined in Table 35-6 from SDM (Sept 2015) */
+	static int silvermont_freq_table[] = {
+		83300, 100000, 133300, 116700, 80000};
 
 	rdmsrl(MSR_FSB_FREQ, value);
-	i = value & 0x3;
+	i = value & 0x7;
+	WARN_ON(i > 4);
 
-	WARN_ON(i > ATOM_BCLK_FREQS);
+	return silvermont_freq_table[i];
+}
 
-	return atom_freq_table[i] * 100;
+static int airmont_get_scaling(void)
+{
+	u64 value;
+	int i;
+	/* Defined in Table 35-10 from SDM (Sept 2015) */
+	static int airmont_freq_table[] = {
+		83300, 100000, 133300, 116700, 80000,
+		93300, 90000, 88900, 87500};
+
+	rdmsrl(MSR_FSB_FREQ, value);
+	i = value & 0xF;
+	WARN_ON(i > 8);
+
+	return airmont_freq_table[i];
 }
 
 static void atom_get_vid(struct cpudata *cpudata)
@@ -887,7 +902,27 @@ static struct cpu_defaults core_params = {
 	},
 };
 
-static struct cpu_defaults atom_params = {
+static struct cpu_defaults silvermont_params = {
+	.pid_policy = {
+		.sample_rate_ms = 10,
+		.deadband = 0,
+		.setpoint = 60,
+		.p_gain_pct = 14,
+		.d_gain_pct = 0,
+		.i_gain_pct = 4,
+	},
+	.funcs = {
+		.get_max = atom_get_max_pstate,
+		.get_max_physical = atom_get_max_pstate,
+		.get_min = atom_get_min_pstate,
+		.get_turbo = atom_get_turbo_pstate,
+		.set = atom_set_pstate,
+		.get_scaling = silvermont_get_scaling,
+		.get_vid = atom_get_vid,
+	},
+};
+
+static struct cpu_defaults airmont_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
@@ -902,7 +937,7 @@ static struct cpu_defaults atom_params = {
 		.get_min = atom_get_min_pstate,
 		.get_turbo = atom_get_turbo_pstate,
 		.set = atom_set_pstate,
-		.get_scaling = atom_get_scaling,
+		.get_scaling = airmont_get_scaling,
 		.get_vid = atom_get_vid,
 	},
 };
@@ -1155,7 +1190,7 @@ static void intel_pstate_timer_func(unsigned long __data)
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x2a, core_params),
 	ICPU(0x2d, core_params),
-	ICPU(0x37, atom_params),
+	ICPU(0x37, silvermont_params),
 	ICPU(0x3a, core_params),
 	ICPU(0x3c, core_params),
 	ICPU(0x3d, core_params),
@@ -1164,7 +1199,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x45, core_params),
 	ICPU(0x46, core_params),
 	ICPU(0x47, core_params),
-	ICPU(0x4c, atom_params),
+	ICPU(0x4c, airmont_params),
 	ICPU(0x4e, core_params),
 	ICPU(0x4f, core_params),
 	ICPU(0x5e, core_params),
-- 
1.9.3

