From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 2/8] sched/fair: add margin to utilization update
Date: Sun, 13 Mar 2016 22:22:06 -0700
Message-ID: <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Utilization contributions to cfs_rq->avg.util_avg are scaled for both
microarchitecture-invariance as well as frequency-invariance. This means
that any given utilization contribution will be scaled against the
current cpu capacity (cpu frequency). Contributions from long running
tasks, whose utilization grows larger over time, will asymptotically
approach the current capacity.

This causes a problem when using this utilization signal to select a
target cpu capacity (cpu frequency), as our signal will never exceed the
current capacity, which would otherwise be our signal to increase
frequency.

Solve this by introducing a default capacity margin that is added to the
utilization signal when requesting a change to capacity (cpu frequency).
The margin is 1280, or 1.25 x SCHED_CAPACITY_SCALE (1024). This is
equivalent to similar margins such as the default 125 value assigned to
struct sched_domain.imbalance_pct for load balancing, and to the 80%
up_threshold used by the legacy cpufreq ondemand governor.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 kernel/sched/fair.c  | 18 ++++++++++++++++--
 kernel/sched/sched.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a32f281..29e8bae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -100,6 +100,19 @@ const_debug unsigned int sysctl_sched_migration_cost = 500000UL;
  */
 unsigned int __read_mostly sysctl_sched_shares_window = 10000000UL;
 
+/*
+ * Add a 25% margin globally to all capacity requests from cfs. This is
+ * equivalent to an 80% up_threshold in legacy governors like ondemand.
+ *
+ * This is required as task utilization increases. The frequency-invariant
+ * utilization will asymptotically approach the current capacity of the cpu and
+ * the additional margin will cross the threshold into the next capacity state.
+ *
+ * XXX someday expand to separate, per-call site margins? e.g. enqueue, fork,
+ * task_tick, load_balance, etc
+ */
+unsigned long cfs_capacity_margin = CAPACITY_MARGIN_DEFAULT;
+
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
  * Amount of runtime to allocate from global (tg) to local (per-cfs_rq) pool
@@ -2840,6 +2853,8 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
 
 	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
 		unsigned long max = rq->cpu_capacity_orig;
+		unsigned long cap = cfs_rq->avg.util_avg *
+			cfs_capacity_margin / max;
 
 		/*
 		 * There are a few boundary cases this might miss but it should
@@ -2852,8 +2867,7 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
 		 * thread is a different class (!fair), nor will the utilization
 		 * number include things like RT tasks.
 		 */
-		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+		cpufreq_update_util(rq_clock(rq), min(cap, max), max);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f06dfca..8c93ed2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -27,6 +27,9 @@ extern __read_mostly int scheduler_running;
 extern unsigned long calc_load_update;
 extern atomic_long_t calc_load_tasks;
 
+#define CAPACITY_MARGIN_DEFAULT 1280;
+extern unsigned long cfs_capacity_margin;
+
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq);
 
-- 
2.1.4
