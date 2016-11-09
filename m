From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/3] cpuidle: allow setting deepest idle
Date: Wed,  9 Nov 2016 11:05:11 -0800
Message-ID: <1478718312-12847-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59248 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbcKITHE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Nov 2016 14:07:04 -0500
In-Reply-To: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

When idle injection is used to cap power, we need to override
governor's choice of idle states. This patch allows caller to select
the deepest idle state on a CPU therefore achieve the maximum
potential power saving.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/cpuidle/cpuidle.c | 12 ++++++++++++
 include/linux/cpuidle.h   |  4 +++-
 kernel/sched/idle.c       |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c73207a..9ad45b3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -97,6 +97,18 @@ static int find_deepest_state(struct cpuidle_driver *drv,
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
+EXPORT_SYMBOL_GPL(cpuidle_use_deepest_state);
+
 #ifdef CONFIG_SUSPEND
 /**
  * cpuidle_find_deepest_state - Find the deepest available idle state.
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..7f93c63 100644
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
+#if defined(CONFIG_CPU_IDLE)
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
 extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
+extern void cpuidle_use_deepest_state(bool enable);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ffd9a83..fc65147 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -173,6 +173,9 @@ static void cpuidle_idle_call(void)
 
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
+	} else if (dev->use_deepest_state) {
+			next_state = cpuidle_find_deepest_state(drv, dev);
+			call_cpuidle(drv, dev, next_state);
 	} else {
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
-- 
1.9.1

