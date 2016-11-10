From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 1/8] sched: Extend scheduler's asym packing
Date: Thu, 10 Nov 2016 14:36:33 -0800
Message-ID: <0c494b134a93e89ebf48e45719a6b864d4ac96b7.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

We generalize the scheduler's asym packing to provide an ordering
of the cpu beyond just the cpu number.  This allows the use of the
ASYM_PACKING scheduler machinery to move loads to preferred CPU in a
sched domain. The preference is defined with the cpu priority
given by arch_asym_cpu_priority(cpu).

We also record the most preferred cpu in a sched group when
we build the cpu's capacity for fast lookup of preferred cpu
during load balancing.

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 15 +++++++++++++
 kernel/sched/fair.c   | 59 ++++++++++++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h  |  6 ++++++
 4 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 348f51b..ca02475 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1057,6 +1057,10 @@ static inline int cpu_numa_flags(void)
 }
 #endif
 
+int arch_asym_cpu_priority(int cpu);
+int arch_asym_max_cpu_and(const struct cpumask *mask1,
+			  const struct cpumask *mask2);
+
 struct sched_domain_attr {
 	int relax_domain_level;
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 154fd68..d54c6e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6301,7 +6301,22 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	WARN_ON(!sg);
 
 	do {
+		int cpu, max_cpu = -1;
+
 		sg->group_weight = cpumask_weight(sched_group_cpus(sg));
+
+		if (!(sd->flags & SD_ASYM_PACKING))
+			goto next;
+
+		for_each_cpu(cpu, sched_group_cpus(sg)) {
+			if (max_cpu < 0)
+				max_cpu = cpu;
+			else if (sched_asym_prefer(cpu, max_cpu))
+				max_cpu = cpu;
+		}
+		sg->asym_prefer_cpu = max_cpu;
+
+next:
 		sg = sg->next;
 	} while (sg != sd->groups);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c242944..5057604 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -100,6 +100,27 @@ const_debug unsigned int sysctl_sched_migration_cost = 500000UL;
  */
 unsigned int __read_mostly sysctl_sched_shares_window = 10000000UL;
 
+#ifdef CONFIG_SMP
+/*
+ * For asym packing, by default the lower numbered cpu has higher priority.
+ */
+int __weak arch_asym_cpu_priority(int cpu)
+{
+	return -cpu;
+}
+
+/*
+ * Return the lowest numbered (or highest priority) cpu
+ * in the intersection of two cpu masks.  If no cpu is
+ * is in both masks, nr_cpu_ids will be returned.
+ */
+int __weak arch_asym_max_cpu_and(const struct cpumask *mask1,
+				 const struct cpumask *mask2)
+{
+	return cpumask_first_and(mask1, mask2);
+}
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
  * Amount of runtime to allocate from global (tg) to local (per-cfs_rq) pool
@@ -7113,16 +7134,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (env->idle == CPU_NOT_IDLE)
 		return true;
 	/*
-	 * ASYM_PACKING needs to move all the work to the lowest
-	 * numbered CPUs in the group, therefore mark all groups
-	 * higher than ourself as busy.
+	 * ASYM_PACKING needs to move all the work to the highest
+	 * prority CPUs in the group, therefore mark all groups
+	 * of lower priority than ourself as busy.
 	 */
-	if (sgs->sum_nr_running && env->dst_cpu < group_first_cpu(sg)) {
+	if (sgs->sum_nr_running &&
+	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		if (!sds->busiest)
 			return true;
 
-		/* Prefer to move from highest possible cpu's work */
-		if (group_first_cpu(sds->busiest) < group_first_cpu(sg))
+		/* Prefer to move from lowest priority cpu's work */
+		if (sched_asym_prefer(sds->busiest->asym_prefer_cpu,
+				      sg->asym_prefer_cpu))
 			return true;
 	}
 
@@ -7274,8 +7297,8 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (!sds->busiest)
 		return 0;
 
-	busiest_cpu = group_first_cpu(sds->busiest);
-	if (env->dst_cpu > busiest_cpu)
+	busiest_cpu = sds->busiest->asym_prefer_cpu;
+	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
 		return 0;
 
 	env->imbalance = DIV_ROUND_CLOSEST(
@@ -7613,10 +7636,11 @@ static int need_active_balance(struct lb_env *env)
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
-		 * higher numbered CPUs in order to pack all tasks in the
-		 * lowest numbered CPUs.
+		 * lower priority CPUs in order to pack all tasks in the
+		 * highest priority CPUs.
 		 */
-		if ((sd->flags & SD_ASYM_PACKING) && env->src_cpu > env->dst_cpu)
+		if ((sd->flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(env->dst_cpu, env->src_cpu))
 			return 1;
 	}
 
@@ -8467,6 +8491,7 @@ static inline bool nohz_kick_needed(struct rq *rq)
 	struct sched_domain *sd;
 	int nr_busy, cpu = rq->cpu;
 	bool kick = false;
+	int asym_idle_cpu;
 
 	if (unlikely(rq->idle_balance))
 		return false;
@@ -8516,10 +8541,14 @@ static inline bool nohz_kick_needed(struct rq *rq)
 	}
 
 	sd = rcu_dereference(per_cpu(sd_asym, cpu));
-	if (sd && (cpumask_first_and(nohz.idle_cpus_mask,
-				  sched_domain_span(sd)) < cpu)) {
-		kick = true;
-		goto unlock;
+	if (sd) {
+		asym_idle_cpu = arch_asym_max_cpu_and(nohz.idle_cpus_mask,
+						sched_domain_span(sd));
+		if (asym_idle_cpu < nr_cpu_ids &&
+		        sched_asym_prefer(asym_idle_cpu, cpu)) {
+			kick = true;
+			goto unlock;
+		}
 	}
 
 unlock:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 055f935..cd3d413 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -539,6 +539,11 @@ struct dl_rq {
 
 #ifdef CONFIG_SMP
 
+static inline bool sched_asym_prefer(int a, int b)
+{
+	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
+}
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -905,6 +910,7 @@ struct sched_group {
 
 	unsigned int group_weight;
 	struct sched_group_capacity *sgc;
+	int asym_prefer_cpu;		/* cpu of highest priority in group */
 
 	/*
 	 * The CPUs this group covers.
-- 
2.5.5
