From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 04/14] sched/{fair,cpufreq_sched}: add reset_capacity interface
Date: Wed, 19 Aug 2015 19:47:14 +0100
Message-ID: <1440010044-3402-5-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53355 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbbHSSrr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Aug 2015 14:47:47 -0400
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>

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
 kernel/sched/fair.c          |  8 ++++++--
 kernel/sched/sched.h         |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
index 2968f3a..e6b4a22 100644
--- a/kernel/sched/cpufreq_sched.c
+++ b/kernel/sched/cpufreq_sched.c
@@ -203,6 +203,18 @@ out:
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
index a75ea07..2961e29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4218,8 +4218,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		 * during load balancing, but in these cases it seems wise to trigger
 		 * as single request after load balancing is done.
 		 */
-		if (task_sleep)
-			update_capacity_of(cpu_of(rq));
+		if (task_sleep) {
+			if (rq->cfs.nr_running)
+				update_capacity_of(cpu_of(rq));
+			else if (sched_energy_freq())
+				cpufreq_sched_reset_cap(cpu_of(rq));
+		}
 	}
 	hrtick_update(rq);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f0b433..ad9293b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1424,9 +1424,12 @@ static inline bool sched_energy_freq(void)
 
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
2.5.0

