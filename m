From: Doug Smythies <doug.smythies@gmail.com>
Subject: [Resend][PATCH V2] cpufreq: intel_pstate: allow trace in passive mode
Date: Fri, 15 Dec 2017 16:43:00 -0800
Message-ID: <1513384980-3428-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42788 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbdLPAnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 19:43:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Allow use of the trace_pstate_sample trace function
when the intel_pstate driver is in passive mode.
Since the core_busy and scaled_busy fields are not
used, and it might be desirable to know which path
through the driver was used, either intel_cpufreq_target
or intel_cpufreq_fast_switch, re-task the core_busy
field as a flag indicator.

The user can then use the intel_pstate_tracer.py utility
to summarize and plot the trace.

In Passive mode the driver is only called if there is
a need to change the target frequency, so durations
(time gaps between calls) can be very very long. The user
needs to understand, and not be confused by, this limitation.

V2: prepare for resend. Rebase to current kernel, 4.15-rc3.
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 50 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a0e88..fe25d69 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1949,7 +1949,10 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	int target_pstate;
+	struct sample *sample;
+	int target_pstate, from;
+	u64 time;
+	bool sample_taken;
 
 	update_turbo_state();
 
@@ -1969,12 +1972,32 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 		break;
 	}
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+
+	from = cpu->pstate.current_pstate;
+	time = ktime_get();
+	sample_taken = intel_pstate_sample(cpu, time);
+
 	if (target_pstate != cpu->pstate.current_pstate) {
 		cpu->pstate.current_pstate = target_pstate;
 		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 	}
 	freqs.new = target_pstate * cpu->pstate.scaling;
+
+	if (sample_taken) {
+		intel_pstate_calc_avg_perf(cpu);
+		sample = &cpu->sample;
+		trace_pstate_sample(0,
+		0,
+		from,
+		cpu->pstate.current_pstate,
+		sample->mperf,
+		sample->aperf,
+		sample->tsc,
+		get_avg_frequency(cpu),
+		fp_toint(cpu->iowait_boost * 100));
+	}
+
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -1984,13 +2007,36 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	int target_pstate;
+	struct sample *sample;
+	int target_pstate, from;
+	u64 time;
+	bool sample_taken;
 
 	update_turbo_state();
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+
+	from = cpu->pstate.current_pstate;
+	time = ktime_get();
+	sample_taken = intel_pstate_sample(cpu, time);
+
 	intel_pstate_update_pstate(cpu, target_pstate);
+
+	if (sample_taken) {
+		intel_pstate_calc_avg_perf(cpu);
+		sample = &cpu->sample;
+		trace_pstate_sample(100,
+		0,
+		from,
+		cpu->pstate.current_pstate,
+		sample->mperf,
+		sample->aperf,
+		sample->tsc,
+		get_avg_frequency(cpu),
+		fp_toint(cpu->iowait_boost * 100));
+	}
+
 	return target_pstate * cpu->pstate.scaling;
 }
 
-- 
2.7.4
