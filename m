From: dirk.brandewie@gmail.com
Subject: [PATCH V2] intel_pstate: Add setting voltage value for baytrail P states.
Date: Wed, 18 Dec 2013 10:32:39 -0800
Message-ID: <1387391559-3133-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50765 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab3LRSct (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 13:32:49 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so20069pdj.37
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2013 10:32:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Baytrail requires setting P state and voltage pairs when adjusting the
requested P state.  Add function for retrieving the valid voltage
values and modify *_set_pstate() functions to caluclate the
appropriate voltage for the requested P state.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 58 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c2dd7dc..cfccb6f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -35,6 +35,7 @@
 #define SAMPLE_COUNT		3
 
 #define BYT_RATIOS	0x66a
+#define BYT_VIDS        0x66b
 
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
@@ -64,6 +65,12 @@ struct pstate_data {
 	int	turbo_pstate;
 };
 
+struct vid_data {
+	int32_t min;
+	int32_t max;
+	int32_t ratio;
+};
+
 struct _pid {
 	int setpoint;
 	int32_t integral;
@@ -82,6 +89,7 @@ struct cpudata {
 	struct timer_list timer;
 
 	struct pstate_data pstate;
+	struct vid_data vid;
 	struct _pid pid;
 
 	u64	prev_aperf;
@@ -104,7 +112,8 @@ struct pstate_funcs {
 	int (*get_max)(void);
 	int (*get_min)(void);
 	int (*get_turbo)(void);
-	void (*set)(int pstate);
+	void (*set)(struct cpudata*, int pstate);
+	void (*get_vid)(struct cpudata *);
 };
 
 struct cpu_defaults {
@@ -356,6 +365,42 @@ static int byt_get_max_pstate(void)
 	return (value >> 16) & 0xFF;
 }
 
+static void byt_set_pstate(struct cpudata *cpudata, int pstate)
+{
+	u64 val;
+	int32_t vid_fp;
+	u32 vid;
+
+	val = pstate << 8;
+	if (limits.no_turbo)
+		val |= (u64)1 << 32;
+
+	vid_fp = cpudata->vid.min + mul_fp(
+		int_tofp(pstate - cpudata->pstate.min_pstate),
+		cpudata->vid.ratio);
+
+	vid_fp = clamp_t(int32_t, vid_fp, cpudata->vid.min, cpudata->vid.max);
+	vid = fp_toint(vid_fp);
+
+	val |= vid;
+
+	wrmsrl(MSR_IA32_PERF_CTL, val);
+}
+
+static void byt_get_vid(struct cpudata *cpudata)
+{
+	u64 value;
+
+	rdmsrl(BYT_VIDS, value);
+	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
+	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
+	cpudata->vid.ratio = div_fp(
+		cpudata->vid.max - cpudata->vid.min,
+		int_tofp(cpudata->pstate.max_pstate - 
+			cpudata->pstate.min_pstate));
+}
+
+
 static int core_get_min_pstate(void)
 {
 	u64 value;
@@ -382,7 +427,7 @@ static int core_get_turbo_pstate(void)
 	return ret;
 }
 
-static void core_set_pstate(int pstate)
+static void core_set_pstate(struct cpudata *cpudata, int pstate)
 {
 	u64 val;
 
@@ -423,7 +468,8 @@ static struct cpu_defaults byt_params = {
 		.get_max = byt_get_max_pstate,
 		.get_min = byt_get_min_pstate,
 		.get_turbo = byt_get_max_pstate,
-		.set = core_set_pstate,
+		.set = byt_set_pstate,
+		.get_vid = byt_get_vid,
 	},
 };
 
@@ -460,7 +506,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 
 	cpu->pstate.current_pstate = pstate;
 
-	pstate_funcs.set(pstate);
+	pstate_funcs.set(cpu, pstate);
 }
 
 static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)
@@ -486,6 +532,9 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.max_pstate = pstate_funcs.get_max();
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 
+	if (pstate_funcs.get_vid)
+		pstate_funcs.get_vid(cpu);
+
 	/*
 	 * goto max pstate so we don't slow up boot if we are built-in if we are
 	 * a module we will take care of it during normal operation
@@ -765,6 +814,7 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_min   = funcs->get_min;
 	pstate_funcs.get_turbo = funcs->get_turbo;
 	pstate_funcs.set       = funcs->set;
+	pstate_funcs.get_vid   = funcs->get_vid;
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
1.8.3.1

