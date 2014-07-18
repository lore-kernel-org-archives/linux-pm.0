From: dirk.brandewie@gmail.com
Subject: [PATCH 03/11] cpufreq: intel_pstate: Add missing blank lines after declarations
Date: Fri, 18 Jul 2014 08:37:19 -0700
Message-ID: <1405697848-13546-4-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61023 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422803AbaGRPho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:44 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so5647133pad.35
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:43 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

Also, remove unnecessary blank lines.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e5fd780..e9f3048 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -37,7 +37,6 @@
 #define BYT_TURBO_RATIOS	0x66c
 #define BYT_TURBO_VIDS		0x66d
 
-
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
@@ -167,7 +166,6 @@ static inline void pid_i_gain_set(struct _pid *pid, int percent)
 
 static inline void pid_d_gain_set(struct _pid *pid, int percent)
 {
-
 	pid->d_gain = div_fp(int_tofp(percent), int_tofp(100));
 }
 
@@ -217,6 +215,7 @@ static inline void intel_pstate_busy_pid_reset(struct cpudata *cpu)
 static inline void intel_pstate_reset_all_pid(void)
 {
 	unsigned int cpu;
+
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu])
 			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
@@ -230,6 +229,7 @@ static int pid_param_set(void *data, u64 val)
 	intel_pstate_reset_all_pid();
 	return 0;
 }
+
 static int pid_param_get(void *data, u64 *val)
 {
 	*val = *(u32 *)data;
@@ -284,6 +284,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 {
 	unsigned int input;
 	int ret;
+
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
@@ -300,6 +301,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 {
 	unsigned int input;
 	int ret;
+
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
@@ -307,6 +309,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
 	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
 	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
 	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
+
 	return count;
 }
 
@@ -315,6 +318,7 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 {
 	unsigned int input;
 	int ret;
+
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
@@ -360,6 +364,7 @@ static void __init intel_pstate_sysfs_expose_params(void)
 static int byt_get_min_pstate(void)
 {
 	u64 value;
+
 	rdmsrl(BYT_RATIOS, value);
 	return (value >> 8) & 0x7F;
 }
@@ -367,6 +372,7 @@ static int byt_get_min_pstate(void)
 static int byt_get_max_pstate(void)
 {
 	u64 value;
+
 	rdmsrl(BYT_RATIOS, value);
 	return (value >> 16) & 0x7F;
 }
@@ -374,6 +380,7 @@ static int byt_get_max_pstate(void)
 static int byt_get_turbo_pstate(void)
 {
 	u64 value;
+
 	rdmsrl(BYT_TURBO_RATIOS, value);
 	return value & 0x7F;
 }
@@ -407,7 +414,6 @@ static void byt_get_vid(struct cpudata *cpudata)
 {
 	u64 value;
 
-
 	rdmsrl(BYT_VIDS, value);
 	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
 	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
@@ -420,10 +426,10 @@ static void byt_get_vid(struct cpudata *cpudata)
 	cpudata->vid.turbo = value & 0x7f;
 }
 
-
 static int core_get_min_pstate(void)
 {
 	u64 value;
+
 	rdmsrl(MSR_PLATFORM_INFO, value);
 	return (value >> 40) & 0xFF;
 }
@@ -431,6 +437,7 @@ static int core_get_min_pstate(void)
 static int core_get_max_pstate(void)
 {
 	u64 value;
+
 	rdmsrl(MSR_PLATFORM_INFO, value);
 	return (value >> 8) & 0xFF;
 }
@@ -439,6 +446,7 @@ static int core_get_turbo_pstate(void)
 {
 	u64 value;
 	int nont, ret;
+
 	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
 	nont = core_get_max_pstate();
 	ret = ((value) & 255);
@@ -493,12 +501,12 @@ static struct cpu_defaults byt_params = {
 	},
 };
 
-
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
 	int max_perf_adj;
 	int min_perf;
+
 	if (limits.no_turbo)
 		max_perf = cpu->pstate.max_pstate;
 
-- 
1.9.3

