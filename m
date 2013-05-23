From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/2] sched: Use do_div() for 64 bit division at power
 utilization calculation (putil)
Date: Thu, 23 May 2013 10:34:23 +0200
Message-ID: <1369298064-14998-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19363 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3EWIfl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2013 04:35:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Now explicit casting is done when power usage variable (putil) is calculated

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This patch was developed on top of the following Alex's repository:
https://github.com/alexshi/power-scheduling/commits/power-scheduling
---
 kernel/sched/fair.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f0ead38..14d29b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3471,8 +3471,10 @@ find_leader_cpu(struct sched_group *group, struct task_struct *p, int this_cpu,
 	int leader_cpu = -1;
 	int i;
 	/* percentage of the task's util */
-	unsigned putil = (u64)(p->se.avg.runnable_avg_sum << SCHED_POWER_SHIFT)
-				/ (p->se.avg.runnable_avg_period + 1);
+	unsigned putil;
+	u64 tmp = (u64) p->se.avg.runnable_avg_sum << SCHED_POWER_SHIFT;
+	do_div(tmp, (p->se.avg.runnable_avg_period + 1));
+	putil = (unsigned) tmp;
 
 	/* bias toward local cpu */
 	if (cpumask_test_cpu(this_cpu, tsk_cpus_allowed(p)) &&
-- 
1.7.10.4

