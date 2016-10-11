From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] cpufreq: CPPC: Correct desired_perf calculation
Date: Tue, 11 Oct 2016 14:12:00 -0700
Message-ID: <1476220320-19685-1-git-send-email-hotran@apm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35433 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbcJKVVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 17:21:18 -0400
Received: by mail-pa0-f54.google.com with SMTP id qn10so21101682pac.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 14:20:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, pprakash@codeaurora.org, Al Stone <ahs3@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>

The desired_perf is an abstract performance number. Its value should
be in the range of [lowest perf, highest perf] of CPPC.
The correct calculation is
  desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1b2f28f..ab1d4b7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -84,7 +84,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	cpu = all_cpu_data[policy->cpu];
 
-	cpu->perf_ctrls.desired_perf = (u64)target_freq * policy->max / cppc_dmi_max_khz;
+	cpu->perf_ctrls.desired_perf = (u64)target_freq * cpu->perf_caps.highest_perf / cppc_dmi_max_khz;
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-- 
1.9.1

