From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 28/34] sched: Count number of shallower idle-states in struct sched_group_energy
Date: Tue, 12 May 2015 20:39:03 +0100
Message-ID: <1431459549-18343-29-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

cpuidle associates all idle-states with each cpu while the energy model
associates them with the sched_group covering the cpus coordinating
entry to the idle-state. To look up the idle-state power consumption in
the energy model it is therefore necessary to translate from cpuidle
idle-state index to energy model index. For this purpose it is helpful
to know how many idle-states that are listed in lower level sched_groups
(in struct sched_group_energy).

Example: ARMv8 big.LITTLE JUNO (Cortex A57, A53) idle-states:
Idle-state              cpuidle         Energy model table indices
                        index           per-cpu sg      per-cluster sg
WFI                     0               0               (0)
Core power-down         1               1               0*
Cluster power-down      2               (1)             1

For per-cpu sgs no translation is required. If cpuidle reports state
index 0 or 1, the cpu is in WFI or core power-down, respectively. We can
look the idle-power up directly in the sg energy model table. Idle-state
cluster power-down, is represented in the per-cluster sg energy model
table as index 1. Index 0* is reserved for cluster power consumption
when the cpus all are in state 0 or 1, but cpuidle decided not to go for
cluster power-down. Given the index from cpuidle we can compute the
correct index in the energy model tables for the sgs at each level if we
know how many states are in the tables in the child sgs. The actual
translation is implemented in a later patch.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fe77e54..9ea43cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1027,6 +1027,7 @@ struct sched_group_energy {
 	atomic_t ref;
 	unsigned int nr_idle_states;	/* number of idle states */
 	struct idle_state *idle_states;	/* ptr to idle state array */
+	unsigned int nr_idle_states_below; /* number idle states in lower groups */
 	unsigned int nr_cap_states;	/* number of capacity states */
 	struct capacity_state *cap_states; /* ptr to capacity state array */
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d307db8..98a83e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6109,6 +6109,7 @@ static void init_sched_energy(int cpu, struct sched_domain *sd,
 	struct sched_group_energy *energy = sg->sge;
 	sched_domain_energy_f fn = tl->energy;
 	struct cpumask *mask = sched_group_cpus(sg);
+	int nr_idle_states_below = 0;
 
 	if (fn && sd->child && !sd->child->groups->sge) {
 		pr_err("BUG: EAS setup broken for CPU%d\n", cpu);
@@ -6133,9 +6134,20 @@ static void init_sched_energy(int cpu, struct sched_domain *sd,
 	if (cpumask_weight(mask) > 1)
 		check_sched_energy_data(cpu, fn, mask);
 
+	/* Figure out the number of true cpuidle states below current group */
+	sd = sd->child;
+	for_each_lower_domain(sd) {
+		nr_idle_states_below += sd->groups->sge->nr_idle_states;
+
+		/* Disregard non-cpuidle 'active' idle states */
+		if (sd->child)
+			nr_idle_states_below--;
+	}
+
 	energy->nr_idle_states = fn(cpu)->nr_idle_states;
 	memcpy(energy->idle_states, fn(cpu)->idle_states,
 	       energy->nr_idle_states*sizeof(struct idle_state));
+	energy->nr_idle_states_below = nr_idle_states_below;
 	energy->nr_cap_states = fn(cpu)->nr_cap_states;
 	memcpy(energy->cap_states, fn(cpu)->cap_states,
 	       energy->nr_cap_states*sizeof(struct capacity_state));
-- 
1.9.1
