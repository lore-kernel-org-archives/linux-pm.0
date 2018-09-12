From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v7 01/14] sched: Relocate arch_scale_cpu_capacity
Date: Wed, 12 Sep 2018 10:12:56 +0100
Message-ID: <20180912091309.7551-2-quentin.perret@arm.com>
References: <20180912091309.7551-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

By default, arch_scale_cpu_capacity() is only visible from within the
kernel/sched folder. Relocate it to include/linux/sched/topology.h to
make it visible to other clients needing to know about the capacity of
CPUs, such as the Energy Model framework.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/topology.h | 19 +++++++++++++++++++
 kernel/sched/sched.h           | 21 ---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 4fe2e49ab13b..1aaa14462207 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -202,6 +202,17 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
+		return sd->smt_gain / sd->span_weight;
+
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -217,6 +228,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #endif	/* !CONFIG_SMP */
 
 static inline int task_node(const struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 85b3a2bf6c2b..481e6759441b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1761,27 +1761,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#else
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#endif
-
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	__acquires(rq->lock);
 
-- 
2.18.0
