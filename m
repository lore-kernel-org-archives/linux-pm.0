From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 2/3] cpuidle: allow setting deepest idle
Date: Wed, 23 Nov 2016 12:13:09 -0800
Message-ID: <1479931990-11732-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

When idle injection is used to cap power, we need to override
governor's choice of idle states. This patch allows caller to select
the deepest idle state on a CPU therefore achieve the maximum
potential power saving.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/cpuidle/cpuidle.c | 11 +++++++++++
 include/linux/cpuidle.h   |  4 +++-
 kernel/sched/idle.c       | 13 ++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c73207a..887a52a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -97,6 +97,17 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 	return ret;
 }
 
+/* Set the current cpu to use the deepest idle state, override governors */
+void cpuidle_use_deepest_state(bool enable)
+{
+	struct cpuidle_device *dev;
+
+	preempt_disable();
+	dev = cpuidle_get_device();
+	dev->use_deepest_state = enable;
+	preempt_enable();
+}
+
 #ifdef CONFIG_SUSPEND
 /**
  * cpuidle_find_deepest_state - Find the deepest available idle state.
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..97c169b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -74,6 +74,7 @@ struct cpuidle_state {
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
+	unsigned int		use_deepest_state:1;
 	unsigned int		cpu;
 
 	int			last_residency;
@@ -192,11 +193,12 @@ static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
-#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
+#ifdef CONFIG_CPU_IDLE
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
 extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
+extern void cpuidle_use_deepest_state(bool enable);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index cb6442f..2729da5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -164,11 +164,14 @@ static void cpuidle_idle_call(void)
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
 	 * until a proper wakeup interrupt happens.
 	 */
-	if (idle_should_freeze()) {
-		entered_state = cpuidle_enter_freeze(drv, dev);
-		if (entered_state > 0) {
-			local_irq_enable();
-			goto exit_idle;
+
+	if (idle_should_freeze() || dev->use_deepest_state) {
+		if (idle_should_freeze()) {
+			entered_state = cpuidle_enter_freeze(drv, dev);
+			if (entered_state > 0) {
+				local_irq_enable();
+				goto exit_idle;
+			}
 		}
 
 		next_state = cpuidle_find_deepest_state(drv, dev);
-- 
1.9.1
