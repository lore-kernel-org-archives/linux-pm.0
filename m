From: dbasehore@chromium.org
Subject: [PATCH v2 2/5] clockevents: Add timed freeze
Date: Wed,  8 Jun 2016 17:43:34 -0700
Message-ID: <1465433017-13602-3-git-send-email-dbasehore@chromium.org>
References: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

Adds a new feature to clockevents to schedule wakeups on a CPU during
freeze. These won't fully wake up the system, but allow simple
platform callbacks that don't require device support to be run during
freeze with little power impact.

This implementation allows an idle driver to setup a timer event with
the clock event device when entering freeze by calling timed_freeze.
timed_freeze is a wrapper around entering freeze and setting up the
timer event so that clock event device state is not exposed to the
caller. This only allows one user of a timed freeze event, but that
will likely be the case for some time.

The reason this isn't implemented on top of the RTC is that wake irqs
unconditionally wake up the system by calling pm_system_wakeup. This
is done by both the SCI and RTC irqs on x86 when an RTC alarm fires.

An abstraction could be easily added on top of this if there is ever
more than one user for freeze events.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 include/linux/clockchips.h |  10 ++++
 include/linux/suspend.h    |  10 ++++
 kernel/time/clockevents.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 0d442e3..e1b66d4 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -66,12 +66,20 @@ enum clock_event_state {
  */
 # define CLOCK_EVT_FEAT_HRTIMER		0x000080
 
+/*
+ * Clockevent device may run during freeze
+ */
+# define CLOCK_EVT_FEAT_FREEZE		0x000100
+
 /**
  * struct clock_event_device - clock event device descriptor
  * @event_handler:	Assigned by the framework to be called by the low
  *			level handler of the event source
  * @set_next_event:	set next event function using a clocksource delta
  * @set_next_ktime:	set next event function using a direct ktime value
+ * @event_pending:	check if the programmed event is still pending. Used
+ *			for freeze events when timekeeping is suspended and
+ *			irqs are disabled.
  * @next_event:		local storage for the next event in oneshot mode
  * @max_delta_ns:	maximum delta value in ns
  * @min_delta_ns:	minimum delta value in ns
@@ -100,7 +108,9 @@ struct clock_event_device {
 	void			(*event_handler)(struct clock_event_device *);
 	int			(*set_next_event)(unsigned long evt, struct clock_event_device *);
 	int			(*set_next_ktime)(ktime_t expires, struct clock_event_device *);
+	bool			(*event_expired)(struct clock_event_device *);
 	ktime_t			next_event;
+	bool			freeze_event_programmed;
 	u64			max_delta_ns;
 	u64			min_delta_ns;
 	u32			mult;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7e..d8d4296 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -194,6 +194,11 @@ struct platform_freeze_ops {
 	void (*end)(void);
 };
 
+struct timed_freeze_ops {
+	int (*enter_freeze)(void *);
+	int (*callback)(void *);
+};
+
 #ifdef CONFIG_SUSPEND
 /**
  * suspend_set_ops - set platform dependent suspend operations
@@ -246,6 +251,9 @@ static inline bool idle_should_freeze(void)
 	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
 }
 
+extern int timed_freeze(struct timed_freeze_ops *ops, void *data,
+			ktime_t delta);
+
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
 extern void freeze_wake(void);
 
@@ -280,6 +288,8 @@ static inline bool pm_resume_via_firmware(void) { return false; }
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 static inline bool idle_should_freeze(void) { return false; }
+static inline int timed_freeze(struct timed_freeze_ops *ops, void *data,
+			       ktime_t delta) { return -ENOSYS; }
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
 static inline void freeze_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index a9b76a4..e7ca673 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/device.h>
+#include <linux/suspend.h>
 
 #include "tick-internal.h"
 
@@ -341,6 +342,122 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 	return (rc && force) ? clockevents_program_min_delta(dev) : rc;
 }
 
+static int clockevents_program_freeze_event(struct clock_event_device *dev,
+					    ktime_t delta)
+{
+	int64_t delta_ns = ktime_to_ns(delta);
+	unsigned long long clc;
+	int ret;
+
+	if (delta_ns > (int64_t) dev->max_delta_ns) {
+		printk_deferred(KERN_WARNING
+				"Freeze event time longer than max delta\n");
+		delta_ns = (int64_t) dev->max_delta_ns;
+	}
+
+	clockevents_tick_resume(dev);
+	clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
+	delta_ns = max_t(int64_t, delta_ns, dev->min_delta_ns);
+	clc = ((unsigned long long) delta_ns * dev->mult) >> dev->shift;
+	ret = dev->set_next_event((unsigned long) clc, dev);
+	if (ret < 0) {
+		printk_deferred(KERN_WARNING
+				"Failed to program freeze event\n");
+		clockevents_shutdown(dev);
+	} else {
+		dev->freeze_event_programmed = true;
+	}
+
+	return ret;
+}
+
+static bool clockevents_freeze_event_expired(struct clock_event_device *dev)
+{
+	if (dev->freeze_event_programmed)
+		return dev->event_expired(dev);
+
+	return false;
+}
+
+static void clockevents_cleanup_freeze_event(struct clock_event_device *dev)
+{
+	if (!(dev->features & CLOCK_EVT_FEAT_FREEZE))
+		return;
+
+	clockevents_shutdown(dev);
+	dev->freeze_event_programmed = false;
+}
+
+/**
+ * timed_freeze - Enter freeze on a CPU for a timed duration
+ * @ops:	Pointers for enter freeze and callback functions.
+ * @data:	Pointer to pass arguments to the function pointers.
+ * @delta:	Time to freeze for. If this amount of time passes in freeze, the
+ *		callback in ops will be called.
+ *
+ * Returns the value from ops->enter_freeze or ops->callback on success, -EERROR
+ * otherwise. If an error is encountered while setting up the clock event,
+ * freeze with still be entered, but it will not be timed nor will the callback
+ * function be run.
+ */
+int timed_freeze(struct timed_freeze_ops *ops, void *data, ktime_t delta)
+{
+	int cpu = smp_processor_id();
+	struct tick_device *td = tick_get_device(cpu);
+	struct clock_event_device *dev;
+	int ret;
+
+	if (!ops || !ops->enter_freeze) {
+		printk_deferred(KERN_ERR
+				"[%s] called with invalid ops\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!td || !td->evtdev ||
+	    !(td->evtdev->features & CLOCK_EVT_FEAT_FREEZE)) {
+		printk_deferred(KERN_WARNING
+				"[%s] called with invalid clock event device\n",
+				__func__);
+		ret = -ENOSYS;
+		goto freeze_no_check;
+	}
+
+	dev = td->evtdev;
+	if (!clockevent_state_shutdown(dev)) {
+		printk_deferred(KERN_WARNING
+				"[%s] called while clock event device in use\n",
+				__func__);
+		ret = -EBUSY;
+		goto freeze_no_check;
+	}
+
+	ret = clockevents_program_freeze_event(dev, delta);
+	if (ret < 0)
+		goto freeze_no_check;
+
+	ret = ops->enter_freeze(data);
+	if (ret < 0)
+		goto out;
+
+	if (ops->callback && clockevents_freeze_event_expired(dev))
+		ret = ops->callback(data);
+
+out:
+	clockevents_cleanup_freeze_event(dev);
+	return ret;
+
+freeze_no_check:
+	/*
+	 * If an error happens before enter_freeze, enter freeze normally and
+	 * return an error. The called can't tell if freeze should be entered on
+	 * an error (since errors can happen after returning from freeze), so
+	 * just handle it here.
+	 */
+	ops->enter_freeze(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(timed_freeze);
+
 /*
  * Called after a notify add to make devices available which were
  * released from the notifier call.
-- 
2.8.0.rc3.226.g39d4020
