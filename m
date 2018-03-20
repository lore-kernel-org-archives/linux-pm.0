From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation helper function
Date: Tue, 20 Mar 2018 09:43:10 +0000
Message-ID: <20180320094312.24081-5-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

In preparation for the definition of an energy-aware wakeup path, a
helper function is provided to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the OPPs to be reached by all frequency domains and estimates
the consumption of each online CPU according to its energy model and its
percentage of busy time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6c72a5e7b1b0..76bd46502486 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6409,6 +6409,30 @@ static inline int cpu_overutilized(int cpu)
 }
 
 /*
+ * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
+	unsigned long capacity = capacity_orig_of(cpu);
+
+	/*
+	 * If p is where it should be, or if it has no impact on cpu, there is
+	 * not much to do.
+	 */
+	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
+		goto clamp_util;
+
+	if (dst_cpu == cpu)
+		util += task_util(p);
+	else
+		util = max_t(long, util - task_util(p), 0);
+
+clamp_util:
+	return (util >= capacity) ? capacity : util;
+}
+
+/*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
  *
@@ -6432,6 +6456,63 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return !util_fits_capacity(task_util(p), min_cap);
 }
 
+static struct capacity_state *find_cap_state(int cpu, unsigned long util)
+{
+	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
+	struct capacity_state *cs = NULL;
+	int i;
+
+	/*
+	 * As the goal is to estimate the OPP reached for a specific util
+	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
+	 */
+	util += util >> 2;
+
+	for (i = 0; i < em->nr_cap_states; i++) {
+		cs = &em->cap_states[i];
+		if (cs->cap >= util)
+			break;
+	}
+
+	return cs;
+}
+
+static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, fdom_max_util;
+	struct capacity_state *cs;
+	unsigned long energy = 0;
+	struct freq_domain *fdom;
+	int cpu;
+
+	for_each_freq_domain(fdom) {
+		fdom_max_util = 0;
+		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			fdom_max_util = max(util, fdom_max_util);
+		}
+
+		/*
+		 * Here we assume that the capacity states of CPUs belonging to
+		 * the same frequency domains are shared. Hence, we look at the
+		 * capacity state of the first CPU and re-use it for all.
+		 */
+		cpu = cpumask_first(&(fdom->span));
+		cs = find_cap_state(cpu, fdom_max_util);
+
+		/*
+		 * The energy consumed by each CPU is derived from the power
+		 * it dissipates at the expected OPP and its percentage of
+		 * busy time.
+		 */
+		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			energy += cs->power * util / cs->cap;
+		}
+	}
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
-- 
2.11.0
