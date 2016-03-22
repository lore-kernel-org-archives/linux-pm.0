From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Mon, 21 Mar 2016 17:21:07 -0700
Message-ID: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

The cpufreq hook should be called whenever the root cfs_rq
utilization changes so update_cfs_rq_load_avg() is a better
place for it. The current location is not invoked in the
enqueue_entity() or update_blocked_averages() paths.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46d64e4ccfde..d418deb04049 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2825,7 +2825,9 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
 static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	struct sched_avg *sa = &cfs_rq->avg;
+	struct rq *rq = rq_of(cfs_rq);
 	int decayed, removed = 0;
+	int cpu = cpu_of(rq);
 
 	if (atomic_long_read(&cfs_rq->removed_load_avg)) {
 		s64 r = atomic_long_xchg(&cfs_rq->removed_load_avg, 0);
@@ -2840,7 +2842,7 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		sa->util_sum = max_t(s32, sa->util_sum - r * LOAD_AVG_MAX, 0);
 	}
 
-	decayed = __update_load_avg(now, cpu_of(rq_of(cfs_rq)), sa,
+	decayed = __update_load_avg(now, cpu, sa,
 		scale_load_down(cfs_rq->load.weight), cfs_rq->curr != NULL, cfs_rq);
 
 #ifndef CONFIG_64BIT
@@ -2848,28 +2850,6 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	return decayed || removed;
-}
-
-/* Update task and its cfs_rq load average */
-static inline void update_load_avg(struct sched_entity *se, int update_tg)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	u64 now = cfs_rq_clock_task(cfs_rq);
-	struct rq *rq = rq_of(cfs_rq);
-	int cpu = cpu_of(rq);
-
-	/*
-	 * Track task load average for carrying it to new CPU after migrated, and
-	 * track group sched_entity load average for task_h_load calc in migration
-	 */
-	__update_load_avg(now, cpu, &se->avg,
-			  se->on_rq * scale_load_down(se->load.weight),
-			  cfs_rq->curr == se, NULL);
-
-	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
-		update_tg_load_avg(cfs_rq, 0);
-
 	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
 		unsigned long max = rq->cpu_capacity_orig;
 
@@ -2890,8 +2870,30 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
 		 * See cpu_util().
 		 */
 		cpufreq_update_util(rq_clock(rq),
-				    min(cfs_rq->avg.util_avg, max), max);
+				    min(sa->util_avg, max), max);
 	}
+
+	return decayed || removed;
+}
+
+/* Update task and its cfs_rq load average */
+static inline void update_load_avg(struct sched_entity *se, int update_tg)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	u64 now = cfs_rq_clock_task(cfs_rq);
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
+
+	/*
+	 * Track task load average for carrying it to new CPU after migrated, and
+	 * track group sched_entity load average for task_h_load calc in migration
+	 */
+	__update_load_avg(now, cpu, &se->avg,
+			  se->on_rq * scale_load_down(se->load.weight),
+			  cfs_rq->curr == se, NULL);
+
+	if (update_cfs_rq_load_avg(now, cfs_rq) && update_tg)
+		update_tg_load_avg(cfs_rq, 0);
 }
 
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
-- 
2.4.10
