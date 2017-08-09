From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Return 0 from ->fast_switch() on errors
Date: Wed,  9 Aug 2017 10:21:46 +0530
Message-ID: <a219f5b42d06a78bd254ca1b23047d45702f12d2.1502254023.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sudeep.holla@arm.com, Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CPUFREQ_ENTRY_INVALID is a special symbol which is used to specify that
an entry in the cpufreq table is invalid. But using it outside of the
scope of the cpufreq table looks a bit incorrect.

We can represent an invalid frequency by writing it as 0 instead if we
need. Note that it is already done that way for the return value of the
->get() callback.

Lets do the same for ->fast_switch() and not use CPUFREQ_ENTRY_INVALID
outside of the scope of cpufreq table.

Also update the comment over cpufreq_driver_fast_switch() to clearly
mention what this returns.

None of the drivers return CPUFREQ_ENTRY_INVALID as of now from
->fast_switch() callback and so we don't need to update any of those.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c        | 7 ++++---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b2cc98551fc3..9588e15da26b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1832,9 +1832,10 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
  * twice in parallel for the same policy and that it will never be called in
  * parallel with either ->target() or ->target_index() for the same policy.
  *
- * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
- * callback to indicate an error condition, the hardware configuration must be
- * preserved.
+ * Returns the actual frequency set for the CPU.
+ *
+ * If 0 is returned by the driver's ->fast_switch() callback to indicate an
+ * error condition, the hardware configuration must be preserved.
  */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5465bf221e8f..2e74c49776be 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -123,7 +123,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 
 	if (policy->fast_switch_enabled) {
 		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
-		if (next_freq == CPUFREQ_ENTRY_INVALID)
+		if (!next_freq)
 			return;
 
 		policy->cur = next_freq;
-- 
2.13.0.71.gd7076ec9c9cb
