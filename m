From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 5/8] sched/cpufreq: pass sched class into cpufreq_update_util
Date: Sun, 13 Mar 2016 22:22:09 -0700
Message-ID: <1457932932-28444-6-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

cpufreq_update_util() accepts a single utilization value which  does not
account for multiple utilization contributions from the cfs, rt & dl
scheduler classes. Begin fixing this by adding a sched_class argument to
cpufreq_update_util(), all of its call sites and the governor-specific
hooks in intel_pstate.c, cpufreq_schedutil.c and cpufreq_governor.c.

A follow-on patch will add summation of the sched_class contributions to
the schedutil governor.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 drivers/cpufreq/cpufreq_governor.c  |  5 +++--
 drivers/cpufreq/cpufreq_schedutil.c |  6 ++++--
 drivers/cpufreq/intel_pstate.c      |  5 +++--
 include/linux/sched.h               | 16 +++++++++++++---
 kernel/sched/cpufreq.c              | 11 +++++++----
 kernel/sched/deadline.c             |  2 +-
 kernel/sched/fair.c                 |  2 +-
 kernel/sched/rt.c                   |  2 +-
 kernel/sched/sched.h                |  8 +++++---
 9 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 148576c..4694751 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -248,8 +248,9 @@ static void dbs_irq_work(struct irq_work *irq_work)
 	schedule_work(&policy_dbs->work);
 }
 
-static void dbs_freq_update_handler(struct freq_update_hook *hook, u64 time,
-				    unsigned long util_not_used,
+static void dbs_freq_update_handler(struct freq_update_hook *hook,
+				    enum sched_class_util sc_not_used,
+				    u64 time, unsigned long util_not_used,
 				    unsigned long max_not_used)
 {
 	struct cpu_dbs_info *cdbs = container_of(hook, struct cpu_dbs_info, update_hook);
diff --git a/drivers/cpufreq/cpufreq_schedutil.c b/drivers/cpufreq/cpufreq_schedutil.c
index 12e49b9..18d9ca3 100644
--- a/drivers/cpufreq/cpufreq_schedutil.c
+++ b/drivers/cpufreq/cpufreq_schedutil.c
@@ -106,7 +106,8 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 	trace_cpu_frequency(freq, smp_processor_id());
 }
 
-static void sugov_update_single(struct freq_update_hook *hook, u64 time,
+static void sugov_update_single(struct freq_update_hook *hook,
+				enum sched_class_util sc, u64 time,
 				unsigned long util, unsigned long max)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
@@ -166,7 +167,8 @@ static unsigned int sugov_next_freq(struct sugov_policy *sg_policy,
 	return  util * max_f / max;
 }
 
-static void sugov_update_shared(struct freq_update_hook *hook, u64 time,
+static void sugov_update_shared(struct freq_update_hook *hook,
+				enum sched_class_util sc, u64 time,
 				unsigned long util, unsigned long max)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_hook);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 20e2bb2..86aa368 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1020,8 +1020,9 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 		sample->freq);
 }
 
-static void intel_pstate_freq_update(struct freq_update_hook *hook, u64 time,
-				     unsigned long util_not_used,
+static void intel_pstate_freq_update(struct freq_update_hook *hook,
+				     enum sched_class_util sc_not_used
+				     u64 time, unsigned long util_not_used,
 				     unsigned long max_not_used)
 {
 	struct cpudata *cpu = container_of(hook, struct cpudata, update_hook);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f18a99b..1c7d7bd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2362,15 +2362,25 @@ extern u64 scheduler_tick_max_deferment(void);
 static inline bool sched_can_stop_tick(void) { return false; }
 #endif
 
+enum sched_class_util {
+	cfs_util,
+	rt_util,
+	dl_util,
+	nr_util_types,
+};
+
 #ifdef CONFIG_CPU_FREQ
 struct freq_update_hook {
-	void (*func)(struct freq_update_hook *hook, u64 time,
+	void (*func)(struct freq_update_hook *hook,
+		     enum sched_class_util sched_class, u64 time,
 		     unsigned long util, unsigned long max);
 };
 
 void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
-			void (*func)(struct freq_update_hook *hook, u64 time,
-				     unsigned long util, unsigned long max));
+			void (*func)(struct freq_update_hook *hook,
+				     enum sched_class_util sched_class,
+				     u64 time, unsigned long util,
+				     unsigned long max));
 void cpufreq_clear_freq_update_hook(int cpu);
 unsigned long cpufreq_get_cfs_capacity_margin(void);
 void cpufreq_set_cfs_capacity_margin(unsigned long margin);
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index a126b58..87f99a6 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -39,8 +39,10 @@ static void set_freq_update_hook(int cpu, struct freq_update_hook *hook)
  * @func: Callback function to use with the new hook.
  */
 void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
-			void (*func)(struct freq_update_hook *hook, u64 time,
-				     unsigned long util, unsigned long max))
+			void (*func)(struct freq_update_hook *hook,
+				     enum sched_class_util sched_class,
+				     u64 time, unsigned long util,
+				     unsigned long max))
 {
 	if (WARN_ON(!hook || !func))
 		return;
@@ -124,7 +126,8 @@ EXPORT_SYMBOL_GPL(cpufreq_reset_cfs_capacity_margin);
  *
  * It can only be called from RCU-sched read-side critical sections.
  */
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+void cpufreq_update_util(enum sched_class_util sc, u64 time,
+			 unsigned long util, unsigned long max)
 {
 	struct freq_update_hook *hook;
 
@@ -138,5 +141,5 @@ void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
 	 * may become NULL after the check below.
 	 */
 	if (hook)
-		hook->func(hook, time, util, max);
+		hook->func(hook, sc, time, util, max);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3fd5bc4..d88ed3f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -728,7 +728,7 @@ static void update_curr_dl(struct rq *rq)
 
 	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_update_util(rq_clock(rq), ULONG_MAX, 0);
+		cpufreq_update_util(dl_util, rq_clock(rq), ULONG_MAX, 0);
 
 	/*
 	 * Consumed budget is computed considering the time as
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 29e8bae..6b454bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2867,7 +2867,7 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
 		 * thread is a different class (!fair), nor will the utilization
 		 * number include things like RT tasks.
 		 */
-		cpufreq_update_util(rq_clock(rq), min(cap, max), max);
+		cpufreq_update_util(cfs_util, rq_clock(rq), min(cap, max), max);
 	}
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 53ad077..9d9dab4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -947,7 +947,7 @@ static void update_curr_rt(struct rq *rq)
 
 	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
 	if (cpu_of(rq) == smp_processor_id())
-		cpufreq_update_util(rq_clock(rq), ULONG_MAX, 0);
+		cpufreq_update_util(rt_util, rq_clock(rq), ULONG_MAX, 0);
 
 	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8c93ed2..469d11d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1744,8 +1744,10 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+void cpufreq_update_util(enum sched_class_util sc, u64 time,
+			 unsigned long util, unsigned long max);
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util,
-				       unsigned long max) {}
+static inline void cpufreq_update_util(enum sched_class_util sc, u64 time,
+				       unsigned long util, unsigned long max)
+{}
 #endif /* CONFIG_CPU_FREQ */
-- 
2.1.4
