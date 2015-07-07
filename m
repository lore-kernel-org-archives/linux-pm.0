From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 33/46] sched: Consider a not over-utilized energy-aware system as balanced
Date: Tue,  7 Jul 2015 19:24:16 +0100
Message-ID: <1436293469-25707-34-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37637 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932937AbbGGSXY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:23:24 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

In case the system operates below the tipping point indicator,
introduced in ("sched: Add over-utilization/tipping point
indicator"), bail out in find_busiest_group after the dst and src
group statistics have been checked.

There is simply no need to move usage around because all involved
cpus still have spare cycles available.

For an energy-aware system below its tipping point,  we rely on the
task placement of the wakeup path. This works well for short running
tasks.

The existence of long running tasks on one of the involved cpus lets
the system operate over its tipping point. To be able to move such
a task (whose load can't be used to average the load among the cpus)
from a src cpu with lower capacity than the dst_cpu, an additional
rule has to be implemented in need_active_balance.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 01f7337..48ecf02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7382,6 +7382,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
+
+	if (energy_aware() && !env->dst_rq->rd->overutilized)
+		goto out_balanced;
+
 	local = &sds.local_stat;
 	busiest = &sds.busiest_stat;
 
-- 
1.9.1

