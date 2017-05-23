From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 1/8] sched/cpufreq_schedutil: make use of DEADLINE utilization signal
Date: Tue, 23 May 2017 09:53:44 +0100
Message-ID: <20170523085351.18586-2-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

SCHED_DEADLINE tracks active utilization signal with a per dl_rq
variable named running_bw.

Make use of that to drive cpu frequency selection: add up FAIR and
DEADLINE contribution to get the required CPU capacity to handle both
requirements (while RT still selects max frequency).

Co-authored-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched/cpufreq.h    |  2 --
 kernel/sched/cpufreq_schedutil.c | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2ccbb372..39640bb3a8ee 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -11,8 +11,6 @@
 #define SCHED_CPUFREQ_DL	(1U << 1)
 #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
 
-#define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
-
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 622eed1b7658..7f1913e265d1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -160,12 +160,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 static void sugov_get_util(unsigned long *util, unsigned long *max)
 {
 	struct rq *rq = this_rq();
-	unsigned long cfs_max;
+	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
-	*max = cfs_max;
+	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
@@ -229,7 +228,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (flags & SCHED_CPUFREQ_RT) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max);
@@ -269,7 +268,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 			j_sg_cpu->iowait_boost = 0;
 			continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
 		j_util = j_sg_cpu->util;
@@ -305,7 +304,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
+		if (flags & SCHED_CPUFREQ_RT)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu, time);
-- 
2.11.0
