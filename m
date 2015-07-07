From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 11/46] sched: Remove blocked load and utilization contributions of dying tasks
Date: Tue,  7 Jul 2015 19:23:54 +0100
Message-ID: <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37414 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932782AbbGGSW3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:22:29 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Tasks being dequeued for the last time (state == TASK_DEAD) are dequeued
with the DEQUEUE_SLEEP flag which causes their load and utilization
contributions to be added to the runqueue blocked load and utilization.
Hence they will contain load or utilization that is gone away. The issue
only exists for the root cfs_rq as cgroup_exit() doesn't set
DEQUEUE_SLEEP for task group exits.

If runnable+blocked load is to be used as a better estimate for cpu
load the dead task contributions need to be removed to prevent
load_balance() (idle_balance() in particular) from over-estimating the
cpu load.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 775b0c7..fa12ce5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3217,6 +3217,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * Update run-time statistics of the 'current'.
 	 */
 	update_curr(cfs_rq);
+	if (entity_is_task(se) && task_of(se)->state == TASK_DEAD)
+		flags &= !DEQUEUE_SLEEP;
 	dequeue_entity_load_avg(cfs_rq, se, flags & DEQUEUE_SLEEP);
 
 	update_stats_dequeue(cfs_rq, se);
-- 
1.9.1

