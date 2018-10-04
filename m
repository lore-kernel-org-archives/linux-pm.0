From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date: Thu,  4 Oct 2018 14:04:02 +0200
Message-ID: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The function nr_iowait_cpu() can be used directly by nr_iowait() instead
of duplicating code.

Call nr_iowait_cpu() from nr_iowait()

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/core.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..43efb74 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2875,6 +2875,25 @@ unsigned long long nr_context_switches(void)
 }
 
 /*
+ * Consumers of these two interfaces, like for example the cpufreq menu
+ * governor are using nonsensical data. Boosting frequency for a CPU that has
+ * IO-wait which might not even end up running the task when it does become
+ * runnable.
+ */
+
+unsigned long nr_iowait_cpu(int cpu)
+{
+	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+}
+
+void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
+{
+	struct rq *rq = this_rq();
+	*nr_waiters = atomic_read(&rq->nr_iowait);
+	*load = rq->load.weight;
+}
+
+/*
  * IO-wait accounting, and how its mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
@@ -2909,31 +2928,11 @@ unsigned long nr_iowait(void)
 	unsigned long i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += atomic_read(&cpu_rq(i)->nr_iowait);
+		sum += nr_iowait_cpu(i);
 
 	return sum;
 }
 
-/*
- * Consumers of these two interfaces, like for example the cpufreq menu
- * governor are using nonsensical data. Boosting frequency for a CPU that has
- * IO-wait which might not even end up running the task when it does become
- * runnable.
- */
-
-unsigned long nr_iowait_cpu(int cpu)
-{
-	struct rq *this = cpu_rq(cpu);
-	return atomic_read(&this->nr_iowait);
-}
-
-void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
-{
-	struct rq *rq = this_rq();
-	*nr_waiters = atomic_read(&rq->nr_iowait);
-	*load = rq->load.weight;
-}
-
 #ifdef CONFIG_SMP
 
 /*
-- 
2.7.4
