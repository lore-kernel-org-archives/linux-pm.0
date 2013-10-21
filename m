From: dirk.brandewie@gmail.com
Subject: [PATCH 4/4] cpufreq/intel_pstate: Add Baytrail support
Date: Mon, 21 Oct 2013 09:20:35 -0700
Message-ID: <1382372435-29778-5-git-send-email-dirk.j.brandewie@intel.com>
References: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46193 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JUQUt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:20:49 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so8271272pab.18
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:20:49 -0700 (PDT)
In-Reply-To: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Add support for the Baytrail processor

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c41fff9..89925513 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -33,6 +33,8 @@
 
 #define SAMPLE_COUNT		3
 
+#define BYT_RATIOS	0x66a
+
 #define FRAC_BITS 8
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
@@ -341,6 +343,20 @@ static void intel_pstate_sysfs_expose_params(void)
 }
 
 /************************** sysfs end ************************/
+static int byt_get_min_pstate(void)
+{
+	u64 value;
+	rdmsrl(BYT_RATIOS, value);
+	return value & 0xFF;
+}
+
+static int byt_get_max_pstate(void)
+{
+	u64 value;
+	rdmsrl(BYT_RATIOS, value);
+	return (value >> 16) & 0xFF;
+}
+
 static int core_get_min_pstate(void)
 {
 	u64 value;
@@ -395,6 +411,24 @@ static struct cpu_defaults core_params = {
 	},
 };
 
+static struct cpu_defaults byt_params = {
+	.pid_policy = {
+		.sample_rate_ms = 10,
+		.deadband = 0,
+		.setpoint = 97,
+		.p_gain_pct = 14,
+		.d_gain_pct = 0,
+		.i_gain_pct = 4,
+	},
+	.funcs = {
+		.get_max = byt_get_max_pstate,
+		.get_min = byt_get_min_pstate,
+		.get_turbo = byt_get_max_pstate,
+		.set = core_set_pstate,
+	},
+};
+
+
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
 	int max_perf = cpu->pstate.turbo_pstate;
@@ -551,6 +585,7 @@ static void intel_pstate_timer_func(unsigned long __data)
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x2a, core_params),
 	ICPU(0x2d, core_params),
+	ICPU(0x37, byt_params),
 	ICPU(0x3a, core_params),
 	ICPU(0x3c, core_params),
 	ICPU(0x3e, core_params),
-- 
1.8.3.1

