From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: allow trace in passive mode
Date: Wed, 19 Apr 2017 14:16:17 -0700
Message-ID: <1492636577-8507-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35552 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966699AbdDSVQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 17:16:43 -0400
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

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 50 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 283491f..04e91ed 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2271,7 +2271,10 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	int target_pstate;
+	struct sample *sample;
+	int target_pstate, from;
+	u64 time;
+	bool sample_taken;
 
 	update_turbo_state();
 
@@ -2291,12 +2294,32 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
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
@@ -2306,13 +2329,36 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
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
