From: Parth Shah <parth@linux.ibm.com>
Subject: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
Date: Wed, 15 May 2019 19:23:18 +0530
Message-ID: <20190515135322.19393-3-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

This patch creates a static key which allows to enable or disable
TurboSched feature at runtime.

This key is added in order to enable the TurboSched feature. The static key
helps in optimizing the scheduler fast-path when the TurboSched feature is
disabled.

The patch also provides get/put methods to keep track of the cgroups using
the TurboSched feature. This allows to enable the feature on adding first
cgroup classified as jitter, similarly disable the feature on removal of
such last cgroup.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77aa4aee4478..facbedd2554e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -60,6 +60,26 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+DEFINE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+static DEFINE_SPINLOCK(turbo_sched_lock);
+static int turbo_sched_count;
+
+void turbo_sched_get(void)
+{
+	spin_lock(&turbo_sched_lock);
+	if (!turbo_sched_count++)
+		static_branch_enable(&__turbo_sched_enabled);
+	spin_unlock(&turbo_sched_lock);
+}
+
+void turbo_sched_put(void)
+{
+	spin_lock(&turbo_sched_lock);
+	if (!--turbo_sched_count)
+		static_branch_disable(&__turbo_sched_enabled);
+	spin_unlock(&turbo_sched_lock);
+}
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e75ffaf3ff34..0339964cdf43 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2437,3 +2437,10 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+DECLARE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+
+static inline bool is_turbosched_enabled(void)
+{
+	return static_branch_unlikely(&__turbo_sched_enabled);
+}
-- 
2.17.1
