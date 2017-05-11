From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] cpufreq / CPPC: Initialize policy->min to lowest nonlinear performance
Date: Thu, 11 May 2017 16:39:44 -0600
Message-ID: <1494542384-7502-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdEKWkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 18:40:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, ahs3@redhat.com, hotran@apm.com, alexey.klimov@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

Description of Lowest Perfomance in ACPI 6.1 specification states:
"Lowest Performance is the absolute lowest performance level of
the platform. Selecting a performance level lower than the lowest
nonlinear performance level may actually cause an efficiency penalty,
but should reduce the instantaneous power consumption of the processor.
In traditional terms, this represents the T-state range of performance
levels."

Set the default value of policy->min to Lowest Nonlinear Performance
to avoid any potential efficiency penalty.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e82bb3c..10be285 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -144,10 +144,23 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cppc_dmi_max_khz = cppc_get_dmi_max_khz();
 
-	policy->min = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz / cpu->perf_caps.highest_perf;
+	/*
+	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
+	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
+	 */
+	policy->min = cpu->perf_caps.lowest_nonlinear_perf * cppc_dmi_max_khz /
+		cpu->perf_caps.highest_perf;
 	policy->max = cppc_dmi_max_khz;
-	policy->cpuinfo.min_freq = policy->min;
-	policy->cpuinfo.max_freq = policy->max;
+
+	/*
+	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
+	 * available if userspace wants to use any perf between lowest & lowest
+	 * nonlinear perf
+	 */
+	policy->cpuinfo.min_freq = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz /
+		cpu->perf_caps.highest_perf;
+	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
+
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
 	policy->shared_type = cpu->shared_type;
 
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
