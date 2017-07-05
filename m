From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Wed,  5 Jul 2017 09:59:00 +0100
Message-ID: <20170705085905.6558-4-juri.lelli@arm.com>
References: <20170705085905.6558-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705085905.6558-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

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
Changes from RFCv0:

 - use a high bit of sched_flags and don't expose the new flag to
   userspace (also add derisory comments) (Peter)
---
 include/linux/sched.h            |  1 +
 kernel/sched/core.c              | 15 +++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 kernel/sched/deadline.c          | 13 +++++++++++++
 kernel/sched/sched.h             | 20 +++++++++++++++++++-
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f0f427e0292..0ba767fdedae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1359,6 +1359,7 @@ extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
+extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5186797908dc..0e40c7ff2bf4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3998,7 +3998,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (attr->sched_flags &
-		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
+		~(SCHED_FLAG_RESET_ON_FORK |
+		  SCHED_FLAG_RECLAIM |
+		  SCHED_FLAG_SPECIAL))
 		return -EINVAL;
 
 	/*
@@ -4065,6 +4067,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (user) {
+		if (attr->sched_flags & SCHED_FLAG_SPECIAL)
+			return -EPERM;
+
 		retval = security_task_setscheduler(p);
 		if (retval)
 			return retval;
@@ -4120,7 +4125,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		}
 #endif
 #ifdef CONFIG_SMP
-		if (dl_bandwidth_enabled() && dl_policy(policy)) {
+		if (dl_bandwidth_enabled() && dl_policy(policy) &&
+				!(attr->sched_flags & SCHED_FLAG_SPECIAL)) {
 			cpumask_t *span = rq->rd->span;
 
 			/*
@@ -4250,6 +4256,11 @@ int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
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
index f2494d1fc8ef..ba6227625f24 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -424,7 +424,16 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
 	struct task_struct *thread;
-	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
+	struct sched_attr attr = {
+		.size = sizeof(struct sched_attr),
+		.sched_policy = SCHED_DEADLINE,
+		.sched_flags = SCHED_FLAG_SPECIAL,
+		.sched_nice = 0,
+		.sched_priority = 0,
+		.sched_runtime = 0,
+		.sched_deadline = 0,
+		.sched_period = 0,
+	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
 
@@ -442,10 +451,10 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
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
index 6912f7f35f9b..4ec82fa56b04 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -220,6 +220,9 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_se->dl_runtime == 0)
 		return;
 
+	if (unlikely(dl_entity_is_special(dl_se)))
+		return;
+
 	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
@@ -1150,6 +1153,9 @@ static void update_curr_dl(struct rq *rq)
 
 	sched_rt_avg_update(rq, delta_exec);
 
+	if (unlikely(dl_entity_is_special(dl_se)))
+		return;
+
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
 		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
 	dl_se->runtime -= delta_exec;
@@ -2447,6 +2453,9 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
 	int cpus, err = -1;
 
+	if (attr->sched_flags & SCHED_FLAG_SPECIAL)
+		return 0;
+
 	/* !deadline task may carry old deadline bandwidth */
 	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
 		return 0;
@@ -2533,6 +2542,10 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	/* special dl tasks don't actually use any parameter */
+	if (attr->sched_flags & SCHED_FLAG_SPECIAL)
+		return true;
+
 	/* deadline != 0 */
 	if (attr->sched_deadline == 0)
 		return false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d8798bb54ace..1be5dac728a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -156,12 +156,30 @@ static inline int task_has_dl_policy(struct task_struct *p)
 }
 
 /*
+ * !! For sched_setattr_nocheck() (kernel) only !!
+ *
+ * This is actually gross. :(
+ *
+ * It is used to make schedutil kworker(s) higher priority than SCHED_DEADLINE
+ * tasks, but still be able to sleep. We need this on platforms that cannot
+ * atomically change clock frequency. Remove once fast switching will be
+ * available on such platforms.
+ */
+#define SCHED_FLAG_SPECIAL	0x10000000
+
+static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
+{
+	return dl_se->flags & SCHED_FLAG_SPECIAL;
+}
+
+/*
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
2.11.0
