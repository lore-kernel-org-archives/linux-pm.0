From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpuidle / sleep: Use broadcast timer for states that stop local timer
Date: Mon, 02 Mar 2015 15:53:28 +0100
Message-ID: <89103967.z1sWWFaE6y@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <1809382.kscziWfTPN@vostro.rjw.lan> <1882932.aLeaejbmMz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63684 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754639AbbCBOaD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 09:30:03 -0500
In-Reply-To: <1882932.aLeaejbmMz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
overlooked the fact that entering some sufficiently deep idle states
by CPUs may cause their local timers to stop and in those cases it
is necessary to switch over to a broadcase timer prior to entering
the idle state.  If the cpuidle driver in use does not provide
the new ->enter_freeze callback for any of the idle states, that
problem affects suspend-to-idle too, but it is not taken into account
after the changes made by commit 381063133246.

Fix that by changing the definition of cpuidle_enter_freeze() and
re-arranging of the code in cpuidle_idle_call(), so the former does
not call cpuidle_enter() any more and the fallback case is handled
by cpuidle_idle_call() directly.

Fixes: 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |   59 ++++++++++++++++------------------------------
 include/linux/cpuidle.h   |   17 +++++++++++--
 kernel/sched/idle.c       |   30 ++++++++++++++++-------
 3 files changed, 57 insertions(+), 49 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -44,8 +44,8 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
-static bool cpuidle_not_available(struct cpuidle_driver *drv,
-				  struct cpuidle_device *dev)
+bool cpuidle_not_available(struct cpuidle_driver *drv,
+			   struct cpuidle_device *dev)
 {
 	return off || !initialized || !drv || !dev || !dev->enabled;
 }
@@ -72,14 +72,8 @@ int cpuidle_play_dead(void)
 	return -ENODEV;
 }
 
-/**
- * cpuidle_find_deepest_state - Find deepest state meeting specific conditions.
- * @drv: cpuidle driver for the given CPU.
- * @dev: cpuidle device for the given CPU.
- * @freeze: Whether or not the state should be suitable for suspend-to-idle.
- */
-static int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev, bool freeze)
+static int find_deepest_state(struct cpuidle_driver *drv,
+			      struct cpuidle_device *dev, bool freeze)
 {
 	unsigned int latency_req = 0;
 	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
@@ -98,6 +92,17 @@ static int cpuidle_find_deepest_state(st
 	return ret;
 }
 
+/**
+ * cpuidle_find_deepest_state - Find the deepest available idle state.
+ * @drv: cpuidle driver for the given CPU.
+ * @dev: cpuidle device for the given CPU.
+ */
+int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
+			       struct cpuidle_device *dev)
+{
+	return find_deepest_state(drv, dev, false);
+}
+
 static void enter_freeze_proper(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
 {
@@ -119,46 +124,27 @@ static void enter_freeze_proper(struct c
 
 /**
  * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
+ * @drv: cpuidle driver for the given CPU.
+ * @dev: cpuidle device for the given CPU.
  *
  * If there are states with the ->enter_freeze callback, find the deepest of
  * them and enter it with frozen tick.  Otherwise, find the deepest state
  * available and enter it normally.
- *
- * Returns with enabled interrupts.
  */
-void cpuidle_enter_freeze(void)
+int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
-	if (cpuidle_not_available(drv, dev))
-		goto fallback;
-
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
-	index = cpuidle_find_deepest_state(drv, dev, true);
-	if (index >= 0) {
+	index = find_deepest_state(drv, dev, true);
+	if (index >= 0)
 		enter_freeze_proper(drv, dev, index);
-		local_irq_enable();
-		return;
-	}
 
-	/*
-	 * It is not safe to freeze the tick, find the deepest state available
-	 * at all and try to enter it normally.
-	 */
-	index = cpuidle_find_deepest_state(drv, dev, false);
-	if (index >= 0) {
-		cpuidle_enter(drv, dev, index);
-		return;
-	}
-
- fallback:
-	arch_cpu_idle();
+	return index;
 }
 
 /**
@@ -217,9 +203,6 @@ int cpuidle_enter_state(struct cpuidle_d
  */
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	if (cpuidle_not_available(drv, dev))
-		return -ENODEV;
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -126,6 +126,8 @@ struct cpuidle_driver {
 
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
+extern bool cpuidle_not_available(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev);
@@ -150,11 +152,17 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
-extern void cpuidle_enter_freeze(void);
+extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
+				      struct cpuidle_device *dev);
+extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
+				struct cpuidle_device *dev);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 #else
 static inline void disable_cpuidle(void) { }
+static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
+					 struct cpuidle_device *dev)
+{return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
 				 struct cpuidle_device *dev)
 {return -ENODEV; }
@@ -183,7 +191,12 @@ static inline int cpuidle_enable_device(
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-static inline void cpuidle_enter_freeze(void) { }
+static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
+					     struct cpuidle_device *dev)
+{return -ENODEV; }
+static inline int cpuidle_enter_freeze(struct cpuidle_driver *drv,
+				       struct cpuidle_device *dev)
+{return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
 #endif
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -82,6 +82,7 @@ static void cpuidle_idle_call(void)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
 	unsigned int broadcast;
+	bool reflect;
 
 	/*
 	 * Check if the idle task must be rescheduled. If it is the
@@ -105,6 +106,9 @@ static void cpuidle_idle_call(void)
 	 */
 	rcu_idle_enter();
 
+	if (cpuidle_not_available(drv, dev))
+		goto use_default;
+
 	/*
 	 * Suspend-to-idle ("freeze") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
@@ -115,15 +119,22 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 	if (idle_should_freeze()) {
-		cpuidle_enter_freeze();
-		goto exit_idle;
+		entered_state = cpuidle_enter_freeze(drv, dev);
+		if (entered_state >= 0) {
+			local_irq_enable();
+			goto exit_idle;
+		}
+
+		reflect = false;
+		next_state = cpuidle_find_deepest_state(drv, dev);
+	} else {
+		reflect = true;
+		/*
+		 * Ask the cpuidle framework to choose a convenient idle state.
+		 */
+		next_state = cpuidle_select(drv, dev);
 	}
-
-	/*
-	 * Ask the cpuidle framework to choose a convenient idle state.
-	 * Fall back to the default arch idle method on errors.
-	 */
-	next_state = cpuidle_select(drv, dev);
+	/* Fall back to the default arch idle method on errors. */
 	if (next_state < 0)
 		goto use_default;
 
@@ -170,7 +181,8 @@ static void cpuidle_idle_call(void)
 	/*
 	 * Give the governor an opportunity to reflect on the outcome
 	 */
-	cpuidle_reflect(dev, entered_state);
+	if (reflect)
+		cpuidle_reflect(dev, entered_state);
 
 exit_idle:
 	__current_set_polling();

