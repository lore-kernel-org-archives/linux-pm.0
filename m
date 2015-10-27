From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4] cpufreq: intel_p_state: Fix limiting turbo sub states
Date: Mon, 26 Oct 2015 17:39:34 -0700
Message-ID: <1445906374-8717-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45570 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbbJ0AkZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 26 Oct 2015 20:40:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Although the max_perf_pct reflects sub states in turbo range, we can't
really restrict to those states. This gives wrong impression that the
performance is reduced.
This can be achieved by restricting turbo ratio limits (MSR 0x1AD),
when bit 28 of platform info MSR allows (MSR 0xCE) is 1.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

This patch was omitted from v4 versions of currently merged patchset
"Intel P State enhancements" (merged to linux next). This patch was
1/6 till the v3 version of the above patchset.

This patch addresses comment on v3 version of this patchset.

- Explain the significance of first byte
- Remove cpu argument from callbacks as it is not used
- last argument of core_set_turbo_ratio_limit changed to u8 from u64.
- Optimize loop to set turbo ratio for setting as suggested by Rafael
- Change return error code for locked parts to -ENXIO

 drivers/cpufreq/intel_pstate.c | 104 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 02bc6c5..551798c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -84,6 +84,7 @@ struct pstate_data {
 	int	max_pstate_physical;
 	int	scaling;
 	int	turbo_pstate;
+	u64	turbo_ratio_limit;
 };
 
 struct vid_data {
@@ -140,6 +141,8 @@ struct pstate_funcs {
 	int (*get_scaling)(void);
 	void (*set)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
+	u64 (*get_turbo_ratio_limit)(void);
+	int (*set_turbo_ratio_limit)(u64, u8);
 };
 
 struct cpu_defaults {
@@ -617,6 +620,34 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
 				  int_tofp(100));
 
+	if (pstate_funcs.set_turbo_ratio_limit) {
+		u8 max_perf_adj;
+		struct cpudata *cpu = all_cpu_data[0];
+
+		/*
+		 * The first byte stores the maximum turbo ratio when 1 core
+		 * is active, which wil be maximum performance system can get.
+		 * Intel P state sysfs percent 100% is this ratio.
+		 */
+		if (limits->max_sysfs_pct == 100)
+			max_perf_adj = cpu->pstate.turbo_ratio_limit & 0xff;
+		else
+			/*
+			 * limits.max_perf is a value between 0-255, which
+			 * corresponds to 0-100%. max_perf_adj is a scaled
+			 * ratio based on the limits.max_perf. For example
+			 * 0x1d is max 1C ratio or 100% then 90%
+			 * (limits->max_perf = 230) ratio will be 0x1a.
+			 */
+			max_perf_adj = fp_toint(mul_fp(int_tofp(
+					cpu->pstate.turbo_ratio_limit & 0xff),
+					limits->max_perf));
+		if (max_perf_adj > cpu->pstate.max_pstate)
+			pstate_funcs.set_turbo_ratio_limit(
+						cpu->pstate.turbo_ratio_limit,
+						max_perf_adj);
+	}
+
 	if (hwp_active)
 		intel_pstate_hwp_set();
 	return count;
@@ -855,6 +886,56 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
+static u64 core_get_turbo_ratio_limit(void)
+{
+	u64 value;
+
+	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+
+	return value;
+}
+
+static int core_set_turbo_ratio_limit(u64 def_ratio, u8 new_1c_ratio)
+{
+	u64 value;
+
+	rdmsrl(MSR_PLATFORM_INFO, value);
+	if (value & BIT(28)) {
+		u64 mask = 0xff;
+		u64 out_ratio = 0;
+		u64 max_ratio = new_1c_ratio;
+		u64 current_ratio;
+
+		current_ratio = core_get_turbo_ratio_limit();
+		if ((current_ratio & 0xff) == new_1c_ratio)
+			return 0;
+
+		/*
+		 * If caller provided reduced max ratio (one core active)
+		 * then use this for all other ratios, which are more
+		 * than the default ratio for those many cores active
+		 * for example if default ratio is 0x1a1b1c1d and new ratio
+		 * is 0x1b, then resultant ratio will be 0x1a1b1b1b
+		 */
+		while (mask) {
+			if (def_ratio & mask) {
+				u64 ratio = def_ratio & mask;
+
+				if (ratio > max_ratio)
+					ratio = max_ratio;
+
+				out_ratio |= ratio;
+			}
+			max_ratio <<= 8;
+			mask <<= 8;
+		}
+		wrmsrl(MSR_NHM_TURBO_RATIO_LIMIT, out_ratio);
+		return 0;
+	}
+
+	return -ENXIO;
+}
+
 static int knl_get_turbo_pstate(void)
 {
 	u64 value;
@@ -884,6 +965,8 @@ static struct cpu_defaults core_params = {
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.set = core_set_pstate,
+		.get_turbo_ratio_limit = core_get_turbo_ratio_limit,
+		.set_turbo_ratio_limit = core_set_turbo_ratio_limit,
 	},
 };
 
@@ -987,7 +1070,10 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
-
+	if (pstate_funcs.get_turbo_ratio_limit &&
+	    !cpu->pstate.turbo_ratio_limit)
+		cpu->pstate.turbo_ratio_limit =
+			pstate_funcs.get_turbo_ratio_limit();
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
@@ -1198,6 +1284,20 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		intel_pstate_hwp_enable(cpu);
 
 	intel_pstate_get_cpu_pstates(cpu);
+	/* readjust turbo limit ratio after resume or hotplug */
+	if (limits->max_sysfs_pct != 100 &&
+	    pstate_funcs.set_turbo_ratio_limit) {
+		int max_perf_adj;
+
+		max_perf_adj = fp_toint(mul_fp(int_tofp(
+					cpu->pstate.turbo_ratio_limit & 0xff),
+					limits->max_perf));
+
+		if (max_perf_adj > cpu->pstate.max_pstate)
+			pstate_funcs.set_turbo_ratio_limit(
+						cpu->pstate.turbo_ratio_limit,
+						max_perf_adj);
+	}
 
 	init_timer_deferrable(&cpu->timer);
 	cpu->timer.data = (unsigned long)cpu;
@@ -1406,6 +1506,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_scaling = funcs->get_scaling;
 	pstate_funcs.set       = funcs->set;
 	pstate_funcs.get_vid   = funcs->get_vid;
+	pstate_funcs.set_turbo_ratio_limit = funcs->set_turbo_ratio_limit;
+	pstate_funcs.get_turbo_ratio_limit = funcs->get_turbo_ratio_limit;
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
2.4.3

