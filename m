From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation helper function
Date: Fri,  6 Apr 2018 16:36:05 +0100
Message-ID: <20180406153607.17815-5-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
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
 include/linux/sched/energy.h | 20 +++++++++++++
 kernel/sched/fair.c          | 68 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h         |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
index 941071eec013..b4110b145228 100644
--- a/include/linux/sched/energy.h
+++ b/include/linux/sched/energy.h
@@ -27,6 +27,24 @@ static inline bool sched_energy_enabled(void)
 	return static_branch_unlikely(&sched_energy_present);
 }
 
+static inline
+struct capacity_state *find_cap_state(int cpu, unsigned long util)
+{
+	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
+	struct capacity_state *cs = NULL;
+	int i;
+
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
 static inline struct cpumask *freq_domain_span(struct freq_domain *fd)
 {
 	return &fd->span;
@@ -42,6 +60,8 @@ struct freq_domain;
 static inline bool sched_energy_enabled(void) { return false; }
 static inline struct cpumask
 *freq_domain_span(struct freq_domain *fd) { return NULL; }
+static inline struct capacity_state
+*find_cap_state(int cpu, unsigned long util) { return NULL; }
 static inline void init_sched_energy(void) { }
 #define for_each_freq_domain(fdom) for (; fdom; fdom = NULL)
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6960e5ef3c14..8cb9fb04fff2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6633,6 +6633,74 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 }
 
 /*
+ * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, util_est;
+	struct cfs_rq *cfs_rq;
+
+	/* Task is where it should be, or has no impact on cpu */
+	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
+		return cpu_util(cpu);
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	if (dst_cpu == cpu)
+		util += task_util(p);
+	else
+		util = max_t(long, util - task_util(p), 0);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+		else
+			util_est = max_t(long, util_est - _task_util_est(p), 0);
+		util = max(util, util_est);
+	}
+
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
+}
+
+/*
+ * Estimates the system level energy assuming that p wakes-up on dst_cpu.
+ *
+ * compute_energy() is safe to call only if an energy model is available for
+ * the platform, which is when sched_energy_enabled() is true.
+ */
+static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
+{
+	unsigned long util, max_util, sum_util;
+	struct capacity_state *cs;
+	unsigned long energy = 0;
+	struct freq_domain *fd;
+	int cpu;
+
+	for_each_freq_domain(fd) {
+		max_util = sum_util = 0;
+		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util += cpu_util_dl(cpu_rq(cpu));
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		/*
+		 * Here we assume that the capacity states of CPUs belonging to
+		 * the same frequency domains are shared. Hence, we look at the
+		 * capacity state of the first CPU and re-use it for all.
+		 */
+		cpu = cpumask_first(freq_domain_span(fd));
+		cs = find_cap_state(cpu, max_util);
+		energy += cs->power * sum_util / cs->cap;
+	}
+
+	return energy;
+}
+
+/*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5d552c0d7109..6eb38f41d5d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2156,7 +2156,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+#ifdef CONFIG_SMP
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-- 
2.11.0
