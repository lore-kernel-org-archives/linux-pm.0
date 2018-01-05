From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH V3] cpufreq: intel_pstate: allow trace in passive mode
Date: Fri,  5 Jan 2018 12:17:10 -0800
Message-ID: <1515183430-7646-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42583 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeAEURw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 15:17:52 -0500
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

Sometimes, in passive mode, the driver is not called for
many tens or even hundreds of seconds. The user
needs to understand, and not be confused by, this limitation.

V3: Move largely duplicate code to a subroutine, as per
feedback from V2.

V2: prepare for resend. Rebase to current kernel, 4.15-rc3.
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a0e88..2bb922e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1943,13 +1943,38 @@ static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void intel_cpufreq_trace(struct cpudata *cpu, int fast, int from)
+{
+	struct sample *sample;
+	u64 time;
+
+	time = ktime_get();
+	if (intel_pstate_sample(cpu, time)) {
+		sample = &cpu->sample;
+		/* In passvie mode the trace core_busy field is
+		 * re-assigned to indicate if the driver call
+		 * was via the normal or fast switch path.
+		 * The scaled_busy field is not used, set to 0.
+		 */
+		trace_pstate_sample(fast,
+			0,
+			from,
+			cpu->pstate.current_pstate,
+			sample->mperf,
+			sample->aperf,
+			sample->tsc,
+			get_avg_frequency(cpu),
+			fp_toint(cpu->iowait_boost * 100));
+	}
+}
+
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	int target_pstate;
+	int target_pstate, from;
 
 	update_turbo_state();
 
@@ -1969,12 +1994,14 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 		break;
 	}
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	from = cpu->pstate.current_pstate;
 	if (target_pstate != cpu->pstate.current_pstate) {
 		cpu->pstate.current_pstate = target_pstate;
 		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 	}
 	freqs.new = target_pstate * cpu->pstate.scaling;
+	intel_cpufreq_trace(cpu, 0, from);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -1984,13 +2011,15 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	int target_pstate;
+	int target_pstate, from;
 
 	update_turbo_state();
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	from = cpu->pstate.current_pstate;
 	intel_pstate_update_pstate(cpu, target_pstate);
+	intel_cpufreq_trace(cpu, 100, from);
 	return target_pstate * cpu->pstate.scaling;
 }
 
-- 
2.7.4
