From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / sleep: Make suspend-to-idle-specific code depend on CONFIG_SUSPEND
Date: Sat, 16 May 2015 01:38:15 +0200
Message-ID: <2270439.0UMhzsTGM1@vostro.rjw.lan>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7138791.PFSSF2gqXk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since idle_should_freeze() is defined to always return 'false'
for CONFIG_SUSPEND unset, all of the code depending on it in
cpuidle_idle_call() is not necessary in that case.

Make that code depend on CONFIG_SUSPEND too to avoid building it
when it is not going to be used.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 ++
 include/linux/cpuidle.h   |   16 ++++++++++------
 include/linux/tick.h      |   12 ++++++++----
 kernel/time/tick-common.c |    2 ++
 4 files changed, 22 insertions(+), 10 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -13,8 +13,6 @@
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
-extern void tick_freeze(void);
-extern void tick_unfreeze(void);
 /* Should be core only, but ARM BL switcher requires it */
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
@@ -23,14 +21,20 @@ extern void tick_handover_do_timer(void)
 extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
-static inline void tick_freeze(void) { }
-static inline void tick_unfreeze(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
 static inline void tick_handover_do_timer(void) { }
 static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
+extern void tick_freeze(void);
+extern void tick_unfreeze(void);
+#else
+static inline void tick_freeze(void) { }
+static inline void tick_unfreeze(void) { }
+#endif
+
 #ifdef CONFIG_TICK_ONESHOT
 extern void tick_irq_enter(void);
 #  ifndef arch_needs_cpu
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -151,10 +151,6 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
-extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev);
-extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 #else
@@ -190,14 +186,22 @@ static inline int cpuidle_enable_device(
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
+static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
+	struct cpuidle_device *dev) {return NULL; }
+#endif
+
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
+extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
+				      struct cpuidle_device *dev);
+extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
+				struct cpuidle_device *dev);
+#else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline int cpuidle_enter_freeze(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
-	struct cpuidle_device *dev) {return NULL; }
 #endif
 
 /* kernel/sched/idle.c */
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -441,6 +441,7 @@ void tick_resume(void)
 	tick_resume_local();
 }
 
+#ifdef CONFIG_SUSPEND
 static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
 static unsigned int tick_freeze_depth;
 
@@ -494,6 +495,7 @@ void tick_unfreeze(void)
 
 	raw_spin_unlock(&tick_freeze_lock);
 }
+#endif /* CONFIG_SUSPEND */
 
 /**
  * tick_init - initialize the tick control
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -97,6 +97,7 @@ static int find_deepest_state(struct cpu
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
 /**
  * cpuidle_find_deepest_state - Find the deepest available idle state.
  * @drv: cpuidle driver for the given CPU.
@@ -150,6 +151,7 @@ int cpuidle_enter_freeze(struct cpuidle_
 
 	return index;
 }
+#endif /* CONFIG_SUSPEND */
 
 /**
  * cpuidle_enter_state - enter the state and update stats
