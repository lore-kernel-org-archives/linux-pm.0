From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Fri, 06 May 2016 14:58:43 +0200
Message-ID: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63255 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751997AbcEFMza (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 08:55:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization
update callbacks) overlooked the fact that update_load_avg(), where
CFS invokes cpufreq utilization update hooks, becomes an empty stub for
CONFIG_SMP unset.  In consequence, if CONFIG_SMP is not set, cpufreq
governors are never invoked from CFS and they do not have a chance to
evaluate CPU performace levels and update them often enough.  Needless
to say, things don't work as expected then.

Fix the problem by making the !CONFIG_SMP stub of update_load_avg()
invoke cpufreq update hooks too.

Fixes: 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization update callbacks)
Reported-by: Steve Muckle <steve.muckle@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This needs to go into v4.6.

---
 kernel/sched/fair.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -3030,7 +3030,14 @@ static int idle_balance(struct rq *this_
 
 #else /* CONFIG_SMP */
 
-static inline void update_load_avg(struct sched_entity *se, int update_tg) {}
+static inline void update_load_avg(struct sched_entity *se, int not_used)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct rq *rq = rq_of(cfs_rq);
+
+	cpufreq_trigger_update(rq_clock(rq));
+}
+
 static inline void
 enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void

