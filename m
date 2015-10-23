From: plongepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v6 2/2] cpufreq: intel_pstate: Fix the FSB feq for Airmont
Date: Fri, 23 Oct 2015 11:05:32 +0200
Message-ID: <5629F85C.20402@linux.intel.com>
References: <5628A76B.8020905@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1505 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbbJWJEh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Oct 2015 05:04:37 -0400
In-Reply-To: <5628A76B.8020905@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Include the Airmont support in the get_scaling function.

Signed-off-by: longepe <philippe.longepe@linux.intel.com>
---
  drivers/cpufreq/intel_pstate.c | 56 +++++++++++++++++++++++++++++++++---------
  1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8716039..59b90d7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -551,20 +551,35 @@ static void atom_set_pstate(struct cpudata *cpudata, int pstate)
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
+	BUG_ON(i > 4);
  
-	BUG_ON(i > ATOM_BCLK_FREQS);
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
+	BUG_ON(i > 8);
+
+	return airmont_freq_table[i];
  }
  
  static void atom_get_vid(struct cpudata *cpudata)
@@ -659,7 +674,26 @@ static struct cpu_defaults core_params = {
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
@@ -673,7 +707,7 @@ static struct cpu_defaults atom_params = {
  		.get_min = atom_get_min_pstate,
  		.get_turbo = atom_get_turbo_pstate,
  		.set = atom_set_pstate,
-		.get_scaling = atom_get_scaling,
+		.get_scaling = airmont_get_scaling,
  		.get_vid = atom_get_vid,
  	},
  };
@@ -907,7 +941,7 @@ static void intel_pstate_timer_func(unsigned long __data)
  static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
  	ICPU(0x2a, core_params),
  	ICPU(0x2d, core_params),
-	ICPU(0x37, atom_params),
+	ICPU(0x37, silvermont_params),
  	ICPU(0x3a, core_params),
  	ICPU(0x3c, core_params),
  	ICPU(0x3d, core_params),
@@ -916,7 +950,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
  	ICPU(0x45, core_params),
  	ICPU(0x46, core_params),
  	ICPU(0x47, core_params),
-	ICPU(0x4c, atom_params),
+	ICPU(0x4c, airmont_params),
  	ICPU(0x4e, core_params),
  	ICPU(0x4f, core_params),
  	ICPU(0x5e, core_params),
-- 
1.9.1

