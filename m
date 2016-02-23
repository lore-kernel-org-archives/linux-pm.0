From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 10/10] sched: rt scheduler sets capacity requirement
Date: Mon, 22 Feb 2016 17:22:50 -0800
Message-ID: <1456190570-4475-11-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

RT tasks don't provide any running constraints like deadline ones
except their running priority. The only current usable input to
estimate the capacity needed by RT tasks is the rt_avg metric. We use
it to estimate the CPU capacity needed for the RT scheduler class.

In order to monitor the evolution for RT task load, we must
peridiocally check it during the tick.

Then, we use the estimated capacity of the last activity to estimate
the next one which can not be that accurate but is a good starting
point without any impact on the wake up path of RT tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/rt.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8ec86ab..da9086c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1426,6 +1426,41 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
+#ifdef CONFIG_CPU_FREQ_GOV_SCHED
+static void sched_rt_update_capacity_req(struct rq *rq)
+{
+	u64 total, used, age_stamp, avg;
+	s64 delta;
+
+	if (!sched_freq())
+		return;
+
+	sched_avg_update(rq);
+	/*
+	 * Since we're reading these variables without serialization make sure
+	 * we read them once before doing sanity checks on them.
+	 */
+	age_stamp = READ_ONCE(rq->age_stamp);
+	avg = READ_ONCE(rq->rt_avg);
+	delta = rq_clock(rq) - age_stamp;
+
+	if (unlikely(delta < 0))
+		delta = 0;
+
+	total = sched_avg_period() + delta;
+
+	used = div_u64(avg, total);
+	if (unlikely(used > SCHED_CAPACITY_SCALE))
+		used = SCHED_CAPACITY_SCALE;
+
+	set_rt_cpu_capacity(rq->cpu, true, (unsigned long)(used));
+}
+#else
+static inline void sched_rt_update_capacity_req(struct rq *rq)
+{ }
+
+#endif
+
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 						   struct rt_rq *rt_rq)
 {
@@ -1494,8 +1529,17 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev)
 	if (prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
 
-	if (!rt_rq->rt_queued)
+	if (!rt_rq->rt_queued) {
+		/*
+		 * The next task to be picked on this rq will have a lower
+		 * priority than rt tasks so we can spend some time to update
+		 * the capacity used by rt tasks based on the last activity.
+		 * This value will be the used as an estimation of the next
+		 * activity.
+		 */
+		sched_rt_update_capacity_req(rq);
 		return NULL;
+	}
 
 	put_prev_task(rq, prev);
 
@@ -2212,6 +2256,8 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 	update_curr_rt(rq);
 
+	sched_rt_update_capacity_req(rq);
+
 	watchdog(rq, p);
 
 	/*
-- 
2.4.10
