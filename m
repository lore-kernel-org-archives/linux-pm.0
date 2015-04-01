From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 01/20] clockevents: Provide explicit broadcast control functions
Date: Thu, 02 Apr 2015 00:03:46 +0200
Message-ID: <4838454.bJXBY0oCE7@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

clockevents_notify() is a leftover from the early design of the
clockevents facility. It's really not a notification mechanism, it's a
multiplex call. We are way better off to have explicit calls instead of this
monstrosity.

Split out the broadcast control into a separate function and provide
inline helpers. Switch clockevents_notify() over. This will go away
once all callers are converted.

This also gets rid of the nested locking of clockevents_lock and
broadcast_lock. The broadcast control functions do not require
clockevents_lock. Only the managing functions
(setup/shutdown/suspend/resume of the broadcast device require 
clockevents_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/tick.h         |   25 +++++++++++++++++
 kernel/time/clockevents.c    |    6 +++-
 kernel/time/tick-broadcast.c |   62 ++++++++++++++++++-------------------------
 kernel/time/tick-internal.h  |    2 -
 4 files changed, 57 insertions(+), 38 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -36,6 +36,31 @@ extern void tick_irq_enter(void);
 static inline void tick_irq_enter(void) { }
 #endif
 
+enum tick_broadcast_mode {
+	TICK_BROADCAST_OFF,
+	TICK_BROADCAST_ON,
+	TICK_BROADCAST_FORCE,
+};
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+extern void tick_broadcast_control(enum tick_broadcast_mode mode);
+#else
+static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
+#endif /* BROADCAST */
+
+static inline void tick_broadcast_enable(void)
+{
+	tick_broadcast_control(TICK_BROADCAST_ON);
+}
+static inline void tick_broadcast_disable(void)
+{
+	tick_broadcast_control(TICK_BROADCAST_OFF);
+}
+static inline void tick_broadcast_force(void)
+{
+	tick_broadcast_control(TICK_BROADCAST_FORCE);
+}
+
 #ifdef CONFIG_NO_HZ_COMMON
 extern int tick_nohz_tick_stopped(void);
 extern void tick_nohz_idle_enter(void);
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -656,9 +656,13 @@ int clockevents_notify(unsigned long rea
 
 	switch (reason) {
 	case CLOCK_EVT_NOTIFY_BROADCAST_ON:
+		tick_broadcast_enable();
+		break;
 	case CLOCK_EVT_NOTIFY_BROADCAST_OFF:
+		tick_broadcast_disable();
+		break;
 	case CLOCK_EVT_NOTIFY_BROADCAST_FORCE:
-		tick_broadcast_on_off(reason, arg);
+		tick_broadcast_force();
 		break;
 
 	case CLOCK_EVT_NOTIFY_BROADCAST_ENTER:
Index: linux-pm/kernel/time/tick-broadcast.c
===================================================================
--- linux-pm.orig/kernel/time/tick-broadcast.c
+++ linux-pm/kernel/time/tick-broadcast.c
@@ -33,7 +33,7 @@ static cpumask_var_t tick_broadcast_mask
 static cpumask_var_t tick_broadcast_on;
 static cpumask_var_t tmpmask;
 static DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
-static int tick_broadcast_force;
+static int tick_broadcast_forced;
 
 #ifdef CONFIG_TICK_ONESHOT
 static void tick_broadcast_clear_oneshot(int cpu);
@@ -326,49 +326,54 @@ unlock:
 	raw_spin_unlock(&tick_broadcast_lock);
 }
 
-/*
- * Powerstate information: The system enters/leaves a state, where
- * affected devices might stop
+/**
+ * tick_broadcast_control - Enable/disable or force broadcast mode
+ * @mode:	The selected broadcast mode
+ *
+ * Called when the system enters a state where affected tick devices
+ * might stop. Note: TICK_BROADCAST_FORCE cannot be undone.
+ *
+ * Called with interrupts disabled, so clockevents_lock is not
+ * required here because the local clock event device cannot go away
+ * under us.
  */
-static void tick_do_broadcast_on_off(unsigned long *reason)
+void tick_broadcast_control(enum tick_broadcast_mode mode)
 {
 	struct clock_event_device *bc, *dev;
 	struct tick_device *td;
-	unsigned long flags;
 	int cpu, bc_stopped;
 
-	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
-
-	cpu = smp_processor_id();
-	td = &per_cpu(tick_cpu_device, cpu);
+	td = this_cpu_ptr(&tick_cpu_device);
 	dev = td->evtdev;
-	bc = tick_broadcast_device.evtdev;
 
 	/*
 	 * Is the device not affected by the powerstate ?
 	 */
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_C3STOP))
-		goto out;
+		return;
 
 	if (!tick_device_is_functional(dev))
-		goto out;
+		return;
 
+	raw_spin_lock(&tick_broadcast_lock);
+	cpu = smp_processor_id();
+	bc = tick_broadcast_device.evtdev;
 	bc_stopped = cpumask_empty(tick_broadcast_mask);
 
-	switch (*reason) {
-	case CLOCK_EVT_NOTIFY_BROADCAST_ON:
-	case CLOCK_EVT_NOTIFY_BROADCAST_FORCE:
+	switch (mode) {
+	case TICK_BROADCAST_FORCE:
+		tick_broadcast_forced = 1;
+	case TICK_BROADCAST_ON:
 		cpumask_set_cpu(cpu, tick_broadcast_on);
 		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_mask)) {
 			if (tick_broadcast_device.mode ==
 			    TICKDEV_MODE_PERIODIC)
 				clockevents_shutdown(dev);
 		}
-		if (*reason == CLOCK_EVT_NOTIFY_BROADCAST_FORCE)
-			tick_broadcast_force = 1;
 		break;
-	case CLOCK_EVT_NOTIFY_BROADCAST_OFF:
-		if (tick_broadcast_force)
+
+	case TICK_BROADCAST_OFF:
+		if (tick_broadcast_forced)
 			break;
 		cpumask_clear_cpu(cpu, tick_broadcast_on);
 		if (!tick_device_is_functional(dev))
@@ -390,22 +395,9 @@ static void tick_do_broadcast_on_off(uns
 		else
 			tick_broadcast_setup_oneshot(bc);
 	}
-out:
-	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
-}
-
-/*
- * Powerstate information: The system enters/leaves a state, where
- * affected devices might stop.
- */
-void tick_broadcast_on_off(unsigned long reason, int *oncpu)
-{
-	if (!cpumask_test_cpu(*oncpu, cpu_online_mask))
-		printk(KERN_ERR "tick-broadcast: ignoring broadcast for "
-		       "offline CPU #%d\n", *oncpu);
-	else
-		tick_do_broadcast_on_off(&reason);
+	raw_spin_unlock(&tick_broadcast_lock);
 }
+EXPORT_SYMBOL_GPL(tick_broadcast_control);
 
 /*
  * Set the periodic handler depending on broadcast on/off
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -85,7 +85,6 @@ static inline int tick_check_oneshot_cha
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
-extern void tick_broadcast_on_off(unsigned long reason, int *oncpu);
 extern void tick_shutdown_broadcast(unsigned int *cpup);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
@@ -100,7 +99,6 @@ static inline void tick_install_broadcas
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
-static inline void tick_broadcast_on_off(unsigned long reason, int *oncpu) { }
 static inline void tick_shutdown_broadcast(unsigned int *cpup) { }
 static inline void tick_suspend_broadcast(void) { }
 static inline void tick_resume_broadcast(void) { }
