From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/4] intel_pstate: Ignore scheduler cpufreq callbacks on remote CPUs
Date: Thu, 29 Jun 2017 10:56:32 +0530
Message-ID: <a33ba3746dacce67a7c2e17b64e54ee89f64a3bc.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34714 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdF2F2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:28:03 -0400
Received: by mail-pf0-f170.google.com with SMTP id s66so44500641pfs.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2017 22:28:02 -0700 (PDT)
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

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
index 4ce501148790..7a2a8ee579ef 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1755,6 +1755,9 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
+	if (smp_processor_id() != data->cpu)
+		return;
+
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		cpu->iowait_boost = int_tofp(1);
 	} else if (cpu->iowait_boost) {
-- 
2.13.0.71.gd7076ec9c9cb
