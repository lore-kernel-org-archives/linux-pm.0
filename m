From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC v2] ACPI: Update cpuinfo.max after bootup if necessary
Date: Fri,  1 Mar 2019 02:08:02 +0800
Message-ID: <bd3c5e04e882e5a4c977211a8d268440b36276a4.1551375162.git.yu.c.chen@intel.com>
References: <cover.1551375162.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551375162.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yu.chen.surf@gmail.com, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

On Dell Inc. XPS13 9333, the BIOS changes the value of
MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
the power source changes), the maximum frequency of the
CPU is not updated accordingly. This is due to the policy's
cpuinfo.max is not updated when _PPC notifier fires.

Fix this problem by updating the policy's cpuinfo.max when
necessary.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq.c      |  2 ++
 drivers/cpufreq/intel_pstate.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..95e08816b512 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
+	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
 	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..841c74f69f66 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2081,11 +2081,17 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
 
 static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
+	int max_freq;
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
+	max_freq = intel_pstate_get_max_freq(cpu);
+
+	if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
+		policy->cpuinfo.max_freq = policy->max = max_freq;
+
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
+				     max_freq);
 
 	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
 	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)
@@ -2192,11 +2198,16 @@ static struct cpufreq_driver intel_pstate = {
 
 static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
 {
+	int max_freq;
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
+	max_freq = intel_pstate_get_max_freq(cpu);
+
+	if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
+		policy->cpuinfo.max_freq = policy->max = max_freq;
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
+				     max_freq);
 
 	intel_pstate_adjust_policy_max(policy, cpu);
 
-- 
2.17.1
