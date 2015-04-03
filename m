From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 10/21] clockevents: Provide explicit broadcast oneshot control functions
Date: Fri, 03 Apr 2015 02:05:15 +0200
Message-ID: <13000649.8qZuEDV0OA@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

clockevents_notify() is a leftover from the early design of the
clockevents facility. It's really not a notification mechanism, it's a
multiplex call. We are way better off to have explicit calls instead of this
monstrosity.

Split out the broadcast oneshot control into a separate function and
provide inline helpers. Switch clockevents_notify() over. This will go
away once all callers are converted.

This also gets rid of the nested locking of clockevents_lock and
broadcast_lock. The broadcast oneshot control functions do not require
clockevents_lock. Only the managing functions
(setup/shutdown/suspend/resume of the broadcast device require
clockevents_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/tick.h         |   19 +++++++++++++++++++
 kernel/time/clockevents.c    |    4 +++-
 kernel/time/tick-broadcast.c |   28 +++++++++++++++++-----------
 kernel/time/tick-internal.h  |    2 --
 4 files changed, 39 insertions(+), 14 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -48,12 +48,23 @@ enum tick_broadcast_mode {
 	TICK_BROADCAST_FORCE,
 };
 
+enum tick_broadcast_state {
+	TICK_BROADCAST_EXIT,
+	TICK_BROADCAST_ENTER,
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 extern void tick_broadcast_control(enum tick_broadcast_mode mode);
 #else
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
 
+#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
+extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
+#else
+static inline int tick_broadcast_oneshot_control(enum tick_broadcast_state state) { return 0; }
+#endif
+
 static inline void tick_broadcast_enable(void)
 {
 	tick_broadcast_control(TICK_BROADCAST_ON);
@@ -66,6 +77,14 @@ static inline void tick_broadcast_force(
 {
 	tick_broadcast_control(TICK_BROADCAST_FORCE);
 }
+static inline int tick_broadcast_enter(void)
+{
+	return tick_broadcast_oneshot_control(TICK_BROADCAST_ENTER);
+}
+static inline void tick_broadcast_exit(void)
+{
+	tick_broadcast_oneshot_control(TICK_BROADCAST_EXIT);
+}
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern int tick_nohz_tick_stopped(void);
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -656,8 +656,10 @@ int clockevents_notify(unsigned long rea
 
 	switch (reason) {
 	case CLOCK_EVT_NOTIFY_BROADCAST_ENTER:
+		tick_broadcast_enter();
+		break;
 	case CLOCK_EVT_NOTIFY_BROADCAST_EXIT:
-		ret = tick_broadcast_oneshot_control(reason);
+		tick_broadcast_exit();
 		break;
 
 	case CLOCK_EVT_NOTIFY_CPU_DYING:
Index: linux-pm/kernel/time/tick-broadcast.c
===================================================================
--- linux-pm.orig/kernel/time/tick-broadcast.c
+++ linux-pm/kernel/time/tick-broadcast.c
@@ -687,18 +687,23 @@ void hotplug_cpu__broadcast_tick_pull(in
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
-/*
- * Powerstate information: The system enters/leaves a state, where
- * affected devices might stop
+/**
+ * tick_broadcast_oneshot_control - Enter/exit broadcast oneshot mode
+ * @state:	The target state (enter/exit)
+ *
+ * The system enters/leaves a state, where affected devices might stop
  * Returns 0 on success, -EBUSY if the cpu is used to broadcast wakeups.
+ *
+ * Called with interrupts disabled, so clockevents_lock is not
+ * required here because the local clock event device cannot go away
+ * under us.
  */
-int tick_broadcast_oneshot_control(unsigned long reason)
+int tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
 	struct clock_event_device *bc, *dev;
 	struct tick_device *td;
-	unsigned long flags;
-	ktime_t now;
 	int cpu, ret = 0;
+	ktime_t now;
 
 	/*
 	 * Periodic mode does not care about the enter/exit of power
@@ -711,17 +716,17 @@ int tick_broadcast_oneshot_control(unsig
 	 * We are called with preemtion disabled from the depth of the
 	 * idle code, so we can't be moved away.
 	 */
-	cpu = smp_processor_id();
-	td = &per_cpu(tick_cpu_device, cpu);
+	td = this_cpu_ptr(&tick_cpu_device);
 	dev = td->evtdev;
 
 	if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
 		return 0;
 
+	raw_spin_lock(&tick_broadcast_lock);
 	bc = tick_broadcast_device.evtdev;
+	cpu = smp_processor_id();
 
-	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
-	if (reason == CLOCK_EVT_NOTIFY_BROADCAST_ENTER) {
+	if (state == TICK_BROADCAST_ENTER) {
 		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_oneshot_mask)) {
 			WARN_ON_ONCE(cpumask_test_cpu(cpu, tick_broadcast_pending_mask));
 			broadcast_shutdown_local(bc, dev);
@@ -813,9 +818,10 @@ int tick_broadcast_oneshot_control(unsig
 		}
 	}
 out:
-	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
+	raw_spin_unlock(&tick_broadcast_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 
 /*
  * Reset the one shot broadcast for a cpu
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -119,7 +119,6 @@ static inline int tick_check_oneshot_cha
 /* Functions related to oneshot broadcasting */
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
 extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
-extern int tick_broadcast_oneshot_control(unsigned long reason);
 extern void tick_broadcast_switch_to_oneshot(void);
 extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
 extern int tick_broadcast_oneshot_active(void);
@@ -128,7 +127,6 @@ bool tick_broadcast_oneshot_available(vo
 extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
 #else /* !(BROADCAST && ONESHOT): */
 static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
-static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
 static inline void tick_broadcast_switch_to_oneshot(void) { }
 static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }

