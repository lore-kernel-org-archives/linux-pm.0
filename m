From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH 1/3] sched: Add new API wake_up_if_idle() to wake up the idle cpu
Date: Fri, 15 Aug 2014 15:01:23 +0800
Message-ID: <1408086085-16691-1-git-send-email-chuansheng.liu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36831 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbaHOHTL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Aug 2014 03:19:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, luto@amacapital.net, daniel.lezcano@linaro.org, rjw@rjwysocki.net, mingo@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com, Chuansheng Liu <chuansheng.liu@intel.com>

Implementing one new API wake_up_if_idle(), which is used to
wake up the idle CPU.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 include/linux/sched.h |    1 +
 kernel/sched/core.c   |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 857ba40..3f89ac1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1024,6 +1024,7 @@ struct sched_domain_topology_level {
 extern struct sched_domain_topology_level *sched_domain_topology;
 
 extern void set_sched_topology(struct sched_domain_topology_level *tl);
+extern void wake_up_if_idle(int cpu);
 
 #ifdef CONFIG_SCHED_DEBUG
 # define SD_INIT_NAME(type)		.name = #type
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1211575..adf104f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1620,6 +1620,22 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu)
 	}
 }
 
+void wake_up_if_idle(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+
+	if (set_nr_if_polling(rq->idle)) {
+		trace_sched_wake_idle_without_ipi(cpu);
+	} else {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		if (rq->curr == rq->idle)
+			smp_send_reschedule(cpu);
+		/* Else cpu is not in idle, do nothing here */
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
-- 
1.7.9.5

