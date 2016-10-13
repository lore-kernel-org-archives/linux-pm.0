From: Hoan Tran <hotran@apm.com>
Subject: [PATCH v2] cpufreq: CPPC: Correct desired_perf calculation
Date: Thu, 13 Oct 2016 10:33:35 -0700
Message-ID: <1476380015-21001-1-git-send-email-hotran@apm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35021 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934248AbcJMRmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 13:42:05 -0400
Received: by mail-pf0-f175.google.com with SMTP id s8so37900013pfj.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2016 10:40:47 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, pprakash@codeaurora.org, Al Stone <ahs3@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>

The desired_perf is an abstract performance number. Its value should
be in the range of [lowest perf, highest perf] of CPPC.
The correct calculation is
  desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz

And cppc_cpufreq_set_target() returns if desired_perf is exactly
the same with the old perf.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
v2
 * Return if desired_perf is the same with the old one (Prashanth's suggestion)


 drivers/cpufreq/cppc_cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1b2f28f..4852d9e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -80,11 +80,17 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 {
 	struct cppc_cpudata *cpu;
 	struct cpufreq_freqs freqs;
+	u32 desired_perf;
 	int ret = 0;
 
 	cpu = all_cpu_data[policy->cpu];
 
-	cpu->perf_ctrls.desired_perf = (u64)target_freq * policy->max / cppc_dmi_max_khz;
+	desired_perf = (u64)target_freq * cpu->perf_caps.highest_perf / cppc_dmi_max_khz;
+	/* Return if it is exactly the same perf */
+	if (desired_perf == cpu->perf_ctrls.desired_perf)
+		return ret;
+
+	cpu->perf_ctrls.desired_perf = desired_perf;
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-- 
1.9.1

