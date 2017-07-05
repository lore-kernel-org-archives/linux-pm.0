From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v1 1/8] sched/cpufreq_schedutil: make use of DEADLINE utilization signal
Date: Wed,  5 Jul 2017 09:58:58 +0100
Message-ID: <20170705085905.6558-2-juri.lelli@arm.com>
References: <20170705085905.6558-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705085905.6558-1-juri.lelli@arm.com>
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
Changes from RFCv0:

 - use BW_SHIFT (Peter)
 - add comment about guaranteed and requested freq (Peter)
 - modify comment about go to max behaviour (Claudio)
---
 include/linux/sched/cpufreq.h    |  2 --
 kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

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
index 076a2e31951c..f2494d1fc8ef 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -157,12 +157,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 static void sugov_get_util(unsigned long *util, unsigned long *max)
 {
 	struct rq *rq = this_rq();
-	unsigned long cfs_max;
+	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
+				>> BW_SHIFT;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
-	*max = cfs_max;
+	/*
+	 * Ideally we would like to set util_dl as min/guaranteed freq and
+	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
+	 * ready for such an interface. So, we only do the latter for now.
+	 */
+	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
@@ -226,7 +231,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (flags & SCHED_CPUFREQ_RT) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max);
@@ -266,7 +271,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 			j_sg_cpu->iowait_boost = 0;
 			continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
 		j_util = j_sg_cpu->util;
@@ -302,7 +307,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
+		if (flags & SCHED_CPUFREQ_RT)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu, time);
@@ -332,9 +337,9 @@ static void sugov_irq_work(struct irq_work *irq_work)
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
 	/*
-	 * For RT and deadline tasks, the schedutil governor shoots the
-	 * frequency to maximum. Special care must be taken to ensure that this
-	 * kthread doesn't result in the same behavior.
+	 * For RT tasks, the schedutil governor shoots the frequency to maximum.
+	 * Special care must be taken to ensure that this kthread doesn't result
+	 * in the same behavior.
 	 *
 	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
 	 * updated only at the end of the sugov_work() function and before that
-- 
2.11.0
