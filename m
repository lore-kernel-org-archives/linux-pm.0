From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 5/5] sched/{core,cpufreq_schedutil}: add capacity clamping for RT/DL tasks
Date: Tue, 28 Feb 2017 14:38:42 +0000
Message-ID: <1488292722-19410-6-git-send-email-patrick.bellasi@arm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdB1Ot3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Feb 2017 09:49:29 -0500
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Currently schedutil enforce a maximum OPP when RT/DL tasks are RUNNABLE.
Such a mandatory policy can be made more tunable from userspace thus
allowing for example to define a reasonable max capacity (i.e.
frequency) which is required for the execution of a specific RT/DL
workload. This will contribute to make the RT class more "friendly" for
power/energy sensible applications.

This patch extends the usage of capacity_{min,max} to the RT/DL classes.
Whenever a task in these classes is RUNNABLE, the capacity required is
defined by the constraints of the control group that task belongs to.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 51484f7..18abd62 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -256,7 +256,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		return;
 
 	if (flags & SCHED_CPUFREQ_RT_DL) {
-		next_f = policy->cpuinfo.max_freq;
+		util = cap_clamp_cpu_util(smp_processor_id(),
+					  SCHED_CAPACITY_SCALE);
+		next_f = get_next_freq(sg_cpu, util, policy->cpuinfo.max_freq);
 	} else {
 		sugov_get_util(&util, &max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
@@ -272,15 +274,11 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
 	unsigned int cap_max = SCHED_CAPACITY_SCALE;
 	unsigned int cap_min = 0;
 	unsigned int j;
 
-	if (flags & SCHED_CPUFREQ_RT_DL)
-		return max_f;
-
 	sugov_iowait_boost(sg_cpu, &util, &max);
 
 	/* Initialize clamping range based on caller CPU constraints */
@@ -308,10 +306,11 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 			j_sg_cpu->iowait_boost = 0;
 			continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
-			return max_f;
 
-		j_util = j_sg_cpu->util;
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+			j_util = cap_clamp_cpu_util(j, SCHED_CAPACITY_SCALE);
+		else
+			j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
 		if (j_util * max > j_max * util) {
 			util = j_util;
-- 
2.7.4
