From: dirk.brandewie@gmail.com
Subject: [PATCH 3/4] intel_pstate: add sample time scaling
Date: Thu, 29 May 2014 09:32:24 -0700
Message-ID: <1401381145-17745-4-git-send-email-dirk.j.brandewie@intel.com>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40418 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052AbaE2Qcl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 May 2014 12:32:41 -0400
In-Reply-To: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dirk.brandewie@gmail.com, rjw@rjwysocki.net, dsmythies@telus.net, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

The PID assumes that samples are of equal time, which for a deferable
timers this is not true when the system goes idle.  This causes the
PID to take a long time to converge to the min P state and depending
on the pattern of the idle load can make the P state appear stuck.

The hold-off value of three sample times before using the scaling is
to give a grace period for applications that have high performance
requirements and spend a lot of time idle,  The poster child for this
behavior is the ffmpeg benchmark in the Phoronix test suite.

Cc: <stable@vger.kernel.org> # 3.14.x
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index db8a992..c4dad16 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -58,6 +58,7 @@ struct sample {
 	u64 aperf;
 	u64 mperf;
 	int freq;
+	ktime_t time;
 };
 
 struct pstate_data {
@@ -93,6 +94,7 @@ struct cpudata {
 	struct vid_data vid;
 	struct _pid pid;
 
+	ktime_t last_sample_time;
 	u64	prev_aperf;
 	u64	prev_mperf;
 	struct sample sample;
@@ -576,6 +578,8 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 	aperf = aperf >> FRAC_BITS;
 	mperf = mperf >> FRAC_BITS;
 
+	cpu->last_sample_time = cpu->sample.time;
+	cpu->sample.time = ktime_get();
 	cpu->sample.aperf = aperf;
 	cpu->sample.mperf = mperf;
 	cpu->sample.aperf -= cpu->prev_aperf;
@@ -598,12 +602,24 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 
 static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
 {
-	int32_t core_busy, max_pstate, current_pstate;
+	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
+	u32 duration_us;
+	u32 sample_time;
 
 	core_busy = cpu->sample.core_pct_busy;
 	max_pstate = int_tofp(cpu->pstate.max_pstate);
 	current_pstate = int_tofp(cpu->pstate.current_pstate);
 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
+
+	sample_time = (pid_params.sample_rate_ms  * USEC_PER_MSEC);
+	duration_us = (u32) ktime_us_delta(cpu->sample.time,
+					cpu->last_sample_time);
+	if (duration_us > sample_time * 3) {
+		sample_ratio = div_fp(int_tofp(sample_time),
+				int_tofp(duration_us));
+		core_busy = mul_fp(core_busy, sample_ratio);
+	}
+
 	return core_busy;
 }
 
-- 
1.9.0

