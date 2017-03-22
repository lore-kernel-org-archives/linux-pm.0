From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: schedutil: Trace frequency only if it has changed
Date: Wed, 22 Mar 2017 18:32:47 +0100
Message-ID: <2563394.lUgF3b60iC@aspire.rjw.lan>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48609 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759029AbdCVRi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 13:38:29 -0400
In-Reply-To: <10655562.4O9KtquB0A@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

sugov_update_commit() calls trace_cpu_frequency() to record the
current CPU frequency if it has not changed in the fast switch case
to prevent utilities from getting confused (they may report that the
CPU is idle if the frequency has not been recorded for too long, for
example).

However, that may cause the tracepoint to be triggered quite often
for no real reason (if the frequency doesn't change, we will not
modify the last update time stamp and governor computations may
run again shortly when that happens), so don't do that (arguably, it
is done to work around a utilities bug anyway).

That allows code duplication in sugov_update_commit() to be reduced
somewhat too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
Drop the trace_cpu_frequency() call in the sg_policy->next_freq == next_freq case.

---
 kernel/sched/cpufreq_schedutil.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -98,22 +98,20 @@ static void sugov_update_commit(struct s
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
+	if (sg_policy->next_freq == next_freq)
+		return;
+
+	sg_policy->next_freq = next_freq;
+	sg_policy->last_freq_update_time = time;
+
 	if (policy->fast_switch_enabled) {
-		if (sg_policy->next_freq == next_freq) {
-			trace_cpu_frequency(policy->cur, smp_processor_id());
-			return;
-		}
-		sg_policy->next_freq = next_freq;
-		sg_policy->last_freq_update_time = time;
 		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
 		if (next_freq == CPUFREQ_ENTRY_INVALID)
 			return;
 
 		policy->cur = next_freq;
 		trace_cpu_frequency(next_freq, smp_processor_id());
-	} else if (sg_policy->next_freq != next_freq) {
-		sg_policy->next_freq = next_freq;
-		sg_policy->last_freq_update_time = time;
+	} else {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
