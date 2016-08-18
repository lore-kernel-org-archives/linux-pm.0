From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Thu, 18 Aug 2016 15:36:44 -0700
Message-ID: <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

We generalize the scheduler's asym packing to provide an
ordering of the cpu beyond just the cpu number.  This allows
the use of the ASYM_PACKING scheduler machinery to move
loads to prefered CPU in a sched domain based on a preference
defined by sched_asym_prefer function.

We also record the most preferred cpu in a sched group when
we build the cpu's capacity for fast lookup of preferred cpu
during load balancing.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 kernel/sched/core.c  | 18 ++++++++++++++++++
 kernel/sched/fair.c  | 25 ++++++++++++++-----------
 kernel/sched/sched.h | 17 +++++++++++++++++
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 342eca9..2ca99a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6237,7 +6237,25 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	WARN_ON(!sg);
 
 	do {
+		int cpu, max_cpu = -1, prev_cpu = -1;
+
 		sg->group_weight = cpumask_weight(sched_group_cpus(sg));
+
+		if (!(sd->flags & SD_ASYM_PACKING))
+			goto next;
+
+		for_each_cpu(cpu, sched_group_cpus(sg)) {
+			if (prev_cpu < 0) {
+				prev_cpu = cpu;
+				max_cpu = cpu;
+			} else {
+				if (sched_asym_prefer(cpu, max_cpu))
+					max_cpu = cpu;
+			}
+		}
+		sg->asym_prefer_cpu = max_cpu;
+
+next:
 		sg = sg->next;
 	} while (sg != sd->groups);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 039de34..37a30d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6862,16 +6862,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
+	    sched_asym_prefer(env->dst_cpu, group_priority_cpu(sg))) {
 		if (!sds->busiest)
 			return true;
 
-		/* Prefer to move from highest possible cpu's work */
-		if (group_first_cpu(sds->busiest) < group_first_cpu(sg))
+		/* Prefer to move from lowest priority cpu's work */
+		if (sched_asym_prefer(group_priority_cpu(sds->busiest),
+				      group_priority_cpu(sg)))
 			return true;
 	}
 
@@ -7023,8 +7025,8 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (!sds->busiest)
 		return 0;
 
-	busiest_cpu = group_first_cpu(sds->busiest);
-	if (env->dst_cpu > busiest_cpu)
+	busiest_cpu = group_priority_cpu(sds->busiest);
+	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
 		return 0;
 
 	env->imbalance = DIV_ROUND_CLOSEST(
@@ -7365,10 +7367,11 @@ static int need_active_balance(struct lb_env *env)
 
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c64fc51..75e1002 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -532,6 +532,22 @@ struct dl_rq {
 
 #ifdef CONFIG_SMP
 
+#ifndef sched_asym_prefer
+
+/* For default ASYM_PACKING, lower numbered cpu is prefered */
+static inline bool sched_asym_prefer(int a, int b)
+{
+	return a < b;
+}
+
+#endif /* sched_asym_prefer */
+
+/*
+ * Return lowest numbered cpu in the group as the most prefered cpu
+ * for ASYM_PACKING for default case.
+ */
+#define group_priority_cpu(group) group->asym_prefer_cpu
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -884,6 +900,7 @@ struct sched_group {
 
 	unsigned int group_weight;
 	struct sched_group_capacity *sgc;
+	int asym_prefer_cpu;		/* cpu of highest priority in group */
 
 	/*
 	 * The CPUs this group covers.
-- 
2.7.4
