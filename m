From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 46/46] sched/fair: cpufreq_sched triggers for load balancing
Date: Tue,  7 Jul 2015 19:24:29 +0100
Message-ID: <1436293469-25707-47-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37781 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933024AbbGGSX7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:23:59 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>

From: Juri Lelli <juri.lelli@arm.com>

As we don't trigger freq changes from {en,de}queue_task_fair() during load
balancing, we need to do explicitly so on load balancing paths.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c2d6de4..c513b19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7741,6 +7741,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * ld_moved     - cumulative load moved across iterations
 		 */
 		cur_ld_moved = detach_tasks(&env);
+		/*
+		 * We want to potentially update env.src_cpu's OPP.
+		 *
+		 * Add a margin (same ~20% used for the tipping point)
+		 * to our request to provide some head room for the remaining
+		 * tasks.
+		 */
+		if (sched_energy_freq() && cur_ld_moved) {
+			unsigned long req_cap = get_cpu_usage(env.src_cpu);
+
+			req_cap = req_cap * capacity_margin
+					>> SCHED_CAPACITY_SHIFT;
+			cpufreq_sched_set_cap(env.src_cpu, req_cap);
+		}
 
 		/*
 		 * We've detached some tasks from busiest_rq. Every
@@ -7755,6 +7769,21 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if (cur_ld_moved) {
 			attach_tasks(&env);
 			ld_moved += cur_ld_moved;
+			/*
+			 * We want to potentially update env.dst_cpu's OPP.
+			 *
+			 * Add a margin (same ~20% used for the tipping point)
+			 * to our request to provide some head room if p's
+			 * utilization further increases.
+			 */
+			if (sched_energy_freq()) {
+				unsigned long req_cap =
+					get_cpu_usage(env.dst_cpu);
+
+				req_cap = req_cap * capacity_margin
+						>> SCHED_CAPACITY_SHIFT;
+				cpufreq_sched_set_cap(env.dst_cpu, req_cap);
+			}
 		}
 
 		local_irq_restore(flags);
@@ -8114,8 +8143,24 @@ static int active_load_balance_cpu_stop(void *data)
 		schedstat_inc(sd, alb_count);
 
 		p = detach_one_task(&env);
-		if (p)
+		if (p) {
 			schedstat_inc(sd, alb_pushed);
+			/*
+			 * We want to potentially update env.src_cpu's OPP.
+			 *
+			 * Add a margin (same ~20% used for the tipping point)
+			 * to our request to provide some head room for the
+			 * remaining task.
+			 */
+			if (sched_energy_freq()) {
+				unsigned long req_cap =
+					get_cpu_usage(env.src_cpu);
+
+				req_cap = req_cap * capacity_margin
+						>> SCHED_CAPACITY_SHIFT;
+				cpufreq_sched_set_cap(env.src_cpu, req_cap);
+			}
+		}
 		else
 			schedstat_inc(sd, alb_failed);
 	}
@@ -8124,8 +8169,23 @@ static int active_load_balance_cpu_stop(void *data)
 	busiest_rq->active_balance = 0;
 	raw_spin_unlock(&busiest_rq->lock);
 
-	if (p)
+	if (p) {
 		attach_one_task(target_rq, p);
+		/*
+		 * We want to potentially update target_cpu's OPP.
+		 *
+		 * Add a margin (same ~20% used for the tipping point)
+		 * to our request to provide some head room if p's utilization
+		 * further increases.
+		 */
+		if (sched_energy_freq()) {
+			unsigned long req_cap = get_cpu_usage(target_cpu);
+
+			req_cap = req_cap * capacity_margin
+					>> SCHED_CAPACITY_SHIFT;
+			cpufreq_sched_set_cap(target_cpu, req_cap);
+		}
+	}
 
 	local_irq_enable();
 
-- 
1.9.1

