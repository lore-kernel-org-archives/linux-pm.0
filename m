From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v4 05/16] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Tue, 28 Aug 2018 14:53:13 +0100
Message-ID: <20180828135324.21976-6-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

When a util_max clamped task sleeps, its clamp constraints are removed
from the CPU. However, the blocked utilization on that CPU can still be
higher than the max clamp value enforced while that task was running.
This max clamp removal when a CPU is going to be idle could thus allow
unwanted CPU frequency increases, right while the task is not running.

This can happen, for example, where there is another (smaller) task
running on a different CPU of the same frequency domain.
In this case, when we aggregate the utilization of all the CPUs in a
shared frequency domain, schedutil can still see the full non clamped
blocked utilization of all the CPUs and thus eventually increase the
frequency.

Let's fix this by using:

   uclamp_cpu_put_id(UCLAMP_MAX)
      uclamp_cpu_update(last_clamp_value)

to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition. Thus, while a CPU is idle, we can still enforce the last used
clamp value for it.

To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
idle, we don't want to enforce any minimum frequency
Indeed, we rely just on blocked load decay to smoothly reduce the
frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v4:
 Message-ID: <20180816172016.GG2960@e110439-lin>
 - ensure to always reset clamp holding on wakeup from IDLE
 Others:
 - rebased on v4.19-rc1

Changes in v3:
 Message-ID: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
Changes in v2:
 - rabased on v4.18-rc4
 - new patch to improve a specific issue
---
 kernel/sched/core.c  | 39 +++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h | 11 +++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 64e5c96bfdaf..ba0e7208c65a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -910,7 +910,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
  * For the specified clamp index, this method computes the new CPU utilization
  * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
  */
-static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
+static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
+				     unsigned int last_clamp_value)
 {
 	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
 	int max_value = UCLAMP_NOT_VALID;
@@ -928,6 +929,24 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
 		if (max_value >= SCHED_CAPACITY_SCALE)
 			break;
 	}
+
+	/*
+	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
+	 * task, we want to keep the CPU clamped to the last task's clamp
+	 * value. This is to avoid frequency spikes to MAX when one CPU, with
+	 * an high blocked utilization, sleeps and another CPU, in the same
+	 * frequency domain, do not see anymore the clamp on the first CPU.
+	 *
+	 * The UCLAMP_FLAG_IDLE is set whenever we detect, from the above
+	 * loop, that there are no more RUNNABLE taks on that CPU.
+	 * In this case we enforce the CPU util_max to that of the last
+	 * dequeued task.
+	 */
+	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
+		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
+		max_value = last_clamp_value;
+	}
+
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
@@ -962,13 +981,25 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	uc_grp = &rq->uclamp.group[clamp_id][0];
 	uc_grp[group_id].tasks += 1;
 
+	/* Reset clamp holds on idle exit */
+	uc_cpu = &rq->uclamp;
+	clamp_value = p->uclamp[clamp_id].value;
+	if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
+		/*
+		 * This function is called for both UCLAMP_MIN (before) and
+		 * UCLAMP_MAX (after). Let's reset the flag only the second
+		 * once we know that UCLAMP_MIN has been already updated.
+		 */
+		if (clamp_id == UCLAMP_MAX)
+			uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
+		uc_cpu->value[clamp_id] = clamp_value;
+	}
+
 	/*
 	 * If this is the new max utilization clamp value, then we can update
 	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
 	 * value is still valid and we are done.
 	 */
-	uc_cpu = &rq->uclamp;
-	clamp_value = p->uclamp[clamp_id].value;
 	if (uc_cpu->value[clamp_id] < clamp_value)
 		uc_cpu->value[clamp_id] = clamp_value;
 }
@@ -1026,7 +1057,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	}
 #endif
 	if (clamp_value >= uc_cpu->value[clamp_id])
-		uclamp_cpu_update(rq, clamp_id);
+		uclamp_cpu_update(rq, clamp_id, clamp_value);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 25d1d218ae10..411635c4c09a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -805,6 +805,17 @@ struct uclamp_group {
 struct uclamp_cpu {
 	struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
 	int value[UCLAMP_CNT];
+/*
+ * Idle clamp holding
+ * Whenever a CPU is idle, we enforce the util_max clamp value of the last
+ * task running on that CPU. This bit is used to flag a clamp holding
+ * currently active for a CPU. This flag is:
+ * - set when we update the clamp value of a CPU at the time of dequeuing the
+ *   last before entering idle
+ * - reset when we enqueue the first task after a CPU wakeup from IDLE
+ */
+#define UCLAMP_FLAG_IDLE 0x01
+	int flags;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
-- 
2.18.0
