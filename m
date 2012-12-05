From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 08/10] yield_to(),
 cpu-hotplug: Prevent offlining of other CPUs properly
Date: Thu, 06 Dec 2012 00:14:28 +0530
Message-ID: <20121205184426.3750.33584.stgit@srivatsabhat.in.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:49634 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab2LESp7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Dec 2012 13:45:59 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 6 Dec 2012 04:44:48 +1000
In-Reply-To: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com
Cc: sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on local_irq_save() to prevent CPUs from going offline from under us.

Use the get/put_online_cpus_atomic_light() APIs to prevent changes to the
cpu_online_mask, while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84a8579..1ef595a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4312,6 +4312,7 @@ bool __sched yield_to(struct task_struct *p, bool preempt)
 	unsigned long flags;
 	bool yielded = 0;
 
+	get_online_cpus_atomic_light();
 	local_irq_save(flags);
 	rq = this_rq();
 
@@ -4339,13 +4340,14 @@ again:
 		 * Make p's CPU reschedule; pick_next_entity takes care of
 		 * fairness.
 		 */
-		if (preempt && rq != p_rq)
+		if (preempt && rq != p_rq && cpu_online(task_cpu(p)))
 			resched_task(p_rq->curr);
 	}
 
 out:
 	double_rq_unlock(rq, p_rq);
 	local_irq_restore(flags);
+	put_online_cpus_atomic_light();
 
 	if (yielded)
 		schedule();

