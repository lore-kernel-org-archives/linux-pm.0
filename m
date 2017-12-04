From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 3/8] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Mon,  4 Dec 2017 11:23:20 +0100
Message-ID: <20171204102325.5110-4-juri.lelli@redhat.com>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204102325.5110-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, alessio.balsini@arm.com, juri.lelli@redhat.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Worker kthread needs to be able to change frequency for all other
threads.

Make it special, just under STOP class.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
---
Changes from RFCv1:
 - return -EINVAL for user trying to use the new flag (Peter)
 - s/SPECIAL/SUGOV/ in the flag name (several comments from people to
   find better naming, Steve thinks SUGOV is more greppable than others)
 - give worker kthread a fake (unused) bandwidth, so that if priority
   inheritance is triggered we don't BUG_ON on zero runtime
 - filter out fake bandwidth when computing SCHED_DEADLINE bandwidth (fix by
   Claudio Scordino)
---
 include/linux/sched.h            |   1 +
 kernel/sched/core.c              |  15 +++++-
 kernel/sched/cpufreq_schedutil.c |  19 ++++++--
 kernel/sched/deadline.c          | 103 +++++++++++++++++++++++++++------------
 kernel/sched/sched.h             |  22 ++++++++-
 5 files changed, 124 insertions(+), 36 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 21991d668d35..c4b2d4a5cfab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1438,6 +1438,7 @@ extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
+extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75554f366fd3..5be52a3c1c1b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4041,7 +4041,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (attr->sched_flags &
-		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
+		~(SCHED_FLAG_RESET_ON_FORK |
+		  SCHED_FLAG_RECLAIM |
+		  SCHED_FLAG_SUGOV))
 		return -EINVAL;
 
 	/*
@@ -4108,6 +4110,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (user) {
+		if (attr->sched_flags & SCHED_FLAG_SUGOV)
+			return -EINVAL;
+
 		retval = security_task_setscheduler(p);
 		if (retval)
 			return retval;
@@ -4163,7 +4168,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		}
 #endif
 #ifdef CONFIG_SMP
-		if (dl_bandwidth_enabled() && dl_policy(policy)) {
+		if (dl_bandwidth_enabled() && dl_policy(policy) &&
+				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
 
 			/*
@@ -4293,6 +4299,11 @@ int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
 }
 EXPORT_SYMBOL_GPL(sched_setattr);
 
+int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
+{
+	return __sched_setscheduler(p, attr, false, true);
+}
+
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
  * @p: the task in question.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index de1ad1fffbdc..c22457868ee6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -475,7 +475,20 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
 	struct task_struct *thread;
-	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
+	struct sched_attr attr = {
+		.size = sizeof(struct sched_attr),
+		.sched_policy = SCHED_DEADLINE,
+		.sched_flags = SCHED_FLAG_SUGOV,
+		.sched_nice = 0,
+		.sched_priority = 0,
+		/*
+		 * Fake (unused) bandwidth; workaround to "fix"
+		 * priority inheritance.
+		 */
+		.sched_runtime	=  1000000,
+		.sched_deadline = 10000000,
+		.sched_period	= 10000000,
+	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
 
@@ -493,10 +506,10 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		return PTR_ERR(thread);
 	}
 
-	ret = sched_setscheduler_nocheck(thread, SCHED_FIFO, &param);
+	ret = sched_setattr_nocheck(thread, &attr);
 	if (ret) {
 		kthread_stop(thread);
-		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
+		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
 		return ret;
 	}
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7e4038bf9954..40f12aab9250 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -78,7 +78,7 @@ static inline int dl_bw_cpus(int i)
 #endif
 
 static inline
-void add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
@@ -91,7 +91,7 @@ void add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 }
 
 static inline
-void sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
@@ -105,7 +105,7 @@ void sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 }
 
 static inline
-void add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
@@ -115,7 +115,7 @@ void add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 }
 
 static inline
-void sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
@@ -127,16 +127,46 @@ void sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 }
 
