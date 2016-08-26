From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Fri, 26 Aug 2016 16:14:58 -0700
Message-ID: <20160826231458.GA11568@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
 <20160825114522.GD10138@twins.programming.kicks-ass.net>
 <20160825131836.GB1323@e105550-lin.cambridge.arm.com>
 <20160825134503.GH10138@twins.programming.kicks-ass.net>
 <20160826103945.GC1323@e105550-lin.cambridge.arm.com>
 <20160826124207.GM10121@twins.programming.kicks-ass.net>
 <1472232338.2916.58.camel@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472232338.2916.58.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2016 at 10:25:38AM -0700, Tim Chen wrote:
> On Fri, 2016-08-26 at 14:42 +0200, Peter Zijlstra wrote:
> > On Fri, Aug 26, 2016 at 11:39:46AM +0100, Morten Rasmussen wrote:
> > > 
> > > On Thu, Aug 25, 2016 at 03:45:03PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > On Thu, Aug 25, 2016 at 02:18:37PM +0100, Morten Rasmussen wrote:
> > > > 
> > > > > 
> > > > > But why not just pass the customized list into the scheduler? Seems
> > > > > simpler?
> > > > Mostly because I didn't want to regress Power I suppose. The ITMT stuff
> > > > needs an extra load, whereas the Power stuff can use the CPU number we
> > > > already have.
> > > The customized list wouldn't have to be mandatory. You could easily
> > > create a default list that would match current behaviour for Power.
> > Sure, but then you have the extra load.. probably not an issue but
> > still.
> > 
> > > 
> > > What is the 'extra load' needed for ITMT? Isn't it just a priority list,
> > > or does the absolute priority value have a meaning? I only saw it used
> > > for less_than comparison, maybe I missed it.
> > LOAD as in a memop, we need to go fetch the priority from wherever we
> > put it in memory, be it rq->cpu_priority or a percpu variable on its
> > own.
> > 
> > > 
> > > If you need to express the difference in compute capability, why not use
> > > capacity?
> > Doesn't work, capacity is actually equal with these things.
> > 
> > Think of one core having more turbo range when thermals allow it. But
> > the moment you run multiple cores the thermal head-room dissipates and
> > they all end up running at more or less the same (lower) frequency.
> > 
> > All of this asym/prio stuff only matters when cores (Power) / packages
> > (Intel) are mostly idle.
> > 
> > On Power SMT0 can go faster than SMT7 when all other siblings are idle,
> > with ITMT some core can go faster than other when the rest is idle.
> > 
> > I suppose we _could_ model it with a dynamic capacity value, but last
> > time I looked at that it made my head hurt.
> > 
> > > 
> > > > 
> > > > Also, since we need an interface to pass in this custom list, I don't
> > > > see the distinction, you can do the same manipulation by constantly
> > > > updating the prio list.
> > > Sure, but the overhead of rebuilding the sched_domain hierarchy is huge
> > > compared to just tweaking the result of the less_than operator that get
> > > called from the scheduler frequently. However, updating
> > > group_priority_cpu() would require a rebuild too in this patch set.
> > You don't actually need to rebuild the domains to change the priorities.
> > We only need to rebuild the domains when we add/remove SD_ASYM_PACKING.
> > 
> > Yes, the sched_group::asym_prefer_cpu thing is tedious, but you could
> > actually update that without a rebuild if one wanted.
> > 
> > Note that there's actually a semi useful use case for dynamically
> > updating the cpu priorities: core hopping.
> > 
> >   https://www.researchgate.net/publication/279915789_Evaluation_of_Core_Hopping_on_POWER7
> > 
> > Again, that's something only relevant to mostly idle packages.
> > 
> > > 
> > > > 
> > > > But not of this stuff should be EXPORT'ed, so its only available to the
> > > > core kernel, which greatly limits the potential for abuse. We can see
> > > > arch code just fine.
> > > I don't see why it can't be wired up to be controlled by entities
> > > outside arch code, e.g. cpufreq or the thermal framework, or even code
> > > outside the kernel (firmware).
> > I suppose an arch could do that, but then we'd see that, wouldn't we?
> > 
> > The firmware and kernel would need to co-ordinate where the prio value
> > lives, which is not something trivially done. And even if the value
> > lives in rq->cpu_priority, it _could_ do that.
> > 
> > 
> > In any case, I don't feel too strongly about this, if you want to stick
> > the value in rq->cpu_priority and have Power use that we can do that I
> > suppose.
> 
> This will mean increasing the rq structure for power pc.
> 
> I guess some compile flag to decide if this cpu_priority field should be
> in rq. Something like
> COFIG_SCHED_ITMT || ((CONFIG_PPC64 || CONFIG_PPC32) && CONFIG_SCHED_SMT))?
> 
> And I will need code to power pc to instantiate rp->cpu_priority on boot.
> 
> This gets somewhat ugly.
> 
> I prefer the other alternative Morten suggested by
> having an arch_cpu_asym_priority() function. It is cleaner
> without increasing size or rq structure.
> 
> I can define for default lower cpu having higher priority:
> 
> int __weak arch_cpu_asym_priority(int cpu)
> {
>         return -cpu;
> }
> 
> and then define it appropriately for x86 when ITMT is used.
> 
> Tim
> 

Morten & Peter,

If the patch is updated as below to use arch_asym_cpu_priority,
will that be okay with you?

Tim

---cut---
Subject: sched: Extend scheduler's asym packing

We generalize the scheduler's asym packing to provide an ordering
of the cpu beyond just the cpu number.  This allows the use of the
ASYM_PACKING scheduler machinery to move loads to prefered CPU in a
sched domain. The preference is defined with the cpu priority
given by arch_asym_cpu_priority(cpu).

We also record the most preferred cpu in a sched group when
we build the cpu's capacity for fast lookup of preferred cpu
during load balancing.

v2:
1. Use arch_asym_cpu_priority() to provide cpu priority
value used for asym packing to the scheduler.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 18 ++++++++++++++++++
 kernel/sched/fair.c   | 35 ++++++++++++++++++++++++-----------
 kernel/sched/sched.h  | 12 ++++++++++++
 4 files changed, 56 insertions(+), 11 deletions(-)

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
index e86c4a5..08135ca 100644
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
index 039de34..4976b99 100644
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
 
@@ -7023,8 +7035,8 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (!sds->busiest)
 		return 0;
 
-	busiest_cpu = group_first_cpu(sds->busiest);
-	if (env->dst_cpu > busiest_cpu)
+	busiest_cpu = group_priority_cpu(sds->busiest);
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
index c64fc51..cc2d35f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -532,6 +532,17 @@ struct dl_rq {
 
 #ifdef CONFIG_SMP
 
+static inline bool sched_asym_prefer(int a, int b)
+{
+	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
+}
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
@@ -884,6 +895,7 @@ struct sched_group {
 
 	unsigned int group_weight;
 	struct sched_group_capacity *sgc;
+	int asym_prefer_cpu;		/* cpu of highest priority in group */
 
 	/*
 	 * The CPUs this group covers.
-- 
2.5.5
