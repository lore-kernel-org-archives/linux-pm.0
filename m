From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 29/34] sched: Determine the current sched_group idle-state
Date: Tue, 12 May 2015 20:39:04 +0100
Message-ID: <1431459549-18343-30-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34018 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933678AbbELTjB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:39:01 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

To estimate the energy consumption of a sched_group in
sched_group_energy() it is necessary to know which idle-state the group
is in when it is idle. For now, it is assumed that this is the current
idle-state (though it might be wrong). Based on the individual cpu
idle-states group_idle_state() finds the group idle-state.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b7bc28..19601c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4951,6 +4951,22 @@ static bool cpu_overutilized(int cpu)
 				(get_cpu_usage(cpu) * capacity_margin);
 }
 
+static int group_idle_state(struct sched_group *sg)
+{
+	int i, state = INT_MAX;
+
+	/* Find the shallowest idle state in the sched group. */
+	for_each_cpu(i, sched_group_cpus(sg))
+		state = min(state, idle_get_state_idx(cpu_rq(i)));
+
+	/* Transform system into sched domain idle state. */
+	if (sg->sge->nr_idle_states_below > 1)
+		state -= sg->sge->nr_idle_states_below - 1;
+
+	/* Clamp state to the range of sched domain idle states. */
+	return clamp_t(int, state, 0, sg->sge->nr_idle_states - 1);
+}
+
 /*
  * sched_group_energy(): Returns absolute energy consumption of cpus belonging
  * to the sched_group including shared resources shared only by members of the
@@ -4993,7 +5009,8 @@ static unsigned int sched_group_energy(struct energy_env *eenv)
 
 			do {
 				unsigned long group_util;
-				int sg_busy_energy, sg_idle_energy, cap_idx;
+				int sg_busy_energy, sg_idle_energy;
+				int cap_idx, idle_idx;
 
 				if (sg_shared_cap && sg_shared_cap->group_weight >= sg->group_weight)
 					eenv->sg_cap = sg_shared_cap;
@@ -5001,11 +5018,13 @@ static unsigned int sched_group_energy(struct energy_env *eenv)
 					eenv->sg_cap = sg;
 
 				cap_idx = find_new_capacity(eenv, sg->sge);
+				idle_idx = group_idle_state(sg);
 				group_util = group_norm_usage(eenv, sg);
 				sg_busy_energy = (group_util * sg->sge->cap_states[cap_idx].power)
-										>> SCHED_CAPACITY_SHIFT;
-				sg_idle_energy = ((SCHED_LOAD_SCALE-group_util) * sg->sge->idle_states[0].power)
-										>> SCHED_CAPACITY_SHIFT;
+								>> SCHED_CAPACITY_SHIFT;
+				sg_idle_energy = ((SCHED_LOAD_SCALE-group_util)
+								* sg->sge->idle_states[idle_idx].power)
+								>> SCHED_CAPACITY_SHIFT;
 
 				total_energy += sg_busy_energy + sg_idle_energy;
 
-- 
1.9.1

