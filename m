From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 24/34] sched: Estimate energy impact of scheduling decisions
Date: Tue, 12 May 2015 20:38:59 +0100
Message-ID: <1431459549-18343-25-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33966 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933966AbbELTis (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:38:48 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

Adds a generic energy-aware helper function, energy_diff(), that
calculates energy impact of adding, removing, and migrating utilization
in the system.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52403e9..f36ab2f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5011,6 +5011,57 @@ static unsigned int sched_group_energy(struct energy_env *eenv)
 	return total_energy;
 }
 
+/*
+ * energy_diff(): Estimate the energy impact of changing the utilization
+ * distribution. eenv specifies the change: utilisation amount, source, and
+ * destination cpu. Source or destination cpu may be -1 in which case the
+ * utilization is removed from or added to the system (e.g. task wake-up). If
+ * both are specified, the utilization is migrated.
+ */
+static int energy_diff(struct energy_env *eenv)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+	int sd_cpu = -1, energy_before = 0, energy_after = 0;
+
+	struct energy_env eenv_before = {
+		.usage_delta	= 0,
+		.src_cpu	= eenv->src_cpu,
+		.dst_cpu	= eenv->dst_cpu,
+	};
+
+	if (eenv->src_cpu == eenv->dst_cpu)
+		return 0;
+
+	sd_cpu = (eenv->src_cpu != -1) ? eenv->src_cpu : eenv->dst_cpu;
+	sd = rcu_dereference(per_cpu(sd_ea, sd_cpu));
+
+	if (!sd)
+		return 0; /* Error */
+
+	sg = sd->groups;
+	do {
+		if (eenv->src_cpu != -1 && cpumask_test_cpu(eenv->src_cpu,
+							sched_group_cpus(sg))) {
+			eenv_before.sg_top = eenv->sg_top = sg;
+			energy_before += sched_group_energy(&eenv_before);
+			energy_after += sched_group_energy(eenv);
+
+			/* src_cpu and dst_cpu may belong to the same group */
+			continue;
+		}
+
+		if (eenv->dst_cpu != -1	&& cpumask_test_cpu(eenv->dst_cpu,
+							sched_group_cpus(sg))) {
+			eenv_before.sg_top = eenv->sg_top = sg;
+			energy_before += sched_group_energy(&eenv_before);
+			energy_after += sched_group_energy(eenv);
+		}
+	} while (sg = sg->next, sg != sd->groups);
+
+	return energy_after-energy_before;
+}
+
 static int wake_wide(struct task_struct *p)
 {
 	int factor = this_cpu_read(sd_llc_size);
-- 
1.9.1

