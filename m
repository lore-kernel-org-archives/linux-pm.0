From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 01/09] clockevents: Remove CONFIG_GENERIC_CLOCKEVENTS_BUILD
Date: Wed, 25 Mar 2015 13:05:19 +0100
Message-ID: <5021859.jl9OC1medj@vostro.rjw.lan>
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

This option was for simpler migration to the clock events code. Most
architectures have been converted and the option has been
disfunctional as a standalone option for quite some time. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/clockchips.h  |    9 +++------
 kernel/time/Kconfig         |    6 ------
 kernel/time/Makefile        |    6 ++----
 kernel/time/clockevents.c   |    3 ---
 kernel/time/tick-internal.h |    4 ++--
 5 files changed, 7 insertions(+), 21 deletions(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -22,7 +22,7 @@ enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_CPU_DEAD,
 };
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 #include <linux/clocksource.h>
 #include <linux/cpumask.h>
@@ -194,13 +194,9 @@ static inline int tick_check_broadcast_e
 static inline void tick_setup_hrtimer_broadcast(void) {};
 #endif
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern int clockevents_notify(unsigned long reason, void *arg);
-#else
-static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
-#endif
 
-#else /* CONFIG_GENERIC_CLOCKEVENTS_BUILD */
+#else /* CONFIG_GENERIC_CLOCKEVENTS */
 
 static inline void clockevents_suspend(void) {}
 static inline void clockevents_resume(void) {}
@@ -208,6 +204,7 @@ static inline void clockevents_resume(vo
 static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
 static inline int tick_check_broadcast_expired(void) { return 0; }
 static inline void tick_setup_hrtimer_broadcast(void) {};
+static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
 
 #endif
 
Index: linux-pm/kernel/time/Kconfig
===================================================================
--- linux-pm.orig/kernel/time/Kconfig
+++ linux-pm/kernel/time/Kconfig
@@ -33,12 +33,6 @@ config ARCH_USES_GETTIMEOFFSET
 config GENERIC_CLOCKEVENTS
 	bool
 
-# Migration helper. Builds, but does not invoke
-config GENERIC_CLOCKEVENTS_BUILD
-	bool
-	default y
-	depends on GENERIC_CLOCKEVENTS
-
 # Architecture can handle broadcast in a driver-agnostic way
 config ARCH_HAS_TICK_BROADCAST
 	bool
Index: linux-pm/kernel/time/Makefile
===================================================================
--- linux-pm.orig/kernel/time/Makefile
+++ linux-pm/kernel/time/Makefile
@@ -2,15 +2,13 @@ obj-y += time.o timer.o hrtimer.o itimer
 obj-y += timekeeping.o ntp.o clocksource.o jiffies.o timer_list.o
 obj-y += timeconv.o timecounter.o posix-clock.o alarmtimer.o
 
-obj-$(CONFIG_GENERIC_CLOCKEVENTS_BUILD)		+= clockevents.o
-obj-$(CONFIG_GENERIC_CLOCKEVENTS)		+= tick-common.o
+obj-$(CONFIG_GENERIC_CLOCKEVENTS)		+= clockevents.o tick-common.o
 ifeq ($(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST),y)
  obj-y						+= tick-broadcast.o
  obj-$(CONFIG_TICK_ONESHOT)			+= tick-broadcast-hrtimer.o
 endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
-obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o
-obj-$(CONFIG_TICK_ONESHOT)			+= tick-sched.o
+obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_TIMER_STATS)			+= timer_stats.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -541,7 +541,6 @@ void clockevents_resume(void)
 			dev->resume(dev);
 }
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
 /**
  * clockevents_notify - notification about relevant events
  * Returns 0 on success, any other value on error
@@ -727,5 +726,3 @@ static int __init clockevents_init_sysfs
 }
 device_initcall(clockevents_init_sysfs);
 #endif /* SYSFS */
-
-#endif /* GENERIC_CLOCK_EVENTS */
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -10,7 +10,7 @@ extern seqlock_t jiffies_lock;
 
 #define CS_NAME_LEN	32
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 #define TICK_DO_TIMER_NONE	-1
 #define TICK_DO_TIMER_BOOT	-2
@@ -166,7 +166,7 @@ static inline int tick_device_is_functio
 
 int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
 
-#endif
+#endif /* GENERIC_CLOCKEVENTS */
 
 extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
