From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization signals
Date: Tue, 23 May 2017 09:53:47 +0100
Message-ID: <20170523085351.18586-5-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

To be able to treat utilization signals of different scheduling classes
in different ways (e.g., CFS signal might be stale while DEADLINE signal
is never stale by design) we need to split sugov_cpu::util signal in two:
util_cfs and util_dl.

This patch does that by also changing sugov_get_util() parameter list.
After this change aggregation of the different signals has to be performed
by sugov_get_util() users (so that they can decide what to do with the
different signals).

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1508109c7f19..f930cec4c3d4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -58,7 +58,8 @@ struct sugov_cpu {
 	u64 last_update;
 
 	/* The fields below are only needed when sharing a policy. */
-	unsigned long util;
+	unsigned long util_cfs;
+	unsigned long util_dl;
 	unsigned long max;
 	unsigned int flags;
 
@@ -157,14 +158,13 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = this_rq();
-	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
 
-	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
-
-	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
+	sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	sg_cpu->util_cfs = rq->cfs.avg.util_avg;
+	sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
@@ -231,7 +231,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(sg_cpu);
+		max = sg_cpu->max;
+		util = min(sg_cpu->util_cfs + sg_cpu->util_dl, max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
@@ -271,8 +273,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
-		j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
+		j_util = min(j_sg_cpu->util_cfs + j_sg_cpu->util_dl, j_max);
 		if (j_util * max > j_max * util) {
 			util = j_util;
 			max = j_max;
@@ -289,15 +291,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sg_cpu->util = util;
-	sg_cpu->max = max;
+	sugov_get_util(sg_cpu);
 	sg_cpu->flags = flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
-- 
2.11.0
