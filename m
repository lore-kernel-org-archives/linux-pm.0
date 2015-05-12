From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 27/34] sched, cpuidle: Track cpuidle state index in the scheduler
Date: Tue, 12 May 2015 20:39:02 +0100
Message-ID: <1431459549-18343-28-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33997 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933972AbbELTi4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:38:56 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

The idle-state of each cpu is currently pointed to by rq->idle_state but
there isn't any information in the struct cpuidle_state that can used to
look up the idle-state energy model data stored in struct
sched_group_energy. For this purpose is necessary to store the idle
state index as well. Ideally, the idle-state data should be unified.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/idle.c  |  2 ++
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index fefcb1f..6832fa1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -151,6 +151,7 @@ static void cpuidle_idle_call(void)
 
 	/* Take note of the planned idle state. */
 	idle_set_state(this_rq(), &drv->states[next_state]);
+	idle_set_state_idx(this_rq(), next_state);
 
 	/*
 	 * Enter the idle state previously returned by the governor decision.
@@ -161,6 +162,7 @@ static void cpuidle_idle_call(void)
 
 	/* The cpu is no longer idle or about to enter idle. */
 	idle_set_state(this_rq(), NULL);
+	idle_set_state_idx(this_rq(), -1);
 
 	if (entered_state == -EBUSY)
 		goto use_default;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 95c8ff7..897730f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -701,6 +701,7 @@ struct rq {
 #ifdef CONFIG_CPU_IDLE
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state *idle_state;
+	int idle_state_idx;
 #endif
 };
 
@@ -1316,6 +1317,17 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 	WARN_ON(!rcu_read_lock_held());
 	return rq->idle_state;
 }
+
+static inline void idle_set_state_idx(struct rq *rq, int idle_state_idx)
+{
+	rq->idle_state_idx = idle_state_idx;
+}
+
+static inline int idle_get_state_idx(struct rq *rq)
+{
+	WARN_ON(!rcu_read_lock_held());
+	return rq->idle_state_idx;
+}
 #else
 static inline void idle_set_state(struct rq *rq,
 				  struct cpuidle_state *idle_state)
@@ -1326,6 +1338,15 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
 	return NULL;
 }
+
+static inline void idle_set_state_idx(struct rq *rq, int idle_state_idx)
+{
+}
+
+static inline int idle_get_state_idx(struct rq *rq)
+{
+	return -1;
+}
 #endif
 
 extern void sysrq_sched_debug_show(void);
-- 
1.9.1

