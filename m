From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 04/34] sched: Convert arch_scale_cpu_capacity() from weak function to #define
Date: Tue, 12 May 2015 20:38:39 +0100
Message-ID: <1431459549-18343-5-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

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
index 5eccd63..d71d0ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6214,19 +6214,6 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
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
@@ -6256,16 +6243,9 @@ static unsigned long scale_rt_capacity(int cpu)
 
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
index d854555..b422e08 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1400,6 +1400,17 @@ unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
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
