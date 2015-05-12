From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 14/34] sched: Make energy awareness a sched feature
Date: Tue, 12 May 2015 20:38:49 +0100
Message-ID: <1431459549-18343-15-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

This patch introduces the ENERGY_AWARE sched feature, which is
implemented using jump labels when SCHED_DEBUG is defined. It is
statically set false when SCHED_DEBUG is not defined. Hence this doesn't
allow energy awareness to be enabled without SCHED_DEBUG. This
sched_feature knob will be replaced later with a more appropriate
control knob when things have matured a bit.

ENERGY_AWARE is based on per-entity load-tracking hence FAIR_GROUP_SCHED
must be enable. This dependency isn't checked at compile time yet.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     | 6 ++++++
 kernel/sched/features.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f20fae9..5980bdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4766,6 +4766,7 @@ static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
 
 	return wl;
 }
+
 #else
 
 static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
@@ -4775,6 +4776,11 @@ static long effective_load(struct task_group *tg, int cpu, long wl, long wg)
 
 #endif
 
+static inline bool energy_aware(void)
+{
+	return sched_feat(ENERGY_AWARE);
+}
+
 static int wake_wide(struct task_struct *p)
 {
 	int factor = this_cpu_read(sd_llc_size);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 03d8072..92bc36e 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -91,3 +91,9 @@ SCHED_FEAT(NUMA_FAVOUR_HIGHER, true)
  */
 SCHED_FEAT(NUMA_RESIST_LOWER, false)
 #endif
+
+/*
+ * Energy aware scheduling. Use platform energy model to guide scheduling
+ * decisions optimizing for energy efficiency.
+ */
+SCHED_FEAT(ENERGY_AWARE, false)
-- 
1.9.1
