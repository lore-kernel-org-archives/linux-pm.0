From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 2/2] sched:fix: Signed overflow prevention for vacancy
 calculation
Date: Thu, 23 May 2013 10:34:24 +0200
Message-ID: <1369298064-14998-2-git-send-email-l.majewski@samsung.com>
References: <1369298064-14998-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1369298064-14998-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Nasty bug with vacancy calculation has been fixed.
In the if statement the FULL_UTIL is a large constant, max_cfs_util()
returns unsigned and putil is also defined as unsigned. The outcome
is that this condition is always true.

As observed, this was the reason for frequent jumps of processes between
CPUs.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This patch was developed on top of the following Alex's repository:
https://github.com/alexshi/power-scheduling/commits/power-scheduling
---
 kernel/sched/fair.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 14d29b3..8b07f6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3476,9 +3476,10 @@ find_leader_cpu(struct sched_group *group, struct task_struct *p, int this_cpu,
 	do_div(tmp, (p->se.avg.runnable_avg_period + 1));
 	putil = (unsigned) tmp;
 
+	vacancy = (int) (FULL_UTIL - max_cfs_util(this_cpu, wakeup) -
+			 (putil << 2));
 	/* bias toward local cpu */
-	if (cpumask_test_cpu(this_cpu, tsk_cpus_allowed(p)) &&
-		FULL_UTIL - max_cfs_util(this_cpu, wakeup) - (putil << 2) > 0)
+	if (cpumask_test_cpu(this_cpu, tsk_cpus_allowed(p)) && vacancy > 0)
 		return this_cpu;
 
 	/* Traverse only the allowed CPUs */
-- 
1.7.10.4
