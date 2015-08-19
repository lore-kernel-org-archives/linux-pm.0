From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 07/14] sched/fair: cpufreq_sched triggers for load balancing
Date: Wed, 19 Aug 2015 19:47:17 +0100
Message-ID: <1440010044-3402-8-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

As we don't trigger freq changes from {en,de}queue_task_fair() during load
balancing, we need to do explicitly so on load balancing paths.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/fair.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6197b3b..955dfe1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7030,6 +7030,11 @@ more_balance:
 		 * ld_moved     - cumulative load moved across iterations
 		 */
 		cur_ld_moved = detach_tasks(&env);
+		/*
+		 * We want to potentially lower env.src_cpu's OPP.
+		 */
+		if (cur_ld_moved)
+			update_capacity_of(env.src_cpu);
 
 		/*
 		 * We've detached some tasks from busiest_rq. Every
@@ -7044,6 +7049,10 @@ more_balance:
 		if (cur_ld_moved) {
 			attach_tasks(&env);
 			ld_moved += cur_ld_moved;
+			/*
+			 * We want to potentially raise env.dst_cpu's OPP.
+			 */
+			update_capacity_of(env.dst_cpu);
 		}
 
 		local_irq_restore(flags);
@@ -7398,8 +7407,13 @@ static int active_load_balance_cpu_stop(void *data)
 		schedstat_inc(sd, alb_count);
 
 		p = detach_one_task(&env);
-		if (p)
+		if (p) {
 			schedstat_inc(sd, alb_pushed);
+			/*
+			 * We want to potentially lower env.src_cpu's OPP.
+			 */
+			update_capacity_of(env.src_cpu);
+		}
 		else
 			schedstat_inc(sd, alb_failed);
 	}
@@ -7408,8 +7422,13 @@ out_unlock:
 	busiest_rq->active_balance = 0;
 	raw_spin_unlock(&busiest_rq->lock);
 
-	if (p)
+	if (p) {
 		attach_one_task(target_rq, p);
+		/*
+		 * We want to potentially raise target_cpu's OPP.
+		 */
+		update_capacity_of(target_cpu);
+	}
 
 	local_irq_enable();
 
-- 
2.5.0
