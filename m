From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH v7 1/2] cpufreq: schedutil: Make iowait boost more energy efficient
Date: Sun, 23 Jul 2017 08:54:25 -0700
Message-ID: <20170723155426.9170-1-joelaf@google.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35580 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755368AbdGWPye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jul 2017 11:54:34 -0400
Received: by mail-pg0-f48.google.com with SMTP id v190so47128782pgv.2
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2017 08:54:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Andres Oportus <andresoportus@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Currently the iowait_boost feature in schedutil makes the frequency go to max
on iowait wakeups.  This feature was added to handle a case that Peter
described where the throughput of operations involving continuous I/O requests
[1] is reduced due to running at a lower frequency, however the lower
throughput itself causes utilization to be low and hence causing frequency to
be low hence its "stuck".

Instead of going to max, its also possible to achieve the same effect by
ramping up to max if there are repeated in_iowait wakeups happening. This patch
is an attempt to do that. We start from a lower frequency (policy->min)
and double the boost for every consecutive iowait update until we reach the
maximum iowait boost frequency (iowait_boost_max).

I ran a synthetic test (continuous O_DIRECT writes in a loop) on an x86 machine
with intel_pstate in passive mode using schedutil. In this test the iowait_boost
value ramped from 800MHz to 4GHz in 60ms. The patch achieves the desired improved
throughput as the existing behavior.

[1] https://patchwork.kernel.org/patch/9735885/

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 622eed1b7658..570ab6e779e6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,6 +53,7 @@ struct sugov_cpu {
 	struct update_util_data update_util;
 	struct sugov_policy *sg_policy;
 
+	bool iowait_boost_pending;
 	unsigned long iowait_boost;
 	unsigned long iowait_boost_max;
 	u64 last_update;
@@ -172,30 +173,54 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 				   unsigned int flags)
 {
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		if (sg_cpu->iowait_boost_pending)
+			return;
+
+		sg_cpu->iowait_boost_pending = true;
+
+		if (sg_cpu->iowait_boost) {
+			sg_cpu->iowait_boost <<= 1;
+			if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
+				sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		} else {
+			sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
+		}
 	} else if (sg_cpu->iowait_boost) {
 		s64 delta_ns = time - sg_cpu->last_update;
 
 		/* Clear iowait_boost if the CPU apprears to have been idle. */
-		if (delta_ns > TICK_NSEC)
+		if (delta_ns > TICK_NSEC) {
 			sg_cpu->iowait_boost = 0;
+			sg_cpu->iowait_boost_pending = false;
+		}
 	}
 }
 
 static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 			       unsigned long *max)
 {
-	unsigned long boost_util = sg_cpu->iowait_boost;
-	unsigned long boost_max = sg_cpu->iowait_boost_max;
+	unsigned long boost_util, boost_max;
 
-	if (!boost_util)
+	if (!sg_cpu->iowait_boost)
 		return;
 
+	if (sg_cpu->iowait_boost_pending) {
+		sg_cpu->iowait_boost_pending = false;
+	} else {
+		sg_cpu->iowait_boost >>= 1;
+		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
+			sg_cpu->iowait_boost = 0;
+			return;
+		}
+	}
+
+	boost_util = sg_cpu->iowait_boost;
+	boost_max = sg_cpu->iowait_boost_max;
+
 	if (*util * boost_max < *max * boost_util) {
 		*util = boost_util;
 		*max = boost_max;
 	}
-	sg_cpu->iowait_boost >>= 1;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -267,6 +292,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		delta_ns = time - j_sg_cpu->last_update;
 		if (delta_ns > TICK_NSEC) {
 			j_sg_cpu->iowait_boost = 0;
+			j_sg_cpu->iowait_boost_pending = false;
 			continue;
 		}
 		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
-- 
2.14.0.rc0.284.gd933b75aa4-goog
