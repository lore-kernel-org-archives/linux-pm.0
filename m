From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 8/9] intel_pstate: ignore scheduler cpufreq callbacks on remote CPUs
Date: Thu,  9 Mar 2017 17:15:18 +0530
Message-ID: <fdd9ba5de92726cc953d36c0a84f68dda5356dd3.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34420 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbdCILqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 06:46:05 -0500
Received: by mail-pg0-f52.google.com with SMTP id 77so25636370pgc.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2017 03:46:04 -0800 (PST)
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

From: Steve Muckle <smuckle.linux@gmail.com>

In preparation for the scheduler cpufreq callback happening on remote
CPUs, check for this case in intel_pstate which currently requires the
callback run on the local CPU. Such callbacks are ignored for now.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3d37219a0dd7..bd60f1cd7ea6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1930,6 +1930,9 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
+	if (smp_processor_id() != data->cpu)
+		return;
+
 	if (pstate_funcs.get_target_pstate == get_target_pstate_use_cpu_load) {
 		if (flags & SCHED_CPUFREQ_IOWAIT) {
 			cpu->iowait_boost = int_tofp(1);
-- 
2.7.1.410.g6faf27b
