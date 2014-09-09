From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH 2/6] PID: Move Turbo detection into backend driver
Date: Tue,  9 Sep 2014 18:12:04 -0400
Message-ID: <1410300728-26637-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1410300728-26637-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410300728-26637-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dirk.j.brandewie@intel.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

Move X86 specific turbo detection logic into platform
specific PID backend driver.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/intel_pid_ctrl.c | 15 ++++++++++++++-
 drivers/cpufreq/pid_ctrl.c       | 13 +++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pid_ctrl.c b/drivers/cpufreq/intel_pid_ctrl.c
index ebab074..9ad7d5e 100644
--- a/drivers/cpufreq/intel_pid_ctrl.c
+++ b/drivers/cpufreq/intel_pid_ctrl.c
@@ -58,6 +58,11 @@ static int byt_get_max_pstate(void)
 static int byt_get_turbo_pstate(void)
 {
 	u64 value;
+	u64 misc_en;
+
+	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
+	if (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE)
+		return byt_get_max_pstate();
 
 	rdmsrl(BYT_TURBO_RATIOS, value);
 	return value & 0x7F;
@@ -124,12 +129,20 @@ static int core_get_turbo_pstate(void)
 {
 	u64 value;
 	int nont, ret;
+	u64 misc_en;
 
-	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
 	nont = core_get_max_pstate();
+	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
+
+	if (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE)
+		return nont;
+
+	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
 	ret = ((value) & 255);
+
 	if (ret <= nont)
 		ret = nont;
+
 	return ret;
 }
 
diff --git a/drivers/cpufreq/pid_ctrl.c b/drivers/cpufreq/pid_ctrl.c
index b273ce1..516b95f 100644
--- a/drivers/cpufreq/pid_ctrl.c
+++ b/drivers/cpufreq/pid_ctrl.c
@@ -313,10 +313,15 @@ static void pid_ctrl_get_cpu_pstates(struct cpudata *cpu)
 {
 	cpu->pstate.min_pstate = pstate_funcs.get_min();
 	cpu->pstate.max_pstate = pstate_funcs.get_max();
-	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
+
+	if (pstate_funcs.get_turbo)
+		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
+	else
+		cpu->pstate.turbo_pstate = cpu->pstate.max_pstate;
 
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
+
 	pid_ctrl_set_pstate(cpu, cpu->pstate.min_pstate);
 }
 
@@ -532,7 +537,6 @@ static int pid_ctrl_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
 	int rc;
-	u64 misc_en;
 
 	rc = pid_ctrl_init_cpu(policy->cpu);
 	if (rc)
@@ -540,9 +544,7 @@ static int pid_ctrl_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = all_cpu_data[policy->cpu];
 
-	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	if (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
-		cpu->pstate.max_pstate == cpu->pstate.turbo_pstate) {
+	if (cpu->pstate.max_pstate == cpu->pstate.turbo_pstate) {
 		limits.turbo_disabled = 1;
 		limits.no_turbo = 1;
 	}
@@ -598,7 +600,6 @@ static int __init pid_ctrl_init(void)
 {
 	int cpu, rc = 0;
 
-
 	if (!pstate_funcs.get_max ||
 			!pstate_funcs.get_min ||
 			!pstate_funcs.set ||
-- 
1.9.1
