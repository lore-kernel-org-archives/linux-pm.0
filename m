From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 43/46] sched/{fair,cpufreq_sched}: add reset_capacity interface
Date: Tue,  7 Jul 2015 19:24:26 +0100
Message-ID: <1436293469-25707-44-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37750 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932996AbbGGSXv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:23:51 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>

From: Juri Lelli <juri.lelli@arm.com>

When a CPU is going idle it is pointless to ask for an OPP update as we
would wake up another task only to ask for the same capacity we are already
running at (utilization gets moved to blocked_utilization).  We thus add
cpufreq_sched_reset_capacity() interface to just reset our current capacity
request without triggering any real update.  At wakeup we will use the
decayed utilization to select an appropriate OPP.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/cpufreq_sched.c | 12 ++++++++++++
 kernel/sched/fair.c          | 10 +++++++---
 kernel/sched/sched.h         |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
index 7071528..06ff183 100644
--- a/kernel/sched/cpufreq_sched.c
+++ b/kernel/sched/cpufreq_sched.c
@@ -203,6 +203,18 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
 	return;
 }
 
+/**
+ * cpufreq_sched_reset_capacity - interface to scheduler for resetting capacity
+ *                                requests
+ * @cpu: cpu whose capacity request has to be reset
+ *
+ * This _wont trigger_ any capacity update.
+ */
+void cpufreq_sched_reset_cap(int cpu)
+{
+	per_cpu(pcpu_capacity, cpu) = 0;
+}
+
 static inline void set_sched_energy_freq(void)
 {
 	if (!sched_energy_freq())
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb49499..323331f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4427,9 +4427,13 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (sched_energy_freq() && task_sleep) {
 			unsigned long req_cap = get_cpu_usage(cpu_of(rq));
 
-			req_cap = req_cap * capacity_margin
-					>> SCHED_CAPACITY_SHIFT;
-			cpufreq_sched_set_cap(cpu_of(rq), req_cap);
+			if (rq->cfs.nr_running) {
+				req_cap = req_cap * capacity_margin
+						>> SCHED_CAPACITY_SHIFT;
+				cpufreq_sched_set_cap(cpu_of(rq), req_cap);
+			} else {
+				cpufreq_sched_reset_cap(cpu_of(rq));
+			}
 		}
 	}
 	hrtick_update(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 85be5d8..f1ff5bb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1487,9 +1487,12 @@ static inline bool sched_energy_freq(void)
 
 #ifdef CONFIG_CPU_FREQ_GOV_SCHED
 void cpufreq_sched_set_cap(int cpu, unsigned long util);
+void cpufreq_sched_reset_cap(int cpu);
 #else
 static inline void cpufreq_sched_set_cap(int cpu, unsigned long util)
 { }
+static inline void cpufreq_sched_reset_cap(int cpu)
+{ }
 #endif
 
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
-- 
1.9.1

