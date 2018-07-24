From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v5 08/14] sched/fair: Clean-up update_sg_lb_stats parameters
Date: Tue, 24 Jul 2018 13:25:15 +0100
Message-ID: <20180724122521.22109-9-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

In preparation for the introduction of a new root domain flag which can
be set during load balance (the 'overutilized' flag), clean-up the set
of parameters passed to update_sg_lb_stats(). More specifically, the
'local_group' and 'local_idx' parameters can be removed since they can
easily be reconstructed from within the function.

While at it, transform the 'overload' parameter into a flag stored in
the 'sg_status' parameter and change the root_domain's overload field to
an 'int' since sizeof(_Bool) is implementation defined.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c  | 26 +++++++++++---------------
 kernel/sched/sched.h |  5 ++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5f7d521e448..fcc97fa3be94 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7802,16 +7802,16 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
  * @group: sched_group whose statistics are to be updated.
- * @load_idx: Load index of sched_domain of this_cpu for load calc.
- * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate more than one runnable task for any CPU.
+ * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
-			struct sched_group *group, int load_idx,
-			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+				      struct sched_group *group,
+				      struct sg_lb_stats *sgs,
+				      int *sg_status)
 {
+	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	int load_idx = get_sd_load_idx(env->sd, env->idle);
 	unsigned long load;
 	int i, nr_running;
 
@@ -7835,7 +7835,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*sg_status |= SG_OVERLOAD;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -7972,8 +7972,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
-	bool overload = false;
+	int prefer_sibling = 0;
+	int sg_status = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -7983,8 +7983,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->flags |= LBF_NOHZ_STATS;
 #endif
 
-	load_idx = get_sd_load_idx(env->sd, env->idle);
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -7999,8 +7997,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+		update_sg_lb_stats(env, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
@@ -8050,8 +8047,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (env->dst_rq->rd->overload != overload)
-			env->dst_rq->rd->overload = overload;
+		env->dst_rq->rd->overload = sg_status & SG_OVERLOAD;
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a317457804dd..99b5bf245eab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -707,6 +707,9 @@ struct freq_domain {
 	struct rcu_head rcu;
 };
 
+/* Scheduling group status flags */
+#define SG_OVERLOAD		0x1 /* More than one runnable task on a CPU. */
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -723,7 +726,7 @@ struct root_domain {
 	cpumask_var_t		online;
 
 	/* Indicate more than one runnable task for any CPU */
-	bool			overload;
+	int			overload;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
-- 
2.18.0
