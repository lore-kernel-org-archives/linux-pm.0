From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 10/34] sched: Include blocked utilization in usage tracking
Date: Tue, 12 May 2015 20:38:45 +0100
Message-ID: <1431459549-18343-11-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33813 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762AbbELTiM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:38:12 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

Add the blocked utilization contribution to group sched_entity
utilization (se->avg.utilization_avg_contrib) and to get_cpu_usage().
With this change cpu usage now includes recent usage by currently
non-runnable tasks, hence it provides a more stable view of the cpu
usage. It does, however, also mean that the meaning of usage is changed:
A cpu may be momentarily idle while usage is >0. It can no longer be
assumed that cpu usage >0 implies runnable tasks on the rq.
cfs_rq->utilization_load_avg or nr_running should be used instead to get
the current rq status.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad07398..e40cd88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2789,7 +2789,8 @@ static long __update_entity_utilization_avg_contrib(struct sched_entity *se)
 		__update_task_entity_utilization(se);
 	else
 		se->avg.utilization_avg_contrib =
-					group_cfs_rq(se)->utilization_load_avg;
+				group_cfs_rq(se)->utilization_load_avg +
+				group_cfs_rq(se)->utilization_blocked_avg;
 
 	return se->avg.utilization_avg_contrib - old_contrib;
 }
@@ -5046,13 +5047,17 @@ static int select_idle_sibling(struct task_struct *p, int target)
 
 static int get_cpu_usage(int cpu)
 {
+	int sum;
 	unsigned long usage = cpu_rq(cpu)->cfs.utilization_load_avg;
+	unsigned long blocked = cpu_rq(cpu)->cfs.utilization_blocked_avg;
 	unsigned long capacity_orig = capacity_orig_of(cpu);
 
-	if (usage >= capacity_orig)
+	sum = usage + blocked;
+
+	if (sum >= capacity_orig)
 		return capacity_orig;
 
-	return usage;
+	return sum;
 }
 
 /*
-- 
1.9.1

