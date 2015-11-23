From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 4/5] cpufreq: intel_pstate: configurable busy calculation
Date: Mon, 23 Nov 2015 14:06:44 +0100
Message-ID: <1448284006-13596-10-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14848 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbbKWNG0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:26 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

Allow a configurable busy calculation which account for non C0 time
based on APERF and TSC and one via estimates.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f9acfb0..4f08fa7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -134,6 +134,7 @@ struct pstate_funcs {
 	int (*get_scaling)(void);
 	void (*set)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
+	int32_t (*get_busy_percent)(struct cpudata *);
 };
 
 struct cpu_defaults {
@@ -141,6 +142,9 @@ struct cpu_defaults {
 	struct pstate_funcs funcs;
 };
 
+static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu);
+static inline int32_t intel_pstate_get_scaled_busy_estimate(struct cpudata *cpu);
+
 static struct pstate_adjust_policy pid_params;
 static struct pstate_funcs pstate_funcs;
 static int hwp_active;
@@ -739,6 +743,7 @@ static struct cpu_defaults core_params = {
 		.get_turbo = core_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.set = core_set_pstate,
+		.get_busy_percent = intel_pstate_get_scaled_busy_estimate,
 	},
 };
 
@@ -759,6 +764,7 @@ static struct cpu_defaults silvermont_params = {
 		.set = atom_set_pstate,
 		.get_scaling = silvermont_get_scaling,
 		.get_vid = atom_get_vid,
+		.get_busy_percent = intel_pstate_calc_scaled_busy,
 	},
 };
 
@@ -779,6 +785,7 @@ static struct cpu_defaults airmont_params = {
 		.set = atom_set_pstate,
 		.get_scaling = airmont_get_scaling,
 		.get_vid = atom_get_vid,
+		.get_busy_percent = intel_pstate_calc_scaled_busy,
 	},
 };
 
@@ -798,6 +805,7 @@ static struct cpu_defaults knl_params = {
 		.get_turbo = knl_get_turbo_pstate,
 		.get_scaling = core_get_scaling,
 		.set = core_set_pstate,
+		.get_busy_percent = intel_pstate_get_scaled_busy_estimate,
 	},
 };
 
@@ -1012,7 +1020,7 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	from = cpu->pstate.current_pstate;
 
 	pid = &cpu->pid;
-	busy_scaled = intel_pstate_calc_scaled_busy(cpu);
+	busy_scaled = pstate_funcs.get_busy_percent(cpu);
 
 	ctl = pid_calc(pid, busy_scaled);
 
@@ -1276,6 +1284,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_scaling = funcs->get_scaling;
 	pstate_funcs.set       = funcs->set;
 	pstate_funcs.get_vid   = funcs->get_vid;
+	pstate_funcs.get_busy_percent = funcs->get_busy_percent;
+
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
-- 
1.9.1

