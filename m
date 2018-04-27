From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH v4][for 4.17-rc3] cpufreq / CPPC: Set platform specific transition_delay_us
Date: Fri, 27 Apr 2018 11:35:27 -0600
Message-ID: <1524850527-31720-1-git-send-email-pprakash@codeaurora.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, Prashanth Prakash <pprakash@codeaurora.org>, "4.14+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add support to specify platform specific transition_delay_us instead
of using the transition delay derived from PCC.

With commit "3d41386d556d: cpufreq: CPPC: Use transition_delay_us
depending transition_latency" we are setting transition_delay_us
directly and not applying the LATENCY_MULTIPLIER. With this on Qualcomm
Centriq we can end up with a very high rate of frequency change requests
when using schedutil governor (default rate_limit_us=10 compared to an
earlier value of 10000).

The PCC subspace describes the rate at which the platform can accept
commands on the CPPC's PCC channel. This includes read and write
command on the PCC channel that can be used for reasons other than
frequency transitions. Moreover the same PCC subspace can be used by
multiple freq domains and deriving transition_delay_us from it as we do
now can be sub-optimal.

Moreover if a platform does not use PCC for desired_perf register then
there is no way to compute the transition latency or the delay_us.

CPPC does not have a standard defined mechanism to get the transition
rate or the latency at the moment.

Given the above limitations, it is simpler to have a platform specific
transition_delay_us and rely on PCC derived value only if a platform
specific value is not available.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: 4.14+ <stable@vger.kernel.org>
Fixes: 3d41386d556d ("cpufreq: CPPC: Use transition_delay_us depending
transition_latency)
---
v2:
* Return final delay_us from cppc_cpufreq_get_transition_delay_us (Viresh)
v3 and v4:
* code style changes (Viresh)
---
 drivers/cpufreq/cppc_cpufreq.c | 47 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bc5fc16..1b690f4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -126,6 +126,50 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
 }
 
+/*
+ * The PCC subspace describes the rate at which platform can accept commands
+ * on the shared PCC channel (including READs which do not count towards freq
+ * trasition requests), so ideally we need to use the PCC values as a fallback
+ * if we don't have a platform specific transition_delay_us
+ */
+#ifdef CONFIG_ARM64
+#include <asm/cputype.h>
+
+static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_num = read_cpuid_part_number();
+	unsigned int delay_us = 0;
+
+	switch (implementor) {
+	case ARM_CPU_IMP_QCOM:
+		switch (part_num) {
+		case QCOM_CPU_PART_FALKOR_V1:
+		case QCOM_CPU_PART_FALKOR:
+			delay_us = 10000;
+			break;
+		default:
+			delay_us = cppc_get_transition_latency(cpu) /
+				NSEC_PER_USEC;
+			break;
+		}
+		break;
+	default:
+		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+		break;
+	}
+
+	return delay_us;
+}
+
+#else
+
+static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+{
+	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+}
+#endif
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu;
@@ -162,8 +206,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		cpu->perf_caps.highest_perf;
 	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
 
-	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
-		NSEC_PER_USEC;
+	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
 	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
