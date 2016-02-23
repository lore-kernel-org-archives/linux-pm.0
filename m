From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 06/10] sched/fair: cpufreq_sched triggers for load balancing
Date: Mon, 22 Feb 2016 17:22:46 -0800
Message-ID: <1456190570-4475-7-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35339 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbcBWBXC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 20:23:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so103056698pac.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 17:23:01 -0800 (PST)
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Juri Lelli <juri.lelli@arm.com>

From: Juri Lelli <juri.lelli@arm.com>

As we don't trigger freq changes from {en,de}queue_task_fair() during load
balancing, we need to do explicitly so on load balancing paths.

[smuckle@linaro.org: move update_capacity_of calls so rq lock is held]

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/fair.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7fab8f..5531513 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6107,6 +6107,10 @@ static void attach_one_task(struct rq *rq, struct task_struct *p)
 {
 	raw_spin_lock(&rq->lock);
 	attach_task(rq, p);
+	/*
+	 * We want to potentially raise target_cpu's OPP.
+	 */
+	update_capacity_of(cpu_of(rq));
 	raw_spin_unlock(&rq->lock);
 }
 
@@ -6128,6 +6132,11 @@ static void attach_tasks(struct lb_env *env)
 		attach_task(env->dst_rq, p);
 	}
 
+	/*
+	 * We want to potentially raise env.dst_cpu's OPP.
+	 */
+	update_capacity_of(env->dst_cpu);
+
 	raw_spin_unlock(&env->dst_rq->lock);
 }
 
@@ -7267,6 +7276,11 @@ more_balance:
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
@@ -7631,8 +7645,13 @@ static int active_load_balance_cpu_stop(void *data)
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
-- 
2.4.10

