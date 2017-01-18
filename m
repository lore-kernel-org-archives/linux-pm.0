From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] cpufreq: intel_pstate: Lower frequency than expected under no_turbo
Date: Wed, 18 Jan 2017 10:48:23 -0800
Message-ID: <1484765305-185352-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22799 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbdARSuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Jan 2017 13:50:02 -0500
In-Reply-To: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When turbo is not disabled by BIOS, but user disabled from intel P-State
sysfs and changes max/min using cpufreq sysfs, the resultant frequency
is lower than what user requested.

The reason for this, when the perf limits are calculated in set_policy()
callback, they are with reference to max cpu frequency (turbo frequency
), but when enforced in the intel_pstate_get_min_max() they are with
reference to max available performance as documented in the intel_pstate
documentation (in this case max non turbo P-State).

This needs similar change as done in intel_cpufreq_verify_policy() for
passive mode. Set policy->cpuinfo.max_freq based on the turbo status.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a54d65a..a5f1a04 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2042,6 +2042,20 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
 {
+	struct cpudata *cpu = all_cpu_data[policy->cpu];
+	struct perf_limits *perf_limits;
+
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
+		perf_limits = &performance_limits;
+	else
+		perf_limits = &powersave_limits;
+
+	update_turbo_state();
+	policy->cpuinfo.max_freq = perf_limits->turbo_disabled ||
+					perf_limits->no_turbo ?
+					cpu->pstate.max_freq :
+					cpu->pstate.turbo_freq;
+
 	cpufreq_verify_within_cpu_limits(policy);
 
 	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
-- 
2.7.4

