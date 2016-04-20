From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFC PATCH 4/4] sched/fair: call cpufreq hook for remote wakeups
Date: Tue, 19 Apr 2016 19:39:29 -0700
Message-ID: <1461119969-10371-4-git-send-email-smuckle@linaro.org>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Without calling the cpufreq hook for a remote wakeup it is possible
for such a wakeup to go unnoticed by cpufreq on the target CPU for up
to a full tick. This can occur if the target CPU is running a
CPU-bound task.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c  |  8 +++-----
 kernel/sched/sched.h | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b06c1e938cb9..d21a80a44b6e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2826,15 +2826,13 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 
-	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
+	if (&rq->cfs == cfs_rq) {
 		unsigned long max = rq->cpu_capacity_orig;
 
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
-		 * a real problem -- added to that it only calls on the local
-		 * CPU, so if we enqueue remotely we'll miss an update, but
-		 * the next tick/schedule should update.
+		 * a real problem.
 		 *
 		 * It will not get called when we go idle, because the idle
 		 * thread is a different class (!fair), nor will the utilization
@@ -2845,7 +2843,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
 		 *
 		 * See cpu_util().
 		 */
-		cpufreq_update_util(rq_clock(rq),
+		cpufreq_update_util(cpu, rq_clock(rq),
 				    min(cfs_rq->avg.util_avg, max), max);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 921d6e5d33b7..a8a1eb603263 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1799,6 +1799,7 @@ DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @cpu: Target CPU.
  * @time: Current time.
  * @util: Current utilization.
  * @max: Utilization ceiling.
@@ -1808,13 +1809,14 @@ DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
  *
  * It can only be called from RCU-sched read-side critical sections.
  */
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+static inline void cpufreq_update_util(int cpu, u64 time, unsigned long util,
+				       unsigned long max)
 {
-       struct update_util_data *data;
+	struct update_util_data *data;
 
-       data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-       if (data)
-               data->func(data, time, util, max);
+	data = rcu_dereference_sched(per_cpu(cpufreq_update_util_data, cpu));
+	if (data)
+		data->func(data, time, util, max);
 }
 
 /**
@@ -1835,10 +1837,11 @@ static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned lo
  */
 static inline void cpufreq_trigger_update(u64 time)
 {
-	cpufreq_update_util(time, ULONG_MAX, 0);
+	cpufreq_update_util(smp_processor_id(), time, ULONG_MAX, 0);
 }
 #else
-static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max) {}
+static inline void cpufreq_update_util(int cpu, u64 time, unsigned long util,
+				       unsigned long max) {}
 static inline void cpufreq_trigger_update(u64 time) {}
 #endif /* CONFIG_CPU_FREQ */
 
-- 
2.4.10
