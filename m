From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/6] cpufreq: intel_p_state: Fix limiting turbo sub states
Date: Thu, 27 Aug 2015 18:34:21 -0700
Message-ID: <1440725666-3550-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbH1Bfi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 21:35:38 -0400
In-Reply-To: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Although the max_perf_pct reflects sub states in turbo range, we can't
really restrict to those states. This gives wrong impression that the
performance is reduced.
This can be achieved by restricting turbo ratio limits (MSR 0x1AD),
when bit 28 of platform info MSR allows (MSR 0xCE) is 1.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 93 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fcb929e..bf5b9d9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -80,6 +80,7 @@ struct pstate_data {
 	int	max_pstate;
 	int	scaling;
 	int	turbo_pstate;
+	u64	turbo_ratio_limit;
 };
 
 struct vid_data {
@@ -132,6 +133,8 @@ struct pstate_funcs {
 	int (*get_scaling)(void);
 	void (*set)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
+	u64 (*get_turbo_ratio_limit)(struct cpudata *);
+	int (*set_turbo_ratio_limit)(struct cpudata *, u64, u64);
 };
 
 struct cpu_defaults {
@@ -425,6 +428,23 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
 
+	if (pstate_funcs.set_turbo_ratio_limit) {
+		int max_perf_adj;
+		struct cpudata *cpu = all_cpu_data[0];
+
+		if (limits.max_sysfs_pct == 100)
+			max_perf_adj = cpu->pstate.turbo_ratio_limit;
+		else
+			max_perf_adj = fp_toint(mul_fp(int_tofp(
+					cpu->pstate.turbo_ratio_limit & 0xff),
+					limits.max_perf));
+
+		if (max_perf_adj > cpu->pstate.max_pstate)
+			pstate_funcs.set_turbo_ratio_limit(cpu,
+						cpu->pstate.turbo_ratio_limit,
+						max_perf_adj);
+	}
+
 	if (hwp_active)
 		intel_pstate_hwp_set();
 	return count;
@@ -618,6 +638,55 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
 }
 
+static u64 core_get_turbo_ratio_limit(struct cpudata *cpudata)
+{
+	u64 value;
+
+	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
+
+	return value;
+}
+
+static int core_set_turbo_ratio_limit(struct cpudata *cpudata, u64 def_ratio,
+			       u64 new_ratio)
+{
+	u64 value;
+
+	rdmsrl(MSR_PLATFORM_INFO, value);
+	if (value & BIT(28)) {
+		u64 ratio = 0;
+		u64 out_ratio = 0;
+		u8 max_ratio = new_ratio & 0xff;
+		int i;
+		/*
+		 * If caller provided reduced max ratio (one core active)
+		 * then use this for all other ratios, which are more
+		 * than the default ratio for those many cores active
+		 * for example if default ratio is 0x1a1b1c1d and new ratio
+		 * is 0x1b, then resultant ratio will be 0x1a1b1b1b
+		 */
+		for (i = 0; i < sizeof(def_ratio); ++i) {
+			if (def_ratio & 0xff) {
+				if (new_ratio & 0xff)
+					ratio = new_ratio & 0xff;
+				else {
+					if ((def_ratio & 0xff) > max_ratio)
+						ratio = max_ratio;
+					else
+						ratio = def_ratio & 0xff;
+				}
+				out_ratio |= (ratio << (i * 8));
+			}
+			def_ratio >>= 8;
+			new_ratio >>= 8;
+		}
+		wrmsrl(MSR_NHM_TURBO_RATIO_LIMIT, out_ratio);
+		return 0;
+	}
+
+	return -EPERM;
+}
+
 static int knl_get_turbo_pstate(void)
 {
 	u64 value;
@@ -646,6 +715,8 @@ static struct cpu_defaults core_params = {
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.set = core_set_pstate,
+		.get_turbo_ratio_limit = core_get_turbo_ratio_limit,
+		.set_turbo_ratio_limit = core_set_turbo_ratio_limit,
 	},
 };
 
@@ -735,7 +806,10 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.max_pstate = pstate_funcs.get_max();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
-
+	if (pstate_funcs.get_turbo_ratio_limit &&
+	    !cpu->pstate.turbo_ratio_limit)
+		cpu->pstate.turbo_ratio_limit =
+			pstate_funcs.get_turbo_ratio_limit(cpu);
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
@@ -935,6 +1009,21 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 	cpu->cpu = cpunum;
 	intel_pstate_get_cpu_pstates(cpu);
 
+	/* readjust turbo limit ratio after resume or hotplug */
+	if (limits.max_sysfs_pct != 100 &&
+	    pstate_funcs.set_turbo_ratio_limit) {
+		int max_perf_adj;
+
+		max_perf_adj = fp_toint(mul_fp(int_tofp(
+					cpu->pstate.turbo_ratio_limit & 0xff),
+					limits.max_perf));
+
+		if (max_perf_adj > cpu->pstate.max_pstate)
+			pstate_funcs.set_turbo_ratio_limit(cpu,
+						cpu->pstate.turbo_ratio_limit,
+						max_perf_adj);
+	}
+
 	init_timer_deferrable(&cpu->timer);
 	cpu->timer.data = (unsigned long)cpu;
 	cpu->timer.expires = jiffies + HZ/100;
@@ -1096,6 +1185,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_scaling = funcs->get_scaling;
 	pstate_funcs.set       = funcs->set;
 	pstate_funcs.get_vid   = funcs->get_vid;
+	pstate_funcs.set_turbo_ratio_limit = funcs->set_turbo_ratio_limit;
+	pstate_funcs.get_turbo_ratio_limit = funcs->get_turbo_ratio_limit;
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
2.4.3

