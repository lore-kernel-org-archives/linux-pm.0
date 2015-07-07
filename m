From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 04/46] sched: Convert arch_scale_cpu_capacity() from weak function to #define
Date: Tue,  7 Jul 2015 19:23:47 +0100
Message-ID: <1436293469-25707-5-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37343 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932680AbbGGSWK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:22:10 -0400
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Bring arch_scale_cpu_capacity() in line with the recent change of its
arch_scale_freq_capacity() sibling in commit dfbca41f3479 ("sched:
Optimize freq invariant accounting") from weak function to #define to
allow inlining of the function.

While at it, remove the ARCH_CAPACITY sched_feature as well. With the
change to #define there isn't a straightforward way to allow runtime
switch between an arch implementation and the default implementation of
arch_scale_cpu_capacity() using sched_feature. The default was to use
the arch-specific implementation, but only the arm architecture provided
one.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     | 22 +---------------------
 kernel/sched/features.h |  5 -----
 kernel/sched/sched.h    | 11 +++++++++++
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 376ec75..5b4e8c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6238,19 +6238,6 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 	return load_idx;
 }
 
-static unsigned long default_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	if ((sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
-	return SCHED_CAPACITY_SCALE;
-}
-
-unsigned long __weak arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return default_scale_cpu_capacity(sd, cpu);
-}
-
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -6280,16 +6267,9 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = SCHED_CAPACITY_SCALE;
+	unsigned long capacity = arch_scale_cpu_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
-	if (sched_feat(ARCH_CAPACITY))
-		capacity *= arch_scale_cpu_capacity(sd, cpu);
-	else
-		capacity *= default_scale_cpu_capacity(sd, cpu);
-
-	capacity >>= SCHED_CAPACITY_SHIFT;
-
 	cpu_rq(cpu)->cpu_capacity_orig = capacity;
 
 	capacity *= scale_rt_capacity(cpu);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 91e33cd..03d8072 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -36,11 +36,6 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
-/*
- * Use arch dependent cpu capacity functions
- */
-SCHED_FEAT(ARCH_CAPACITY, true)
-
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(DOUBLE_TICK, false)
 SCHED_FEAT(LB_BIAS, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d62b288..af08a82 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1399,6 +1399,17 @@ unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
 }
 #endif
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	if ((sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
+		return sd->smt_gain / sd->span_weight;
+
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
-- 
1.9.1

