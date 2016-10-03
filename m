From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v5 1/9] sched: Extend scheduler's asym packing
Date: Mon, 3 Oct 2016 09:49:01 -0700
Message-ID: <20161003164901.GA14994@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1475322326-160112-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CACbG30-L_U=iES=+VNGSbOTsT_q3_Nvu_XVqSh6SGdua6n+ejQ@mail.gmail.com>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACbG30-L_U=iES=+VNGSbOTsT_q3_Nvu_XVqSh6SGdua6n+ejQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Nilay Vaish <nilayvaish@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86 <x86@kernel.org>, linux-pm@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 01, 2016 at 11:38:04AM -0500, Nilay Vaish wrote:
> On 1 October 2016 at 06:45, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e86c4a5..08135ca 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6237,7 +6237,25 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
> >         WARN_ON(!sg);
> >
> >         do {
> > +               int cpu, max_cpu = -1, prev_cpu = -1;
> > +
> >                 sg->group_weight = cpumask_weight(sched_group_cpus(sg));
> > +
> > +               if (!(sd->flags & SD_ASYM_PACKING))
> > +                       goto next;
> > +
> > +               for_each_cpu(cpu, sched_group_cpus(sg)) {
> > +                       if (prev_cpu < 0) {
> > +                               prev_cpu = cpu;
> > +                               max_cpu = cpu;
> 
> It seems that you can drop prev_cpu and put the check on max_cpu instead.
> 

The usage of prev_cpu was an artifact of the evolution of this patch.
It can indeed be dropped and I've updated this change in the patch below.

Thanks.

Tim

--->8---
commit 90955f87f228ee2fe7eeffcab851eb3141a783b4
Author: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v5 1/9 update] sched: Extend scheduler's asym packing 

    sched: Extend scheduler's asym packing
    
    We generalize the scheduler's asym packing to provide an ordering
    of the cpu beyond just the cpu number.  This allows the use of the
    ASYM_PACKING scheduler machinery to move loads to preferred CPU in a
    sched domain. The preference is defined with the cpu priority
    given by arch_asym_cpu_priority(cpu).
    
    We also record the most preferred cpu in a sched group when
    we build the cpu's capacity for fast lookup of preferred cpu
    during load balancing.
    
    Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 62c68e5..aeea288 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1052,6 +1052,8 @@ static inline int cpu_numa_flags(void)
 }
 #endif
 
+int arch_asym_cpu_priority(int cpu);
+
 struct sched_domain_attr {
 	int relax_domain_level;
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e86c4a5..b2e22de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6237,7 +6237,22 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
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
index 039de34..8e2a078 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -100,6 +100,16 @@ const_debug unsigned int sysctl_sched_migration_cost = 500000UL;
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
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
  * Amount of runtime to allocate from global (tg) to local (per-cfs_rq) pool
@@ -6862,16 +6872,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
 
@@ -7023,8 +7035,8 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (!sds->busiest)
 		return 0;
 
-	busiest_cpu = group_first_cpu(sds->busiest);
-	if (env->dst_cpu > busiest_cpu)
+	busiest_cpu = sds->busiest->asym_prefer_cpu;
+	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
 		return 0;
 
 	env->imbalance = DIV_ROUND_CLOSEST(
@@ -7365,10 +7377,11 @@ static int need_active_balance(struct lb_env *env)
 
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
index c64fc51..b6f449d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -532,6 +532,11 @@ struct dl_rq {
 
 #ifdef CONFIG_SMP
 
+static inline bool sched_asym_prefer(int a, int b)
+{
+	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
+}
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -884,6 +889,7 @@ struct sched_group {
 
 	unsigned int group_weight;
 	struct sched_group_capacity *sgc;
+	int asym_prefer_cpu;		/* cpu of highest priority in group */
 
 	/*
 	 * The CPUs this group covers.
