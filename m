From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v7 11/14] sched/fair: Introduce an energy estimation helper function
Date: Wed, 12 Sep 2018 10:13:06 +0100
Message-ID: <20180912091309.7551-12-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

In preparation for the definition of an energy-aware wakeup path,
introduce a helper function to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the capacity state to be reached by all performance domains
and estimates the consumption of each online CPU according to its Energy
Model and its percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 648482f35458..7ee3e43cdaf2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6262,6 +6262,83 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return !task_fits_capacity(p, min_cap);
 }
 
+/*
+ * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
+ * to @dst_cpu.
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	/*
+	 * If @p migrates from @cpu to another, remove its contribution. Or,
+	 * if @p migrates from another CPU to @cpu, add its contribution. In
+	 * the other cases, @cpu is not impacted by the migration, so the
+	 * util_avg should already be correct.
+	 */
+	if (task_cpu(p) == cpu && dst_cpu != cpu)
+		util = max_t(long, util - task_util(p), 0);
+	else if (task_cpu(p) != cpu && dst_cpu == cpu)
+		util += task_util(p);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * During wake-up, the task isn't enqueued yet and doesn't
+		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
+		 * so just add it (if needed) to "simulate" what will be
+		 * cpu_util() after the task has been enqueued.
+		 */
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+
+		util = max(util, util_est);
+	}
+
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
+}
+
+/*
+ * compute_energy(): Estimates the energy that would be consumed if @p was
+ * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
+ * landscape of the * CPUs after the task migration, and uses the Energy Model
+ * to compute what would be the energy if we decided to actually migrate that
+ * task.
+ */
+static long compute_energy(struct task_struct *p, int dst_cpu,
+							struct perf_domain *pd)
+{
+	long util, max_util, sum_util, energy = 0;
+	int cpu;
+
+	while (pd) {
+		max_util = sum_util = 0;
+		/*
+		 * The capacity state of CPUs of the current rd can be driven by
+		 * CPUs of another rd if they belong to the same performance
+		 * domain. So, account for the utilization of these CPUs too
+		 * by masking pd with cpu_online_mask instead of the rd span.
+		 *
+		 * If an entire performance domain is outside of the current rd,
+		 * it will not appear in its pd list and will not be accounted
+		 * by compute_energy().
+		 */
+		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util = schedutil_freq_util(cpu, util, ENERGY_UTIL);
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		energy += em_pd_energy(pd->obj, max_util, sum_util);
+		pd = pd->next;
+	}
+
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
-- 
2.18.0
