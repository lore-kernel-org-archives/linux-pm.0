From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 05/14] sched/fair: jump to max OPP when crossing UP threshold
Date: Wed, 19 Aug 2015 19:47:15 +0100
Message-ID: <1440010044-3402-6-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Since the true utilization of a long running task is not detectable while
it is running and might be bigger than the current cpu capacity, create the
maximum cpu capacity head room by requesting the maximum cpu capacity once
the cpu usage plus the capacity margin exceeds the current capacity. This
is also done to try to harm the performance of a task the least.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/fair.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2961e29..6197b3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7864,6 +7864,24 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (numabalancing_enabled)
 		task_tick_numa(rq, curr);
+
+	/*
+	 * To make free room for a task that is building up its "real"
+	 * utilization and to harm its performance the least, request a
+	 * jump to max OPP as soon as get_cpu_usage() crosses the UP
+	 * threshold. The UP threshold is built relative to the current
+	 * capacity (OPP), by using capacity_margin.
+	 */
+	if (sched_energy_freq()) {
+		int cpu = cpu_of(rq);
+		unsigned long capacity_orig = capacity_orig_of(cpu);
+		unsigned long capacity_curr = capacity_curr_of(cpu);
+
+		if (capacity_curr < capacity_orig &&
+		    (capacity_curr * SCHED_LOAD_SCALE) <
+		    (cpu_util(cpu) * capacity_margin))
+			cpufreq_sched_set_cap(cpu, capacity_orig);
+	}
 }
 
 /*
-- 
2.5.0
