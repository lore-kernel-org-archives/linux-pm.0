From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 04/14] sched/core: uclamp: update CPU's refcount on
 clamp changes
Date: Thu, 16 Aug 2018 14:22:49 +0100
Message-ID: <20180816132249.GA2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-5-patrick.bellasi@arm.com>
 <4023267d-be06-c599-136e-1f70bf376d5d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4023267d-be06-c599-136e-1f70bf376d5d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 15-Aug 17:02, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> 
> [...]
> 
> >+/**
> >+ * uclamp_task_active: check if a task is currently clamping a CPU
> >+ * @p: the task to check
> >+ *
> >+ * A task actively affects the utilization clamp of a CPU if:
> >+ * - it's currently enqueued or running on that CPU
> >+ * - it's refcounted in at least one clamp group of that CPU
> >+ *
> >+ * Return: true if p is currently clamping the utilization of its CPU.
> >+ */
> >+static inline bool uclamp_task_active(struct task_struct *p)
> >+{
> >+	struct rq *rq = task_rq(p);
> >+	int clamp_id;
> >+
> >+	lockdep_assert_held(&p->pi_lock);
> >+	lockdep_assert_held(&rq->lock);
> >+
> >+	if (!task_on_rq_queued(p) && !p->on_cpu)
> >+		return false;
> >+
> >+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> >+		if (uclamp_task_affects(p, clamp_id))
> >+			return true;
> >+	}
> >+
> >+	return false;
> >+}
> 
> Looks like that uclamp_task_active() is only used once (in
> uclamp_task_update_active()). Can you not code the if condition and the for
> loop directly in uclamp_task_update_active()? This would save code
> (lockdep_assert_held() etc.) and comment lines.

Yes, that's possible... and we will have:

---8<---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae528a7b9bef..0c8bec892018 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1331,7 +1331,9 @@ uclamp_task_update_active(struct task_struct *p, int clamp_id, int group_id)
 	 * index, then that task is not yet RUNNABLE and it's going to be
 	 * enqueued with the proper clamp group value.
 	 */
-	if (!uclamp_task_active(p))
+	if (!task_on_rq_queued(p) && !p->on_cpu)
+		goto done;
+	if (!uclamp_task_affects(p, clamp_id))
 		goto done;
 
 	/* Release p's currently referenced clamp group */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 11d139faed1f..65fdf4abc6ff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2231,35 +2231,6 @@ static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 {
 	return (p->uclamp[clamp_id].effective.group_id != UCLAMP_NOT_VALID);
 }
-
-/**
- * uclamp_task_active: check if a task is currently clamping a CPU
- * @p: the task to check
- *
- * A task actively affects the utilization clamp of a CPU if:
- * - it's currently enqueued or running on that CPU
- * - it's refcounted in at least one clamp group of that CPU
- *
- * Return: true if p is currently clamping the utilization of its CPU.
- */
-static inline bool uclamp_task_active(struct task_struct *p)
-{
-	struct rq *rq = task_rq(p);
-	int clamp_id;
-
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_held(&rq->lock);
-
-	if (!task_on_rq_queued(p) && !p->on_cpu)
-		return false;
-
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
-		if (uclamp_task_affects(p, clamp_id))
-			return true;
-	}
-
-	return false;
-}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_CPU_FREQ
---8<---

I'll add this to the next posting!

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
