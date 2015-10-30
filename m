From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v8 1/2] cpufreq: intel_pstate: Replace BYT by ATOM
Date: Fri, 30 Oct 2015 19:28:17 +0100
Message-ID: <1446229698-21391-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759928AbbJ3S1X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Oct 2015 14:27:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Stephane Gasparini <stephane.gasparini@linux.intel.com>

The goal is to support several Atoms architectures.

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Signed-off-by: Stephane Gasparini <stephane.gasparini@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aa33b92..8618b02 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -34,10 +34,10 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 
-#define BYT_RATIOS		0x66a
-#define BYT_VIDS		0x66b
-#define BYT_TURBO_RATIOS	0x66c
-#define BYT_TURBO_VIDS		0x66d
+#define ATOM_RATIOS		0x66a
+#define ATOM_VIDS		0x66b
+#define ATOM_TURBO_RATIOS	0x66c
+#define ATOM_TURBO_VIDS		0x66d
 
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
@@ -502,31 +502,31 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 }
 
-static int byt_get_min_pstate(void)
+static int atom_get_min_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(BYT_RATIOS, value);
+	rdmsrl(ATOM_RATIOS, value);
 	return (value >> 8) & 0x7F;
 }
 
-static int byt_get_max_pstate(void)
+static int atom_get_max_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(BYT_RATIOS, value);
+	rdmsrl(ATOM_RATIOS, value);
 	return (value >> 16) & 0x7F;
 }
 
-static int byt_get_turbo_pstate(void)
+static int atom_get_turbo_pstate(void)
 {
 	u64 value;
 
-	rdmsrl(BYT_TURBO_RATIOS, value);
+	rdmsrl(ATOM_TURBO_RATIOS, value);
 	return value & 0x7F;
 }
 
-static void byt_set_pstate(struct cpudata *cpudata, int pstate)
+static void atom_set_pstate(struct cpudata *cpudata, int pstate)
 {
 	u64 val;
 	int32_t vid_fp;
@@ -551,10 +551,10 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
-#define BYT_BCLK_FREQS 5
-static int byt_freq_table[BYT_BCLK_FREQS] = { 833, 1000, 1333, 1167, 800};
+#define ATOM_BCLK_FREQS 5
+static int atom_freq_table[ATOM_BCLK_FREQS] = { 833, 1000, 1333, 1167, 800};
 
-static int byt_get_scaling(void)
+static int atom_get_scaling(void)
 {
 	u64 value;
 	int i;
@@ -562,16 +562,16 @@ static int byt_get_scaling(void)
 	rdmsrl(MSR_FSB_FREQ, value);
 	i = value & 0x3;
 
-	BUG_ON(i > BYT_BCLK_FREQS);
+	BUG_ON(i > ATOM_BCLK_FREQS);
 
-	return byt_freq_table[i] * 100;
+	return atom_freq_table[i] * 100;
 }
 
-static void byt_get_vid(struct cpudata *cpudata)
+static void atom_get_vid(struct cpudata *cpudata)
 {
 	u64 value;
 
-	rdmsrl(BYT_VIDS, value);
+	rdmsrl(ATOM_VIDS, value);
 	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
 	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
 	cpudata->vid.ratio = div_fp(
@@ -579,7 +579,7 @@ static void byt_get_vid(struct cpudata *cpudata)
 		int_tofp(cpudata->pstate.max_pstate -
 			cpudata->pstate.min_pstate));
 
-	rdmsrl(BYT_TURBO_VIDS, value);
+	rdmsrl(ATOM_TURBO_VIDS, value);
 	cpudata->vid.turbo = value & 0x7f;
 }
 
@@ -659,7 +659,7 @@ static struct cpu_defaults core_params = {
 	},
 };
 
-static struct cpu_defaults byt_params = {
+static struct cpu_defaults atom_params = {
 	.pid_policy = {
 		.sample_rate_ms = 10,
 		.deadband = 0,
@@ -669,12 +669,12 @@ static struct cpu_defaults byt_params = {
 		.i_gain_pct = 4,
 	},
 	.funcs = {
-		.get_max = byt_get_max_pstate,
-		.get_min = byt_get_min_pstate,
-		.get_turbo = byt_get_turbo_pstate,
-		.set = byt_set_pstate,
-		.get_scaling = byt_get_scaling,
-		.get_vid = byt_get_vid,
+		.get_max = atom_get_max_pstate,
+		.get_min = atom_get_min_pstate,
+		.get_turbo = atom_get_turbo_pstate,
+		.set = atom_set_pstate,
+		.get_scaling = atom_get_scaling,
+		.get_vid = atom_get_vid,
 	},
 };
 
@@ -912,7 +912,7 @@ static void intel_pstate_timer_func(unsigned long __data)
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x2a, core_params),
 	ICPU(0x2d, core_params),
-	ICPU(0x37, byt_params),
+	ICPU(0x37, atom_params),
 	ICPU(0x3a, core_params),
 	ICPU(0x3c, core_params),
 	ICPU(0x3d, core_params),
@@ -921,7 +921,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x45, core_params),
 	ICPU(0x46, core_params),
 	ICPU(0x47, core_params),
-	ICPU(0x4c, byt_params),
+	ICPU(0x4c, atom_params),
 	ICPU(0x4e, core_params),
 	ICPU(0x4f, core_params),
 	ICPU(0x5e, core_params),
-- 
1.9.1

