From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0
Date: Mon, 18 Jun 2018 12:47:45 -0700
Message-ID: <20180618194745.36879-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

When scaling max/min settings are changed, internally they are converted
to a ratio using the max turbo 1 core turbo frequency. This works fine
when 1 core max is same irrespective of the core. But under Turbo 3.0,
this will not be the case. For example:
Core 0: max turbo pstate: 43 (4.3GHz)
Core 1: max turbo pstate: 45 (4.5GHz)
In this case 1 core turbo ratio will be maximum of all, so it will be
45 (4.5GHz). Suppose scaling max is set to 4GHz (ratio 40) for all cores
,then on core one it will be
 = max_state * policy->max / max_freq;
 = 43 * (4000000/4500000) = 38 (3.8GHz)
 = 38
which is 200MHz less than the desired.
On core2, it will be correctly set to ratio 40 (4GHz). Same holds true
for scaling min frequency limit. So this requires usage of correct turbo
max frequency for core one, which in this case is 4.3GHz. So we need to
adjust per CPU cpu->pstate.turbo_freq using the maximum HWP ratio of that
core.

This change uses the HWP capability of a core to adjust max turbo
frequency. But since Broadwell HWP doesn't use ratios in the HWP
capabilities, we have use legacy max 1 core turbo ratio. This is not a
problem as the HWP capabilities don't differ among cores in Broadwell.
So we need to check for non Broadwell CPU model for applying this change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
---
v2
Backport friendly without any dependency on recent features.

 drivers/cpufreq/intel_pstate.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1de5ec8d5ea3..ece120da3353 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -294,6 +294,7 @@ struct pstate_funcs {
 static struct pstate_funcs pstate_funcs __read_mostly;
 
 static int hwp_active __read_mostly;
+static int hwp_mode_bdw __read_mostly;
 static bool per_cpu_limits __read_mostly;
 static bool hwp_boost __read_mostly;
 
@@ -1413,7 +1414,15 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
-	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+
+	if (hwp_active && !hwp_mode_bdw) {
+		unsigned int phy_max, current_max;
+
+		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
+		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
+	} else {
+		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	}
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
@@ -2467,28 +2476,36 @@ static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
 static inline void intel_pstate_request_control_from_smm(void) {}
 #endif /* CONFIG_ACPI */
 
+#define INTEL_PSTATE_HWP_BROADWELL	0x01
+
+#define ICPU_HWP(model, hwp_mode) \
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
+
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_HWP },
+	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(X86_MODEL_ANY, 0),
 	{}
 };
 
 static int __init intel_pstate_init(void)
 {
+	const struct x86_cpu_id *id;
 	int rc;
 
 	if (no_load)
 		return -ENODEV;
 
-	if (x86_match_cpu(hwp_support_ids)) {
+	id = x86_match_cpu(hwp_support_ids);
+	if (id) {
 		copy_cpu_funcs(&core_funcs);
 		if (!no_hwp) {
 			hwp_active++;
+			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			goto hwp_cpu_matched;
 		}
 	} else {
-		const struct x86_cpu_id *id;
-
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id)
 			return -ENODEV;
-- 
2.17.0
