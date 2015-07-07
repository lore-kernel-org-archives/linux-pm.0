From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 34/46] sched: Enable idle balance to pull single task towards cpu with higher capacity
Date: Tue,  7 Jul 2015 19:24:17 +0100
Message-ID: <1436293469-25707-35-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37647 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942AbbGGSX1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:23:27 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

We do not want to miss out on the ability to pull a single remaining
task from a potential source cpu towards an idle destination cpu if the
energy aware system operates above the tipping point.

Add an extra criteria to need_active_balance() to kick off active load
balance if the source cpu is over-utilized and has lower capacity than
the destination cpu.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48ecf02..97eb83e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7569,6 +7569,13 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
+	if ((capacity_of(env->src_cpu) < capacity_of(env->dst_cpu)) &&
+				env->src_rq->cfs.h_nr_running == 1 &&
+				cpu_overutilized(env->src_cpu) &&
+				!cpu_overutilized(env->dst_cpu)) {
+			return 1;
+	}
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
@@ -7923,7 +7930,8 @@ static int idle_balance(struct rq *this_rq)
 	this_rq->idle_stamp = rq_clock(this_rq);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	    (!energy_aware() && !this_rq->rd->overload) ||
+	    (energy_aware() && !this_rq->rd->overutilized)) {
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
-- 
1.9.1

