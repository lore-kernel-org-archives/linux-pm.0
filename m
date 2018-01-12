From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 3/8] cpu_pm: Add SYSTEM_PM state
Date: Fri, 12 Jan 2018 13:24:17 -0800
Message-ID: <20180112212422.148625-4-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds a new CPU PM state that is only called on system suspend.
Saving the GIC state needs to happen after the CPU_PM and
CPU_CLUSTER_PM transitions on suspend. The corresponding restore needs
to happen before these same transitions on resume. The CPU_CLUSTER_PM
transition is not valid since that can be called with normal idle
operations when powering down the GIC is not desired. Another set of
syscore ops would have to rely on the correct ordering of syscore ops,
so avoid that by adding a new CPU_PM state.

Change-Id: I484bafbad8e810540d54b7c73ef03e4adf7b7c9a
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/linux/cpu_pm.h | 14 ++++++++++
 kernel/cpu_pm.c        | 74 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/include/linux/cpu_pm.h b/include/linux/cpu_pm.h
index 455b233dd3b1..28a462120cc5 100644
--- a/include/linux/cpu_pm.h
+++ b/include/linux/cpu_pm.h
@@ -41,6 +41,11 @@
  * are used to save any global context for affected blocks, and must be called
  * after all the CPUs in the power domain have been notified of the low power
  * state.
+ *
+ * CPU system notifications apply to all CPUs within the system. They are used
+ * for operations that must only happen on suspend and have an ordering
+ * requirement with the other CPU PM notifications. Must be called after all
+ * CPUs and clusters in the system have been notified of the low power state.
  */
 
 /*
@@ -64,6 +69,15 @@ enum cpu_pm_event {
 
 	/* A cpu power domain is exiting a low power state */
 	CPU_CLUSTER_PM_EXIT,
+
+	/* A cpu power domain is entering a system low power state (suspend) */
+	CPU_SYSTEM_PM_ENTER,
+
+	/* A cpu power domain failed to enter a system low power state */
+	CPU_SYSTEM_PM_ENTER_FAILED,
+
+	/* A cpu power domain is exiting a system low power state */
+	CPU_SYSTEM_PM_EXIT,
 };
 
 #ifdef CONFIG_CPU_PM
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 03bcc0751a51..833357959bc5 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -72,6 +72,22 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
+static int cpu_pm_notify_enter(enum cpu_pm_event enter, enum cpu_pm_event fail)
+{
+	int nr_calls;
+	int ret = 0;
+
+	ret = cpu_pm_notify(enter, -1, &nr_calls);
+	if (ret)
+		/*
+		 * Inform listeners (nr_calls - 1) about failure to enter CPU PM
+		 * state <enter> who were notified earlier to prepare for it.
+		 */
+		cpu_pm_notify(fail, nr_calls - 1, NULL);
+
+	return ret;
+}
+
 /**
  * cpu_pm_enter - CPU low power entry notifier
  *
@@ -89,18 +105,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU PM
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_enter(CPU_PM_ENTER, CPU_PM_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
 
@@ -140,18 +145,8 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU cluster
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_enter(CPU_CLUSTER_PM_ENTER,
+		CPU_CLUSTER_PM_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
 
@@ -176,6 +171,27 @@ int cpu_cluster_pm_exit(void)
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
+/*
+ * Notifies listeners that the system is entering suspend. Called after
+ * cpu_cluster_pm_enter() and only within the syscore suspend callback,
+ * cpu_pm_suspend.
+ */
+static int cpu_system_pm_enter(void)
+{
+	return cpu_pm_notify_enter(CPU_SYSTEM_PM_ENTER,
+		CPU_SYSTEM_PM_ENTER_FAILED);
+}
+
+/*
+ * Notifies listeners that the system is leaving suspend. Called before
+ * cpu_cluster_pm_exit() and only within the syscore resume callback,
+ * cpu_pm_resume.
+ */
+static int cpu_system_pm_exit(void)
+{
+	return cpu_pm_notify(CPU_SYSTEM_PM_EXIT, -1, NULL);
+}
+
 #ifdef CONFIG_PM
 static int cpu_pm_suspend(void)
 {
@@ -186,14 +202,22 @@ static int cpu_pm_suspend(void)
 		return ret;
 
 	ret = cpu_cluster_pm_enter();
-	if (ret)
+	if (ret) {
 		cpu_pm_exit();
+		return ret;
+	}
 
+	ret = cpu_system_pm_enter();
+	if (ret) {
+		cpu_cluster_pm_exit();
+		cpu_pm_exit();
+	}
 	return ret;
 }
 
 static void cpu_pm_resume(void)
 {
+	cpu_system_pm_exit();
 	cpu_cluster_pm_exit();
 	cpu_pm_exit();
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
