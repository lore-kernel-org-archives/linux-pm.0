From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 03/09] tick: Simplify tick-internal.h
Date: Wed, 25 Mar 2015 13:06:47 +0100
Message-ID: <16068264.vcNp79HLaT@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

tick-internal.h is pretty confusing as a lot of the stub inlines are
there several times.

Distangle the maze and make clear functional sections.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-internal.h |  145 ++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 96 deletions(-)

Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -27,13 +27,18 @@ extern bool tick_check_replacement(struc
 				   struct clock_event_device *newdev);
 extern void tick_install_replacement(struct clock_event_device *dev);
 
-extern void clockevents_shutdown(struct clock_event_device *dev);
+/* Check, if the device is functional or a dummy for broadcast */
+static inline int tick_device_is_functional(struct clock_event_device *dev)
+{
+	return !(dev->features & CLOCK_EVT_FEAT_DUMMY);
+}
 
+extern void clockevents_shutdown(struct clock_event_device *dev);
+extern int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
 extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
+#endif /* GENERIC_CLOCKEVENTS */
 
-/*
- * NO_HZ / high resolution timer shared code
- */
+/* Oneshot related functions */
 #ifdef CONFIG_TICK_ONESHOT
 extern void tick_setup_oneshot(struct clock_event_device *newdev,
 			       void (*handler)(struct clock_event_device *),
@@ -42,69 +47,19 @@ extern int tick_program_event(ktime_t ex
 extern void tick_oneshot_notify(void);
 extern int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *));
 extern void tick_resume_oneshot(void);
-# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
-extern int tick_broadcast_oneshot_control(unsigned long reason);
-extern void tick_broadcast_switch_to_oneshot(void);
-extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
-extern int tick_resume_broadcast_oneshot(struct clock_event_device *bc);
-extern int tick_broadcast_oneshot_active(void);
-extern void tick_check_oneshot_broadcast_this_cpu(void);
-bool tick_broadcast_oneshot_available(void);
-# else /* BROADCAST */
-static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
-{
-	BUG();
-}
-static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
-static inline void tick_broadcast_switch_to_oneshot(void) { }
-static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
-static inline int tick_broadcast_oneshot_active(void) { return 0; }
-static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
-static inline bool tick_broadcast_oneshot_available(void) { return true; }
-# endif /* !BROADCAST */
-
+static inline bool tick_oneshot_possible(void) { return true; }
 #else /* !ONESHOT */
 static inline
 void tick_setup_oneshot(struct clock_event_device *newdev,
 			void (*handler)(struct clock_event_device *),
-			ktime_t nextevt)
-{
-	BUG();
-}
-static inline void tick_resume_oneshot(void)
-{
-	BUG();
-}
-static inline int tick_program_event(ktime_t expires, int force)
-{
-	return 0;
-}
+			ktime_t nextevt) { BUG(); }
+static inline void tick_resume_oneshot(void) { BUG(); }
+static inline int tick_program_event(ktime_t expires, int force) { return 0; }
 static inline void tick_oneshot_notify(void) { }
-static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
-{
-	BUG();
-}
-static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
-static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
-static inline int tick_resume_broadcast_oneshot(struct clock_event_device *bc)
-{
-	return 0;
-}
-static inline int tick_broadcast_oneshot_active(void) { return 0; }
-static inline bool tick_broadcast_oneshot_available(void) { return false; }
+static inline bool tick_oneshot_possible(void) { return false; }
 #endif /* !TICK_ONESHOT */
 
-/* NO_HZ_FULL internal */
-#ifdef CONFIG_NO_HZ_FULL
-extern void tick_nohz_init(void);
-# else
-static inline void tick_nohz_init(void) { }
-#endif
-
-/*
- * Broadcasting support
- */
+/* Broadcasting support */
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
@@ -114,53 +69,51 @@ extern void tick_shutdown_broadcast(unsi
 extern void tick_suspend_broadcast(void);
 extern int tick_resume_broadcast(void);
 extern void tick_broadcast_init(void);
-extern void
-tick_set_periodic_handler(struct clock_event_device *dev, int broadcast);
-int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
-
+extern void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast);
+extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 #else /* !BROADCAST */
-
-static inline void tick_install_broadcast_device(struct clock_event_device *dev)
-{
-}
-
-static inline int tick_is_broadcast_device(struct clock_event_device *dev)
-{
-	return 0;
-}
-static inline int tick_device_uses_broadcast(struct clock_event_device *dev,
-					     int cpu)
-{
-	return 0;
-}
+static inline void tick_install_broadcast_device(struct clock_event_device *dev) { }
+static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
+static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
 static inline void tick_broadcast_on_off(unsigned long reason, int *oncpu) { }
 static inline void tick_shutdown_broadcast(unsigned int *cpup) { }
 static inline void tick_suspend_broadcast(void) { }
 static inline int tick_resume_broadcast(void) { return 0; }
 static inline void tick_broadcast_init(void) { }
-static inline int tick_broadcast_update_freq(struct clock_event_device *dev,
-					     u32 freq) { return -ENODEV; }
+static inline int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq) { return -ENODEV; }
 
-/*
- * Set the periodic handler in non broadcast mode
- */
-static inline void tick_set_periodic_handler(struct clock_event_device *dev,
-					     int broadcast)
+/* Set the periodic handler in non broadcast mode */
+static inline void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
 {
 	dev->event_handler = tick_handle_periodic;
 }
 #endif /* !BROADCAST */
 
-/*
- * Check, if the device is functional or a dummy for broadcast
- */
-static inline int tick_device_is_functional(struct clock_event_device *dev)
-{
-	return !(dev->features & CLOCK_EVT_FEAT_DUMMY);
-}
-
-int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
-
-#endif /* GENERIC_CLOCKEVENTS */
+/* Functions related to oneshot broadcasting */
+#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
+extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
+extern int tick_broadcast_oneshot_control(unsigned long reason);
+extern void tick_broadcast_switch_to_oneshot(void);
+extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
+extern int tick_resume_broadcast_oneshot(struct clock_event_device *bc);
+extern int tick_broadcast_oneshot_active(void);
+extern void tick_check_oneshot_broadcast_this_cpu(void);
+bool tick_broadcast_oneshot_available(void);
+#else /* BROADCAST && ONESHOT */
+static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
+static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
+static inline void tick_broadcast_switch_to_oneshot(void) { }
+static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
+static inline int tick_resume_broadcast_oneshot(struct clock_event_device *bc) { return 0; }
+static inline int tick_broadcast_oneshot_active(void) { return 0; }
+static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
+static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
+#endif /* !BROADCAST && ONESHOT */
 
+/* NO_HZ_FULL internal */
+#ifdef CONFIG_NO_HZ_FULL
+extern void tick_nohz_init(void);
+# else
+static inline void tick_nohz_init(void) { }
+#endif
