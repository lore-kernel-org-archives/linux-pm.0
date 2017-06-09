From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: intel_pstate: Provide resolve_freq() to fix regression
Date: Fri,  9 Jun 2017 15:45:56 +0530
Message-ID: <eb1c4db95f52dbd4014438b901cc21dd693df005.1497002895.git.viresh.kumar@linaro.org>
References: <cover.1497002895.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497002895.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1497002895.git.viresh.kumar@linaro.org>
References: <cover.1497002895.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, patrick.bellasi@arm.com, john.ettedgui@gmail.com, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

When the schedutil governor calls cpufreq_driver_resolve_freq() for the
intel_pstate (in passive mode) driver, it simply returns the requested
frequency as there is no ->resolve_freq() callback provided.

The result is that get_next_freq() doesn't get a chance to know the
frequency which will be set eventually and we can hit a potential
regression as explained in the following paragraph.

For example, consider the possible range of frequencies as 900 MHz, 1
GHz, 1.1 GHz, and 1.2 GHz. If the current frequency is 1.1 GHz and the
next frequency (based on current utilization) is 1 GHz, then the
schedutil governor will try to set the average of these as the next
frequency (i.e. 1.05 GHz).

Because we always try to find the lowest frequency greater than equal to
the target frequency, the intel_pstate driver will end up setting the
frequency as 1.1 GHz.

Though the sg_policy->next_freq field gets updated with the average
frequency only. And so we will finally select the min frequency when the
next_freq is 1 more than the min frequency as the average then will be
equal to the min frequency. But that will also take lots of iterations
of the schedutil update callbacks.

Fix that by providing a resolve_freq() callback.

Tested on desktop with Intel Skylake processors.

Fixes: 39b64aa1c007 ("cpufreq: schedutil: Reduce frequencies slower")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 029a93bfb558..e177352180c3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2213,6 +2213,19 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+unsigned int intel_cpufreq_resolve_freq(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	int target_pstate;
+
+	update_turbo_state();
+
+	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	return target_pstate * cpu->pstate.scaling;
+}
+
 static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
@@ -2246,6 +2259,7 @@ static struct cpufreq_driver intel_cpufreq = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_cpufreq_verify_policy,
 	.target		= intel_cpufreq_target,
+	.resolve_freq	= intel_cpufreq_resolve_freq,
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-- 
2.13.0.70.g6367777092d9
