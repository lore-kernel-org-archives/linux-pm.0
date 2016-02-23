From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 09/10] sched/deadline: split rt_avg in 2 distincts metrics
Date: Mon, 22 Feb 2016 17:22:49 -0800
Message-ID: <1456190570-4475-10-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

rt_avg monitors the average load of rt tasks, deadline tasks and
interruptions, when enabled. It's used to calculate the remaining
capacity for CFS tasks. We split rt_avg in 2 metrics, one for rt and
interruptions that keeps the name rt_avg and another one for deadline
tasks that will be named dl_avg.
Both values are still used to calculate the remaining capacity for cfs
task. But rt_avg is now also used to request capacity to the sched-freq
for the rt tasks.
As the irq time is accounted with rt tasks, it will be taken into account
in the request of capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/core.c     | 1 +
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 1 +
 kernel/sched/sched.h    | 8 +++++++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 747a7af..12a4a3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -759,6 +759,7 @@ void sched_avg_update(struct rq *rq)
 		asm("" : "+rm" (rq->age_stamp));
 		rq->age_stamp += period;
 		rq->rt_avg /= 2;
+		rq->dl_avg /= 2;
 	}
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index cd64c97..87dcee3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -747,7 +747,7 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.exec_start = rq_clock_task(rq);
 	cpuacct_charge(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
+	sched_dl_avg_update(rq, delta_exec);
 
 	dl_se->runtime -= dl_se->dl_yielded ? 0 : delta_exec;
 	if (dl_runtime_exceeded(dl_se)) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf7ae0a..3a812fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6278,6 +6278,7 @@ static unsigned long scale_rt_capacity(int cpu)
 	 */
 	age_stamp = READ_ONCE(rq->age_stamp);
 	avg = READ_ONCE(rq->rt_avg);
+	avg += READ_ONCE(rq->dl_avg);
 	delta = __rq_clock_broken(rq) - age_stamp;
 
 	if (unlikely(delta < 0))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3df21f2..ad6cc8b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -644,7 +644,7 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	u64 rt_avg;
+	u64 rt_avg, dl_avg;
 	u64 age_stamp;
 	u64 idle_stamp;
 	u64 avg_idle;
@@ -1499,8 +1499,14 @@ static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
 }
+
+static inline void sched_dl_avg_update(struct rq *rq, u64 dl_delta)
+{
+	rq->dl_avg += dl_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
+}
 #else
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
+static inline void sched_dl_avg_update(struct rq *rq, u64 dl_delta) { }
 static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
-- 
2.4.10
