From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 7/8] sched/sched.h: move arch_scale_{freq,cpu}_capacity outside CONFIG_SMP
Date: Tue, 23 May 2017 09:53:50 +0100
Message-ID: <20170523085351.18586-8-juri.lelli@arm.com>
References: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523085351.18586-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Currently, frequency and cpu capacity scaling is only performed on
CONFIG_SMP system (as CFS PELT signals are only present for such systems
as well). However, other scheduling class want to do freq/cpu scaling as
well, and for !CONFIG_SMP configurations too.

arch_scale_freq_capacity is useful to implement frequency scaling even
on !CONFIG_SMP platforms, so we simply move it outside CONFIG_SMP
ifdeffery.

Even if arch_scale_cpu_capacity is not useful on !CONFIG_SMP platforms,
we make a default implementation available for such configurations anyway
to simplify scheduler code doing CPU scale invariance.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/topology.h | 12 ++++++------
 kernel/sched/sched.h           | 13 ++++++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7d065abc7a47..953cf4f889ec 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -6,6 +6,12 @@
 #include <linux/sched/idle.h>
 
 /*
+ * Increase resolution of cpu_capacity calculations
+ */
+#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
+#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
+
+/*
  * sched-domains (multiprocessor balancing) declarations:
  */
 #ifdef CONFIG_SMP
@@ -26,12 +32,6 @@
 #define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
 #define SD_NUMA			0x4000	/* cross-node balancing */
 
-/*
- * Increase resolution of cpu_capacity calculations
- */
-#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
-#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
-
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 063fd8c47e75..cc474c62cd18 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1636,9 +1636,6 @@ static inline int hrtick_enabled(struct rq *rq)
 
 #endif /* CONFIG_SCHED_HRTICK */
 
-#ifdef CONFIG_SMP
-extern void sched_avg_update(struct rq *rq);
-
 #ifndef arch_scale_freq_capacity
 static __always_inline
 unsigned long arch_scale_freq_capacity(int cpu)
@@ -1647,6 +1644,9 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SMP
+extern void sched_avg_update(struct rq *rq);
+
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
@@ -1664,6 +1664,13 @@ static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 	sched_avg_update(rq);
 }
 #else
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
 static inline void sched_avg_update(struct rq *rq) { }
 #endif
-- 
2.11.0