+static inline
+void add_rq_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
+{
+	if (!(dl_se->flags & SCHED_FLAG_SUGOV))
+		__add_rq_bw(dl_se->dl_bw, dl_rq);
+}
+
+static inline
+void sub_rq_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
+{
+	if (!(dl_se->flags & SCHED_FLAG_SUGOV))
+		__sub_rq_bw(dl_se->dl_bw, dl_rq);
+}
+
+static inline
+void add_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
+{
+	if (!(dl_se->flags & SCHED_FLAG_SUGOV))
+		__add_running_bw(dl_se->dl_bw, dl_rq);
+}
+
+static inline
+void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
+{
+	if (!(dl_se->flags & SCHED_FLAG_SUGOV))
+		__sub_running_bw(dl_se->dl_bw, dl_rq);
+}
+
 void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	struct rq *rq;
 
+	BUG_ON(p->dl.flags & SCHED_FLAG_SUGOV);
+
 	if (task_on_rq_queued(p))
 		return;
 
 	rq = task_rq(p);
 	if (p->dl.dl_non_contending) {
-		sub_running_bw(p->dl.dl_bw, &rq->dl);
+		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
@@ -148,8 +178,8 @@ void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 			put_task_struct(p);
 	}
-	sub_rq_bw(p->dl.dl_bw, &rq->dl);
-	add_rq_bw(new_bw, &rq->dl);
+	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
+	__add_rq_bw(new_bw, &rq->dl);
 }
 
 /*
@@ -221,6 +251,9 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_se->dl_runtime == 0)
 		return;
 
+	if (unlikely(dl_entity_is_special(dl_se)))
+		return;
+
 	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
@@ -240,12 +273,12 @@ static void task_non_contending(struct task_struct *p)
 	 */
 	if (zerolag_time < 0) {
 		if (dl_task(p))
-			sub_running_bw(dl_se->dl_bw, dl_rq);
+			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 			if (p->state == TASK_DEAD)
-				sub_rq_bw(p->dl.dl_bw, &rq->dl);
+				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 			__dl_clear_params(p);
@@ -272,7 +305,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		return;
 
 	if (flags & ENQUEUE_MIGRATED)
-		add_rq_bw(dl_se->dl_bw, dl_rq);
+		add_rq_bw(dl_se, dl_rq);
 
 	if (dl_se->dl_non_contending) {
 		dl_se->dl_non_contending = 0;
@@ -293,7 +326,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * when the "inactive timer" fired).
 		 * So, add it back.
 		 */
-		add_running_bw(dl_se->dl_bw, dl_rq);
+		add_running_bw(dl_se, dl_rq);
 	}
 }
 
@@ -1149,6 +1182,9 @@ static void update_curr_dl(struct rq *rq)
 
 	sched_rt_avg_update(rq, delta_exec);
 
+	if (unlikely(dl_entity_is_special(dl_se)))
+		return;
+
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
 		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
 	dl_se->runtime -= delta_exec;
@@ -1205,8 +1241,8 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 		if (p->state == TASK_DEAD && dl_se->dl_non_contending) {
-			sub_running_bw(p->dl.dl_bw, dl_rq_of_se(&p->dl));
-			sub_rq_bw(p->dl.dl_bw, dl_rq_of_se(&p->dl));
+			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));
+			sub_rq_bw(&p->dl, dl_rq_of_se(&p->dl));
 			dl_se->dl_non_contending = 0;
 		}
 
@@ -1223,7 +1259,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	sub_running_bw(dl_se->dl_bw, &rq->dl);
+	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -1417,8 +1453,8 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		dl_check_constrained_dl(&p->dl);
 
 	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & ENQUEUE_RESTORE) {
-		add_rq_bw(p->dl.dl_bw, &rq->dl);
-		add_running_bw(p->dl.dl_bw, &rq->dl);
+		add_rq_bw(&p->dl, &rq->dl);
+		add_running_bw(&p->dl, &rq->dl);
 	}
 
 	/*
@@ -1458,8 +1494,8 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	__dequeue_task_dl(rq, p, flags);
 
 	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
-		sub_running_bw(p->dl.dl_bw, &rq->dl);
-		sub_rq_bw(p->dl.dl_bw, &rq->dl);
+		sub_running_bw(&p->dl, &rq->dl);
+		sub_rq_bw(&p->dl, &rq->dl);
 	}
 
 	/*
@@ -1565,7 +1601,7 @@ static void migrate_task_rq_dl(struct task_struct *p)
 	 */
 	raw_spin_lock(&rq->lock);
 	if (p->dl.dl_non_contending) {
-		sub_running_bw(p->dl.dl_bw, &rq->dl);
+		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
@@ -1577,7 +1613,7 @@ static void migrate_task_rq_dl(struct task_struct *p)
 		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 			put_task_struct(p);
 	}
