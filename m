From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: [RFC] sched/core: Fix up load metric exposed to cpuidle
Date: Fri, 23 Sep 2016 14:49:47 -0700
Message-ID: <57E5A37B.8010802@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11927 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934834AbcIWVyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 17:54:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Cc: Peter Boonstoppel <pboonstoppel@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Colin Cross <ccross@android.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org

When triaging a performance degradation of ~5% on some use cases between
our k3.18 and k4.4 trees, we found that the menu cpuidle governor on k4.4
was way more aggressive when requesting for deeper idle states. It would
often get it wrong though resulting in perf loss.

The menu governor tries to bias picking shallower idle states based on the
historical load on the CPU. The busier the CPU, the shallower the idle
state.

However, after commit "3289bdb sched: Move the loadavg code to a more
obvious location", the load metric it looks at is rq->load.weight which is
the instantaneous se->load.weight sum for top level entities on the rq
which on idle entry is always 0 (for the common case at least) because
there is nothing on the cfs rq.

The previous metric the menu governor used was rq->cpu_load[0] which is a
snap shot of the weighted_cpuload at the previous load update point so it
isn't always 0 on idle entry.

Unfortunately, it isn't straightforward to switch the metric being used to
rq->cfs.load_avg or rq->cfs.util_avg because they overestimate the load a
lot more than rq->cpu_load[0] (include blocked task contrib.). That would
potentially require redoing the magic constants in the menu governor's
performance_multiplier...so for now, use rq->cpu_load[0] instead to
preserve old behaviour.

Reported-by: Juha Lainema <jlainema@nvidia.com>
Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
---

* I realize this might not be the best thing to do hence the RFC tag.
Thoughts?

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44817c6..d1aea12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2955,7 +2955,7 @@ void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
 {
 	struct rq *rq = this_rq();
 	*nr_waiters = atomic_read(&rq->nr_iowait);
-	*load = rq->load.weight;
+	*load = rq->cpu_load[0];
 }
 
 #ifdef CONFIG_SMP
-- 
2.1.4
