From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 4/5] sched/{core,cpufreq_schedutil}: add capacity clamping for FAIR tasks
Date: Tue, 28 Feb 2017 14:38:41 +0000
Message-ID: <1488292722-19410-5-git-send-email-patrick.bellasi@arm.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdB1Ot3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Feb 2017 09:49:29 -0500
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Each time a frequency update is required via schedutil, we must grant
the capacity_{min,max} constraints enforced in the current CPU by the
set of currently RUNNABLE tasks.

This patch adds the required support to clamp the utilization generated
by FAIR tasks within the boundaries defined by the current constraints.
The clamped utilization is ultimately used to select the frequency
thus allowing both to:
 - boost small tasks
   by running them at least at a minimum granted capacity (i.e. frequency)
 - cap background tasks
   by running them only up to a maximum granted capacity (i.e. frequency)

The default values for boosting and capping are defined to be:
 - capacity_min: 0
 - capacity_max: SCHED_CAPACITY_SCALE
which means that by default no boosting/capping is enforced.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index fd46593..51484f7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -192,6 +192,54 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 	sg_cpu->iowait_boost >>= 1;
 }
 
+#ifdef CONFIG_CAPACITY_CLAMPING
+
+static inline
+void cap_clamp_cpu_range(unsigned int cpu, unsigned int *cap_min,
+			 unsigned int *cap_max)
+{
+	struct cap_clamp_cpu *cgc;
+
+	*cap_min = 0;
+	cgc = &cpu_rq(cpu)->cap_clamp_cpu[CAP_CLAMP_MIN];
+	if (cgc->node)
+		*cap_min = cgc->value;
+
+	*cap_max = SCHED_CAPACITY_SCALE;
+	cgc = &cpu_rq(cpu)->cap_clamp_cpu[CAP_CLAMP_MAX];
+	if (cgc->node)
+		*cap_max = cgc->value;
+}
+
+static inline
+unsigned int cap_clamp_cpu_util(unsigned int cpu, unsigned int util)
+{
+	unsigned int cap_max, cap_min;
+
+	cap_clamp_cpu_range(cpu, &cap_min, &cap_max);
+	return clamp(util, cap_min, cap_max);
+}
+
+static inline
+void cap_clamp_compose(unsigned int *cap_min, unsigned int *cap_max,
+		       unsigned int j_cap_min, unsigned int j_cap_max)
+{
+	*cap_min = max(*cap_min, j_cap_min);
+	*cap_max = max(*cap_max, j_cap_max);
+}
+
+#define cap_clamp_util_range(util, cap_min, cap_max) \
+	clamp_t(typeof(util), util, cap_min, cap_max)
+
+#else
+
+#define cap_clamp_cpu_range(cpu, cap_min, cap_max) { }
+#define cap_clamp_cpu_util(cpu, util) util
+#define cap_clamp_compose(cap_min, cap_max, j_cap_min, j_cap_max) { }
+#define cap_clamp_util_range(util, cap_min, cap_max) util
+
+#endif /* CONFIG_CAPACITY_CLAMPING */
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
@@ -212,6 +260,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	} else {
 		sugov_get_util(&util, &max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
+		util = cap_clamp_cpu_util(smp_processor_id(), util);
 		next_f = get_next_freq(sg_cpu, util, max);
 	}
 	sugov_update_commit(sg_policy, time, next_f);
@@ -225,6 +274,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int max_f = policy->cpuinfo.max_freq;
 	u64 last_freq_update_time = sg_policy->last_freq_update_time;
+	unsigned int cap_max = SCHED_CAPACITY_SCALE;
+	unsigned int cap_min = 0;
 	unsigned int j;
 
 	if (flags & SCHED_CPUFREQ_RT_DL)
@@ -232,9 +283,13 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 
 	sugov_iowait_boost(sg_cpu, &util, &max);
 
+	/* Initialize clamping range based on caller CPU constraints */
+	cap_clamp_cpu_range(smp_processor_id(), &cap_min, &cap_max);
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu;
 		unsigned long j_util, j_max;
+		unsigned int j_cap_max, j_cap_min;
 		s64 delta_ns;
 
 		if (j == smp_processor_id())
@@ -264,8 +319,21 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
 		}
 
 		sugov_iowait_boost(j_sg_cpu, &util, &max);
+
+		/*
+		 * Update clamping range based on this CPU constraints, but
+		 * only if this CPU is not currently idle. Idle CPUs do not
+		 * enforce constraints in a shared frequency domain.
+		 */
+		if (!idle_cpu(j)) {
+			cap_clamp_cpu_range(j, &j_cap_min, &j_cap_max);
+			cap_clamp_compose(&cap_min, &cap_max,
+					  j_cap_min, j_cap_max);
+		}
 	}
 
+	/* Clamp utilization on aggregated CPUs ranges */
+	util = cap_clamp_util_range(util, cap_min, cap_max);
 	return get_next_freq(sg_cpu, util, max);
 }
 
-- 
2.7.4
