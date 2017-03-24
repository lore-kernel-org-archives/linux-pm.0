From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Fri, 24 Mar 2017 14:08:58 +0000
Message-ID: <20170324140900.7334-4-juri.lelli@arm.com>
References: <20170324140900.7334-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757137AbdCXOJ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 10:09:29 -0400
In-Reply-To: <20170324140900.7334-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

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
 include/linux/sched.h            |  1 +
 include/uapi/linux/sched.h       |  1 +
 kernel/sched/core.c              | 19 +++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 kernel/sched/deadline.c          |  6 ++++++
 kernel/sched/sched.h             |  8 +++++++-
 6 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 952cac87e433..6f508980f320 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1351,6 +1351,7 @@ extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
+extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
 
 /**
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index e2a6c7b3510b..72723859ef74 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -48,5 +48,6 @@
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
+#define SCHED_FLAG_SPECIAL		0x04
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 378d402ee7a6..9b211c77cb54 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2495,6 +2495,9 @@ static int dl_overflow(struct task_struct *p, int policy,
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
 	int cpus, err = -1;
 
+	if (attr->sched_flags & SCHED_FLAG_SPECIAL)
+		return 0;
+
 	/* !deadline task may carry old deadline bandwidth */
 	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
 		return 0;
@@ -4052,6 +4055,10 @@ __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 static bool
 __checkparam_dl(const struct sched_attr *attr)
 {
+	/* special dl tasks don't actually use any parameter */
+	if (attr->sched_flags & SCHED_FLAG_SPECIAL)
+		return true;
+
 	/* deadline != 0 */
 	if (attr->sched_deadline == 0)
 		return false;
@@ -4138,7 +4145,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	if (attr->sched_flags &
-		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
+		~(SCHED_FLAG_RESET_ON_FORK |
+		  SCHED_FLAG_RECLAIM |
+		  SCHED_FLAG_SPECIAL))
 		return -EINVAL;
 
 	/*
@@ -4260,7 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		}
 #endif
 #ifdef CONFIG_SMP
-		if (dl_bandwidth_enabled() && dl_policy(policy)) {
+		if (dl_bandwidth_enabled() && dl_policy(policy) &&
+				!(attr->sched_flags & SCHED_FLAG_SPECIAL)) {
 			cpumask_t *span = rq->rd->span;
 
 			/*
@@ -4390,6 +4400,11 @@ int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
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
index 05f5625ea005..da67a1cf91e7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -394,7 +394,16 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
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
 
@@ -412,10 +421,10 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
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
index 5c1a205e830f..853de524c6c6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -131,6 +131,9 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_se->dl_runtime == 0)
 		return;
 
+	if (dl_entity_is_special(dl_se))
+		return;
+
 	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
@@ -968,6 +971,9 @@ static void update_curr_dl(struct rq *rq)
 
 	sched_rt_avg_update(rq, delta_exec);
 
+	if (unlikely(dl_entity_is_special(dl_se)))
+		return;
+
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
 		delta_exec = grub_reclaim(delta_exec, rq, curr->dl.dl_bw);
 	dl_se->runtime -= delta_exec;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93c24528ceb6..7b5e81120813 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -155,13 +155,19 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
+{
+	return dl_se->flags & SCHED_FLAG_SPECIAL;
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
2.10.0
