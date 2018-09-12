From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate platforms
Date: Wed, 12 Sep 2018 10:13:03 +0100
Message-ID: <20180912091309.7551-9-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Energy Aware Scheduling (EAS) in its current form is most relevant on
platforms with asymmetric CPU topologies (e.g. Arm big.LITTLE) since
this is where there is a lot of potential for saving energy through
scheduling. This is particularly true since the Energy Model only
includes the active power costs of CPUs, hence not providing enough data
to compare packing-vs-spreading strategies.

As such, disable EAS on root domains where the SD_ASYM_CPUCAPACITY flag
is not set. While at it, disable EAS on systems where the complexity of
the Energy Model is too high since that could lead to unacceptable
scheduling overhead.

All in all, EAS can be used on a root domain if and only if:
  1. the ENERGY_AWARE sched_feat is enabled;
  2. the root domain has an asymmetric CPU capacity topology;
  3. the complexity of the root domain's EM is low enough to keep
     scheduling overheads low.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/topology.c | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10e37ffea19a..0d18d69b719c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -270,12 +270,45 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+/*
+ * EAS can be used on a root domain if it meets all the following conditions:
+ *    1. the ENERGY_AWARE sched_feat is enabled;
+ *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
+ *    3. the EM complexity is low enough to keep scheduling overheads low;
+ *
+ * The complexity of the Energy Model is defined as:
+ *
+ *              C = nr_pd * (nr_cpus + nr_cs)
+ *
+ * with parameters defined as:
+ *  - nr_pd:    the number of performance domains
+ *  - nr_cpus:  the number of CPUs
+ *  - nr_cs:    the sum of the number of capacity states of all performance
+ *              domains (for example, on a system with 2 performance domains,
+ *              with 10 capacity states each, nr_cs = 2 * 10 = 20).
+ *
+ * It is generally not a good idea to use such a model in the wake-up path on
+ * very complex platforms because of the associated scheduling overheads. The
+ * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
+ * with per-CPU DVFS and less than 8 capacity states each, for example.
+ */
+#define EM_MAX_COMPLEXITY 2048
+
 static void build_perf_domains(const struct cpumask *cpu_map)
 {
+	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
+					cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
 
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
@@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
+
+		/*
+		 * Count performance domains and capacity states for the
+		 * complexity check.
+		 */
+		nr_pd++;
+		nr_cs += em_pd_nr_cap_states(pd->obj);
+	}
+
+	/* Bail out if the Energy Model complexity is too high. */
+	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
+		if (sched_debug())
+			pr_info("rd %*pbl: EM complexity is too high\n ",
+						cpumask_pr_args(cpu_map));
+		goto free;
 	}
 
 	perf_domain_debug(cpu_map, pd);
-- 
2.18.0
