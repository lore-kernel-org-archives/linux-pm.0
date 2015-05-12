From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 30/34] sched: Add cpu capacity awareness to wakeup balancing
Date: Tue, 12 May 2015 20:39:05 +0100
Message-ID: <1431459549-18343-31-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

Wakeup balancing is completely unaware of cpu capacity, cpu usage and
task utilization. The task is preferably placed on a cpu which is idle
in the instant the wakeup happens. New tasks (SD_BALANCE_{FORK,EXEC} are
placed on an idle cpu in the idlest group if such can be found, otherwise
it goes on the least loaded one. Existing tasks (SD_BALANCE_WAKE) are
placed on the previous cpu or an idle cpu sharing the same last level
cache. Hence existing tasks don't get a chance to migrate to a different
group at wakeup in case the current one has reduced cpu capacity (due
RT/IRQ pressure or different uarch e.g. ARM big.LITTLE). They may
eventually get pulled by other cpus doing periodic/idle/nohz_idle
balance, but it may take quite a while before it happens.

This patch adds capacity awareness to find_idlest_{group,queue} (used by
SD_BALANCE_{FORK,EXEC}) such that groups/cpus that can accommodate the
waking task based on task utilization are preferred. In addition, wakeup
of existing tasks (SD_BALANCE_WAKE) is sent through
find_idlest_{group,queue} if the task doesn't fit the capacity of the
previous cpu to allow it to escape (override wake_affine) when
necessary instead of relying on periodic/idle/nohz_idle balance to
eventually sort it out.

The patch doesn't depend on any energy model infrastructure, but it is
kept behind the energy_aware() static key despite being primarily a
performance optimization as it may increase scheduler overhead slightly.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98a83e4..ec46248 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6315,7 +6315,7 @@ sd_init(struct sched_domain_topology_level *tl, int cpu)
 					| 1*SD_BALANCE_NEWIDLE
 					| 1*SD_BALANCE_EXEC
 					| 1*SD_BALANCE_FORK
-					| 0*SD_BALANCE_WAKE
+					| 1*SD_BALANCE_WAKE
 					| 1*SD_WAKE_AFFINE
 					| 0*SD_SHARE_CPUCAPACITY
 					| 0*SD_SHARE_PKG_RESOURCES
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19601c9..bb44646 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5190,6 +5190,39 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
 	return 1;
 }
 
+static inline unsigned long task_utilization(struct task_struct *p)
+{
+	return p->se.avg.utilization_avg_contrib;
+}
+
+static inline bool __task_fits(struct task_struct *p, int cpu, int usage)
+{
+	unsigned long capacity = capacity_of(cpu);
+
+	usage += task_utilization(p);
+
+	return (capacity * 1024) > (usage * capacity_margin);
+}
+
+static inline bool task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned long capacity = capacity_of(cpu);
+	unsigned long max_capacity = cpu_rq(cpu)->rd->max_cpu_capacity;
+
+	if (capacity == max_capacity)
+		return true;
+
+	if (capacity * capacity_margin > max_capacity * 1024)
+		return true;
+
+	return __task_fits(p, cpu, 0);
+}
+
+static inline bool task_fits_cpu(struct task_struct *p, int cpu)
+{
+	return __task_fits(p, cpu, get_cpu_usage(cpu));
+}
+
 /*
  * find_idlest_group finds and returns the least busy CPU group within the
  * domain.
@@ -5199,7 +5232,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		  int this_cpu, int sd_flag)
 {
 	struct sched_group *idlest = NULL, *group = sd->groups;
+	struct sched_group *fit_group = NULL;
 	unsigned long min_load = ULONG_MAX, this_load = 0;
+	unsigned long fit_capacity = ULONG_MAX;
 	int load_idx = sd->forkexec_idx;
 	int imbalance = 100 + (sd->imbalance_pct-100)/2;
 
@@ -5230,6 +5265,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 				load = target_load(i, load_idx);
 
 			avg_load += load;
+
+			if (energy_aware() && capacity_of(i) < fit_capacity &&
+			    task_fits_cpu(p, i)) {
+				fit_capacity = capacity_of(i);
+				fit_group = group;
+			}
 		}
 
 		/* Adjust by relative CPU capacity of the group */
@@ -5243,6 +5284,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		}
 	} while (group = group->next, group != sd->groups);
 
+	if (fit_group)
+		return fit_group;
+
 	if (!idlest || 100*this_load < imbalance*min_load)
 		return NULL;
 	return idlest;
@@ -5263,7 +5307,7 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
-		if (idle_cpu(i)) {
+		if (task_fits_cpu(p, i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
@@ -5275,7 +5319,8 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 				min_exit_latency = idle->exit_latency;
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
-			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
+			} else if (idle_cpu(i) &&
+				   (!idle || idle->exit_latency == min_exit_latency) &&
 				   rq->idle_stamp > latest_idle_timestamp) {
 				/*
 				 * If equal or no active idle state, then
@@ -5284,6 +5329,13 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 				 */
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
+			} else if (shallowest_idle_cpu == -1) {
+				/*
+				 * If we haven't found an idle CPU yet
+				 * pick a non-idle one that can fit the task as
+				 * fallback.
+				 */
+				shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
 			load = weighted_cpuload(i);
@@ -5361,9 +5413,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int cpu = smp_processor_id();
 	int new_cpu = cpu;
 	int want_affine = 0;
+	int want_sibling = true;
 	int sync = wake_flags & WF_SYNC;
 
-	if (sd_flag & SD_BALANCE_WAKE)
+	/* Check if prev_cpu can fit us ignoring its current usage */
+	if (energy_aware() && !task_fits_capacity(p, prev_cpu))
+		want_sibling = false;
+
+	if (sd_flag & SD_BALANCE_WAKE && want_sibling)
 		want_affine = cpumask_test_cpu(cpu, tsk_cpus_allowed(p));
 
 	rcu_read_lock();
@@ -5388,7 +5445,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	if (affine_sd && cpu != prev_cpu && wake_affine(affine_sd, p, sync))
 		prev_cpu = cpu;
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (sd_flag & SD_BALANCE_WAKE && want_sibling) {
 		new_cpu = select_idle_sibling(p, prev_cpu);
 		goto unlock;
 	}
-- 
1.9.1