-	sub_rq_bw(p->dl.dl_bw, &rq->dl);
+	sub_rq_bw(&p->dl, &rq->dl);
 	raw_spin_unlock(&rq->lock);
 }
 
@@ -2020,11 +2056,11 @@ static int push_dl_task(struct rq *rq)
 	}
 
 	deactivate_task(rq, next_task, 0);
-	sub_running_bw(next_task->dl.dl_bw, &rq->dl);
-	sub_rq_bw(next_task->dl.dl_bw, &rq->dl);
+	sub_running_bw(&next_task->dl, &rq->dl);
+	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
-	add_rq_bw(next_task->dl.dl_bw, &later_rq->dl);
-	add_running_bw(next_task->dl.dl_bw, &later_rq->dl);
+	add_rq_bw(&next_task->dl, &later_rq->dl);
+	add_running_bw(&next_task->dl, &later_rq->dl);
 	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
@@ -2112,11 +2148,11 @@ static void pull_dl_task(struct rq *this_rq)
 			resched = true;
 
 			deactivate_task(src_rq, p, 0);
-			sub_running_bw(p->dl.dl_bw, &src_rq->dl);
-			sub_rq_bw(p->dl.dl_bw, &src_rq->dl);
+			sub_running_bw(&p->dl, &src_rq->dl);
+			sub_rq_bw(&p->dl, &src_rq->dl);
 			set_task_cpu(p, this_cpu);
-			add_rq_bw(p->dl.dl_bw, &this_rq->dl);
-			add_running_bw(p->dl.dl_bw, &this_rq->dl);
+			add_rq_bw(&p->dl, &this_rq->dl);
+			add_running_bw(&p->dl, &this_rq->dl);
 			activate_task(this_rq, p, 0);
 			dmin = p->dl.deadline;
 
@@ -2225,7 +2261,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 		task_non_contending(p);
 
 	if (!task_on_rq_queued(p))
-		sub_rq_bw(p->dl.dl_bw, &rq->dl);
+		sub_rq_bw(&p->dl, &rq->dl);
 
 	/*
 	 * We cannot use inactive_task_timer() to invoke sub_running_bw()
@@ -2257,7 +2293,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
-		add_rq_bw(p->dl.dl_bw, &rq->dl);
+		add_rq_bw(&p->dl, &rq->dl);
 
 		return;
 	}
@@ -2436,6 +2472,9 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
 	int cpus, err = -1;
 
+	if (attr->sched_flags & SCHED_FLAG_SUGOV)
+		return 0;
+
 	/* !deadline task may carry old deadline bandwidth */
 	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
 		return 0;
@@ -2522,6 +2561,10 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	/* special dl tasks don't actually use any parameter */
+	if (attr->sched_flags & SCHED_FLAG_SUGOV)
+		return true;
+
 	/* deadline != 0 */
 	if (attr->sched_deadline == 0)
 		return false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a1730e39cbc6..280b421a82e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -156,13 +156,33 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+/*
+ * !! For sched_setattr_nocheck() (kernel) only !!
+ *
+ * This is actually gross. :(
+ *
+ * It is used to make schedutil kworker(s) higher priority than SCHED_DEADLINE
+ * tasks, but still be able to sleep. We need this on platforms that cannot
+ * atomically change clock frequency. Remove once fast switching will be
+ * available on such platforms.
+ *
+ * SUGOV stands for SchedUtil GOVernor.
+ */
+#define SCHED_FLAG_SUGOV	0x10000000
+
+static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
+{
+	return dl_se->flags & SCHED_FLAG_SUGOV;
+}
+
 /*
  * Tells if entity @a should preempt entity @b.
  */
 static inline bool
 dl_entity_preempt(struct sched_dl_entity *a, struct sched_dl_entity *b)
 {
-	return dl_time_before(a->deadline, b->deadline);
+	return dl_entity_is_special(a) ||
+	       dl_time_before(a->deadline, b->deadline);
 }
 
 /*
-- 
2.14.3
