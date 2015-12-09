From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv6 PATCH 07/10] sched/fair: jump to max OPP when crossing UP threshold
Date: Tue,  8 Dec 2015 22:19:28 -0800
Message-ID: <1449641971-20827-8-git-send-email-smuckle@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Since the true utilization of a long running task is not detectable
while it is running and might be bigger than the current cpu capacity,
create the maximum cpu capacity head room by requesting the maximum
cpu capacity once the cpu usage plus the capacity margin exceeds the
current capacity. This is also done to try to harm the performance of
a task the least.

Original fair-class only version authored by Juri Lelli
<juri.lelli@arm.com>.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/core.c  | 41 ++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 57 --------------------------------------------------
 kernel/sched/sched.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4c8c353e..3f4d907 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2869,6 +2869,45 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+#ifdef CONFIG_CPU_FREQ_GOV_SCHED
+static unsigned long sum_capacity_reqs(unsigned long cfs_cap,
+				       struct sched_capacity_reqs *scr)
+{
+	unsigned long total = cfs_cap + scr->rt;
+
+	total = total * capacity_margin;
+	total /= SCHED_CAPACITY_SCALE;
+	total += scr->dl;
+	return total;
+}
+
+static void sched_freq_tick(int cpu)
+{
+	struct sched_capacity_reqs *scr;
+	unsigned long capacity_orig, capacity_curr;
+
+	if (!sched_freq())
+		return;
+
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_curr = capacity_curr_of(cpu);
+	if (capacity_curr == capacity_orig)
+		return;
+
+	/*
+	 * To make free room for a task that is building up its "real"
+	 * utilization and to harm its performance the least, request
+	 * a jump to max OPP as soon as the margin of free capacity is
+	 * impacted (specified by capacity_margin).
+	 */
+	scr = &per_cpu(cpu_sched_capacity_reqs, cpu);
+	if (capacity_curr < sum_capacity_reqs(cpu_util(cpu), scr))
+		set_cfs_cpu_capacity(cpu, true, capacity_max);
+}
+#else
+static inline void sched_freq_tick(int cpu) { }
+#endif
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -2895,6 +2934,8 @@ void scheduler_tick(void)
 	trigger_load_balance(rq);
 #endif
 	rq_last_tick_reset(rq);
+
+	sched_freq_tick(cpu);
 }
 
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 880ceee..4c49f76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4199,9 +4199,6 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
-static unsigned long capacity_orig_of(int cpu);
-static int cpu_util(int cpu);
-
 static void update_capacity_of(int cpu)
 {
 	unsigned long req_cap;
@@ -4601,15 +4598,6 @@ static unsigned long target_load(int cpu, int type)
 	return max(rq->cpu_load[type-1], total);
 }
 
-static unsigned long capacity_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity;
-}
-
-static unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
 
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
@@ -4779,17 +4767,6 @@ static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
 #endif
 
 /*
- * Returns the current capacity of cpu after applying both
- * cpu and freq scaling.
- */
-static unsigned long capacity_curr_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig *
-	       arch_scale_freq_capacity(NULL, cpu)
-	       >> SCHED_CAPACITY_SHIFT;
-}
-
-/*
  * Detect M:N waker/wakee relationships via a switching-frequency heuristic.
  * A waker of many should wake a different task than the one last awakened
  * at a frequency roughly N times higher than one of its wakees.  In order
@@ -5033,40 +5010,6 @@ done:
 }
 
 /*
- * cpu_util returns the amount of capacity of a CPU that is used by CFS
- * tasks. The unit of the return value must be the one of capacity so we can
- * compare the utilization with the capacity of the CPU that is available for
- * CFS task (ie cpu_capacity).
- *
- * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
- * recent utilization of currently non-runnable tasks on a CPU. It represents
- * the amount of utilization of a CPU in the range [0..capacity_orig] where
- * capacity_orig is the cpu_capacity available at the highest frequency
- * (arch_scale_freq_capacity()).
- * The utilization of a CPU converges towards a sum equal to or less than the
- * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
- * the running time on this CPU scaled by capacity_curr.
- *
- * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
- * higher than capacity_orig because of unfortunate rounding in
- * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
- * the average stabilizes with the new running time. We need to check that the
- * utilization stays within the range of [0..capacity_orig] and cap it if
- * necessary. Without utilization capping, a group could be seen as overloaded
- * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
- * available capacity. We allow utilization to overshoot capacity_curr (but not
- * capacity_orig) as it useful for predicting the capacity required after task
- * migrations (scheduler-driven DVFS).
- */
-static int cpu_util(int cpu)
-{
-	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
-	unsigned long capacity = capacity_orig_of(cpu);
-
-	return (util >= capacity) ? capacity : util;
-}
-
-/*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ad82274..90d5df6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1384,7 +1384,66 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 }
 #endif
 
+#ifdef CONFIG_SMP
+static inline unsigned long capacity_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity;
+}
+
+static inline unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+
+/*
+ * cpu_util returns the amount of capacity of a CPU that is used by CFS
+ * tasks. The unit of the return value must be the one of capacity so we can
+ * compare the utilization with the capacity of the CPU that is available for
+ * CFS task (ie cpu_capacity).
+ *
+ * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
+ * recent utilization of currently non-runnable tasks on a CPU. It represents
+ * the amount of utilization of a CPU in the range [0..capacity_orig] where
+ * capacity_orig is the cpu_capacity available at the highest frequency
+ * (arch_scale_freq_capacity()).
+ * The utilization of a CPU converges towards a sum equal to or less than the
+ * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
+ * the running time on this CPU scaled by capacity_curr.
+ *
+ * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
+ * higher than capacity_orig because of unfortunate rounding in
+ * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
+ * the average stabilizes with the new running time. We need to check that the
+ * utilization stays within the range of [0..capacity_orig] and cap it if
+ * necessary. Without utilization capping, a group could be seen as overloaded
+ * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
+ * available capacity. We allow utilization to overshoot capacity_curr (but not
+ * capacity_orig) as it useful for predicting the capacity required after task
+ * migrations (scheduler-driven DVFS).
+ */
+static inline int cpu_util(int cpu)
+{
+	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
+	unsigned long capacity = capacity_orig_of(cpu);
+
+	return (util >= capacity) ? capacity : util;
+}
+
+/*
+ * Returns the current capacity of cpu after applying both
+ * cpu and freq scaling.
+ */
+static inline unsigned long capacity_curr_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig *
+	       arch_scale_freq_capacity(NULL, cpu)
+	       >> SCHED_CAPACITY_SHIFT;
+}
+
+#endif
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHED
+#define capacity_max SCHED_CAPACITY_SCALE
 extern unsigned int capacity_margin;
 extern struct static_key __sched_freq;
 
-- 
2.4.10
