From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 2/5] tick: Add freeze timer events
Date: Fri,  7 Jul 2017 17:03:00 -0700
Message-ID: <20170708000303.21863-2-dbasehore@chromium.org>
References: <20170708000303.21863-1-dbasehore@chromium.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-1-dbasehore@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

Adds a new feature to tick to schedule wakeups on a CPU during freeze.
This won't fully wake up the system (devices are not resumed), but
allow simple platform functionality to be run during freeze with
little power impact.

This implementation allows an idle driver to setup a timer event with
the clock event device when entering freeze by calling
tick_set_freeze_event. Only one caller should exist for the function.

tick_freeze_event_expired is used to check if the timer went off when
the CPU wakes.

The event is cleared by tick_clear_freeze_event.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 include/linux/clockchips.h |  9 +++++
 include/linux/suspend.h    |  2 +
 kernel/time/tick-common.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index a116926598fd..6a3f30008020 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -66,12 +66,20 @@ enum clock_event_state {
  */
 # define CLOCK_EVT_FEAT_HRTIMER		0x000080
 
+/*
+ * Clockevent device may run during freeze
+ */
+# define CLOCK_EVT_FEAT_FREEZE_NONSTOP	0x000100
+
 /**
  * struct clock_event_device - clock event device descriptor
  * @event_handler:	Assigned by the framework to be called by the low
  *			level handler of the event source
  * @set_next_event:	set next event function using a clocksource delta
  * @set_next_ktime:	set next event function using a direct ktime value
+ * @event_expired:	check if the programmed event is expired. Used for
+ *			freeze events when timekeeping is suspended and
+ *			irqs are disabled.
  * @next_event:		local storage for the next event in oneshot mode
  * @max_delta_ns:	maximum delta value in ns
  * @min_delta_ns:	minimum delta value in ns
@@ -100,6 +108,7 @@ struct clock_event_device {
 	void			(*event_handler)(struct clock_event_device *);
 	int			(*set_next_event)(unsigned long evt, struct clock_event_device *);
 	int			(*set_next_ktime)(ktime_t expires, struct clock_event_device *);
+	int			(*event_expired)(struct clock_event_device *);
 	ktime_t			next_event;
 	u64			max_delta_ns;
 	u64			min_delta_ns;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 0b1cf32edfd7..1d56269a7b31 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -248,6 +248,8 @@ static inline bool idle_should_freeze(void)
 }
 
 extern void __init pm_states_init(void);
+int tick_set_freeze_event(int cpu, ktime_t expires);
+int tick_clear_freeze_event(int cpu);
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
 extern void freeze_wake(void);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..688d1c0cad10 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -498,6 +498,97 @@ void tick_freeze(void)
 	raw_spin_unlock(&tick_freeze_lock);
 }
 
+/**
+ * tick_set_freeze_event - Set timer to wake up the CPU from freeze.
+ *
+ * @cpu:	CPU to set the clock event for
+ * @delta:	time to wait before waking the CPU
+ *
+ * Returns 0 on success and -EERROR on failure.
+ */
+int tick_set_freeze_event(int cpu, ktime_t delta)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;
+	u64 delta_ns;
+	int ret;
+
+	if (!dev->set_next_event ||
+	    !(dev->features & CLOCK_EVT_FEAT_FREEZE_NONSTOP)) {
+		printk_deferred(KERN_WARNING
+				"[%s] unsupported by clock event device\n",
+				__func__);
+		return -EPERM;
+	}
+
+	if (!clockevent_state_shutdown(dev)) {
+		printk_deferred(KERN_WARNING
+				"[%s] clock event device in use\n",
+				__func__);
+		return -EBUSY;
+	}
+
+	delta_ns = ktime_to_ns(delta);
+	if (delta_ns > dev->max_delta_ns || delta_ns < dev->min_delta_ns) {
+		printk_deferred(KERN_WARNING
+				"[%s] %lluns outside range: [%lluns, %lluns]\n",
+				__func__, delta_ns, dev->min_delta_ns,
+				dev->max_delta_ns);
+		return -ERANGE;
+	}
+
+	clockevents_tick_resume(dev);
+	clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
+	ret = dev->set_next_event((delta_ns * dev->mult) >> dev->shift, dev);
+	if (ret < 0) {
+		printk_deferred(KERN_WARNING
+				"Failed to program freeze event\n");
+		clockevents_shutdown(dev);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tick_set_freeze_event);
+
+/**
+ * tick_freeze_event_expired - Check if the programmed freeze event expired
+ *
+ * @cpu:	CPU to check the clock event device for an expired event
+ *
+ * Returns 1 if the event expired and 0 otherwise.
+ */
+int tick_freeze_event_expired(int cpu)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;
+
+	if (!(dev && dev->event_expired))
+		return 0;
+
+	return dev->event_expired(dev);
+}
+
+/**
+ * tick_clear_freeze_event - Shuts down the clock device after programming a
+ * freeze event.
+ *
+ * @cpu:	CPU to shutdown the clock device for
+ *
+ * Returns 0 on success and -EERROR otherwise.
+ */
+int tick_clear_freeze_event(int cpu)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!clockevent_state_oneshot(dev))
+		return -EBUSY;
+
+	clockevents_shutdown(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tick_clear_freeze_event);
+
 /**
  * tick_unfreeze - Resume the local tick and (possibly) timekeeping.
  *
-- 
2.13.2.725.g09c95d1e9-goog
